Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718D6C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 05:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96FC888056;
	Wed, 14 Aug 2024 07:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="siNgEWvt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 064C28880F; Wed, 14 Aug 2024 07:35:12 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82ED78800C
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 07:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47E5Z6lt001338;
 Wed, 14 Aug 2024 00:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723613706;
 bh=ocuWj8crZISJ9omaEUSYHC/i3qdE6SF4RjCPmYAO6u0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=siNgEWvtbzjFfghU30DTljgw4WOTArdrZAfza2k6/l9OpwkHfSXjXVdPLr9F9+E10
 /vpxpYuXfR6NcNh4ni/2eRTjLTbrRsvymAXkKJ5q8S3jVbuacMHrpeKIdo4fzEKrdQ
 Fiu2XgZy5qjKTd+/YTXG1opFwmfG2TDy2ZxOFEWM=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47E5Z62Z121152
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 14 Aug 2024 00:35:06 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 00:35:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 00:35:05 -0500
Received: from [172.24.20.129] (lt5cd112gt3k.dhcp.ti.com [172.24.20.129])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47E5Z1ki126770;
 Wed, 14 Aug 2024 00:35:02 -0500
Message-ID: <8844498f-f2ca-42f1-a00b-e566d5bbeed4@ti.com>
Date: Wed, 14 Aug 2024 11:05:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] arch: arm: dts: k3-j7200-r5-evm: Add missing fss
 range
To: Jonathan Humphreys <j-humphreys@ti.com>, Nishanth Menon <nm@ti.com>, Reid
 Tonking <reidt@ti.com>, Udit Kumar <u-kumar1@ti.com>, Hari Nagalla
 <hnagalla@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Sumit Garg
 <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 <afd@ti.com>, <eballetb@redhat.com>
CC: <u-boot@lists.denx.de>
References: <20240809230157.3935118-1-j-humphreys@ti.com>
 <20240809230157.3935118-4-j-humphreys@ti.com>
Content-Language: en-US
From: "Limaye, Aniket" <a-limaye@ti.com>
In-Reply-To: <20240809230157.3935118-4-j-humphreys@ti.com>
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



On 8/10/2024 4:31 AM, Jonathan Humphreys wrote:
> Upstream DTS added explicit ranges to the fss node.  It did not include the
> 32 bit memory space needed by the R5 to access OSPI.  With the upstream DTS
> sync, OSPI boot no longer works.
> 
> Adding the missing range here. It is also being added in the upstream DTS,
> so after the next upstream DTS sync, this patch can be removed. See
> f00e626085 (arm64: dts: ti: k3-j7200: Use exact ranges for FSS node)
> 
> Fixes: 5024a96db8e ("Subtree merge tag 'v6.10-dts' of devicetree-rebasing repo [1] into dts/upstream")
> 
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>   arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 6 ++++++
>   1 file changed, 6 insertions(+)

LGTM,

Reviewed-by: Aniket Limaye <a-limaye@ti.com>

> 
> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> index fb7e2e50239..94760c78dd3 100644
> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> @@ -89,6 +89,12 @@
>             <0x0 0x50000000 0x0 0x8000000>;
>   };
>   
> +&fss {
> +	/* enable ranges missing from the FSS node */
> +	ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x00068400>,
> +	         <0x0 0x50000000 0x0 0x50000000 0x0 0x08000000>;
> +};
> +
>   &mcu_ringacc {
>       ti,sci = <&dm_tifs>;
>   };
