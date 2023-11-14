Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C66BC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 13:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65B9C87215;
	Tue, 14 Nov 2023 14:37:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jqwihxeB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66BBF87225; Tue, 14 Nov 2023 14:37:22 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F290A871E4
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 14:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-66d17bdabe1so36073166d6.0
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 05:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699969039; x=1700573839; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RUACpLQgKC1J1HJtbgu7J2z2oY3Abvy/Hlvg1QpWpS4=;
 b=jqwihxeB1oKMrDeOPxiEKkZwFk4aeY4b5rHMuUmmUQlqpEdCsZXmKqSu5UWeSAj9Xo
 2NfXusGnYvZxcegTyiEaluX5jcvwgZzCVYDkdVPVoRNjMw7aRDOQHPwx5yGRYmsMt1qm
 ycymtR2bQQmpazgCzr1Llwe4caNXlDt12QQWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699969039; x=1700573839;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUACpLQgKC1J1HJtbgu7J2z2oY3Abvy/Hlvg1QpWpS4=;
 b=W/UXg02h/+TZw5CID85XFKdGL9ueVboLbJZdI3Aj9f5zND5f4yKWvPamyTCA24/oBE
 o4mBi02lFf4PvKnbaKQ8ZZPuFSCWGMBF3iAiF1YCRhw3BQ8eQpxJ8nAwSfO1XMpHTyVf
 clE521eqbn8afovR7jmmfNIWhbVjLa3vL8wFFPb/pOfSu2wi4WbEURCjFmuYpAGkfEN6
 8XqcmHxqSUFrkgQzOAHNG91Qw1a27HNcuWJaO6kJ5ErbSLqvVCU3htoneiyQqew/Y3DB
 qSafwwQ4rD+1Qq3OWf+P6TAXbCEkwnKphZf3RDcMPCQp7c9QvJMNpglWEa5yegpieC8k
 Xigg==
X-Gm-Message-State: AOJu0YyyGi2JMgVbj02BAueXchhb4n2pLXObEa1dUJ81bnz9yA/ghXJR
 o5wpPgoNdt6avew85OfZsm7g9g==
X-Google-Smtp-Source: AGHT+IGvdVoSCbtsYZ51KA/QNwRfBv4lclnO4afyJGg+Pjt/bbiwotXbrRuNoSDuTtnKJXojYyDpFg==
X-Received: by 2002:a0c:ea4d:0:b0:66d:2eb6:f3f6 with SMTP id
 u13-20020a0cea4d000000b0066d2eb6f3f6mr2351562qvp.32.1699969038763; 
 Tue, 14 Nov 2023 05:37:18 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2a5c-a31a-8ead-8e73.res6.spectrum.com.
 [2603:6081:7b00:6400:2a5c:a31a:8ead:8e73])
 by smtp.gmail.com with ESMTPSA id
 ef17-20020a0562140a7100b00670e0f71ff7sm2948931qvb.90.2023.11.14.05.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 05:37:18 -0800 (PST)
Date: Tue, 14 Nov 2023 08:37:16 -0500
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, sjg@chromium.org,
 u-boot@lists.denx.de, vigneshr@ti.com, u-kumar1@ti.com,
 reidt@ti.com, m-chawdhry@ti.com
Subject: Re: [PATCH 1/2] dt-bindings: misc: Move esm-k3.txt to
 ti,j721e-esm.yaml
Message-ID: <20231114133716.GQ6601@bill-the-cat>
References: <20231113043023.2126690-1-n-francis@ti.com>
 <20231113043023.2126690-2-n-francis@ti.com>
 <20231113195216.m7itxtjh467vv3yr@equity>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OWydk3Ny27eKdhcI"
Content-Disposition: inline
In-Reply-To: <20231113195216.m7itxtjh467vv3yr@equity>
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


--OWydk3Ny27eKdhcI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 01:52:16PM -0600, Nishanth Menon wrote:
> On 10:00-20231113, Neha Malcom Francis wrote:
> > Move esm-k3.txt to ti,j721e-esm.yaml in line with the devicetree
> > documentation in kernel.
> >=20
> > Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> > ---
> >  doc/device-tree-bindings/misc/esm-k3.txt      | 25 ---------
> >  .../misc/ti,j721e-esm.yaml                    | 53 +++++++++++++++++++
>=20
> What is the rule here?
> https://tgit.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/devicetree/bindings/misc/ti,j721e-esm.yaml
> we have the binding in upstream kernel.

Not to cause anyone undue worry but part of me wants to just
submodule/subtree
https://github.com/devicetree-org/dt-schema/tree/main/dtschema/schemas
as that looks like Rob syncs it with the kernel periodically and since
in turn we're working with Rob to upstream our unique bindings there
here and not there list should be shrinking, not growing. Since we say
"use the kernel device trees" and we don't have the validation make
targets, the content of the copies of the schema in our trees is more of
a promise that it's true than used anywhere. So perhaps it would be
better if something was written down to that effect.

--=20
Tom

--OWydk3Ny27eKdhcI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVTeAwACgkQFHw5/5Y0
tyyw1gv9H5PH415BMkoKwLvnl9kXs4JFZf5UQRw4j6HsHEuTyWwk6GiVdaEouQhB
6eLSeUVJEAAsWtZDIDVB9MaE/qgT99lylVuE9YFPSw605nUifZrTa62zju8EJqHw
k3jwYm8eXVr7x8cySTKfRL1JpyaUjh7GYtqfZqrjQBHTLrUiZBcMCqM6H/v+gVCo
D18EoMNUOHHdmKQECfNURxCzOLBvGGYb8HkmJR21HDtJIMLm1I14RiR+UxczFhrE
cs+NwV6FsG1BnWEpH+l7PIfnWIVlTms504CYsRW5Ujp47bHHb1OLUsDJJD1yt8PP
YHswp0NQeT3rMrN/ZJmPeZYxjk+kApEzGRYDz8RVD8iZm6JYy53fz7msAi6nDlF+
ksIrJroiBLWLgUbMKRONE9xGWDH0HiwUt+O/VBxHxsU1zJv1Y4QIsfHB23+sPXnQ
rwbVZ8QlpIsnGTqjPR4Em+8seAIpaiFu8awqp3EI1e1t/CjkMG9HJ0V4nb5SQQ6E
74Ez70qp
=QSd6
-----END PGP SIGNATURE-----

--OWydk3Ny27eKdhcI--
