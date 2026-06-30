Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D72EC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 16:32:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBF5184A26;
	Tue, 30 Jun 2026 18:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YxTqPChc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23B7D84A47; Tue, 30 Jun 2026 18:32:02 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD55C8498C
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 18:31:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493a7bd27c2so23302745e9.3
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 09:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782837119; x=1783441919; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nuinsQUTFnaj88WpGTOH926nE6UeHmcHcCUupL7bVo4=;
 b=YxTqPChcPpB2DopC+jAwqBO9ca2gst0267UjAVmA5AcqGLmKsfObJyZ1NMRT/VuUe2
 9tNfealOFnJI/4HnxAyZO8r3GyivMhZ20/iJh9MvkgUg+vggeiYKbLsTyvZDvANtF41X
 0Xo+86pNUHscS8v6+oT4o1J5RI/oEGTyL4lUklSBCxwaoy24m6ojTBtSzcD69quUyNUd
 GwqPhGYrKqRqo6JKg/1h1oQDXLUogBRbCDrlBUHaHyanWX+hai37VYqmQAB/MJKkdA0o
 mi3Eu3UjTUvAFizWFsrFLHXyVoL7U7k02vtA0KISwwq1V/Tx85UvKUVgof+VQJIGCg+q
 Zxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782837119; x=1783441919;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nuinsQUTFnaj88WpGTOH926nE6UeHmcHcCUupL7bVo4=;
 b=beYQ6ZOg569X7nwLE5PVNtI6av9n+p9yHPHMZw16wimZiLvYf4roZ0djhTDrSnbXcU
 VfT9SLVoiqUJKVf0GD9i8obo8ge4MmCimIFloXSawO8f6KQnQbGM48+I3TnGv5x0WDpW
 UUkf1XnKkZMX3gYjuocEmq4jku3558by9LfqAF43Jk+QOxm6hhWEbtwk0Kumv2Jw3Qvy
 JA6Yi5vBc5ZOguPZADP0TKvSZB7v8hv7CYxWUMX0tin9pwXk+MtZvQslEGaV+dWMfVkI
 nRaWAYh/QmxcgXWc6be8PKFKgElDSDd/+NbVmjj95ObcK/284XdwLW10rbZmJTacEtrB
 8sKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+N+Q2GuBV6kN7HlUPxahcQDWNr8uct0DMgM1g+EDWlH2DCqOUI0nhYjwhdJmwjdUVmbfDjdCo=@lists.denx.de
X-Gm-Message-State: AOJu0YxMmKoA7YXJDW/abVyNqf24WEzUogGUVHPOQyUlGymEQf9w7sMl
 92BC5fJaQI+YTcooYlElvzypMCat6oPFdDCboGcveC7ybeVayy0k9Eae64b3SdU+6hE=
X-Gm-Gg: AfdE7cldtroZahXlrKqPxuOzLAH7+c4w88aKRGFrEyE0SJdVwZ/YrouOkDHf+U1Tkgp
 ccx6SWSs8548guDzbU9P9fziCS1/s6nQS65Jq9B70tsUAaCTBzT6r37fW+hG1FKy3PaPjqcEb+l
 MThC0F9hmKI/HfZp4F5SZZ9LcmD+NWPtlz/71DaxF7WJ1oyXhU5kA7ZyuARZsNs7HLJNSss0Pc0
 KZxOfySlL80/jyeS3NC25whvE6g5zy8N8I3C32vcJyQT8t3SpCdByb0MTCxCKdoihcyVBG31qN4
 F0KQBvSEYTaUp6fR/U6aUbNPPtM4aCPJmYxrkBeNlj43i0tsBL5Nug4VBox5fr+TZncovPSvhaD
 HzCprh1JqBE87K+cyPfmv6bRon8GQtT/tdC03b2fiRG3CpEtg/R/Y7Dug27CK7LVqa3Abgixc1p
 tXYDeqCK1YWkzhcjlEnmVwEsIOTMg=
X-Received: by 2002:a05:600c:698d:b0:493:b8d9:f28b with SMTP id
 5b1f17b1804b1-493b8d9f306mr58934655e9.23.1782837118816; 
 Tue, 30 Jun 2026 09:31:58 -0700 (PDT)
Received: from [172.16.185.106] ([195.76.196.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4e7f81sm7195315e9.11.2026.06.30.09.31.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 09:31:58 -0700 (PDT)
Message-ID: <a8c66666-ca2a-4b0c-bb25-cc0fad03cd9f@linaro.org>
Date: Tue, 30 Jun 2026 18:31:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] configs: Add defconfig for ipq9650 RDP488
To: Badhrinath S <badhrinath.s@oss.qualcomm.com>, trini@konsulko.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, quic_varada@quicinc.com, luca.weiss@fairphone.com,
 danila@jiaxyga.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, adrian@mainlining.org,
 david.wronek@mainlining.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20260610053655.2825589-1-badhrinath.s@oss.qualcomm.com>
 <20260610053655.2825589-5-badhrinath.s@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260610053655.2825589-5-badhrinath.s@oss.qualcomm.com>
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



On 6/10/26 07:36, Badhrinath S wrote:
> Add default configuration for the IPQ9650 RDP488 board with eMMC boot
> support.

Do we need individual defconfigs for every single IPQ board really? One 
or two sure but at this point I think we ought to have a common fragment 
that they include with the base stuff so we can keep things in sync and 
differentiate the platform specific options.

> 
> Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
> ---
> Changes in v2:
> - No changes
> 
>   configs/qcom_ipq9650_mmc_defconfig | 57 ++++++++++++++++++++++++++++++
>   1 file changed, 57 insertions(+)
>   create mode 100644 configs/qcom_ipq9650_mmc_defconfig
> 
> diff --git a/configs/qcom_ipq9650_mmc_defconfig b/configs/qcom_ipq9650_mmc_defconfig
> new file mode 100644
> index 000000000000..ce2488d72eb1
> --- /dev/null
> +++ b/configs/qcom_ipq9650_mmc_defconfig
> @@ -0,0 +1,57 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_POSITION_INDEPENDENT=y
> +CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
> +CONFIG_ARCH_SNAPDRAGON=y
> +CONFIG_TEXT_BASE=0x8a280000
> +CONFIG_NR_DRAM_BANKS=24
> +CONFIG_ENV_SIZE=0x40000
> +CONFIG_ENV_OFFSET=0
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq9650-rdp488"
> +CONFIG_SYS_LOAD_ADDR=0x90000000
> +CONFIG_DEBUG_UART_BASE=0x1a98000
> +CONFIG_DEBUG_UART_CLOCK=14745600
> +CONFIG_DEBUG_UART=y
> +CONFIG_REMAKE_ELF=y
> +# CONFIG_EFI_LOADER is not set
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +# CONFIG_BOOTSTD is not set
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_USE_PREBOOT=y
> +CONFIG_SYS_PBSIZE=1024
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_HUSH_PARSER=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PART=y
> +CONFIG_OF_LIVE=y
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_CLK=y
> +CONFIG_CLK_QCOM_IPQ9650=y
> +CONFIG_MSM_GPIO=y
> +# CONFIG_I2C is not set
> +# CONFIG_INPUT is not set
> +CONFIG_MISC=y
> +CONFIG_QCOM_GENI=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_ADMA=y
> +CONFIG_MMC_SDHCI_MSM=y
> +CONFIG_MTD=y
> +CONFIG_DM_MDIO=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_QCOM=y
> +CONFIG_RGMII=y
> +CONFIG_PHY=y
> +CONFIG_PHY_QCOM_QMP_UFS=y
> +CONFIG_PHY_QCOM_QUSB2=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCONF=y
> +CONFIG_PINCTRL_QCOM_IPQ9650=y
> +CONFIG_DEBUG_UART_MSM_GENI=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_MSM_SERIAL=y
> +CONFIG_MSM_GENI_SERIAL=y
> +CONFIG_SOC_QCOM=y
> +CONFIG_SYS_MALLOC_LEN=0xC0000

