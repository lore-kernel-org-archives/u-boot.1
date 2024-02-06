Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B998C48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 14:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A52DD87C7D;
	Tue,  6 Feb 2024 15:07:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="j68lk8Uh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E960287CA6; Tue,  6 Feb 2024 15:07:39 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EE2287C78
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 15:07:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416E7Y68041765;
 Tue, 6 Feb 2024 08:07:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707228454;
 bh=YRDacwXy1IEfqkv52HmHIUPTDDefwMIkLHnB/QcBNxw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=j68lk8UhXDyJxwJaVz5UqPHe1E+8BynQXML1HIqx1hjyi7kuxzHz+C4okAYxvgMgn
 yfd+W3I731yFRKGIfnwd3Pc7OAwIv+tJLZ8wFo7Yur50MiQyAvWt+ZUXexs0/mzqe+
 5jmhFzN+i/yfxy8CZ0TfN10u4o3Hrfv7RClfbrq4=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416E7YHT058138
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 Feb 2024 08:07:34 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 08:07:34 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 08:07:34 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416E7Ubo091504;
 Tue, 6 Feb 2024 08:07:31 -0600
Message-ID: <092b59f2-681e-4ddf-9a09-d34a18d5efce@ti.com>
Date: Tue, 6 Feb 2024 19:37:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] DONOTMERGE: arm: dts: j721s2: Fix Power domain for
 VTM node.
Content-Language: en-US
To: Manorit Chawdhry <m-chawdhry@ti.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Aniket Limaye <a-limaye@ti.com>, Tom Rini
 <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis
 <afd@ti.com>, Nishanth Menon <nm@ti.com>, <u-kumar1@ti.com>
References: <20240206-b4-upstream-j721s2-avs-v1-0-b75043c59969@ti.com>
 <20240206-b4-upstream-j721s2-avs-v1-9-b75043c59969@ti.com>
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240206-b4-upstream-j721s2-avs-v1-9-b75043c59969@ti.com>
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


On 2/6/2024 5:51 PM, Manorit Chawdhry wrote:
> Patch is sent to upstream linux [0].
>
> [0]: https://lore.kernel.org/all/20240201-b4-upstream-j721s2-fix-vtm-devid-v2-0-85fd568b77e3@ti.com/
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi b/arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi
> index 80aa33c58a45..a47cb557dd95 100644
> --- a/arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi
> +++ b/arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi
> @@ -663,7 +663,7 @@
>   		compatible = "ti,j7200-vtm";
>   		reg = <0x00 0x42040000 0x0 0x350>,
>   		      <0x00 0x42050000 0x0 0x350>;
> -		power-domains = <&k3_pds 154 TI_SCI_PD_SHARED>;
> +		power-domains = <&k3_pds 180 TI_SCI_PD_SHARED>;

I kind of disagree with this patch as Do not Merge, I understand you 
want to do this change as part of next sync.

But we got already node in u-boot for VTM with incorrect power-domain.

I am not sure, with incorrect power-domain, how AVS will be behave.

Here are my 2 cents

Either mark this patch part of series or Hold AVS till next sync


>   		#thermal-sensor-cells = <1>;
>   	};
>   
>
