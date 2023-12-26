Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D472C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 14:32:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4840A87855;
	Tue, 26 Dec 2023 15:32:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XH36L+vl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 153628789B; Tue, 26 Dec 2023 15:32:45 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8FF387751
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 15:32:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-35fff16827fso5294465ab.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 06:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703601161; x=1704205961; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=elVT3DLlEHNUgHADzyBhQjnPsfutsbgOdaTIVI11p5A=;
 b=XH36L+vlmwLonMpXDLem14JrTAMzBne/JZ6ISEEvZf30JIZmmboQvYiMAUQuroxUN1
 Q4eKSbZi2jbus0FG0VSvkmrQ2YCKI5dGW7DG/ZaIW8kKKvfDruJwDlNvRoO7HfwsIVpv
 Imdu+z4e3LvsFC1vdNup4Dm665SdkVxpEgevo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703601161; x=1704205961;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=elVT3DLlEHNUgHADzyBhQjnPsfutsbgOdaTIVI11p5A=;
 b=FFLRoLssDBT6fCvAZWWAFN+6SPapSofbQy6rfGe1gfnx2cYcOP8A6a92ZJKrITK0xp
 W3Tm6WBTk20Jyddjw0gL+D4w8/iEVitehfjkuzs2Tzig8QYmLWnrgqfNnt7OU1FLbKq+
 Cb+6+zvLZf7FL3tJeh2ny/JsRjX3wX/rAJkpkdBlJ63LkgEIEhngw7WibYtwrMpd7JiY
 LxYsZrVJOr7SYTuaDjAAuRsB8PUlgcILHazGt33GVFdPzJlmjXyQ9kpIpfSec8KffIqN
 l2vF2RdPBBUO812P5RKptTSwJpjZOBOoAgRAgT0pbqs5B/NkRZdjEgexxbql0rMZlja1
 2rfg==
X-Gm-Message-State: AOJu0Yx8a65MpD7ZStA50h30yYfDSai5qTY7dqSVsQ1gQsPkmmGGr64T
 VhZSqV3lAoUl8dpVoUo8lJ0oUG1z1/vOPQ==
X-Google-Smtp-Source: AGHT+IEsIMCBK72E3fF6H+IJF9ZTvfZLkRynwgYKLW5O/HnBzfCGzgiQdMW1oxgGbvZJ4TDz/Zux3A==
X-Received: by 2002:a05:6e02:12ed:b0:35f:f707:3ebc with SMTP id
 l13-20020a056e0212ed00b0035ff7073ebcmr3033853iln.74.1703601161361; 
 Tue, 26 Dec 2023 06:32:41 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 fd10-20020a05690c318a00b005eb7876abe0sm2693188ywb.103.2023.12.26.06.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 06:32:40 -0800 (PST)
Date: Tue, 26 Dec 2023 09:32:39 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de
Subject: Re: [PATCH v3 4/4] fs: remove explicit efi configuration dependency
Message-ID: <20231226143239.GJ2652760@bill-the-cat>
References: <20231218023842.281336-1-takahiro.akashi@linaro.org>
 <20231218023842.281336-5-takahiro.akashi@linaro.org>
 <CAPnjgZ0vq6kxiBNOwbi1JyMxV44S46uKXd1vbPNHFX5nwYLVtQ@mail.gmail.com>
 <14EA5E9B-23EB-4BD5-ACA9-7CEA6BC35453@gmx.de>
 <CAPnjgZ2n=yoL3GwUMsiL9dm-w8P88d_N5MUxMEHx+J9q666w0Q@mail.gmail.com>
 <20231220132503.GK2513409@bill-the-cat>
 <CAFLszTicmvmK9zVuvNF3v2twgEMzxrdPRuaxDJaXnTEqMR5exA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TzIxb4VlpVof4t0F"
Content-Disposition: inline
In-Reply-To: <CAFLszTicmvmK9zVuvNF3v2twgEMzxrdPRuaxDJaXnTEqMR5exA@mail.gmail.com>
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


--TzIxb4VlpVof4t0F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 09:46:52AM +0000, Simon Glass wrote:
> Hi,
>=20
> On Wed, Dec 20, 2023 at 1:25=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Tue, Dec 19, 2023 at 09:46:27PM -0700, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Mon, 18 Dec 2023 at 15:16, Heinrich Schuchardt <xypron.glpk@gmx.de=
> wrote:
> > > >
> > > >
> > > >
> > > > Am 18. Dezember 2023 16:01:40 MEZ schrieb Simon Glass <sjg@chromium=
=2Eorg>:
> > > > >Hi AKASHI,
> > > > >
> > > > >On Sun, 17 Dec 2023 at 19:39, AKASHI Takahiro
> > > > ><takahiro.akashi@linaro.org> wrote:
> > > > >>
> > > > >> Now it is clear that the feature actually depends on efi interfa=
ces,
> > > > >> not "bootefi" command. efi_set_bootdev() will automatically be n=
ullified
> > > > >> if necessary efi component is disabled.
> > > > >>
> > > > >> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > >> ---
> > > > >>  fs/fs.c | 7 +++----
> > > > >>  1 file changed, 3 insertions(+), 4 deletions(-)
> > > > >>
> > > > >> diff --git a/fs/fs.c b/fs/fs.c
> > > > >> index f33b85f92b61..82ee03b160e9 100644
> > > > >> --- a/fs/fs.c
> > > > >> +++ b/fs/fs.c
> > > > >> @@ -791,10 +791,9 @@ int do_load(struct cmd_tbl *cmdtp, int flag=
, int argc, char *const argv[],
> > > > >>                 return 1;
> > > > >>         }
> > > > >>
> > > > >> -       if (IS_ENABLED(CONFIG_CMD_BOOTEFI))
> > > > >> -               efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : =
"",
> > > > >> -                               (argc > 4) ? argv[4] : "", map_s=
ysmem(addr, 0),
> > > > >> -                               len_read);
> > > > >> +       efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
> > > > >> +                       (argc > 4) ? argv[4] : "", map_sysmem(ad=
dr, 0),
> > > > >> +                       len_read);
> > > > >
> > > > >As I understand it, this is setting the boot device so that (if it
> > > > >happens to be an efi application) it will know which device it came
> > > > >from. But this is a hack. For bootstd, the device is known as it l=
oads
> > > > >the kernel.
> > > >
> > > > Please, consider what happens when the user interactively executes =
the load and bootefi command from the console.
>=20
> Yes, that case needs to be handled.
>=20
> > > >
> > > > >
> > > > >Also it does not deal with memory allocation (nor can it).
> > > > >
> > > > >Where are we using the 'load' command to load a kernel? The distro
> > > > >scripts are deprecated.
> > > >
> > > > Some users use boot.scr scripts
>=20
> We will need to figure out that. But we should make bootstd do the right =
thing.
>=20
> > > >
> > > >
> > > > >
> > > > >At some point this code should be removed. Is it too early for tha=
t?
> > > >
> > > > Yes, as long as we allow users to invoke the bootefi command with a=
n address pointer.
> > >
> > > So how about we create the new path, with the info passed in as part
> > > of the bootefi call? Then we can remove the call from bootstd, at
> > > least.
> >
> > Why? It's not clear to me we'd have this information available at that
> > point unless we stored things to pass along at that point too.
>=20
> For the bootstd case, we know the device where the kernel came from.
> See distro_efi_boot() for this code. It calls efiload_read_file()
> which calls set_efi_bootdev().
>=20
> We should instead pass the device information to efi_binary_run().
>=20
> With that done, we can perhaps make the 'load' and 'tftp' commands
> record the device information somewhere, so that bootm can pick it up
> when it starts and put it in 'images'. Then at some point we can clean
> up the 'devnr' parameter, which should really be a partition number,
> since the 'dev' parameter tells you the device.
>=20
> Anyway, this series is fine, so long as we can agree to the above.

I'm getting very worried that we're spending a lot of time deciding how
users are going to use the system, without getting input from them on
what their use cases are, and are not, and why they've chosen what
they've chosen. Talking with some of the Debian people about why they're
using script + extlinux, and Armbian people about what they're doing
(which is just scripts?) should be the first priority before we decide
how booting things is going to work, outside of the EFI cases (which to
be clear, are having their interests / needs represented already I
believe).

--=20
Tom

--TzIxb4VlpVof4t0F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWK5AcACgkQFHw5/5Y0
tyxt9Av+Kfz0qSfMoXBzWAh2xS+r8ercd604Ms9PyPMk/zNOi7MznhLlatCDkB4a
JGJkCZvolL+lDSn5h7FDzGIdhod5m26K1sUg9yQ5VsTmLubKC1TIvsPWklqpQSAN
TckJkQ41+IRmgwuE9VmsduMKTFSIaor5DAIOzUZI+AlhxcaH/u4O0bJNJXQvDFrY
+nrjDOEyIUolq407lcNc/ZtR22acJzjgFAoI86w3qoTbqnhZQVD/5kAZnPl2g4aq
gv2v1rMf6I7HKkWHsjuFwxkaUD8zBRAz89jK1Rf9gTGQdx7VvDGM67PejcWgP7ZV
vToXpvIgVfpfEIpvE2aac3P93tI/+WRjVKDF3WydE7T7l2hmSPraKyyCsBvHfdLu
ZnJA+gCQyscgKSabIYmvLD8HDTxP3IK1q1HSfm+5hGG93D06f5DsqZyUn2MttAz8
alW/DWmc80uYkWpeakoQsPqOeSvC0Tl0/zZykI83W3uHYJqD2HVYN3z/f7wH0qmz
z37O4Mcm
=8w4H
-----END PGP SIGNATURE-----

--TzIxb4VlpVof4t0F--
