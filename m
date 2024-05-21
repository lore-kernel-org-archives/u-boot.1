Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CF7C25B75
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 10:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 861528871D;
	Tue, 21 May 2024 12:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1716288615;
	bh=zK5QHlDPS88gYSHqx0uBB8UyIBu8GFIzUxPs6uz313Y=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JmVi6KFt83kC9EH9TJ0d8ALuCcyiM/qpC7vLdQTuGFMRO2ke050KSyKRzEyH87m+C
	 r/ini0dOIOemFPzRNwLRtMmuz3/CO8Nv1JHuefT0YCWVwHnzTH88ru9xQWM9/ez81F
	 eW0GOTHGwoldSD8kvIwQDyIiq44LYio1jTipj2hyvwmaoADvTMBEJBQz192JfcuXmC
	 vYr/hdLXovE+gOR+o0AOGVEyRnVsOei0P0X5kHTFRl+QFwlCkdzpm9u2qvDii1mVpg
	 UeMLRF3MOWNZflU9e2c48MEMhPZ0BaQcaYd6d7av4zzLhPnkl45hw03h/AVgf/fszg
	 /V9DRTa40GkWQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CFA3387FBC;
 Tue, 21 May 2024 12:50:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1716288613;
 bh=zK5QHlDPS88gYSHqx0uBB8UyIBu8GFIzUxPs6uz313Y=;
 h=From:To:Cc:Subject:Date:From;
 b=EOwbCazbF4xctvSZw/2q4NvoQywJByCQv2GDoAH7Fv1eTuNPfPG7ww7Ggbj8RoCgK
 shWmIq0NLceG4v7SRnUWPIwXrlUvC05WWSFsaet9T5H+m5csTDqWuE2jtkypiEQBhl
 C0K+ic2LnPfkvt1zawDl6FsWH133W3Ya1ks0cMLNu0rohAadMnwXmrKCQSR0LVhfZB
 ivATewq8uFoj9n3GNd3mhDiIO7eHstzbcSiR4j83w5gDcOx2enR4imRkbUIwqVeNNJ
 ZvGBlq5k5Bkjg/Q0kaAy8/HcmRRCn59T3JHnhjL0evB9SNaSnZ2/xFhBvQ+DDOMqBQ
 wyjk3ztuaX2kw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Olaf Mandel <o.mandel@menlosystems.com>, Marek Vasut <marex@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH] ARM: imx: mx5: Simplify TFTP server layout on MX53 Menlo board
Date: Tue, 21 May 2024 12:49:38 +0200
Message-ID: <20240521105000.11376-1-marex@denx.de>
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

From: Olaf Mandel <o.mandel@menlosystems.com>

By removing the "boot" directory in the "m53menlo/boot/fitImage" path,
we simplify the TFTP server directory layout a bit. This also requires a
change to the mmcload command as it (mis-)uses the same variable as the
TFTP boot.

Signed-off-by: Olaf Mandel <o.mandel@menlosystems.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@lists.denx.de
---
 configs/m53menlo_defconfig | 2 +-
 include/configs/m53menlo.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/m53menlo_defconfig b/configs/m53menlo_defconfig
index 7c3f0dc1525..b06a614dde0 100644
--- a/configs/m53menlo_defconfig
+++ b/configs/m53menlo_defconfig
@@ -71,7 +71,7 @@ CONFIG_ENV_RANGE=0x80000
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
-CONFIG_BOOTFILE="boot/fitImage"
+CONFIG_BOOTFILE="fitImage"
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC0"
 CONFIG_USE_HOSTNAME=y
diff --git a/include/configs/m53menlo.h b/include/configs/m53menlo.h
index 1ecbba1b58f..9cf46b2c362 100644
--- a/include/configs/m53menlo.h
+++ b/include/configs/m53menlo.h
@@ -119,7 +119,7 @@
 	"addargs=run addcons addmisc addmtd\0"				\
 	"mmcload="							\
 		"mmc rescan || reset ; load mmc ${mmcdev}:${mmcpart} "	\
-		"${kernel_addr_r} ${bootfile} || reset\0"		\
+		"${kernel_addr_r} boot/${bootfile} || reset\0"		\
 	"miscargs=nohlt panic=1\0"					\
 	"mmcargs=setenv bootargs root=/dev/mmcblk0p${mmcpart} rw "	\
 		"rootwait\0"						\
-- 
2.43.0

