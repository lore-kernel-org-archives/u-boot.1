Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747E0CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 19:53:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DFEE83849;
	Fri, 17 Oct 2025 21:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D3nT0uEj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ED9D83869; Fri, 17 Oct 2025 21:53:37 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FC4C83829
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 21:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-3c8f62cae4bso1483992fac.1
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 12:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760730813; x=1761335613; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WCySeUb3G4jdYwb3CTVDmZzla285yQr8WmHNRmHhNTc=;
 b=D3nT0uEjj2hW+ADwle4sj48Fc4XOexWBiCKFL7Ru9sR0A7YRYF2iCQdWlE3veGOLTt
 /CJD+GKPLBbUJcG/j0wGYZ9ht8LJdxEl8phYoOqROV+Z9rYf3EWpfLsFAliH1nWf6vi3
 y1lRnBvzZaO1b7znI4+fxkBSfl1/1sWmv8Zeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760730813; x=1761335613;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WCySeUb3G4jdYwb3CTVDmZzla285yQr8WmHNRmHhNTc=;
 b=rxC9KLVGFvdUeK5BiztVfe6maSDRVUo7S9PEy+d5L/Dad1NKzfvZqF+3B6OE38WTs9
 lGmzgxcUHBt8nrpNcULNOS2xIoo4FzBcwkYzDTQ4M4pCPGXZGrtXk9jQukdOrYxEhj6C
 Xp9TqEWG9VoxYXa7j1Qh30XClge3elPxrDFxfaXxez/HZzQfSJWrTUuIOArrymAz44ro
 v1jq/WqJkWNExnFbDKvUtHrJv6Vr6OQi7/pSMqbfbvzUa0+o+0oqZ+BNrTrKMwYzpLDb
 ZM4w0xFlu7ref+7tHhsY7mB4oefDiUsyLckpWTktjDI2uaUjfxTyjVJGPqJDeU6yqlWG
 DjUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYA2BSN6j87YnTt8vxOB/2MPQST3FvGsZ60alqNHNHo6AngXClnsaXzH+mu8hvtM8WIKxUTYo=@lists.denx.de
X-Gm-Message-State: AOJu0YzdFsnWqCT/svAjrI51WyBnmmepkSMmsmg+8ro0Sbforv3hQBqI
 iiphOdZ8sYzIujlX99uA7TLlkOGFrzy+joWIyJ0QyCA+LjUeMW6GoUWzryXa+PIH/Zo=
X-Gm-Gg: ASbGncsGF4+xlWdFWFspzFFqoTAjqrDH4MNhtC1BCxr1lONkUfFoSZsuS80Gv6pxEc5
 Yb30kHXz388PKazm8E9y2QqTesnrQX9Dm6vvTn0snqshGf03Vi4nuh77ZchCWbOsp1cP/nI9SJ2
 ZNgxv+i6buFZcLWUFGJDg9acm61bTgeLejVgMrTnFiPY5YU8N/5cUu5RVXLndMLRPO9+AmAaK+Y
 iYiGSr4B6hgtWXAs3R9me7eWxDr97WyhLvDdiPJo7oJd7QxnMNkyFi1WEud/lG6BVdU7X3pMKQi
 jgFAKDR/7nLV6W+T7WOc4UYJpqG3TmiEXsqd30JSAc0eWibH36BX4OO6flH7sCpWsU2e2TLzNNi
 oEZqipyKGHLzBATTEfV/M/tFrnu6OLj9WxKkpp17o/MdmTtIkDYAspje+hjQP3REpL/2h0MRxH/
 V9oOLfs9lmlkcwlm6/hoaz52yN8KlT2c2t+Su4Oo2/kSaX48mUBg==
X-Google-Smtp-Source: AGHT+IG8syhfo6TSO4DoHrb470OL2KhMuqeid+PebD47gSMFFEfHsMhXbJHAD3/HpZVyPAZmvSBNTw==
X-Received: by 2002:a05:687c:4b:20b0:3c9:8423:f616 with SMTP id
 586e51a60fabf-3c9842411eamr2416370fac.21.1760730813313; 
 Fri, 17 Oct 2025 12:53:33 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c9af40da32sm135539fac.22.2025.10.17.12.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 12:53:32 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:53:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <sean.anderson@seco.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] fs: semihosting: Use correct variable for error check
Message-ID: <20251017195330.GG6688@bill-the-cat>
References: <20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org>
 <2780374a-3a85-4969-96df-34e331a53c53@gmx.de>
 <7f274115-8fd1-46c3-866c-278569aca469@seco.com>
 <20251015162858.GA669557@bill-the-cat>
 <632340c9-6a6d-4f46-b731-e766f8517f7d@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QyfVJlWjVE0X1UXB"
Content-Disposition: inline
In-Reply-To: <632340c9-6a6d-4f46-b731-e766f8517f7d@seco.com>
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


--QyfVJlWjVE0X1UXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 01:08:20PM -0400, Sean Anderson wrote:
> On 10/15/25 12:28, Tom Rini wrote:
> > On Thu, Oct 02, 2025 at 10:36:07AM -0400, Sean Anderson wrote:
> >> On 10/2/25 05:52, Heinrich Schuchardt wrote:
> >> > On 10/2/25 11:39, Andrew Goodbody wrote:
> >> >> After calling a function that can return an error, the test to dete=
ct
> >> >> that error should use the return value not a different variable. Fi=
x it.
> >> >>
> >> >> This issue was found by Smatch.
> >> >>
> >> >=20
> >> > Fixes: f676b45151c3 ("fs: Add semihosting filesystem")
> >> >=20
> >> >> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> >> >> ---
> >> >>   fs/semihostingfs.c | 2 +-
> >> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
> >> >> index 77e39ca407e4d240a1fd573497c5b6b908816454..9d7a136b9ba9b035545=
b34b31df58e2d65de7db9 100644
> >> >> --- a/fs/semihostingfs.c
> >> >> +++ b/fs/semihostingfs.c
> >> >> @@ -35,7 +35,7 @@ static int smh_fs_read_at(const char *filename, l=
off_t pos, void *buffer,
> >> >>       }
> >> >>       if (!maxsize) {
> >> >>           size =3D smh_flen(fd);
> >> >> -        if (ret < 0) {
> >> >> +        if (size < 0) {
> >> >=20
> >> > The ARM specification (https://cas5-0-urlprotect.trendmicro.com:443/=
wis/clicktime/v1/query?url=3Dhttps%3a%2f%2fdeveloper.arm.com%2fdocumentatio=
n%2fdui0203%2fj%2fsemihosting%2fsemihosting%2doperations%2fsys%2dflen%2d%2d=
0x0c%2d&umid=3Df17ab8fc-2d9d-4cce-91e2-e7e66f117613&rct=3D1759398729&auth=
=3Dd807158c60b7d2502abde8a2fc01f40662980862-e0799d2d4d61f93cae033d54733c8fa=
50ef84918) has:
> >> >=20
> >> > SYS_FLEN (0x0C)
> >> >=20
> >> > Returns the length of a specified file.
> >> > On exit, R0 contains:
> >> >     the current length of the file object, if the call is successful
> >> >     -1 if an error occurs.
> >> >=20
> >> > Please, consider that the file length on 32bit systems may exceed 2^=
31 You must not consider this as an error.
> >> >=20
> >> > %s/if (size < 0)/if (size =3D=3D -1L)/
> >>=20
> >> This cannot occur because on a 32-bit system SYS_FLEN only returns
> >> 32-bits of information. The host must detect files that exceed 2 GiB in
> >> size and return -1 (simulating EOVERFLOW).
> >=20
> > OK, but this is for 64-bit systems too, isn't it?
> >=20
>=20
> Sorry, I worded that poorly. What I mean is that the spec says
>=20
> | On exit, R0 contains:
> |     the current length of the file object, if the call is successful
> |     -1 if an error occurs.
>=20
> which implies that R0 is a signed integer (otherwise they would have
> specified 0xffffffff or 0xffffffffffffffff as the error value). So
> negative values (other than -1) indicate a negative file size (or are
> unspecified).
>=20
> However, both OpenOCD and QEMU just take the return from stat(2) and
> copy it into R0. With a 32-bit host there is no problem since stat(2)
> will itself fail for files over 2 GiB. With a 32-bit target, this
> produces erroneous values for files larger than 4 GiB. Files sizes
> between 2 and 4 GiB could be recovered, but I don't think we should do
> that. On a 64-bit target, there is again no ambiguity (at least until 8
> EiB file sizes).
>=20
> I don't think we should try to interpret negative values because it's
> ambiguous in the spec, the hosts known to return such values do so
> because of flaws in their implementation, and large files themselves
> have dubious merit.

Thanks for explaining more, it helps.

--=20
Tom

--QyfVJlWjVE0X1UXB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPKeuQAKCRAr4qD1Cr/k
CrOAAP9ZmyRlHNRGyRB6Wojm0q9hoA4Qhm3+U7RPbriBabq4LwD/aC+OvX1IFwBH
IGalH6EVmLTWmDIge1wzMOhgMMhFMAA=
=eDO1
-----END PGP SIGNATURE-----

--QyfVJlWjVE0X1UXB--
