Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E2BCAC5BB
	for <u-boot@archiver.kernel.org>; Sun,  5 Oct 2025 00:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53658807B1;
	Sun,  5 Oct 2025 02:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0971809A5; Sun,  5 Oct 2025 02:40:53 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id ECCB780107
 for <u-boot@lists.denx.de>; Sun,  5 Oct 2025 02:40:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 396C21A25;
 Sat,  4 Oct 2025 17:40:42 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E3643F59E;
 Sat,  4 Oct 2025 17:40:49 -0700 (PDT)
Date: Sun, 5 Oct 2025 01:40:21 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Rudi Horn <dyn-git@rudi-horn.de>
Cc: u-boot@lists.denx.de, jernej.skrabec@gmail.com, linux-sunxi
 <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH] Fix detection of odd memory configurations on sunxi
Message-ID: <20251005014021.4b1b035a@minigeek.lan>
In-Reply-To: <56f44755-fca8-4364-905e-685e79fd1aea@rudi-horn.de>
References: <56f44755-fca8-4364-905e-685e79fd1aea@rudi-horn.de>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, 11 Aug 2025 09:35:19 +0200
Rudi Horn <dyn-git@rudi-horn.de> wrote:

Hi Rudi,

thanks for sending a patch to address this long-standing issue!

But ... ;-)

> I encountered a bug where u-boot detects that my OrangePI zero 3 (with=20
> 1.5GB) has 2GB and crashes.

As Jernej already said, this is a known limitation: we simply don't
support not-power-of-2 DRAM sizes at the moment.

> The orangepi u-boot source code contains an additional
> modification in the `mctl_calc_size` which removes a quarter of the=20
> memory the
> calculated last address cannot be written to:
>=20
> https://github.com/orangepi-xunlong/u-boot-orangepi/blob/v2024.01/arch/ar=
m/mach-sunxi/dram_sun50i_h616.c#L1365-L1368
>=20
> I'm not entirely sure if there is some specific logic that applies to this
> modifier, but it does fix the issue on my system.

So can someone shed some light on how this is supposed to work? If I
understand the code correctly, it checks for *aliasing* between the
first and the last word of DRAM, which doesn't make much sense to me: I
would expect a simple write/verify to see if the last quarter of DRAM
is for real, or to check for a known aliasing pattern with this "odd"
setup (as in: last quarter is aliased to first or third quarter or
something), but checking those two words for aliasing seems wrong.

And indeed the code also fires on a board with 512MB and 4GB, capping
the memory there as well (resulting in 384 MB and 3GB, respectively).
This is somewhat expected, as we never would expect aliasing between
those two particular words, I'd say.

So since I don't have a board with an "uneven" DRAM size, can you
please test some ideas to detect this RAM setup?
- Read the content of the first word to not exist (@1.5GB), then write
  something else there, and see if you can read this back? Don't forget
  a write barrier (dsb();) when doing so.
- Write some test pattern to some known good DRAM locations, like the
  beginning of DRAM, @512MB, @1GB, and see if any of those values pop
  up @1.5GB, to see if there is an aliasing pattern?
- Can you post the exact label on that DRAM chip, so that we can see if
  we find a datasheet? I'd be curious about the actual organisation of
  the DRAM array.

Jernej, do you happen to know how those DRAM chips are organised? Do
they just feature a non-power-of-2 number of rows or columns?

Oh, and also this patch was heavily malformed - line breaks and spaces
instead of tabs. Please try to fix this. Simplest is probably "git
format-patch", then sending this via "git send-email". Your email
server seems to be postfix, so you could just give the SMTP details and
credentials to git.

Cheers,
Andre


>=20
> I propose the following patch, but am open to any further suggestions.
>=20
> Thanks,
> Rudi Horn
>=20
> Note: Submitted in my personal capacity and is not affiliated with my=20
> employer.
>=20
>=20
>  From 2199f3b28e5fc853ed1921586358c33f3f1502d3 Mon Sep 17 00:00:00 2001
> From: Rudi Horn <dyn-git@rudi-horn.de>
> Date: Mon, 11 Aug 2025 08:58:34 +0200
> Subject: [PATCH] arch: arm: mach-sonxi: Fix detection of odd memory
>  =C2=A0configurations
>=20
> Fix detection of odd memory configurations. Previously 1.5GB devices were
> incorrectly detected as 2GB devices, causing u-boot to crash.
>=20
> Signed-off-by: Rudi Horn <dyn-git@rudi-horn.de>
> ---
>  =C2=A0arch/arm/include/asm/arch-sunxi/dram.h |=C2=A0 1 +
>  =C2=A0arch/arm/mach-sunxi/dram_dw_helpers.c=C2=A0 | 10 +++++++++-
>  =C2=A0arch/arm/mach-sunxi/dram_helpers.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 8 ++++++++
>  =C2=A03 files changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/include/asm/arch-sunxi/dram.h=20
> b/arch/arm/include/asm/arch-sunxi/dram.h
> index 0eccb1e6c28..7580421ca77 100644
> --- a/arch/arm/include/asm/arch-sunxi/dram.h
> +++ b/arch/arm/include/asm/arch-sunxi/dram.h
> @@ -44,6 +44,7 @@
>  =C2=A0unsigned long sunxi_dram_init(void);
>  =C2=A0void mctl_await_completion(u32 *reg, u32 mask, u32 val);
>  =C2=A0bool mctl_mem_matches(u32 offset);
> +bool mctl_mem_matches_upto(u32 offset);
>  =C2=A0bool mctl_mem_matches_base(u32 offset, ulong base);
>=20
>  =C2=A0#endif /* _SUNXI_DRAM_H */
> diff --git a/arch/arm/mach-sunxi/dram_dw_helpers.c=20
> b/arch/arm/mach-sunxi/dram_dw_helpers.c
> index 24767354935..5bcd2672465 100644
> --- a/arch/arm/mach-sunxi/dram_dw_helpers.c
> +++ b/arch/arm/mach-sunxi/dram_dw_helpers.c
> @@ -146,5 +146,13 @@ unsigned long mctl_calc_size(const struct=20
> dram_config *config)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 width =3D config->bus_full=
_width ? 4 : 2;
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 8 banks */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (1ULL << (config->cols + con=
fig->rows + 3)) * width *=20
> config->ranks;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long size =3D (1ULL << (co=
nfig->cols + config->rows + 3))=20
> * width * config->ranks;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* some memory configurations such =
as 1.5GB rely on this to=20
> compute the correct size */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!mctl_mem_matches_upto(size)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 size =3D (size * 3) / 4;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 debug("capping memory at 0x%lx\n", size);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0 return size;
>  =C2=A0}
> diff --git a/arch/arm/mach-sunxi/dram_helpers.c=20
> b/arch/arm/mach-sunxi/dram_helpers.c
> index 83dbe4ca98f..68c75fa07a6 100644
> --- a/arch/arm/mach-sunxi/dram_helpers.c
> +++ b/arch/arm/mach-sunxi/dram_helpers.c
> @@ -61,4 +61,12 @@ bool mctl_mem_matches(u32 offset)
>  =C2=A0{
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return mctl_mem_matches_base(=
offset, CFG_SYS_SDRAM_BASE);
>  =C2=A0}
> +
> +/*
> + * Test if memory at offset matches memory at end of DRAM
> + */
> +bool mctl_mem_matches_upto(u32 offset)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return mctl_mem_matches_base(offset=
 - sizeof(u32),=20
> CFG_SYS_SDRAM_BASE);
> +}
>  =C2=A0#endif
> --
> 2.43.0
>=20

