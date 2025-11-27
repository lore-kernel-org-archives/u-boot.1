Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4783BCFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 17:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B20768437E;
	Thu, 27 Nov 2025 18:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="TYxS1aOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CC258437F; Thu, 27 Nov 2025 18:54:49 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7144583B2C
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 18:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from rpi5.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C4D5C42490; 
 Thu, 27 Nov 2025 17:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1764266086;
 bh=qFdPcW4WJQmdLypDhnMLoGM/guGRUiuNUCDOrY96o84=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=TYxS1aOvitRrNGd5SSGbSTW2ZFfl3ALcgh7/EcgsmLbPJTn3ZReO7ZQH/ELEYHjxt
 P9dnI+qjTE4canXN1K9dGQzqYfWBcx+gIdJgAt1vHDTtBBLuT2EJX3FSivq3D3Gavb
 JMU6usSUViUbvv89Ef/CK7eWhnaA5k319fF1y9kYuad4TPt35/5FgH5N3JeXt/yjHh
 lwv/nkV7Q3/V2xhY76lkszo63dnIDpe20CCFTDsc4ZjyZOghPWIv9pRqGCcPsc6Foa
 YroyVNNmRIguxMVSaqaZ/nQW3T4SES0EPHg9FElVUPCGyLVl7ygKgRvWL4APqmO4AL
 DUXSIpKDxs8JYWOZ6exBVPN3LUVYD2sLlKl0LrzJy17a7RCGXCync8NsyfyfCgDE63
 ESN/BdgH4HH0OYe7rxOg64Crwdul3CRMpB5eoN/yj7Ta9o4GDY/u1gCD1IfeHCWTKe
 1ZxebpGWiqVb8xctaKuq7IoTCbQIdeVYiwzgxubSVhy+igjDZu/aECHm7n63IV6eWW
 U9NmpCH3gjz4YIJdhzIoQoOh4nIWZGyzFRqXvsg8co7Q9c2RXRsjLjRrb+ulndv6e2
 BvPU6y85tyLXm9k9CAWW2OtjxcQJ0kqWOJLBzkevE50I8pcNwKUgAP37fdTa48uyyv
 730Jm0TmCKZegOPaIZtltPwA=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Bin Meng <bmeng.cn@gmail.com>,
	Marek Vasut <marex@denx.de>
Cc: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2] usb/xhci: avoid noisy 'Register NbrPorts' message
Date: Thu, 27 Nov 2025 18:54:25 +0100
Message-ID: <20251127175425.639086-1-heinrich.schuchardt@canonical.com>
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

We should avoid overwhelming users with non-essential messages.

'Register NbrPorts' is a debug message for EHCI. Do the same for XHCI.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	improve the commit title an message
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

