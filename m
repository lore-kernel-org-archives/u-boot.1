Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9932C61DD3
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 01:50:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C498380F81;
	Sat, 29 Aug 2026 01:50:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P9iSvFUcDV0h; Sat, 29 Aug 2026 01:50:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787968241;
	bh=VxcZHRhXyZjXWFw5fTwzwYanmFn4gqjohZ8NmcLOfqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mJg/6yvlONL+k2/aYlU+i/njsJJ6dyIQkI9dBBmwgPVEG5tBCAxAi9ELK7UUvyady
	 K6RkiByoQL1JvqWkN7G/9wbK3ClSR+TCqlGBqJLCrRD7OGuxykNNOZs+zSGEM7vmzR
	 VYfcuMCB525JLtAOYreRHCCIVrovURb5dasE3Uo/oqrU3l6OuXF0ZEU069boBC/t4L
	 aIqEPyjOFomWbF4lX30OqvtEe29ZYfz/DceAVIVlbMWEt7QtoncdoMJ/GXF1sPcKf2
	 UOP1eKDD8BQ1kw32O6nnjsVOSBGmD2WRsubC4PoO1yl/NgA0g9iIqW+4GNgPsbOkDS
	 dtjcVrVThX7qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 159D280F97;
	Sat, 29 Aug 2026 01:50:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E07DD355
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 01:50:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE12440845
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 01:50:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mngqZx4pqGUT for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 01:50:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c31; helo=mail-oo1-xc31.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=rl/ypgcu
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1568940841
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 01:50:33 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6b1334a3b16so39997eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 18:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787968233; x=1788573033;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VxcZHRhXyZjXWFw5fTwzwYanmFn4gqjohZ8NmcLOfqE=;
 b=rl/ypgcu6+kO0iVE3jbr0vBgGk0P/BcWSWcYua0XGLsdxbeo84QsP8bYFx12AWkPl7
 AzprZR5+ATIDydc4NFmzFOTbYqcS2lQ3XBNoRRu6sFmB/VzwJH+T9zVsmg1TvRyl10Oh
 zqeptI9voj4VMwkkFeQIqgVomKMlXud/e88co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787968233; x=1788573033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VxcZHRhXyZjXWFw5fTwzwYanmFn4gqjohZ8NmcLOfqE=;
 b=VO40iPxIQEtntt8vcvKVkRK+WlGlFkMgVSMq+fU7Og+udXYtZVNrT89GV8Wb/YR2z2
 J3twGpu2xU4RDE0JRyOi9l1Gy6z0Iy0jQU4x3Gt/4vGehEwwRVE50NJS0ROCg3++LkcT
 byMrK2xbFFagd0Fyx7ZCoejbJl9fkmBpyVAjNuoiINN1GBQUgQD4i1vefj0jVhUJ/Mel
 CCDk1qJZRZCdF/A4k1vKoySnirBNT4pm19ToHq9lZ6b4Wy0mthV4zddkoNYRQlhV1FuI
 4f2VhDtXrUEMMvj6H+9u8H8P8vdWCx3A8D7uH7qBl7Z+gkEbK7bJ1z85IkEbNk6dOU9Z
 DMRg==
X-Gm-Message-State: AFuF++mXZTVpSRhhXX/NwaIqI9Z0hDMMGbrYDpLKMkJWzS2JEXgrWy5G
 LkEmGXIBO4OruZI1rvnMYKKu+UV5XFLEHSvPgDjyUXpR21onbdmVN+ywTb0YIisWdKNBpEmLktz
 XEWVjMweLDxQ8
X-Gm-Gg: AR+sD11tMfx/StQzWhcPHkXj/UP1pG5IObn7uS1sqs76//o2mfThqVFdo0/xQhijy/q
 5hpGd6+uq8/d8wwJex48WsNV8Np5nWo+5sCyEezS1Q8IzYPdIN/lJlCG73KbwFYKpA2VPpi/oI3
 m+BaTIYAgvcVpzjpMwpDdE1nVZyqR6+zwrGtFi9Vqy8Ba4lagCORtzWEumnVU+H3VrOePlFmqlI
 cBNbOZIi/ZaNxoKuoIuUHFpHrFsweohfzf7v+U98aTs2b9XhEbGLeICPjMnl8EZ0aMQMI31YIwm
 D3mx2PfdOLj7cfDKfozI08VCqUUCdCxvjIkNFe6nnX1Hap2s42elny3tjj6pOFLf1rDqLr6yGNH
 XMJdbaAbGvgJZwMRBsWsGSJuRTqHks4XuuLPEBuiGONMDzZM7+ptBUG78lngq/5TKm55lC8dlda
 VA+HYNbAge79hy9xAQK9sUqRRHwkHhUeDxgXw2mYTeEGcPJOLKWwn4BvVHXxXz2dTB6DJzDpwJ4
 6mzEPlutXsaSChWuNfDRDvCSiAFjPNcAGMY6fb8YN2PffiH4K/0HgdD9xFsfgYtsHjwCdNzCRIG
 XyVP9yiGy1aMIDjLzD9AzlC14igRayv0cQ==
X-Received: by 2002:a05:6820:4b81:b0:6aa:d13c:a709 with SMTP id
 006d021491bc7-6b1c67cc418mr10688552eaf.31.1787968232750; 
 Fri, 28 Aug 2026 18:50:32 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-468a353d45asm3070190fac.7.2026.08.28.18.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 18:50:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>
Subject: [PATCH v2 5/7] MAINTAINERS: Correct entries missed during renames
Date: Fri, 28 Aug 2026 19:50:23 -0600
Message-ID: <20260829015026.473134-6-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260829015026.473134-1-trini@konsulko.com>
References: <20260829015026.473134-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

In some cases, files had been renamed or merged and their existing
MAINTAINERS entry was not updated to match. Correct these places.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Michal Simek <michal.simek@amd.com>
---
 board/amlogic/p212/MAINTAINERS             | 2 +-
 board/amlogic/q200/MAINTAINERS             | 2 +-
 board/amlogic/s400/MAINTAINERS             | 2 +-
 board/engicam/imx6ul/MAINTAINERS           | 5 ++---
 board/keymile/km83xx/MAINTAINERS           | 6 ++++--
 board/qualcomm/dragonboard410c/MAINTAINERS | 2 +-
 board/qualcomm/dragonboard820c/MAINTAINERS | 2 +-
 board/qualcomm/dragonboard845c/MAINTAINERS | 2 --
 board/qualcomm/qcs404-evb/MAINTAINERS      | 2 --
 board/renesas/eagle/MAINTAINERS            | 2 +-
 board/renesas/grpeach/MAINTAINERS          | 2 +-
 board/renesas/v3msk/MAINTAINERS            | 2 +-
 board/samsung/starqltechn/MAINTAINERS      | 4 ++--
 board/wandboard/MAINTAINERS                | 2 +-
 14 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/board/amlogic/p212/MAINTAINERS b/board/amlogic/p212/MAINTAINERS
index e73a4e52c1fd..869264285c37 100644
--- a/board/amlogic/p212/MAINTAINERS
+++ b/board/amlogic/p212/MAINTAINERS
@@ -3,7 +3,7 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/p212/
-F:	include/configs/p212.h
+F:	include/configs/meson64.h
 F:	configs/khadas-vim_defconfig
 F:	configs/libretech-cc_defconfig
 F:	configs/libretech-cc_v2_defconfig
diff --git a/board/amlogic/q200/MAINTAINERS b/board/amlogic/q200/MAINTAINERS
index aece8d5e05c7..dba49eb33248 100644
--- a/board/amlogic/q200/MAINTAINERS
+++ b/board/amlogic/q200/MAINTAINERS
@@ -3,7 +3,7 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/q200/
-F:	include/configs/q200.h
+F:	include/configs/meson64.h
 F:	configs/beelink-gt1-ultimate_defconfig
 F:	configs/khadas-vim2_defconfig
 F:	configs/libretech-s905d-pc_defconfig
diff --git a/board/amlogic/s400/MAINTAINERS b/board/amlogic/s400/MAINTAINERS
index ca51bb6b3ba1..2b909f4b276c 100644
--- a/board/amlogic/s400/MAINTAINERS
+++ b/board/amlogic/s400/MAINTAINERS
@@ -3,6 +3,6 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/s400/
-F:	include/configs/s400.h
+F:	include/configs/meson64.h
 F:	configs/s400_defconfig
 F:	doc/board/amlogic/s400.rst
diff --git a/board/engicam/imx6ul/MAINTAINERS b/board/engicam/imx6ul/MAINTAINERS
index b9c6af27245c..a1b5b1778421 100644
--- a/board/engicam/imx6ul/MAINTAINERS
+++ b/board/engicam/imx6ul/MAINTAINERS
@@ -7,12 +7,11 @@ F:	include/configs/imx6-engicam.h
 F:	configs/imx6ul_geam_mmc_defconfig
 F:	configs/imx6ul_geam_nand_defconfig
 F:	configs/imx6ul_isiot_emmc_defconfig
-F:	configs/imx6ul_isiot_mmc_defconfig
 F:	configs/imx6ul_isiot_nand_defconfig
 F:	arch/arm/dts/imx6ul.dtsi
 F:	arch/arm/dts/imx6ul-u-boot.dtsi
-F:	arch/arm/dts/imx6ul-geam-kit.dts
-F:	arch/arm/dts/imx6ul-geam-kit-u-boot.dtsi
+F:	arch/arm/dts/imx6ul-geam.dts
+F:	arch/arm/dts/imx6ul-geam-u-boot.dtsi
 F:	arch/arm/dts/imx6ul-isiot.dtsi
 F:	arch/arm/dts/imx6ul-isiot-u-boot.dtsi
 F:	arch/arm/dts/imx6ul-isiot-emmc.dts
diff --git a/board/keymile/km83xx/MAINTAINERS b/board/keymile/km83xx/MAINTAINERS
index af0d6afb2b44..291d4f053355 100644
--- a/board/keymile/km83xx/MAINTAINERS
+++ b/board/keymile/km83xx/MAINTAINERS
@@ -5,10 +5,12 @@ S:	Maintained
 F:	board/keymile/km83xx/
 F:	board/keymile/common/
 F:	board/keymile/scripts/
-F:	include/configs/km8360.h
+F:	include/configs/kmcoge5ne.h
+F:	include/configs/kmeter1.h
+F:	include/configs/km/km-mpc83xx.h
 F:	configs/kmcoge5ne_defconfig
 F:	configs/kmeter1_defconfig
-F:	include/configs/tuxx1.h
+F:	include/configs/km832x.h
 F:	configs/kmopti2_defconfig
 F:	configs/kmsupx5_defconfig
 F:	configs/kmtepr2_defconfig
diff --git a/board/qualcomm/dragonboard410c/MAINTAINERS b/board/qualcomm/dragonboard410c/MAINTAINERS
index 9c10fa3053b0..a8eae9a05485 100644
--- a/board/qualcomm/dragonboard410c/MAINTAINERS
+++ b/board/qualcomm/dragonboard410c/MAINTAINERS
@@ -4,5 +4,5 @@ R:	Sam Day <me@samcday.com>
 S:	Maintained
 F:	board/qualcomm/dragonboard410c/
 F:	include/configs/dragonboard410c.h
-F:	configs/dragonboard410c_defconfig
+F:	configs/qcom_dragonboard410c_defconfig
 F:	doc/board/qualcomm/dragonboard410c.rst
diff --git a/board/qualcomm/dragonboard820c/MAINTAINERS b/board/qualcomm/dragonboard820c/MAINTAINERS
index 7ef905bdf69c..08fdb9903414 100644
--- a/board/qualcomm/dragonboard820c/MAINTAINERS
+++ b/board/qualcomm/dragonboard820c/MAINTAINERS
@@ -3,4 +3,4 @@ M:	Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
 S:	Maintained
 F:	board/qualcomm/dragonboard820c/
 F:	include/configs/dragonboard820c.h
-F:	configs/dragonboard820c_defconfig
+F:	configs/qcom_dragonboard820c_defconfig
diff --git a/board/qualcomm/dragonboard845c/MAINTAINERS b/board/qualcomm/dragonboard845c/MAINTAINERS
index e555953df697..3b5c63459fe0 100644
--- a/board/qualcomm/dragonboard845c/MAINTAINERS
+++ b/board/qualcomm/dragonboard845c/MAINTAINERS
@@ -2,5 +2,3 @@ Qualcomm Robotics RB3 Development Platform (dragonboard845c)
 M:	Sumit Garg <sumit.garg@linaro.org>
 S:	Maintained
 F:	board/qualcomm/dragonboard845c/
-F:	include/configs/dragonboard845c.h
-F:	configs/dragonboard845c_defconfig
diff --git a/board/qualcomm/qcs404-evb/MAINTAINERS b/board/qualcomm/qcs404-evb/MAINTAINERS
index 0a2e194ff608..c6c672d6c3c4 100644
--- a/board/qualcomm/qcs404-evb/MAINTAINERS
+++ b/board/qualcomm/qcs404-evb/MAINTAINERS
@@ -2,5 +2,3 @@ Qualcomm Technologies, Inc. QCS404 evaluation board
 M:	Sumit Garg <sumit.garg@linaro.org>
 S:	Maintained
 F:	board/qualcomm/qcs404-evb/
-F:	include/configs/qcs404-evb.h
-F:	configs/qcs404evb_defconfig
diff --git a/board/renesas/eagle/MAINTAINERS b/board/renesas/eagle/MAINTAINERS
index c28b6502478c..8b458a3ca4d0 100644
--- a/board/renesas/eagle/MAINTAINERS
+++ b/board/renesas/eagle/MAINTAINERS
@@ -4,4 +4,4 @@ S:	Maintained
 F:	arch/arm/dts/r8a77970-eagle*
 F:	board/renesas/eagle/
 F:	configs/r8a77970_eagle_defconfig
-F:	include/configs/eagle.h
+F:	include/configs/rcar-gen3-common.h
diff --git a/board/renesas/grpeach/MAINTAINERS b/board/renesas/grpeach/MAINTAINERS
index c0f4fbcbae16..37a3df5f2b52 100644
--- a/board/renesas/grpeach/MAINTAINERS
+++ b/board/renesas/grpeach/MAINTAINERS
@@ -7,7 +7,7 @@ F:	configs/grpeach_defconfig
 F:	drivers/gpio/gpio-rza1.c
 F:	drivers/mtd/renesas_rpc_hf.c
 F:	drivers/net/sh_eth*
-F:	drivers/pinctrl/renesas/pfc-r7s72100.c
+F:	drivers/pinctrl/renesas/pinctrl-rza1.c
 F:	drivers/serial/serial_sh*
 F:	drivers/spi/renesas_rpc_spi.c
 F:	drivers/timer/ostm_timer.c
diff --git a/board/renesas/v3msk/MAINTAINERS b/board/renesas/v3msk/MAINTAINERS
index c198cf8c9b89..062133b0259e 100644
--- a/board/renesas/v3msk/MAINTAINERS
+++ b/board/renesas/v3msk/MAINTAINERS
@@ -5,4 +5,4 @@ S:	Maintained
 F:	arch/arm/dts/r8a77970-v3msk*
 F:	board/renesas/v3msk/
 F:	configs/r8a77970_v3msk_defconfig
-F:	include/configs/v3msk.h
+F:	include/configs/rcar-gen3-common.h
diff --git a/board/samsung/starqltechn/MAINTAINERS b/board/samsung/starqltechn/MAINTAINERS
index 135cafdd69ca..7ca1a9bac896 100644
--- a/board/samsung/starqltechn/MAINTAINERS
+++ b/board/samsung/starqltechn/MAINTAINERS
@@ -2,5 +2,5 @@ Samsung S9 (SM-G9600)(starqltechn)  Board
 M:	Dzmitry Sankouski <dsankouski@gmail.com>
 S:	Maintained
 F:	board/samsung/starqltechn/
-F:	include/configs/starqltechn.h
-F:	configs/starqltechn_defconfig
+F:	include/configs/qcom.h
+F:	configs/qcom_sdm845_spl_defconfig
diff --git a/board/wandboard/MAINTAINERS b/board/wandboard/MAINTAINERS
index 3c2a06cf09bc..f5a6db3aa9e7 100644
--- a/board/wandboard/MAINTAINERS
+++ b/board/wandboard/MAINTAINERS
@@ -3,7 +3,7 @@ M:	Fabio Estevam <festevam@gmail.com>
 S:	Maintained
 F:	arch/arm/dts/imx6qdl-wandboard.dtsi
 F:	arch/arm/dts/imx6qdl-wandboard-revb1.dtsi
-F:	arch/arm/dts/imx6dl-wandboard-revb1.dts
+F:	arch/arm/dts/imx6dl-wandboard-revd1.dts
 F:	board/wandboard/
 F:	include/configs/wandboard.h
 F:	configs/wandboard_defconfig
-- 
2.43.0

