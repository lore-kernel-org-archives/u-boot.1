Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAE1C54E66
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 07:05:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E24D87F6A;
	Tue, 12 Mar 2024 08:04:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cZW6sj0m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 810C487F4E; Tue, 12 Mar 2024 08:04:52 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C499887F58
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 08:04:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dd10a37d68so44486285ad.2
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 00:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710227087; x=1710831887; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lfWJG7zDQD7Ni2HMoxnaG0e75q8Drv3ck3rXE8CMIig=;
 b=cZW6sj0m+KYDbD+ewAdcodCr9qhMjPanQrr1Yhg06l89fi/OmA8P+ts4NEKc5sstF6
 kfNlzI+qg/CRaEDdgCyCcF8GJveor4Ev/c3pdW47x+bzDju32x4jUxUuZ6WCIax13wtU
 tdRApHUHsDAekzZ+nxz1iWgEd9YdxzKaVQ0+XlBrZ85tDvjcFck4rfC4wbeyVOzvYJtz
 FCZut2LREtwm0VqaFhEgP70ew7APmca4jT/rsiW6R8z7tgCuJf1CdZyfcXkbFMSiL00J
 XH/sAKahAgv4xvHgnWQGHpn1MNCVupf6vHxQ8IxS75rfjbtuj3BKYnNXUR2HlXmfHnkv
 rqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710227087; x=1710831887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfWJG7zDQD7Ni2HMoxnaG0e75q8Drv3ck3rXE8CMIig=;
 b=T0I+s6EI1fo4h1zpE2qzPJ0rFawvRxODUSSsFW/xySufxFUnGqaW86ydZfs1VEMx/R
 wN4qgflHcqiq/ArR9rVEFMtY5+zVrjzOMtSDC0a6TE4b0zdIS2MqdqBwe2lBOaoydo3U
 ABu/zuqlfzWejTGjoGZzp55JfFAVglJiKJxsZDokwgyIyyt/wB+V7w5+J2HYPIUj+219
 OmsBEto5fTi2ECVVbXOHmmfo4eyNLxhOESWJNMaxPnsbHdogcTRXO9R783Bf93LjmjZ0
 1Iv75lT/tZAQPBelCUPMg1enmPGT2BTYBlytBijdt5mwH2iVimRNrtEQxpraQruiH8SI
 IdQQ==
X-Gm-Message-State: AOJu0Yw2Z9GPGd69gzYW3AWe1+UiH9RUUErW3CI5FVoqFezWVJnTDNkr
 V23og3o+xJXLKds8Ez2xqFIkUzpuqGynCGey0q+m0bsJW6ToBwlebLxQ2+QCfpRiJTtouBqhto9
 g
X-Google-Smtp-Source: AGHT+IHV6kgmbCIf2z/mUFuVvNtOmROGLCtHeubs+YmyaRkLH6J1NfoEG37qC5USxjzphIeRVE7zGw==
X-Received: by 2002:a17:902:f806:b0:1dc:7bc:cb49 with SMTP id
 ix6-20020a170902f80600b001dc07bccb49mr6997851plb.60.1710227086894; 
 Tue, 12 Mar 2024 00:04:46 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.249]) by smtp.gmail.com with ESMTPSA id
 e13-20020a170902784d00b001dd0d0d26a4sm6045401pln.147.2024.03.12.00.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 00:04:46 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v3 09/11] verdin-imx8mp_defconfig: Enable PCIe/NVMe support
Date: Tue, 12 Mar 2024 12:33:36 +0530
Message-Id: <20240312070338.86127-10-sumit.garg@linaro.org>
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

Enable PCIe/NVMe support. Also, enable the reset driver which
is a prerequisite for PCIe support.

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 configs/verdin-imx8mp_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index 22b8a334dfa..fefadb344f8 100644
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

