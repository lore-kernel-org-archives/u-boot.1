Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8ACAC48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D66A87FF4;
	Mon,  4 Mar 2024 16:27:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VEATaunH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D038887FF3; Mon,  4 Mar 2024 16:27:09 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 220D288008
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-68ffddd89d1so17239456d6.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566024; x=1710170824; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WuWlajUj2Zr4vGsTX3MYVqpw2geMxOco0KBQnEMiu2U=;
 b=VEATaunHUFIdQhSP99k07AlaDoSOSgOB4nnEGYCtE0ookkUzEhWeMHRuT8SniIW07c
 3tEY/gt4zzXdpCJtoz05zP7d8UZ3Lds9rJY51C/yyTakqFuzgIBEZOPEyc6meTR9/BGg
 bjzDy5RqET5/uUXQNS5DkmD+l7i1dOP5xDSC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566024; x=1710170824;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WuWlajUj2Zr4vGsTX3MYVqpw2geMxOco0KBQnEMiu2U=;
 b=sipxH10eIwOn3C9wKWlEGqF1lFrR+Bc/tHUq6QaLroNIDzcNiQQNIXXBCGf3YjNjXh
 ebKZaayz7ydIk8AMbOl3aattTPoh+bXom3t3MhrJS5FHsCYbXjrdISDG5gsDgq3CrCMv
 dzkW3ah3eTJ4IngenxoAIOIfSDSCvudTkVVLg/M0Gw+c8ohuI4Rfu0uUQs8OKP+uvXDq
 Ob2X6MzBjozSW08S+236oDEZbXYG3JzgvcQh6eknR8+En9Tm7WYTDczMzWuPCvdti2SA
 gLILhu6t9gkVSt/v0Ijr+epH/EVYzkcWutag0HstHL27UnYYMD/sptkByO6GLCPkSHPP
 LsTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxtBGaBgODJ+np51TJhLw+6ibXAj8ZxPS0rmIfQqDcYtqLqSaNmtaokzP125BzfJuPSa/i6gutNkLHfMSk0fTTxHdt4Q==
X-Gm-Message-State: AOJu0YxsJPocQBgdiZsW4+u7QTDOIrLJbY3CZtYU8s5kVyiY3C7rHvdZ
 pTLDzb9dvZux54/pi15FQh+SOneAF92wXn36PqyE2lggDi2oArA7n9yRparE7n8=
X-Google-Smtp-Source: AGHT+IH5wmvLfzsacPel1NbyckWAF7KS2miO8Kv29fe1K8fh1feLjO5I/xPS6pqJ9SkPaC3bKA98pQ==
X-Received: by 2002:a0c:cc08:0:b0:690:5f74:81a7 with SMTP id
 r8-20020a0ccc08000000b006905f7481a7mr7270100qvk.45.1709566023986; 
 Mon, 04 Mar 2024 07:27:03 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 pc19-20020a056214489300b006904a34830esm4905662qvb.72.2024.03.04.07.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:27:03 -0800 (PST)
Date: Mon, 4 Mar 2024 10:27:01 -0500
From: Tom Rini <trini@konsulko.com>
To: Stefan Bosch <stefan_b@posteo.net>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/2] common: board_f: change calculation of
 gd->mon_len to fix s5p4418 reloc
Message-ID: <20240304152701.GN1523872@bill-the-cat>
References: <20240126125056.16439-1-stefan_b@posteo.net>
 <20240126125056.16439-2-stefan_b@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Gg0e8vAqTC17qKNS"
Content-Disposition: inline
In-Reply-To: <20240126125056.16439-2-stefan_b@posteo.net>
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


--Gg0e8vAqTC17qKNS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 12:50:55PM +0000, Stefan Bosch wrote:

> ARCH_NEXELL: Change calculation of monitor length (gd->mon_len) to fix
> relocation at boards with s5p4418-SoC (ARCH_NEXELL). At s5p4418, _start
> is after the header (NSIH). Therefore the monitor length has to be
> calculated using __image_copy_start instead of _start in order the
> whole monitor code is relocated.
>=20
> Signed-off-by: Stefan Bosch <stefan_b@posteo.net>

Applied to u-boot/next, thanks!

--=20
Tom

--Gg0e8vAqTC17qKNS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6EUACgkQFHw5/5Y0
tywmugv/ZByayerQkit82egOccGr8EjIwYZ1yTxJV/oU2msth2zKqMs+WaI1/CM2
sE4sKfARxV5fL5HaLF7vspQvQnu2TUZv3VT4xf/QjxNYzGMzxRgfQofBns0c2QIV
KDy+8T18Ry0TMWW3jzPdJBVjtACBWt/enBWu3StLi8GXNpg/q7+05Z6MGT+OZ5YU
uNfLq9W3PJNZWcquuO84TkKyuvV/EaduVBKlyjJv6F+2BiA6cvpMZvCw6xhAemhi
5ma5z4fVEEa95u0vXlpddISTdgdCFQqM56fMI7g0PIqW0mPM4Q3dLe+ASmxnbTPU
YBQLo4JTx/XSBWNX4U/J1bt8VBxh2Y3MjnHF78sEk8ds94SwtJ3vZstcb6seqGaa
xZ+jYKlQ0RuNgzBWvp73+X+uluhfFIoSJTCIzCI3azJ+RvLNW4fHXBSjs9p5nLIi
zisDLaMQHzqvYRZth1fKPeeYblzvNROoaEpqAI1aHOhVgEaJL10J0HZeayg677XI
aAGg55sZ
=bk/B
-----END PGP SIGNATURE-----

--Gg0e8vAqTC17qKNS--
