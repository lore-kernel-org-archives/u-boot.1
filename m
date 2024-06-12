Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04830C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 17:07:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67D1688854;
	Wed, 12 Jun 2024 19:07:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ABWg/62a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 659E58880E; Wed, 12 Jun 2024 19:07:49 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B71F88702
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 19:07:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6f8ffe1b65dso48406a34.0
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 10:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718212066; x=1718816866; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XfH+JjQYS0JqsacgzjyO2moGkqewvs34B5BN5gcZ4Fw=;
 b=ABWg/62a6SHwLGTXAdWiJ+PESRDvT4GzBxnxvaGohVcC8CPnNYnity0ca9NPgO9gob
 s1Xs3/CeO+1yJP6KO4RsUhPml7Nb/DDwNq0Dr2UCHPRnhvYFFPPYTqMWTN65gWCO47N7
 P2irmVDwk0UFiFwmPDeBkqz0+9FPOvS2lZif0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718212066; x=1718816866;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XfH+JjQYS0JqsacgzjyO2moGkqewvs34B5BN5gcZ4Fw=;
 b=hlDkD7pNmyMIaKFFSJgtOGJE4juqbjgCpihUJvvtw1lW7wnaqb44iYF/c0tag6iGIC
 ctrIZ9pzNHWENTxJqIFVn7WJGy4J3RjXaD26DNXK7iAy0D8V0iRcQdXsGswGC5+qhB3T
 FOhULTeKxEOSaBPlsMd6wrpVAQWdo7odStLIObqjxBM/DrPcF/ygWXtbcM9/8VoKVYdb
 B9JvhHnG6Comn3dAIy0kU2MGwvks75ZXJQAK+z0PKO84wsx2+/Jg6vKt55cnwQROwiqM
 G085Gx1G527mbStEwKq388UQDI2htnPYajwC3dQMmML73i7/MU+vswuJQCbn+j26UGcZ
 lOwA==
X-Gm-Message-State: AOJu0YwFWSIkkmNuhdcK2e53Q7SN2r2c22BO4PpOdW4orfbsg9ixuBXK
 IWcRkK4tbI9jQJAAYe7gtTlddIW0019ihGYq8XFSRrk+Z2VzheOWE9RORGb8pkg=
X-Google-Smtp-Source: AGHT+IGuZSdvA1MUrWhjaA3+XafMJ/uSLwRLXnvcV5B1ezg5qpihKYDrO8LuPr2AW/UDPkBWD+bk7g==
X-Received: by 2002:a9d:4e90:0:b0:6f9:4824:8d66 with SMTP id
 46e09a7af769-6fad978b351mr153468a34.6.1718212065831; 
 Wed, 12 Jun 2024 10:07:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f992005002sm1570160a34.42.2024.06.12.10.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 10:07:45 -0700 (PDT)
Date: Wed, 12 Jun 2024 11:07:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aaron Williams <awilliams@marvell.com>
Subject: Re: [PATCH 14/20] CI: GitLab: Split build_world tasks
Message-ID: <20240612170742.GE68077@bill-the-cat>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
 <20240611-docker-image-v1-14-51472eb70357@flygoat.com>
 <20240612160104.GU68077@bill-the-cat>
 <894fd87b-ece7-48b6-bf20-2c6621e7224e@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PN5sZ4B3K8VUyomg"
Content-Disposition: inline
In-Reply-To: <894fd87b-ece7-48b6-bf20-2c6621e7224e@app.fastmail.com>
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


--PN5sZ4B3K8VUyomg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 05:14:46PM +0100, Jiaxun Yang wrote:
>=20
>=20
> =E5=9C=A82024=E5=B9=B46=E6=9C=8812=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=
=E5=8D=885:01=EF=BC=8CTom Rini=E5=86=99=E9=81=93=EF=BC=9A
> > On Tue, Jun 11, 2024 at 10:04:13PM +0100, Jiaxun Yang wrote:
> >
> >> Current build_world task runs for too long on public gitlab
> >> runner.
> >>=20
> >> Split the job as what we've done to azure pipeline.
> >>=20
> >> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >> ---
> >>  .gitlab-ci.yml | 103 +++++++++++++++++++++++++++++++++---------------=
---------
> >>  1 file changed, 59 insertions(+), 44 deletions(-)
> >
> > I don't like this. The list in Azure is because of the time limits there
> > and in turn we:
> > a) Have to tweak it periodically to keep things from running too long
> > b) Have to tweak it to ensure that we don't miss some new SoC/etc
>=20
> Then it will render running CI test on gitlab.com impossible again :-(

Yeah, it's not something I'm the happiest with. Looking around a bit, I
see a blog post that talks about dealing with dynamic variables, in
Azure. So we could, I think, figure out some logic to have each build
stage say what platforms it covers. And then have a final step that
compares all of the platforms built vs the global list (just
tools/buildman/buildman --dry-run -v) to make sure nothing was missed.
With something like that, and assuming GitLab can do it too (it probably
can), I'm OK with having the world build be broken down to 10 groups
(maximum number of parallel jobs in Azure CI for free) since we'll know
if we miss something too.

So lets set this patch (and the doc update) aside for now, unless you
want to look at the above. I'll look at the above soon.

--=20
Tom

--PN5sZ4B3K8VUyomg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZp1dsACgkQFHw5/5Y0
tyzNKAwAknv5m/Vxao8NHydW76r+eQ7v7xCQJmvA2XecbORrc9rQbcn0BJCpsSZE
MjPvfi5jvlzp0fQNnH89q+tMj0m5+EJMLQsrAcb3p+kZ9ZIjz8Hpd01yjfpS6Im6
NJTat7Q5yI3hGVydudx7544GdPd8xJWF63DNmJbgqWqwW78XjECYiaibAmN/vTrG
qxscHA3dKTFavxqlN4k5Fji+d75AcDZ43eTHg33gHcEPe66f6V51R5oImLuqzUHa
tFeS+DoZCFqxvvgWdg27JUix/8HLy90CoJeIoGY67l1yKQX28tXEzUr5JWRqTn9t
mxfZwKcmq3E+Z6SvOARnbe/M0OsXTgqCqW3+ayo+eppvc8UEIZqMV3JyIX0+YAsj
5HLXEY8NbJwhHeMsie6sK+1cMp/O+Xf5dpMvgm3oB28o2emUHucCptSLF4VWAMCJ
0JMDmIUo4PwkmJFFiWr+Oy8IB3eZg9MzSt/9f0PsTbGw0nt7aNtWbD01VvInMKfk
+cHW+Eua
=zEKK
-----END PGP SIGNATURE-----

--PN5sZ4B3K8VUyomg--
