Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72422C369D9
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 14:36:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08A0E815D1;
	Tue, 22 Apr 2025 16:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gisvP5w2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8276A8171B; Tue, 22 Apr 2025 16:36:07 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A80EC8082A
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 16:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53MEa2oW1244003
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Apr 2025 09:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745332562;
 bh=/PUJkHOr/4lB45FQ1WpNVBMi5Fd6xxcXrS2t6F5RyeY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=gisvP5w2rtv2zFrYtWApnQ6guQuc1glp+zWRuKW8Hsdg1J2LOS3745QiYyF/yevqu
 s7PbwzVo7A+uRDpnnRShgRU/ZMv1c4ic2niS8ki1cKa+l8uDU8yTjE5c3/ib/8jBgY
 vbrFFogI8BQMyaoj+bOD0twuIDtxBS2aVW7Z1bAI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53MEa1wH099702
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Apr 2025 09:36:01 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Apr 2025 09:36:01 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Apr 2025 09:36:01 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53MEa1fb018525;
 Tue, 22 Apr 2025 09:36:01 -0500
Message-ID: <07f83df4-fa97-47be-bedb-8bafad560a4a@ti.com>
Date: Tue, 22 Apr 2025 09:36:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm: dts: k3-{j721s2/j784s4}-binman: Pack HSM
 firmware inside tispl.bin
To: Beleswar Padhi <b-padhi@ti.com>, <trini@konsulko.com>
CC: <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20250422095430.363792-1-b-padhi@ti.com>
 <20250422095430.363792-4-b-padhi@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250422095430.363792-4-b-padhi@ti.com>
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

On 4/22/25 4:54 AM, Beleswar Padhi wrote:
> Pack the HSM firmware in tispl.bin fit image so that it can be unloaded
> and used by R5 SPL to boot the HSM core. By default, point to the
> firmware for HS-SE device type. This needs to be changed to point to
> appropriate firmware when using a different device type.
> 
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>   arch/arm/dts/k3-j721s2-binman.dtsi | 12 ++++++++++++
>   arch/arm/dts/k3-j784s4-binman.dtsi | 14 ++++++++++++++
>   2 files changed, 26 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
> index d121d8c0c54..1e6cdf92421 100644
> --- a/arch/arm/dts/k3-j721s2-binman.dtsi
> +++ b/arch/arm/dts/k3-j721s2-binman.dtsi
> @@ -280,6 +280,14 @@
>   
>   					};
>   				};
> +#ifdef CONFIG_K3_HSM_FW

Is there some way to make this blob "optional" so that
we don't need all this #ifdef stuff everywhere? It makes
the image structures here harder to follow.

Andrew

> +				hsm {
> +					hsm: blob-ext {
> +						filename = "ti-hsm/hsm-demo-firmware-j721s2-hs.bin";
> +					};
> +				};
> +#endif
> +
>   				dm {
>   					ti-secure {
>   						content = <&dm>;
> @@ -312,7 +320,11 @@
>   				conf-0 {
>   					description = "k3-j721s2-common-proc-board";
>   					firmware = "atf";
> +#ifdef CONFIG_K3_HSM_FW
> +					loadables = "hsm", "tee", "dm", "spl";
> +#else
>   					loadables = "tee", "dm", "spl";
> +#endif
>   					fdt = "fdt-0";
>   				};
>   			};
> diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
> index 0553825b383..ab417a47034 100644
> --- a/arch/arm/dts/k3-j784s4-binman.dtsi
> +++ b/arch/arm/dts/k3-j784s4-binman.dtsi
> @@ -159,6 +159,16 @@
>   
>   		fit {
>   			images {
> +
> +#ifdef CONFIG_K3_HSM_FW
> +				hsm {
> +					hsm: blob-ext {
> +						filename = "ti-hsm/hsm-demo-firmware-j784s4-hs.bin";
> +					};
> +				};
> +
> +#endif
> +
>   				dm {
>   					ti-secure {
>   						content = <&dm>;
> @@ -194,7 +204,11 @@
>   				conf-0 {
>   					description = BOARD_DESCRIPTION;
>   					firmware = "atf";
> +#ifdef CONFIG_K3_HSM_FW
> +					loadables = "hsm", "tee", "dm", "spl";
> +#else
>   					loadables = "tee", "dm", "spl";
> +#endif
>   					fdt = "fdt-0";
>   				};
>   			};
