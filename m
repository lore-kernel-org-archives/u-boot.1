Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A5AC5478C
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 13:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4075C87E30;
	Sat,  2 Mar 2024 14:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="EjFwiNQF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 817A387E45; Sat,  2 Mar 2024 14:10:12 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 472DA87A23
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 14:10:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8beb=KJ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1709384997;
 bh=bBVe1sm8EQxRcK3TdwfWwElRF4i++SiK7sOgkhHi0xQ=;
 b=EjFwiNQFjtGuNul00FhrLdNlaptZUuDK1KmDOm28zgq0VBOY20019QlmpoT7pOfhTinYuD/bH
 TypN5MBEAEJgugw/sgMvBpoC+9w5fJdlqRDzJ6vEwXjaKbc5mOtH+SKFRGcgg1jiiLK+P33KBwM
 Qe39AEAoqtySjBAdKE1p1FDYOj15Rcbl8n6KANQdPmP/NLqF3aXKcGTWD32b34L+bxqd4iA/P4E
 hDAKrRS5BxcGJ+Cjb8sKjAA4qlhYEEdBFsa5XhcVvjuN2r3arroq8UCyN53ja6sKIlc5YnxkPMb
 2OAJbESG7NikuGw4/pduYtYD52PNczln7o1jm9fTAHWw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, Mark
 Kettenis <kettenis@openbsd.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: [PATCH] usb: xhci-dwc3: Fix support for dis_enblslpm_quirk
Date: Sat,  2 Mar 2024 13:09:49 +0000
Message-ID: <20240302130951.4123405-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65e3252552a4f89a74917dce
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

No device tree in U-Boot or linux use the wrong spelling used in code.

Use correct property name as defined in dwc3 bindings.

Fixes: 062790f46131 ("usb: xhci-dwc3: Add USB2 PHY configuration")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/usb/host/xhci-dwc3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
index 1dbd65dfaa34..6cebe1cc30cb 100644
--- a/drivers/usb/host/xhci-dwc3.c
+++ b/drivers/usb/host/xhci-dwc3.c
@@ -197,7 +197,7 @@ static int xhci_dwc3_probe(struct udevice *dev)
 		reg |= DWC3_GUSB2PHYCFG_USBTRDTIM_16BIT;
 	}
 
-	if (dev_read_bool(dev, "snps,dis_enblslpm-quirk"))
+	if (dev_read_bool(dev, "snps,dis_enblslpm_quirk"))
 		reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
 
 	if (dev_read_bool(dev, "snps,dis-u2-freeclk-exists-quirk"))
-- 
2.43.0

