Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9FCE7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 12:50:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DB468903C;
	Thu,  5 Dec 2024 13:50:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="rT/Y3JCj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9904988FE8; Thu,  5 Dec 2024 13:50:08 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC661894A4
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 13:50:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=20690cba17=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5AKPMR019839;
 Thu, 5 Dec 2024 13:50:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 PpaGmXZ83EDxQNJOzQVz3dEIDXe2tdn1bLN1fgYB5K0=; b=rT/Y3JCjW5GfM5ce
 9Ylk6tli1dr+xVKlQzNFbQ5rnX2EmnAlmLF4mX63vN/53GaxK/CE5AbzO8P6h4gU
 47/v60TPlJ4mGwcy/SZmIIGotCnUQSPj5ooC7b5x+H8hTTTlhqje9a3Gc6YY/DtL
 kllAoTsaUM2bSMQdy2aJuWTSR3ZWMQO1UqM6bT+/LDF0oJ1krWGeba3bt8iS6Mne
 2a98ttwyCA4IcPb9caIGLKCwzNlpwiHuHZwUNjAp0xnDT/iBzOwzZFOc6fY28RUP
 lZF0HTW0BhHJzwUomqEnePQTES0jTlO2+WfNPl4f+9fpDk5ho9kUjEfQ5nREAmCn
 gZ0lGA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 437rq9fjg5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Dec 2024 13:50:01 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7E40D40046;
 Thu,  5 Dec 2024 13:49:06 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A1089217910;
 Thu,  5 Dec 2024 13:48:44 +0100 (CET)
Received: from [10.48.86.243] (10.48.86.243) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 5 Dec
 2024 13:48:44 +0100
Message-ID: <b4006420-b89c-488b-8148-5af4740f34bb@foss.st.com>
Date: Thu, 5 Dec 2024 13:48:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: st: stm32mp1: Clean env_get_location()
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Marek Vasut
 <marex@denx.de>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
References: <20241129124857.443093-1-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20241129124857.443093-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.243]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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

On 11/29/24 13:48, Patrice Chotard wrote:
> ENV_IS_IN_EXT4 flag is no more used in any STM32 defconfig,
> remove the related code.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   board/st/stm32mp1/stm32mp1.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/board/st/stm32mp1/stm32mp1.c b/board/st/stm32mp1/stm32mp1.c
> index d5e5e776d2a..15fb9e4b062 100644
> --- a/board/st/stm32mp1/stm32mp1.c
> +++ b/board/st/stm32mp1/stm32mp1.c
> @@ -751,8 +751,6 @@ enum env_location env_get_location(enum env_operation op, int prio)
>   	case BOOT_FLASH_EMMC:
>   		if (CONFIG_IS_ENABLED(ENV_IS_IN_MMC))
>   			return ENVL_MMC;
> -		else if (CONFIG_IS_ENABLED(ENV_IS_IN_EXT4))
> -			return ENVL_EXT4;
>   		else
>   			return ENVL_NOWHERE;
>   



Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

