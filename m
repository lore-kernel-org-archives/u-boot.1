Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB28BFD3772
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 16:15:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 588328407D;
	Wed, 25 Feb 2026 16:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L0qzgWc8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39D158407E; Wed, 25 Feb 2026 16:53:02 +0100 (CET)
Received: from mail-ot1-x344.google.com (unknown [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AACA283F36
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 16:51:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7d513bc15c7so5288140a34.1
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 07:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772034641; x=1772639441; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+lYOgWo2tLfrW88RJRJjtH1Z/9sDf/+Zu9dhfaZoii4=;
 b=L0qzgWc863zkbrDwKOykRn8Rgtuf3dvV8GLw+hW55rKuuIlZnKzjDoMRM7enQSkmv+
 6U+BscAUzlqtoGUquM8BfcNCuo67Q7mIr8Ae6xwbZZzWWfaJW4V+9HM/DGQ/pWMX4jsh
 JNioY+MA4vetXMQ5YyMkKpCNW4vKVapOFbAXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772034641; x=1772639441;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+lYOgWo2tLfrW88RJRJjtH1Z/9sDf/+Zu9dhfaZoii4=;
 b=dQeL0WyCCRyLgmaoHYPwvPMum4gULXTtWMSeE/aNpDaxWzxCMaSPPdvRpu44Q0R+Ur
 RGCQ0GzxK+CytXhee0yD+QWkI3Al7KN7Rad2ydp7Z69t+9bzucfV0xk3Ter96BbmMQ3r
 1fjyZ4cQ4RPD7rGtqKPAnpzCFXjtLNwN0qOq3cFGVZ2JXE7vojdzcE1yFfkbLFLqFt73
 /cSM3IeUN1WxrIt70LiLTw9/kyLA2+ljF4I5cOm+h6pW7BM10DzcSP/84QRSc49PrinX
 nu6xkncEtLwQ6LbZe47qP/eSnNDg4UCKScL34EYvSBE4o7RwSaNX46mOgnHSXNik3r2s
 PhBA==
X-Gm-Message-State: AOJu0Yz/erxePZgUeVqjBoKNQfDN84THjTR1goKzrzxESZvBFR1rA19f
 VBxlAyu92a2ZhZ7wzwXEwCJ0mqg04C62QU+qpJUneHJn5XM6QNluh8Zs1Y5wyKqUKg1XoS914BH
 AKEH7sAM=
X-Gm-Gg: ATEYQzzILcAPt92jr2CxT1035gC3Tv1Z2kbqMksb9GLSK0uuqWUUaqT0mIDdeT8CDlf
 g70OIjFR1UYpphgji1Nu3g8lD/78QIIZc1KCtv0yC/YnTrcBSyvvZFU0VE7XQU8M+AzH9c9t8K8
 dJPYpcphazE+bW0Nd2VuY7TODjYMJT873U6CSkG3zDLrGuOrNGqF5ffOJ+t/HD76njZZEeQMtDd
 zRzYu9ynEQn5Trm6wBrZM6SSXansqzdlUQyvYPidPcLshQr/kMW2ryOTSmQOreP43d+wEzl3HMy
 bJSufFJ/tupL38XGnUXqBXtoCcp71iPiA7fzR8mi71Nyhbb0KjHCj2tPbxEBIQpssh+9v+w9luv
 pZ9AODalV2cT4EVwnZ6rwK2wcK5lcVanUfTLha+/tPq7U7RQ36MN78NlFobbh4SMsBloohsCIBi
 PjGhJXFw4HGeXOsbrVhRDVwBoKOT78TXX/HdQ0MU+VydRojL/yPiWE6OyvsFvYx4KTJ+lSO/pc0
 D89y1nqPfNKvZNsoiBgWfdNVWJTT+X4XDEAYFhrvI6g9pVxFqo=
X-Received: by 2002:a05:6830:2a0c:b0:7d1:4f21:ff79 with SMTP id
 46e09a7af769-7d52bf2172amr9202134a34.22.1772034641115; 
 Wed, 25 Feb 2026 07:50:41 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d038b5bsm12625018a34.14.2026.02.25.07.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 07:50:40 -0800 (PST)
Date: Wed, 25 Feb 2026 09:50:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] tools/atmelimage: add const qualifier to fix compiler
 warning
Message-ID: <20260225155038.GL1593142@bill-the-cat>
References: <b040fc218c68db39b51c9f8d7b180ddfc332d4e6.1772031799.git.daniel@makrotopia.org>
 <20260225150742.GH1593142@bill-the-cat>
 <aZ8R4NfCnbDvdGX2@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="90wqKmKi5Uj7QfMe"
Content-Disposition: inline
In-Reply-To: <aZ8R4NfCnbDvdGX2@makrotopia.org>
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


--90wqKmKi5Uj7QfMe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 03:14:40PM +0000, Daniel Golle wrote:
> On Wed, Feb 25, 2026 at 09:07:42AM -0600, Tom Rini wrote:
> > On Wed, Feb 25, 2026 at 03:03:57PM +0000, Daniel Golle wrote:
> >=20
> > > tools/atmelimage.c: In function =E2=80=98atmel_find_pmecc_parameter_i=
n_token=E2=80=99:
> > > tools/atmelimage.c:64:31: error: assignment discards =E2=80=98const=
=E2=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifier=
s]
> > > 64 |                         param =3D strstr(token, "=3D");
> > >    |                               ^
> > > cc1: all warnings being treated as errors
> > >=20
> > > Add 'const' qualifier to variable 'param' to prevent build failing
> > > due to -Werror.
> > >=20
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > ---
> > >  tools/atmelimage.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/tools/atmelimage.c b/tools/atmelimage.c
> > > index 6a2d9d8feab..770f7a0de4e 100644
> > > --- a/tools/atmelimage.c
> > > +++ b/tools/atmelimage.c
> > > @@ -55,7 +55,7 @@ static const char * const configs[] =3D {
> > >  static int atmel_find_pmecc_parameter_in_token(const char *token)
> > >  {
> > >  	size_t pos;
> > > -	char *param;
> > > +	const char *param;
> > > =20
> > >  	debug("token: '%s'\n", token);
> > > =20
> >=20
> > How / where are you triggering this problem? This is part of mkimage and
> > built on CI every time (and on macOS and Windows, in Azure). Thanks!
>=20
> I'm using archlinux on my workstation which got a fairly
> recent version of GCC which is used to build the host tools:
> gcc (GCC) 15.2.1 20260209

Ah. We dont' support 15.x yet due to:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D121588

But a v2 where you note that newer compilers find this would be good and
get us ahead of problems once a newer gcc comes out with the fix.

> When trying to use the u-boot-size-test.sh scripts you had asked me for
> it failed because of passing the '-E' parameter to buildman.
>=20
> Also 'dtc' fails building for the same reason and that can be fixed by
> picking commit dfe057874b34c ("scripts/dtc: Update to upstream versionv
> 1.7.2-62-ga26ef6400bd8") from Linux.
> However, that has far-reaching consequences such as the
> -Wno-graph_child_address parameter no longer existing, and also dtc
> became more strict and issues new warnings for many of the dts files in
> U-Boot, so then the build failed because of that...

Good to know for the next time we sync up, which should be soon to avoid
getting super out of date again.

--=20
Tom

--90wqKmKi5Uj7QfMe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ8aTgAKCRAr4qD1Cr/k
Cgk4AP9CoIpucOvBGmFw3viqwTZVHVrc9v4gMpfV0qVMyO4kAwEAn1wbHioBz0fW
ldj8wUyF+lBiO3tS3jxMQqpG6wSHGgA=
=cTbV
-----END PGP SIGNATURE-----

--90wqKmKi5Uj7QfMe--
