Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DDDC02187
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 23:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C75ED80763;
	Fri, 17 Jan 2025 00:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WaaeCOU9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8ABD80757; Fri, 17 Jan 2025 00:01:39 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B2FE80713
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 00:01:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3eba559611aso525313b6e.0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737068495; x=1737673295; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SPkZAeZDqazXZtjFU/k1Yiley/PHe8k4qR4R+Lz6nEo=;
 b=WaaeCOU9iBOcDeTJ5z/CLGRZb32lmat8rOaOxa53bp1Tv+QYkaGfr+D23obn/6Ws2A
 w0Sm6dOnJC5ps5/fiSPjc1TjRhLJuOkuXs//9GB3iTGjsTnwaXdxFI8e5Pn/tayd0HJf
 40dRAXs9zTRarxGZLuzQq3jYVE99MgDo4lhUHBEcYh/QKmuc6FE2Yrk8ic4X6AbHO27E
 V0740EHsxhox/PiUF5AvPcIFzCVwh08MZoW5omUnAqCPixHo3x/F5Ig7a1SDBL3il3pK
 AhakIvbo618xpdfutmiPS3p94nmhWM8mHS1he9cMjKZnOunzmvE/cp5Vt1ZVdNKBuZW7
 dRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737068495; x=1737673295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SPkZAeZDqazXZtjFU/k1Yiley/PHe8k4qR4R+Lz6nEo=;
 b=K9ktpKsVuDhD4MD6VNsvkZfJzHEVRr4XTim1Vf86x7d7FvPinh3/aBp3QvkpR+q8tz
 4optdq2PVKpY1Wx/dFRuchDEt2DKp2NgkjC2Ky1Mz2tfwjtOarRYdv7tt5y2bJNArHon
 2359WIsKUMIS+KYkX7dhP1kTz0lPpCu1y2s5O/rwlxY5wAU+VBqxjjgPPJiYgj1zuOVR
 q+aBHdcLjtmQqVCN+hFl+EcuauLuKkcrihKekUyo2k+WOODmDVs4ZvngVdPhz7y1rmg/
 iJih1elZCJZLyqnSWMakDC9mckKazUF81Ph9lGZUwmOF/Y2eN4mmNi4YoFVUmBbT7MkG
 tuuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaxB96kn0GOm4BP701MZ/fLXaUK8Z4qBQIpquz8tHVAfRNjaDdQvrzCLItaEKHGHC64TJdqec=@lists.denx.de
X-Gm-Message-State: AOJu0Ywq2J49kK5dKtZPiLYkAPSS8pU7dAxDRKl5L0HPC9VPEgbOo+02
 uh2YttvETdwY+LmzWzDlrqB250WqDL4iogQpRI2UufY7n8osxLPP8+6s8Ocsom4=
X-Gm-Gg: ASbGnctiN2jeBiJVdaaZqetyX1AWzmeN8El08Hdi/lAGUhct8MQWClfLKLxaw8UUprk
 CcPUNsTGguXYzn5PbA6mkJD2Pm2UCZtjGZbf44HOgaL/4FjD6r5TvZ4nYvX/UtiPWcFtpVGfZqI
 Qz7w2wwOmaM/vWhLnQXGGlhHuuxqAvPFcfUWS/qK/fIoqGv2VgCRZVrH6JJvnLGhj6/gZq/eWXm
 OAgtUXdfhqpSN+hac1ivJVyCWB5sDylK2FqS1WZPqIwr8mvgPpNVx0VonCr+Oa0sPw=
X-Google-Smtp-Source: AGHT+IFKlt6osjzO7jVOEzqg3tcEHFybp2R2S3tJUP2MRrEDaTVU7NgUMVV/B8Kj7iQKZceJ/BbHzw==
X-Received: by 2002:a05:6808:4494:b0:3e6:3a82:f790 with SMTP id
 5614622812f47-3f19fc534cemr474758b6e.6.1737068495399; 
 Thu, 16 Jan 2025 15:01:35 -0800 (PST)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f19db9f6casm410832b6e.50.2025.01.16.15.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 15:01:35 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH 2/7] configs: e850-96: Enable U-Boot environment on eMMC
Date: Thu, 16 Jan 2025 17:01:25 -0600
Message-Id: <20250116230130.3337-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116230130.3337-1-semen.protsenko@linaro.org>
References: <20250116230130.3337-1-semen.protsenko@linaro.org>
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

Store U-Boot environment in BOOT2 HW area of eMMC (/dev/mmcblk0boot1),
as it's currently unused. BOOT1 area will be probably used for storing
low-level bootloaders further, so let's not touch it.

Both primary and redundant environments work fine:

    => env default -f -a
    ## Resetting to default environment
    => env save
    Saving Environment to MMC... Writing to redundant MMC(0)... OK

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 configs/e850-96_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index b1b3510d691d..d287018ec632 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -8,8 +8,11 @@ CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_ARCH_EXYNOS9=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xf8c00000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x0
 CONFIG_DEFAULT_DEVICE_TREE="exynos/exynos850-e850-96"
 CONFIG_SYS_LOAD_ADDR=0x80000000
+CONFIG_ENV_OFFSET_REDUND=0x10000
 # CONFIG_PSCI_RESET is not set
 CONFIG_ANDROID_BOOT_IMAGE=y
 # CONFIG_AUTOBOOT is not set
@@ -24,8 +27,14 @@ CONFIG_CMD_PART=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_RNG=y
 CONFIG_PARTITION_TYPE_GUID=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_NO_NET=y
 CONFIG_CLK_EXYNOS850=y
+CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_DW=y
 CONFIG_SOC_SAMSUNG=y
 CONFIG_EXYNOS_PMU=y
-- 
2.39.5

