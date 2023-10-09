Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7C3E95A91
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 14:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B1B986C1E;
	Mon,  9 Oct 2023 16:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XkzZOyJ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51A6F82BBF; Mon,  9 Oct 2023 16:36:28 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D03086D78
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 16:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d81f35511e6so3920227276.0
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 07:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696862184; x=1697466984; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SdUhRZYzeBdiROmdazGzLwBtrBIDLJF+Cdb5uTvHjno=;
 b=XkzZOyJ/KWxdeqYI+LOt4FVfzNlsgDhAtpT515i6q/QpjNBT0TOsumIFqUHnRDFST4
 qwXhi4PZMiveBuj+paS6rJHZGBEm8oqsQnLI7fVcGuzl5ybf+o7rhZzQ0+RiIkZNvgQ/
 zf9C0Xx7ZmGg2en2MEHkozbwFEwvEdFufDN6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696862184; x=1697466984;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SdUhRZYzeBdiROmdazGzLwBtrBIDLJF+Cdb5uTvHjno=;
 b=uZjaZof7dck0Twz9F7infFHQCiSxEJADz1SkSOEK9FCv4Co8wpbV0ucn0IKBUfpu2A
 8bn+qGkOm+osBXYkYx/aaFJted8U+3kMzovwc2zmvM/ppcCfdsA8KX5FZ842C8Mx6TYJ
 zz24/H5AzBXjTqyT8hR/37WqO3KeMJuk9qaNRX0MUR1lRxzTyiRotVofBVMrw9Lb2sej
 g3QwobVUW6l2B1sn8imAvjRhQ+vj27FKRyMEsHgj/c73ksAB/3+OCLtGnR2btEaANqL9
 EDHb4gBC7GmcHRStwYGCClEHxboah4UH/ZFmA2XjLaECjGmz1riVbeH6EWJRlAO5w025
 F3oQ==
X-Gm-Message-State: AOJu0Yy6wyo1PX0fIT+l9ybNlI/bixFTbzxlgDd+UJ+1m89bUtYMwESz
 c+I53ZpLu/HCwlMk+JsUk37wfGw15J4KAKpB1+JeLg==
X-Google-Smtp-Source: AGHT+IHzL29M0p3N0aWK5zSTT7yGtAaAXBdZq1L8a4raxbZ4BupLGHDlaNbRt7x/Hqhap9LKp9oK1Q==
X-Received: by 2002:a25:a2c6:0:b0:d81:ce53:11e7 with SMTP id
 c6-20020a25a2c6000000b00d81ce5311e7mr9510134ybn.8.1696862183973; 
 Mon, 09 Oct 2023 07:36:23 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-fae2-bb7a-3833-e7d0.res6.spectrum.com.
 [2603:6081:7b00:6400:fae2:bb7a:3833:e7d0])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a056902055200b00d818ced8939sm3061859ybs.1.2023.10.09.07.36.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 07:36:23 -0700 (PDT)
Date: Mon, 9 Oct 2023 10:36:21 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 04/27] bootstd: Correct dependencies on CMDLINE
Message-ID: <20231009143621.GO2227687@bill-the-cat>
References: <20231007231255.277623-1-sjg@chromium.org>
 <20231007231255.277623-5-sjg@chromium.org>
 <20231007233219.GI2227687@bill-the-cat>
 <CAPnjgZ37DN50orkHmNFs7w4yA+npw_7W0-6iEU=wwtOZ60U8rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XymYl3Pnnjg2GPLu"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ37DN50orkHmNFs7w4yA+npw_7W0-6iEU=wwtOZ60U8rg@mail.gmail.com>
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


--XymYl3Pnnjg2GPLu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2023 at 05:45:17PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 7 Oct 2023 at 17:32, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Oct 07, 2023 at 05:12:23PM -0600, Simon Glass wrote:
> >
> > > With recent changes in boot/Kconfig it is no-longer possible to disab=
le
> > > CMDLINE. It results in various link errors because some options which
> > > require CMDLINE are enabled regardless of whether it is available.
> >
> > How "recent" is this problem?
>=20
> Over the last few years, I think. It was definitely in better shape
> 3-4 years ago.

OK, that makes a little more sense.  But still, this is the wrong
approach I think.  I've got a little more specific feedback against v2,
but I want to see things get unwound from CMDLINE that aren't
specifically commands as they're things those other use cases you've
described will also need to enable.

--=20
Tom

--XymYl3Pnnjg2GPLu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUkD+UACgkQFHw5/5Y0
tywiPQv+JRZxxyVqQO4oPuyaeOz59wzqTvHeKEsMI8/J43z7Xn4IPtBLQwt4LtdO
hXDCdyb6uhy3mfWHj0C0KNPhAMGZsAC2XPXm/Rj3BMnKMki/5taUVzpaeJOt2B5O
JcqZ4tuMtp7P8a/wRiOOD3OMz7TjDsy7es/3HIF0znRcQHeEZv28Y2NL4OzZpqAq
sQWCneGWR5nFEJCuIGFGcnIRS1vgo//8rdIsB7UvAMssSQ7mXP9wcFU21FNlTL9B
fm2a2rEzMXcYYCuAAWtPggWwTX9WgQJk5i2pGHau+p+ZoYWnFoCodNM/ld16CiTG
pelgoD/+Qovcj2VWDXCG+I0Pwbj/q/N0yE2Monu0ANjVrCTTlFwSdjR/fFYActNr
77riqXucmIgSIkN9WOV5lYfuVaXK5gMw0cmBXnxul9Rl2DWQg3mHS8L40RLfuYZv
ndIr9PQxq6YDj/764WK29GfR0QEAKaVYDISIDACF6G8ScS8Fr1FCR7rHG/bTvkp7
46ykz9ai
=QHGC
-----END PGP SIGNATURE-----

--XymYl3Pnnjg2GPLu--
