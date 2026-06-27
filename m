Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC977C43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 13:46:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95CED8467F;
	Sat, 27 Jun 2026 15:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="FoI3bCpZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3EA1841F2; Sat, 27 Jun 2026 14:39:11 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 762FC805D7
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 14:39:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=13738176232@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id; bh=L8Wc5sSQVZ1Gm4C
 0ZKSG3PvJvQK7bqPg6rv7FKRJFpY=; b=FoI3bCpZxoFmGOA3SPKuqs3ppW1gaW+
 cQ+1ALO7maNl0z4g7gmGiXeYufnDSRrsdNCmm7bhWHRUzGx/UiJmh6MGUnxEZ+E5
 urd0G4WRXN034XGUJYdqlKB+BKI6DLIaiWanwkY8K4kOOrWBOX6Fc2sgFZtByaLM
 TQfgxK/u9z2Y=
Received: from 163.com (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PygvCgCnfhpUxD9qp0SeEQ--.57457S2;
 Sat, 27 Jun 2026 20:38:44 +0800 (CST)
From: Beibei Yang <13738176232@163.com>
To: u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com,
	marex@denx.de,
	13738176232@163.com
Subject: [PATCH] usb: xhci: Fix bNbrPorts overwritten by another controller
Date: Sat, 27 Jun 2026 05:37:19 -0700
Message-Id: <1782563839-11379-1-git-send-email-13738176232@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: PygvCgCnfhpUxD9qp0SeEQ--.57457S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtry5Cw1rAw48Zw15Xr1kXwb_yoWkXFXEkF
 sIkF1fC34kCrW2yws7KF48JrWa93Wqq3W8u3ZYqr93WF1v9a45ZanFkFWjkryY9rZ8Gr1D
 JrnaqrW7u348ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_5l13UUUUU==
X-Originating-IP: [117.147.115.1]
X-CM-SenderInfo: zprtljayrxljits6il2tof0z/xtbC7xSwHGo-xFR5qwAA3A
X-Mailman-Approved-At: Sat, 27 Jun 2026 15:46:26 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

In a system with multiple XHCI controllers, the global descriptor.hub
(bNbrPorts) can be overwritten by a later initialized controller,
causing the root hub of an earlier controller to report wrong port
numbers.

Fix this by dynamically setting bNbrPorts from the current controller's
hcsparams1 in the USB_DT_HUB request handler, instead of relying on
a stale global value.

Signed-off-by: Beibei Yang <13738176232@163.com>

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index dbeb88a..f7984de 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -942,6 +942,12 @@ static int xhci_submit_root(struct usb_device *udev, unsigned long pipe,
 		case USB_DT_HUB:
 		case USB_DT_SS_HUB:
 			debug("USB_DT_HUB config\n");
+			/* Dynamically set bNbrPorts from this controller's
+			* hcsparams1, because the global descriptor.hub
+			* may have been overwritten by another controller
+			* that initialized after this one. */
+			descriptor.hub.bNbrPorts =
+				HCS_MAX_PORTS(xhci_readl(&hccr->cr_hcsparams1));
 			srcptr = &descriptor.hub;
 			srclen = 0x8;
 			break;

