Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F3BC71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 15:27:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11AF986515;
	Mon, 28 Aug 2023 17:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KfYx7hO9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BBD786515; Mon, 28 Aug 2023 17:27:48 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE49A86534
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 17:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-592976e5b6dso35623857b3.2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 08:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693236463; x=1693841263;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hcMb9fKfGFbQ9okEkyU+owMj8MIaZAuqobtXgqcgiqk=;
 b=KfYx7hO9dEEe6fguSmW9iAhHIA12Wy6NNBrNYEP4Up9Z6msarNmQjD+AOB+J0m24MG
 COHT02OcIG5ieXdNee1BeXLZ2PpuySi6a07STz1Ie4DXZdwvtAFoInAUSOpFcuUrvt9v
 1Tl5JxJbrKAIBDSykELDvFDxP6je709POAL90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693236463; x=1693841263;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hcMb9fKfGFbQ9okEkyU+owMj8MIaZAuqobtXgqcgiqk=;
 b=lIwp2QVPSBgIH6gIQWtRxv2C19m/2uRkCOnbStNWug3vFqxXoS1A6X+mXwGwqmTabH
 aXZzwx5p1jHqdeheKPDlOHWl+U3eZ5poY/Yzx1Fn1J3YnJdYFamOaPnZjrfvZOOT7Svi
 PjzWgTB5M9kKr4itnX0uHjVrjU0i/Do1HVTeBFqY+i/4u4RB65xA0vAVte3sZnHUNWRv
 rTxJ2JGfnd10FYjJ408qOAgdzyBM2Fk51ASVe46+DSqip+xVVqq6rekY/CYQ5QFKJIVP
 d5LbiJhfhxpLRDRdDQFUWPBx1vc2UeQ/oFwdHaJSPZCZ/AoUFYi7pQ5vM7xVV6t7Lbo1
 yr5Q==
X-Gm-Message-State: AOJu0Yyry6I1NckyeJAA8qBvNMRFnqkMS/113Zr8tLhCXxkIVcfgopZa
 eSaCwxZnYcQkUtAuJEPX/4lsDw==
X-Google-Smtp-Source: AGHT+IHrxGSSe7hh/M8dix2kR3cO40hSTgerSU0qdu3zmAoLRVaxiqmZT4xHpvs7pYZNkBLjah04SQ==
X-Received: by 2002:a05:690c:290e:b0:594:1be1:7d33 with SMTP id
 eg14-20020a05690c290e00b005941be17d33mr7397272ywb.28.1693236463549; 
 Mon, 28 Aug 2023 08:27:43 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c01a-9a8d-1e42-2ea4.res6.spectrum.com.
 [2603:6081:7b00:6400:c01a:9a8d:1e42:2ea4])
 by smtp.gmail.com with ESMTPSA id
 r189-20020a0de8c6000000b0058390181d16sm2204434ywe.30.2023.08.28.08.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 08:27:42 -0700 (PDT)
Date: Mon, 28 Aug 2023 11:27:40 -0400
From: Tom Rini <trini@konsulko.com>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Asherah Connor <ashe@kivikakk.ee>, Alexander Graf <agraf@csgraf.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v2 4/7] qfw: Add flag to allow probing before relocation
Message-ID: <20230828152740.GE3953269@bill-the-cat>
References: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
 <20230822121026.1007105-5-alpernebiyasak@gmail.com>
 <CAPnjgZ0uez=Wj+_G7nrz8iknuc_Tn56TdHjSS2R_73h5-FrJvA@mail.gmail.com>
 <347da6dc-7adb-48cc-afb7-a47ca621bb06@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="azIgj+QniNKd/wRg"
Content-Disposition: inline
In-Reply-To: <347da6dc-7adb-48cc-afb7-a47ca621bb06@gmail.com>
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


--azIgj+QniNKd/wRg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 06:22:31PM +0300, Alper Nebi Yasak wrote:
> On 2023-08-22 21:56 +03:00, Simon Glass wrote:
> > Hi Alper,
> >=20
> > On Tue, 22 Aug 2023 at 06:10, Alper Nebi Yasak <alpernebiyasak@gmail.co=
m> wrote:
> >>
> >> QEMU firmware config drivers need to be probed to bind the ramfb devic=
e.
> >> The ramfb driver needs to be bound before relocation to properly reser=
ve
> >> video memory for it, otherwise it cannot be probed after relocation. A=
dd
> >> the flag to probe QEMU firmware config drivers before relocation so th=
at
> >> ramfb can work as an initial vidconsole.
> >>
> >> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> >> ---
> >> Alternatively, I guess I could default VIDEO_PCI_DEFAULT_FB_SIZE to a
> >> higher size with "if VIDEO_RAMFB". But it exists because "PCI drivers
> >> cannot be bound before relocation unless they are mentioned in the
> >> devicetree" and qfw is in the QEMU-generated devicetree unlike those, =
so
> >> I assumed this would be the preferred way.
> >>
> >> Changes in v2:
> >> - Add patch "qfw: Add flag to allow probing before relocation"
> >>
> >>  drivers/misc/qfw.c         | 1 +
> >>  drivers/misc/qfw_mmio.c    | 1 +
> >>  drivers/misc/qfw_pio.c     | 1 +
> >>  drivers/misc/qfw_sandbox.c | 1 +
> >>  4 files changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/misc/qfw.c b/drivers/misc/qfw.c
> >> index 4e4260982cce..265f45290011 100644
> >> --- a/drivers/misc/qfw.c
> >> +++ b/drivers/misc/qfw.c
> >> @@ -414,6 +414,7 @@ UCLASS_DRIVER(qfw) =3D {
> >>         .name           =3D "qfw",
> >>         .post_bind      =3D qfw_post_bind,
> >>         .per_device_auto        =3D sizeof(struct qfw_dev),
> >> +       .flags =3D DM_FLAG_PRE_RELOC,
> >>  };
> >=20
> > Should we add this to the DT instead?
>=20
> I've experimented a bit, and got something that works nice on x86
> because we have the device-trees in-tree. So I can add something to
> arch/x86/dts/qemu-*.dts like:
>=20
>     / {
>         fw-cfg {
>             compatible =3D "qemu,fw-cfg-pio";
>             bootph-some-ram;
>=20
>             qfw-ramfb {
>                 compatible =3D "qemu,qfw-ramfb";
>                 bootph-some-ram;
>             };
>         };
>     };
>=20
> Then add the compatibles as .of_match to qfw_pio and ramfb drivers, call
> dm_scan_fdt_dev(dev) in qfw_post_bind(), merge qfw_bind_ramfb() into the
> ramfb driver probe, and it will work without the board_early_init_[fr]
> hooks or these flags. That all seems to be fine.
>=20
> The problem is other arches where QEMU generates a device-tree at
> runtime and passes it to U-Boot with OF_BOARD. It has, on arm64 (and
> with @10100000 instead on riscv64):
>=20
>     fw-cfg@9020000 {
>         dma-coherent;
>         reg =3D <0x00 0x9020000 0x00 0x18>;
>         compatible =3D "qemu,fw-cfg-mmio";
>     };
>=20
> As a proof of concept, I used `qemu-system-* -M dumpdtb=3Dfile.dtb` and
> `dtc -I dtb -O dts` to replace the empty qemu dts files, then set
> OF_BOARD=3Dn and OF_OMIT_DTB=3Dn, and added similar modifications to
> qemu-*-u-boot.dtsi. And everything seems fine like that as well.
>=20
> I think it can be automated in Makefile, but I don't think disabling
> OF_BOARD is right here. I see there's OF_BOARD_FIXUP, so I guess I'll
> try finding the fw-cfg node there and adding the bootph props and ramfb
> nodes... Is this going the right way?
>=20
> (And the pio/ramfb compatibles don't exist, do we have to use u-boot,*?)

This seems like a whole lot of work to avoid using the flags mechanism
that we have, intentionally.

--=20
Tom

--azIgj+QniNKd/wRg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTsvOMACgkQFHw5/5Y0
tyxc4wwAjEKseq/zX77pztCesV64VerUBku4HkuIB23OJ49w21LdV7pDdO9YFwEX
dXFkm6galBZJiKeUvkonYvhLf/QRWT2cw4uX60arc20+m2AK3TT5w6XLFyu6+n9d
GuIuN+G+keQadektBd0QLJ/B00QT1x/MY0l+T49Z0v7BGm3DyT0tSlrePixaRHrv
ZjAsUdIm9rSroyL5NXjtLBFY6PzRdsazJrbseNGbyIIJH3FldQJ/OkOUNIvBtiNM
qEgFCYsqFYj9gnaQYRUJBoWFLb/BPFHZVixfW2tiK73+EU1Ad9os+PDUcxbqErdL
HVN47CVHV98ZI6VsEtD/KBTdqLz4hfhJKHX+HCdQ2DlYz4XD0xboWPZdFg1zYhFW
A6it+CDV8YqIczYK/Yvi8r0BMyWCq4gGsWKqfBMgoghRgQp0za4fVtmNyy+BSxH3
BalkFF0b9lkk8xB70iTrJ/s1I133Y7OhfVJ8JLlV6DA6+bldzS3mwWfHQZ0oTWWR
BaVwazQe
=qRqI
-----END PGP SIGNATURE-----

--azIgj+QniNKd/wRg--
