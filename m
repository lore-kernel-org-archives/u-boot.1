Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D5DC27C79
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 06:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83B2287B1A;
	Wed, 19 Jun 2024 08:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="7o2kJ9l9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFFC087923; Wed, 19 Jun 2024 08:35:58 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E84DF883F6
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 08:35:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=690026c4cb=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILZtve002573;
 Wed, 19 Jun 2024 08:35:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 oxI/oHpnVoYsBVI53472R7ZraxX6l42TM8cRUojKihA=; b=7o2kJ9l98RkAEdoh
 Lz5y+tD0Zz823gz0/vGa4/bR9Dvuf3c/eqHyJhBjLyIaeo9XxG323e8vKnvYKcCa
 zmKk09cKgE+eproJcOtC3EZvoq4vfvEKmP0DvtlC36E2z3HvII3gFm7IIoHrHFZ3
 +g/JbtG38T6Xbo8KcsQDl6D5XV8AF0uFFTRk14Rb6VOyBQiREwRtjC4NFf7QiGXL
 wvNvQtVW98UCwryZje6UiXatqMUTd/dhNONCXQcGcHUyMXNknS7V/AqGE1omxU9P
 c5yylAhSc+bFgE0z3Ng8/SbViJFMVo716mbuaR4SyKj7ydkFz8jc6WQSDwzwqmY4
 dyBGUQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yuj9n1gwn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jun 2024 08:35:55 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E607640048;
 Wed, 19 Jun 2024 08:35:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 95DA720FA3E;
 Wed, 19 Jun 2024 08:35:25 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 19 Jun
 2024 08:35:25 +0200
Message-ID: <2fd69224-c299-4b43-9078-07e06cc345f5@foss.st.com>
Date: Wed, 19 Jun 2024 08:35:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: Fix TAMP_SMCR BKP..PROT fields on STM32MP15xx
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240618225736.154959-1-marex@denx.de>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240618225736.154959-1-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-17_01,2024-05-17_01
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



On 6/19/24 00:57, Marek Vasut wrote:
> Update the TAMP_SMCR BKP..PROT fields to put first 10 registers
> into protection zone 1 and next 5 into zone 2. This fixes use of
> boot counter which is often in zone 3 and has to be updated from
> Linux, which runs in NS.
> 
> Fixes: 73f7fc944cf6 ("ARM: stm32: Initialize TAMP_SMCR BKP..PROT fields on STM32MP15xx")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
> index f096fe538d8..ca202bec8ee 100644
> --- a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
> +++ b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
> @@ -148,8 +148,8 @@ static void security_init(void)
>  	 */
>  	clrsetbits_le32(TAMP_SMCR,
>  			TAMP_SMCR_BKPRWDPROT | TAMP_SMCR_BKPWDPROT,
> -			FIELD_PREP(TAMP_SMCR_BKPRWDPROT, 0x20) |
> -			FIELD_PREP(TAMP_SMCR_BKPWDPROT, 0x20));
> +			FIELD_PREP(TAMP_SMCR_BKPRWDPROT, 0x0A) |
> +			FIELD_PREP(TAMP_SMCR_BKPWDPROT, 0x0F));
>  
>  	/* GPIOZ: deactivate the security */
>  	writel(BIT(0), RCC_MP_AHB5ENSETR);

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
