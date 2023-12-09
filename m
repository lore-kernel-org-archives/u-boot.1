Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86EFC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 23:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05A1487067;
	Sun, 10 Dec 2023 00:16:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HWMlQ+CW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F382987053; Sun, 10 Dec 2023 00:16:38 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BDEE87067
 for <u-boot@lists.denx.de>; Sun, 10 Dec 2023 00:16:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5d3758fdd2eso30599667b3.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 15:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702163794; x=1702768594; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8fZ6Yu7sHGNhaHwJQ4xbeVY8SZZJ6BjEUHv/biJZYjc=;
 b=HWMlQ+CWPxNf9VxJXf6rEYDqqJ51bjYFoIWXxyNkoAyhJJx72zLpiSmlo1d+Z5SbDT
 VtIMwRv8/358hq/E50UBq3gBeZWb7q33rzfvwHEiisShv5Kcf/BV1Wvehs0jBo7wo05r
 7Zo+JA+OT74QRY2g0oV9eqgSw3kfsEvi0TyMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702163794; x=1702768594;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8fZ6Yu7sHGNhaHwJQ4xbeVY8SZZJ6BjEUHv/biJZYjc=;
 b=EYSeG68p6StCSr65IPAYz8f8H9NXU9m0YodjcZfXg+XapaWqfgV7gu92JNFUiz7NIv
 60mmCXkX2VsuO8EEBSSjaA46sSR624NId1iqS0ciUI/CqvWhZ8pnETCY7bUkhngCeHka
 pxLrplNm43gtMawggPGpz317Oe1IDvAPcKRuJz9q4iPg5xamsJJr3KNM1BK7U0x5Iqyj
 a4hRs+fTGofzq2vSBvuZlpgaxfWMZmHKukmDOZSifVN+qaKiViayOQ9GFF0YQVShUVNb
 sLf+tyR+pXozQSDLEej7pA6HnO0N2W2WmLW2/Yc0MwRL6Fm2YbLrTSSaoiokiUXXaKWh
 UE7g==
X-Gm-Message-State: AOJu0YzPWVw0dX5X3Gr39fY8FTatPjacUSmFllgBl9MIxmTzsLei6q3X
 sXMkGNZlNuJHMx4S+6XGyFJsFrzeEn5cVhcX7R/jNg==
X-Google-Smtp-Source: AGHT+IExQFCiQCM/x7hnkGCY8U2Hv3uZM9dTelI7p/kSudeJeNv5nQdXj9yg6KbYMyhxOnTvwuoTKw==
X-Received: by 2002:a81:5cc2:0:b0:5d7:1941:3577 with SMTP id
 q185-20020a815cc2000000b005d719413577mr1280808ywb.94.1702163793872; 
 Sat, 09 Dec 2023 15:16:33 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8dee-9b11-e8b3-3204.res6.spectrum.com.
 [2603:6081:7b00:6400:8dee:9b11:e8b3:3204])
 by smtp.gmail.com with ESMTPSA id
 gi3-20020a05690c424300b005df4992992esm929341ywb.24.2023.12.09.15.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 15:16:33 -0800 (PST)
Date: Sat, 9 Dec 2023 18:16:31 -0500
From: Tom Rini <trini@konsulko.com>
To: Francis Laniel <francis.laniel@amarulasolutions.com>
Cc: u-boot@lists.denx.de,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v12 00/24] Modernize U-Boot shell
Message-ID: <20231209231631.GO2513409@bill-the-cat>
References: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lcm+qk3tdl7sa+zX"
Content-Disposition: inline
In-Reply-To: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
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


--lcm+qk3tdl7sa+zX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 11:30:01PM +0100, Francis Laniel wrote:

> Hi.
>=20
>=20
> During 2021 summer, Sean Anderson wrote a contribution to add a new shell=
, based
> on LIL, to U-Boot [1, 2].
> While one of the goals of this contribution was to address the fact actual
> U-Boot shell, which is based on Busybox hush, is old there was a discussi=
on
> about adding a new shell versus updating the actual one [3, 4].
>=20
> So, in this series, with Harald Seiler, we updated the actual U-Boot shel=
l to
> reflect what is currently in Busybox source code.
> Basically, this contribution is about taking a snapshot of Busybox shell/=
hush.c
> file (as it exists in commit 37460f5da) and adapt it to suit U-Boot needs.
>=20
> This contribution was written to be as backward-compatible as possible to=
 avoid
> breaking the existing.
> So, the modern hush flavor offers the same as the actual, that is to say:
> 1. Variable expansion.
> 2. Instruction lists (;, && and ||).
> 3. If, then and else.
> 4. Loops (for, while and until).
> No new features offered by Busybox hush were implemented (e.g. functions).
>=20
> It is possible to change the parser at runtime using the "cli" command:
> =3D> cli print
> old
> =3D> cli set modern
> =3D> cli print
> modern
> =3D> cli set old
> The default parser is the old one.
> Note that to use both parser, you would need to set both
> CONFIG_HUSH_MODERN_PARSER and CONFIG_HUSH_OLD_PARSER.
>=20
> In terms of testing, new unit tests were added to ut to ensure the new be=
havior
> is the same as the old one and it does not add regression.
> Nonetheless, if old behavior was buggy and fixed upstream, the fix is the=
n added
> to U-Boot [5].
> In sandbox, all of these tests pass smoothly:
> =3D> printenv board
> board=3Dsandbox
> =3D> ut hush
> Running 20 hush tests
> ...
> Failures: 0
> =3D> cli set modern
> =3D> ut hush
> Running 20 hush tests
> ...
> Failures: 0
>=20
> Thanks to the effort of Harald Seiler, I was successful booting a board:
> =3D> printenv fdtfile
> fdtfile=3Damlogic/meson-gxl-s905x-libretech-cc.dtb
> =3D> cli get
> old
> =3D> boot
> ...
> root@lepotato:~#
> root@lepotato:~# reboot
> ...
> =3D> cli set modern
> =3D> cli get
> modern
> =3D> printenv fdtfile
> fdtfile=3Damlogic/meson-gxl-s905x-libretech-cc.dtb
> =3D> boot
> ...
> root@lepotato:~#
>=20
> This contribution indeed adds a lot of code and there were concern about =
its
> size [6, 7].
> With regard to the amount of code added, the cli_hush_upstream.c is 13030=
 lines
> long but it seems a smaller subset is really used:
> gcc -D__U_BOOT__ -E common/cli_hush_upstream.c | wc -l
> 2870
> Despite this, it is better to still have the whole upstream code for the =
sake of
> easing maintenance.
> With regard to memory size, I conducted some experiments for version 8 of=
 this
> series and for a subset of arm64 boards and found the worst case to be 4K=
 [8].
> Tom Rini conducted more research on this and also found the increase to be
> acceptable [9].
>=20
> If you want to review it - your review will really be appreciated - here =
are
> some information regarding the commits:
> * commits marked as "test:" deal with unit tests.
> * commit "cli: Add Busybox upstream hush.c file." copies Busybox shell/hu=
sh.c
> into U-Boot tree, this explain why this commit contains around 12000 addi=
tions.
> * commit "cli: Port Busybox 2021 hush to U-Boot." modifies previously add=
ed file
> to permit us to use this as new shell.
> The really good idea of #include'ing Busybox code into a wrapper file to =
define
> some particular functions while minimizing modifications to upstream code=
 comes
> from Harald Seiler.
> * commit "cmd: Add new parser command" adds a new command which permits
> selecting parser at runtime.
> I am not really satisfied with the fact it calls cli_init() and cli_loop(=
) each
> time the parser is set, so your reviews would be welcomed.
> * Other commits focus on enabling features we need (e.g. if).
>=20
> Changes since:
>  v2:
>   * Added a small fix to compile sandbox with NO_SDL=3D1.
>   * Added a command to change parser at runtime.
>   * Added 2021 parser function to all run_command*().
>  v3:
>   * Various bug fixes pointed by the CI.
>   * Added upstream busybox hush commits until 6th February 2022.
>  v4:
>   * Various cleaning.
>   * Modified python test to accept failure output when the test are desig=
ned to
>   fail.
>   * Bumped upstream busybox hush commits until 24h March 2022.
>  v5:
>   * Bumped upstream busybox hush commits until 30th January 2023.
>   * Fix how hush interprets '<' and '>', indeed we needed to escape them =
but I
>   removed this behavior as tests are handled by test command and not hush
>   itself. This permitted to have the ut fdt to pass.
>   * Fix a problem with how exit was handled. This was reported by the ut =
exit
>   test.
>  v6:
>   * There was no v6 and I got mixed up with version.
>  v7:
>   * Bumped upstream busybox hush commits until 9th May 2023.
>   * Renamed parser command to change parser at runtime to cli and added
>   documentation.
>   * Added better separation of patches.
>   * Removed code about __gnu_thumb1_case_si as it was merged in another s=
eries.
>   * Various cleaning.
>  v8:
>   * Bumped upstream busybox hush commits until 25th May 2023.
>  v9:
>   * Bumped upstream busybox hush commits until 2nd October 2023.
>  v10:
>   * Fixed a build error in commit adding cli command.
>   * Add new CONFIG_HUSH_SELECTABLE to only build cli command if the two s=
hell
>   flavors are selected.
>  v11:
>   * Renamed everything containing 2021 to modern.
>   * Fixed cmd Kconfig indentation.
>   * Set modern parser as default for majority of boards except some.

Thanks, this looks good overall and I'll put things in CI soon and aim
to get this in to -next and v2024.04.

--=20
Tom

--lcm+qk3tdl7sa+zX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV09UwACgkQFHw5/5Y0
tyxNQQv/eiQUDEjHaW8leVK+Ety8ATLTS3QFqU4hfOdFNQ4T2grdAnJTx3NeE8jr
LBEpTb+uxBVE1pIY1V3JRF3tuNM9W1Iv3+qNUOCtmJULZVyb+ndnecFOKteKZqmZ
NfoBtBI7ZLeTOaNAioalSalJpxJZci9EUkCCQvPKMLToa/cm+9ZMN7TO6FALkbak
G9bYgj+g/0D8kn0jHLYGtpwin/CkwM3CVuPz+0RZq1w28Cx7QtA2y33c8KcTUjUR
+Ompp1HuVONi70buOIx4dFn02HZmEpmZU8TSD2sdd1AWWMDV/ZasuG9LiirwnO6d
9XJxh4GrWZdOE3xuYQHMB5IBlhvXluSE8rOVbRsGSgGxkuNOL8fpoqSszrgft4xa
GnM9MOerRW//OfATFLHCTWuJROnzrx9dWYvSQ4bG9TU70VmRSP829gCdEklRhML7
TfDtDR/8XYsEYa42gVXcEYUCuhTfLxegHt+/x7t15JtQfcI4k1BBag643WXQ9zmu
8u42PZjY
=UomB
-----END PGP SIGNATURE-----

--lcm+qk3tdl7sa+zX--
