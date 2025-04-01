Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8C9C36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 14:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F11580FDA;
	Tue,  1 Apr 2025 16:40:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="MxOPwy4q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A482B81703; Tue,  1 Apr 2025 16:40:19 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E1BE801BE
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 16:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=ogXf3CgyQ4KmAlUE/dlo9F13hwUhLKLv+EYtv5yqk5w=; b=MxOPwy4qcnA6bsb/vb62zHfe6M
 GpWM78QKA3bWQtIXOaDVI1uWOFFUCECt7L6YTM4D0LcmTlKZiZx/e4c1ZI8+Eva2xl9OSHP1+2kQ4
 FTem1kUKbDoFY+A8VMLFVGO2xhoYTb/PKSgzhvJz+PMA1+P6tZUXfyKLDrxo/CTJG6NH6ocXgUVc4
 AeziWZBln02hxMt7v7fcLyf12jRCwFxrMafuV2DhNfhwv5cQMu3FlAN3wfcmunmc0SyG0wGIRSSXq
 0SalC430jJHMR7+wGL1EP9aCQG2/c+5IpC1+MB/v2WjldBKKACsKOduXyE3Mxun6ASDZTB9svLhj+
 1QRtfXXw==;
Received: from i53875bf8.versanet.de ([83.135.91.248]
 helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1tzcmk-0002U9-FT; Tue, 01 Apr 2025 16:40:14 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: quentin.schulz@cherry.de, u-boot@lists.denx.de, heiko@sntech.de,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH] configs: rockchip: sync ENV_MEM_LAYOUT_SETTINGS for px30 to
 rk3308/etc
Date: Tue,  1 Apr 2025 16:40:04 +0200
Message-ID: <20250401144004.2342300-1-heiko@sntech.de>
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

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Loading a FIT image for kernel, initrd and rootfs on px30 can result in an
memory overlap, resulting in the not 100% helpful message of
"This will not be a case any time" from lmb_fix_over_lap_regions().

Adding a bit of debug info to lmb_fix_over_lap_regions() brings:
lmb_fix_over_lap_regions: base1 0x280000-0x6005ac > base2 0x600000-0x6000d1

So this is because the FIT image gets loaded to the kernel_addr_r at
0x280000 while the pxe-file is already living at 0x600000, only 3.5MB
behind.

In commit 4acc8bb044a4 ("configs: rockchip: sync ENV_MEM_LAYOUT_SETTINGS
for rk3308, rk3328, and rk3399") FUKAUMI Naoki already brought the memory
layouts for the mentioned socs in sync.

Adjusting the env-layout on px30 to this scheme, magically solves the
overlap issue and also brings px30 more in line with the other mentioned
SoCs.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 include/configs/px30_common.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/configs/px30_common.h b/include/configs/px30_common.h
index 13ed9011764..2a3dc362f98 100644
--- a/include/configs/px30_common.h
+++ b/include/configs/px30_common.h
@@ -18,11 +18,14 @@
 
 #define ENV_MEM_LAYOUT_SETTINGS \
 	"scriptaddr=0x00500000\0" \
+	"script_offset_f=0xffe000\0" \
+	"script_size_f=0x2000\0" \
 	"pxefile_addr_r=0x00600000\0" \
-	"fdt_addr_r=0x08300000\0" \
-	"kernel_addr_r=0x00280000\0" \
-	"ramdisk_addr_r=0x0a200000\0" \
-	"kernel_comp_addr_r=0x03e80000\0" \
+	"fdt_addr_r=0x01e00000\0" \
+	"fdtoverlay_addr_r=0x01f00000\0" \
+	"kernel_addr_r=0x02080000\0" \
+	"ramdisk_addr_r=0x06000000\0" \
+	"kernel_comp_addr_r=0x08000000\0" \
 	"kernel_comp_size=0x2000000\0"
 
 #define CFG_EXTRA_ENV_SETTINGS \
-- 
2.47.2

