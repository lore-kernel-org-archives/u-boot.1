Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FD4C7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 13:46:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D863182F6A;
	Tue,  1 Jul 2025 15:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IJhkbeoU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 390A182FD6; Tue,  1 Jul 2025 15:45:51 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08DCF8301E
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 15:45:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ae3b37207easo100570666b.2
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 06:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751377539; x=1751982339; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nqpq5llxMKs8fmDm7eSOIp99fXNqTU8zXMZlCmB1ClI=;
 b=IJhkbeoUJwO99A+7UMwTOnstk6mDzT9DSgFPHvlYXfiUf9Yx5ysE4OKHn2zgN2K/oz
 lhsYWgS8nTt7auW390xajyBDU/3afg8lzAOYJBqdEgQkTvtO318Xyu8IUxpBk8tVeUfR
 JjG6hzUyf2Jc1ajKf/74gDtJfD+XoEHzrl0dx++3XY28L9ccnX7M+EGnhQjk5IlbTLUK
 Fgwb6DEGZFsIymyvQ0dQ7CQYLIWcWzBuAtXI+QjQSqOMzIaW3rDUL61upKYqB1DdPdw+
 dFZyAl35LT80s9OVaYoSSkt1UIdVeNqTSmifGD7MGLOlLnvMIVdACndYu8b81sYT45pR
 ZX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751377539; x=1751982339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nqpq5llxMKs8fmDm7eSOIp99fXNqTU8zXMZlCmB1ClI=;
 b=SftjpVbC9b4vgv0UGX7LntRTKuP16uQV6nBw7hrKua7VskXDAbpij8KCKpsscFaNoV
 kr49MmkbKpzqvHmlkvUP7ot3Z3wuk81zvxolfjmMP5qoyHScmb0wazzUDynVivFfwRSn
 yG1QBGNskHYyocx9mY6LtceNVejlj0pDHe+XVWuApDIr6brxZF+MgD4egd1w3C9ciFy1
 o5eV3DRm+3PB1NKYUByGLvkR0A622BfIgNTa8X40Uc5WARZ/H5JTmbjv52dae8C8kw7R
 Yg8heqyiqcFGvaZayoffvngTutyI60nhDj4BcSyUVMyAgxJUAj5XTyLMY6npKzS0H7K1
 h4kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMRzL/0qNIE3aCMs/syQt/Kvkn0ytmeZ6yQ5CE7bVZ1N1LvWNjXZgliXMbfRL5Yz8W2dN+VeY=@lists.denx.de
X-Gm-Message-State: AOJu0YwyJWgA8MEtpVQl2m34eLxbNgULfaSHMxJZuhwi82oPg0JzW8a4
 0W4j0beaR/trVVe97VPqguKPPayWm8zkKFSWRsLbheZojBn6kzBNB+Qw92y94Q==
X-Gm-Gg: ASbGnctVIVrF9d00fTn1YVEXTpM6UMiZlF9y4Om55xNv+g8WIEoVeSsfKXXhy5mwiTq
 5uZS4h8L/xQN4QRJs3jRrsQnmXGnMY6pdH6qdcXmSRaYLxdXOQ9wswaa0al+CCvzmFPrsN+BZdJ
 voFGKAKkpArhxkQA87TuqvtK3gh4pReDJP56zlI9d7SQwj0s8UHZlAQPOYO2A1OufPoUhImgu4t
 KvhFoeTyFN6qP8G1WJztZ5lRc/ufceGzh7gKyrzM9WU88Kwt61jfGRRoMhv7lFlolUjHQqmEsfd
 pG8jc5JL2Q0ZohcAorpOMOKrBZt+T35CihZi6DZ7kMw/YXnX60zH3/ISYs1hxMmhKQ3G3083/mH
 rN+gkZ4GtFlP/5GcL
X-Google-Smtp-Source: AGHT+IFHtG4d2CkafxViRiCgi33OQ2QcdUMP7u+AwO98AXqwdCoacUHQH9RCMq8LlUldYkdrLrEMJQ==
X-Received: by 2002:a17:907:9802:b0:ae0:e065:ddfb with SMTP id
 a640c23a62f3a-ae34fd8932cmr1523242466b.18.1751377539184; 
 Tue, 01 Jul 2025 06:45:39 -0700 (PDT)
Received: from emanuele-nb.int.toradex.com
 ([2001:b07:aac:705d:6d3f:7f26:74f6:c076])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae39ec1146csm288232366b.185.2025.07.01.06.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 06:45:38 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 1/5] configs: verdin-imx8mm: enable RNG support for KASLR
Date: Tue,  1 Jul 2025 15:44:56 +0200
Message-ID: <20250701134504.1076115-2-ghidoliemanuele@gmail.com>
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

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 configs/verdin-imx8mm_defconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/configs/verdin-imx8mm_defconfig b/configs/verdin-imx8mm_defconfig
index 7db6e81ee6d1..ea085acd28f7 100644
--- a/configs/verdin-imx8mm_defconfig
+++ b/configs/verdin-imx8mm_defconfig
@@ -76,6 +76,7 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_UUID=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
+# CONFIG_CMD_HASH is not set
 CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
@@ -99,6 +100,7 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MM=y
 CONFIG_CLK_IMX8MM=y
+CONFIG_FSL_CAAM=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x44200000
 CONFIG_FASTBOOT_FLASH=y
@@ -108,7 +110,6 @@ CONFIG_GPIO_HOG=y
 CONFIG_SPL_GPIO_HOG=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
-CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
@@ -139,6 +140,7 @@ CONFIG_SPL_DM_PMIC_PCA9450=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SYSRESET=y
@@ -161,4 +163,5 @@ CONFIG_CI_UDC=y
 CONFIG_SDP_LOADADDR=0x40400000
 CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_IMX_WATCHDOG=y
+# CONFIG_SPL_SHA_HW_ACCEL is not set
 CONFIG_HEXDUMP=y
-- 
2.43.0

