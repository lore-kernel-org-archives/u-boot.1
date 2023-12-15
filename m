Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE34C41535
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 14:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BE3087B9C;
	Fri, 15 Dec 2023 15:42:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="uZrK8ikF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3C3987B77; Fri, 15 Dec 2023 15:42:32 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3744B87BD6
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 15:42:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0713d16bf2=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3BF9TrKW006665; Fri, 15 Dec 2023 15:42:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=cepyr1K+SZomwnQrKIK7ucVYeK1okcGDtLp7lzkclqA=; b=uZ
 rK8ikFiXewGydAI7ntIPlF+sIXtPgTCdRax4jfBbXi2yR8PZjm3Ti3pihfSwW3ql
 cGf2ovbHv2y3dqrvkIXCjNcgibX27y3KlP0Nm8gI1TN94J5s4o48JTYFqx15LCKc
 9pXWJ2PFdL3xwQHlsi+NPwK8OmNjudv349QSrKCEuZONeghmz0GljVuMNfod+DWK
 CGOftNZVK0mOdm1z+v+WhpyM1mcnQ2x/CiU8fwDpihtz901AkIqR5YGO+NuHpzZn
 JsDxnkaLyxAmFP6PzBE8hYIso8HDtBcEa6Zoh9mRaFAsvgYMI7lktjhUhKDqwFGJ
 Bhwoak+xjWkjOU0JTLIQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uvg0ha0xj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Dec 2023 15:42:27 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B2159100052;
 Fri, 15 Dec 2023 15:42:26 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A828F228A22;
 Fri, 15 Dec 2023 15:42:26 +0100 (CET)
Received: from [10.252.23.141] (10.252.23.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Dec
 2023 15:42:26 +0100
Message-ID: <ea021247-ce01-40bd-a162-4f938b10603d@foss.st.com>
Date: Fri, 15 Dec 2023 15:42:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] ARM: dts: stm32f469-disco: sync with Linux 6.5
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20231211220643.1073606-1-dario.binacchi@amarulasolutions.com>
 <20231211220643.1073606-2-dario.binacchi@amarulasolutions.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20231211220643.1073606-2-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.23.141]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_08,2023-12-14_01,2023-05-22_02
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



On 12/11/23 23:05, Dario Binacchi wrote:
> Sync the devicetree with linux 6.5 for stm32f746-disco board.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Add Patrice Chotard's Reviewed-by tag.
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
Applied to u-boot-stm32/next

Thanks
Patrice
