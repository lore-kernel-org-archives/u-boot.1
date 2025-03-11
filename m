Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6E2C28B30
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 15:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 634E180F92;
	Tue, 11 Mar 2025 16:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JtZDGV7b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3E6581197; Tue, 11 Mar 2025 16:27:30 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B86278083E
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 16:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-390fdaf2897so5454468f8f.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 08:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741706848; x=1742311648; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9t4fk9qhVS2H4TackNxuCd/mqNCKY1jF3sPOs8Pqhvw=;
 b=JtZDGV7bdx5HQG7c5vM0gwDs1od5lqJ4WRyMtSG8qx4mEKHFFjfoiskJeGCpUOujBy
 xhabTd7e97kcaC8cC+sky8+wpId9RQQqPzBTZoo+aBvAqe3K3YBJaKEStwxiqhWZpj6H
 vKZRerfJKhQem3Kplk7qizN7PNkA+gZIjVTTcSih7SYZ9NZT0r3cetA2K/8LnMyEobnS
 V3AH5EW0o+K78nughB8IU+sMasZDd6M4GwHpDn05d06mnzp7ns2BGhkPNS9cYTyaH7n5
 NRWmV9NuOHkdCdKe8x2OnGTBh2HlZS521+2nCze8bhSPSqe9QEbfoNTZnn5RsIN8tGFS
 PEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741706848; x=1742311648;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9t4fk9qhVS2H4TackNxuCd/mqNCKY1jF3sPOs8Pqhvw=;
 b=L5oabQ6jh8W0GXxeR4CZbSd6gAsBixVBTsCcgMwUiGfQh0Blj6s38dFKIkodmzd/tl
 3W6DvJMG+FezNTjdKnataI9ShwyWG3z95SiN6mF0Q86QthyzQj+PfvF4keMaFWAnhM+R
 OaXPHz4fNOQdoq33M/JH0ppBDoSwWuNxi2IhEnmlJpvpzj0jmVOjryhr0ZfpJFwZYCSN
 1bjNQY7hJ+oAbATh3vgRu2z63rVKcjI61vyj29DwNL5pTk9pocPnQXag9OV5M4B8tqwi
 Fonc2qdOVaJywNnrSJuUQh5kpRtxxqI0R5CCiYtMeoLFQhe7ZjNvzI3Nf86BkzYN38J1
 pBTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHgxEO0hLCJtqwumHDukM9GT5djcLBL4GzXLOzaa4sl9WPgs90km1UOf1G5GxUqBmxPxWtulo=@lists.denx.de
X-Gm-Message-State: AOJu0YypPITcOWzsDYw2o0CAHRI8yRpaWc9uYt5DgfAm686s72sE6hQB
 ENwO8sbSQpE5FUlGS92CKN0ykzHrsP0zbJN9pbZOQXXyw/ED+dV9u1HuUKfitfw=
X-Gm-Gg: ASbGncvCrOK9BibzlIa3hvRt2kIXTJeIgI7M42llyleLJhkwrlqxDjFjLeROUAjDcA9
 leMp7hYteXuFwDcUO46pMxg3FZGc+GrjjMDZ5/ADxwjIUdaygZsAOXAzqDcVLCPcNAhcaTVZIlk
 Dbig2KU+fY6BTCphhzwgJCPTmraGvpTNR3z+ViNM5jn5mPDJfPjnMWylFV6gLgdkbVQZ2lg2/i3
 gDPkpX6F7pqcuR0gv64N+gIGG12Wzf+L+RfJVaSpgLbwuFqW6fXieIkNzwqmgXtEOHcHnFGuzTi
 IfIil0SXzsu7WBP5qQIsP0E1/QJJ0/plDl+iQ91IBH7tlL0UgWE2R4Q6CaHN/bZGFSWZOsuFrqL
 mKkhAbrKbjuXlyVh8uE+/JyiKFw==
X-Google-Smtp-Source: AGHT+IGU/kBIbkTWDz0jlprNTGyFAIWGtntRrVKBJtDEKN9vU3ezITg1Hs+ltl9pFr6SHS4oawU04Q==
X-Received: by 2002:a05:6000:144b:b0:391:47d8:de23 with SMTP id
 ffacd0b85a97d-39147d8dff6mr9730046f8f.31.1741706848046; 
 Tue, 11 Mar 2025 08:27:28 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:f578:9a7d:3957:bef9?
 ([2a0a:ef40:1d11:ab01:f578:9a7d:3957:bef9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e4065sm18690614f8f.62.2025.03.11.08.27.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 08:27:26 -0700 (PDT)
Message-ID: <c138a744-4423-4b3e-8b1f-abe77d6e228e@linaro.org>
Date: Tue, 11 Mar 2025 15:27:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/6] configs: add qcom_ipq5424_mmc_defconfig
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, lukma@denx.de,
 seanga2@gmail.com, Volodymyr_Babchuk@epam.com, lehmanju@devpi.de,
 sjg@chromium.org, robert.marko@sartura.hr, dmitry.baryshkov@linaro.org,
 andersson@kernel.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250304110105.2762124-1-quic_varada@quicinc.com>
 <20250304110105.2762124-7-quic_varada@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250304110105.2762124-7-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Varadarajan,

Thanks for the series, and apologies for the slow reply, i've been out 
sick and still finding my feet again.

On 3/4/25 11:01, Varadarajan Narayanan wrote:
> Introduce a defconfig for the Qualcomm IPQ5424 SoC based RDPs.
> Presently supports eMMC.
> 
> Per the flash memory layout, U-Boot size cannot exceed 756KB. With this
> defconfig, u-boot.mbn size is ~480KB.

What are the differences between this and the other new IPQ platform? 
Can they share a defconfig?

Alternatively, could most of the things here be de-duplicated so there 
is a "base" config which they both #include (similarly to 
qcm6490_defconfig) this way we can nicely keep track of what parts of 
board specific.

If you'd prefer to keep it this way that's fine too.

Should I be expecting more platforms like this?

Kind regards,
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>   configs/qcom_ipq5424_mmc_defconfig | 83 ++++++++++++++++++++++++++++++
>   1 file changed, 83 insertions(+)
>   create mode 100644 configs/qcom_ipq5424_mmc_defconfig
> 
> diff --git a/configs/qcom_ipq5424_mmc_defconfig b/configs/qcom_ipq5424_mmc_defconfig
> new file mode 100644
> index 0000000000..0dd46680b0
> --- /dev/null
> +++ b/configs/qcom_ipq5424_mmc_defconfig
> @@ -0,0 +1,83 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_POSITION_INDEPENDENT=y
> +CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
> +CONFIG_ARCH_SNAPDRAGON=y
> +CONFIG_NR_DRAM_BANKS=24
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq5424-rdp466"
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
> +CONFIG_CLK_QCOM_IPQ5424=y
> +CONFIG_DFU_MMC=y
> +CONFIG_DFU_SCSI=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
> +CONFIG_MSM_GPIO=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCONF=y
> +CONFIG_PINCTRL_QCOM_IPQ5424=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_ADMA=y
> +CONFIG_MMC_SDHCI_MSM=y
> +CONFIG_MMC_HS200_SUPPORT=y
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
> +CONFIG_DEBUG_UART_BASE=0x1a84000
> +CONFIG_DEBUG_UART_MSM_GENI=y
> +CONFIG_DEBUG_UART_CLOCK=14745600
> +CONFIG_TEXT_BASE=0x8a380000
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

-- 
Caleb (they/them)

