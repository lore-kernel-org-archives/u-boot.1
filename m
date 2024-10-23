Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DE1CDDE6E
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 11:54:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6034D88F82;
	Wed, 23 Oct 2024 13:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dB7t7Js5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1848188F4B; Wed, 23 Oct 2024 13:54:42 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDCA388F82
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 13:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2887abeefbdso3392115fac.0
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 04:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729684468; x=1730289268; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3Pu9wXvKkA0rTUeQG19jSYkajv0CDIHpPqbEIG/j3zw=;
 b=dB7t7Js5I3Vp7gFt4lYhDpyRdn5r4aJW2xKj/fQJ4128lBJvFPmw2KLP8+NE7sJGUn
 ocUik7D5SLoC6n0UzF+QU9l/JTx2hvqW0l2JffI0ejSR7seEJcCgkt2MuqusIMDPUyvD
 MAWKVZ9WCV+tEZPkiB5eVLJMKWiQ4PgeMpikey9nwJDK/CrHuX2q1G0QzriIMUW9drNn
 t4pfE1EUk5DQXPUpb12LJ6Q+VfB5Kei58NZwgWDrqv7Dx2pd5fvR8oR6BpWakQDIrpSU
 gut0RYYVBJA6nzyjWBFP6jp9xfyETaQ0n+PefNN7ptmH8M4d+dBDe5KnNCE/vzTTbKs/
 mw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729684468; x=1730289268;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Pu9wXvKkA0rTUeQG19jSYkajv0CDIHpPqbEIG/j3zw=;
 b=kC4Acd47VPPVvuoHwIW3zpI1IZhevxbaHqjBtska4cYOXXg/f/LAJ6lrVkOezRInBs
 7DkqogogKPft3eGMaJ3ppamLrPxfmEhoZkbBL6Pzy2RbDBfe1WMpULE6/vudE0ZUJHP8
 Rn7ENWPIyMPXRP5Dy/UAUzpwFEku1A/JFfIR/UlwnMZZSCuWPBOJbcG57bdsYhICpHgK
 UIAso0QvkinNF57CQXUaSOaBn42wy3MG3ZizWBbktRLXJv+8HHIC9/GwQ9vy9Okqfb2U
 NbIOPRVJ+9krFsRsoajl7fnRjort5/jnL9xpYWbQMrNHpPJeJxafxV6O7ZeYH77W1RGR
 M5pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZG+Id/S8lcGoeouMzd8KDRhm8dzA1wvrZEa3+hUPqChVoCnczYUMYzAoo7z+7i32gF5OeHeQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyaj9cq3isWPv+9gnV6dND6dtZP9SiEXahb0Qnh5Irf4B5xdE2c
 TIRNAzo8v20vBOEfCmRQ+Tay/5Ecn0Y4UNIopt/CLP5JXAeF4OQ3
X-Google-Smtp-Source: AGHT+IGnLF0BlzKyZtpemP3iJ6SZ0BMUEPqsxd2aSg9ZuEmXoWb1gb0AbhH5QLmV7V/k5oTZ93HZVg==
X-Received: by 2002:a05:6870:468a:b0:287:4904:7125 with SMTP id
 586e51a60fabf-28ccb404365mr2274638fac.14.1729684468578; 
 Wed, 23 Oct 2024 04:54:28 -0700 (PDT)
Received: from hiago-nb.corp.toradex.com ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec1407ecbsm6184879b3a.193.2024.10.23.04.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 04:54:27 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH] verdin-imx8m{m|p}: defconfig: update fastboot buffer
 size/address
Date: Wed, 23 Oct 2024 08:53:50 -0300
Message-Id: <20241023115350.8413-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.5
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

From: Hiago De Franco <hiago.franco@toradex.com>

Remove FASTBOOT_BUF_SIZE from verdin-imx8mm_defconfig and
verdin-imx8mp_defconfig to use the default value of 0x7000000, aligning
with other Toradex boards.

Update FASTBOOT_BUF_ADDR to 0x44200000, consistent with the value in
previous downstream NXP U-Boot releases. This will make fastboot
applications continue working with upstream U-Boot by using the same
address.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 configs/verdin-imx8mm_defconfig | 3 +--
 configs/verdin-imx8mp_defconfig | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/configs/verdin-imx8mm_defconfig b/configs/verdin-imx8mm_defconfig
index aa4a400c3c60..abb458df4a98 100644
--- a/configs/verdin-imx8mm_defconfig
+++ b/configs/verdin-imx8mm_defconfig
@@ -100,8 +100,7 @@ CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MM=y
 CONFIG_CLK_IMX8MM=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_FASTBOOT_BUF_ADDR=0x42800000
-CONFIG_FASTBOOT_BUF_SIZE=0x40000000
+CONFIG_FASTBOOT_BUF_ADDR=0x44200000
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_UUU_SUPPORT=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index bf1a0b8badfa..661761f39774 100644
--- a/configs/verdin-imx8mp_defconfig
+++ b/configs/verdin-imx8mp_defconfig
@@ -112,8 +112,7 @@ CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_IMX8MP=y
 CONFIG_FSL_CAAM=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_FASTBOOT_BUF_ADDR=0x42800000
-CONFIG_FASTBOOT_BUF_SIZE=0x40000000
+CONFIG_FASTBOOT_BUF_ADDR=0x44200000
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_UUU_SUPPORT=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
-- 
2.39.5

