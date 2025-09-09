Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB61CAC583
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 13:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60E95830B4;
	Tue,  9 Sep 2025 15:54:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GxKIM6Q8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1BA183192; Tue,  9 Sep 2025 15:54:53 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7F5B8309E
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 15:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 589Dsnb04037644
 for <u-boot@lists.denx.de>; Tue, 9 Sep 2025 08:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757426089;
 bh=chI7bOGcVA951st77sd6mzrFpGH5PFDCDyP6YqYrerc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=GxKIM6Q8CoNbZnWe2KiLtS6KwN6FjeUJNO7nux0Z904BSHkQjKv6As/MPpFUbtVFB
 ZeaEKXMFDVQsXxUQ8AHkxOybp7w2DGiNRnIDxC9aSMUS5b6TTosdQGKQYLYWjOJkEf
 WFo+5BMAcbrTfdgwvPqgYLFh1i2khEmLGI8+pMeU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 589Dsn4r401811
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL)
 for <u-boot@lists.denx.de>; Tue, 9 Sep 2025 08:54:49 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 08:54:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 9 Sep 2025 08:54:49 -0500
Received: from [10.247.30.162] (ula0226330.dhcp.ti.com [10.247.30.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 589Dsmh62425311;
 Tue, 9 Sep 2025 08:54:48 -0500
Message-ID: <26171a54-6ee7-4292-b287-6a63c1ed0184@ti.com>
Date: Tue, 9 Sep 2025 08:54:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/5] arch: mach-k3: Introduce support for AM62D2-EVM
To: Paresh Bhagat <p-bhagat@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>,
 <nm@ti.com>
CC: <u-boot@lists.denx.de>, <bb@ti.com>, <khasim@ti.com>, <v-singh1@ti.com>,
 <anshuld@ti.com>
References: <20250909053429.444854-1-p-bhagat@ti.com>
 <20250909053429.444854-4-p-bhagat@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250909053429.444854-4-p-bhagat@ti.com>
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

On 9/9/25 12:34 AM, Paresh Bhagat wrote:
> Introduce the basic functions and definitions needed to properly

What "functions"?

> initialize TI's AM62D2-EVM.
> 
> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
> ---
>   arch/arm/mach-k3/am62ax/Kconfig | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/am62ax/Kconfig b/arch/arm/mach-k3/am62ax/Kconfig
> index f8cdcdca57a..e7ab299fe5d 100644
> --- a/arch/arm/mach-k3/am62ax/Kconfig
> +++ b/arch/arm/mach-k3/am62ax/Kconfig
> @@ -50,9 +50,34 @@ config TARGET_PHYCORE_AM62AX_R5
>   	select BINMAN
>   	imply SYS_K3_SPL_ATF
>   
> +config TARGET_AM62D2_A53_EVM
> +	bool "TI K3 based AM62D2 EVM running on A53"
> +	select ARM64
> +	select BINMAN
> +	imply BOARD
> +	imply SPL_BOARD
> +	imply TI_I2C_BOARD_DETECT
> +
> +config TARGET_AM62D2_R5_EVM
> +	bool "TI K3 based AM62D2 EVM running on R5"
> +	select CPU_V7R
> +	select SYS_THUMB_BUILD
> +	select K3_LOAD_SYSFW
> +	select RAM
> +	select SPL_RAM
> +	select K3_DDRSS
> +	select BINMAN
> +	imply SYS_K3_SPL_ATF
> +	imply TI_I2C_BOARD_DETECT
> +
>   endchoice
>   
> +if TARGET_AM62A7_A53_EVM || TARGET_AM62A7_R5_EVM

The Phycore boards are not our EVMs, you have them guarded by this
new if block. Why have these if block at all? The Kconfigs below
have the if checks already inside.

Andrew

>   source "board/ti/am62ax/Kconfig"
>   source "board/phytec/phycore_am62ax/Kconfig"
> +endif
>   
> +if TARGET_AM62D2_A53_EVM || TARGET_AM62D2_R5_EVM
> +source "board/ti/am62dx/Kconfig"
> +endif
>   endif

