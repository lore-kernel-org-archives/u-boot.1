Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A086C83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 07:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36C9B86454;
	Mon, 28 Aug 2023 09:34:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="s7DZXWvS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D4B186451; Mon, 28 Aug 2023 09:34:51 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF2E58642B
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 09:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37S7Yivg065480;
 Mon, 28 Aug 2023 02:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693208084;
 bh=Edl4SiAWmLBg+T5AVKjSVA8y1NbQFl6iExOxqViHP5E=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=s7DZXWvSjK0nC6VboNAfMYRuRDSQJDj348UbKhq2pJOyxiuN+yjgg/22PQJ1cwnMz
 pVt7ol5p1UiC6TtgRwlbmN841lJ30YzSyxKVUwBSZ1EsMakRguBj7nyooo4LuuRQLq
 Q4HOvmYVwgIfq9jduR33L5nUi+9FVVoBuU54Wkx0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37S7YifO018509
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Aug 2023 02:34:44 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Aug 2023 02:34:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Aug 2023 02:34:44 -0500
Received: from [10.24.68.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37S7Ye55013207;
 Mon, 28 Aug 2023 02:34:41 -0500
Message-ID: <3b853275-ac4d-f279-4e10-4cba8846de90@ti.com>
Date: Mon, 28 Aug 2023 13:04:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/6] k3-j721s2: Sync from Linux tag v6.5-rc1
Content-Language: en-US
To: Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Reid Tonking <reidt@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Andrew Davis <afd@ti.com>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v2-0-a5f141be40bc@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v2-3-a5f141be40bc@ti.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230816-b4-upstream-j721s2-r5-pinmux-v2-3-a5f141be40bc@ti.com>
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

Hi Manorit

On 25/08/23 16:47, Manorit Chawdhry wrote:
> The following commit syncs the device tree from Linux tag
> v6.5-rc1 to U-boot and fixes the following to be compatible with
> the future syncs -
> 

[...]

> diff --git a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> index c74e8e58ae81..022618b37c74 100644
> --- a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
> @@ -1,20 +1,19 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/

[...]

> +&cbass_mcu_wakeup {
>   	sysctrler: sysctrler {
>   		compatible = "ti,am654-system-controller";
> -		mboxes= <&mcu_secproxy 4>, <&mcu_secproxy 5>, <&sa3_secproxy 5>;
> +		mboxes= <&secure_proxy_mcu 4>, <&secure_proxy_mcu 5>, <&secure_proxy_sa3 5>;
>   		mbox-names = "tx", "rx", "boot_notify";
>   		bootph-pre-ram;
>   	};
> @@ -92,101 +67,17 @@
>   		ti,host-id = <3>;
>   		ti,secure-host;
>   		mbox-names = "rx", "tx";
> -		mboxes= <&mcu_secproxy 21>,
> -			<&mcu_secproxy 23>;
> +		mboxes= <&secure_proxy_mcu 21>,
> +			<&secure_proxy_mcu 23>;
>   		bootph-pre-ram;
>   	};
>   };
>   

Sorry I didn't catch this earlier before the review tag. But dm_tifs can be 
moved to the root node, see review comments in [1]

>   
>   /* Now include peripherals from each bus segment */
> 

[1] 
https://patchwork.ozlabs.org/project/uboot/patch/20230822185725.6718-1-reidt@ti.com/

-- 
Thanking You
Neha Malcom Francis
