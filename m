Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5822EC02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 23:02:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B10680778;
	Fri, 17 Jan 2025 00:01:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qVSC8Hm4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7383780757; Fri, 17 Jan 2025 00:01:40 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC0688022B
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 00:01:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3eb9bbcc936so968191b6e.0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737068496; x=1737673296; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EeIWRehaDvJW3klYrgdOiErw+8LPdGBx2RHkuWpcIL4=;
 b=qVSC8Hm4QkNfi2j04KIErovXZ1ESfA/bHvx4cABGRj5Yq5c5mtXDWWABQSoom5B0W1
 +P1XUPcCp4JERmuNIl4NzJgg+WS6TznF02risjN7xe+pPJfS/a2lY4B618WZ2HZJQcLV
 nPRq8QTVjYo29zh8UZ8ORHOJbaoa51myYe89M8yC+1n/G6JPXVBoyxzUY37FPaBFaTfe
 0/taDwFlz6mYkaoSSkBGxGmu+JuiSphdfQ4xO7g0hvq0iVqHrt5iBVIOa1L9uAxSk4ce
 ZKBx1yrbM0MhRrkSYTP1NKpy/AhyLqJPfLJs2tkJTo+H3Y3tQ+60S0Cy9ila83qTjF1/
 ytxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737068496; x=1737673296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EeIWRehaDvJW3klYrgdOiErw+8LPdGBx2RHkuWpcIL4=;
 b=mnf3xv2aTNwwbgSTU7E7MnKNDLT2Yzln2AC3GJPr4QyZa5spInkWZjMf3TzwJpP+Q8
 UWZATMG7TtTvwGsOcX0nl7FysmUc/oMlaMQFL21yn0g4yxnK7DAnHM4Gd+EZYhPtC6u6
 g1jpFXV79p3Am5xx7wxevBtxYCnGtqhrNEfeqOxOIYcuKLNuLXKnX7bmOThrYB/NM9cT
 lPABw60UVkNslorvFi08crozIKiijZi43ngHqVuvyM6C7JHpMqMgE4lOC1babSW4IKjm
 t2dTdocK3HjfN+Rr6NiUytpM772OChovgRalgCbf95GvAjUXSjI6Kbi/2PU/cQp+rTv3
 LBmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWosxPcZgfXxKD3TBmwIfwcpPOoDJRnW+9KPXOmv52fGy9Xa8Fh5SDn4eT56MmfOJvHPCzNDAo=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+U4O3lBeDCFuhLHNFN8daZ/ByjeRQDdmqJQP+wAAM4fUJRupf
 0C6GmjTLGc4Yjyb32dCrKrYufoGsyU60TPOylJAokpG5l3Y6PrYszIycU4bHdSk=
X-Gm-Gg: ASbGncvgbEN8VqabUv8duGRXcUir9bnk2n7U5o+mnunfXnk/M8ckt+6Y/+GGr1l/tM3
 jvDjtBPT4BPh5a2fdnLbpsnnedR/47Dm0ICibfIL9U8v2SOwQTUv4p4lAIR9+s7hEr/IIlqJpKI
 S44RK/A7DeHCuLj+iosEYiDL7b7BlcLBGB4D4Nv5zDOZyineBcId33kLT18++585zQcXE7jwE8y
 SUBZC8Yn19KIdIRShno2qWxIUbKxbYqm9hMFOWAWiUMvfSsmkvnZ5nYonQypD5qV84=
X-Google-Smtp-Source: AGHT+IHa4ShwKVgQ8aMPPQwtTPqrkBKL0itQfwAX0kgMhe99YcgHRUAStuYnBKQ51/Isn6SX2rGyoA==
X-Received: by 2002:a05:6808:830f:b0:3e6:5f3:f0d8 with SMTP id
 5614622812f47-3f19fdd1e38mr331284b6e.24.1737068496718; 
 Thu, 16 Jan 2025 15:01:36 -0800 (PST)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f19da7a23dsm413084b6e.20.2025.01.16.15.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 15:01:36 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH 3/7] configs: e850-96: Enable more EFI features
Date: Thu, 16 Jan 2025 17:01:26 -0600
Message-Id: <20250116230130.3337-4-semen.protsenko@linaro.org>
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

The basic EFI support is already enabled by EFI_LOADER. Follow
SystemReady IR recommendations [1,2] for U-Boot and enable support for
more EFI features. That includes:

  - CONFIG_CMD_BOOTEFI_SELFTEST: support for "bootefi selftest" command
  - CONFIG_CMD_NVEDIT_EFI: support for "env -e" to explore EFI vars
  - CONFIG_CMD_EFIDEBUG: support for "efidebug" command

Also enable RTC support:

  - CONFIG_EFI_SET_TIME
  - CONFIG_CMD_RTC
  - CONFIG_DM_RTC
  - CONFIG_RTC_EMULATION

[1] https://developer.arm.com/documentation/DUI1101/1-1/Configure-U-Boot-for-SystemReady
[2] https://developer.arm.com/documentation/DUI1101/1-1/Test-SystemReady-IR

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 configs/e850-96_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index d287018ec632..1cae252175be 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -14,16 +14,22 @@ CONFIG_DEFAULT_DEVICE_TREE="exynos/exynos850-e850-96"
 CONFIG_SYS_LOAD_ADDR=0x80000000
 CONFIG_ENV_OFFSET_REDUND=0x10000
 # CONFIG_PSCI_RESET is not set
+CONFIG_EFI_SET_TIME=y
 CONFIG_ANDROID_BOOT_IMAGE=y
 # CONFIG_AUTOBOOT is not set
 CONFIG_DEFAULT_FDT_FILE="exynos850-e850-96.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_HUSH_PARSER=y
+CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_ABOOTIMG=y
+CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
+CONFIG_CMD_EFIDEBUG=y
+# CONFIG_CMD_DATE is not set
+CONFIG_CMD_RTC=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_RNG=y
 CONFIG_PARTITION_TYPE_GUID=y
@@ -36,6 +42,8 @@ CONFIG_NO_NET=y
 CONFIG_CLK_EXYNOS850=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_DW=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
 CONFIG_SOC_SAMSUNG=y
 CONFIG_EXYNOS_PMU=y
 CONFIG_EXYNOS_USI=y
-- 
2.39.5

