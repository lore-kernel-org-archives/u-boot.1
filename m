Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589E7C54E66
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 07:05:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 090F187F50;
	Tue, 12 Mar 2024 08:04:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dZiIIDvY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A06F087F4F; Tue, 12 Mar 2024 08:04:57 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 741AA87F70
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 08:04:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dd6198c4e2so36368915ad.2
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 00:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710227092; x=1710831892; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U6WtT0I6JDyowZ/GlxxV1QCKvD+alAjN3Li8P43gCTc=;
 b=dZiIIDvYzrWmRZKtiEGAGJAl/BkycPP3odvXUXSyitCZoSogahmIGi9Oqn1McIULZ4
 wy+A6MsJPYHvtoPTp8HDMNI6HMPnPsiMWavQgdGa2+Vz+BJXbWmuwyXlTj5ITC2g/b+j
 dGd6hNg2TzfX08LKhK6hgo/bL53UilYA71qx9nHQ+WO/BbigozgQwb2m3BKtHquzN4Hs
 DbTza00zCl0kP2X1QvStoipvgfVe7X+PJIjWk5b7i2Hd1Fz5CkhVc6i01Ple+/1dLuWO
 dFtBN9STPT40amrEMwgxzKVn4tsnAWENHZjY3pIWUeLpLur8a/nZOWpnSXZcW4l8Eh7X
 FqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710227092; x=1710831892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U6WtT0I6JDyowZ/GlxxV1QCKvD+alAjN3Li8P43gCTc=;
 b=aKvGDMiGGe44vxbSNhOL/+pFK/m4zmCQTpum3sqgvuSkmyb90KinpFjNJuHARQRrYM
 fekm3foff2ToeuqB9A+JDa63GKqoJXPBGGh3TqDu4YQPmkSREaGF+u0zPcCEkMbOxb4d
 o/tn4e7yA1ve2M3tIhkqWhm1rieKAdX9v1Y8ifoyRpPePM4A3BvsKFUyWZpz3N8Codfj
 ztYgIoEMwdYJEEXPLpUTKhuVP7ov7qhtqm5NIv+2r3CX2vtPPZ7nrvs7HuIUYiYHgZBf
 +OuaAGNuGBblnpdwVFKWkNdnZWxqFETV9MPonrumOt1DT6M8Qbibel2yX7fVSI1WWr2O
 C4rg==
X-Gm-Message-State: AOJu0YzjYcjlZIZgTaEdli2O7eC+uXkX1jWFUJ/322TY2fv6Y0N6Bh7G
 HAlZnR3WEcyAit6XnqoKnzKNcZqor9zFFj8YzZpUt4Ro9uajeQJMnvjIhkmAW67Y+HLEjQZYkHg
 c
X-Google-Smtp-Source: AGHT+IE47k3swpFZSpQG+IDw2oTJnU06afw75Aqd4iB9NvhP7iDIMYNE0dpPAsIgDLQ/V89nOS3AIw==
X-Received: by 2002:a17:903:2342:b0:1db:fa72:25eb with SMTP id
 c2-20020a170903234200b001dbfa7225ebmr11012046plh.52.1710227092565; 
 Tue, 12 Mar 2024 00:04:52 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.249]) by smtp.gmail.com with ESMTPSA id
 e13-20020a170902784d00b001dd0d0d26a4sm6045401pln.147.2024.03.12.00.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 00:04:52 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
Subject: [PATCH v3 10/11] imx8mp_venice_defconfig: Enable PCIe/NVMe support
Date: Tue, 12 Mar 2024 12:33:37 +0530
Message-Id: <20240312070338.86127-11-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312070338.86127-1-sumit.garg@linaro.org>
References: <20240312070338.86127-1-sumit.garg@linaro.org>
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

From: Tim Harvey <tharvey@gateworks.com>

Enable PCIe/NVMe support. Also, enable the reset, regmap and syscon
drivers which are a prerequisite for PCIe support.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 configs/imx8mp_venice_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configs/imx8mp_venice_defconfig b/configs/imx8mp_venice_defconfig
index 11b356b7785..ff7ea9811ed 100644
--- a/configs/imx8mp_venice_defconfig
+++ b/configs/imx8mp_venice_defconfig
@@ -12,6 +12,7 @@ CONFIG_DEFAULT_DEVICE_TREE="imx8mp-venice"
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_TARGET_IMX8MP_VENICE=y
 CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
@@ -21,6 +22,7 @@ CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x3f8000
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
 CONFIG_SYS_LOAD_ADDR=0x40480000
+CONFIG_PCI=y
 CONFIG_SYS_MEMTEST_START=0x40000000
 CONFIG_SYS_MEMTEST_END=0x80000000
 CONFIG_LTO=y
@@ -65,6 +67,7 @@ CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
 CONFIG_SYS_DISABLE_AUTOLOAD=y
 CONFIG_CMD_CACHE=y
@@ -86,6 +89,8 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_BLOCKSIZE=4096
 CONFIG_SPL_DM=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_IMX8MP=y
 CONFIG_GPIO_HOG=y
@@ -114,7 +119,10 @@ CONFIG_FEC_MXC=y
 CONFIG_KSZ9477=y
 CONFIG_RGMII=y
 CONFIG_MII=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_IMX=y
 CONFIG_PHY_IMX8MQ_USB=y
+CONFIG_PHY_IMX8M_PCIE=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
-- 
2.34.1

