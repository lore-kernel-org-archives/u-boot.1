Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EDECAC5AE
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 13:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A93B883447;
	Wed, 24 Sep 2025 15:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NaZWaDc3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0672C834D4; Wed, 24 Sep 2025 15:51:47 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AE4680107
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 15:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-30ccec928f6so2895292fac.3
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 06:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758721903; x=1759326703; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WqUCTsrBGZqd2APnTOn132IM07S7qZH5Ypo9M7ee8aM=;
 b=NaZWaDc3yjTTkMnGzrR+HCrfwik2GIR2E5XzhQPypooagK8YvuXAqxkr9owvNjWIm3
 uPKypnvbq7LN1He1TU+KWT+mP7es2ntAyhEWT5d0LetNclgx+IdeVchgjrOBRbXghDqh
 5CqsSIPWLzhI2LA/9V1Ueby1hAccFhJilFqTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758721903; x=1759326703;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WqUCTsrBGZqd2APnTOn132IM07S7qZH5Ypo9M7ee8aM=;
 b=q9uu30WJZTOrkb06uvFPRfwYZR1jtxgFX2M3Jda0ZbZJLIIe+HMTjEK7B4ZHBmBCKq
 qixhBbIieWD5z11nwXix2qKkq7PkMTypAxGGYDF62RIE2QWI7s9fZHbC5QfSHZbnWPbM
 HAI0mjjFsmjnJIhe/HdEcqxti5SEcTDvXuVGVQvH+Pgw0gtfE3f47Wac7V/XQTdrCkTw
 p5HEy2+qSjsjrv043n4WfvI4K8vEgp1JS0b3Zmq/uUfq4nMM1MEHBRtEwBJJFKhjU8TX
 zi0jozyUfW1MvAfL/ymnJIP+Ijij2Lwvs/800TtTYS8N1bb1E9P5lrkjxn3KsC7zLUWV
 5KYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYh9FJCEI3IOtl2UJ9KY3GxkhJ1+ZfVxjvb/BSwWAYlyzIaffI8UyEgMAmiiCBbFyKo4lUM1g=@lists.denx.de
X-Gm-Message-State: AOJu0YxXQdOUb7Cp811Lg1//w25q5p4U1pnhtyMe1vWDrHLEUGJFcf9L
 jBO5gKpIsP7vJW2BQWKoe3JnUgo0gWsx1noLkM+rKlnipSU3nL+xDLlt/q33h7b4kmk=
X-Gm-Gg: ASbGncsZ64LDaqoJE08qpJFHulgOplAP7m8TPbk+pfYVJTKHUd9hBXY2x0NSQ2iiNin
 8VJIU5mfJsOj40vM71IE5cOBmxponHPaVKSpLJ/WHBlpt3aJjYd9Y68J2LjboLNWhnlBO4D3BLj
 5gYO9xzRjUiEZU+lRwO+H6TOSFGINkirNlPIsFJAm+ItnO0Yh9XJR9zqDtwlbhIpRVixAnU98dm
 ptxWhY8BWcLTH8Aa0ukCV5K5/aW23h7VRCm3Mdq2g/8SMjiqirc29OG53XtEJfIWZhdWaok6YYA
 vN97nvgGTTcJ9A7S5V0KFtRaEw9lx2adh2/xXhTnLX8EWUf06jRdC1Zo3kLBTG+MhQTDOl5WH7z
 XTAA0Mkse7DlNSoftWz4sxz30Aa3I+WH5f5mH6P39L4YAyKVR9k1oE9eD
X-Google-Smtp-Source: AGHT+IG7vxTWVYwXhfSXuU6mERZ7Nd5uws6f/s4v3+UBYi3kybL35WyGIKHs3Eqn1moBXK3BT9ZOgw==
X-Received: by 2002:a05:6870:64a2:b0:342:74e6:4fac with SMTP id
 586e51a60fabf-34c86b478a1mr3394434fac.42.1758721903152; 
 Wed, 24 Sep 2025 06:51:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-336e412167csm10372968fac.12.2025.09.24.06.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 06:51:42 -0700 (PDT)
Date: Wed, 24 Sep 2025 07:51:39 -0600
From: Tom Rini <trini@konsulko.com>
To: E Shattow <e@freeshell.de>
Cc: Nishanth Menon <nm@ti.com>, Aristo Chen <jj251510319013@gmail.com>,
 u-boot@lists.denx.de, sjg@chromium.org, alpernebiyasak@gmail.com,
 al.kochet@gmail.com, paul.henrys_ext@softathome.com, bb@ti.com,
 y.moog@phytec.de, w.egorov@phytec.de, francesco.dolcini@toradex.com,
 ggiordano@phytec.com, n-francis@ti.com, afd@ti.com,
 d.schultz@phytec.de, d-gole@ti.com, ravi@prevas.dk,
 carlos.lopezr4096@gmail.com, quentin.schulz@cherry.de,
 alice.guo@nxp.com, Aristo Chen <aristo.chen@canonical.com>
Subject: Re: [PATCH v2 0/7] mkimage: Detect FIT image load address overlaps
 and fix related test/DTS issues
Message-ID: <20250924135139.GH197373@bill-the-cat>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20250924113733.uz6hozszbuynemtc@giddy>
 <20250924114317.742ae4ntrb4mvuyq@expert>
 <b07919da-f3fe-49ca-8f76-ab057d8af58a@freeshell.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y486mIP/9owdqAHG"
Content-Disposition: inline
In-Reply-To: <b07919da-f3fe-49ca-8f76-ab057d8af58a@freeshell.de>
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


--Y486mIP/9owdqAHG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 06:31:23AM -0700, E Shattow wrote:
> Hi Aristo,
>=20
> On 9/24/25 04:43, Nishanth Menon wrote:
> > On 06:37-20250924, Nishanth Menon wrote:
> >> On 10:59-20250914, Aristo Chen wrote:
> >>> This patch series enhances FIT image robustness by adding **memory
> >>> region overlap detection** to `mkimage` and fixing existing overlaps
> >>> in DTS files and `binman` tests.
> >=20
> > [...]
> >>>
> >>
> >> Looks like i see a build regression in linux-next after this series.
> >=20
> > I fat fingered that one.. sorry, I meant u-boot next.
> >=20
> >=20
> > Fails at commit 4d84fa1261eb, last pass was on commit d81c1118580f
> >=20
> >>
> >> https://gist.github.com/nmenon/b2fc9e7680cc296062c7dced94105f76
> >=20
> > I  believe there are outstanding comments on V1 that have'nt been
> > addressed either. Can we revert/drop this series for now while the
> > comments are addressed?
> >=20
>=20
> Similar to Nishanth, I am seeing a build regression, itb.map:

Sorry for the noise all, I've reverted this in next now.

--=20
Tom

--Y486mIP/9owdqAHG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNP3ZwAKCRAr4qD1Cr/k
CjLVAPwLzkfnZ66VokagMJ20i6mJfzu9n08+X4v0tiO6dcvybwD/VAz1VKvPixp9
KmeUPXQXZzesnhz5HmY2lax+GqIGLQI=
=nBD7
-----END PGP SIGNATURE-----

--Y486mIP/9owdqAHG--
