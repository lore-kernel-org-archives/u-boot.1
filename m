Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD915C5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57DA681E25;
	Tue,  3 Jun 2025 16:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="FGc9GHs1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8590282145; Tue,  3 Jun 2025 16:03:18 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4052A80F9C
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 16:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=82493dba10=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553DP0uY012580;
 Tue, 3 Jun 2025 16:03:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 Of78UydbjpqoOAtPt1FJmmKFa4OWJF/hUhGizzfz23U=; b=FGc9GHs19d+ajooK
 2iSOzhQAZHIPXBkwNyqfgAhdNAslioJAKoivb9c9WSDflH000+y4aXToORAHENgk
 yTXyHacxu7bkgmZf4ld5j2kRv0GQYs5ivwaAh0Egkb4uQM0mzikqKuji7JEUQYf/
 YRM8+RmVuE+mlD/RqFt8v3/C8UHHX5uK/QGqTc4lEENCoClowbgrJ+4V7LeXs01J
 GzCn13xIu8skWSNVfNXX9QMCm1vvIqptBDbRbjJJFVkP4Gxn1y6mflZVAwKq6QDS
 wLXJkeGIPGXu2Y3+kzE6QZckGG6StdzbE/KbIOlGYjGBBbYMAlem3kNdufhLoXCs
 h96nkg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 471g8v4dem-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Jun 2025 16:03:04 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 959DE40077;
 Tue,  3 Jun 2025 16:01:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ABEFAB26CC8;
 Tue,  3 Jun 2025 16:01:00 +0200 (CEST)
Received: from [10.48.86.182] (10.48.86.182) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Jun
 2025 16:01:00 +0200
Message-ID: <69b334fa-cd92-45dd-aa91-2e0dbc78bd92@foss.st.com>
Date: Tue, 3 Jun 2025 16:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] ARM: stm32: Add STM32MP13xx PMIC initialization for
 DDR3 DRAM type
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Cheick Traore <cheick.traore@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Pascal Zimmermann <pzimmermann@dh-electronics.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@dh-electronics.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250512172149.150214-1-marek.vasut@mailbox.org>
 <20250512172149.150214-5-marek.vasut@mailbox.org>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20250512172149.150214-5-marek.vasut@mailbox.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.86.182]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
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

Hi,

On 5/12/25 19:21, Marek Vasut wrote:
> The STM32MP13xx PMIC initialization for DDR3 DRAM type is similar
> to the STM32MP15xx PMIC initialization, except the VTT rail is not
> enabled. Fill in the STM32MP13xx support.
>
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: Cheick Traore <cheick.traore@foss.st.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: Gatien Chevallier <gatien.chevallier@foss.st.com>
> Cc: Lionel Debieve <lionel.debieve@foss.st.com>
> Cc: Pascal Zimmermann <pzimmermann@dh-electronics.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>   board/st/common/stpmic1.c | 51 ++++++++++++++++++++++++++-------------
>   1 file changed, 34 insertions(+), 17 deletions(-)
>
> diff --git a/board/st/common/stpmic1.c b/board/st/common/stpmic1.c
> index 45c2bb5bcea..b46f89dacb9 100644
> --- a/board/st/common/stpmic1.c
> +++ b/board/st/common/stpmic1.c
> @@ -14,8 +14,19 @@
>   #include <power/pmic.h>
>   #include <power/stpmic1.h>
>   
> +static bool is_stm32mp13xx(void)
> +{
> +	if (!IS_ENABLED(CONFIG_STM32MP13X))
> +		return false;
> +
> +	return of_machine_is_compatible("st,stm32mp131") ||
> +	       of_machine_is_compatible("st,stm32mp133") ||
> +	       of_machine_is_compatible("st,stm32mp135");


return true;  ?


no need to check compatible if U-Boot is compiled for STM32MP13x..


> +}
> +
>   int board_ddr_power_init(enum ddr_type ddr_type)
>   {
> +	bool is_mp13 = is_stm32mp13xx();
>   	struct udevice *dev;
>   	bool buck3_at_1800000v = false;
>   	int ret;
> @@ -30,18 +41,21 @@ int board_ddr_power_init(enum ddr_type ddr_type)
>   	switch (ddr_type) {
>   	case STM32MP_DDR3:
>   		/* VTT = Set LDO3 to sync mode */
> -		ret = pmic_reg_read(dev, STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3));
> -		if (ret < 0)
> -			return ret;
> -
> -		ret &= ~STPMIC1_LDO3_MODE;
> -		ret &= ~STPMIC1_LDO12356_VOUT_MASK;
> -		ret |= STPMIC1_LDO_VOUT(STPMIC1_LDO3_DDR_SEL);
> -
> -		ret = pmic_reg_write(dev, STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3),
> -				     ret);
> -		if (ret < 0)
> -			return ret;
> +		if (!is_mp13) {
> +			/* Enable VTT only on STM32MP15xx */
> +			ret = pmic_reg_read(dev, STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3));
> +			if (ret < 0)
> +				return ret;
> +
> +			ret &= ~STPMIC1_LDO3_MODE;
> +			ret &= ~STPMIC1_LDO12356_VOUT_MASK;
> +			ret |= STPMIC1_LDO_VOUT(STPMIC1_LDO3_DDR_SEL);
> +
> +			ret = pmic_reg_write(dev, STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3),
> +					     ret);
> +			if (ret < 0)
> +				return ret;
> +		}
>   
>   		/* VDD_DDR = Set BUCK2 to 1.35V */
>   		ret = pmic_clrsetbits(dev,
> @@ -69,11 +83,14 @@ int board_ddr_power_init(enum ddr_type ddr_type)
>   		mdelay(STPMIC1_DEFAULT_START_UP_DELAY_MS);
>   
>   		/* Enable VTT = LDO3 */
> -		ret = pmic_clrsetbits(dev,
> -				      STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3),
> -				      STPMIC1_LDO_ENA, STPMIC1_LDO_ENA);
> -		if (ret < 0)
> -			return ret;
> +		if (!is_mp13) {
> +			/* Enable VTT only on STM32MP15xx */
> +			ret = pmic_clrsetbits(dev,
> +					      STPMIC1_LDOX_MAIN_CR(STPMIC1_LDO3),
> +					      STPMIC1_LDO_ENA, STPMIC1_LDO_ENA);
> +			if (ret < 0)
> +				return ret;
> +		}
>   
>   		mdelay(STPMIC1_DEFAULT_START_UP_DELAY_MS);


Support of VTT is not linked to SoC but to board design...

I think all this part should be reworked / based on TF-A binding to have 
information in device tree (link between regulators and DDR supply)


in TF-A we manage this part as a generic way to prepare STPMIC1L 
introduction,

based on information found on device tree when we introduce STM32MP13 
and STM32MP25 in TF-A

see binding for compatible = "st,stm32mp1-ddr";

docs/devicetree/bindings/memory-controllers/st,stm32mp1-ddr.txt

 > And the supply attributes depending on the DDR type (DDR3/LPDDR2/LPDDR3).
 >
 >For DDR3:
 >- vdd-supply    : phandle to the VDD/VDDQ regulator device tree node.
 >- vref-supply    : phandle to the VREFCA/VREFDQ regulator device tree 
node.
 >- vtt-supply    : phandle to the VTT regulator device tree node.
 >
 >For LPDDR2/LPDDR3:
 >- vdd1-supply    : phandle to the VDD1 regulator device tree node.
 >- vdd2-supply    : phandle to the VDD2/VDDCA regulator device tree node.
 >- vddq-supply    : phandle to the VDDQ regulator device tree node.


the sequence are generic and some supply are optional

For example:

     pmic: stpmic@33 {
         compatible = "st,stpmic1";
         reg = <0x33>;
         interrupts-extended = <&exti_pwr 55 IRQ_TYPE_EDGE_FALLING>;
         interrupt-controller;
         #interrupt-cells = <2>;
         status = "okay";

         regulators {
             compatible = "st,stpmic1-regulators";
             ldo1-supply = <&v3v3>;
             ldo2-supply = <&v3v3>;
             ldo3-supply = <&vdd_ddr>;
             ldo5-supply = <&v3v3>;
             ldo6-supply = <&v3v3>;
             pwr_sw1-supply = <&bst_out>;
             pwr_sw2-supply = <&bst_out>;
...
             vdd_ddr: buck2 {
                 regulator-name = "vdd_ddr";
                 regulator-min-microvolt = <1350000>;
                 regulator-max-microvolt = <1350000>;
                 regulator-always-on;
                 regulator-initial-mode = <0>;
                 regulator-over-current-protection;
             };
...
             vtt_ddr: ldo3 {
                 regulator-name = "vtt_ddr";
                 regulator-always-on;
                 regulator-over-current-protection;
                 st,regulator-sink-source;
             };
...

             vref_ddr: vref_ddr {
                 regulator-name = "vref_ddr";
                 regulator-always-on;
             };
...


&ddr {
     vdd-supply = <&vdd_ddr>;
     vtt-supply = <&vtt_ddr>;
     vref-supply = <&vref_ddr>;
};


And it is managed in TF-A code
=> ./plat/st/stm32mp1/plat_ddr.c


anyway for a first implementation it is OK with my remark on comaptible....


Regards


Patrick

>   
