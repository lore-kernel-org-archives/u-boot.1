Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46125E7D26B
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 09:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2E6286D7C;
	Tue, 26 Sep 2023 11:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="uYPmNZlW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B497D86D93; Tue, 26 Sep 2023 11:11:23 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDB1B86BEE
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7633ac7092=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38Q6iWor007872; Tue, 26 Sep 2023 11:11:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=r6S4R9nM7QjlZ2bSnPOwvja8/PLcipE5/6s0PYDiDbE=; b=uY
 PmNZlWCO/+Ve/WE4zqphxdnR4lYOnxBnIPKsvxk70n7ru4EQZPgIe41uijkpPuDZ
 eE5j+VHdbtQIdQ551FKrRvCdcbrYa9MpRv60QB60xqEHr1awvbFgAttQuXVgrwXt
 hnM320RZBjwt2ZXEQzDjKCgIkRBii4INHwrorunUUrWYnoj7CtT3xqikpirDObi3
 ElVvWfVbgwHscjLx21snoPMpuSnAeQLik5nA2os33KvKRH0pA4rd8iLTgvdb1eah
 Q8MjWL+imQ7a/Ff/VfXh9hnmOfcArqiIioXoRjYUuTe7qEYc/P5W8u6vO+87Ifg9
 LViM7sdOeMWrO/ED9Wmg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t9qbwue0n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 11:11:18 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 020F8100059;
 Tue, 26 Sep 2023 11:11:16 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EAF1B22F7B9;
 Tue, 26 Sep 2023 11:11:16 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 11:11:16 +0200
Message-ID: <7a2a8f79-247e-1936-d7c6-638e634abcf6@foss.st.com>
Date: Tue, 26 Sep 2023 11:11:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 1/5] ARM: dts: stm32f469-disco: sync with Linux 6.5
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230903205703.662080-1-dario.binacchi@amarulasolutions.com>
 <20230903205703.662080-2-dario.binacchi@amarulasolutions.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230903205703.662080-2-dario.binacchi@amarulasolutions.com>
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



On 9/3/23 22:56, Dario Binacchi wrote:
> Sync the devicetree with linux 6.5 for stm32f746-disco board.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>  arch/arm/dts/stm32f469-disco.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/dts/stm32f469-disco.dts b/arch/arm/dts/stm32f469-disco.dts
> index 6e0ffc1903be..c9acabf0f530 100644
> --- a/arch/arm/dts/stm32f469-disco.dts
> +++ b/arch/arm/dts/stm32f469-disco.dts
> @@ -119,7 +119,7 @@
>  		};
>  	};
>  
> -	panel-dsi@0 {
> +	panel@0 {
>  		compatible = "orisetech,otm8009a";
>  		reg = <0>; /* dsi virtual channel (0..3) */
>  		reset-gpios = <&gpioh 7 GPIO_ACTIVE_LOW>;
> @@ -138,7 +138,7 @@
>  	status = "okay";
>  
>  	port {
> -		ltdc_out_dsi: endpoint@0 {
> +		ltdc_out_dsi: endpoint {
>  			remote-endpoint = <&dsi_in>;
>  		};
>  	};
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
