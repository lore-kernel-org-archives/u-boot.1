Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BC0C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 06:35:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D661F80141;
	Fri, 21 Feb 2025 07:35:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FQQZDLK8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 897EC801DE; Fri, 21 Feb 2025 07:35:33 +0100 (CET)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53F068007D
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 07:35:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-868f169bb56so497670241.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 22:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740119706; x=1740724506; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hjVdOBh5OzSG5G97yPQ+eLeOA8m6LKHmxn//A4Cek+M=;
 b=FQQZDLK8yVotfnC/LMq/LgRVVMDCgScV6jm0lwRinFR/cr2jAmQTmvCo7iLKQzyMwU
 jGIx0vwXxk1TZ2d39X3jAtb25M5dPO+fOp+jEpbcMaVKD/vJ0gOaaDoeHAV3LinoK1TC
 QeOvPR6B8w0YhJIRu9DH8Qz2xuPW40Q8xnDYLWXsmn0E4S/zugwv8vRJIIas02uh/QR3
 NpVY36xMZ7VRh3i48T1wuLDh82wuvvm1K6JLRQu9AVYDrq6Gqn+shINbrxZFNZQtokXy
 B5XLN1He8yZ2ULhp8srgDgZKPLw1B6xi03G/RsVuk+P7GbagQ0ewTeCViYxmmkmKtSJJ
 XQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740119706; x=1740724506;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hjVdOBh5OzSG5G97yPQ+eLeOA8m6LKHmxn//A4Cek+M=;
 b=rkxGWERuFS5tXN4mzZExJ43ran5di9fMQVwm26XRzfKFkSN7ZMzAnaN7dOpKyJPW/f
 Xibv6BsS33blS2LaE7wMw1EUWtjRE6rMcYKJo2aBxxroCrnEWb9DqQRCKGVernmPx689
 ud7MG84h48IqobshKuU/Gmf8B+uwRiW4p9d/oInlneEeoLA7wf0kPdc6ch0EASj7N5Ir
 axjtHFIeoETwaR7wQL5rLTprthI739iqTWr0dhARLI1AJDdMHIcFx7XWSGJw+WiR4fqP
 cHnkoG+qd+MppBoBUsU7bELbfY8BRfYEY8k/nrohYvmsnKYezm7VuIRdu5sgnM4kVdIh
 FuVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv2mhZ/4R6iEjIJqrtp7zoiE9DEc2S1YfKUH75kX01ep9wTX3QuqUfsuhOkir5ZrZiHcSxBAE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7Ap4/cYJc4qmFwzRON0ndoLRcM3Nfw3AW2zLlq1MCo4H5O70k
 k6NvY0nBld7I8JDOVVE1+smVfgIDiS9K6MQRgbxIj0UlbeE9hVh4aF773q4vbDK8XrE+wGHNDuv
 7AIcMbEZHdD8q8EdUwAJcfyYefH9cAr7EgBOVNA==
X-Gm-Gg: ASbGncv0tlNZVDR81mh25qp1AsbTAX8ZjrjuzszKNwAML/MLB5Edb1eDc/POQQUrLLJ
 m9kux/Bk2aJw+MDcLi/o4+JkizBXbtmHuQoNiekshToVlMaSuvIg0mFS01d/sRxbAy++VyE7vIg
 0jcqZbaPDq
X-Google-Smtp-Source: AGHT+IFJrCKBjK4h4k82xV+idPRsi6H4RKx4/eq4AlF1lBLosKRnT5wi8/Kc2Ku86tu6Takvgs+DcxR3YmYY66BWeis=
X-Received: by 2002:a05:6102:e13:b0:4bb:c527:aacd with SMTP id
 ada2fe7eead31-4bfc29545f4mr661690137.23.1740119705691; Thu, 20 Feb 2025
 22:35:05 -0800 (PST)
MIME-Version: 1.0
References: <20250220073937.133687-1-quic_varada@quicinc.com>
 <20250220073937.133687-8-quic_varada@quicinc.com>
In-Reply-To: <20250220073937.133687-8-quic_varada@quicinc.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 21 Feb 2025 12:04:54 +0530
X-Gm-Features: AWEUYZmrQEnoOc_36Lv8VYZ4qhl2_s-oN6WCQxTNDJSkSfbzQ7DfvXg-9WsJUy8
Message-ID: <CAFA6WYMQ4Xkf-bBJxQD_=tGUZ363YSZhye920jU-3121bPxASA@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] configs: add qcom_ipq9574_mmc_defconfig
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org, 
 lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 robert.marko@sartura.hr, luka.perkov@sartura.hr, Volodymyr_Babchuk@epam.com, 
 sjg@chromium.org, lehmanju@devpi.de, pbrobinson@gmail.com, 
 marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 20 Feb 2025 at 13:10, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Introduce a defconfig for the Qualcomm IPQ9574 SoC based RDPs.
> Presently supports eMMC.
>
> Per the flash memory layout, U-Boot size cannot exceed 756KB. With this
> defconfig, u-boot.mbn size is ~480KB.
>
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v4: Don't include qcom_defconfig
>     Update commit message to include details about size restrictions
>     Drop 'Reviewed-by: Caleb Connolly' as the file has changed considerably
>
> v3: Removed unnecessary comment
> ---
>  configs/qcom_ipq9574_mmc_defconfig | 83 ++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 configs/qcom_ipq9574_mmc_defconfig
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/configs/qcom_ipq9574_mmc_defconfig b/configs/qcom_ipq9574_mmc_defconfig
> new file mode 100644
> index 0000000000..9bc1e1c70b
> --- /dev/null
> +++ b/configs/qcom_ipq9574_mmc_defconfig
> @@ -0,0 +1,83 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_POSITION_INDEPENDENT=y
> +CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
> +CONFIG_ARCH_SNAPDRAGON=y
> +CONFIG_NR_DRAM_BANKS=24
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq9574-rdp433"
> +CONFIG_SYS_LOAD_ADDR=0x50000000
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +# CONFIG_EFI_LOADER is not set
> +# CONFIG_EFI_BINARY_EXEC is not set
> +# CONFIG_EFI_VARIABLE_FILE_STORE is not set
> +# CONFIG_PXE_UTILS is not set
> +# CONFIG_BOOTSTD is not set
> +# CONFIG_BOOTMETH_VBE is not set
> +CONFIG_BOOTDELAY=2
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_USE_PREBOOT=y
> +CONFIG_SYS_CBSIZE=512
> +CONFIG_LOG_MAX_LEVEL=9
> +CONFIG_LOG_DEFAULT_LEVEL=4
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_PART=y
> +CONFIG_OF_LIVE=y
> +CONFIG_USE_DEFAULT_ENV_FILE=y
> +CONFIG_DEFAULT_ENV_FILE="board/qualcomm/default.env"
> +CONFIG_CLK=y
> +CONFIG_CLK_QCOM_IPQ9574=y
> +CONFIG_DFU_MMC=y
> +CONFIG_DFU_SCSI=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
> +CONFIG_MSM_GPIO=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCONF=y
> +CONFIG_PINCTRL_QCOM_IPQ9574=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_ADMA=y
> +CONFIG_MMC_SDHCI_MSM=y
> +CONFIG_DM_MDIO=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_QCOM=y
> +CONFIG_RGMII=y
> +CONFIG_PHY=y
> +CONFIG_PHY_QCOM_QMP_UFS=y
> +CONFIG_PHY_QCOM_QUSB2=y
> +CONFIG_SCSI=y
> +CONFIG_MSM_SERIAL=y
> +CONFIG_MSM_GENI_SERIAL=y
> +CONFIG_SOC_QCOM=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_BASE=0x78b1000
> +CONFIG_DEBUG_UART_MSM=y
> +CONFIG_DEBUG_UART_CLOCK=1843200
> +CONFIG_TEXT_BASE=0x4A240000
> +CONFIG_REMAKE_ELF=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_BOOTSTD_FULL=y
> +CONFIG_SYS_CBSIZE=1024
> +CONFIG_SYS_PBSIZE=1024
> +CONFIG_OF_LIVE=y
> +CONFIG_MSM_SERIAL=y
> +CONFIG_DM_EVENT=y
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_ENV_SIZE=0x40000
> +CONFIG_ENV_OFFSET=0
> +CONFIG_PARTITIONS=y
> +CONFIG_PARTITION_UUIDS=y
> +CONFIG_MTD=y
> +CONFIG_MTD_PARTS=y
> +CONFIG_HUSH_PARSER=y
> +CONFIG_PARTITIONS=y
> +CONFIG_EFI_PARTITION=y
> +# CONFIG_I2C is not set
> +# CONFIG_INPUT is not set
> +# CONFIG_SCSI is not set
> +# CONFIG_SPMI is not set
> --
> 2.34.1
>
