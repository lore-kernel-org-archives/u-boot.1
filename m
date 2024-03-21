Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87B8C54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 14:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC16C880FA;
	Thu, 21 Mar 2024 15:56:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KnqJKuGG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B384F880FE; Thu, 21 Mar 2024 15:56:31 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2A3C880FA
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 15:56:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1deefb08b9eso6706885ad.3
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711032986; x=1711637786; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DPOk29tp9hSaHHd7ex7d+x3CJBUfHDyKeW57FXsBWGs=;
 b=KnqJKuGGSjbFAZ9B4S0C2able35B2HzPEaXUJLMuU0IYJ6qvdH1IcOqOX7Nrd2H9P/
 DBvVTEU/sJDLGoU30PdF+80H1h4U7AVQjSjetlRex8I47ishpks6suXNtbMKgsq97OW5
 PdymfvforKaUIIwESAxDmtrfPlJwRPezYxeP+UpuJNBYt2A8aQQUjXBfDxMq++1gvztQ
 HmcFas1/vYRQ+cPX0JocCGiyE76YF59mLVJj8PTteRP/7+qYI0NDfwsBk8SgdGWsipWr
 VUq4fNx/1tuvcwpoJFpr/cBuYl45i+eF9ndbXn0d2Zhc2YYu5cNzCLfWFC547nOvJeSC
 jLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711032986; x=1711637786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DPOk29tp9hSaHHd7ex7d+x3CJBUfHDyKeW57FXsBWGs=;
 b=At5Jpuep5y4u6L6mYIvc2Kv9qjOzBZOmSzBEhqWEMCV3nSIk1O02URw0ZS0JZ+x8/q
 Esj5ORQHgaP7w3mP47HEdG3dOuTl24IGGDED+g44IwSKX0QyT+S24aMxiqbuspSL7Tp+
 m722OnMMAzYYKQVQMor5e4SN4+eGdKAF3ZDnv3pqq12YMlTrTNLsz2yJ1HnZ9fwrlSYa
 NyKe7ECdEVLdXZ9b5FTsAyroZrxvZvRu8i/xW73oIISpt0ZI1aGgMhODNk1DwjGLAHjM
 IL+l8JFYTzfsZC7e05HIe6kH+WgVWlhWSnnkJnylIWqr2C0BA02ofjq7kF0X+dzNn5Tk
 u9wA==
X-Gm-Message-State: AOJu0YzexyDAd6I1F/wKiwYL9GknnXGxGPg4ijVYJpHIfRdudcmjYMr/
 xMwHS410uIDQ5QPcjKv3N9MNbS+P/As+/kQ8zhyW2xy++/IHemi/hmCFl3XHqcejYuffsWinwGS
 W
X-Google-Smtp-Source: AGHT+IFN5gxfQaBn9GNvvUZ7xBY3s4olLW0lNFJHOTmVmEuAxmItAj2/SzjdcQqJP8FqxEYRSgrOiA==
X-Received: by 2002:a17:902:c949:b0:1dd:819f:9503 with SMTP id
 i9-20020a170902c94900b001dd819f9503mr10750524pla.12.1711032986220; 
 Thu, 21 Mar 2024 07:56:26 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.159]) by smtp.gmail.com with ESMTPSA id
 j9-20020a170902da8900b001dddb014624sm11751668plx.54.2024.03.21.07.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 07:56:25 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, pbrobinson@gmail.com,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 10/11] imx8mp_venice_defconfig: Enable PCIe/NVMe support
Date: Thu, 21 Mar 2024 20:25:06 +0530
Message-Id: <20240321145507.619448-11-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321145507.619448-1-sumit.garg@linaro.org>
References: <20240321145507.619448-1-sumit.garg@linaro.org>
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
[SG: rebased to next branch tip]
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 configs/imx8mp_venice_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configs/imx8mp_venice_defconfig b/configs/imx8mp_venice_defconfig
index 501ccb0ba8f..6e4addc7728 100644
--- a/configs/imx8mp_venice_defconfig
+++ b/configs/imx8mp_venice_defconfig
@@ -12,6 +12,7 @@ CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-venice-gw71xx-2x"
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
 CONFIG_FIT=y
@@ -63,6 +65,7 @@ CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
 CONFIG_SYS_DISABLE_AUTOLOAD=y
 CONFIG_CMD_CACHE=y
@@ -84,6 +87,8 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_BLOCKSIZE=4096
 CONFIG_SPL_DM=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_IMX8MP=y
 CONFIG_GPIO_HOG=y
@@ -112,7 +117,10 @@ CONFIG_FEC_MXC=y
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

