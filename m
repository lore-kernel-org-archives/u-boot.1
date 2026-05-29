Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEF5CD4F54
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 15:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 378AB846A3;
	Fri, 29 May 2026 17:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WuWRjrUd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8EB3846F4; Fri, 29 May 2026 17:44:53 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E22A984671
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 17:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7e615b4c2a7so1995022a34.2
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 08:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780069489; x=1780674289; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CUMbfmE3vbmKXytzCQOx9cIAhADf/gcTHMIOTT8Wb2I=;
 b=WuWRjrUdkMa/cgE/rIIlvFe+Z1vYwZv5r6i7RU9Dy/s5ttJoAT7vT8XWMWULG8qm5t
 lvzzyWfs8mgjC7CJ9exwXrI6neUKHlEXPpyn2MggQy4jqFe922x6/RDi+mtphe0P6ypw
 6/u5LuOgVvQdDnRNlTZFT+ODM2wmii2jv0SU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780069489; x=1780674289;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CUMbfmE3vbmKXytzCQOx9cIAhADf/gcTHMIOTT8Wb2I=;
 b=sRfQ8ilfiLnQO5HXS4f6gossuRvf9gqSxEXhcrBsqlmXWIW1/47qkexuW4Fc6Fnt+0
 Uudt7qWiEQs0SwypWsGOqrU2FMOxUMPLNX6ZsW29E2zNG6T1iV3tdq7qdmgaiZIZLPYR
 sPvDWkOGQLXRd4yEICX/oI238i4yJeMpen3boVvsYO6vcViO0b7CNkPZbRt4eUAyh7+b
 E7C3+8qQ70NxsT+j0IdtqjfnVsWqbLugy7KUwshDXwVmjz4Z6PQdVHHcFa4o07qfKlR1
 /kH4lTrmPqu/fx7UnYe+TzIusc8AIOmfwTkSxWlo/JF3WfBQISsAZ4BEeMGUO+BtYwiJ
 EaVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+FQ1LuB/QkSFCABsRIMbegeigXvabKHvwtd7LILphgMvPVPuzTy4qIiP391OXmXiuFP/1+xKA=@lists.denx.de
X-Gm-Message-State: AOJu0YwFCQgZ9/nawY1/mdX8cx9luhHd5SZ7QT2kTw1abfoHB4DoTf+P
 98K03sZePr52JTLsa9CzbkbZJnaNznWYfHBPAY1sTxPdLHqiMalpMCRURR7EIS5Ys3yc2DPAqmO
 PrBuSofI=
X-Gm-Gg: Acq92OF2/tN52epBCjE7ms1Ol234u43gVGdbswHfgnG3rHLHQhGI+epIV8ruAzDgna0
 5WSFZNc7nsSYLci0i+vhjs7y/uuZDOZr8UfwR9JEA4qY+AiFNjL0FI3G72YRWKCzknOm6SFgiAS
 p2B2rKKrXPZRVzqyfKqfxfViz0qB7HMTIQOVqkjPf8wrrsxXCY72pmHpRmN153JEyLu1wzE//ni
 IqFFqKg87PAtP49gqiSLJp3KK95XwEYuw/+M7ZasTfU6VaXj8bPFj0pZreTe4iDn0vl9QeFry8v
 A6YlffajxroksaAQ7maZwaBgJ+wxmKiv2GuMS1002TkUp3uRmrvM19Lcmxt24GZWbX6LW3AymOQ
 IMQersXVFY+MRzwrKsJHSOmJ4/XyI+KyfsTySD2b8RKFNhksGI+PnojLwfgUYgEpcvV4vfIEcGH
 KdAxUwJenkskHB8kdlLIIItV4YvjPB1dWQPwRrQwvQ4XBX4Ki8RipFEvpjddljVWrzrzmxMLF7c
 aRtD5Rnxx58Ug2PGiFnLrDw1EmTXTEXAGTFVYJV7wzgHmaFTYKk+nss
X-Received: by 2002:a05:6830:2404:b0:7e5:fe62:d916 with SMTP id
 46e09a7af769-7e6a1e1a2demr215747a34.19.1780069489559; 
 Fri, 29 May 2026 08:44:49 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e695d4726dsm1623599a34.19.2026.05.29.08.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 08:44:49 -0700 (PDT)
Date: Fri, 29 May 2026 09:44:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, U-Boot <u-boot-bounces@lists.denx.de>
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
Message-ID: <20260529154446.GC627328@bill-the-cat>
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <CALeDE9PARyt0iUvnfbSfz=rSA2RkQ1AcoaJpU=8RgnYivaPNEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6nrH//ezCxiexhpd"
Content-Disposition: inline
In-Reply-To: <CALeDE9PARyt0iUvnfbSfz=rSA2RkQ1AcoaJpU=8RgnYivaPNEA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--6nrH//ezCxiexhpd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 01:10:14PM +0100, Peter Robinson wrote:
> Hi Tom, Marek et el,
>=20
> This is still broken on Raspberry Pis, at least RPi4/RPi5 against RC3.
>=20
> > On Fri Mar 13, 2026 at 8:54 PM GMT, Tom Rini wrote:
> > > On Wed, 28 Jan 2026 00:48:40 +0100, Marek Vasut wrote:
> > >
> > >> Revert commit eb052cbb896f ("lmb: add and reserve memory above ram_t=
op")
> > >> and commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top ev=
en from
> > >> same bank"). These are based on incorrect premise of the first commi=
t, that
> > >> "U-Boot does not use memory above ram_top". While U-Boot itself inde=
ed does
> > >> not and should not use memory above ram_top, user can perfectly well=
 use
> > >> that memory from the U-Boot shell, for example to load content in th=
ere.
> > >>
> > >> [...]
> > >
> > > Applied to u-boot/next, thanks!
> > >
> > > [1/1] lmb: Reinstate access to memory above ram_top
> > >       commit: a3075db94d49f415658bf7e961e1eae90d9abc33
> >
> > (Cc RPI maintainers)
> >
> > Hi Tom,
> >
> > I'm testing out latest u-boot/next on my Raspberry Pi 5 8GB, and I am r=
unning
> > into issues caused by this patch.
> >
> > I have EFI enabled, and efi_allocate_pages will call into lmb to alloca=
te pages
> > and start accessing them. However on RPI5, only 1G is mapped, so I got =
hit with
> > an "Synchronous Abort" triggered at address 0x1_ffff_f000.
>=20
> I was seeing a "Synchronous Abort" triggered, but now now I am seeing:
>=20
> Hit any key to stop autoboot: 0
> Cannot persist EFI variables without system partition
> ** Booting bootflow '<NULL>' with efi_mgr
> Not a PE-COFF file
> Loading Boot0000 'mmc 0' failed
> EFI boot manager: Cannot load any image
> Boot failed (err=3D-14)
> ** Booting bootflow 'mmc@7e340000.bootdev.part_1' with efi
> Booting /\EFI\BOOT\BOOTAA64.EFI
> Platform does not support this image
> Failed to read header: Unsupported
> Failed to load image: Unsupported
> start_image() returned Unsupported
> ## Application failed, r =3D 3
> Boot failed (err=3D-22)
>=20
> > Now, that is easy to fix with the following diff:
>=20
> Simon sent something similar [1] but it didn't fix the problem, nor
> address the RPi4.
>=20
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20260508233254.20224=
95-1-sjg@chromium.org/
>=20
> > diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
> > index 7a1de22e0aef..1db2e37c44f4 100644
> > --- a/arch/arm/mach-bcm283x/init.c
> > +++ b/arch/arm/mach-bcm283x/init.c
> > @@ -69,10 +69,10 @@ static struct mm_region bcm2711_mem_map[MEM_MAP_MAX=
_ENTRIES] =3D {
> >
> >  static struct mm_region bcm2712_mem_map[MEM_MAP_MAX_ENTRIES] =3D {
> >         {
> > -               /* First 1GB of DRAM */
> > -               .virt =3D 0x00000000UL,
> > -               .phys =3D 0x00000000UL,
> > -               .size =3D 0x40000000UL,
> > +               /* 16GB of DRAM max */
> > +               .virt =3D 0x000000000UL,
> > +               .phys =3D 0x000000000UL,
> > +               .size =3D 0x400000000UL,
> >                 .attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> >                          PTE_BLOCK_INNER_SHARE
> >         }, {
> >
> > and that indeed makes my system go past the init. However, I found that=
 while it
> > is fine to boot into systemd-boot, systemd-boot cannot boot into kernel=
=2E After
> > some investigation, it turns out that efi_load_image_from_file uses
> > efi_allocate_pages to allocate pages, and then feed this to f->read. Th=
is all
> > eventually trickles down to the MMC driver, and MMC is doing a 32-bit D=
MA and it
> > fails to write to the buffer allocated (which is above 4G).
>=20
> The Raspberry Pi has a number of devices which are only accessible at
> lower memory access, the mailbox is only accessible < 1Gb too.
>=20
> > This could be all fixed by having dma_map_single use a bounce buffer an=
d copy
> > back the contents on unmap similar to kernel's swiotlb, but that's goin=
g to be
> > some major work.
> >
> > In the mean time, I think this patch should be reverted. I can confirm =
that my
> > system boots fine with this reverted.
>=20
> Yes, I agree here.

Can you please post the revert Peter? Thanks.

--=20
Tom

--6nrH//ezCxiexhpd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahm0bgAKCRAr4qD1Cr/k
ClBXAQCmOp5/yNqoJfxmssLWPjrJw/7huBx1FByYnye1xOUd7wD/fpBKIwBWfFcB
G6JRWAzNwWpaYlPgkV3wlBkX/t5o/Ag=
=uh0o
-----END PGP SIGNATURE-----

--6nrH//ezCxiexhpd--
