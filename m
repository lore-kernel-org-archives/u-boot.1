Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6711BC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:08:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83F9488113;
	Fri, 14 Jun 2024 14:08:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="U9iIVbqh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 404D788176; Fri, 14 Jun 2024 14:08:26 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6000D880F5
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6895721e93=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EAQP4L027034;
 Fri, 14 Jun 2024 14:08:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 Qhy6L+1td9UQDbZLtUCX6jrxDayc4A+3ZcRs6lCkYtM=; b=U9iIVbqhWAzryVpw
 lpDxonJ2D8xKMygHmKdFGunefAXE9YT1R6w/A5sj/z0eVeEFztwfipvWojKirFQD
 9hrw3S3iIB7KnrwB4Hvs01G47MSq0k+0ISXk+Qk1Dz3c6QB/Lj0NKzZ8SUTjc+7O
 2PYpoQ32/K4Uxh/wD9U5uFH5ukw5xAyOvY+hgTu4Ow7+HoW1P4duLKv/u4E/ZMlk
 xccdEDbUmI3bm+coxCX1GYM/eF/mCTWGuYjxa+uVQ62a/UDO1vyzYFeb11/uGWMS
 CzXnC5eBhqocK1u6hSIss7iHtLF+rJBtpTTu9Kk0AA4kmYaTb+++RCeaPL0jVk/O
 0EU9BQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yrfuj9nya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jun 2024 14:08:23 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 62ABF4002D;
 Fri, 14 Jun 2024 14:08:19 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1E3B52132FD;
 Fri, 14 Jun 2024 14:08:11 +0200 (CEST)
Received: from [10.252.18.60] (10.252.18.60) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 14 Jun
 2024 14:08:10 +0200
Message-ID: <eabeff42-ecc4-4e1e-a406-04a20a45bcc7@foss.st.com>
Date: Fri, 14 Jun 2024 14:08:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dts: stm32mp157c-odyssey: set PLL4_P to 125Mhz for
 ETH_CLK
To: Heesub Shin <heesub@gmail.com>, <u-boot@lists.denx.de>
References: <20240428142406.28445-1-heesub@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240428142406.28445-1-heesub@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.18.60]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_09,2024-06-14_03,2024-05-17_01
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



On 4/28/24 16:24, Heesub Shin wrote:
> Odyssey board requires ETH_CLK of 125Mhz. This commit sets PLL4_P/Q/R to
> 125, 62.5 and 62.5Mhz in respectively.
> 
> Signed-off-by: Heesub Shin <heesub@gmail.com>
> ---
>  arch/arm/dts/stm32mp157c-odyssey-som-u-boot.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/dts/stm32mp157c-odyssey-som-u-boot.dtsi b/arch/arm/dts/stm32mp157c-odyssey-som-u-boot.dtsi
> index b780dbd95e..d07fdcf4bc 100644
> --- a/arch/arm/dts/stm32mp157c-odyssey-som-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp157c-odyssey-som-u-boot.dtsi
> @@ -115,11 +115,11 @@
>  		bootph-all;
>  	};
>  
> -	/* VCO = 594.0 MHz => P = 99, Q = 74, R = 74 */
> +	/* VCO = 750.0 MHz => P = 125, Q = 62.5, R = 62.5 */
>  	pll4: st,pll@3 {
>  		compatible = "st,stm32mp1-pll";
>  		reg = <3>;
> -		cfg = < 3 98 5 7 7 PQR(1,1,1) >;
> +		cfg = < 3 124 5 9 9 PQR(1,1,1) >;
>  		bootph-all;
>  	};
>  };

Applied to u-boot-stm32/next

Thanks
Patrice
