Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F89FC36018
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 08:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C928F81F7E;
	Tue,  1 Apr 2025 10:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="bDXj3ppy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F99681FAA; Tue,  1 Apr 2025 10:38:48 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E2E981F0D
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 10:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=XPNTwT6MbzSw13R7GV0g2F+3uR9kznuTXggt90I0VAQ=; b=bDXj3ppyCAjFnyyiN14EjS0wb9
 /UlQP2CGr09fIZdWmq1jxVe3zbF3ARX8zJfbGoS9GqdWaKNTnlPqlEYIsRojYnjYSUJwqsJksqH/j
 YKOTVXfWr4ik9SdEbuhYj27dtSUE84Zx81UuL8VOVRYn7uWgtj/rojF/Vw+0ZTlDgPujf6i2ZM+4O
 XEBHyDLxBDBkF79N9NkcNFEXPw0oOxhBRVlREby48tdqclyfsLJD9QhAwa0JYeFCIIUsIFDBVr0+e
 C2gvpxVvxDk3Z3iuyi+8gG3Qrl7LQzwPM5p/LKL/xoGK5JXmFzPkduEGUfek58zblCZwJrFCwEXAn
 ZXoBHY9w==;
Received: from i53875bf8.versanet.de ([83.135.91.248]
 helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1tzX8r-0008N8-M8; Tue, 01 Apr 2025 10:38:41 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: trini@konsulko.com
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, xypron.glpk@gmx.de,
 sjg@chromium.org, u-boot@lists.denx.de, quentin.schulz@cherry.de,
 Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] Revert "net: eth_bootdev_hunt() should not run DHCP"
Date: Tue,  1 Apr 2025 10:38:30 +0200
Message-ID: <20250401083830.2320479-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
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

This reverts commit 1f68057e03206e6597ca8b2be8bb1c49d4bd47d0.

Commit 1f68057e0320 ("net: eth_bootdev_hunt() should not run DHCP")
aims to reduce EFI boot times by disabling the dhcp_run when
checking ethernet bootdevices, by preventing it from running double,
with the reasoning

    We need to call eth_bootdev_hunt() when setting up the EFI sub-system to
    supply the simple network protocol. We don't need an IP address set up.

That might by true for EFI, but not for everything else, because when
running distro-boot and for example the PXE method in it, nothing will
set up an IP address now.

So for example in my setup of Rockchip boards, no dhcp runs and pxe then
fails with messages like:

  Retrieving file: pxelinux.cfg/01-....
  Speed: 100, full duplex
  *** ERROR: `serverip' not set
  Retrieving file: pxelinux.cfg/00000000
  Speed: 100, full duplex
  *** ERROR: `serverip' not set

As the original commit message talks about speed efficiencies for the EFI
side mostly, reverting this should just restore previous functionality
(and in fact does so on my Rockchip boards).

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 net/eth_bootdev.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/net/eth_bootdev.c b/net/eth_bootdev.c
index b0fca6e8313..6ee54e3c790 100644
--- a/net/eth_bootdev.c
+++ b/net/eth_bootdev.c
@@ -64,23 +64,9 @@ static int eth_bootdev_bind(struct udevice *dev)
 	return 0;
 }
 
-/**
- * eth_bootdev_hunt() - probe all network devices
- *
- * Network devices can also come from USB, but that is a higher
- * priority (BOOTDEVP_5_SCAN_SLOW) than network, so it should have been
- * enumerated already. If something like 'bootflow scan dhcp' is used,
- * then the user will need to run 'usb start' first.
- *
- * @info:	info structure describing this hunter
- * @show:	true to show information from the hunter
- *
- * Return:	0 if device found, -EINVAL otherwise
- */
 static int eth_bootdev_hunt(struct bootdev_hunter *info, bool show)
 {
 	int ret;
-	struct udevice *dev = NULL;
 
 	if (!test_eth_enabled())
 		return 0;
@@ -92,11 +78,19 @@ static int eth_bootdev_hunt(struct bootdev_hunter *info, bool show)
 			log_warning("Failed to init PCI (%dE)\n", ret);
 	}
 
-	ret = -EINVAL;
-	uclass_foreach_dev_probe(UCLASS_ETH, dev)
-		ret = 0;
+	/*
+	 * Ethernet devices can also come from USB, but that is a higher
+	 * priority (BOOTDEVP_5_SCAN_SLOW) than ethernet, so it should have been
+	 * enumerated already. If something like 'bootflow scan dhcp' is used
+	 * then the user will need to run 'usb start' first.
+	 */
+	if (IS_ENABLED(CONFIG_CMD_DHCP)) {
+		ret = dhcp_run(0, NULL, false);
+		if (ret)
+			return -EINVAL;
+	}
 
-	return ret;
+	return 0;
 }
 
 struct bootdev_ops eth_bootdev_ops = {
-- 
2.47.2

