Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C95D111A8
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 16:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C746843EA;
	Thu, 27 Nov 2025 17:07:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="AxhFLFmW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48D828441B; Thu, 27 Nov 2025 17:07:22 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF585842A2
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 17:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from rpi5.fritz.box
 (dynamic-046-114-107-084.46.114.pool.telefonica.de [46.114.107.84])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 267BE40289; 
 Thu, 27 Nov 2025 16:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1764259639;
 bh=R9K1h3+kVe+5Q/Nho95SGcY/nb2mQgr4lmcYbDJJozA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=AxhFLFmWIE9Yo75/mO9I4z8/KwIh9ZhesSs9bf3kjSIKaOj10ftbby+VCzmbAYmgT
 C2oHF4pffg7HBjdaMZDxhSHudN7g5bIx3t5mQk2zkjz5QAbrYp/tZwCjkduwZBl0eK
 dDwZtVBIxWVaOdPg+VxIbTRg+K6usKjtSytTJUsJNoKFW9hteb7qJ3bWqQ3UMcj6dE
 XcuDCMvUtDK3Nk7PVQAci19+7cEnns5QYJ0/4uFahdmG9UsRnsS1hz8yDKP+5LlnDF
 ZchdXDrHV08XmoUGggWjMXiMLtEsVPdxWoxEIYY2Yb3+lxWwQCvYm0/4XEiFVAO3hg
 Hg4Dp99f09ECs6qs44nkIaoLHLDbbNVHp1YWsXvipXViEfXZrwndIbO3y2N4MAmmaZ
 vW9Bhm4JfBuOuS0NvUr2WtD9jFy76lOPKCezYa+h6X8Hgs4FzMwaVU0Lix8+OiaD5k
 gBhj9H89/blMlE3k34aA8CqXBuBHHK9dNe17KIBzFHoPDuZvmHx35wkjDuNnEtbKeC
 VfMnOrHpyjs93gC60hiWXTx0NnvrCN9JHrf80JzP9bEQuDAhuPeSpEI9fVzyikygKi
 Sk14v8SFaXgsRaQJroHkwhFslNEWSEzJCbQuqfYb/NQfVX+sslJGHYXvpavWQ7CDyo
 zydfRmg1Ftdu+cTAJBGAeLAo=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Bin Meng <bmeng.cn@gmail.com>,
	Marek Vasut <marex@denx.de>
Cc: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] usb/xhci: debug message Register NbrPorts
Date: Thu, 27 Nov 2025 17:06:43 +0100
Message-ID: <20251127160643.568577-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This is a debug message for EHCI. Do the same for XHCI.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/usb/host/xhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 3ee1f67190f..d59804580f1 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1249,7 +1249,7 @@ static int xhci_lowlevel_init(struct xhci_ctrl *ctrl)
 
 	reg = xhci_readl(&hccr->cr_hcsparams1);
 	ctrl->hub_desc.bNbrPorts = HCS_MAX_PORTS(reg);
-	printf("Register %x NbrPorts %d\n", reg, ctrl->hub_desc.bNbrPorts);
+	debug("Register %x NbrPorts %d\n", reg, ctrl->hub_desc.bNbrPorts);
 
 	/* Port Indicators */
 	reg = xhci_readl(&hccr->cr_hccparams);
-- 
2.43.0

