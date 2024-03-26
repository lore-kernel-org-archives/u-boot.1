Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00022CD11DF
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 21:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6812887F9F;
	Tue, 26 Mar 2024 22:25:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nhwUX7lV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E48388035; Tue, 26 Mar 2024 22:25:08 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2796487F49
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 22:25:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-696147fb5a7so55584476d6.0
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 14:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711488304; x=1712093104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZvaFcS2zxRZuIwk/ZCPEXbBkBWlUvE1N6BCndZn9kS4=;
 b=nhwUX7lVkzFS1P47W/1s8TUmDH/N6pM7U7A8JOgQNVDuK9TbWrs0FDqovHkti/HKSw
 R7Yn7dCJU/t0KmUL4hl2PIMJVC7cuoPnd7nI7e8uh0EzRksQqY7GY4Nm07aauVm/tWTH
 D9+ZJmeRUv6O/lfH6OzjbPgo1p1w5CnqVx7VViQ36tiNwuPYkQwy0hKZzSxzfDeD5tFs
 LlI9waGRrowNe9lXkR7oK4H4i2lt7Pm42ThDMzO9k58fx7lSbmhPFAAHHhYbGG5KxiQl
 YzM6bTXJmxO6uZMgevw8nClUh5IGHk+ppZHEgs0idljaBKza6Rxe2PRW5NZ+X2LKLmpM
 PvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711488304; x=1712093104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZvaFcS2zxRZuIwk/ZCPEXbBkBWlUvE1N6BCndZn9kS4=;
 b=g8JcrR+el9ZzXXY2x8N66OWVrORNbxzD/vzk6F/Qf0Da/J0XodpCXYxSZMHoYiB/Z+
 148I5tFrzCBZYIeq327OVR7MsOFHxWrA+EJH9sj9SFzWWLgn6IUF9fSyt0WxDvAcbHSF
 8kxtNHFU9L4nlqLhbdY3RfDPD7GiSa9/NSWPP1N7cqOkLU0j+aR9+y6do3gQ3y8YGfyh
 ZjsiRalPKRZmfCK8oYaGi3mloikrdi6t+LnSsat0dFcqEiQTwNu4+mFOTvzHDNFY78De
 VcbitT9YWu6vVTJt0w+Pkw/tNrJSJS1jutzk6C+mPSZqqUmI2zDPN2ZgoUb0on02ykkd
 BLSQ==
X-Gm-Message-State: AOJu0Yz/j/r9/29WPX4ftZX9WPKRcU8RrfCQYP9KIvjLBCtwiCBq1ofl
 FzqTXIMVoq+IstduObTCN9WCiihWm5jBP8qya6KolnK6Xir2pQn5ZX/N2A65sOE=
X-Google-Smtp-Source: AGHT+IEpktkyw7hGr7Yxe0N8djybio2dyveriK3tXjCOs08IQ1wR7r3Ha9174zt8sLRkN4x1ewjmrA==
X-Received: by 2002:a05:6214:528b:b0:696:a324:cd04 with SMTP id
 kj11-20020a056214528b00b00696a324cd04mr1138880qvb.10.1711488304375; 
 Tue, 26 Mar 2024 14:25:04 -0700 (PDT)
Received: from aford-System-Version.lan
 ([2601:447:d002:5be:6f52:cf6f:a4b1:c71f])
 by smtp.gmail.com with ESMTPSA id
 j11-20020a05621419cb00b006968f5c34dasm2469361qvc.112.2024.03.26.14.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 14:25:03 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, sumit.garg@linaro.org,
 Adam Ford <aford173@gmail.com>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH] configs: imx8mp_beacon:  Enable PCIe NVMe drives
Date: Tue, 26 Mar 2024 16:24:54 -0500
Message-ID: <20240326212455.118772-1-aford173@gmail.com>
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

The baseboard supports and NVMe drives via the PCIe slot. This
requires a few extra config options to be enabled.

The NVMe can be enumerated with the following commands:

u-boot=> pci enum
PCIE-0: Link up (Gen1-x1, Bus0)
u-boot=> nvme scan
u-boot=> nvme info
Device 0: Vendor: 0x15b7 Rev: 20120022 Prod: 184960441105
            Type: Hard Disk
            Capacity: 122104.3 MB = 119.2 GB (250069680 x 512)
u-boot=>

Signed-off-by: Adam Ford <aford173@gmail.com>
---
Depends on: https://patchwork.ozlabs.org/project/uboot/patch/20240326202439.46707-4-aford173@gmail.com/

diff --git a/configs/imx8mp_beacon_defconfig b/configs/imx8mp_beacon_defconfig
index 0ae8c9645a..fe1678d8ae 100644
--- a/configs/imx8mp_beacon_defconfig
+++ b/configs/imx8mp_beacon_defconfig
@@ -15,6 +15,7 @@ CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-beacon-kit"
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_TARGET_IMX8MP_BEACON=y
+CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
@@ -27,6 +28,7 @@ CONFIG_ARMV8_SET_SMPEN=y
 CONFIG_ARMV8_EA_EL3_FIRST=y
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
 CONFIG_SYS_LOAD_ADDR=0x40480000
+CONFIG_PCI=y
 # CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
@@ -65,6 +67,7 @@ CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_SDP=y
 CONFIG_CMD_USB_MASS_STORAGE=y
@@ -118,8 +121,11 @@ CONFIG_DWC_ETH_QOS_IMX=y
 CONFIG_FEC_MXC=y
 CONFIG_RGMII=y
 CONFIG_MII=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_IMX=y
 CONFIG_PHY=y
 CONFIG_PHY_IMX8MQ_USB=y
+CONFIG_PHY_IMX8M_PCIE=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
-- 
2.43.0

