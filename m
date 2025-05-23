Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D457C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CDF08369D;
	Sat, 24 May 2025 01:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MR929wRQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11C7183340; Sat, 24 May 2025 00:59:32 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C79D78342C
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so374742b3a.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041168; x=1748645968; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJn1iAakwrEYwx6wSi68vq6+jgdZXkZq1snPVXS9NlU=;
 b=MR929wRQVaK/Q8vxJPicEpA66vMwRpiE5FqCM2QItsKl73JGOclzN7yrcwKlhq8/mf
 JXGgbmNkE/GdxKK4ijT0VHbaB3a2JAcaRXv9EatqlOPLiPwk6jxr3fo5MKaRvv0TKAWM
 HGoN8qiFCdgnQ5WUdSMTQnPvHOPqfK6NBEGf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041168; x=1748645968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TJn1iAakwrEYwx6wSi68vq6+jgdZXkZq1snPVXS9NlU=;
 b=n2RY3GTrSl7Tk54VMI/Ue2w5M2o4TTFZCV3Dfawge0bFdTobJwXfNwxEsHO3eCXMai
 0XXvvCxKSOg7Zoc61vFFWR1HLNH6vmS0Zx5TXciM6CTb2YG/pKFYBQoR5okSZ5r1/PIm
 gzQFfdPJteUrh7ALpU+RT6VMUFCWiWdTtnOvoQdQF96XVs66deXRQ6JZEPRdO6a7F8T5
 EwWPbRu7UmpEd+B7oiNNjZEPLu/06sKFJFAgETXbu9APZ3xQgq3YBCbwnjCg4mH9b+kc
 khZPZirYJIpifcn3Ud8fGad+Cn5VyiTIykxfcurxfFD19uK9R9SbzmEsv/bXFIjX1AGN
 Xarg==
X-Gm-Message-State: AOJu0YzjYg+qOw7VkOzx1AqJ4ZmUOUE8+MeoF4d1XZZ9VOinHvtyUymn
 JP8E4aPEzBlF3eepFz2A0Q2oGbec6WxJsWOI6z778q+oNFNNX7Owim3l53NxXVb+6uBrslS0M1C
 E/oE=
X-Gm-Gg: ASbGncui9lXHwDXJH06u+vO2Gf66CPeBkHXwjCLOBwQWXxFUlNeOkLw3sWmcGnmSBfR
 whEzeERZcoqOG8MSPqdjxdajfeVKoDLa0fpTog9VILztGVNZB8Mfrxf8FxjFuebXyHmWPFxfxzB
 zRAJ4DEeaMRpQP660U+byJJU+dG5R661WxETzD025r9pSIh+yTM9L1EhphOA0wg1XMN2CNDCHdG
 KUyaLWAH3f7BY3UKIkneaObyMm1kNo1M01yQhlsv9XtsSxrOFHpYMe15oGCUyV692Q63+8TAYoc
 xQE11Xe3STG5HLlUkHQgK2N7+Nx3p6zdAr5PadGi9NhDepbYAyHapjDJYOFekpICzhInN/Jl2eG
 Lsp/vYaSXDuyC1Dw=
X-Google-Smtp-Source: AGHT+IF2ygTRXh6KMiMTioFqzjdqdVOkXKXyO+AIErTQmRlrVu26HlJ0WFr5pXepeDSP9UzvOs0hSQ==
X-Received: by 2002:a05:6a21:1799:b0:1f3:418c:6281 with SMTP id
 adf61e73a8af0-2188c1917e8mr1573945637.4.1748041168123; 
 Fri, 23 May 2025 15:59:28 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b26eaf6ffdbsm11487228a12.20.2025.05.23.15.59.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:59:27 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 27/28] configs: Add chromebook_trogdor defconfig
Date: Fri, 23 May 2025 15:58:42 -0700
Message-ID: <20250523225845.2311989-28-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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

Add a config that boots on Trogdor Lazor devices.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 configs/chromebook_trogdor_defconfig | 138 +++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 configs/chromebook_trogdor_defconfig

diff --git a/configs/chromebook_trogdor_defconfig b/configs/chromebook_trogdor_defconfig
new file mode 100644
index 000000000000..c90dc946494c
--- /dev/null
+++ b/configs/chromebook_trogdor_defconfig
@@ -0,0 +1,138 @@
+CONFIG_ARM=y
+CONFIG_SYS_VENDOR="google"
+CONFIG_SYS_BOARD="trogdor"
+CONFIG_SYS_CONFIG_NAME="qcom"
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_TEXT_BASE=0x80c00000
+CONFIG_SYS_MALLOC_LEN=0x4000000
+CONFIG_NR_DRAM_BANKS=32
+CONFIG_DEFAULT_DEVICE_TREE="qcom/sc7180-trogdor-lazor-r3-lte"
+CONFIG_SYS_LOAD_ADDR=0x80000000
+CONFIG_REMAKE_ELF=y
+CONFIG_SYS_COREBOOT=y
+CONFIG_EFI_RT_VOLATILE_STORE=y
+CONFIG_EFI_SCROLL_ON_CLEAR_SCREEN=y
+# CONFIG_BOOTEFI_HELLO_COMPILE is not set
+# CONFIG_BOOTEFI_TESTAPP_COMPILE is not set
+CONFIG_FIT=y
+CONFIG_FIT_BEST_MATCH=y
+CONFIG_BOOTSTD_FULL=y
+# CONFIG_BOOTSTD_DEFAULTS is not set
+# CONFIG_EXPO is not set
+# CONFIG_BOOTMETH_SCRIPT is not set
+CONFIG_BOOTSTAGE=y
+CONFIG_BOOTSTAGE_FDT=y
+CONFIG_SD_BOOT=y
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_STOP_STR="!"
+CONFIG_AUTOBOOT_KEYED_CTRLC=y
+CONFIG_AUTOBOOT_MENU_SHOW=y
+# CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
+# CONFIG_USE_PREBOOT is not set
+CONFIG_LOGLEVEL=9
+CONFIG_CONSOLE_FLUSH_ON_NEWLINE=y
+# CONFIG_CONSOLE_MUX is not set
+# CONFIG_SYS_DEVICE_NULLDEV is not set
+CONFIG_LOG_MAX_LEVEL=9
+CONFIG_LOG_DEFAULT_LEVEL=3
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+# CONFIG_CYCLIC is not set
+CONFIG_HUSH_PARSER=y
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_CMD_VBE is not set
+CONFIG_CMD_BOOTMENU=y
+CONFIG_CMD_SHA1SUM=y
+CONFIG_SHA1SUM_VERIFY=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_LOADM=y
+CONFIG_CMD_MBR=y
+CONFIG_CMD_MISC=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_BKOPS_ENABLE=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_READ=y
+CONFIG_CMD_SPI=y
+CONFIG_DEFAULT_SPI_BUS=6
+CONFIG_CMD_USB=y
+# CONFIG_CMD_CLS is not set
+CONFIG_CMD_PSTORE=y
+CONFIG_CMD_PSTORE_MEM_ADDR=0x0
+CONFIG_CMD_PSTORE_RECORD_SIZE=0x40000
+CONFIG_CMD_PSTORE_CONSOLE_SIZE=0x40000
+CONFIG_CMD_PSTORE_FTRACE_SIZE=0x20000
+CONFIG_CMD_PSTORE_PMSG_SIZE=0x20000
+CONFIG_CMD_BOOTSTAGE=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_LOG=y
+CONFIG_PARTITION_TYPE_GUID=y
+CONFIG_OF_LIVE=y
+# CONFIG_OF_TAG_MIGRATE is not set
+CONFIG_DM_WARN=y
+# CONFIG_OFNODE_MULTI_TREE is not set
+# CONFIG_SCSI_AHCI is not set
+CONFIG_CLK=y
+CONFIG_CLK_STUB=y
+CONFIG_CLK_QCOM_SC7180=y
+CONFIG_MSM_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_I2C_CROS_EC_TUNNEL=y
+CONFIG_SYS_I2C_GENI=y
+CONFIG_CROS_EC_KEYB=y
+CONFIG_MISC=y
+CONFIG_CROS_EC=y
+CONFIG_CROS_EC_SPI=y
+# CONFIG_MMC_PCI is not set
+CONFIG_MMC_SDHCI_MSM=y
+# CONFIG_ETH_DESIGNWARE is not set
+CONFIG_PHY=y
+CONFIG_PHY_QCOM_QUSB2=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_QCOM_SC7180=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_PWM=y
+CONFIG_PWM_CROS_EC=y
+# CONFIG_SCSI is not set
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_CONS_INDEX=0
+# CONFIG_COREBOOT_SERIAL is not set
+# CONFIG_SYS_NS16550 is not set
+CONFIG_MSM_GENI_SERIAL=y
+CONFIG_SOC_QCOM=y
+CONFIG_QCOM_COMMAND_DB=y
+CONFIG_QCOM_RPMH=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_SPI_GENI_QCOM=y
+# CONFIG_DM_USB_GADGET is not set
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_RTL8152=y
+CONFIG_VIDEO=y
+CONFIG_VIDEO_PCI_DEFAULT_FB_SIZE=0x1000
+CONFIG_VIDEO_MIPI_DSI=y
+# CONFIG_SIMPLE_PANEL is not set
+CONFIG_BMP=y
+CONFIG_VIDEO_BMP_GZIP=y
+CONFIG_BMP_16BPP=y
+CONFIG_BMP_24BPP=y
+CONFIG_BMP_32BPP=y
+# CONFIG_RANDOM_UUID is not set
+# CONFIG_SHA256 is not set
+CONFIG_ZLIB_UNCOMPRESS=y
+CONFIG_BZIP2=y
+CONFIG_ZSTD=y
-- 
Sent by a computer, using git, on the internet

