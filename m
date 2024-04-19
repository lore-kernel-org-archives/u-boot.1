Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4252C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6439D88780;
	Fri, 19 Apr 2024 14:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="NWfzNn3h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21B6588786; Fri, 19 Apr 2024 14:12:53 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 341808876A
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43J8Nu2a018077; Fri, 19 Apr 2024 14:12:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=tBn8A+iHP+cDRpMCS7O8S7Rr2vx8fNtcX+huof1IU2I=; b=NW
 fzNn3hcwkchE5LUXjaO6oTA+/88khnKZTXe+rh1+kKSpQcA0BHsLuexFTT/I2pck
 ytnd3J/X9p8SAvQy1G7WKx0GjVYISFw4g4ispYrWzOsJZvXgnnFAjgAmJdgosUqX
 E2Ti1pCw+cfM08OlgQWlpIEyK/m3mN+lP8jtsUFGmvMLA8pP2aDG5v8BHHShCUla
 P3+yKBshpkEKt+UpSE8ikCLLWnumlm9pNZqZOqXG2aINV+ApnGyESexHN4WnVpbv
 YSY3tboXpQKZGTtrFnzHXrwnjW+o5u4DQslaUDLhyIyrfYAlQVKjkkVsyX9XYIUs
 1ToFmHSv08L1d6kZWDVg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xfhcx43mk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:12:41 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DACCF40044;
 Fri, 19 Apr 2024 14:12:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 150052194D8;
 Fri, 19 Apr 2024 14:12:10 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:12:09 +0200
Message-ID: <ef50d67f-dff9-4ab7-8d25-942f55006f1e@foss.st.com>
Date: Fri, 19 Apr 2024 14:12:09 +0200
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
X-Originating-IP: [10.252.13.94]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
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

Applied on u-boot-stm32/master 
