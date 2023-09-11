Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81024EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 14:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4D4B86D77;
	Mon, 11 Sep 2023 16:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="icGFI3zO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FBEB86E45; Mon, 11 Sep 2023 16:59:44 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 686E586D11
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 16:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BExdUD047449;
 Mon, 11 Sep 2023 09:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694444379;
 bh=Wfc9yyzdlHSVosKckXS0QJ5NrtfoU8qnVMhGXINZRPw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=icGFI3zONz87oUZtWarYt0cLEJHV9cNjL1xvXiQ5tWidLJ9c7fNbbi3aK/AY3Ys2a
 5DhJZtaWCBrSdo0TAfWtpUoMgz2rmvKjXhxhEXCKucU0xy+oWlulzg1ZRkptqsqnk6
 YAeywGp5wQkgf13nOubmuXzjoGERODmYull8SBK4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BExd0D093735
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 11 Sep 2023 09:59:39 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 09:59:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 09:59:38 -0500
Received: from [10.249.141.75] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BExZ1g051217;
 Mon, 11 Sep 2023 09:59:36 -0500
Message-ID: <e8799043-46da-b00b-cb53-2889a512b82c@ti.com>
Date: Mon, 11 Sep 2023 20:29:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] config: j7200: removed not needed power config
To: Nishanth Menon <nm@ti.com>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>,
 <n-francis@ti.com>, <a-nandan@ti.com>
References: <20230911111946.749270-1-u-kumar1@ti.com>
 <20230911132120.otpxghrp27gtdr3a@filled>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230911132120.otpxghrp27gtdr3a@filled>
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

Thank you for suggestion Nishanth

On 9/11/2023 6:51 PM, Nishanth Menon wrote:
> On 16:49-20230911, Udit Kumar wrote:
>> [..]
> And maybe expand this patch so that it contains something like the
> following to prevent this from coming back again elsewhere?
>
> diff --git a/drivers/clk/ti/Kconfig b/drivers/clk/ti/Kconfig
> index fbcdefd889ae..aff1ba5ab43b 100644
> --- a/drivers/clk/ti/Kconfig
> +++ b/drivers/clk/ti/Kconfig
> @@ -36,7 +36,7 @@ config CLK_TI_MUX
>   
>   config CLK_TI_SCI
>   	bool "TI System Control Interface (TI SCI) clock driver"
> -	depends on CLK && TI_SCI_PROTOCOL && OF_CONTROL
> +	depends on CLK && TI_SCI_PROTOCOL && OF_CONTROL && !CLK_K3
>   	help
>   	  This enables the clock driver support over TI System Control Interface
>   	  available on some new TI's SoCs. If you wish to use clock resources
> @@ -44,24 +44,24 @@ config CLK_TI_SCI
>   
>   [..]
>   
>   config CLK_K3
>   	bool "Clock support for K3 SoC family of devices"
> -	depends on CLK
> +	depends on CLK && !CLK_TI_SCI
>   	help
>   	  Enables the clock translation layer from DT to device clocks.
>   

I think these may end up recursive dependency


> diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
> index 411c210756a3..9625764b304b 100644
> --- a/drivers/power/domain/Kconfig
> +++ b/drivers/power/domain/Kconfig
> @@ -92,14 +92,14 @@ config TEGRA186_POWER_DOMAIN
>   
>   config TI_SCI_POWER_DOMAIN
>   	bool "Enable the TI SCI-based power domain driver"
> -	depends on POWER_DOMAIN && TI_SCI_PROTOCOL
> +	depends on POWER_DOMAIN && TI_SCI_PROTOCOL && !TI_POWER_DOMAIN
>   	help
>   	  Generic power domain implementation for TI devices implementing the
>   	  TI SCI protocol.
>   
>   config TI_POWER_DOMAIN
>   	bool "Enable the TI K3 Power domain driver"
> -	depends on POWER_DOMAIN && ARCH_K3
> +	depends on POWER_DOMAIN && ARCH_K3 && !TI_SCI_POWER_DOMAIN
>   	help
>   	  Generic power domain implementation for TI K3 devices.
>   

and these too.

