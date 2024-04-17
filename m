Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFC0C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 09:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5257288431;
	Wed, 17 Apr 2024 11:00:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="wEP4IWJ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A47C488431; Wed, 17 Apr 2024 11:00:12 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B7DE8844A
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 11:00:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4837253909=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43H7cpwD005064; Wed, 17 Apr 2024 11:00:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=4QZidN/Nh6urgfOR8x04oBRtCDPYH17tPvBGGp3qM3Q=; b=wE
 P4IWJ2z0tC4yMecLWeMcKopNrfjlLW4lHgbfTz9798beG5g/iS+t8chry09nhwTP
 uutSCG4mGvUCIhT78WJgt6bNCW6X29MdypchygNbQ/1Ultsf5JZzb8QHF5J2+6RQ
 jDCET/MjfFsnG4Vk0Cb275qMfqjnANh2pxwT+T4GJ+Rp8CMOaauDLBy1YQvcdg0q
 k19BqbOBooJPmtvK9IjgWASt998gv2XIWyrXfzpw5syE6Lw8wIkIQeMZ8rG4hcjv
 mSZoiioYLEIEksRtt1VJ18vwHG9qBmt/RFuZ3z70rV+4Pjt4JNf54Z52ED48UC99
 4Wy8KWwMrm6shUiqpGlA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xffffh519-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Apr 2024 11:00:04 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9828C4002D;
 Wed, 17 Apr 2024 11:00:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A6626210598;
 Wed, 17 Apr 2024 10:59:41 +0200 (CEST)
Received: from [10.48.86.112] (10.48.86.112) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 10:59:41 +0200
Message-ID: <480ef8f6-2cc0-4014-8025-19b5c48a14fd@foss.st.com>
Date: Wed, 17 Apr 2024 10:59:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ARM: dts: stm32: Fix partition node name for
 stm32mp157c-ev1-u-boot
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Marek Vasut
 <marex@denx.de>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
References: <20240308135009.2621719-1-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20240308135009.2621719-1-patrice.chotard@foss.st.com>
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

On 3/8/24 14:50, Patrice Chotard wrote:
> Fix flash@0 and nand@0 partition node name with correct offset.
>
> Fixes: e91d3c61767b ("arm: dts: stm32: Add partitions in flash0 and nand
> node for stm32mp15xx-ev1")
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   arch/arm/dts/stm32mp157c-ev1-u-boot.dtsi | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/dts/stm32mp157c-ev1-u-boot.dtsi b/arch/arm/dts/stm32mp157c-ev1-u-boot.dtsi
> index 139940bd5d4..3515347e91d 100644
> --- a/arch/arm/dts/stm32mp157c-ev1-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp157c-ev1-u-boot.dtsi
> @@ -33,11 +33,11 @@
>   			label = "fsbl1";
>   			reg = <0x00000000 0x00040000>;
>   		};
> -		partition@80000 {
> +		partition@40000 {
>   			label = "fsbl2";
>   			reg = <0x00040000 0x00040000>;
>   		};
> -		partition@100000 {
> +		partition@80000 {
>   			label = "ssbl";
>   			reg = <0x00080000 0x00200000>;
>   		};
> @@ -58,7 +58,7 @@
>   			label = "fsbl2";
>   			reg = <0x00040000 0x00040000>;
>   		};
> -		partition@100000 {
> +		partition@80000 {
>   			label = "fip";
>   			reg = <0x00080000 0x00400000>;
>   		};
> @@ -112,7 +112,7 @@
>   					label = "fip2";
>   					reg = <0x00600000 0x00400000>;
>   				};
> -				partition@1200000 {
> +				partition@a00000 {
>   					label = "UBI";
>   					reg = <0x00a00000 0x3f600000>;
>   				};


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


