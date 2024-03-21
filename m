Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8785AC54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 14:56:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7818D8810D;
	Thu, 21 Mar 2024 15:56:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FkZCMC63";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FAD887F1E; Thu, 21 Mar 2024 15:56:25 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD9528810D
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 15:56:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dff837d674so8482595ad.3
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 07:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711032979; x=1711637779; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FQSdlyuHyjO3evVA1Zxr8iEviGz+bLT9UGQ9oBc3nSw=;
 b=FkZCMC63AB1Jm4NAvFFAuOWTbBAiI+OloTr0lPAKyrjSgSAW4GmHffHtQs0ESWskn0
 PWx+GdXsfB70wmiOT9ziY3SRZGzARgkgy1Axqk24rVRpvpCslwtiaUfCOrSYO442Xhh/
 oBFjFU95rlp+SxB7e33IDGL964yrNSqcEE6eoKl3E5gDZYFzkqvoTznYfVsgiRxBvAFi
 JMCZ7a7PFPiIICQeLIxLWWNoPUFpgonMAFo+IY+I4uCUvxziaFiouY44hHRBWFYNDvmS
 X7IsgH30OQVvrfbTECWD5ytF94Tp+7qEitOpzRc0tYoJQLq4Cfe3Fjh0omE5NcxzIh1c
 IAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711032979; x=1711637779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FQSdlyuHyjO3evVA1Zxr8iEviGz+bLT9UGQ9oBc3nSw=;
 b=HIVqAH521BbfoX7opsJgFmplmoH0vXygwNwvm1YHjGuDfPw6DkWUEpYEXYt96hqb2W
 qvRSJGdGzqidj9x1sU5XvVR9oXBDPUjjvL39CGgDiNleWcpKDzYBEKGoOk0OZFhc/xHW
 ShYH3ZPi6bcUbPTulVlLqPxICjQ1LrKl+IyiV/bJjWVeGh/KyQjD8Ii7812ouZtwGzJl
 yo6Max8rMj+77DlwQPUjbzsvhqMSWb2Hzo12xSECUwqhldAMGFX0ytR9UdOmy3e45mxV
 qqzfNY5CoqZytwJ9iIZ+KmuD7RzKRUJMDqvBWYf6/K1cqUVAEQLpjtVzDXHFj/83D/Hu
 ewGg==
X-Gm-Message-State: AOJu0YwXdjG27U68tabzGLto4+KwGjEU5WdbpWjbntCiqdeYBhiwDNiS
 EG/UQoFyJz/rCgNuprwlWZwV/IlvcK5x5coxhKBJ0US+R26Zr0ZiH6lP/SHLcbaqjHMwsD8Xi1E
 n
X-Google-Smtp-Source: AGHT+IHCUsgWaM2xJxs3FjOTsrhqAdWtWmAu9zShFl6go8MIXpkWQ2sSHd+RKXNZRBWUf0ukOe+ZTg==
X-Received: by 2002:a17:902:7847:b0:1e0:2335:8f68 with SMTP id
 e7-20020a170902784700b001e023358f68mr4636036pln.26.1711032979710; 
 Thu, 21 Mar 2024 07:56:19 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.159]) by smtp.gmail.com with ESMTPSA id
 j9-20020a170902da8900b001dddb014624sm11751668plx.54.2024.03.21.07.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 07:56:19 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, pbrobinson@gmail.com,
 Sumit Garg <sumit.garg@linaro.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v4 09/11] verdin-imx8mp_defconfig: Enable PCIe/NVMe support
Date: Thu, 21 Mar 2024 20:25:05 +0530
Message-Id: <20240321145507.619448-10-sumit.garg@linaro.org>
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

Enable PCIe/NVMe support. Also, enable the reset driver which
is a prerequisite for PCIe support.

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 configs/verdin-imx8mp_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index 7ac5e65642c..b6194404baa 100644
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
@@ -76,6 +78,7 @@ CONFIG_CMD_FUSE=y
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

