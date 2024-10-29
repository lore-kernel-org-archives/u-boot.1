Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DABD5B861
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 02:53:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1016E89183;
	Tue, 29 Oct 2024 03:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NZ6otDwg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1775D8917E; Tue, 29 Oct 2024 03:53:25 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4F238917B
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 03:53:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b152a23e9aso385244385a.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 19:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730170402; x=1730775202; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XV1ymOjCDz6SPvMldtSzkRWRl1vr+U+CTqp5a7Ig44Y=;
 b=NZ6otDwga9pHzjiF3VGQTdvYT7ERKdH8x9VhveBRJYNHXE+gNduIgqQT+YmElorJ2T
 UkEEcq3wc9cM/oPEF7lCNa2smwpxJk/qZlZN8AsKDmFhZAcCb+3zlEagcvN0rHUrDdQl
 KtTf5Sm+ljRX+VumQSRr6X/p8mZn85IleG97g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730170402; x=1730775202;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XV1ymOjCDz6SPvMldtSzkRWRl1vr+U+CTqp5a7Ig44Y=;
 b=bdIuAXMkE3b71j45PqDfgf7xN5ZkpQqy8fw/8Jj6oiNYk41a71XboR5tCFzpRpPTl+
 RnR78p/V9Q5k+auuhyvTmZB97EVGiCWdrBf6voSBHjeluUABuq+ddWXosniKB/VsU0fA
 4Ocm83MzjqOI4CMhTZWNgIJloTwoQsOlNmFaQt1GOiZOa75EpCCM4ZcZmj6I68Yo8RiM
 ut6DDwU3nMpsICI5yqz4WIwW7+3u/l0pHbe1A3BK1qiqwuekkhaged9yCa7azF3BiPQM
 4AyG9PawcmiVXh5ilnY4N8Gt2urFiyG8/F34KvAxHZyW4FtTaoB0vYwPGHxLfyb1jyfg
 hGSQ==
X-Gm-Message-State: AOJu0YzFFUDOSQAwYm9hWd5ArxHXpyMkvrr3k2YIUq7i3JJPXnyxv/Te
 7HX2V83w6Zgh1DgKy0v5xK7lKJKdfUK5vcpE2doh6RiDDNPQnarw/Ok3nCRcGfLNasLTx1JVsX/
 tYiY=
X-Google-Smtp-Source: AGHT+IFMhMhRH8RYM3SyzNFqZO0CgcHpj+dqCqzWp8hawXEsMrKzynDq6LR4FKNvTI2qerwbPuqciQ==
X-Received: by 2002:a05:620a:1a89:b0:7b1:543d:c9f with SMTP id
 af79cd13be357-7b193f7001amr1605847785a.62.1730170401718; 
 Mon, 28 Oct 2024 19:53:21 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d343c69sm377789885a.105.2024.10.28.19.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 19:53:20 -0700 (PDT)
Date: Mon, 28 Oct 2024 20:53:17 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v1] acpi_table: Fix coverity defect in acpi_write_spcr
Message-ID: <20241029025317.GZ4959@bill-the-cat>
References: <20241028080837.1590247-1-patrick.rudolph@9elements.com>
 <173015803439.2338198.5277824884771902648.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lb0q90owcEE/wir3"
Content-Disposition: inline
In-Reply-To: <173015803439.2338198.5277824884771902648.b4-ty@konsulko.com>
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


--lb0q90owcEE/wir3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 05:27:14PM -0600, Tom Rini wrote:
> On Mon, 28 Oct 2024 09:08:35 +0100, Patrick Rudolph wrote:
>=20
> > Fix "Integer handling issues  (SIGN_EXTENSION)" in newly added code:
> > Cast serial_info.reg_offset to u64 to prevent an integer overflow when
> > shifted too many bits to the left. Currently this never happens as the
> > shift is supposed to be less than 4.
>=20
> Applied to u-boot/master, thanks!

"I'll just bend my rules and apply this before release, it'll be fine" I
said to myself. But:
   sandbox:  +   sandbox
+(sandbox) In file included from include/linux/printk.h:4,
+(sandbox)                  from include/linux/kernel.h:5,
+(sandbox)                  from include/linux/libfdt_env.h:13,
+(sandbox)                  from include/linux/libfdt.h:6,
+(sandbox)                  from include/fdtdec.h:17,
+(sandbox)                  from include/dm/ofnode.h:11,
+(sandbox)                  from include/dm/device.h:13,
+(sandbox)                  from include/dm.h:13,
+(sandbox)                  from lib/acpi/acpi_table.c:10:
+(sandbox) lib/acpi/acpi_table.c: In function =E2=80=98acpi_write_spcr=E2=
=80=99:
+(sandbox) lib/acpi/acpi_table.c:498:15: error: format =E2=80=98%lx=E2=80=
=99 expects argument of type =E2=80=98long unsigned int=E2=80=99, but argum=
ent 8 has type =E2=80=98u64=E2=80=99 {aka =E2=80=98long long unsigned int=
=E2=80=99} [-Werror=3Dformat=3D]
+(sandbox)   498 |         debug("UART type %u @ %lx\n", spcr->interface_ty=
pe, serial_address);
+(sandbox)       |               ^~~~~~~~~~~~~~~~~~~~~~
+(sandbox) include/log.h:159:21: note: in definition of macro =E2=80=98pr_f=
mt=E2=80=99
+(sandbox)   159 | #define pr_fmt(fmt) fmt
+(sandbox)       |                     ^~~
+(sandbox) include/log.h:260:17: note: in expansion of macro =E2=80=98log=
=E2=80=99
+(sandbox)   260 |                 log(LOG_CATEGORY,                       =
                \
+(sandbox)       |                 ^~~
+(sandbox) include/log.h:282:9: note: in expansion of macro =E2=80=98debug_=
cond=E2=80=99
+(sandbox)   282 |         debug_cond(_DEBUG, fmt, ##args)
+(sandbox)       |         ^~~~~~~~~~
+(sandbox) lib/acpi/acpi_table.c:498:9: note: in expansion of macro =E2=80=
=98debug=E2=80=99
+(sandbox)       |         ^~~~~
+(sandbox) lib/acpi/acpi_table.c:498:33: note: format string is defined here
+(sandbox)       |                               ~~^
+(sandbox)       |                                 |
+(sandbox)       |                                 long unsigned int
+(sandbox)       |                               %llx
+(sandbox) cc1: all warnings being treated as errors
+(sandbox) make[3]: *** [scripts/Makefile.build:256: lib/acpi/acpi_table.o]=
 Error 1
+(sandbox) make[2]: *** [scripts/Makefile.build:398: lib/acpi] Error 2
+(sandbox) make[1]: *** [Makefile:1914: lib] Error 2
+(sandbox) make: *** [Makefile:177: sub-make] Error 2

And most other platforms too. I'm reverting this for now, and if someone
is packaging v2025.01-rc1 too, just do that too. Sorry.

--=20
Tom

--lb0q90owcEE/wir3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcgThYACgkQFHw5/5Y0
tywN3gwApZrbSwwqc2zNM5tbvxYfOvtl34z6B8DXUJ3n8C1Umdda6e5KuPDzlKRf
HVGVDI3ZcpYiWZLiNZRNTM4wwTsGFt9gkwJ+jV/YjgmdgW767vTvaCkxRvw/YdFx
g3kEC5fI0lKNykCQQPphj9vO435t+eOfdzYEP+SO8ePVRw2vHULnJizHSZEnfneO
hrb2zCWd3m24+i/52DMJuwZzfBAsR5kR6TuZ1T9TfTMfQ2J4746dSLtvRGsEY6Ol
onCf+xa72gbUf8pkiPLhlUqfXxakZ8tzzmKNkbdy0gChxhaoecUQGNi4/l3yti+7
Na/viJvhcKUR0A/d9iumOId6p2NO+UZUORyq9bZzyl2lOp6AHqu8mKb7pvoFUIKv
eO1l4e3ySaI1MCvw/tg4aZAtbgb2xUv7MsAaknkSyPEkjUgRamWtp+fb9NMU2xYc
ykleRbJ1yVYQRKcxsSvSr8UMrYDcx11sKE+pqsA6KJhhiMFRDnKXzYIeKvFldmQU
se+L8cRq
=AEdm
-----END PGP SIGNATURE-----

--lb0q90owcEE/wir3--
