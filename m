Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B253ACA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 16:44:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C0518366F;
	Fri, 29 Aug 2025 18:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nIlwM2wJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2069083675; Fri, 29 Aug 2025 18:44:01 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E661483542
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 18:43:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-437d6f776a4so13163b6e.3
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 09:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756485837; x=1757090637; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BUpaqFSmchTe2S1shtFfUmINpZpVTfmO6WqGFIpLET4=;
 b=nIlwM2wJIQBS4Y1ucroTapNSJKufLbDLoDnLjxwUrSqBEf4FVwNnG+NOAWx2UWpGqx
 OQr6dzXA3XffuOAiA3KYtsO89ZxzGX682FUu96GJk19Fpk2osr1p5RgCNVlMehaV+q7r
 wHqICm69FXZdn6VjZzpevNAhadRv2XG/hpqDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756485837; x=1757090637;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BUpaqFSmchTe2S1shtFfUmINpZpVTfmO6WqGFIpLET4=;
 b=G06/apj9jZ0g49PO/sEMT2x+nBKRfinLmgnk2OdvaQHq4UOh2WkRSSoSYLb7cvIVwI
 xw+cCP25ZZfJX0E9zZQe1MMC2U2vsxmzuHrL4f6yrXoAPzdjLbhYEdNPDSbfQ6SXM5RP
 /w7sJwAjvPD+i1OuciKj2kMocMTMbsBO88s3ETUj6Z1dNYGiJW7uJJOx4A4SiHMt9CRZ
 TNT3WGamE4JCDfp/T+fY3VoK3HivWXeKTaPNdBNLVsK0Kte5S6xuSakzyWCjvNZPJ/Uo
 p/EHMQNjCQMGWD8EDprOcTKU+bbrY+IxWf/mJxbT9Ujd30iw0zUVGmjR0ALf7cjACQiD
 Gi8g==
X-Gm-Message-State: AOJu0YzCCeE3YwNXRRZoH8n6EsUN3gGbLL2+bqi67Zm5580j8gzkdSfY
 7V+V3Fe+9rflrhwxshHth1GZlNwdfZY/9nJxQYPO6PIx9PXy0DrPA9oPfz+ruwfTY6E=
X-Gm-Gg: ASbGncvnZ26PUrNuR06awLIqwyjXu8v+JUnB66R5MpaOz8VnS8NoO5y5gbvHq+dptYB
 NWxuoGlGg95xvlfCf+LxxmLcaJTJuZ5J55c3kMflaGebBS6IfAXf06k/Jmj+jTlB9onojmfAPp1
 4Nnd6Q9KvxRXdd+Ylem2yxIRk4Rn8dCHRuCTgGDnyHcm/V50aDPyRSK2j+g9Fi2A3YLegcxNGFB
 JFDluo2wZdjGKaZg7s8eSFhOBrgGl3oxQ0EynZq+sjGD5UpjFlbOZDiMk/FRUTaZcEC7BC4Ozrs
 mEdsjLXwtRc7EhlwkajTlQwg+YycdStw1UNUh6QWWnYis9X/Ka6X8rjjCBzAf3OV1HdTMxw382r
 ixZsNeiR4umwqtA8qDXKYv6QhOsWCjX9CetJ/4M/lCoDoFqZd3x0uAk1RNMVchztyM+4=
X-Google-Smtp-Source: AGHT+IGVAko7hoJ14KPj5JCle5uMmjwopSYfVsfHe9BR5rFP4WObzlFYYKsxZjgKUvLAx+btkz4mgg==
X-Received: by 2002:a05:6808:164c:b0:437:dd6e:6844 with SMTP id
 5614622812f47-437dd6e6b9emr3485742b6e.38.1756485837522; 
 Fri, 29 Aug 2025 09:43:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-315afbe3b41sm1468513fac.5.2025.08.29.09.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 09:43:56 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:43:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: tools: patman cannot find aiohttp module
Message-ID: <20250829164354.GX124814@bill-the-cat>
References: <CAJaLiFwxjWPg+SQ4VVO7Oay4OX-WcCTmNa7FPHCYW6JLQmd9Uw@mail.gmail.com>
 <20250825190224.GU124814@bill-the-cat>
 <CAJaLiFwO-d7ejv3POg6d+kxqwbZxcrHVfRRbtBg-=63mQjPdfg@mail.gmail.com>
 <CAJaLiFwE+_FN=okhS4LcRaCeAi=Gz5p_2+M38R4w=+yYDAvmmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NWuc1dn5DXgK335H"
Content-Disposition: inline
In-Reply-To: <CAJaLiFwE+_FN=okhS4LcRaCeAi=Gz5p_2+M38R4w=+yYDAvmmA@mail.gmail.com>
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


--NWuc1dn5DXgK335H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 09:30:34AM -0700, Tony Dinh wrote:
> Hi Tom,
>=20
> On Mon, Aug 25, 2025 at 12:32=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wr=
ote:
> >
> > On Mon, Aug 25, 2025 at 12:02=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > On Mon, Aug 25, 2025 at 11:49:35AM -0700, Tony Dinh wrote:
> > >
> > > > Hi Tom,
> > > >
> > > > I've just done a git pull on the master branch. And then ran patman
> > > > and got this error.
> > > >
> > > > ./tools/patman/patman  -c1 -s2 send -n
> > > > Traceback (most recent call last):
> > > >   File "/usr/src/u-boot-marvell/./tools/patman/patman", line 21, in=
 <module>
> > > >     from patman import control
> > > >   File "/usr/src/u-boot-marvell/tools/patman/../patman/control.py",
> > > > line 24, in <module>
> > > >     from patman import cseries
> > > >   File "/usr/src/u-boot-marvell/tools/patman/../patman/cseries.py",
> > > > line 19, in <module>
> > > >     from patman import cser_helper
> > > >   File "/usr/src/u-boot-marvell/tools/patman/../patman/cser_helper.=
py",
> > > > line 18, in <module>
> > > >     import aiohttp
> > > > ModuleNotFoundError: No module named 'aiohttp'
> > > >
> > > > I'm on Debian 12.11 and have Python 3.11.2. Is there something I mi=
ght
> > > > be missing?
> > >
> > > Ideally you should be using a virtualenv or whatever is recommended on
> > > Debian 12 and then pip (or pipx?) install -r
> > > tools/patman/requirements.txt
> >
> > Strange! I did not have to do anything extra like that before. I
> > always thought u-boot did that automatically. Also, I've just tested
> > it on u-boot-2025.07-rc5 on another u-boot git clone (on the same
> > system), and patman ran without this problem.
> >
> > I'll dig some more, but if you have any idea please let me know.
> >
>=20
> Debian 12.11 (bookworm) has quite a bit of version mismatches between
> aiohttp, pygit2 and their dependencies in u-boot. It's a struggle, ie.
> impossible, to try to resolve. So I had to upgrade to Debian 13.0
> (trixie) and used the versions provided by this distro version.

Right. This, sadly IMHO, is why anything python related needs to be done
in a virtual environment. That seems to really be a language best
practice, even.

--=20
Tom

--NWuc1dn5DXgK335H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLHYxwAKCRAr4qD1Cr/k
CiutAP9xk0s1oKIrUzz0ZulCSgUcr1Yq7YDDPcDWGhXBL73ovAEA5Gw/q6fYJQBX
zl6xQh3wd42boZXFgJv3RkYnOtX6bg0=
=UYDu
-----END PGP SIGNATURE-----

--NWuc1dn5DXgK335H--
