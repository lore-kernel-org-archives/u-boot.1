Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3329CA0ED3
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 14:10:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9167388B27;
	Wed,  4 Sep 2024 16:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wfXw5gYR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF81588C7B; Wed,  4 Sep 2024 06:22:29 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE15988B49
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 06:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4844MQEx021379;
 Tue, 3 Sep 2024 23:22:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1725423746;
 bh=LvNHhtRIpH2/kuOaiygLuu9WxmJv1AkKBdZC2FzFHKA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=wfXw5gYRRaSbho1091mcjvdp0i/cT4+fDoiMeAxB5W9ZsaMYo2ftvzfusOPZ9cOmY
 oGbTuAXfFY1zeSjq7LWGtGqIPbiZndtsxlj7vQSKoj4L1YtIksrCYYsv+5ZKudb2Fo
 TpW/fYk3KUO9d16PQbMIG7ACHaZ1y2oOcwe/1NiQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4844MQ0F065259
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 3 Sep 2024 23:22:26 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Sep 2024 23:22:26 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Sep 2024 23:22:25 -0500
Received: from [172.24.23.68] (lt5cd2489kgj.dhcp.ti.com [172.24.23.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4844MLTa036909;
 Tue, 3 Sep 2024 23:22:22 -0500
Message-ID: <c5b230ea-a2f1-4502-a315-789a63b23d86@ti.com>
Date: Wed, 4 Sep 2024 09:52:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/6] arm: dts: k3-j784s4-main: Add PBIST_14 node
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>
References: <20240903114402.2155740-1-n-francis@ti.com>
 <20240903114402.2155740-3-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240903114402.2155740-3-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 04 Sep 2024 16:09:57 +0200
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


On 9/3/2024 5:13 PM, Neha Malcom Francis wrote:
> Add DT node for PBIST_14 that is responsible for triggering the BIST
> self-tests for the MAIN_R5_2_x cores.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi b/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
> index 6a4554c6c9c..5d9b0b6b59d 100644
> --- a/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
> +++ b/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
> @@ -2255,4 +2255,14 @@
>   			 */
>   		};
>   	};
> +
> +	bist_mcu14: bist@33c0000 {

Name shouldn't be mcu, if this is included in main .

Also consider to put this is kernel as well.


> +		compatible = "ti,j784s4-bist";
> +		reg = <0x00 0x033c0000 0x00 0x400>;
> +		clocks = <&k3_clks 237 7>;
> +		power-domains = <&k3_pds 237 TI_SCI_PD_EXCLUSIVE>;
> +		bootph-pre-ram;
> +		ti,bist-instance = <14>;
> +		cores-under-test = <&main_r5fss2_core0>, <&main_r5fss2_core1>;
> +	};
>   };
