Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DA0C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 08:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1DAC881FE;
	Mon, 15 Apr 2024 10:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="hYmstKrR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A004388216; Mon, 15 Apr 2024 10:48:28 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFA5F88153
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 10:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4835aa2b69=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43F7BCHr000551; Mon, 15 Apr 2024 10:48:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=upVtUm/tIbsGphA2/+Vf3eyaRu62m7eDJnLYE3btJ7g=; b=hY
 mstKrRmvQDzDvdh5QS9MeoBScUatUsSltGlS++PaLSolR1i5ZXqCdo9SKUwtMcCD
 /AmcBm/gZKNiFTnxWGQwuYwkoC5/zPrObVn1k3bWHGt/IRD4A5XD/QlKUBRD6SAU
 k8Cbl+6AHFGgroiEBJi+WVQQ2JAXHPYgY735XvL/nKh3LVdPn/iXjRNwywW8aYE8
 e/rl4Vdnt+42jGUczm6UjNf5dENF+W2y0OLmvOMZg1w7lFhI33dr2iiW9P8r6MtE
 x0aPYXnGIyH3oX4sodjfOH3m4rHAd/dwLoZvO55pXkerup0OriHREex+Vm6FC82t
 efKU6irQ9lryi6vcJzGg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xg3m0cb2b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Apr 2024 10:48:16 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 20BC240055;
 Mon, 15 Apr 2024 10:48:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 51915211959;
 Mon, 15 Apr 2024 10:47:30 +0200 (CEST)
Received: from [10.48.86.98] (10.48.86.98) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Apr
 2024 10:47:29 +0200
Message-ID: <8c5a5d04-4659-4904-8446-4954c33381c1@foss.st.com>
Date: Mon, 15 Apr 2024 10:47:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: Report OTP-CLOSED instead of rev.? on closed
 STM32MP15xx
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Igor Opaniuk <igor.opaniuk@foundries.io>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240414183932.147045-1-marex@denx.de>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240414183932.147045-1-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.98]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_08,2024-04-09_01,2023-05-22_02
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



On 4/14/24 20:39, Marek Vasut wrote:
> SoC revision is only accessible via DBUMCU IDC register,
> which requires BSEC.DENABLE DBGSWENABLE bit to be set to
> make the register accessible, otherwise an access to the
> register triggers bus fault. As BSEC.DBGSWENABLE is zero
> in case of an OTP-CLOSED system, do NOT set DBGSWENABLE
> bit as this might open a brief window for timing attacks.
> Instead, report that this system is OTP-CLOSED and do not
> report any SoC revision to avoid confusing users. Use an
> SEC/C abbreviation to avoid growing SOC_NAME_SIZE .
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Igor Opaniuk <igor.opaniuk@foundries.io>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Simon Glass <sjg@chromium.org
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
> index afc56b02eea..dd99150fbc2 100644
> --- a/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
> +++ b/arch/arm/mach-stm32mp/stm32mp1/stm32mp15x.c
> @@ -322,8 +322,23 @@ void get_soc_name(char name[SOC_NAME_SIZE])
>  
>  	get_cpu_string_offsets(&type, &pkg, &rev);
>  
> -	snprintf(name, SOC_NAME_SIZE, "STM32MP%s%s Rev.%s",
> -		 soc_type[type], soc_pkg[pkg], soc_rev[rev]);
> +	if (bsec_dbgswenable()) {
> +		snprintf(name, SOC_NAME_SIZE, "STM32MP%s%s Rev.%s",
> +			 soc_type[type], soc_pkg[pkg], soc_rev[rev]);
> +	} else {
> +		/*
> +		 * SoC revision is only accessible via DBUMCU IDC register,
> +		 * which requires BSEC.DENABLE DBGSWENABLE bit to be set to
> +		 * make the register accessible, otherwise an access to the
> +		 * register triggers bus fault. As BSEC.DBGSWENABLE is zero
> +		 * in case of an OTP-CLOSED system, do NOT set DBGSWENABLE
> +		 * bit as this might open a brief window for timing attacks.
> +		 * Instead, report that this system is OTP-CLOSED and do not
> +		 * report any SoC revision to avoid confusing users.
> +		 */
> +		snprintf(name, SOC_NAME_SIZE, "STM32MP%s%s SEC/C",
> +			 soc_type[type], soc_pkg[pkg]);
> +	}
>  }
>  
>  static void setup_soc_type_pkg_rev(void)

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
