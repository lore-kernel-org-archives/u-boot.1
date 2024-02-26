Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185C4C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 08:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55AA387EE0;
	Mon, 26 Feb 2024 09:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eLpMcBU6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B41187EB9; Mon, 26 Feb 2024 09:06:00 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9F0887EB9
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:05:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e46db0cf82so1736711b3a.0
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 00:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708934752; x=1709539552; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ge5B7uN7JrSnKeLnBLux1fdk9dyE06ytKyVUm32lr80=;
 b=eLpMcBU6YMMxJadLMnsHhCVmzJ6fT+f+i9PHDbtLD3gitudnlAPDCtj5AVC2pIr3+t
 QK4JDtcAi2/e2k7kQQpgqu/0EXscn34TUy6QfWZZat72iiqgPZLfwRBoOzl+ubM4gXI0
 Fdu74KmtZIHgXbrJ5fNGqAhhfa5FAG1xbSHqeHz3r4vKWhWsTPcAgCym/8oII3uAPi6m
 9qBhKvi4aCGJdzRCAgUUP08Xab75fD0IyJIlW31+2DujMa5mVIkvqEKpuYyTBpudA/Sj
 6IgsKOFy8Ns5av8AROgE4PHmXjk5QtJFR7EPDRFKvKPTRzVDzStmWBFwk7UMWVhwji/e
 doJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708934752; x=1709539552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ge5B7uN7JrSnKeLnBLux1fdk9dyE06ytKyVUm32lr80=;
 b=YyN8ZsjabxBjwr7pUQYx4g3lHVAmNLT3AThNvjUFNDnSMJdKE5VMEbjjMGaYTikvzt
 OoB/DGlCSL9v18OBVqzmhSCvJ98Vgzduls+mc02AC8egVLTxACu5QvjChT3onBInwwIO
 1xNy5ZacmCGQzdEHYpVQecuag7F0vRJ/eNYcQWYlVtWqv2rX7Uvx7xEmtpeNSQkLiYQn
 KsGEBZdpf1j5i2aUwXR6xsBuZO6HNM5EDXZClNx2ZyS1Yd9zW3FnecwB9skTx+GsWtlN
 YokjshyRavaIcjnrQayiKSbozVrgli7ZlHEx+lFHU7ExmOgbR7PfpFhX0JiP36eWv0WF
 AyHA==
X-Gm-Message-State: AOJu0YzsZwtIN+bXc1bvxRtuCAvB7yCewwiW+qn4q1nS+bNt5PsOS0Wb
 d4+OO+tfoQeQJL3eiYlqrkZHsGDuoqiWZIx7zNIkhKa4Dty4cTIPSFBvS8Npl8kPLAsR0CMBO9A
 X
X-Google-Smtp-Source: AGHT+IEXdnmG3EIpTynP3CZujT+ggyF31/SqCoHwozKECk/7yVpIkXUs2CVx7yCymD1fbSNBa1ev3g==
X-Received: by 2002:a05:6a20:c908:b0:19e:c777:5c61 with SMTP id
 gx8-20020a056a20c90800b0019ec7775c61mr7274147pzb.22.1708934752432; 
 Mon, 26 Feb 2024 00:05:52 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.32]) by smtp.gmail.com with ESMTPSA id
 k2-20020aa788c2000000b006e13a88d52esm3392842pff.61.2024.02.26.00.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 00:05:52 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, francesco@dolcini.it, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, marex@denx.de, ilias.apalodimas@linaro.org,
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 7/8] verdin-imx8mp_defconfig: Enable PCIe/NVMe support
Date: Mon, 26 Feb 2024 13:34:32 +0530
Message-Id: <20240226080433.3307154-8-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226080433.3307154-1-sumit.garg@linaro.org>
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
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

Enable PCIe/NVMe support. Also, enable the reset driver which
is a prerequisite for PCIe support.

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 configs/verdin-imx8mp_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index 22b8a334dfaf..fefadb344f8b 100644
--- a/configs/verdin-imx8mp_defconfig
+++ b/configs/verdin-imx8mp_defconfig
@@ -16,6 +16,7 @@ CONFIG_DEFAULT_DEVICE_TREE="imx8mp-verdin-wifi-dev"
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_TARGET_VERDIN_IMX8MP=y
 CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
@@ -26,6 +27,7 @@ CONFIG_SPL=y
 CONFIG_IMX_BOOTAUX=y
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
 CONFIG_SYS_LOAD_ADDR=0x48200000
+CONFIG_PCI=y
 CONFIG_SYS_MEMTEST_START=0x40000000
 CONFIG_SYS_MEMTEST_END=0x80000000
 CONFIG_REMAKE_ELF=y
@@ -77,6 +79,7 @@ CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
 CONFIG_CMD_READ=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
@@ -145,8 +148,11 @@ CONFIG_DWC_ETH_QOS_IMX=y
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
2.34.1

