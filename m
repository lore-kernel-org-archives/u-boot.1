Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF56C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 15:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EF6F84143;
	Fri, 11 Apr 2025 17:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CmuY8+CA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 853AF84148; Fri, 11 Apr 2025 17:05:57 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D81F840D5
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 17:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-601b6146b9cso1190398eaf.0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 08:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744383953; x=1744988753; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5KsT5rHlGdGm+xJYnxiLoreCROxism0Ow7JgtMybzb4=;
 b=CmuY8+CALSmUkvh+svtjiJKZPzg44Szz1IpTYgWJ4EW6OUmAL+uGVjTr5KOvZl4YOY
 bXL/EcQtdbzmAP/wkJeETyco5Z6jyRB3obivEDGRycc4oopmaxNE4sB3oaQXNaRG2/Jr
 3S1WWKjkgEpzrRTCjmluHyTmrkc4F6NS1mQg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744383953; x=1744988753;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5KsT5rHlGdGm+xJYnxiLoreCROxism0Ow7JgtMybzb4=;
 b=Lg9GC5HVsVxGU5yMRSSO+rEffHt79dGtaJK9qgiOmJ6zLUGBjgb1hDeM1CPUE38lmq
 3g3E+yARf8dV/pbzpX6KbkAw6DN7H5Zbfnq8U46SacwOP+RtKNFjrzJLs2pXFsWfV7mQ
 64XBfQ4tr/8LuhjxHCxhMGGfRZJ/4i8mGNLkZhdXpDXb03bEed9i3MO0uXiDGXNdi494
 9g6BMOtSboO1jXlEI2gOtSD9fOxZ88XSCZ4cJRx2e9P4cuIJy7vztwcHyHhExnxRNtRE
 zJ5vk8C1roXW5166433KcnJb/ZKsaO0clVYurNqciYFVGwR4cEkSCT8EMiYKCIzq5Ju7
 p/PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr64VmZDc6v5BVnUmcKSB2qV6gd93yVpYUr2CqzVflvudM39ZTqNyFTfoX3EumwI6jjq4Ly+8=@lists.denx.de
X-Gm-Message-State: AOJu0YyVuQBveTk+uMgEwdg/n7b2VyohFGhrK8A/ZmP4/mkIBbjbJUpo
 wzCUHhqSSvYgDyx+/Z3ddeVofEa7xjEt5ZiWPI3NTbW7pY6coPXvXi938yh3icRjQhQCRzr88TQ
 zLfw=
X-Gm-Gg: ASbGncv1WhZYhM9K/6FTaBbUaysmsF9sanZNDk7FnMcBsLNXu79f7gY3WeNR7+MiP9n
 z+KHHqEgozQLpZak24zVCnAxcUiGH/prwcJUM+HzTdGVPY1Nl9O0GMUtN23QHegLIpb5Wu0G+n5
 27yoVHuVLQs8KwtcS/tZujz+9S7Zo+rOZ3K1Nrh2S5ChJkl7hn2pFdXHGPy/wUaeRsKOQJIXmNn
 bkqEiMbEbMq7RI10sqRkh9AXvfulEfgqtasM7x87UpnO1+HJaoKLCBDTyH4vdljisAFSfEbYl0c
 qBHWydAi9qIeeELn8zIx9ImI42FAzPRO//JWLMSlkfKIBNvNO+SN62D+hBIuI8hgcjwPVPw5JrZ
 4rw==
X-Google-Smtp-Source: AGHT+IFxig9dP676XSrZJBcrBcyRGdyaZOgCkT+X45SK1qmVEIxN/ZrFEkbhpk9Ozow0fSAS1lhnog==
X-Received: by 2002:a05:6871:6086:b0:2c2:b18c:9be9 with SMTP id
 586e51a60fabf-2d0d5c3c5c7mr1733193fac.3.1744383953312; 
 Fri, 11 Apr 2025 08:05:53 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73e67050sm965447a34.56.2025.04.11.08.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 08:05:52 -0700 (PDT)
Date: Fri, 11 Apr 2025 09:05:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Joel Stanley <joel@jms.id.au>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 open list <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: Re: Gitlab runner timeout on evb-ast2600 ?
Message-ID: <20250411150550.GR5495@bill-the-cat>
References: <7a737a5e-c804-4d46-be33-28aed9c4a113@linaro.org>
 <CACPK8XeCDU+-6+zzJe4=uj=Lduh8nGx6pNr=yWCsM+k-rov2UQ@mail.gmail.com>
 <20250410231444.GK5495@bill-the-cat>
 <89f2eac8-4e76-42a6-b56e-fc62abdaffe9@kaod.org>
 <CACPK8Xff4GD=CzJ+_fbCWniut7TVNHh744At8w3JSYrcsv=oOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="isKZvqH788sxrYhx"
Content-Disposition: inline
In-Reply-To: <CACPK8Xff4GD=CzJ+_fbCWniut7TVNHh744At8w3JSYrcsv=oOQ@mail.gmail.com>
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


--isKZvqH788sxrYhx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 05:26:49PM +0930, Joel Stanley wrote:
> On Fri, 11 Apr 2025 at 16:54, C=E9dric Le Goater <clg@kaod.org> wrote:
> >
> > Hi,
> >
> > On 4/11/25 01:14, Tom Rini wrote:
> > > On Fri, Apr 11, 2025 at 08:07:15AM +0930, Joel Stanley wrote:
> > >> On Mon, 7 Apr 2025 at 23:25, Eugen Hristev <eugen.hristev@linaro.org=
> wrote:
> > >>>
> > >>> Hi everyone,
> > >>>
> > >>> I keep getting an error on running the CI loop on -next on my tree :
> > >>>
> > >>> https://source.denx.de/u-boot/custodians/u-boot-at91/-/jobs/1090517
> > >>
> > >> Thanks for the report.
> > >>
> > >>>
> > >>> ! _pytest.outcomes.Exit: Lab timeout: Marking connection bad - no o=
ther
> > >>> tests will run !
> > >>>
> > >>> Any clue ? It's been like this for few days. It doesn't look like a
> > >>> faulty patch.
> > >>
> > >> I can't see that link you sent me, it 403s.
> > >>
> > >> Do you have any other traces or information to share?
> > >
> > > It's been intermittent recently. I was able to put qemu + gdb together
> > > and see it's one of the early initcalls that fails and hang()s but
> > > didn't see why. You should be able to use commit 1f0281294d8b ("Merge
> > > patch series "Annotate switch/case fallthrough cases"") as a starting
> > > point of failure.
> > >
> >
> > Do you have logs ?
> >
> > Things look ok from the QEMU side (latest 10.0.0-rc and 9.1) :
>=20
> I brefily tried to run the steps from CI locally, but couldn't work
> out how to get the flash image built. Instead I used the instructions
> from 154cffa16a7b6647e180ed6cef55342b39580aff.

It's a bit of abstractions, sorry. It's this:
https://source.denx.de/u-boot/u-boot-test-hooks/-/blob/master/bin/flash.qem=
u_gen_padded_image?ref_type=3Dheads
with variables filled from:
https://source.denx.de/u-boot/u-boot-test-hooks/-/blob/master/bin/travis-ci=
/conf.evb-ast2600_qemu?ref_type=3Dheads

> Testing master with Debian's qemu 9.2.2:
>=20
> makearm evb-ast2600_defconfig
> make u-boot-with-spl.bin
> truncate -s 64M u-boot-with-spl.bin
> qemu-system-arm -nographic -M ast2600-evb \
>         -drive file=3Du-boot-with-spl.bin,if=3Dmtd,format=3Draw
>=20
>=20
> U-Boot SPL 2025.04-00921-gcb7555e93075 (Apr 11 2025 - 17:05:20 +0930)
> Trying to boot from RAM
> ## Checking hash(es) for config conf-1 ... OK
> ## Checking hash(es) for Image firmware-1 ... crc32+ OK
> ## Checking hash(es) for Image fdt-1 ... crc32+ OK
>=20
>=20
> U-Boot 2025.04-00921-gcb7555e93075 (Apr 11 2025 - 17:05:20 +0930)

Just please note I don't know if this rev of U-Boot was a failing one,
or not. That's part of the challenge here is seemingly arbitrary changes
lead to this platform passing/failing.

--=20
Tom

--isKZvqH788sxrYhx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf5L84ACgkQFHw5/5Y0
tyzgdQv+Lcn9LwebUqBDALeA3jxpkGosRF9JS7dXsnCay4XXy8WzTh3opuhCG1Ja
AzSixAwm3KVIhnCtUGwYcwSd8p4Kf1W156Mm8AntFsauZMkut+D4RN5rGUhBNnfE
ih9aVoxA0jPs57JGDyKEwGevJSJLreUa6oj5dBezqeYadFLcgDsUUUk9ouNsKGz2
2hWcFrXIlcfO7RQCviM0NuQv44kXHWrb3o4ZOZ9MlekPKOQlDSdjZzDiYBKApacL
24v077x139yUZfJ/M+Ysh1cxOjjWp/KEY74fpS0UI49a8rLb/P8zFdqT7wpHpHpn
14mKEeFijRx3A+/wQLmn5BIDxhklndKSA+SwInYJm2LiEbEncLgvWjSSgxztz7zI
iUDKBnkIDJjd8E0bGXTJjlWCVIW+CEBB51J/hxcSAkj45X6bq/JVwpv/jZ+cDeBp
mgYrdSAwjZ0N+tLgcJoCfkOKmRTh0EWUO4ZBAbnevgj372TJEkrZgcmA3qIh4cu7
HWIc4l4Y
=YEhr
-----END PGP SIGNATURE-----

--isKZvqH788sxrYhx--
