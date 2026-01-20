Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD72D2ED12
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 14:59:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E91E83B07;
	Tue, 20 Jan 2026 15:59:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XbsHZxDA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A3EF83B0B; Tue, 20 Jan 2026 15:59:54 +0100 (CET)
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com
 [IPv6:2001:4860:4864:20::41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D5CE83A8F
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 15:59:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x41.google.com with SMTP id
 586e51a60fabf-404254ffe8aso3958987fac.0
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 06:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768921191; x=1769525991; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LzfhSROFRRt++OOxHDzHKCNNTQeNsV3JVnybLnJWn2o=;
 b=XbsHZxDAq7yqh0bc9QwdBfnfCgfF11Yxe0NgixeqyKy+EVb2I4ZLh8+FmAJMpEJlHg
 G3HqfXJUIk5MqlxE5FZDWPDC+6/Iz496qXRnGeJokh19iH/Udv7GFv1GHznRQFO5Rk1m
 kPCQJDDfLadJPNuny0wRM53JcKwf3pZUR+gIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768921191; x=1769525991;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LzfhSROFRRt++OOxHDzHKCNNTQeNsV3JVnybLnJWn2o=;
 b=gD9vE+4HtPVae2BPLHoUeIHvdRRI116NfQ9+F6lAmRCScSb6l7j+trzjKt/ztBl7gy
 A9FYYP5i24OS8AymkIWi2AZgVI0R1sm+oLG71XemA1MZ2ZsiDiCWIu323o4Ej0InZaZX
 YrgEOrg8oOTRLy5hhb0RK8Ht2IChB0nZHoaZK7bX561SyHfSszaGksCszkM5I6Sa1vMv
 5wwnNSHeB07QCEKvX3FSyjGozXl14zbVmMhAkyz3GDG2wjxL4BZo6OK2BDiBJ214npWF
 wPfdFSOO0tcWQ27wKKnDo2JB6j88NEHar8fOiXhuqn9eh1GNSK8AV/A8dHF4IXRAPq2r
 h5sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH8FuBx7SQnMwOaEU6Ftm70dmIONG03ufKU+wx8iwVOMkOy6XfmOM44Xn5NA0dDBDhsYyZFg8=@lists.denx.de
X-Gm-Message-State: AOJu0YxrI2dUkfpEUlQs7MSm6GZWW1wptUiDUdiP7C3Y7X6UcMeMK5Kr
 l2tnEV9Uw4qwn7wmKlBuyFNR2Ge0WTJ991WYSOwbAqKzk721h4Is7xrwXK4qqNH9vy4=
X-Gm-Gg: AZuq6aIplcnn9dqSeFHCcYLI6IrKj4uG1ppWeqMmX3TtlAb8LF9spbj4ptO6+cSAK3F
 goRomiLBQ6Z9JvCOPrTgDz0SNBENI8Rp25LV83ZpQJC5T3jBjrQTxPVo8TvpuDv4sb8N5s49Te/
 wmWG7SjzBO/OFE4sKEQmvP+Sha5saLYD+cdkpPu/J154lvhFTKKHNXZGZ8WH9YGDNF6YpJtl1MT
 QHWjbNkDD+LHg/FT5oLEV7Mz5YtuHi1VtBhPhRBKKeKWU/EbyNMI+8R5cn7RPCg8MSUxOFO2i0Z
 3z6wRuqutpJ/qH0jgvbovUweaPacNaqZTZdRk675/Dcr79gpafYjCFiM/PuGW7l0EztdBmSzoim
 InTl9Kv0jrUH5KWOIcDNVGmq8drEDcWlqUIzspXLpCovC2lEnDQVWY/IwKRKz+/u11Pb2uS+cqu
 pw0Mu3ZQjfmEX6NaxLyFq/xee+Qzkg1vbIvp0rI30eOyO8lDf27rDVYEn06HIWKFGdfBMCUd1i7
 RzIUiohIx/o4NAke91yxI9O5RWwjdN257YiN7U=
X-Received: by 2002:a05:6870:7025:b0:3c9:ad69:4416 with SMTP id
 586e51a60fabf-40428e156bdmr8563791fac.5.1768921190666; 
 Tue, 20 Jan 2026 06:59:50 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044bd1488esm9289411fac.11.2026.01.20.06.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 06:59:50 -0800 (PST)
Date: Tue, 20 Jan 2026 08:59:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Vagrant Cascadian <vagrant@debian.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Green Wan <green.wan@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] board: unmatched: Workaround failure to find .dtb file.
Message-ID: <20260120145947.GM3416603@bill-the-cat>
References: <877bteqx7y.fsf@wireframe>
 <e406ccb2-670c-481a-a128-d25a8973341b@mailbox.org>
 <20260119191841.GE3416603@bill-the-cat> <87pl75p0ug.fsf@wireframe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zdxLJDFPksReEVGN"
Content-Disposition: inline
In-Reply-To: <87pl75p0ug.fsf@wireframe>
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


--zdxLJDFPksReEVGN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 04:46:47PM -0800, Vagrant Cascadian wrote:
> On 2026-01-19, Tom Rini wrote:
> > On Mon, Jan 19, 2026 at 07:42:59AM +0100, Marek Vasut wrote:
> >> On 1/19/26 1:09 AM, Vagrant Cascadian wrote:
> >> > The fdtdfile variable contains quotes:
> >> >=20
> >> >    printenv fdtfile
> >> >    fdtfile=3D"sifive/hifive-unmatched-a00.dtb"
> >> >=20
> >> > But this leads to issues which booting with an extlinux.conf format
> >> > file failing to find the .dtb file:
> >> >=20
> >> >    Retrieving file: /usr/lib/linux-image-6.12.63+deb13-riscv64/"sifi=
ve/hifive-unmatched-a00.dtb"
> >> >    Skipping fdtdir /usr/lib/linux-image-6.12.63+deb13-riscv64/ for f=
ailure retrieving dts
> >> >=20
> >> > Other platforms (e.g. rockpro64-rk3399) do not contain quotes in the
> >> > fdtfile variable, and work properly out of the box.
> >> >=20
> >> > The workaround suggested by marex is to hard-code the correct .dtb
> >> > value, which works for me.
> >> >=20
> >> > This has been present at least since version 2025.01, also present in
> >> > 2026.01. I have not yet tested against git master branch.
> >> >=20
> >> > This could probably be properly fixed by stripping the quotes in
> >> > whatever processes the .env file. There are numerous other boards th=
at
> >> > have the same way of setting the fdtfile variable, which might
> >> > similarly be effected by this issue.
> >> >=20
> >> > Signed-off-by: Vagrant Cascadian <vagrant@debian.org>
> >> >=20
> >> > Not sure who all to CC on this, please feel free to forward
> >> > appropriately!
> >>=20
> >> ./scripts/get_maintainer.pl -f board/sifive/unmatched/
> >>=20
> >> produces a few names, added
> >>=20
> >> > ---
> >> >   board/sifive/unmatched/unmatched.env | 2 +-
> >> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >> >=20
> >> > diff --git a/board/sifive/unmatched/unmatched.env b/board/sifive/unm=
atched/unmatched.env
> >> > index 34425dc9efa..cdba2c8ae0e 100644
> >> > --- a/board/sifive/unmatched/unmatched.env
> >> > +++ b/board/sifive/unmatched/unmatched.env
> >> > @@ -16,4 +16,4 @@ partitions=3D
> >> >       name=3Dloader1,start=3D17K,size=3D1M,type=3D${type_guid_gpt_lo=
ader1};
> >> >       name=3Dloader2,size=3D4MB,type=3D${type_guid_gpt_loader2};
> >> >       name=3Dsystem,size=3D-,bootable,type=3D${type_guid_gpt_system}=
;=20
> >> > -fdtfile=3DCONFIG_DEFAULT_FDT_FILE
> >> > +fdtfile=3Dsifive/hifive-unmatched-a00.dtb
> >>=20
> >> Also +CC Peng because iMX is also affected.
> >
> > I'm setting aside the question of why we have both DEFAULT_FDT_FILE and
> > DEFAULT_DEVICE_TREE and pointing to:
> > commit d085e692c98d0d7b57cc577ed9befda159cd4a40
> > Author: Simon Glass <sjg@chromium.org>
> > Date:   Wed Nov 13 08:09:37 2024 -0700
> >
> >     env: Provide a work-around for unquoting fdtfile
> >    =20
> >     Some boards use a CONFIG option to specify the value of this variab=
le.
> >     This is normally handled by efi_get_distro_fdt_name() but in the ca=
se
> >     of sunxi this does not work, since 'soc' is sunxi, but the files are
> >     in the allwinner directory.
> >    =20
> >     Provide a work-around for this particular case.
> >    =20
> >     Signed-off-by: Simon Glass <sjg@chromium.org>
> >     Reviewed-by: Tom Rini <trini@konsulko.com>
> >
> > As how to address this issue as well, unless someone discovers something
> > still more clever to deal with quoting.
>=20
> Thanks for the hint! So a quick and dirty stab at getting this to work:
>=20
> diff --git a/Makefile b/Makefile
> index 50737f93850..2e3280bb87b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2137,7 +2137,7 @@ quiet_cmd_gen_envp =3D ENVP    $@
>                 $(CPP) -P $(cpp_flags) -x assembler-with-cpp -undef \
>                         -D__ASSEMBLY__ \
>                         -D__UBOOT_CONFIG__ \
> -                       -DDEFAULT_DEVICE_TREE=3D$(subst ",,$(CONFIG_DEFAU=
LT_DEVICE_TREE)) \
> +                       -DDEFAULT_FDT_FILE=3D$(subst ",,$(CONFIG_DEFAULT_=
FDT_FILE)) \
>                         -I . -I include -I $(srctree)/include \
>                         -include linux/kconfig.h -include include/config.=
h \
>                         -I$(srctree)/arch/$(ARCH)/include \
> diff --git a/board/sifive/unmatched/unmatched.env b/board/sifive/unmatche=
d/unmatched.env
> index 34425dc9efa..f309229481b 100644
> --- a/board/sifive/unmatched/unmatched.env
> +++ b/board/sifive/unmatched/unmatched.env
> @@ -16,4 +16,4 @@ partitions=3D
>      name=3Dloader1,start=3D17K,size=3D1M,type=3D${type_guid_gpt_loader1};
>      name=3Dloader2,size=3D4MB,type=3D${type_guid_gpt_loader2};
>      name=3Dsystem,size=3D-,bootable,type=3D${type_guid_gpt_system};
> -fdtfile=3DCONFIG_DEFAULT_FDT_FILE
> +fdtfile=3DDEFAULT_FDT_FILE
>=20
> Though obviously any boards relying on DEFAULT_DEVICE_TREE would need
> adapting with my quick patch above...

The rest of the platforms, yes. If you can do a patch to fixup
unmatched, I can follow-up with the rest.

> I did not successfully just add -DDEFAULT_FDT_FILE without removing
> -DDEFAULT_DEVICE_TREE ... probably just need to cut-and-paste more lines
> in the Makefile... or try to do something even more clever. :)
>=20
> That would also require the other handfull of boards using
> CONFIG_DEFAULT_FDT_FILE to switch to DEFAULT_FDT_FILE, presumably.
>=20
>=20
> I also tried switching the unmatched board to use DEFAULT_DEVICE_TREE
> instead, but that does not contain the vendor prefix
> (e.g. hifive-unmatched-a00 vs. sifive/hifive-unmatched-a00.dtb) and so
> the file was still not found. Should CONFIG_DEFAULT_DEVICE_TREE and
> CONFIG_DEFAULT_FDT_FILE both contain the vendor dir?

Ah, probably a difference between platforms that use OF_UPSTREAM, or
not, then.

--=20
Tom

--zdxLJDFPksReEVGN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaW+YYwAKCRAr4qD1Cr/k
ChHAAP9iDST/XnQj/nmTMEMP8ssqD54Dc1JbkmFJ6e+xzhCLdAEAya0i+FiOQRQ0
XWJqEKXQAg/Oim8IKexzTlqkjHwcHAQ=
=+0sB
-----END PGP SIGNATURE-----

--zdxLJDFPksReEVGN--
