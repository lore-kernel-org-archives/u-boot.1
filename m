Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C1BC02196
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 14:09:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08B8A800B3;
	Tue,  4 Feb 2025 15:09:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TqhxGhSV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA5FF80207; Tue,  4 Feb 2025 15:09:50 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC96980040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 15:09:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 514E9jMB3229072
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Feb 2025 08:09:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738678185;
 bh=GI+J+QTkuBBhegRDbPlr8FVURv4fizx4q0BzODhYDkU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=TqhxGhSViidE71JXkSmeoq6qS4fviIic/CUrAZVja4YVRYNIRYgow79Q4lPTeOqY4
 H3pgVDbB/jJfvphLGVqV2bY4OxQveAepE4ysC1UtKj7CWkiC5SOnvUP3DONs9J0c2o
 ZnfXy2x3mOgdhbKJxIfQ29OlMxACRYw6dtF+9+PQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 514E9jFg015169
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 4 Feb 2025 08:09:45 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Feb 2025 08:09:45 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Feb 2025 08:09:45 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 514E9edH076296;
 Tue, 4 Feb 2025 08:09:41 -0600
Message-ID: <d7190a0a-2413-44cb-b403-6f3d51e64cbd@ti.com>
Date: Tue, 4 Feb 2025 19:39:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] DONOTMERGE: arm: dts: k3-j784s4-main: Add PBIST_14
 node
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-boot@lists.denx.de>
References: <20250204123147.939917-1-n-francis@ti.com>
 <20250204123147.939917-3-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250204123147.939917-3-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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


On 2/4/2025 6:01 PM, Neha Malcom Francis wrote:
> Add DT node for PBIST_14 that is responsible for triggering the PBIST
> self-tests for the MAIN_R5_2_x cores.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> Link to kernel DT upstreaming:
> https://lore.kernel.org/all/20241128140825.263216-1-n-francis@ti.com/

I think DONOTMERGE should be last :)


> Will be following up on its v2.
>
>   dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi b/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
> index 0160fe0da98..64f0339675d 100644
> --- a/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
> +++ b/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
> @@ -113,6 +113,18 @@
>   			status = "disabled";
>   		};
>   	};
> +
> +	bist_main14: bist@33c0000 {
> +		compatible = "ti,j784s4-bist";
> +		reg-names = "cfg", "ctrl_mmr";
> +		reg = <0x00 0x033c0000 0x00 0x400>,
> +			  <0x00 0x0010c1a0 0x00 0x01c>;
> +		clocks = <&k3_clks 237 7>;
> +		power-domains = <&k3_pds 237 TI_SCI_PD_EXCLUSIVE>;
> +		bootph-pre-ram;
> +		ti,bist-instance = <14>;
> +		cores-under-test = <&main_r5fss2_core0>, <&main_r5fss2_core1>;
> +	};
>   };
>   
>   &scm_conf {
