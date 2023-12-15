Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EFFC35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 14:42:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0177887C09;
	Fri, 15 Dec 2023 15:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="YRjlrvVa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B62787B4B; Fri, 15 Dec 2023 15:42:49 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2621C87561
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 15:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0713d16bf2=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3BFC0iPF007651; Fri, 15 Dec 2023 15:42:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=5M6MC2yYTddlN6g0bspMN5vUS/ob8AJwLOj5vm+YLTg=; b=YR
 jlrvVa1Omqc452o4XGSTXKNeNdcDw+8ryZoTDNIsxHbcINpukcQUfcYjiiB0T+U2
 +Y60imUhPfhFIm4fdDMdDZCKeFDA3Ux0HEJMvnbc6wIEZQzk87FjVSxvKcckdPAM
 Gz+5+c0VW7U14AI0gL8a7Ic851VdodGebL1bJQO/EKVaBlvHUUIEblRVLGGK4oFr
 8qN/1/K9bYooTlbbYlPqkgPNmDxK+xQvPBioU20p/MeOQS+xFyj8a/0xOUlgXcmP
 xLIGin/APrBbrG43aS5PnahE6cBX0DdXLxJ0X9yH1gV79DFLk5/Ei/atl9q0yUEL
 ffZIW//2JRdVd1sqVQkQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uxvh9ntxp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Dec 2023 15:42:45 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3282210005D;
 Fri, 15 Dec 2023 15:42:45 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2A0D1228A23;
 Fri, 15 Dec 2023 15:42:45 +0100 (CET)
Received: from [10.252.23.141] (10.252.23.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Dec
 2023 15:42:44 +0100
Message-ID: <c14eeceb-e0dc-486a-86db-79026af59a3a@foss.st.com>
Date: Fri, 15 Dec 2023 15:42:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] ARM: dts: stm32: make the DSI clock usable by the
 clock driver
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20231211220643.1073606-1-dario.binacchi@amarulasolutions.com>
 <20231211220643.1073606-4-dario.binacchi@amarulasolutions.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20231211220643.1073606-4-dario.binacchi@amarulasolutions.com>
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
> As described in [1], the "clocks" property contains "a phandle to the
> clock device node, an index selecting between gated clocks (0) and other
> clocks (1), and an index specifying the clock to use." The current version
> of the clock driver, unlike the kernel, is currently able to properly
> handle nodes with "clocks" properties with an index set to 0.
> 
> This patch is preparatory for future developments that require the use
> of the DSI clock.
> 
> [1] Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
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
>  arch/arm/dts/stm32f469-disco-u-boot.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/dts/stm32f469-disco-u-boot.dtsi b/arch/arm/dts/stm32f469-disco-u-boot.dtsi
> index dcc70369cd0d..8e781c5a7b23 100644
> --- a/arch/arm/dts/stm32f469-disco-u-boot.dtsi
> +++ b/arch/arm/dts/stm32f469-disco-u-boot.dtsi
> @@ -90,6 +90,11 @@
>  	bootph-all;
>  };
>  
> +&dsi {
> +	clocks = <&rcc 0 STM32F4_APB2_CLOCK(DSI)>,
> +		 <&clk_hse>;
> +};
> +
>  &gpioa {
>  	bootph-all;
>  };
Applied to u-boot-stm32/next

Thanks
Patrice
