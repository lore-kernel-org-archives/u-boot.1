Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FA4D0EE12
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 16:26:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69CC58937B;
	Fri, 11 Oct 2024 18:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="d/lgNkat";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E026C89380; Fri, 11 Oct 2024 18:26:15 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0017A8936A
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 18:26:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0014bb5f26=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BCJBEX014745;
 Fri, 11 Oct 2024 18:26:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 GbcC0zfRo48peS3mQZbZ1Ye6pPQolT2hmx+7a40FT4s=; b=d/lgNkatC+Wc/TI6
 SOkoldmGjqjCN9L3vKGPMRC1Mitt+g3xINsmPLp1lE80HezzvvORJdIBS6oKyfBZ
 BoJ6DMo7AeJcRSBBPzjCT8Dq9XN2iTSbeJx9KBaFq2mjBkXBa6zrMsJwGVHtwtKm
 LsEGynPBQ/OaYeHa7lnk4jvTMvY7NTx305i5b4Hzo6vngl2NDfceRA88tXeqBMdy
 yHB9EHd8W2PB+aV6kX2OnX6bQw1RVB6OeufXdulNFkQSDKIKwkJv7TuEETM3tg+s
 hRlubKQEYhgdRSz1mYHB8VwVJV3txkFERVG+DzsrQa2gwwZpg8f069DXjP7cTRMY
 jguJXA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 425w9xjs3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Oct 2024 18:26:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 18BC3400C9;
 Fri, 11 Oct 2024 18:24:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3A19A2AC581;
 Fri, 11 Oct 2024 18:23:34 +0200 (CEST)
Received: from [10.48.86.243] (10.48.86.243) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 11 Oct
 2024 18:23:33 +0200
Message-ID: <bdda6428-9f09-4038-82a7-62ff6bccef34@foss.st.com>
Date: Fri, 11 Oct 2024 18:23:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: stm32: Update MAINTAINERS file globs for STM32MP
 DHSOM
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20241004235641.395703-1-marex@denx.de>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20241004235641.395703-1-marex@denx.de>
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


On 10/5/24 01:56, Marek Vasut wrote:
> Update the MAINTAINERS file glob to cover all of STM32MP DHSOM related files.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
> V2: Use multiple N: instead of multiple F:
> ---
>   board/dhelectronics/dh_stm32mp1/MAINTAINERS | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/board/dhelectronics/dh_stm32mp1/MAINTAINERS b/board/dhelectronics/dh_stm32mp1/MAINTAINERS
> index 865588f5b8b..fdd579013a0 100644
> --- a/board/dhelectronics/dh_stm32mp1/MAINTAINERS
> +++ b/board/dhelectronics/dh_stm32mp1/MAINTAINERS
> @@ -2,8 +2,5 @@ DH_STM32MP1_PDK2 BOARD
>   M:	Marek Vasut <marex@denx.de>
>   L:	u-boot@dh-electronics.com
>   S:	Maintained
> -F:	arch/arm/dts/stm32mp15xx-dhcom*
> -F:	board/dhelectronics/dh_stm32mp1/
> -F:	configs/stm32mp15_dhcom_basic_defconfig
> -F:	configs/stm32mp15_dhcor_basic_defconfig
> -F:	include/configs/stm32mp15_dh_dhsom.h
> +N:	stm32mp.*dh[cs]o
> +N:	dh_stm32



Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

