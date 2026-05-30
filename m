Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86D5CD6E49
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 14:06:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ACD284671;
	Sat, 30 May 2026 16:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IwFqHoLM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C8E0846A3; Sat, 30 May 2026 16:06:51 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00F0E8405A
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 16:06:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4854d5cc708so6113578b6e.2
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 07:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780150008; x=1780754808; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TJU7VyuEe8/L+uig4d+jzw9cPgXim4o5iKam9bR/BqI=;
 b=IwFqHoLMguhoXhsjd1xqzloA+z8fZAYoBejQNtirPQDZoDY2l0hJkVOiovI2wwxxje
 pSy50rNCwz+ulT5XyDGHrz7HZwhKWHCM4TSwGhv7mWaLwp3Ha92j3MutAHZkPWKF7eTI
 U2d1lbE2x9J+f4aSf3g7VIFGP/62rktj25wJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780150008; x=1780754808;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TJU7VyuEe8/L+uig4d+jzw9cPgXim4o5iKam9bR/BqI=;
 b=C+gY4KdDYmpof3QwUaLaER9JVcjt+S5xiE009SvCJZvMtKCtikMcKKFC+Ir+k6gaMd
 u2paLdeR4A+hwUtCJ/amN8im19T4DENDz7IwqzoGvPZACTrhwYnJ0GxMvhMjl/LdAUV+
 9bCwoairi1/v6GVVttI7N4Rgl1d2VA+p66CrjVGHbN1tVpN+yBjzL6nO28LC2BJQkxM4
 KU6QWTHK2JwbkZwJmBtKm7HGBXfFh8LscxphkO7O47ebUjrKDC0rm9068o31d5JvjzR5
 9tlflXfbKlg0+3Ce1PSe3GayIl8BSMMNNdXShQG2J6xs13vR+djsL4z9Qpih2y5Gxyah
 fcuA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8nG1lD/qJyZ4/E0kK6om1/cOmi26veq9ARiS1ydoPw2FNxEcsFbjJ/+Q/SvDfRnB/1ch7/b4w=@lists.denx.de
X-Gm-Message-State: AOJu0Yz18funwDt2/IBxMlAOKVQH8V2RuTpeoR3a/jwefmOF+0mcQ30o
 KF43fWW1HvfrYMkvEaijkqYybjtqKzP0c66nsFDandTV9ZYh9IoNXL6MjZOD9WgDIlc=
X-Gm-Gg: Acq92OE624jm4ULWNpqWjMBrcElnn/ke+54GjiwpCVxX805KHsalTkZFXSqXBfiwVBH
 wKIMogFz0he7tUmKF2boYd4TdwH5GYj064qzx4es/3zI2GFs3b6i0w1RmvUIwBiYw7BwgDq3zEa
 qm5x6lHvGiBeGpd9vhh9Av63E5Po7Q0pXeQInp7kpFJTtDb+bXyUERjBUOAIHi7UbqaP99Y4U3q
 cfwWjjh8hgMKJoJgDyAOez6WrmaYJrTjdT8CoEVL6w0jY0wWqLigm4IZW6NAmRoUGA582hgEt43
 djp25UONOuNaUrnk4PHzYGqT8YZaYE+m80icMI4D3b+Ri+FCNNcKTUSAYGO8StJlXeRGHPtyV7H
 1eFmCNUQrJdU8LZN7ci9Uc8mgltMVlR6tvbNtGoYlI2MtIul8AdchgpMrXcHcd5CCVB9Q4rhP5Z
 TJF0YYMIQbZvpNqlY7SYc1YwQDgTaDvfhtYAprXfDvkz0HQQH8OSN+hV9fZnk+Fmg4pp2a/dJe/
 jQ0Oxao9KBRA+Zw4sL5MMM86EBXauRorstUAUtfzyonF8/MsXheiSeG
X-Received: by 2002:a05:6808:c1a6:b0:467:1f38:bc1a with SMTP id
 5614622812f47-485fb663814mr2366238b6e.7.1780150007647; 
 Sat, 30 May 2026 07:06:47 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43c93ef3ad7sm3571187fac.9.2026.05.30.07.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 07:06:47 -0700 (PDT)
Date: Sat, 30 May 2026 08:06:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, Gary Guo <gary@garyguo.net>,
 u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
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
Message-ID: <20260530140644.GG627328@bill-the-cat>
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <CALeDE9PARyt0iUvnfbSfz=rSA2RkQ1AcoaJpU=8RgnYivaPNEA@mail.gmail.com>
 <20260529154446.GC627328@bill-the-cat>
 <CALeDE9MAE6r3pFzNRDbwAXkkkWrZo_0gXEMTavmpnGjQBoxrVQ@mail.gmail.com>
 <c9e810ac-6c0e-4a66-bbae-d6557a26197b@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Co3f/KU3DcczskXZ"
Content-Disposition: inline
In-Reply-To: <c9e810ac-6c0e-4a66-bbae-d6557a26197b@mailbox.org>
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


--Co3f/KU3DcczskXZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 03:24:43PM +0200, Marek Vasut wrote:
> On 5/29/26 6:30 PM, Peter Robinson wrote:
> > On Fri, 29 May 2026 at 16:44, Tom Rini <trini@konsulko.com> wrote:
> > >=20
> > > On Fri, May 29, 2026 at 01:10:14PM +0100, Peter Robinson wrote:
> > > > Hi Tom, Marek et el,
> > > >=20
> > > > This is still broken on Raspberry Pis, at least RPi4/RPi5 against R=
C3.
> > > >=20
> > > > > On Fri Mar 13, 2026 at 8:54 PM GMT, Tom Rini wrote:
> > > > > > On Wed, 28 Jan 2026 00:48:40 +0100, Marek Vasut wrote:
> > > > > >=20
> > > > > > > Revert commit eb052cbb896f ("lmb: add and reserve memory abov=
e ram_top")
> > > > > > > and commit 1a48b0be93d4 ("lmb: prohibit allocations above ram=
_top even from
> > > > > > > same bank"). These are based on incorrect premise of the firs=
t commit, that
> > > > > > > "U-Boot does not use memory above ram_top". While U-Boot itse=
lf indeed does
> > > > > > > not and should not use memory above ram_top, user can perfect=
ly well use
> > > > > > > that memory from the U-Boot shell, for example to load conten=
t in there.
> > > > > > >=20
> > > > > > > [...]
> > > > > >=20
> > > > > > Applied to u-boot/next, thanks!
> > > > > >=20
> > > > > > [1/1] lmb: Reinstate access to memory above ram_top
> > > > > >        commit: a3075db94d49f415658bf7e961e1eae90d9abc33
> > > > >=20
> > > > > (Cc RPI maintainers)
> > > > >=20
> > > > > Hi Tom,
> > > > >=20
> > > > > I'm testing out latest u-boot/next on my Raspberry Pi 5 8GB, and =
I am running
> > > > > into issues caused by this patch.
> > > > >=20
> > > > > I have EFI enabled, and efi_allocate_pages will call into lmb to =
allocate pages
> > > > > and start accessing them. However on RPI5, only 1G is mapped, so =
I got hit with
> > > > > an "Synchronous Abort" triggered at address 0x1_ffff_f000.
> > > >=20
> > > > I was seeing a "Synchronous Abort" triggered, but now now I am seei=
ng:
> > > >=20
> > > > Hit any key to stop autoboot: 0
> > > > Cannot persist EFI variables without system partition
> > > > ** Booting bootflow '<NULL>' with efi_mgr
> > > > Not a PE-COFF file
> > > > Loading Boot0000 'mmc 0' failed
> > > > EFI boot manager: Cannot load any image
> > > > Boot failed (err=3D-14)
> > > > ** Booting bootflow 'mmc@7e340000.bootdev.part_1' with efi
> > > > Booting /\EFI\BOOT\BOOTAA64.EFI
> > > > Platform does not support this image
> > > > Failed to read header: Unsupported
> > > > Failed to load image: Unsupported
> > > > start_image() returned Unsupported
> > > > ## Application failed, r =3D 3
> > > > Boot failed (err=3D-22)
> > > >=20
> > > > > Now, that is easy to fix with the following diff:
> > > >=20
> > > > Simon sent something similar [1] but it didn't fix the problem, nor
> > > > address the RPi4.
> > > >=20
> > > > [1] https://patchwork.ozlabs.org/project/uboot/patch/20260508233254=
=2E2022495-1-sjg@chromium.org/
> > > >=20
> > > > > diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x=
/init.c
> > > > > index 7a1de22e0aef..1db2e37c44f4 100644
> > > > > --- a/arch/arm/mach-bcm283x/init.c
> > > > > +++ b/arch/arm/mach-bcm283x/init.c
> > > > > @@ -69,10 +69,10 @@ static struct mm_region bcm2711_mem_map[MEM_M=
AP_MAX_ENTRIES] =3D {
> > > > >=20
> > > > >   static struct mm_region bcm2712_mem_map[MEM_MAP_MAX_ENTRIES] =
=3D {
> > > > >          {
> > > > > -               /* First 1GB of DRAM */
> > > > > -               .virt =3D 0x00000000UL,
> > > > > -               .phys =3D 0x00000000UL,
> > > > > -               .size =3D 0x40000000UL,
> > > > > +               /* 16GB of DRAM max */
> > > > > +               .virt =3D 0x000000000UL,
> > > > > +               .phys =3D 0x000000000UL,
> > > > > +               .size =3D 0x400000000UL,
> > > > >                  .attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> > > > >                           PTE_BLOCK_INNER_SHARE
> > > > >          }, {
> > > > >=20
> > > > > and that indeed makes my system go past the init. However, I foun=
d that while it
> > > > > is fine to boot into systemd-boot, systemd-boot cannot boot into =
kernel. After
> > > > > some investigation, it turns out that efi_load_image_from_file us=
es
> > > > > efi_allocate_pages to allocate pages, and then feed this to f->re=
ad. This all
> > > > > eventually trickles down to the MMC driver, and MMC is doing a 32=
-bit DMA and it
> > > > > fails to write to the buffer allocated (which is above 4G).
> > > >=20
> > > > The Raspberry Pi has a number of devices which are only accessible =
at
> > > > lower memory access, the mailbox is only accessible < 1Gb too.
> > > >=20
> > > > > This could be all fixed by having dma_map_single use a bounce buf=
fer and copy
> > > > > back the contents on unmap similar to kernel's swiotlb, but that'=
s going to be
> > > > > some major work.
> > > > >=20
> > > > > In the mean time, I think this patch should be reverted. I can co=
nfirm that my
> > > > > system boots fine with this reverted.
> > > >=20
> > > > Yes, I agree here.
> > >=20
> > > Can you please post the revert Peter? Thanks.
> >=20
> > Sent.
>=20
> The revert is wrong as that breaks other things , like use of DRAM above 4
> GiB boundary, which is exactly why this change was implemented. If RPi has
> limitations, then those limitations should be imposed on RPi, not globall=
y,
> so add the LMB reservations on RPi.

Isn't the case you describe still a theoretical and not used in tree
case? And note that Ilias' patches to relocate to the top of memory also
fail on Pi. So there's something to be debugged here and worked out
before we add this seemingly enhanced behavior. Hence, the need to
revert it for now until it can be fixed.

--=20
Tom

--Co3f/KU3DcczskXZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahru8AAKCRAr4qD1Cr/k
CtB2AP9C2VOMRbY0QMa9bv4CrC2dcszcPjcPjztTZkdjrrkpVgEA8sJ0en8hbLVE
RdJuY9NQn+OPaKzm10a66IbggC3zRQU=
=Dx72
-----END PGP SIGNATURE-----

--Co3f/KU3DcczskXZ--
