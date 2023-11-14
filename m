Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7A7C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 05:37:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F351287129;
	Tue, 14 Nov 2023 06:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CgeYuFDe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 942998711A; Tue, 14 Nov 2023 06:37:12 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2DE58713E
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 06:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AE5b5dl024430;
 Mon, 13 Nov 2023 23:37:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699940225;
 bh=WdWHVgYJw1NT6sJ6vYx6UlsngNnZYgyvYewlWY056vA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=CgeYuFDeGQGNnIM+i2GjwR75TyLtx8QKDVraXlLyog5e+YiK9sjJo0HUcutMrqks4
 PsPVC5YyvIuDspL5JEGxO+R6k464N1tKoLZKwlJvkOJLr85OPPjReb5pbw1q0lz6xc
 Rft1bMJHJXIGmmwIMMNq5egsoHdEUDijYe74RuA8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AE5b5Ua097668
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 13 Nov 2023 23:37:05 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 23:37:05 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 23:37:05 -0600
Received: from [10.249.141.75] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AE5b1Sm013161;
 Mon, 13 Nov 2023 23:37:02 -0600
Message-ID: <dad98c6c-0951-4f21-a28c-7d8499147098@ti.com>
Date: Tue, 14 Nov 2023 11:07:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: k3-j7200: Sync with Linux 6.7-rc1
To: Reid Tonking <reidt@ti.com>, <trini@konsulko.com>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <m-chawdhry@ti.com>
References: <20231113204309.3246434-1-reidt@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20231113204309.3246434-1-reidt@ti.com>
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

Thanks Reid for sync.

On 11/14/2023 2:13 AM, Reid Tonking wrote:
> Sync u-boot device tree with Linux kernel 6.7-rc1
>
> Signed-off-by: Reid Tonking <reidt@ti.com>
> ---
> Boot-log: https://gist.github.com/reidt1/db5426f2a778369db8c3699cf293b94f
>
>   arch/arm/dts/k3-j7200-main.dtsi       | 2 +-
>   arch/arm/dts/k3-j7200-mcu-wakeup.dtsi | 9 ++++++++-
>   2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/dts/k3-j7200-main.dtsi b/arch/arm/dts/k3-j7200-main.dtsi
> index cdb1d6b2a9..264913f832 100644
> --- a/arch/arm/dts/k3-j7200-main.dtsi
> +++ b/arch/arm/dts/k3-j7200-main.dtsi
> @@ -91,7 +91,7 @@
>   	};
>   
>   	main_navss: bus@30000000 {
> -		compatible = "simple-mfd";
> +		compatible = "simple-bus";
>   		#address-cells = <2>;
>   		#size-cells = <2>;
>   		ranges = <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>;
> diff --git a/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi b/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi
> index 6ffaf85fa6..3fc588b848 100644
> --- a/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm/dts/k3-j7200-mcu-wakeup.dtsi
> @@ -318,7 +318,7 @@
>   	};
>   
>   	mcu_navss: bus@28380000 {
> -		compatible = "simple-mfd";
> +		compatible = "simple-bus";
>   		#address-cells = <2>;
>   		#size-cells = <2>;
>   		ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>;
> @@ -637,4 +637,11 @@
>   		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
>   		#thermal-sensor-cells = <1>;
>   	};
> +
> +	mcu_esm: esm@40800000 {
> +		compatible = "ti,j721e-esm";
> +		reg = <0x00 0x40800000 0x00 0x1000>;
> +		ti,esm-pins = <95>;
> +		bootph-pre-ram;
> +	};
>   };

Please take care of actual usage of this node

https://lore.kernel.org/all/20231003081038.24299-10-j-keerthy@ti.com/

https://lore.kernel.org/all/20231003081038.24299-11-j-keerthy@ti.com/

https://lore.kernel.org/all/838b07a0-8490-c05b-b08f-3ab6d3e1737a@ti.com/


