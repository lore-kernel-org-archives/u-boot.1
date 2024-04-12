Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06273C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 00:27:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21E338751B;
	Fri, 12 Apr 2024 02:27:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="eCJaYrxk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D4C5881D6; Fri, 12 Apr 2024 02:27:29 +0200 (CEST)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2929B880A8
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 02:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
Date: Fri, 12 Apr 2024 10:26:29 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712881645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C79MHpb5FXNUzIHb5OhvlitgbAW0f4cNXhz2Z+SiqU8=;
 b=eCJaYrxkB/ATa3nGc0GnX4mW8hfP5nGARI9Q0wSKVIBe/nFxa86dKqgPKLwrRsfZhAyixV
 1mjSFwwv/sPP/3FwE9mHN1CQ+ur8r58xMbIdFBy2jKza3sWwJGBPmclg9TzIjhuIDHqb0p
 dNGe259iHS2dJHAFmMq0ShXRNxNaBu94nrdZevJBRv8HnaSN4GImoyo2fNM6H/N8jx+xzf
 EQ4P7not3VCeZaqiA05AnK02KoyqnNJIaPXrjPTx63/FPcJAxAQZ3hWHGgXcRR0GMSAocu
 vY7ZLo4sw5JfdfbiknurwNOd+lVonqxycIRydxyF/M5dzj23g27nQIxjynwQGA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Maksim Kiselev <bigunclemax@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH RFC 00/15] Support SPI NAND booting on the T113
Message-ID: <Zhh_tSXhCZFSjtnD@titan>
References: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
 <CAH5Ym4j_u8cx_efju70LxrirTH6g0_L_c_PGXO3H=L=cgB5S=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5Ym4j_u8cx_efju70LxrirTH6g0_L_c_PGXO3H=L=cgB5S=w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
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

On Thu, Apr 11, 2024 at 05:27:08PM -0600, Sam Edwards wrote:
> Hi John,
> 
> It doesn't look like I was sent the whole series (only 00 and 01), but
> I was able to find it on Patchwork and sift through it. A few general
> comments follow:
> 
> The introduction of `SUNXI_BOOTED_FROM_SPINAND` is the right call,
> since the newer sunxis use this for SPI-NAND, and
> `SUNXI_BOOTED_FROM_SPI` for SPI-NOR. The older sunxis, however, will
> use `SUNXI_BOOTED_FROM_SPI` for "it's either SPI-NAND or SPI-NOR, have
> fun figuring out which." While the rationale in 09/15 ("Instead of
> trying to boot from SPI NAND then SPI NOR in series, select one based
> on the current boot device.") is solid, we still need some code
> (perhaps in/called from `sunxi_get_boot_device`?) to handle the
> `SUNXI_BOOTED_FROM_SPI` case by performing flash type detection --
> disabled for those sunxis known to use `SUNXI_BOOTED_FROM_SPINAND`, of
> course.

Is there already code that can do this probing somewhere in U-Boot?
I'd rather not try and support older boards with an ambiguous boot
method, they already don't work.

> 06/15 ("sunxi: enable support for SPI NAND booting on SUNIV") should
> be dropped from the series. You are updating `suniv_get_boot_source`
> when introducing `SUNXI_BOOTED_FROM_SPINAND` anyway, so you can just
> hook up `SUNIV_BOOTED_FROM_NAND` at that time (and a heads-up: I think
> you got it wired backwards in this version of the series).

Some of the redunancy in patches are from including Icenowy's patchset.

> On a more fundamental note: I am hesitant about the overall approach
> of having NAND reading code in `arch/arm/mach-sunxi/spl_spi_sunxi.c`.
> NANDs are more complex than NORs (requiring e.g. bad block handling)
> and U-Boot generally keeps the SPL load methods in
> `common/spl/spl_*.c`. It's good that the UBI-on-SPI-NAND method is
> hooked up there, but the "U-Boot image follows the (good) blocks of
> the SPL in NAND" method should probably live in the same directory.
> 
> Here's what I'd like to explore: can we introduce a
> `common/spl/spl_spinand.c` and update the `drivers/mtd/nand/spi/*.c`
> code to support running in SPL? This way
> `arch/arm/mach-sunxi/spl_spi_sunxi.c` must only provide the SPL-mode
> implementation of SPI -- that is, the actual sunxi-specific bit. Also,
> updating the `drivers/mtd/nand/spi/*.c` drivers for SPL-friendliness
> will mean dropping those `SPL_SPINAND_{PAGE,BLOCK}_SIZE` configuration
> options: the tables in the drivers will be the ones providing those
> after NAND autodetection.

This is a little bit of a mess:

common/spl/spl_spi.c implements general SPI NOR reading
drivers/mtd/spi/sf-uclass.c wraps SPI flash access using DM
drivers/spi/spi-sunxi.c implements the SPI controller
arch/arm/mach-sunxi/spl_spi_sunxi.c overrides spl_spi

It would be good to somehow have spl_spi provide functions spl_spi
uses instead of having spl_spi_sunxi implement it directly.

common/spl/spl_nand.c implements general NAND reading
common/spl/spl_ubi.c implements UBI reading
drivers/mtd/nand/raw/sunxi_nand.c implements sunxi NAND reading
drivers/mtd/nand/raw/nand_spl_simple.c implmements a generic solution
drivers/mtd/nand/raw/sunxi_nand_spl.c implements sunxi SPL NAND reading

spl_ubi requires nand_spl_simple callbacks, sunxi_nand_spl doesn't
implement these.

It's possible spl_spi, spl_nand and spl_ubi all work if the DM code is
used for sunxi. Maybe that's a good goal here? Getting DM in SPL working
on these boards then hooking it in to spl_ubi seems like it could solve
some pain. I'm not too concerned about old SoCs at this point.

For non-DM Adding spl_spinand would work for the case of reading the
next good block. I'm not actually sure if the SPI NAND code supports the
bad block table yet. But we would still need an API for spl_ubi to
access.

> 
> Thoughts?
> 
> Cheers,
> Sam

John.
