Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC781C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 09:45:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E150882B18;
	Mon, 16 Jun 2025 11:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IlTifA9b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94F1E82B00; Mon, 16 Jun 2025 11:44:52 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2B7A82063
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 11:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-450cf214200so36798185e9.1
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 02:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750067090; x=1750671890; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7QzpiWvKP6Hu/G7sTJLlLUUn844Qvlz9QBHGPpwFtPs=;
 b=IlTifA9bDnmXCnIRtBN2kciGJmb6PWqfy85jIyic0QDwlh7xMyuyBMJfX59Avtr6E/
 pSl9uBUE/rYEqhD38D4v9C153G1zfmbUglfzPCGhgr7o8do82kxFsI4R/ZW8S9IaDuHF
 bkBeUpHGRg4+Sb/fpp8naiH1Z2ZMs2bD9QInNinJYg5/g2fA72HyqVAspcxoXy4fnaMJ
 P6Vows5CFWjLTgv+KGFEVx0wEgAqUre7lC6f/NrtfjHW1S5IQWQuGk1OF/WgtRqiMpiX
 MHjGiVFct6/AoNowv0U8P8gobGOad2dMXRHzlZ0cZcZR/D8ibNkJB0jy+w1eLXWPdrJg
 2pSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750067090; x=1750671890;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7QzpiWvKP6Hu/G7sTJLlLUUn844Qvlz9QBHGPpwFtPs=;
 b=BLnjK4sMZwg4Duh+0nt67zHQxo5XJxqZsQBwgTZe96oKqZHppjbGwni0KW5lUFYkwu
 mdH249xwc8xpR3oKJxXmDjt0qsSFkZrQpNDTRp7DKoo2JkTxdSUV1zWRqjF7sTQ5w4ln
 +O4MevMDLjJ16Pn7xZZ3SYqttCxABCjKNof3HsDx5abrQAX3cLV73xdKi94H20QCi8Ba
 av1XP6OfWhZ2abdQiEWUrcnILq7iOLZPsZ33sCJ1iO4RnVDsTizBJ8Ergfw6GrLC/cyE
 RtuHUD9HqMGQL1iqoG3wZKR0O3/baFRW8vLR7SrRRSnusBS5rkPYJJuG2zpR+lk58+b4
 CnHw==
X-Gm-Message-State: AOJu0YyqHjfTq8FZRjzl2dNQXKLqlyvvXnSJkVC98xT6x2DaWWYMKb5t
 1ORT6tStwUWQN0DnBGjY+xYmxv7c0uReVfswmgzi9YP/IZjdc4LE7e7US/wb3IukEFM=
X-Gm-Gg: ASbGncsc52Y8hyS//jqAHUdb7yUeAW474Syunl+1Ikad/I+EGJUofnniEXPYVm12sLk
 k3Lk9oNhUi2tfmu9OP7yK0K6J1JRo5zbwM2YemeN/Wyl8UFIGTgZuJ4LEFn2UrQLQPpshhG0/Su
 770pEJDLFAPMdheK09k0VUXt4bSVy65qbwCkZdr52RUei808bev8motZhaxUEv1QyKrvlpKAfJ1
 nYT5oeOTYIzTkDgoKHrQrz4Qu2cFKAZdp9N58H/WkXGZp8eY7dB6FR3I0/f80mqN94qE9FlP7Yt
 Mng7GAKpSEODkNwMNrO3DcrxeKVkakCHukF9HSai+D2U8GiOPecNZHdDo1+PYVKoked+CV7T5Xj
 nGpeH
X-Google-Smtp-Source: AGHT+IGK+6zA/UE5HXPEDx9ZzfH+DjL9e5G1BJMk1QSgVJTb1j7z030ppxHQqIzyhHX4ba83OfLmFg==
X-Received: by 2002:a05:600c:6303:b0:43c:f87c:24ce with SMTP id
 5b1f17b1804b1-4533cab8e9cmr63299505e9.21.1750067089997; 
 Mon, 16 Jun 2025 02:44:49 -0700 (PDT)
Received: from toyger.localdomain ([213.240.182.76])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532de8c229sm139308105e9.6.2025.06.16.02.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 02:44:49 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 16 Jun 2025 11:44:43 +0200
Subject: [PATCH v4 1/9] configs: run savedefconfig on
 qcom_ipq5424_mmc_defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-geni-load-fw-v4-1-e7df44205505@linaro.org>
References: <20250616-geni-load-fw-v4-0-e7df44205505@linaro.org>
In-Reply-To: <20250616-geni-load-fw-v4-0-e7df44205505@linaro.org>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3455;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=DuauTFgIp9Tnr1otBmJ9x3E6yLrgsQgQdVIBnjkhz0Y=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoT+eNKELwFZeghUWzKGJUcnDFl2g5OKvjmNDUv
 a2CuG5NGI2JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaE/njQAKCRAFgzErGV9k
 tqnzD/9md8c6tag171UBq9+OVNVThXBicnwl+gBCCqA2Ffcq9B45HzFzeiUZiXgpOGSH4BW12Nw
 b5Q9MfqFkSChctEZfZcjvQz8d621ml08v5JLaDx/C6z1XhdFiYQZ63tB43hVWFA68Gq3d+Ime3g
 w/1ixoDeElaCAWBeOrsMgxk/k58n6cVgmT75D8LNwYowxlbXD6avJarcN0tYPUGDttbq22KUv3w
 32dABptmzJlacPAwvyAfKybs3F3EK5wdaJ6vuITDCgMuGE/mnoE+rL+5O1R/vXhaqEtgku0MHxA
 6swuAibOEAY0FkO9qdIIm8neb0bkFuXv8v+Hma0BUaAp7Z10GtPDv6glHryMWAGwynFQlvy60Ca
 iEuLyrov0SdrkdJBfF2DHMZa34MRC5TwYtLe2Bmj4SstkjomirvvOm8AS4LQGqD1R14DpLGlc7x
 +6/HM3pN2PAq8wHpvLFRApOClz0r/px6Z05LrKA+yX7y1UfFaGIT59OukQXDdRbCypljkBNEd71
 2qY+OpEt6tT461EjeNv5tj7oF9mpSRR3KeaKpyqLJVQScaSjaC+y1B1fARJCE8RQQ3EbnPtecjB
 wCRdo26NbxDbE2hOT/py4UhdTNKsH/FmIVqaz0DOtxAWF18s6SaWCm3R7LTd5ZDNDG0ZTsfH/j8
 8hy/fPpvicUJy5Q==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Regenerate this defconfig since it seems to have been hand-made
originally. Some options like SCSI were enabled in the defconfig but not
in the final config, it seems like disabling SCSI is the correct thing
here, so no functional changes.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 configs/qcom_ipq5424_mmc_defconfig | 67 ++++++++++++--------------------------
 1 file changed, 21 insertions(+), 46 deletions(-)

diff --git a/configs/qcom_ipq5424_mmc_defconfig b/configs/qcom_ipq5424_mmc_defconfig
index 0dd46680b0fc80b10a6975aaddf36e97d8b9be84..81c3865193d73e3f1fc85bd342e3f1d25534c81d 100644
--- a/configs/qcom_ipq5424_mmc_defconfig
+++ b/configs/qcom_ipq5424_mmc_defconfig
@@ -2,82 +2,57 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_POSITION_INDEPENDENT=y
 CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
 CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_TEXT_BASE=0x8a380000
 CONFIG_NR_DRAM_BANKS=24
+CONFIG_ENV_SIZE=0x40000
+CONFIG_ENV_OFFSET=0
 CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq5424-rdp466"
 CONFIG_SYS_LOAD_ADDR=0x50000000
+CONFIG_DEBUG_UART_BASE=0x1a84000
+CONFIG_DEBUG_UART_CLOCK=14745600
+CONFIG_DEBUG_UART=y
+CONFIG_REMAKE_ELF=y
+# CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
-# CONFIG_EFI_LOADER is not set
-# CONFIG_EFI_BINARY_EXEC is not set
-# CONFIG_EFI_VARIABLE_FILE_STORE is not set
-# CONFIG_PXE_UTILS is not set
 # CONFIG_BOOTSTD is not set
-# CONFIG_BOOTMETH_VBE is not set
-CONFIG_BOOTDELAY=2
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_PREBOOT=y
-CONFIG_LOG_MAX_LEVEL=9
-CONFIG_LOG_DEFAULT_LEVEL=4
+CONFIG_SYS_PBSIZE=1024
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_HUSH_PARSER=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_USB=y
 CONFIG_CMD_PART=y
+CONFIG_EFI_PARTITION=y
 CONFIG_OF_LIVE=y
+CONFIG_ENV_IS_IN_MMC=y
 CONFIG_USE_DEFAULT_ENV_FILE=y
 CONFIG_DEFAULT_ENV_FILE="board/qualcomm/default.env"
 CONFIG_CLK=y
 CONFIG_CLK_QCOM_IPQ5424=y
-CONFIG_DFU_MMC=y
-CONFIG_DFU_SCSI=y
-CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
 CONFIG_MSM_GPIO=y
-CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
-CONFIG_PINCTRL_QCOM_IPQ5424=y
+# CONFIG_I2C is not set
+# CONFIG_INPUT is not set
+CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_MSM=y
-CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MTD=y
 CONFIG_DM_MDIO=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_QCOM=y
 CONFIG_RGMII=y
 CONFIG_PHY=y
 CONFIG_PHY_QCOM_QMP_UFS=y
 CONFIG_PHY_QCOM_QUSB2=y
-CONFIG_SCSI=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_QCOM_IPQ5424=y
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
 CONFIG_SOC_QCOM=y
-CONFIG_DEBUG_UART=y
-CONFIG_DEBUG_UART_ANNOUNCE=y
-CONFIG_DEBUG_UART_BASE=0x1a84000
-CONFIG_DEBUG_UART_MSM_GENI=y
-CONFIG_DEBUG_UART_CLOCK=14745600
-CONFIG_TEXT_BASE=0x8a380000
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_BOOTSTD_FULL=y
-CONFIG_SYS_CBSIZE=1024
-CONFIG_SYS_PBSIZE=1024
-CONFIG_OF_LIVE=y
-CONFIG_MSM_SERIAL=y
-CONFIG_DM_EVENT=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_ENV_SIZE=0x40000
-CONFIG_ENV_OFFSET=0
-CONFIG_PARTITIONS=y
-CONFIG_PARTITION_UUIDS=y
-CONFIG_MTD=y
-CONFIG_MTD_PARTS=y
-CONFIG_HUSH_PARSER=y
-CONFIG_PARTITIONS=y
-CONFIG_EFI_PARTITION=y
-# CONFIG_I2C is not set
-# CONFIG_INPUT is not set
-# CONFIG_SCSI is not set
-# CONFIG_SPMI is not set

-- 
2.49.0

