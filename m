Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4877FC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 04:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 645C68786C;
	Wed, 24 Jan 2024 05:06:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="i6nTIF/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 701908793F; Wed, 24 Jan 2024 05:06:09 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6E118783B
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 05:06:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1706069166;
 bh=IFJesVkRZ5QqlVIfJc3XDJqK0ykxX2dFtJ1LxiwqZ84=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=i6nTIF/WsIqnnvIqYsLOrwpzyNxF+Gz0MrtvPLfriSoaSsvRsw1XIp7YzEG4VADt3
 pESa42FZ92K3WQNZUg+X1RN0X05Js9q8hrN2aZ2HlmCCmixC9yyDUsR03wKbO9FMLN
 k4nfODHLjjoGTdojVp/BXrfzCXm4UQspT25rPw5+A0W6kBeVK3nYDSpa9oTozID3hf
 26aEugmiEBycI1GkIzmeHFQAWoC7xlegzBcy+NBAb+FmPwS295EFxyrlCuogDjGe7l
 vPBNMa9jbQCbLiST5Ofy7km9vaGE1Ge7MfwztrxTRsTgk5N3l10H7MvAfCuNJLGzSI
 A+uZaMlTu1qFA==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id E183737810CD;
 Wed, 24 Jan 2024 04:06:04 +0000 (UTC)
Message-ID: <429bd0bd-0054-41c8-a6a1-44fdf6fa7370@collabora.com>
Date: Wed, 24 Jan 2024 06:06:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mtd: nand: raw: atmel: Remove duplicate definitions
Content-Language: en-US
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
References: <20231212160423.44290-1-ada@thorsis.com>
 <20231212160423.44290-5-ada@thorsis.com>
 <966f57cc-79c9-4a80-b561-a77575fcc7a0@collabora.com>
 <20231219-c9fb0a5045bd2aa69c2bdf2b@thorsis.com>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20231219-c9fb0a5045bd2aa69c2bdf2b@thorsis.com>
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

On 12/19/23 18:39, Alexander Dahl wrote:
> Hello Eugen,
> 
> Am Tue, Dec 19, 2023 at 04:32:07PM +0200 schrieb Eugen Hristev:
>> On 12/12/23 18:04, Alexander Dahl wrote:
>>> These removed definitions were specific to some sam9 SoCs, but not
>>> generic over all at91 SoCs.  The correct SoC specific definitions for
>>> ATMEL_BASE_PMECC are spread over different header files in
>>> arch/arm/mach-at91/include/mach directory.
>>>
>>> Fixes a build error on a custon board based on SAMA5D2:
>>>
>>>     Building current source for 73 boards (16 threads, 1 job per thread)
>>>            arm:  +   vera2
>>>     +drivers/mtd/nand/raw/atmel/pmecc.c:819: warning: "ATMEL_BASE_PMECC" redefined
>>>     +  819 | #define ATMEL_BASE_PMECC        0xffffe000
>>>     +      |
>>>     +In file included from include/configs/vera2.h:11,
>>>     +                 from include/config.h:3,
>>>     +                 from include/linux/mtd/rawnand.h:16,
>>>     +                 from drivers/mtd/nand/raw/atmel/pmecc.c:44:
>>>     +include/asm/arch/sama5d2.h:171: note: this is the location of the previous definition
>>>     +  171 | #define ATMEL_BASE_PMECC        (ATMEL_BASE_HSMC + 0x70)
>>>     +drivers/mtd/nand/raw/atmel/pmecc.c:820: warning: "ATMEL_BASE_PMERRLOC" redefined
>>>     +  820 | #define ATMEL_BASE_PMERRLOC     0xffffe600
>>>     +include/asm/arch/sama5d2.h:172: note: this is the location of the previous definition
>>>     +  172 | #define ATMEL_BASE_PMERRLOC     (ATMEL_BASE_HSMC + 0x500)
>>>
>>> Fixes: a490e1b7c017 ("nand: atmel: Add pmecc driver")
>>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
>>> ---
>>>  drivers/mtd/nand/raw/atmel/pmecc.c | 3 ---
>>>  1 file changed, 3 deletions(-)
>>>
>>> diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
>>> index e2e3f1ee6b5..51f6bd2e65b 100644
>>> --- a/drivers/mtd/nand/raw/atmel/pmecc.c
>>> +++ b/drivers/mtd/nand/raw/atmel/pmecc.c
>>> @@ -816,9 +816,6 @@ int atmel_pmecc_wait_rdy(struct atmel_pmecc_user *user)
>>>  }
>>>  EXPORT_SYMBOL_GPL(atmel_pmecc_wait_rdy);
>>>  
>>> -#define ATMEL_BASE_PMECC	0xffffe000
>>> -#define ATMEL_BASE_PMERRLOC	0xffffe600
>>> -
>>>  static struct atmel_pmecc *
>>>  atmel_pmecc_create(struct udevice *dev,
>>>  		   const struct atmel_pmecc_caps *caps,
>>
>>
>> Hi Alexander,
>>
>> What happens if we try to select and build this driver without
>> sama5d2/sama5d3/sama5d4/sam9x5/sam9x60 ?
>> Is it even possible ?
> 
> It is not possible on non-at91 boards because <mach/at91_sfr.h> is
> included so you need to select arch at91.  But it is possible on older
> sam9 boards like sam9260, sam9g20 and the like.  Tried that by using
> at91sam9g20ek_nandflash_defconfig as a base, then disabling
> CONFIG_NAND_ATMEL, then enabling CONFIG_DM_NAND_ATMEL (which activates
> build of drivers/mtd/nand/raw/atmel/pmecc.c), then enabling some more
> missing dependencies (CONFIG_MFD_ATMEL_SMC, CONFIG_REGMAP,
> CONFIG_SYSCON) and then it builds just fine.
> 
> (btw: should those be selected or implied by CONFIG_DM_NAND_ATMEL in
> 'drivers/mtd/nand/raw/Kconfig' then in another patch or is this stuff
> rather loose coupled?)

Hi Alexander,

I tried to look around the drivers and the symbols, but it appears enabling any
sort of driver makes things stop building, as the dependencies are not at all
stated correctly.
Thus, I cannot really answer that.
About this modification in particular, I ran the CI loop, it appears to be fine,
and I agree with the duplication, I was a bit reluctant to not break old platforms,
but since the CI says it's fine... I applied your set to u-boot-at91/master .

Eugen
> 
>> Because it appears these defines are done for those SoCs in their
>> mach header, but the driver uses them in any situation. 
> 
> I don't think so.  There are two drivers, the old one is
> 'drivers/mtd/nand/raw/atmel_nand.c' selected by CONFIG_NAND_ATMEL
> while the new one is 'drivers/mtd/nand/raw/atmel/nand-controller.c'
> selected by CONFIG_DM_NAND_ATMEL (note the extra sub-directory).  Only
> the new one leads to building the file in question.  The symbols
> removed from pmecc.c are not used in pmecc.c but only in the old
> driver.  The scope of those removed symbols would have been in pmecc.c
> only however, they are pointless at the place where they are currently
> defined.  (Unless someone would #include that .c file, but that
> seems rather unusual.)
> 
> And the part where the symbols of the same name are used is
> conditionally built only if CONFIG_ATMEL_NAND_HW_PMECC is set.  From a
> quick glance I would say that one is set only for newer boards, those
> families you mentioned below.  But as said, all this is for the old
> driver.
> 
>> And currently, these warnings are being ignored if the driver is
>> built with sama5d2/sama5d3/sama5d4/sam9x5/sam9x60 ? 
> 
> The warning only popped up for a custom board build, where I include
> <asm/arch/sama5d2.h> in file 'include/configs/myboard.h' and keep some
> old definitions for the old driver and then switching from the old to
> the new driver.  I did not see it for any mainline at91 defconfig.
> Nevertheless I consider those defines wrong in that place.
> 
>> or the
>> driver actually isn't even built with these platforms at all ?
> 
> It depends on the (def)config.  Currently in mainline U-Boot to my
> knowledge the new driver is only used by sam9x60 and sam7g*something,
> but it was ported from Linux and it should support all at91 SoCs.  I
> think it is just a matter of who migrates all those boards to the new
> driver?
> 
>> So, I guess it would be safer to do #ifndef ATMEL_BASE_PMECC, #define ...
>>
>> Or, we could fix the driver to get these base addresses from the platform/DT ?
> 
> As said above.  The new driver does not these definitions at all, but
> already gets these addresses from DT.  See sam9x60 curiosity for
> example.
> 
> Greets
> Alex
> 

