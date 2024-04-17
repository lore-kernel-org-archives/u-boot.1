Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B406C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 09:08:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C36AB88481;
	Wed, 17 Apr 2024 11:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="taslHmtc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C458788488; Wed, 17 Apr 2024 11:08:15 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E76288845C
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 11:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4837253909=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43H80X0m003792; Wed, 17 Apr 2024 11:08:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=WD9EKt+cZSm0VG0VBqFJBk+osKX3OptGPMwHhPan5cA=; b=ta
 slHmtcvAxIIQaBICmsLh3eGWPLH2UtZ/VgM2PxrbN02r/Burl5NjC0LB0a2uf6xX
 2SS/xL0iWMBRHhRWjbttKhA863V33I+Y+td2eF+aDk0aHgo2G7C9ZQWMYsg4m5ba
 IknACJkWxxwkMCTivleF+9mmQofNwPYe3NrlIar6CS4myXlG0XKQ3qg8zQfKij/0
 n1I35+vfEmxA2RxQGuUrAibrBIsP2iWJz6H/6CADlRl62hQ6TOzlptPU8Ia6v6Mh
 F/WOEyW/RBBcUNnUpj/TSuojd2qu9vJhJpnxBQnkV5tEmOJPK5ZpEhKQuB+3Mma+
 A4anjW1h4QLYgh7gUgJA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xffffh6mh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Apr 2024 11:08:12 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A2C9940044;
 Wed, 17 Apr 2024 11:08:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 88BDB210723;
 Wed, 17 Apr 2024 11:07:56 +0200 (CEST)
Received: from [10.48.86.112] (10.48.86.112) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 11:07:56 +0200
Message-ID: <6bf28011-bf01-429f-a941-31c835bce16c@foss.st.com>
Date: Wed, 17 Apr 2024 11:07:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/25] ARM: dts: stm32: Don't probe red led at boot for
 stm32mp157a-dk1-scmi-u-boot
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini
 <trini@konsulko.com>
References: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
 <20240409150215.2497778-12-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20240409150215.2497778-12-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.112]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_08,2024-04-16_01,2023-05-22_02
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
>   arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi b/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi
> index 5d49b09c35d..8760d6c7d93 100644
> --- a/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi
> @@ -39,7 +39,6 @@
>   		red {
>   			label = "error";
>   			gpios = <&gpioa 13 GPIO_ACTIVE_LOW>;
> -			default-state = "off";
>   			status = "okay";
>   		};
>   	};



Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

