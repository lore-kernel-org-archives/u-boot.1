Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1501D637AB
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 19:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36F2588DC8;
	Wed, 13 Nov 2024 20:24:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="R4Ty6Ckl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76C7388DD0; Wed, 13 Nov 2024 20:24:04 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 728FE88D5A
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 20:24:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7D1D53FDE7; 
 Wed, 13 Nov 2024 19:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1731525840;
 bh=VQFzw7L3Ik/9XfCzbqfnD3t3kWHzuRP4dXSRp3mvZRg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=R4Ty6CklfnejiMBjZrhytdMs1RLOLNFLXlcAtYkrqghZihLnBnSht5T2jwFB+jV6A
 Pu/04ajNxkBP7U47afIeuiJUFW9RkTHgEqWsb+rtK78mt90z7Ay19f9bW+pCZiAM87
 f+ihnJBDyaNDpx9sjCP3852JG/3mfn1T6ycprS11TUXLLJzM/EXA5WHe/XjD4gX1TL
 7QD7/CHXwe/pUhKpCqIFNOFf4o+uYkpvJsF7bmsr4hP1/rkMGA6MiYuFQCXT895/Np
 YduQ3EdvHWOKlA7gaOd9rRdJN8+Dy6ECPKLYbcdtPxQ7UWko4u9c40W/X8TlBBQEfG
 ydD/LBOkx0E1A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Adam Ford <aford173@gmail.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 1/1] configs: disable UEFI on rcar3_salvator-x_defconfig
Date: Wed, 13 Nov 2024 20:23:58 +0100
Message-ID: <20241113192358.35803-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

rcar3_salvator-x_defconfig fails to build with UEFI support on current
Ubuntu as u-boot-nodtb.bin becomes too big:

    u-boot-nodtb.bin exceeds file size limit:
      limit:  0x100000 bytes
      actual: 0x1010f8 bytes
      excess: 0x10f8 bytes

Reported-by: Adriano Cordova <adriano.cordova@canonical.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 configs/rcar3_salvator-x_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-x_defconfig
index 6b095f63549..b003502b637 100644
--- a/configs/rcar3_salvator-x_defconfig
+++ b/configs/rcar3_salvator-x_defconfig
@@ -16,7 +16,7 @@ CONFIG_SPL_BSS_START_ADDR=0xe633f000
 CONFIG_SPL_BSS_MAX_SIZE=0x1000
 CONFIG_PCI=y
 CONFIG_SYS_MONITOR_BASE=0x00000000
-# CONFIG_EFI_UNICODE_CAPITALIZATION is not set
+# CONFIG_EFI_LOADER is not set
 # CONFIG_BOOTSTD is not set
 CONFIG_USE_BOOTARGS=y
 CONFIG_USE_BOOTCOMMAND=y
-- 
2.45.2

