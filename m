Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8900CCD1BB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 13:54:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D38F832BC;
	Wed, 22 Oct 2025 15:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sqafkHML";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50C8B8334F; Wed, 22 Oct 2025 15:54:08 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AB2582B20
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 15:54:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c288d3f249so2721533a34.1
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 06:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761141244; x=1761746044; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kEY2/wxbCs0I0Zb2hoXnSfNQE3LIHJhYS7Hjv3cbBEo=;
 b=sqafkHMLqZtrzZCxbn2aK9UKL3fuGjQency4bm0KXPq0e5Db2bIEWL89N50HPXlEnH
 8ugdDnDoWpQpgz9IagTmDAVWdxKCAYaYH6I0wWihcpFSAaq+oKbCo17MBg+BQyC54K9x
 HZ6SJB4OArwylPMiTrtUaqp4Lva4iBRjSeqr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761141244; x=1761746044;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kEY2/wxbCs0I0Zb2hoXnSfNQE3LIHJhYS7Hjv3cbBEo=;
 b=n91CfEzkF/pejSiEKayBJfWiYh3MdM0DEGwR9ngakGc9Y79q/OV/pGYgZZIHqmAN4y
 E/v9tlLNUvTmvV/xTluLHpeGSe8RJhX8h/M+lUZzKEg5GvQSTbw8THztDHzsqHNmFsog
 Yz/GKez+Qb0eByJq0neI1xX2HMdPxH6/q82yvYdeVRtatxhIKisM/z2wUvPCFOpNPa9E
 Yn35sXtPGaOZVa2pTa5jsxXQEib1AIfuEUOgJvYLUJqSZkx3/EK+OkaS9kUeC1uKtZFf
 BA337l9/6OAbA4eZeWYpHp7qBM8w3gba3TD32rCDS9JGUt3r8KNCbqkfK4kXvZMtfEmC
 JMhA==
X-Gm-Message-State: AOJu0YwTwD8WTlRTuqHTOOtiDIca/mbfdCquox7w+911BQvfi85oj1Cu
 +mEsMFGgrP/dFtBuca3CIwy6YagBpGOxvldI3SWtQFnX46IF1iBe+i2G8HU9ZZ9mnnI=
X-Gm-Gg: ASbGncuQTZ06P+DB4QMnncNH8qQUxJ64OQFbaPZ0SptRMYsU02tWfaqJ4PZ/PVUvJ0X
 vQvlWiBqfZnrbhJseaQtGrwhuQyifM9jtFjy/ZS5huX5PEIuO2NKE48tJklpjxLCTOcf2pD5tXH
 dUmHWKBlzg8u35FxVjmDhqQ3IVkr+90h1HbVsdKA6s+tTEp+bMI/2Mqg0IXxhdFFpeZqlgeIK6s
 4xoUG++z8KRNMsvGQrviCrSb5owinH00qFXwgoQ39aZdQEDJ7qjl9qhd6OaIow+vTUac+5HKCP5
 DhPFNpDTIr36DAxLRWCSfFtouREB7MWTOu4fsWSkDugTC7kpAHLe02O99AeayvZA8WjbZtGhtcH
 i9jmoblRu/UgGwnJSiiiN2t6w7Mfdx6VOUYZQK3IsNEfZcKbx0IjNAD9Un+J1aBs5CJUE0VgU+H
 kMvTZaxHZU6uRX5QwDmLY5z9CqcV2ldSFf6z+xIyQ=
X-Google-Smtp-Source: AGHT+IFshJf3XkiupWiF3c6JRm1iJU5joNGySWHfjuc5zOA1ALUzIZTt7yYvM5bqnHTbzukSdZHj0w==
X-Received: by 2002:a05:6808:1b0d:b0:43f:b6de:8152 with SMTP id
 5614622812f47-443a30dd51dmr8720584b6e.40.1761141243868; 
 Wed, 22 Oct 2025 06:54:03 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-443dc4d5653sm3300495b6e.1.2025.10.22.06.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 06:54:03 -0700 (PDT)
Date: Wed, 22 Oct 2025 07:54:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 1/3] doc: usage: Add general rule for `$?`
Message-ID: <20251022135401.GJ6688@bill-the-cat>
References: <20251021202820.1272414-1-trini@konsulko.com>
 <20251021202820.1272414-2-trini@konsulko.com>
 <3a453e3c-9ed0-41a1-858e-84f7cad7b50c@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7D0LLmScqBBhcyp8"
Content-Disposition: inline
In-Reply-To: <3a453e3c-9ed0-41a1-858e-84f7cad7b50c@cherry.de>
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


--7D0LLmScqBBhcyp8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 11:19:21AM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 10/21/25 10:25 PM, Tom Rini wrote:
> [...]
> > diff --git a/doc/usage/cmdline.rst b/doc/usage/cmdline.rst
> > index 58240c5279cd..cb353975eb82 100644
> > --- a/doc/usage/cmdline.rst
> > +++ b/doc/usage/cmdline.rst
> > @@ -55,6 +55,12 @@ General rules
> >      command will cause "run" to terminate, i. e. the remaining
> >      variables are not executed.
> > +#. The variable `?` will be set as the return value of any command. Th=
ese
>=20
> s/These/The possible/ ?

Sure.

> > +   values are 0 on success, -1 on a usage related errors, i. e. invali=
d syntax
>=20
> s/a//
> or
> s/a/any/
> ?

I'll drop 'a'.

> I would also add a comma after "syntax".

Is that oxford comma or no?

>=20
> Should i.e. be e.g.? c.f. https://en.wiktionary.org/wiki/i.e.
>=20
> > +   and 1 on any other error. Any exceptions to this are documented by =
the
> > +   specific command, i. e. :doc:`cmd/for` sets this based on the last =
command
>=20
> s/i. e./e.g./

Maybe? In both cases I'm following the example in the previous rule here
that's quoted for context.

--=20
Tom

--7D0LLmScqBBhcyp8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPjh+QAKCRAr4qD1Cr/k
CsFYAPoCG4q6w27Iu2h0Vj0Ud7RtR7+KjGe/Jdrj2SwyKU5Z3wD9FQ6+XG6HF6Qn
KYGJM0mObTARNTaFVmMzVonQKIbDDgw=
=z0pj
-----END PGP SIGNATURE-----

--7D0LLmScqBBhcyp8--
