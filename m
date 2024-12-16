Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F2CE7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 08:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A93C78005B;
	Mon, 16 Dec 2024 09:55:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="yvWzX2lr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBA3C8005B; Mon, 16 Dec 2024 09:55:36 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A58E8003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 09:55:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=20806bd110=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG74SHB009392;
 Mon, 16 Dec 2024 09:55:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 he9wIIeATgsfQRD/bP17GApZ1r/pYp7Z8AqimTg+Tks=; b=yvWzX2lr1DGBmYA1
 nNiehYOdibxnh8YQAJmcEEzusdSQnrWoC0HpHR3FIAQdzoGOmVu2UtNl89Jx+izg
 sB/DyeIrdIV/01+VVww38pVlA2D0ZxEA5xu3mUwVadx8BUmhx/UtkGebgryt3xfO
 5j1l0IpT2PUtTx7dCpSi7eoHbOctVfl9Eo/J4ynOoLL1Vq6zWB0p9/ZWdElPkrdA
 iPeHjELNdFDPziJeSnOrw0TBniOt1RJ2OucJMh+L3Ob5C/sP+BF0b0HFMvQJq+wX
 BxHSjXihI6OITBWmc333hziH5mjXJVZkiLfuY4hRyL+UDRY+3nSeb8nGqV+BScB3
 y8FO3A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43jfg8rfsj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Dec 2024 09:55:20 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 29D4E40053;
 Mon, 16 Dec 2024 09:54:16 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 57F8D243908;
 Mon, 16 Dec 2024 09:53:42 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 16 Dec
 2024 09:53:41 +0100
Message-ID: <bd611a96-194c-4522-ac12-08b87e89344b@foss.st.com>
Date: Mon, 16 Dec 2024 09:53:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ARM: dts: stm32: Deduplicate
 CONFIG_OF_SPL_REMOVE_PROPS on DH STM32MP15xx DHSOM
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Igor Opaniuk <igor.opaniuk@gmail.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20241215233011.569287-1-marex@denx.de>
 <20241215233011.569287-4-marex@denx.de>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20241215233011.569287-4-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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



On 12/16/24 00:29, Marek Vasut wrote:
> The content of CONFIG_OF_SPL_REMOVE_PROPS is the same in both
> STM32MP15xx DHCOM and DHCOR defconfigs, deduplicate the content
> into stm32mp15_dhsom.config .
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> NOTE: For 2025.01
> ---
> Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  configs/stm32mp15_dhcom_basic_defconfig | 1 -
>  configs/stm32mp15_dhcor_basic_defconfig | 1 -
>  configs/stm32mp15_dhsom.config          | 1 +
>  3 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/configs/stm32mp15_dhcom_basic_defconfig b/configs/stm32mp15_dhcom_basic_defconfig
> index 5add66fb2f4..a28f2862048 100644
> --- a/configs/stm32mp15_dhcom_basic_defconfig
> +++ b/configs/stm32mp15_dhcom_basic_defconfig
> @@ -7,5 +7,4 @@ CONFIG_SYS_MEMTEST_START=0xc0000000
>  CONFIG_SYS_MEMTEST_END=0xc4000000
>  CONFIG_SYS_I2C_EEPROM_BUS=3
>  CONFIG_OF_LIST="st/stm32mp157c-dhcom-pdk2 st/stm32mp153c-dhcom-drc02 st/stm32mp157c-dhcom-picoitx"
> -CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended interrupt-controller \\\#interrupt-cells interrupt-parent dmas dma-names assigned-clocks assigned-clock-rates assigned-clock-parents hwlocks access-controllers"
>  CONFIG_SYS_I2C_EEPROM_ADDR=0x50
> diff --git a/configs/stm32mp15_dhcor_basic_defconfig b/configs/stm32mp15_dhcor_basic_defconfig
> index dd14db3b4c5..f6f2af6e7a2 100644
> --- a/configs/stm32mp15_dhcor_basic_defconfig
> +++ b/configs/stm32mp15_dhcor_basic_defconfig
> @@ -5,7 +5,6 @@ CONFIG_ARCH_STM32MP=y
>  CONFIG_DEFAULT_DEVICE_TREE="st/stm32mp157a-dhcor-avenger96"
>  CONFIG_SYS_I2C_EEPROM_BUS=2
>  CONFIG_OF_LIST="st/stm32mp157a-dhcor-avenger96 st/stm32mp151a-dhcor-testbench st/stm32mp153c-dhcor-drc-compact"
> -CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended interrupt-controller \\\#interrupt-cells interrupt-parent dmas dma-names assigned-clocks assigned-clock-rates assigned-clock-parents hwlocks access-controllers"
>  CONFIG_SYS_I2C_EEPROM_ADDR=0x53
>  CONFIG_PHY_MICREL=y
>  CONFIG_PHY_MICREL_KSZ90X1=y
> diff --git a/configs/stm32mp15_dhsom.config b/configs/stm32mp15_dhsom.config
> index 04ee9bfc444..ac3ae82cda9 100644
> --- a/configs/stm32mp15_dhsom.config
> +++ b/configs/stm32mp15_dhsom.config
> @@ -22,6 +22,7 @@ CONFIG_HAS_BOARD_SIZE_LIMIT=y
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>  CONFIG_HWSPINLOCK_STM32=y
>  CONFIG_KS8851_MLL=y
> +CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended interrupt-controller \\\#interrupt-cells interrupt-parent dmas dma-names assigned-clocks assigned-clock-rates assigned-clock-parents hwlocks access-controllers"
>  CONFIG_PHY_ANEG_TIMEOUT=20000
>  CONFIG_PINCTRL_STMFX=y
>  CONFIG_REMOTEPROC_STM32_COPRO=y

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
