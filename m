Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13BCC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 22:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EAFF880D1;
	Sat, 10 Aug 2024 00:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CIqTRbdA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AF6F88C39; Sat, 10 Aug 2024 00:11:09 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7DB58780E
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 00:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 479MB2R4096097;
 Fri, 9 Aug 2024 17:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723241462;
 bh=hLfbTlurhKFVEJRapskR+w3yzkpaAKjesGnPEDRESgw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=CIqTRbdAEA7WPqwxJFptfSMyqD8WPbQtplvtjyLQjlkWSYTJHbBssTaiLH2O/pzVN
 lDgayxezXHB4+aWgSesFI+jtnmxoFSSprWmn4SnUog/oB4E4ESd/Ovngnm6B9+ujZH
 0d8gjmEKvQMlTYkqVcsm1G0s20N7P+Zh7w9IMhgk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 479MB2Jp026143
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 9 Aug 2024 17:11:02 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Aug 2024 17:11:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Aug 2024 17:11:01 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 479MB1I9021531;
 Fri, 9 Aug 2024 17:11:01 -0500
Message-ID: <a0be94e4-9390-4d2c-8d76-ce647f631a78@ti.com>
Date: Fri, 9 Aug 2024 17:11:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] arch: arm: dts: k3-j784s4-r5-evm: Add missing fss
 range
To: Jonathan Humphreys <j-humphreys@ti.com>, Nishanth Menon <nm@ti.com>, Reid
 Tonking <reidt@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Hari Nagalla <hnagalla@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>, <eballetb@redhat.com>
CC: <u-boot@lists.denx.de>
References: <20240809211717.3887859-1-j-humphreys@ti.com>
 <20240809211717.3887859-2-j-humphreys@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240809211717.3887859-2-j-humphreys@ti.com>
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

On 8/9/24 4:17 PM, Jonathan Humphreys wrote:
> Upstream DTS added explicit ranges to the fss node.  It did not include the
> 32 bit memory space needed by the R5 to access OSPI.  With the upstream DTS
> sync, OSPI boot no longer works.
> 
> Adding the missing range here. It is also being added in the upstream DTS,
> so after the next upstream DTS sync, this patch can be removed. See
> f062a015f4 (arm64: dts: ti: k3-j784s4: Use exact ranges for FSS node)
> 
> Fixes: 5024a96db8e (Subtree merge tag 'v6.10-dts' of devicetree-rebasing

Fixes tags have "" around the name of the offending commit, and the name
does not linewrap, even if it is more than 80 chars.

> repo [1] into dts/upstream)
> 

No newline.

> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> Reviewed-by: Andrew Davis <afd@ti.com>
> ---
>   arch/arm/dts/k3-j784s4-r5-evm.dts | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-j784s4-r5-evm.dts b/arch/arm/dts/k3-j784s4-r5-evm.dts
> index bef4573d3d2..db963828916 100644
> --- a/arch/arm/dts/k3-j784s4-r5-evm.dts
> +++ b/arch/arm/dts/k3-j784s4-r5-evm.dts
> @@ -97,6 +97,12 @@
>   	      <0x0 0x58000000 0x0 0x8000000>;
>   };
>   
> +&fss {
> +	/* enable ranges missing from the fss node */

s/fss/FSS/

Andrew

> +	ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x00068400>,
> +	         <0x0 0x50000000 0x0 0x50000000 0x0 0x08000000>;
> +};
> +
>   &mcu_ringacc {
>   	ti,sci = <&dm_tifs>;
>   };
