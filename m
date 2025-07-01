Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBEEC83038
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 13:46:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 742C583055;
	Tue,  1 Jul 2025 15:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dB+9Hkl3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A94082FD6; Tue,  1 Jul 2025 15:45:55 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F2D083020
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 15:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ae36dc91dc7so569151866b.2
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 06:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751377545; x=1751982345; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qn7xzKxLzI1OAye7pXEPgYZzFttk2wZuxaGXAaO9pF8=;
 b=dB+9Hkl3ko46uuKT47jAQohHGxJxN2D7Ocfe6/cvDrxT0wohnRPojjIAnS1OL40Shc
 JhedloS3bwfNsBLjEsK48OLtOBqeJZEYDXAMDg6Nl4NxVKl6m8uPpbxX8t01nDe8JTdB
 5kBh+T84OMrXFhQRS+zl7OrmG1SiJRJgGKRJ/PigHtX7mBb8vXxm/LIswMasVSgAaxJ4
 OVT982yMFM45qQZEq0LpEOWIxPYjVwnQfU7yU0kdEwrav/oHH0c54OjprfzRp7Ao6nyf
 vLNxbecjHEp8+vqEtP+6WkUxiP2jFKFbtBnkPTim2XHp216U6LnZVpEKMmLYCPxSIHHM
 Rhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751377545; x=1751982345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qn7xzKxLzI1OAye7pXEPgYZzFttk2wZuxaGXAaO9pF8=;
 b=KF6IXQNrp4OhMP/R2eTGoXVb6hC/FT6PSK2xEnNAJhOq45kpTJOQ7u2GNy5vbUIQAb
 FeZNEOSMCi8zSNUYWTpN8gm84Epd1SFUTdG+3EndskYJXg9tSHtUmQnC/uVMqBa9Toki
 5eDyey9SBcPcff3N7fWCe4f6O5AvD6EFqS30hWbik9TOThUyKYh54mXJ3y0A9QCGVtQA
 Z/JWnD+ZrNTay2F/Z0wcNvsPLnCq+OSB+A8Unglqd+KGWDAyeW6sjxPD1eG2Y6TFLzj8
 X1Qk0ltcK/iRGsB3UEGNAav2bEBdfu7w6ahhtbdTwjBi1aZKp9UhUrSbFBM1vkG1MUwS
 Ntqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKbWTPT9dTAaF++zZ/YDWXDUZEwZKK/HhKlUyeQwWH+DqQEzigHMKIIWRsY4YSiTYKsWK6Rm8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4aj1uJSYrMry06uTRHoTArg2w4Z5gsCz9Y1BdPWBj/8uGjUxF
 TXuQo2XpfaPj/8mSkR4ZHqirtreTjKUrZJGnvELM8Sp4xvpXUR05FhfZpY5j9Q==
X-Gm-Gg: ASbGncsi7ajOAATriul7COq2uAufwjq+/x8cODPEGmOVRUbmI1r09wsqR9efjvKBzYf
 NNVmYRyKGZjmNvCorm0YxeRNvEJ+TLb1gq4ukt6tcRdWmUhzIp0RBSTaxkmnVkvSJzn0cwJcs0N
 gx0MUrPgzYr8wXhhAHqKz5S5L3SO86Vybte4jzhSybFH8+iQw3ZfVIzVsjZ7jdml3SWXrZnyD/9
 wOXKny/7G8/ZZ8ijAegsXI5k1rxunjkrfgD09qfmGIXTt1qP76kyUjGP10iZHpySpiD11Dgw/+s
 R4X1lLGaw4nZtB/vBH7tG5jHAQQS+v/SiSXaVBRn0hxi1QAjRsBSz/16gO8ADaDZX7d0+tvxJAj
 5I71jCTCbpUwEJMZB
X-Google-Smtp-Source: AGHT+IG34LmeeuDVxUq+i2yuuhV+g/iXaQwRuYACHarVRFgju9fUyfVZiC2SwlvD9KgXs4uN9XgGSQ==
X-Received: by 2002:a17:907:d29:b0:ae0:bbd2:68d1 with SMTP id
 a640c23a62f3a-ae3500b8d51mr1426372466b.37.1751377541803; 
 Tue, 01 Jul 2025 06:45:41 -0700 (PDT)
Received: from emanuele-nb.int.toradex.com
 ([2001:b07:aac:705d:6d3f:7f26:74f6:c076])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae39ec1146csm288232366b.185.2025.07.01.06.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 06:45:41 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 5/5] configs: colibri-imx8x: enable RNG support for KASLR
Date: Tue,  1 Jul 2025 15:45:00 +0200
Message-ID: <20250701134504.1076115-6-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701134504.1076115-1-ghidoliemanuele@gmail.com>
References: <20250701134504.1076115-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Enable DM_RNG in U-Boot to automatically populate /chosen/kaslr-seed
and enable CAAM to provide entropy.
Enable ARCH_MISC_INIT to initialize the CAAM job ring.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 configs/colibri-imx8x_defconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/configs/colibri-imx8x_defconfig b/configs/colibri-imx8x_defconfig
index 431987d3f90b..6880caf9208b 100644
--- a/configs/colibri-imx8x_defconfig
+++ b/configs/colibri-imx8x_defconfig
@@ -33,6 +33,7 @@ CONFIG_SYS_PBSIZE=2068
 CONFIG_LOG=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_ARCH_MISC_INIT=y
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SYS_PROMPT="Colibri iMX8X # "
 CONFIG_CMD_CPU=y
@@ -47,6 +48,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_UUID=y
+# CONFIG_CMD_HASH is not set
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
@@ -67,12 +69,12 @@ CONFIG_TFTP_BLOCKSIZE=4096
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
 CONFIG_CLK_IMX8=y
+CONFIG_FSL_CAAM=y
 CONFIG_GPIO_HOG=y
 CONFIG_FXL6408_GPIO=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_IMX_LPI2C=y
-CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
 CONFIG_PHYLIB=y
@@ -89,6 +91,7 @@ CONFIG_IMX8_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
 CONFIG_DM_THERMAL=y
-- 
2.43.0

