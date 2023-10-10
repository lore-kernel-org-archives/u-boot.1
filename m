Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5A0CD80CA
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 13:05:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C97586725;
	Tue, 10 Oct 2023 15:05:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="fL6myBY5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C383A86D85; Tue, 10 Oct 2023 15:05:23 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A8E1863C3
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 15:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=86470e826c=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39A87YgX001191; Tue, 10 Oct 2023 15:04:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=tX3wUIwEYkd2biYtEscFRw7YXo9Mu+yY4QD0gC1sgHY=; b=fL
 6myBY5865kmaxZJ1Ws4ivQDQrubO0GXLFh5U26enBUx4hHw0BqSTabNMojXLZXRB
 RRoNGnriHhpUqYwisFanYqq7rnUlmf+T5dIOQFX/pAWVWL7yPQOTP6nYa5IJBexi
 Dn1ESdC3l1HynCKklV1fGS359bR9aEEjsXyJdwQjGtLMd0makdphbdZgWKTCosY6
 ZsPnlA4x5a355F8apBlh+oNKNyuwSWqF3pSRfh/7WCv0IXbJsPBkUUgYIAHeLQIw
 0ikly7aufJLmbvOmuR8eE+N7jOXl34XNPrpiF4oNOG8oFOO11fmi9SJKQLWh50K9
 hDnORzuSmdjjPBasoD+Q==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tkhg6245c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Oct 2023 15:04:58 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E5B1210005E;
 Tue, 10 Oct 2023 15:04:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CD952231532;
 Tue, 10 Oct 2023 15:04:56 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 15:04:56 +0200
Message-ID: <83deab6c-7615-80a9-8fad-2073da828e7e@foss.st.com>
Date: Tue, 10 Oct 2023 15:04:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ARM: dts: stm32mp: Repair damage from alignment with v6.3
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 <u-boot@dh-electronics.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20231009231551.354425-1-marex@denx.de>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20231009231551.354425-1-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_08,2023-10-10_01,2023-05-22_02
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

On 10/10/23 01:15, Marek Vasut wrote:
> The patch fixed by this commit renders ST STM32MP15xx EV1 board and
> all DHSOM SoM based boards unbootable from SPI NOR. Fix the damage
> by updating -u-boot.dtsi to match the stm32mp15-pinctrl.dtsi update.
> 
> Fixes: 08002ffd083d ("ARM: dts: stm32mp: alignment with v6.3")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> NOTE: It is truly incomprehensible how 08002ffd083d was ever tested
>       at ST, I can only speculate it never was tested at all, grumb.

Hi Marek,

Sorry for that, you are right, SPI NOR boot in SPL is no more tested on our side :-(
Today we are only tested boot from sdcard with tf-a/optee.

Thanks for you fix.

Patrice

> ---
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  arch/arm/dts/stm32mp157c-ev1-u-boot.dtsi   | 16 ++++++++++++----
>  arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi | 12 +++---------
>  arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi |  8 ++++++--
>  3 files changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/dts/stm32mp157c-ev1-u-boot.dtsi b/arch/arm/dts/stm32mp157c-ev1-u-boot.dtsi
> index 1f7fdbce530..eb283cacd27 100644
> --- a/arch/arm/dts/stm32mp157c-ev1-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp157c-ev1-u-boot.dtsi
> @@ -135,20 +135,28 @@
>  
>  &qspi_bk1_pins_a {
>  	bootph-pre-ram;
> -	pins1 {
> +	pins {
>  		bootph-pre-ram;
>  	};
> -	pins2 {
> +};
> +
> +&qspi_cs1_pins_a {
> +	bootph-pre-ram;
> +	pins {
>  		bootph-pre-ram;
>  	};
>  };
>  
>  &qspi_bk2_pins_a {
>  	bootph-pre-ram;
> -	pins1 {
> +	pins {
>  		bootph-pre-ram;
>  	};
> -	pins2 {
> +};
> +
> +&qspi_cs2_pins_a {
> +	bootph-pre-ram;
> +	pins {
>  		bootph-pre-ram;
>  	};
>  };
> diff --git a/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi b/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi
> index f12941b05f6..2f70b0690d2 100644
> --- a/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi
> @@ -134,20 +134,14 @@
>  
>  &qspi_bk1_pins_a {
>  	bootph-pre-ram;
> -	pins1 {
> -		bootph-pre-ram;
> -	};
> -	pins2 {
> +	pins {
>  		bootph-pre-ram;
>  	};
>  };
>  
> -&qspi_bk2_pins_a {
> +&qspi_cs1_pins_a {
>  	bootph-pre-ram;
> -	pins1 {
> -		bootph-pre-ram;
> -	};
> -	pins2 {
> +	pins {
>  		bootph-pre-ram;
>  	};
>  };
> diff --git a/arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi b/arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi
> index eb905ad2820..552b35db3c7 100644
> --- a/arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi
> @@ -98,10 +98,14 @@
>  
>  &qspi_bk1_pins_a {
>  	bootph-pre-ram;
> -	pins1 {
> +	pins {
>  		bootph-pre-ram;
>  	};
> -	pins2 {
> +};
> +
> +&qspi_cs1_pins_a {
> +	bootph-pre-ram;
> +	pins {
>  		bootph-pre-ram;
>  	};
>  };

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Patrice
