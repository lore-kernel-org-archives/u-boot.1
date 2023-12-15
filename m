Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280EDC35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 14:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89DD887BE0;
	Fri, 15 Dec 2023 15:42:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="8TRFrY9t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 451A287BE7; Fri, 15 Dec 2023 15:42:43 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 561A286DEE
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 15:42:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0713d16bf2=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3BFEbAPw002843; Fri, 15 Dec 2023 15:42:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=I20fqkMD5I+zMEBgJUOwPgllHnUDOdU3KKHqpAjShtI=; b=8T
 RFrY9t8hX4XOdQGK97I2IW4or6IRDSqKMQTpPcv4G6/LLFwcwmUnHZgeOejpJ1aM
 RXDC2nwbkgrHd9lRWhvPmxy9qgs+YFFVLStdzRdPpKwvMrGFtCz07x5PxHV5s9a/
 HT41GdKj2M1BlX5KtYhNPVBXOF7kvibf2PepNUlyjRUJR+4lbrTjlYwZaxH0hGxI
 7p2g9dS8JLrkD6NjNnyzQuP66vezvfo63j0IvGqWxBrCPLeVYDhq0MYV+YISI9uY
 4H7AucySNnrI8dOu1L+zP2KgIxruB4NoXqQWOcnrhkCILXpf8i/NTsV9kfMiHeDP
 LvDtwfPlkkOfV+32pECA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uxvh9ntx0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Dec 2023 15:42:39 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EF959100052;
 Fri, 15 Dec 2023 15:42:38 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E67A2228A24;
 Fri, 15 Dec 2023 15:42:38 +0100 (CET)
Received: from [10.252.23.141] (10.252.23.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Dec
 2023 15:42:38 +0100
Message-ID: <5476f3a0-523e-4fbe-ad8e-1b9b8c6729d2@foss.st.com>
Date: Fri, 15 Dec 2023 15:42:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] ARM: dts: stm32: make the LTDC clock usable by the
 clock driver
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20231211220643.1073606-1-dario.binacchi@amarulasolutions.com>
 <20231211220643.1073606-3-dario.binacchi@amarulasolutions.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20231211220643.1073606-3-dario.binacchi@amarulasolutions.com>
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
> of the LTDC clock.
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
>  arch/arm/dts/stm32f469-disco-u-boot.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/dts/stm32f469-disco-u-boot.dtsi b/arch/arm/dts/stm32f469-disco-u-boot.dtsi
> index c07e2022e4a8..dcc70369cd0d 100644
> --- a/arch/arm/dts/stm32f469-disco-u-boot.dtsi
> +++ b/arch/arm/dts/stm32f469-disco-u-boot.dtsi
> @@ -134,6 +134,10 @@
>  	bootph-all;
>  };
>  
> +&ltdc {
> +	clocks = <&rcc 0 STM32F4_APB2_CLOCK(LTDC)>;
> +};
> +
>  &pinctrl {
>  	bootph-all;
>  
Applied to u-boot-stm32/next

Thanks
Patrice
