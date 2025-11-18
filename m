Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77321CED617
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 12:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5E7783B99;
	Tue, 18 Nov 2025 13:34:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jM8pMUaa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B306883C96; Tue, 18 Nov 2025 13:34:08 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD3FD83A8F
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 13:34:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b72bf7e703fso897101466b.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 04:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763469246; x=1764074046; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fMteHo8Gw92/+d7KX5U5kplVG9b8ikdRb01Ck2/axnY=;
 b=jM8pMUaaba6HL2TK5AJBpu08QcMtYwMPUUzJOLV9gMLT+ipIZguFqfEP2YsBwX0BxC
 l9BSqDpYPc04jGep1MCTIrvCKoj22KCrHfsEYVsYRlCdEdqmmlUE+5+mke4pkbE1TFhH
 iFW1JB8e/9puVcCaS9nqLfOs2Zr/VFHzCqVmJYrr5ovmy3umnZo79lF34Mo1Sq1hyzyh
 oBbKEV9fXlToUNgbJkGyKD5c0GowYZ3flOJ1BAeu81/AgV5QumWGDDuVgr8fmr6t3MSy
 fApz2mgoDOHHQW+CnL0V88g8hnyaZnyHUWsbeDKz2XH4BjUCXz2SiqIWfs7hw+bwoxqL
 hntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763469246; x=1764074046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fMteHo8Gw92/+d7KX5U5kplVG9b8ikdRb01Ck2/axnY=;
 b=J7G8+yi+xK867fMBQmb/l39yMHn+iTOm46MegE4O3TlBFvbHmqJdLsPZj9zOeVL8nC
 31pTVd9XyFFSm8rtoPuD75Ni5k2az/aIAd3GRrVohyaHFYTj+0nM+al/2opSAjb2JDho
 TcSS8X4urhB2BUUSd3TbPb9jd5wdNbu8Net35m5WTAYHeOddTLqvpHa0XoQSP6qAWZDQ
 ympH6h0Rla9nNE25z3FyPwk6pG7rvKnIZRTb8ghrkIYR/LXUs/x2VnXEAexMOz+RcKK6
 5FI3zPca2khRLvodVSlBbHprNsrKY+zVa1Y7B81O2xGSmTfVrJ+1rb4CABL7bA/tBzHj
 cdNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMV7jqH4SwO8wpWwBNTRp5FjcQhMb5aI1/6r0lBrgPo7iex86PiTmzU/Vn1YFZt2k7W80WAUk=@lists.denx.de
X-Gm-Message-State: AOJu0Yxbz/pyc5XHVD9suqkjFMZeG0FqSWCs+gIN0I1i85jubMrASt3G
 uPPNQsyt05RO2MHGkcbIy167h9FFFDUhfxd8ImlpISkGFHDi2s+TjRct
X-Gm-Gg: ASbGncv7bBPYvbWkzGV8WeUY+T7sLoG+aEZCGn1XZPvl2gpmauulsi42nKIXJkn8ODs
 cXcEoLWjcVvVaRQvTyOyCUrgmJdX6fv+iZ2zituDk93Vqai7bwqZp8H9f4nMXRRgldZC+/hMF4t
 wVRdLsTiFJ2ylyjD/8FXyq1TZ7Y4Lydb+QuWh30b+W6y5WOeTe4YvBEVCg+d0LIYpPU00wME24/
 V7clx66Uow/L3zDB8n8K6zcuP++URjtXJVGlpvzEgzb+egE29G5aU59TBtOudViqXk7Nf43AIJ/
 kkZ9+BCwoPEJEg9ikM1kHXWTsIhsP3yn922UE0A8ZoSm25HZ7GsTgQX7XML++wKdpBclh/8EoRW
 Dxxz5MTx5sr9DTkVJrQ/itGt7Z5T6H2HjYyU85CAnzzqbyTnW/FHiSs/VQ+wC2/YCNeh9Rf+XM1
 hd428IhdFtu0FKAsiGgYiOcWkcQqT6bI4SylkqEUigB586/WPcdC10Jqw7231JDD4obmMdpAfcA
 vKssGL42odJ0KrPFJBCdzc=
X-Google-Smtp-Source: AGHT+IG4UscJwa/iq4uS5talgJKFT3dtc0iZRzecmuHA0bMqDDrgl50elFCkt4k/Sy0xx1PPGi5fhw==
X-Received: by 2002:a17:906:cc99:b0:b73:aebe:e259 with SMTP id
 a640c23a62f3a-b73aebee4cbmr364810166b.34.1763469245842; 
 Tue, 18 Nov 2025 04:34:05 -0800 (PST)
Received: from ernest.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b734fad41cesm1323176466b.16.2025.11.18.04.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 04:34:05 -0800 (PST)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: [PATCH v1] configs: colibri-imx7*: set 'fdtfile' generically in
 PREBOOT
Date: Tue, 18 Nov 2025 13:30:52 +0100
Message-ID: <20251118123056.1124089-1-ernestvanhoecke@gmail.com>
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

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

In TEZI (Toradex Easy Installer), we use one U-Boot binary for both our
NAND and eMMC Colibri iMX7 modules. Currently, CONFIG_PREBOOT sets the
environment variable 'fdtfile' depending on which defconfig was used,
adding the '-emmc' variant for the emmc defconfig. Since we always build
the TEZI recovery U-Boot with the standard (non-emmc) defconfig, fdtfile
has to be overwritten later or it will be wrong there.

By using '$variant', the fdtfile var is properly constructed at run time
for both the NAND and eMMC variants, and we do not have to worry about
setting fdtfile again when building the recovery TEZI U-Boot.

This also synchronizes these configs with how we handle the iMX6ULL.

Fixes: 327381e8b57c ("colibri_imx7: use preboot for fdtfile evaluation")
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 configs/colibri_imx7_defconfig      | 2 +-
 configs/colibri_imx7_emmc_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/colibri_imx7_defconfig b/configs/colibri_imx7_defconfig
index 5a415120bead..ec950c89569e 100644
--- a/configs/colibri_imx7_defconfig
+++ b/configs/colibri_imx7_defconfig
@@ -22,7 +22,7 @@ CONFIG_BOOTDELAY=1
 CONFIG_OF_ENV_SETUP=y
 CONFIG_BOOTCOMMAND="run ubiboot ; echo ; echo ubiboot failed ; run distro_bootcmd;"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile ${soc}-colibri-${fdt_board}.dtb "
+CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx7-colibri${variant}-${fdt_board}.dtb "
 CONFIG_SYS_PBSIZE=544
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 # CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/configs/colibri_imx7_emmc_defconfig b/configs/colibri_imx7_emmc_defconfig
index bae43fe45aa7..8b8e71b056fc 100644
--- a/configs/colibri_imx7_emmc_defconfig
+++ b/configs/colibri_imx7_emmc_defconfig
@@ -19,7 +19,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile ${soc}-colibri-emmc-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx7-colibri${variant}-${fdt_board}.dtb"
 CONFIG_SYS_PBSIZE=544
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 # CONFIG_DISPLAY_BOARDINFO is not set
-- 
2.43.0

