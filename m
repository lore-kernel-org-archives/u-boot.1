Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A13CC54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09E2C8309E;
	Tue, 27 May 2025 15:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="PlvfA/89";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 439B0830B3; Tue, 27 May 2025 15:27:36 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BA768309C
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=724286f330=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RBga1u000339;
 Tue, 27 May 2025 15:27:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 iBbFnd4KwnDGA2OgKLhFtgXflB47NenLgz7oA7l+f2U=; b=PlvfA/89uWl/YnZo
 SaFxzB7PxxMRzmUPRE842W35Ss6eQzNS4VdqJsO7j6WNYe0RitJH9V4xWtFptU11
 dptF7Cf4FL7RxkTtcwwagXoTHb08V2RkZgUDcgMm7Xi93wq/tao+cCQytOBBo/0d
 dklH8qnvDzdRbFUm0eagRfBpAmI5W6iyfyEgUeH5+AcIu0+5wHIlRv9bQ+HPKujT
 hLf0LQVtlWlfMN2LOEeGoOH9V+P9/SvQxCEwqc9CZcZi+ap/HPK181UwVou0UDOe
 nCj74+WynH3W8MMEaVlqVSFyTJNCHEzQXTN9CpMs923gGOMZS24tlOV6i6npMA5T
 dX/Rnw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46u50gkxky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 15:27:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2445240056;
 Tue, 27 May 2025 15:26:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BCA7CAEB8F1;
 Tue, 27 May 2025 15:26:37 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 15:26:37 +0200
Message-ID: <9492d28d-6b28-4f85-a822-1a66090bffc2@foss.st.com>
Date: Tue, 27 May 2025 15:26:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] dts: upstream: arm: st: stm32h7-pinctrl: change
 pins for USART1
To: Johannes Krottmayer <johannes@krotti42.com>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
 <20250508212058.640483-11-johannes@krotti42.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250508212058.640483-11-johannes@krotti42.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
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



On 5/8/25 23:24, Johannes Krottmayer wrote:
> The pins for USART1 have must be changed to other values, to
> support the STM32H747 discovery board.
> 
> Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>  dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi b/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi
> index 7f1d234e102..7d7c87aa2fe 100644
> --- a/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi
> +++ b/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi
> @@ -213,13 +213,13 @@
>  
>  	usart1_pins: usart1-0 {
>  		pins1 {
> -			pinmux = <STM32_PINMUX('B', 14, AF4)>; /* USART1_TX */
> +			pinmux = <STM32_PINMUX('A', 9, AF7)>; /* USART1_TX */
>  			bias-disable;
>  			drive-push-pull;
>  			slew-rate = <0>;
>  		};
>  		pins2 {
> -			pinmux = <STM32_PINMUX('B', 15, AF4)>; /* USART1_RX */
> +			pinmux = <STM32_PINMUX('A', 10, AF7)>; /* USART1_RX */
>  			bias-disable;
>  		};
>  	};


Hi Johannes

Same remark as Quentin did on Patch 9, don't update DT files from dts/upstream/src/... as
it's a synchronization with kernel device tree.
If you need a new pinctrl configuration for USART1, add a new one in kernel device tree
and submit it to kernel mailing list.

Thanks
Patrice
