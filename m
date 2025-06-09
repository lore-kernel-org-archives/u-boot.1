Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC112C5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 07:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F85F82B0E;
	Mon,  9 Jun 2025 09:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="mVjJA3Q7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 087A382958; Mon,  9 Jun 2025 09:57:41 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0BC282958
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 09:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=82553fdf62=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5597m5b6007924;
 Mon, 9 Jun 2025 09:57:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 1Mb8tRE6iWCjo3i87K8/EFXKFU7CLKLwRO/iJo5L5+s=; b=mVjJA3Q7lepI35L7
 vTt9gW5TB1mEO0F+P8RSs6/289wOQYdOF6SfUfDOwTiAujhi0mPWF3SH9ZVdMLOx
 tRc6RgQG/ygN9edoI9ZzjZh+IS07APlq/a3WE4JADPYxx4gvJvQLvNsuIDSboRJo
 7NXi2H+2vPw7WweVN1kn/Avcju6MMyeB1Q/+V32M/Us2JKQjcV37uPzqFRnjnadn
 WQihmVbHRYEnhRVeaPi5Z8v8aPmmD/+lQagHwVSrtc/YUNeaKCOwEJpH3hUhaBN2
 osM8M9zFPoJuAXujWUZ9PYFP27edGd/0W5jVGaFBwVEyziijPBbld1FyaXUHTqpn
 bp6BQQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 474y04uwa9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 09:57:25 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8901E40056;
 Mon,  9 Jun 2025 09:56:15 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D414DB722A9;
 Mon,  9 Jun 2025 09:55:28 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Jun
 2025 09:55:28 +0200
Message-ID: <92001465-40d2-4191-8564-fe2bfe57535a@foss.st.com>
Date: Mon, 9 Jun 2025 09:55:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] dt-bindings: arm: stm32: add compatible for
 stm32h747i-disco board
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
 <20250607093730.2249536-3-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250607093730.2249536-3-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_03,2025-06-05_01,2025-03-28_01
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



On 6/7/25 11:37, Dario Binacchi wrote:
> The board includes an STM32H747XI SoC with the following resources:
>  - 2 Mbytes Flash
>  - 1 MByte SRAM
>  - LCD-TFT controller
>  - MIPI-DSI interface
>  - FD-CAN
>  - USB 2.0 high-speed/full-speed
>  - Ethernet MAC
>  - camera interface
> 
> Detailed information can be found at:
> https://www.st.com/en/evaluation-tools/stm32h747i-disco.html
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Link: https://lore.kernel.org/r/20250427074404.3278732-3-dario.binacchi@amarulasolutions.com
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 
> [upstream commit: 815d49f61ea049075482161f897aa13e1ae30cbb ]
> 
> ---
> 
>  dts/upstream/Bindings/arm/stm32/stm32.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/dts/upstream/Bindings/arm/stm32/stm32.yaml b/dts/upstream/Bindings/arm/stm32/stm32.yaml
> index b6c56d4ce6b9..a0660a0b494f 100644
> --- a/dts/upstream/Bindings/arm/stm32/stm32.yaml
> +++ b/dts/upstream/Bindings/arm/stm32/stm32.yaml
> @@ -42,6 +42,10 @@ properties:
>                - st,stm32h743i-disco
>                - st,stm32h743i-eval
>            - const: st,stm32h743
> +      - items:
> +          - enum:
> +              - st,stm32h747i-disco
> +          - const: st,stm32h747
>        - items:
>            - enum:
>                - st,stm32h750i-art-pi
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
