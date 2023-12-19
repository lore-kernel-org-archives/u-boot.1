Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848A6C46CCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 14:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAD268715C;
	Tue, 19 Dec 2023 15:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="JpMYuj32";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3517E874ED; Tue, 19 Dec 2023 15:32:11 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09F9186FF4
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 15:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1702996328;
 bh=bF3EVa3ZwDgoFm6MmIc308Iz7Zw5I1KiJyuyX2Q88jI=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=JpMYuj32I+f9ca/cTRvvgJ1sUQ4Aq5UQX2dsdjGRW/eTK9ftR8w7oE3vW1LTQENNM
 7/8q0zI8yUAVLQSjUjJgk97rS1vqWDRaivywXbKLVeEB/LocwtMfhvLpxHKnF8LLiE
 1bW2ea0TFmJ1891Y5Ihd4RaDlRqi8uwC3Js2WnuP7faHsAoGsUnVOk0xxr+YEK5CCr
 nDU2V5lkc/pdJKlWXBIrjvVc/jfu0UZuILMHBYRIexkIqDO4yFE5OTUhg8y60u3kFS
 6clubG2n7GiwnvJXDgs66VC4GyDzYo/9plzi8/5tkUSSGwxZBqVDVZ1T56iefZyOi7
 FaiCSMsBzCazg==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 14807378148A;
 Tue, 19 Dec 2023 14:32:08 +0000 (UTC)
Message-ID: <966f57cc-79c9-4a80-b561-a77575fcc7a0@collabora.com>
Date: Tue, 19 Dec 2023 16:32:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mtd: nand: raw: atmel: Remove duplicate definitions
To: Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
References: <20231212160423.44290-1-ada@thorsis.com>
 <20231212160423.44290-5-ada@thorsis.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20231212160423.44290-5-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8
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

On 12/12/23 18:04, Alexander Dahl wrote:
> These removed definitions were specific to some sam9 SoCs, but not
> generic over all at91 SoCs.  The correct SoC specific definitions for
> ATMEL_BASE_PMECC are spread over different header files in
> arch/arm/mach-at91/include/mach directory.
> 
> Fixes a build error on a custon board based on SAMA5D2:
> 
>     Building current source for 73 boards (16 threads, 1 job per thread)
>            arm:  +   vera2
>     +drivers/mtd/nand/raw/atmel/pmecc.c:819: warning: "ATMEL_BASE_PMECC" redefined
>     +  819 | #define ATMEL_BASE_PMECC        0xffffe000
>     +      |
>     +In file included from include/configs/vera2.h:11,
>     +                 from include/config.h:3,
>     +                 from include/linux/mtd/rawnand.h:16,
>     +                 from drivers/mtd/nand/raw/atmel/pmecc.c:44:
>     +include/asm/arch/sama5d2.h:171: note: this is the location of the previous definition
>     +  171 | #define ATMEL_BASE_PMECC        (ATMEL_BASE_HSMC + 0x70)
>     +drivers/mtd/nand/raw/atmel/pmecc.c:820: warning: "ATMEL_BASE_PMERRLOC" redefined
>     +  820 | #define ATMEL_BASE_PMERRLOC     0xffffe600
>     +include/asm/arch/sama5d2.h:172: note: this is the location of the previous definition
>     +  172 | #define ATMEL_BASE_PMERRLOC     (ATMEL_BASE_HSMC + 0x500)
> 
> Fixes: a490e1b7c017 ("nand: atmel: Add pmecc driver")
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  drivers/mtd/nand/raw/atmel/pmecc.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
> index e2e3f1ee6b5..51f6bd2e65b 100644
> --- a/drivers/mtd/nand/raw/atmel/pmecc.c
> +++ b/drivers/mtd/nand/raw/atmel/pmecc.c
> @@ -816,9 +816,6 @@ int atmel_pmecc_wait_rdy(struct atmel_pmecc_user *user)
>  }
>  EXPORT_SYMBOL_GPL(atmel_pmecc_wait_rdy);
>  
> -#define ATMEL_BASE_PMECC	0xffffe000
> -#define ATMEL_BASE_PMERRLOC	0xffffe600
> -
>  static struct atmel_pmecc *
>  atmel_pmecc_create(struct udevice *dev,
>  		   const struct atmel_pmecc_caps *caps,


Hi Alexander,

What happens if we try to select and build this driver without
sama5d2/sama5d3/sama5d4/sam9x5/sam9x60 ?
Is it even possible ?
Because it appears these defines are done for those SoCs in their mach header, but
the driver uses them in any situation. And currently, these warnings are being
ignored if the driver is built with sama5d2/sama5d3/sama5d4/sam9x5/sam9x60 ? or the
driver actually isn't even built with these platforms at all ?

So, I guess it would be safer to do #ifndef ATMEL_BASE_PMECC, #define ...

Or, we could fix the driver to get these base addresses from the platform/DT ?

Eugen
