Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD93C25B79
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 15:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33EE78848B;
	Fri, 17 May 2024 17:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VYlckBqW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B8D988494; Fri, 17 May 2024 17:53:06 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D395088263
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 17:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-792b8bf806fso59901885a.0
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 08:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715961183; x=1716565983; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cdf9A+Zrs0bi5MCeClaEa8lZYhIPRU/0FcflbiAEPFY=;
 b=VYlckBqWg2mPa5BlwKpIHovDaE5bNMrkv1PJZSOyGJ3EgaY1WGi4+6ki/h2j9vU7EH
 2JFpk3nx86vmcUrupGgGWsMs4MOS0/7JxYfYCrZIMQXdpJoWf9KyE3sODA/F6T1wFK9i
 84rFzCQ5+NCKJdFsQ2kbNwtT+3EMCt98hsmik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715961183; x=1716565983;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cdf9A+Zrs0bi5MCeClaEa8lZYhIPRU/0FcflbiAEPFY=;
 b=IuJMFiU/CGb3qOeK7zVjTTw/gPJoiSKkwNZKxMqO53Z8cyit8dUfnrk/oaFF/3zmaj
 HP3jOl+1ftgNRQK3OF5ZlJ8jR8IMNlImf7tUZ9f+jkcb0pcYKGgjc3TZlhXf5YsM5uN8
 xWrbmQBnb+nLlQ7pwYI63WeaTVc3TULH+bOzMszO4uvWLrbuDMW28n/h5e3P40JST2zk
 gSDgV8xGU6W3VEhsOdeB6CGIxe/hXc+yz+k2QPJpQC+SKWcZVKZPkoYAfHCkV1wZV/cX
 Owg6zQiBjabiux+FLYd/Rp5LUnpuwEo/42pCwXmptCRcUSSQbjlzQkZQBtd23vcZohcA
 LDjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpQl0pCk4+4y4OAASEtc9trcyfiedhKnLnRuNljZ2NJPtGiKwUwG0IbX2sk4H2MAufjbuCc/Vq3Szku5wLlYjjxiCRBw==
X-Gm-Message-State: AOJu0YwQ7BiJByze5gHTqeFDx1wUlSnO30mjDTvTIrIUFOGYfm4sqTSC
 W+uuTR4QfH5ClWrATxcdOnDmitZlQR1j5bJD0yvz40TEmMk0cfoK7374sxAUaJo=
X-Google-Smtp-Source: AGHT+IGyJ3/zBRTvt6B0mNv9NCXHWSuupTRZuBrbOZcgBIWrOOC0oU00gfqUWaP7dCwDt2sONSIUkw==
X-Received: by 2002:a05:6214:3c9f:b0:6a0:c707:1bed with SMTP id
 6a1803df08f44-6a16822cdd1mr224512906d6.42.1715961182664; 
 Fri, 17 May 2024 08:53:02 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f194bf9sm86768016d6.58.2024.05.17.08.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 08:53:02 -0700 (PDT)
Date: Fri, 17 May 2024 09:52:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M . Busch-George" <leon@georgemail.eu>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] Makefile: add build-sandbox*/ to mrproper target
Message-ID: <20240517155259.GL2568172@bill-the-cat>
References: <20240517151534.65242-1-heinrich.schuchardt@canonical.com>
 <20240517151855.GK2568172@bill-the-cat>
 <f055664e-5d3b-45eb-b6e9-d0321058e76c@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KDDELevgprYXILCc"
Content-Disposition: inline
In-Reply-To: <f055664e-5d3b-45eb-b6e9-d0321058e76c@canonical.com>
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


--KDDELevgprYXILCc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 05:51:29PM +0200, Heinrich Schuchardt wrote:
> On 5/17/24 17:18, Tom Rini wrote:
> > On Fri, May 17, 2024 at 05:15:34PM +0200, Heinrich Schuchardt wrote:
> >=20
> > > make mrproper should remove all build artefacts.
> > >=20
> > > Running make tests without deleting build-sandbox led to an error
> > >=20
> > >      *** No rule to make target '../include/common.h',
> > >      needed by 'include/config/auto.conf'.
> > >=20
> > > on my machine.
> > >=20
> > > Let's add the build-sandbox*/ directories to the mrproper target.
> > >=20
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >   Makefile | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > I don't believe it's the right place to remove build directories. This
> > is also incomplete as it wouldn't clean up other platforms that can be
> > built, and of course it cannot handle out of tree build directories. All
> > build directories regardless of where they are need to be removed as
> > that particular change breaks re-using build directories before/after
> > it.
> >=20
>=20
> My expectation is that after 'make mrproper; git clean -df' I have no bui=
ld
> artifacts left over.
>=20
> In .gitignore I find '/build*'. This results in 'git clean -df' not remov=
ing
> the the build directories either.
>=20
> Tom, what is your suggestion?

git clean -dfx ? Per the help:
       -x
           Don=E2=80=99t use the standard ignore rules (see gitignore(5)), =
but still use the ignore
           rules given with -e options from the command line. This allows r=
emoving all
           untracked files, including build products. This can be used (pos=
sibly in
           conjunction with git restore or git reset) to create a pristine =
working directory
           to test a clean build.

--=20
Tom

--KDDELevgprYXILCc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZHfVcACgkQFHw5/5Y0
tyxYHAv/emUnkjVxZxCqLzLgLm471IKi4gcnFogEBXi1qoJvlDYJsXu67CWEy9Tl
qII0PWjLMah5TaBHrjPQEoYoyMLEHZtTtTURKIvbIbVcsLaSs73pu/y0ozfnLBPz
NTJSKXlPr9mXQFGfCSbakdQQBMSIPMCqZ347iADz2EPyeDkxUQMQ7xKx/Iuz05PZ
Be9xbjQg8CUtzxTt1Fb14dA/azlbXlxNpuacCG3kb2Dgd06eYP/G8qbaf2lII8NN
jWLzPwpQlzXZRCCEZNvJTda41gtcrYFo69yFwTduscaWD76cLj/uaB+R1nu0ArVn
CQN5Zdqyw1YYbDsQj7tBGILw8vPHIiNBKdlHXtzI3o7Mo8cj218JdOMWt6LaMBf5
ZiR28KATXJz64qFjvwCWN4ntnFReRQlyV6gtvccMqhzxQRpBkalY7GRcYGZjqgoV
VWfkS+uSkwZHxJK4Qj7dUv5HqOEaTqCLnMnJp8IKF230IMhDmKsdXg3BJVMef6go
7knici1t
=9vfk
-----END PGP SIGNATURE-----

--KDDELevgprYXILCc--
