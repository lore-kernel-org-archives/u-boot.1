Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5336DC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:39:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 953F487646;
	Tue, 19 Dec 2023 17:39:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="etkHbpxV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F9E487646; Tue, 19 Dec 2023 17:39:17 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 238E1876CF
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:39:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Date: Tue, 19 Dec 2023 17:39:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1703003953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=cK/AaOFDLVEx9iEuZGZs+3qZTk3OLZHPDC37L8bQzJQ=;
 b=etkHbpxV43XLFzTXYWvWI8iK7oAMKU+f0Fes+CJCLlFh/fzR7B/DSQj+6+iJsemadF9ESE
 ARYiSPIo788d28wvqYPUyvNhKJxhnz3MkUSByIdzlWox791CmY+VXTe7h8vSD0A3d0X3Jp
 HETrsEQ3IjWoRtth+G26MFekX1EZmkZUvVdFEDGeqvBsA+/FG2Y85bkKY7lWhilPE/1wQe
 S1HHs5LOWst5M/8btT4QkfmV6mMCiE0PkgmMXBqN3k4Rvq1cJHp1ipdxMHHYZ05eO75SqA
 u2NZmRIOLTFhMAV8RHreUDceVVO2FfqjVZ97sW/0R7Q8GeNpO6tceYG41WXzDQ==
From: Alexander Dahl <ada@thorsis.com>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Subject: Re: [PATCH 4/4] mtd: nand: raw: atmel: Remove duplicate definitions
Message-ID: <20231219-c9fb0a5045bd2aa69c2bdf2b@thorsis.com>
Mail-Followup-To: Eugen Hristev <eugen.hristev@collabora.com>,
 u-boot@lists.denx.de,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
References: <20231212160423.44290-1-ada@thorsis.com>
 <20231212160423.44290-5-ada@thorsis.com>
 <966f57cc-79c9-4a80-b561-a77575fcc7a0@collabora.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <966f57cc-79c9-4a80-b561-a77575fcc7a0@collabora.com>
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

Hello Eugen,

Am Tue, Dec 19, 2023 at 04:32:07PM +0200 schrieb Eugen Hristev:
> On 12/12/23 18:04, Alexander Dahl wrote:
> > These removed definitions were specific to some sam9 SoCs, but not
> > generic over all at91 SoCs.  The correct SoC specific definitions for
> > ATMEL_BASE_PMECC are spread over different header files in
> > arch/arm/mach-at91/include/mach directory.
> > 
> > Fixes a build error on a custon board based on SAMA5D2:
> > 
> >     Building current source for 73 boards (16 threads, 1 job per thread)
> >            arm:  +   vera2
> >     +drivers/mtd/nand/raw/atmel/pmecc.c:819: warning: "ATMEL_BASE_PMECC" redefined
> >     +  819 | #define ATMEL_BASE_PMECC        0xffffe000
> >     +      |
> >     +In file included from include/configs/vera2.h:11,
> >     +                 from include/config.h:3,
> >     +                 from include/linux/mtd/rawnand.h:16,
> >     +                 from drivers/mtd/nand/raw/atmel/pmecc.c:44:
> >     +include/asm/arch/sama5d2.h:171: note: this is the location of the previous definition
> >     +  171 | #define ATMEL_BASE_PMECC        (ATMEL_BASE_HSMC + 0x70)
> >     +drivers/mtd/nand/raw/atmel/pmecc.c:820: warning: "ATMEL_BASE_PMERRLOC" redefined
> >     +  820 | #define ATMEL_BASE_PMERRLOC     0xffffe600
> >     +include/asm/arch/sama5d2.h:172: note: this is the location of the previous definition
> >     +  172 | #define ATMEL_BASE_PMERRLOC     (ATMEL_BASE_HSMC + 0x500)
> > 
> > Fixes: a490e1b7c017 ("nand: atmel: Add pmecc driver")
> > Signed-off-by: Alexander Dahl <ada@thorsis.com>
> > ---
> >  drivers/mtd/nand/raw/atmel/pmecc.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
> > index e2e3f1ee6b5..51f6bd2e65b 100644
> > --- a/drivers/mtd/nand/raw/atmel/pmecc.c
> > +++ b/drivers/mtd/nand/raw/atmel/pmecc.c
> > @@ -816,9 +816,6 @@ int atmel_pmecc_wait_rdy(struct atmel_pmecc_user *user)
> >  }
> >  EXPORT_SYMBOL_GPL(atmel_pmecc_wait_rdy);
> >  
> > -#define ATMEL_BASE_PMECC	0xffffe000
> > -#define ATMEL_BASE_PMERRLOC	0xffffe600
> > -
> >  static struct atmel_pmecc *
> >  atmel_pmecc_create(struct udevice *dev,
> >  		   const struct atmel_pmecc_caps *caps,
> 
> 
> Hi Alexander,
> 
> What happens if we try to select and build this driver without
> sama5d2/sama5d3/sama5d4/sam9x5/sam9x60 ?
> Is it even possible ?

It is not possible on non-at91 boards because <mach/at91_sfr.h> is
included so you need to select arch at91.  But it is possible on older
sam9 boards like sam9260, sam9g20 and the like.  Tried that by using
at91sam9g20ek_nandflash_defconfig as a base, then disabling
CONFIG_NAND_ATMEL, then enabling CONFIG_DM_NAND_ATMEL (which activates
build of drivers/mtd/nand/raw/atmel/pmecc.c), then enabling some more
missing dependencies (CONFIG_MFD_ATMEL_SMC, CONFIG_REGMAP,
CONFIG_SYSCON) and then it builds just fine.

(btw: should those be selected or implied by CONFIG_DM_NAND_ATMEL in
'drivers/mtd/nand/raw/Kconfig' then in another patch or is this stuff
rather loose coupled?)

> Because it appears these defines are done for those SoCs in their
> mach header, but the driver uses them in any situation. 

I don't think so.  There are two drivers, the old one is
'drivers/mtd/nand/raw/atmel_nand.c' selected by CONFIG_NAND_ATMEL
while the new one is 'drivers/mtd/nand/raw/atmel/nand-controller.c'
selected by CONFIG_DM_NAND_ATMEL (note the extra sub-directory).  Only
the new one leads to building the file in question.  The symbols
removed from pmecc.c are not used in pmecc.c but only in the old
driver.  The scope of those removed symbols would have been in pmecc.c
only however, they are pointless at the place where they are currently
defined.  (Unless someone would #include that .c file, but that
seems rather unusual.)

And the part where the symbols of the same name are used is
conditionally built only if CONFIG_ATMEL_NAND_HW_PMECC is set.  From a
quick glance I would say that one is set only for newer boards, those
families you mentioned below.  But as said, all this is for the old
driver.

> And currently, these warnings are being ignored if the driver is
> built with sama5d2/sama5d3/sama5d4/sam9x5/sam9x60 ? 

The warning only popped up for a custom board build, where I include
<asm/arch/sama5d2.h> in file 'include/configs/myboard.h' and keep some
old definitions for the old driver and then switching from the old to
the new driver.  I did not see it for any mainline at91 defconfig.
Nevertheless I consider those defines wrong in that place.

> or the
> driver actually isn't even built with these platforms at all ?

It depends on the (def)config.  Currently in mainline U-Boot to my
knowledge the new driver is only used by sam9x60 and sam7g*something,
but it was ported from Linux and it should support all at91 SoCs.  I
think it is just a matter of who migrates all those boards to the new
driver?

> So, I guess it would be safer to do #ifndef ATMEL_BASE_PMECC, #define ...
> 
> Or, we could fix the driver to get these base addresses from the platform/DT ?

As said above.  The new driver does not these definitions at all, but
already gets these addresses from DT.  See sam9x60 curiosity for
example.

Greets
Alex

