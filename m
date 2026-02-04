Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A514CEA7943
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 21:20:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A9948063E;
	Wed,  4 Feb 2026 22:20:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QFikTYUw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B780839A8; Wed,  4 Feb 2026 22:20:17 +0100 (CET)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5C46800AE
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 22:20:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7d1872504cbso276665a34.0
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 13:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770240013; x=1770844813; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cWzO0GPDc5CKFbz6V1h0VfzpHJeRj9nY/eyKefsgdZQ=;
 b=QFikTYUwetLg30DqYQA/2yVjrPOgH1jbAZSIXO46eAe2ktWt62pk8eIovGYcqKqFhp
 JapjL2tYhjHFaudGIpylTpj0x0zLM9WGbjlISBNehW6dF+Bc5hFU9Cxklmq/I/jLFitc
 4WnJ4/Sxq7Lr4X1UXuNyiy5S1waubwFXxFy4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770240013; x=1770844813;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cWzO0GPDc5CKFbz6V1h0VfzpHJeRj9nY/eyKefsgdZQ=;
 b=jaSpVzY5Igb9wUIl9MTLhzCmEBmjs9364defxRqRl5WBkuC0fc1R9pCqRoCNZvs7BJ
 MnM74LEv5q9ubaaPi4xJiYNfXLZ8l3YRMQ0/gHluTAUDG5hBSCDAI3dg0ymyFsXGn//e
 fdt6/wXZ6Fhk4W+eswZ8WxwhGIexY8kPse7QjKa3udIWd5jkInsuLRTuNnME/pEtFYLo
 TaZXwBeSMHidvzRwiOXFktGxxEQqM6j28nzU+WbaZYR8Xp3VByZUBQFejJDOeWDdJsKc
 quQoe+UnArUj2RjwgD3+D3rFO02IYevHj47tp7zJ464o3v0Go1Gt2dvBx/+LFQxsfs91
 AiPw==
X-Gm-Message-State: AOJu0YwbkozKhjYw4PgZw8wqT37KeCysC0ZyooQnwzsXz582pBE2guBd
 aFK/wWJ88sNAQtoPYQ73QntezqbKmPqA5bGsdPcj8JDeVcEXxt1s0zlKubtirByBGLs=
X-Gm-Gg: AZuq6aJOURS7pBUuHNOsGtfGV6SL1BKpXVvFcQh22x0k3xnoo8QHD/dp2J+qDgKUjP4
 AImxEqbJTpLzlMeq9hcL/zu7GCtKvUIthgbL/uYr6G/GckBKE8GjMQ+0RCb57WZsvmOo/6y1b3e
 UPfwXWDbvpemsEugk2ydZytwmBXG+6NrFEogrlIyebHwFkNIOiQwTQVBblaSCchkwuJP04spuWS
 pKgpobboRzJ6F9F+PjUt9N25rj+PiZuKhBh24Myv5LiCQPEIKot0ZkdPqU9J2j63Sg7ynLqWbVA
 Kme0KlQ5zMAqPth3ql0UABIeFY9Lcmm/B8OdSnRUEoTPcbb9EWGK4XQ+ix6U6mzEDW0aapa3LLB
 CcFvCVzymxZEGBHsf4D3FQZI874koN2ke8dRD4QdvY+my+x4jSyha9D8gIc9FmD/o2iJ686CNuk
 Fd+cht/W89rapc4PRuDN2/mmfqPtoRgdZTr054dgkvLIovb4iwWa8uuVQnJdmI0wH1C/QO83MCS
 rYKQzG2UX/Qmvw1dzQSWCpx0f+PX8HakN6gs+ZyIhN39YvIXA==
X-Received: by 2002:a05:6830:3146:b0:7cf:d075:2674 with SMTP id
 46e09a7af769-7d456acf930mr567889a34.15.1770240013531; 
 Wed, 04 Feb 2026 13:20:13 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d449229ffdsm2318532a34.23.2026.02.04.13.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 13:20:12 -0800 (PST)
Date: Wed, 4 Feb 2026 15:20:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Phil Sutter <phil@nwl.cc>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, Joel Stanley <joel@jms.id.au>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
Message-ID: <20260204212010.GD2603314@bill-the-cat>
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-3-trini@konsulko.com>
 <aYO3HOmFFVAkjfKD@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K5lVjMoGP0MwgjKA"
Content-Disposition: inline
In-Reply-To: <aYO3HOmFFVAkjfKD@orbyte.nwl.cc>
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


--K5lVjMoGP0MwgjKA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2026 at 10:16:12PM +0100, Phil Sutter wrote:
> Hi,
>=20
> On Thu, Jan 15, 2026 at 04:19:32PM -0600, Tom Rini wrote:
> > With commit 0535e46d55d7 ("scripts/dtc: Update to upstream version
> > v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if our
> > device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM: OMAP2+:
> > Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi explains
> > that we must have ALIGN(x) statements inside of a section to ensure that
> > padding is included and not simply that the linker address counter is
> > incremented. To that end, this patch:
> > - Expands some linker sections to be more readable when adding a second
> >   statement to the section.
> > - Aligns the final section before _end (for U-Boot) or
> >   _image_binary_end or __bss_end (for xPL phases) by 8-bytes by adding
> >   '. =3D ALIGN(8);' to the final section before the symbol.
> > - Ensure that we do have alignment by adding an ASSERT so that when not
> >   aligned we fail to link (and explain why).
> > - Remove now-spurious  '. =3D ALIGN(x);' statements that were intended =
to
> >   provide the above alignments.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
>=20
> For unclear reasons, this seems to break boot via xmodem protocol on my
> Synology DS414. I found this commit via 'git bisect'. The symptom is:
>=20
> | kwboot version 2026.04-rc1-00098-g6ad0cf8f83db
> | Detected kwbimage v1 with SPI boot signature
> | Patching image boot signature to UART
> | Aligning image header to Xmodem block size
> | Sending boot message. Please reboot the target...\
> | Sending boot image header (67584 bytes)...
> |   0 % [................................................................=
=2E.....]
> |  13 % [................................................................=
=2E.....]
> |  26 % [................................................................=
=2E.....]
> |  39 % [................................................................=
=2E.....]
> |  53 % [................................................................=
=2E.....]
> |  66 % [................................................................=
=2E.....]
> |  79 % [................................................................=
=2E.....]
> |  92 % [......................................                          =
      ]
> | Done
> | Missing DTB
> | spl_init() failed: -2
> | ### ERROR ### Please RESET the board ###
> |=20
> |=20
> | xmodem: Connection timed out
>=20
> Debug printf()s in fdtdec_prepare_fdt() show that fdt_check_header()
> returns -FDT_ERR_BADMAGIC.
>=20
> With HEAD at a8d982e1f1726 ("x86: cpu: Fix crash on FTRACE enabled
> builds"), reverting arch/arm/cpu/u-boot-spl.lds like so:
>=20
> | @@ -41,14 +41,21 @@ SECTIONS
> |                 __binman_sym_start =3D .;
> |                 KEEP(*(SORT(.binman_sym*)));
> |                 __binman_sym_end =3D .;
> | -               . =3D ALIGN(8);
> |         }
> | =20
> | +       . =3D ALIGN(4); /* critical! */
> |         __image_copy_end =3D .;
> | +       .rel.dyn : {
> | +               __rel_dyn_start =3D .;
> | +               *(.rel*)
> | +               __rel_dyn_end =3D .;
> | +       }
> | +
> | +       . =3D ALIGN(8);
> |         _image_binary_end =3D .;
> |         _end =3D .;
> | =20
> | -       .bss : {
> | +       .bss __rel_dyn_start (OVERLAY) : {
> |                 __bss_start =3D .;
> |                 *(.bss*)
> |                  . =3D ALIGN(8);
>=20
> The SPL image starts up again and continues loading the real uboot
> image. Note that I have no idea what these changes actually do, so I
> need instructions if I should dig further.

Does:
https://patchwork.ozlabs.org/project/uboot/patch/20260130183635.2612933-1-t=
rini@konsulko.com/
fix it?

--=20
Tom

--K5lVjMoGP0MwgjKA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYO4BgAKCRAr4qD1Cr/k
ColJAQCj1dwKjMTwKJBCwxbCi6Hj9kupkTISjTdXzcwWr79CYQD+M1fwvm2Yq1ed
50cL8HT1YJ7aDEJdQ2r5pH6VEKEyZQg=
=xRlg
-----END PGP SIGNATURE-----

--K5lVjMoGP0MwgjKA--
