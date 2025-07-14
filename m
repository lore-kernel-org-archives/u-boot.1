Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F54C83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A30908304A;
	Mon, 14 Jul 2025 15:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kkzMrNW/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 328B982F49; Mon, 14 Jul 2025 15:13:20 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45D9D83020
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a503d9ef59so3235539f8f.3
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 06:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752498798; x=1753103598; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=57qTojJVzZCL9vrHxV3w3EvKFhfYQ29Vf+jS2q+ot1g=;
 b=kkzMrNW/3dk1OSb5bGtoj5dFfgs9Kz7Sk4+xjgA86Q0vls4OM+R2RTFDUSJjAC/oWf
 BY0tuCXaQ52UElMJeuiAP815OkI/pqREUjWod6xg1gh9zDuQA3YFI4FfTCYXdGjGlfuF
 D28ASo4IqAA/xKd8nFHOAC54GVRwje4kjMvxgJi+86DXzY4zhVYxSxyTGV6FNS0P3CXa
 5He/Ko7/YkTtSYU4sfozIpjgFlHQu3OPga0TauItGiC/0OttfiNlu9w0me9ZtlPfR3aP
 tpqRg0j7HBcWqbXWprT5j2j81ZvjG2YcZQA+d5jZnqh5ZBSt5PeOTfj0Hw0nW2Tk7LiQ
 yyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752498798; x=1753103598;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=57qTojJVzZCL9vrHxV3w3EvKFhfYQ29Vf+jS2q+ot1g=;
 b=LMir/xUFqeKIBj9Ug0AayNTgkEf9WyOHwKf3kEO8lBEnZOHzkdwrtLetx9QT1CI6zC
 wpuvBpJuzthSFQteZ2Gi1EhV9PwtTEchbQwfrh4IhIfb5Rp6J8Z+8V4T5YoZYs/SuV1W
 Tk6jf/0g6iAGjsGXqdQ3kNmFq9SGdsVFmnbnbyvoWWnYhiDTZvr8ArfJhLmU9dAiQcXw
 rENry/Biz890LKF/GklunIuCDB+2YD42tcToqgeuRDY7maE9Cjeovokkzp9e8eJGUZP4
 hfyc/x36zhwbdsMkkN8chbNet5KxRPi2KpzV/bLRXPQec7sgnjGHFBhn0MAaeRYZIwrv
 ECxQ==
X-Gm-Message-State: AOJu0Yxp57Em+aNofiDQtOBUIJCP7ekLuoBSrlc5+ZZnJjyQ3hDawW2o
 s0KjDHrcbB0uxb9+cQiGrfyX4ipzMv+YM3117mp6R1/FFwCirc2xSCZ1pZO6NfLC9DE=
X-Gm-Gg: ASbGncsW9WMDZkxoXIGowOacB8PMUf/Xw+hMqe8SgfwmqGldlCmLCcch47KoyJrXZLf
 PiqHT5OOMKupxBeYul+UUgDy4eB1EbrlznYOoADZQas1E2WX+Fbi7rJJ9nhP2Kqj3jjIpJomKR0
 o1m8qfKroyP2Sx6IcY53Cil2eFfrP3uqMhik4NPHf085FI0B2snAWnm7hCRrk3neler0vMUaj4J
 t1n6/y6BPIYsSmMIOp+/W5cVhNNLbzpuEEtj7SotmE29E3P5KnQVyokYfjlsSNZJQ+0EpQoRlRx
 0/BM3gDi2DERdVRTVH6oYmCtQ358ZdOj3Aziv62gcbO8qt+WM5gfuQWOlz01HvqHT8O1GuCG9Ne
 OFtbbkTkj7wCx3X0niBc2dcQiMs6TvaCj2iJmml7sQL3qOhPVWFvXaERkP7yGl6mgytC8yA==
X-Google-Smtp-Source: AGHT+IEPt+lznf3+kIs3bItyZnSqIO2nbGbNWRAh33+52kSbWpqOhpqGu8FOtDWKHii8Az2uYf/nLA==
X-Received: by 2002:a05:6000:1884:b0:3a4:ee3f:e9a6 with SMTP id
 ffacd0b85a97d-3b5f2e45e0fmr10958318f8f.54.1752498797654; 
 Mon, 14 Jul 2025 06:13:17 -0700 (PDT)
Received: from toyger.localdomain (p549d4699.dip0.t-ipconnect.de.
 [84.157.70.153]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc9298sm12361010f8f.44.2025.07.14.06.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 06:13:17 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 14 Jul 2025 15:13:12 +0200
Subject: [PATCH v5 1/8] configs: run savedefconfig on
 qcom_ipq5424_mmc_defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-geni-load-fw-v5-1-5abbc0d29838@linaro.org>
References: <20250714-geni-load-fw-v5-0-5abbc0d29838@linaro.org>
In-Reply-To: <20250714-geni-load-fw-v5-0-5abbc0d29838@linaro.org>
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
 bh=unrwUiLZwHJQEfNEdUudbX4OCE66MoUqBOoLLezpEvY=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBodQJqmRm03btx4QkymCOV60TezVLs7Yf8IVDr9
 6Ks0XOdF0OJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaHUCagAKCRAFgzErGV9k
 tg71D/9jYvj2h23lmEzFh+J1gc14MEXHNCwt8GYEfccMEEl+Ua9EHwSPMFAJ4v1Dd9mJ+DleEQp
 p2Uy9Nlw0oaVQuEFIgRB37/oFOV3UVgcnDy0czAPRoz/p2EU+boQGXQXc7u2CruoCKknz3lp+lE
 m1CnnKD6ZKG0IzlmwbbQGALAGoAE5qnOTx5YJ58MXL/TvsUcxaa6QP7HV4gemv4q5nE1RDcwp69
 p4tWgYZBWTE4Ce0Fh93LVnQYfNwIzKxeuvG9GgWE7SdzSlZ/7vAZ6kQuWWqva7bbZ7ecyjIf+sK
 0W9wg59bPjiiqL6zaxQgIXXXXnV7Zm+t/0TDl26t0mMj9hwd4g48OAMIdeD6PvRxIm/NeQ8qKEX
 oTuvkGgtJXGMCuoJRWHfKYvE+2OBuspYa6e1YJdqq+CNhRahyaXsUfEuGmCEiIbA4YJu0+A+nlr
 QlO7nFEP0PVV8sY9EMKtaTAUC2++fszX5SgIi15I02brssUEcBNrfmpiJTV18P5AgeSoW9ML+7R
 ePtd6zAiiRYmkouZWYdPtnG2/1X4ycGUSQCPpZWbuCDtptg98PlHMptrkYQMwyHMX5mRCZjwZp1
 whIVbqbX53Mr70vSnBcEXoelEPkRLgD6Vzqs5neR2co7QtcZwoAae2YVrngrQD6pni6ytEJ6EeU
 S4pa7ih+Fqpg8NQ==
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
2.50.0

