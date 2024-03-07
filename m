Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90726C54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 11:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E90DA87DE5;
	Thu,  7 Mar 2024 12:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hJ2qrd/3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B06087DED; Thu,  7 Mar 2024 12:59:16 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9050E87DC1
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 12:59:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3651d6dea15so2578825ab.1
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 03:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709812751; x=1710417551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=moRsFY/q9IITCtAcRa72Wx2FyZfUOs9E8mFNy1WW3Qs=;
 b=hJ2qrd/3l8h5BetZDdyWX06TlvbhLU4tVAQ4irm1FhSSViEUL7gNhMRL2lGVuweZhR
 oOzvWmZBdhPbefQu1g+OdFIDdUSOJJ1PUGbXsmpl+CLZLWuWI2peRwgATEUq7JToWWJZ
 vGkz2CpAoOVOfqhLbovs9DbZkFNJQtoy2KM33IUfQephBdYBxCL7JSl/36dN/kDd1RoY
 Y2h96Ax+LgLo0UT5HONZFC4v4nHUyGf455jUvO0Y79EJKhZCJ7SYEAZfAOx7UxkvryzE
 gadxPm6HvKvN4aouf8Xop8geL79wwhPUCDC9Zd/4omAMaOIigXAgS2TduhUN7eWcKkgQ
 XFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709812751; x=1710417551;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=moRsFY/q9IITCtAcRa72Wx2FyZfUOs9E8mFNy1WW3Qs=;
 b=tKcb77fChfVinZ4VyrqZPgUgiFnLD6+7EF6UAVtvCt7lI1DnZrDuePvFJNqhckLt5U
 wiLnu6qjlZ0gsC6g+qlINA6yC3lJIMEDLsyYZ5b85MKLW4O3zCWVsFdGtt200usEluZ+
 8jc4pibbXw08sO+V4OUa7ws/kWPD5xdQBYfI4rIpxHUVhRzJ3xjd/kI0e6ApLVA5vqVH
 HwvkhjnX43hc4wjAoeKJNFG9EQUf9P7Blmg8/Re0RcnEFKBDIRtxuE+poShPzAMCXyYq
 4fRkYPJbsunWoUuKvm+XjmOYrFkMH92kxVKL4RWgUSXhA5RAq+vmrsXcViz88B02OjgI
 u5Vg==
X-Gm-Message-State: AOJu0YzjL/e6dnMFI8DMTW2R4rO6/2e+uEBhB4f92MFuCRpF1/6IWdYx
 dod7/SDlabLGIcSbLPy6GAR5ZnrmXu/m2fHKkoY1cRFSldZNFEjFVDA36342hzDQhg==
X-Google-Smtp-Source: AGHT+IFf9fCjoomKnBTgVOmW1C4y1nnklFA7CZwZIVLcFYRHY0EH5twGAMJpn7GsJLzepRk43sKhWg==
X-Received: by 2002:a05:6e02:20e1:b0:365:89a4:a7ac with SMTP id
 q1-20020a056e0220e100b0036589a4a7acmr818189ilv.11.1709812750553; 
 Thu, 07 Mar 2024 03:59:10 -0800 (PST)
Received: from aford-System-Version.lan
 ([2601:447:d002:5be:5af1:af30:8daf:fa4])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a92c104000000b00363da909ebcsm4161453ile.56.2024.03.07.03.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 03:59:10 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, festevam@gmail.com,
 Adam Ford <aford173@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: [PATCH] configs: imx8mp_beacon:  Fall back to using TF-A
Date: Thu,  7 Mar 2024 05:58:58 -0600
Message-ID: <20240307115859.22198-1-aford173@gmail.com>
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

When the board was originally added, it enabled some features which
allowed it to bypass Trusted Firmware, but as the feature set of
Linux grew and more features became available, the U-Boot config
options which bypassed TF-A caused issues, so it needs to return
to the standard operating mode of using TF-A or the system no
longer boots.

Fixes: ab53bd43dbde ("arm64: imx: Add support for imx8mp-beacon-kit")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/configs/imx8mp_beacon_defconfig b/configs/imx8mp_beacon_defconfig
index 29162ac9a4..9d09dd4a7c 100644
--- a/configs/imx8mp_beacon_defconfig
+++ b/configs/imx8mp_beacon_defconfig
@@ -14,7 +14,6 @@ CONFIG_ENV_OFFSET=0xFFFFDE00
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx8mp-beacon-kit"
 CONFIG_SPL_TEXT_BASE=0x920000
-CONFIG_SYS_HAS_ARMV8_SECURE_BASE=y
 CONFIG_TARGET_IMX8MP_BEACON=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
@@ -23,13 +22,8 @@ CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK=0x960000
 CONFIG_SPL=y
 CONFIG_ARMV8_SPL_EXCEPTION_VECTORS=y
-CONFIG_ARMV8_MULTIENTRY=y
 CONFIG_ARMV8_SET_SMPEN=y
 # CONFIG_PSCI_RESET is not set
-CONFIG_ARMV8_PSCI=y
-CONFIG_ARMV8_PSCI_CPUS_PER_CLUSTER=4
-CONFIG_ARMV8_PSCI_RELOCATE=y
-CONFIG_ARMV8_SECURE_BASE=0x970000
 CONFIG_ARMV8_EA_EL3_FIRST=y
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
 CONFIG_SYS_LOAD_ADDR=0x40480000
@@ -85,7 +79,6 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_SYS_MMC_ENV_PART=2
-CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
 CONFIG_SPL_DM=y
-- 
2.43.0

