Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A918D6D25F
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 03:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EA9B8950F;
	Thu, 28 Nov 2024 04:58:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mkqVi13C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B545893A4; Thu, 28 Nov 2024 04:58:41 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D364E89825
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 04:58:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AS3wbFK072516;
 Wed, 27 Nov 2024 21:58:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732766317;
 bh=IzkU791AGfUeZ1LP1t+uiUJY7mMceqPA/Fp3RIXHUQo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=mkqVi13C2UVCjaDfD9M+6jEBsOpzXm3A6Vyzt4NJ2zskNXZGSIlpqr3NLKAkre7O9
 gkMmsMc5vu0R++vmT1dblO3xl2g/lYKF83ACp4TyiO+sTbATHTFFoG6uLRE4UZoV37
 CiFAZ4tm/Q3Pzvq0Dq/LWdi7rrePdFbkQUqknxQg=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AS3wbZ1064819
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Nov 2024 21:58:37 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Nov 2024 21:58:36 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Nov 2024 21:58:36 -0600
Received: from [172.24.23.130] (lt5cd2489kgj.dhcp.ti.com [172.24.23.130])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AS3wWxQ048633;
 Wed, 27 Nov 2024 21:58:33 -0600
Message-ID: <4515c566-2c7c-441b-8e31-279b64427a73@ti.com>
Date: Thu, 28 Nov 2024 09:28:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: dts: k3-j784s4-main: Add PBIST_14 node
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-boot@lists.denx.de>
References: <20241127145346.2609868-1-n-francis@ti.com>
 <20241127145346.2609868-2-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20241127145346.2609868-2-n-francis@ti.com>
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


On 11/27/2024 8:23 PM, Neha Malcom Francis wrote:
> Add DT node for PBIST_14 that is responsible for triggering the PBIST
> self-tests for the MAIN_R5_2_x cores.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi b/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
> index d4ac1c9872a..21e2777cd9d 100644
> --- a/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
> +++ b/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
> @@ -2782,4 +2782,16 @@
>   		power-domains = <&k3_pds 269 TI_SCI_PD_EXCLUSIVE>;
>   		status = "disabled";
>   	};
> +
> +	bist_main14: bist@33c0000 {
> +		compatible = "ti,j784s4-bist";
> +		reg-names = "cfg", "ctrl_mmr";
> +		reg = <0x00 0x033c0000 0x00 0x400>,
> +			  <0x00 0x0010c1a0 0x00 0x01c>;
> +		clocks = <&k3_clks 237 7>;

Please go through kernel route for device tree update.

Even this is getting applied, in next kernel-u-boot sync, we will be 
losing this node


> +		power-domains = <&k3_pds 237 TI_SCI_PD_EXCLUSIVE>;
> +		bootph-pre-ram;
> +		ti,bist-instance = <14>;
> +		cores-under-test = <&main_r5fss2_core0>, <&main_r5fss2_core1>;
> +	};
>   };
