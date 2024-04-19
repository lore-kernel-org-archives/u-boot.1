Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F666C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:30:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 464D888820;
	Fri, 19 Apr 2024 14:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="3/X3tbub";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 773A68881E; Fri, 19 Apr 2024 14:30:45 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 998CB88819
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43J9drOY009597; Fri, 19 Apr 2024 14:30:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=Q+lQFCSojiczd85iG9Ayo6k8i4kY9UNzjHGQotsgadE=; b=3/
 X3tbub0qLkkXrk2nF1p5P4jV19MWF/Uzblv33wHHxUUz+8l6IzjCJzKLMpcp1u+S
 MTGt0fffGFKVm06SjJBIkP4mx6MTLSTz6a+K0Ch82hJ10+qHNP73bqvV7+2C6eKr
 cS7NwcY6gxw7rYzVw07xCzrBAtKXeZCvzEiKGl/LM9cCikMocdoCykF4vF+B+K7q
 KaoytSyzLcJvZSYhN5c/DYtGndD4qnfNR1RNIL4JXnZSeT6jXJmYicxWMfdAIZnY
 9PVa59pS4pnIyeR7s5GlBk2AdxlNLLBe/tXeDOlM85Bm1BKO2uqr1dFWbVp6IpHK
 SsIceTEKiszM1sGztmAQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xff64uv5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:30:41 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 05D064002D;
 Fri, 19 Apr 2024 14:30:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7D47221ADAF;
 Fri, 19 Apr 2024 14:30:24 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:30:24 +0200
Message-ID: <585b1091-0df0-49fb-a651-b158987c0ed1@foss.st.com>
Date: Fri, 19 Apr 2024 14:30:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 23/25] ARM: dts: stm32: Don't probe red led at boot for
 stm32mp157c-ed1-scmi-u-boot
Content-Language: en-US
To: <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini <trini@konsulko.com>
References: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
 <20240409150215.2497778-24-patrice.chotard@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240409150215.2497778-24-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.13.94]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_08,2024-04-19_01,2023-05-22_02
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



On 4/9/24 17:02, Patrice Chotard wrote:
> red led and button dedicated to fastboot share the same gpio GPIOA13.
> Led driver is probed early so the corresponding gpio is taken and
> configured in output which forbid fastboot and stm32prog button usage.
> 
> To avoid this, remove the "default-state" property from red led node.
> 
> This will avoid to trigger the led driver probe() to configure the led
> default state during startup.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> 
>  arch/arm/dts/stm32mp157c-ed1-scmi-u-boot.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/dts/stm32mp157c-ed1-scmi-u-boot.dtsi b/arch/arm/dts/stm32mp157c-ed1-scmi-u-boot.dtsi
> index 84920f53496..2abd512e297 100644
> --- a/arch/arm/dts/stm32mp157c-ed1-scmi-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp157c-ed1-scmi-u-boot.dtsi
> @@ -37,7 +37,6 @@
>  		red {
>  			label = "error";
>  			gpios = <&gpioa 13 GPIO_ACTIVE_LOW>;
> -			default-state = "off";
>  			status = "okay";
>  		};
>  	};

Applied on u-boot-stm32/master 
