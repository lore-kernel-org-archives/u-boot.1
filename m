Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24C2C54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 13:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06C0287D64;
	Wed,  6 Mar 2024 14:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AvCSJqvh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DCD187D64; Wed,  6 Mar 2024 14:17:09 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9B48879E2
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 14:17:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 426DH4mu067999;
 Wed, 6 Mar 2024 07:17:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709731024;
 bh=FUjwQQhGIqMSSkpZp/qzJS8n/O4rgFuy8qG+DKimA9M=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=AvCSJqvhED8pXjdh/wfXPTOsc2cx8avFC9se3c7BhIX7nl6tJRv1fvLdAE2aPAObW
 7KHhvjRhCO/zXrkqJQqvZOyP3Zg7CuJUxqxYsvmYddSpirg+Rj7VFhpR4+3RXABjwD
 eX6l39o+W9GEnqJnPqHYjxHicZ+DAl+zvBlORc9k=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 426DH42i006444
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Mar 2024 07:17:04 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Mar 2024 07:17:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Mar 2024 07:17:03 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 426DH0Sv005569;
 Wed, 6 Mar 2024 07:17:01 -0600
Message-ID: <6777d0be-7610-4d54-bd32-1b41ebe94035@ti.com>
Date: Wed, 6 Mar 2024 18:47:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm: dts: k3-j7200: Fix support for OSPI flash
Content-Language: en-US
To: Aniket Limaye <a-limaye@ti.com>, <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>
CC: <vaishnav.a@ti.com>, <a-nandan@ti.com>, Nishanth Menon <nm@ti.com>,
 <u-kumar1@ti.com>
References: <20240306063749.1411176-1-a-limaye@ti.com>
 <20240306063749.1411176-3-a-limaye@ti.com>
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240306063749.1411176-3-a-limaye@ti.com>
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


On 3/6/2024 12:07 PM, Aniket Limaye wrote:
> - Add the missing bootph-all property in the flash subnode for ospi
> - Add the missing overrides for the ospi node in the r5 devicetree

Please see , if you can add more on this why we are adding this

also, if this patch fixes some previous commit

>
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
>   arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi | 4 ++++
>   arch/arm/dts/k3-j7200-r5-common-proc-board.dts      | 5 +++++
>   2 files changed, 9 insertions(+)
>
> diff --git a/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
> index 60ca6d21ab..c9fee0ea99 100644
> --- a/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j7200-common-proc-board-u-boot.dtsi
> @@ -195,6 +195,10 @@
>   
>   &ospi0 {
>   	bootph-all;
> +
> +	flash@0 {
> +		bootph-all;
> +	};
>   };


Ideally this should come from kernel DT sync or with OF_UPSTREAM, 
whatever is applicable

As you are fixing broken OSPI boot.

Tom can suggest, if he is ok to pull in this fix for 2024.04 or we need 
to wait to get this change into kernel first.


>   
>   &serdes_ln_ctrl {
> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> index 018faaa13b..195637a836 100644
> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> @@ -83,3 +83,8 @@
>   &wkup_vtm0 {
>   	bootph-pre-ram;
>   };
> +
> +&ospi0 {
> +    reg = <0x0 0x47040000 0x0 0x100>,
> +          <0x0 0x50000000 0x0 0x8000000>;
> +};

With change in commit message,

Reviewed-by: Udit Kumar <u-kumar1@ti.com>



