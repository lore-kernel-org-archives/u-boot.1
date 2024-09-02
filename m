Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7C1CA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 22:36:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8169885C5;
	Tue,  3 Sep 2024 00:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4016788C87; Tue,  3 Sep 2024 00:36:00 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C2A2C882EF
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 00:35:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5907CFEC;
 Mon,  2 Sep 2024 15:36:23 -0700 (PDT)
Received: from [192.168.178.92] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 5B4683F73F; Mon,  2 Sep 2024 15:35:54 -0700 (PDT)
Message-ID: <354eadd1-6264-4e1b-817f-1530210a25fb@arm.com>
Date: Mon, 2 Sep 2024 23:35:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 6/9] sunxi: Correct TPR6 parameter for H616 DRAM driver
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, jagan@amarulasolutions.com, trini@konsulko.com,
 ryan@testtoast.com, iuncuim@gmail.com, sumit.garg@linaro.org,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240830155514.481410-1-macroalpha82@gmail.com>
 <20240830155514.481410-7-macroalpha82@gmail.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20240830155514.481410-7-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

On 30/08/2024 16:55, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Correct the default TPR6 parameter based on suggestion from Mikhail
> Kalashnikov. [1]
> 
> [1] https://lore.kernel.org/u-boot/4c003cab-c8b8-484d-924d-084e71fe666e@gmail.com/

I am confused, doesn't that change belong together with the one that 
masks bits[23:16] instead bits[15:8]? So that the same 0xc0 end up in 
that register?
Mikhail, can you confirm what the intention of your reply mentioned 
above was? To say that the vendor code masks the different set of bits, 
and to stay correct we also have to adjust the TPR6 default value?
For OPi Zero2W and OPi Zero3 those two bytes are the same, but for the 
Tanix TX1 and the default value they are not.

Cheers,
Andre

> Fixes: 4b02f0120a4b ("sunxi: H616: add LPDDR4 DRAM support")
> Suggested-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>   arch/arm/mach-sunxi/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index 078f8c19fa..5b3571025f 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -87,7 +87,7 @@ config DRAM_SUN50I_H616_TPR2
>   
>   config DRAM_SUN50I_H616_TPR6
>   	hex "H616 DRAM TPR6 parameter"
> -	default 0x3300c080
> +	default 0x33c00080
>   	help
>   	  TPR6 value from vendor DRAM settings.
>   
