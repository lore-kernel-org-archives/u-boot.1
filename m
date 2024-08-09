Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0E0C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 02:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2632A88A44;
	Fri,  9 Aug 2024 04:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="duDJiiS7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93C0F88A79; Fri,  9 Aug 2024 04:04:02 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31B9B88A44
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 04:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47923rLB101525;
 Thu, 8 Aug 2024 21:03:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723169033;
 bh=5tSm9eo6qA5YNSwBE3LL+5yoUzs0bT8ODiLclbvcRKI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=duDJiiS785ONTxoun9NpJamvnoWfaA3tsFice0aIJlwuO8fP3IxOc2xFT4RTzyogd
 b1xDcrSY+47PVwScZ34SnPuXBZ2dCugm+fTJpkKgkgkrYoxudfZchpOqcWSk7aw/0T
 9/WGUqzILtBdlWl6dUf0dmpsQRS4LR+aQsLU1x38=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47923r9N054332
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 8 Aug 2024 21:03:53 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 21:03:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 21:03:54 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47923qgv112056;
 Thu, 8 Aug 2024 21:03:53 -0500
Message-ID: <8e3c11cd-56cf-4a98-a3b2-2236c94aa5cc@ti.com>
Date: Thu, 8 Aug 2024 21:03:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] arch: arm: dts: k3-j784s4-r5-evm: Add missing fss
 range
To: Jonathan Humphreys <j-humphreys@ti.com>, Nishanth Menon <nm@ti.com>, Reid
 Tonking <reidt@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Hari Nagalla <hnagalla@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>, <eballetb@redhat.com>
CC: <u-boot@lists.denx.de>
References: <20240808212926.3790223-1-j-humphreys@ti.com>
 <20240808212926.3790223-2-j-humphreys@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240808212926.3790223-2-j-humphreys@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 8/8/24 4:29 PM, Jonathan Humphreys wrote:
> Upstream DTS added explicit ranges to the fss node.  It did not include the
> 32 bit memory space needed by the R5 to access OSPI.  With the upstream DTS
> sync, OSPI boot no longer works.
> 
> Adding the missing range here. It is also being added in the upstream DTS,
> so after the next upstream DTS sync, this patch can be removed. See
> f062a015f4 (arm64: dts: ti: k3-j784s4: Use exact ranges for FSS node)
> 
> Fixes: 5024a96db8e (Subtree merge tag 'v6.10-dts' of devicetree-rebasing
> repo [1] into dts/upstream)
> 
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>   arch/arm/dts/k3-j784s4-r5-evm.dts | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-j784s4-r5-evm.dts b/arch/arm/dts/k3-j784s4-r5-evm.dts
> index bef4573d3d2..26af72d73f4 100644
> --- a/arch/arm/dts/k3-j784s4-r5-evm.dts
> +++ b/arch/arm/dts/k3-j784s4-r5-evm.dts
> @@ -97,6 +97,12 @@
>   	      <0x0 0x58000000 0x0 0x8000000>;
>   };
>   
> +&fss {
> +	/* enable ranges missing from the fss node */
> +	ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x00068400>,
> +					 <0x0 0x50000000 0x0 0x50000000 0x0 0x08000000>;

Looks like way too many tabs, do you have your editor set to 8 space tabs for DTS files?

Otherwise, LGTM,

Reviewed-by: Andrew Davis <afd@ti.com>

> +};
> +
>   &mcu_ringacc {
>   	ti,sci = <&dm_tifs>;
>   };
