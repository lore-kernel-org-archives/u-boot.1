Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C60E7D270
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 09:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD71A86D24;
	Tue, 26 Sep 2023 11:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="hrRdfOKL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE17486DE1; Tue, 26 Sep 2023 11:25:16 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C287686BB2
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7633ac7092=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38Q6a3j4023149; Tue, 26 Sep 2023 11:25:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=/Uo1721+e+JKvLwA+v9CbYhjakr2W9kJcoq4Pm0jde4=; b=hr
 RdfOKLVk/7TzPpH8y6y5uuASKlc41Eb4AaN3eRuwk/yBBvypz4XUVz5qIb41GNhS
 xDOTTx3dSfXlipEOUJCQ5640U7gxXc8jZKeBZprYoj7a0TF+G6DTvwV4KfRVl4XV
 H9ju20EYas8fRMorCvLvPyLsKvhz4zmeYBpnNR+0j+jg9XJCuhqnXvE3gzmQf4s3
 4r1TNY8xVFYKXB7PbImAzEH1OgMcVr91mSF1RYpTzPeQKVnTNCEsH4CphEnGnksW
 7TLWOgqowAS0NopvThMZz+nrNpwcBVRrKY+ugjn374PfzTinplSOEZK9LNwxglGg
 93obnwBiZZLDDE7pJOlA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ta9k09cne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 11:25:13 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D9132100059;
 Tue, 26 Sep 2023 11:25:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D275E22F7DB;
 Tue, 26 Sep 2023 11:25:12 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 11:25:12 +0200
Message-ID: <b125a329-3601-90a5-b5e8-f91249d9bac7@foss.st.com>
Date: Tue, 26 Sep 2023 11:25:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 06/10] ARM: dts: stm32: add touchscreen on stm32f746-disco
 board
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230903204849.660722-1-dario.binacchi@amarulasolutions.com>
 <20230903204849.660722-7-dario.binacchi@amarulasolutions.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230903204849.660722-7-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_07,2023-09-25_01,2023-05-22_02
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



On 9/3/23 22:48, Dario Binacchi wrote:
> commit f0215440069c4fb12958d2d321e05faa2708a11d Linux upstream.
> 
> The patch adds support for touchscreen on the stm32f746-disco board.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> ---
> 
>  arch/arm/dts/stm32f746-disco.dts | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/stm32f746-disco.dts b/arch/arm/dts/stm32f746-disco.dts
> index 1ed58f236149..9541f449fd0e 100644
> --- a/arch/arm/dts/stm32f746-disco.dts
> +++ b/arch/arm/dts/stm32f746-disco.dts
> @@ -7,8 +7,9 @@
>  /dts-v1/;
>  #include "stm32f746.dtsi"
>  #include "stm32f746-pinctrl.dtsi"
> -#include <dt-bindings/input/input.h>
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
>  
>  / {
>  	model = "STMicroelectronics STM32F746-DISCO board";
> @@ -63,6 +64,22 @@
>  	status = "okay";
>  };
>  
> +&i2c3 {
> +	pinctrl-0 = <&i2c3_pins_a>;
> +	pinctrl-names = "default";
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	touchscreen@38 {
> +		compatible = "edt,edt-ft5306";
> +		reg = <0x38>;
> +		interrupt-parent = <&gpioi>;
> +		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
> +		touchscreen-size-x = <480>;
> +		touchscreen-size-y = <272>;
> +	};
> +};
> +
>  &sdio1 {
>  	status = "okay";
>  	vmmc-supply = <&mmc_vcard>;
Apply on stm32/next

Thanks
Patrice
