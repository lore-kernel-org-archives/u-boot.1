Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1514C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 13:25:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ABB387C0F;
	Fri, 19 Jan 2024 14:25:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="M1/G8XBS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF96B87BF9; Fri, 19 Jan 2024 14:25:04 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F7EC87C5A
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 14:25:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=17487c629f=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40JBGaqB022593; Fri, 19 Jan 2024 14:24:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=J+BTJ/VOnkL4WOaAH8V7uucTpTcbesH/XHJuW6zXVbI=; b=M1
 /G8XBSrkx5cTueImXe3bPF2p9YIFK+SNNH0XbpxfQ0GoXCgWX2gxEhmwsNFdk5qd
 5lRgtKKKKUlArJaeopc9SJY5ipq3wlZugppPOP0/8GFOc5vGKpnu2cB3E2q2TDh7
 yxChS5jvhqSDcS2cWv7xORXZpqwVYTKyh6QoMGoUmAjr51+VGzz9dxslDh68oZKh
 Ic+HGgx3YOzGRl+WR/1+1531Buhm8vhHd1x57lDo75hPhGm4V4nuZqD1LJtISgic
 pxf3yFj36BoHrVDYKKk0F6/6rO9PqA833rtQlsVwfzWcTZPqQDCtZQKE1Wj/xjbM
 E0lc7/lR7Rr1ObzZ0lgw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkmbhnu54-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jan 2024 14:24:59 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2B476100081;
 Fri, 19 Jan 2024 14:24:59 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 22E1B245501;
 Fri, 19 Jan 2024 14:24:59 +0100 (CET)
Received: from [10.252.4.250] (10.252.4.250) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Jan
 2024 14:24:58 +0100
Message-ID: <c0f5139c-dd7c-4cb9-bb72-20aa200160d6@foss.st.com>
Date: Fri, 19 Jan 2024 14:24:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] stm32mp: bsec: add support of stm32mp25
Content-Language: en-US
To: Patrick Delaunay <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: Igor Opaniuk <igor.opaniuk@foundries.io>, Marek Vasut <marex@denx.de>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, Simon Glass
 <sjg@chromium.org>, U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240115140557.57448-1-patrick.delaunay@foss.st.com>
 <20240115150451.v2.4.I81fedd3d2ff9635b3738dd1ef349c936bc9b433d@changeid>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240115150451.v2.4.I81fedd3d2ff9635b3738dd1ef349c936bc9b433d@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.4.250]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_08,2024-01-19_02,2023-05-22_02
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



On 1/15/24 15:05, Patrick Delaunay wrote:
> Add support of BSEC for STM32MP25x family to access OTP.
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
> (no changes since v1)
> 
>  arch/arm/mach-stm32mp/bsec.c               | 7 +++++++
>  arch/arm/mach-stm32mp/include/mach/stm32.h | 3 ++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-stm32mp/bsec.c b/arch/arm/mach-stm32mp/bsec.c
> index 705c994d9307..5b869017ec1a 100644
> --- a/arch/arm/mach-stm32mp/bsec.c
> +++ b/arch/arm/mach-stm32mp/bsec.c
> @@ -784,9 +784,16 @@ static const struct stm32mp_bsec_drvdata stm32mp15_data = {
>  	.size = 96,
>  	.ta = false,
>  };
> +
> +static const struct stm32mp_bsec_drvdata stm32mp25_data = {
> +	.size = 368, /* 384 but no access to HWKEY and STM32PRVKEY */
> +	.ta = true,
> +};
> +
>  static const struct udevice_id stm32mp_bsec_ids[] = {
>  	{ .compatible = "st,stm32mp13-bsec", .data = (ulong)&stm32mp13_data},
>  	{ .compatible = "st,stm32mp15-bsec", .data = (ulong)&stm32mp15_data},
> +	{ .compatible = "st,stm32mp25-bsec", .data = (ulong)&stm32mp25_data},
>  	{}
>  };
>  
> diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-stm32mp/include/mach/stm32.h
> index 46d469881b32..45c929aa605d 100644
> --- a/arch/arm/mach-stm32mp/include/mach/stm32.h
> +++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
> @@ -197,7 +197,8 @@ enum forced_boot_mode {
>  #ifdef CONFIG_STM32MP25X
>  #define BSEC_OTP_SERIAL	5
>  #define BSEC_OTP_RPN	9
> -#define BSEC_OTP_PKG	246
> +#define BSEC_OTP_PKG	122
> +#define BSEC_OTP_MAC	247
>  #endif
>  
>  #ifndef __ASSEMBLY__
Applied to u-boot-stm32/master

Thanks
Patrice
