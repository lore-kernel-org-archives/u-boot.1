Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4A4C7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 13:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F5478304C;
	Tue,  1 Jul 2025 15:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kk8Y66dr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F9FD82FD6; Tue,  1 Jul 2025 15:45:51 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ECDC82FAB
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 15:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ae0bde4d5c9so1040143066b.3
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 06:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751377541; x=1751982341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oBHcBGsFTJvLYVokIEHCECqgRaC8/RAwf50kHUrPm68=;
 b=kk8Y66drOR09WN0WmKxv44fw7/rYuJYq02a0o8q9fVYH8ZJHAqt1+u77SXQfNcI4+g
 0dUcACXNs6tkCTsHqGitDWt82/x0RL6nxGHKMuyb2hslw3+LtyE7oAJkSdzbzrfBg9vN
 MeK01QcAYjZqK7jcYBZQN9sfUR2B2AogKTeK4cqS86dXq+XfJMvf2cg/GFpmaN4TX8g8
 /MlIU4Qu+/iWgHXylZ8t2anlqin7UoSUNKQWQWVN5eGFEEmsLraSuCMb75mEU7qh4t5t
 WEtkFKg/x9dfQCVgz+2NMOkHBnxkBZoJFuAv8W2TA0PmylrQadsZkDXhP/XfvdKoFiYZ
 YigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751377541; x=1751982341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oBHcBGsFTJvLYVokIEHCECqgRaC8/RAwf50kHUrPm68=;
 b=mnfY6L1ZW//xnXzj1t2g32h+iP7W2H23STEKgUV9YRgJAfRuE0+mHktskfqkStUooO
 rCSzmkhhXLshYZY+1zts/G8+RMx+MpTh3XpTlJ0OpuHFMCUgZgBLpbCGkMR6H8scVc6I
 p70ghOWBW+kG3qi8UINcoUU6PjYLwb8nmY3sdp9+GzjDaLE8fsAFxdm6g4PlU2mR313g
 i79AmB3uhvSkqrwixf4agwvm46tD8xQ/r/1nEVCJMaLl31oygkjtczrWTjRqvL0slDsA
 FhfIpB0kg9/fwRPDmDGGuhdhPpmO5Wi1AdrZo34jIM40CU2K7ymn1RA8Fl1TWFd2TD/4
 Aexw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvvnGIcnJQTxK6y8rm2Rvy8Uj7NXuDhX6jIRj8NmOnzmiLTf241mh1Xo4lJBJTYqm9OxfNNeM=@lists.denx.de
X-Gm-Message-State: AOJu0Yxv68FIRDriWNKYh/1uA4cqmUvZadrl4n1XElQfDsoO1WitxXcq
 TReJkSnvtfStCsA5wWSn5W9C540aKJkl21xKGIv8rG80DMANCurAJTkNrZZS0A==
X-Gm-Gg: ASbGncvIWjzB5d5EucseNorj9WPZ2q9SXCJQUlNlgsGB8B/WyfnDHhHFiLhbwESJOAa
 e2Fje6kCmJ03KwdoHwGSq2WJnphjDNCmUd5PnhHrreHeiucczOxTOKXHqa8j/dNCfvkazNVnfB7
 z5HcpRd2gwJIxVXKxyYnqoh1ypLAR7At+dDtA666upcWTUJGHjvNVQBzD34WznMBcKbnPmD0Q5w
 1ubJT2UH/eGD2Ptz2TGMhDbMfOQ+ScoYUjOdwtKT+VfmZI0TqyP7M1o2VrBqx0ecpRTshPB/oMu
 Kb99B0gLG83HV2rlp1DZUnkkSANOnZiyyPswuBLtdZXrCav6XMKaEN26+VUeBZxy3tZn4HDc4cL
 9D/EsOpCGBehxYZnX
X-Google-Smtp-Source: AGHT+IFquT1t6Tgw3VPfT7l/TP2+RJLWyRvuAxKf4hf08mHHDw8LssGxFtWiZgvDtBL/v913S3SZuw==
X-Received: by 2002:a17:907:f507:b0:ae0:68a8:bd6a with SMTP id
 a640c23a62f3a-ae34fd9a82bmr1586528366b.15.1751377541099; 
 Tue, 01 Jul 2025 06:45:41 -0700 (PDT)
Received: from emanuele-nb.int.toradex.com
 ([2001:b07:aac:705d:6d3f:7f26:74f6:c076])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae39ec1146csm288232366b.185.2025.07.01.06.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 06:45:40 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 4/5] configs: apalis-imx8: enable RNG support for KASLR
Date: Tue,  1 Jul 2025 15:44:59 +0200
Message-ID: <20250701134504.1076115-5-ghidoliemanuele@gmail.com>
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
 configs/apalis-imx8_defconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/configs/apalis-imx8_defconfig b/configs/apalis-imx8_defconfig
index dfd586b1c144..da0d51a844b1 100644
--- a/configs/apalis-imx8_defconfig
+++ b/configs/apalis-imx8_defconfig
@@ -32,6 +32,7 @@ CONFIG_SYS_PBSIZE=2068
 CONFIG_LOG=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_ARCH_MISC_INIT=y
 CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SYS_PROMPT="Apalis iMX8 # "
 CONFIG_CMD_CPU=y
@@ -46,6 +47,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_UUID=y
+# CONFIG_CMD_HASH is not set
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
@@ -66,11 +68,11 @@ CONFIG_TFTP_BLOCKSIZE=4096
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
 CONFIG_CLK_IMX8=y
+CONFIG_FSL_CAAM=y
 CONFIG_GPIO_HOG=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_IMX_LPI2C=y
-CONFIG_MISC=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
 CONFIG_PHYLIB=y
@@ -88,6 +90,7 @@ CONFIG_IMX8_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
 CONFIG_DM_THERMAL=y
-- 
2.43.0

