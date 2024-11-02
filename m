Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA5DE67819
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 23:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79FC588FFC;
	Sun,  3 Nov 2024 00:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p5NLuGCq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 752D188F50; Sun,  3 Nov 2024 00:53:27 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 502B58901D
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 00:53:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b161fa1c7bso228582485a.0
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 16:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730591604; x=1731196404; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FiQk/aX42jOurJfgKaCQ0Uk24vgjzrgaeNUSqefDsrk=;
 b=p5NLuGCqA0iwuo6tIM+lMqPZubpx8jWBq6vXaNozr1CdXaey57dU3wndhH7UjD5QEk
 EDtE7mtxCWn3rmxL9ynQycP3VW03eAQNU7Kvx58hSrX1BtpNtgCtQTTygacnTFpursjG
 kIr5uD/TFQrcS+HOjUGYm0qKTic9mGG2f9Tts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730591604; x=1731196404;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FiQk/aX42jOurJfgKaCQ0Uk24vgjzrgaeNUSqefDsrk=;
 b=SDpg+/KC967uEIGCR2WvJUMrxZIGMuIMcgj4QhVhY4Eoy1eNtMBO9vTAh+PhtpiA8h
 SOfhrrpwKbKi36oreVzeTm1QWiQwx9D8VMvKz/epB0zOfxBha8SVcJUZmVsMGvcTInnE
 Tpmv0tEDy0rcTRdX4Z2cdbJF/S4e15DMqmsHMxnibEYGWD4ZrrzkF7QsrtPU24LCrW4g
 DLeNADPamGjc4gfTqsNvjJW0g5/4/R8OLKKPJA7ew1Tvq69Bi1MIyANWlsxyXWwL6PIi
 S7WPxaxLOMdvcvyl4t41BscoFLU823SVSre0VFfwYgqgWf7hKJpya5iJW4/zV0VBLCqd
 m1nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ8svv/RXlH2wkEmgYsNm/zW1bfT8qHVw/1rK860mtB1J9pJhEcfmBAjP9xrPPFO1+YukhlyM=@lists.denx.de
X-Gm-Message-State: AOJu0YxcbgjcCUIcXcUmjd9svu0Ivezy8UprZn0fn3CDeWsOlygNfq6a
 DNk3Cd1ZstYL2qmGNzTDz0YOmBk0Q3cmxVGDdtC60EUMIzEfigYduXVaHPlu4Sk=
X-Google-Smtp-Source: AGHT+IGTlejNPXnPD9c2LW3lZ4EMFbvf7B/IEwzpTQrLbpFqe0rNjuFVDnaSmW4YSx9HM9gD3XzF7Q==
X-Received: by 2002:a05:620a:244f:b0:7b1:35bc:ae0b with SMTP id
 af79cd13be357-7b193f5b8e0mr4063722085a.57.1730591604164; 
 Sat, 02 Nov 2024 16:53:24 -0700 (PDT)
Received: from bill-the-cat ([189.177.125.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a858a2sm297953385a.115.2024.11.02.16.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 16:53:23 -0700 (PDT)
Date: Sat, 2 Nov 2024 17:53:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/5] fs: ext4: implement opendir, readdir, closedir
Message-ID: <20241102235319.GY3600562@bill-the-cat>
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
 <173058992364.1044919.1983318156372551084.b4-ty@konsulko.com>
 <CAOf5uw=292JNb1g03_Hcgav4zyUckh3R1_iphHnynHVeqC82Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="x4PET3ETXlgp9UuR"
Content-Disposition: inline
In-Reply-To: <CAOf5uw=292JNb1g03_Hcgav4zyUckh3R1_iphHnynHVeqC82Jw@mail.gmail.com>
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


--x4PET3ETXlgp9UuR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 03, 2024 at 12:36:38AM +0100, Michael Nazzareno Trimarchi wrote:
> Hi Tom
>=20
> On Sun, Nov 3, 2024 at 12:26=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Sat, 26 Oct 2024 08:40:43 +0200, Heinrich Schuchardt wrote:
> >
> > > With this series opendir, readdir, closedir are implemented for ext4.
> > > These functions are needed for the UEFI sub-system to interact with
> > > the ext4 file system.
> > >
> > > To reduce code growth the functions are reused to implement the ls
> > > command for ext4.
> > >
> > > [...]
> >
> > Applied to local tree/v2-tidy-test-dir, thanks!
> >
> Am I sleeping?

=2E.. I always forget b4 compares with checked out branch, that should
have been master.

> int ext4fs_opendir(const char *dirname, struct fs_dir_stream **dirsp) {
>     struct ext4_dir_stream *dirs =3D NULL;
>     struct ext2fs_node *dir =3D NULL;
>     int ret;
>=20
>     *dirsp =3D NULL;
>=20
>     dirs =3D calloc(1, sizeof(struct ext4_dir_stream));
>     if (!dirs)
>         return -ENOMEM;
>=20
>     dirs->dirname =3D strdup(dirname);
>     if (!dirs->dirname) {
>         free(dirs);
>         return -ENOMEM;
>     }
>=20
>     ret =3D ext4fs_find_file(dirname, &ext4fs_root->diropen, &dir,
> FILETYPE_DIRECTORY);
>=20
>     if (ret =3D=3D 1) {
>         ret =3D 0;
>         *dirsp =3D (struct fs_dir_stream *)dirs;
>     } else {
>         ret =3D -ENOENT;
>         free(dirs->dirname);
>         free(dirs);
>     }
>=20
>     if (dir)
>         ext4fs_free_node(dir, &ext4fs_root->diropen);
>=20
>     return ret;
> }
>=20
> Should not be like this?

Please elaborate?

--=20
Tom

--x4PET3ETXlgp9UuR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcmu2cACgkQFHw5/5Y0
tyw8Igv/XshBH+oox4zUplQREoGa0Px5rnlzbS8zS5Usrl5AcnSFWyAuLhh4q4Jb
g2+BwrHocroXvTzXWSS0CMozgqKt8Hunu+WaAfCzZFxGtoRuw74uIYxk8ffP1LA7
F04JCmHiYwryhjhWJqumcHdTFh/S2SJaQ48s6Z1zcvWLUxXQXBNOg6OjByXNIwAd
a/fsrxG0W18mwJKTd/nZZ0yGUKMwBHp6QDd/QNxPpyYGLiOCXs/jc1VGtREkKbGH
+Mwo38fhI7SYfh6SJ0tUx2OZJm20RX76/7s19jt/rLocvYNUD0uNg2098vGT9p+M
WMMDlObrRWkoBIvkKVSzItr18Gd5EEFNV8Ct+n8CXC4IUU3wmY+6IJBKHRs+fxoy
HFElX62T1qp0aqydn8D/8i5dUe5eWzlfQYniZ5MLZY/4g/hu1iGN14U/01ht7YnC
IpyQmZgUx4Vpd2Hm5BaCDVX2VC/9zaiyBgoRrgPTQR/QahyEu1RUb9ntT6uubLjg
zFusJye6
=a6Sr
-----END PGP SIGNATURE-----

--x4PET3ETXlgp9UuR--
