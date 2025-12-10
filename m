Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2701D3C918
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 14:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3F5E836C8;
	Wed, 10 Dec 2025 15:29:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QdPYeQsV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 587FF83869; Wed, 10 Dec 2025 15:29:24 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1ACB8367F
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c71cca8fc2so4998135a34.1
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 06:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765376960; x=1765981760; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vDJ8fzk/B1rhNPi533ZVGuBQockuA2PLioVXwqGw340=;
 b=QdPYeQsV/fPwQXzzzUqdjmJ9IHDGfdPCJCn0js2jyA5Hlp9/g+7cvab4G2kL21u37t
 9H892T/s1QQ7F/FLoiMwrgPnDy0+VbzH3qJtfFHL3F8eE9KLrLadxvmvM66o5XpXRtCI
 4gWKHjZJPKP8g/7vc/MTtpU1bLP9jXyJcFx0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765376960; x=1765981760;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vDJ8fzk/B1rhNPi533ZVGuBQockuA2PLioVXwqGw340=;
 b=d7VVXLf4jyLOTHQhg9VK1xqUOBIU8s28yXZuc5cl+rf6WqPSLFEDmpwBu+thaFBfI4
 qiwkypo8NoMBRoVyMc9zFg3tRcybzdUZ5Cfwxo6sFV2Sk9hNWcUCQSqenqwDe5kiwuVm
 14trZR839WUrzceJgj/warvPJiEhh7UkshLCzPFwWESivhbFCEvGwyl4+2s2csw11WSE
 u0+rKN3C7xliH1kVkXFGXELYVg3yLCaoq1KV+emh62JAGJUQTRBi7q7YIUwySJsfhJmV
 Rt3QIxCzv2jc9iWuGtSp6WVuDyo0xsZ6cJbi/WlhwHXezsaO7WNv0Hdm5PpqYu81uLng
 xQyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMqmpgGuAn2umzu7wzr1IMf8p93OucNr4dZ4QyUf3xqZpZdFIxPR7cq39uS18/IwLRlAu5Kzs=@lists.denx.de
X-Gm-Message-State: AOJu0YyUSUQAmoNbdDgO4yy1V+YkR9sT/XQU29k98euUJv0/Ku0YRa1G
 xNTcx2Hii+7XowaKxpEDTsiDqzNse5dF/RdFLoi0ltdVkxX55W7pQVI0ssAaEb6ogas=
X-Gm-Gg: ASbGncvlXZZq/55weGjH3ovd0dcg2Zd9wyQJIJGIXathqRE6ezYB6tUzs5pu7WOWbLF
 B55JXJeOCjp+JtZQkCgQAV0kMA3HLbEKKe+eDN7l+IA3FTp2TmvpV4ZHI1oucu1oKIBCmU7u762
 3MGMdzojYSZdJyxRQCPTzUaRu0sG1VFqvwJlmJ60lvQ+XBy88UJ5gLmfEWxRNyKK0Zw/K2XPHR/
 +3OK/lV8sFlGgYlQd5UQxjqPjk+bqXx85fFWDQva178HiVZm8chvcl3XxWu+rkhNsRUdYhDGz1z
 QGrjALgUXhKbK9q6ELBSY9qTeD9GnZBVz8mdjSQos2JTFmCGz9xERjplzrIvdYYcI4XTCUMr99G
 JnhKKxuzd44iL8hxyr9IgbSeeB8d3fAxpqdT38twSS7/1ut7LelCYgH+dBq7o0SZN3/kxumjgPc
 7ysVhAr4lRBg2dQcKOh9Fc5batJDMmeTOC7RvMGfesOS7+rxMrDQ==
X-Google-Smtp-Source: AGHT+IHLWQCrmXE4cC2Pqj4FOE3OKUbzeaMtl2PtTxHS66rBlHm2HY7i8GKmkIeOJpaYv+oVVpeyHw==
X-Received: by 2002:a05:6808:c1ab:b0:438:430b:3dce with SMTP id
 5614622812f47-455865521fdmr1559720b6e.10.1765376960180; 
 Wed, 10 Dec 2025 06:29:20 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a91d789sm14446475a34.10.2025.12.10.06.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 06:29:19 -0800 (PST)
Date: Wed, 10 Dec 2025 08:29:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Bryan Brattlof <bb@ti.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Peter Robinson <pbrobinson@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>,
 Kever Yang <kever.yang@rock-chips.com>, Yannic Moog <y.moog@phytec.de>
Subject: Re: [PATCH v3 4/4] tools: binman: fit: add tests for signing with an
 OpenSSL engine
Message-ID: <20251210142916.GF303283@bill-the-cat>
References: <20251121-binman-engine-v3-0-b80180aaa783@cherry.de>
 <20251121-binman-engine-v3-4-b80180aaa783@cherry.de>
 <CAFLszThxhLBEm731QjvB-wbOGryGBfh1_09NeWNy13nLwqZW4A@mail.gmail.com>
 <6b2751af-783b-40d4-b205-5859b7eaa0d2@cherry.de>
 <CAFLszTh1Tt1=9SOHf1WdnENB3q1E7vdq4mK4XjPC7Bob5gQoEw@mail.gmail.com>
 <fea1b8fb-2512-41f9-af23-a716c70cce39@cherry.de>
 <CAFLszTieo4xZzo6VkvrP28duwgksgpx+4HP3tQ8WVEdssYzGOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JUrvhxaCpW7meZw3"
Content-Disposition: inline
In-Reply-To: <CAFLszTieo4xZzo6VkvrP28duwgksgpx+4HP3tQ8WVEdssYzGOA@mail.gmail.com>
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


--JUrvhxaCpW7meZw3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 05:32:04AM -0700, Simon Glass wrote:
> Hi Quentin,
>=20
> On Thu, 4 Dec 2025 at 04:50, Quentin Schulz <quentin.schulz@cherry.de> wr=
ote:
> >
> > Hi Simon
> >
> > On 12/2/25 9:06 PM, Simon Glass wrote:
> > > Hi Quentin,
> > >
> > > On Wed, 26 Nov 2025 at 04:44, Quentin Schulz <quentin.schulz@cherry.d=
e> wrote:
> > >>
> > >> Hi Simon,
> > >>
> > >> On 11/25/25 11:15 PM, Simon Glass wrote:
> > >>> Hi Quentin,
> > >>>
> > >>> On Fri, 21 Nov 2025 at 10:15, Quentin Schulz <foss+uboot@0leil.net>=
 wrote:
> > >>>>
> > >>>> From: Quentin Schulz <quentin.schulz@cherry.de>
> > >>>>
> > >>>> This adds a test that signs a FIT and verifies the signature with
> > >>>> fit_check_sign.
> > >>>>
> > >>>> OpenSSL engines are typically for signing with external HW so it's=
 not
> > >>>> that straight-forward to simulate.
> > >>>>
> > >>>> For a simple RSA OpenSSL engine, a dummy engine with a hardcoded R=
SA
> > >>>> 4096 private key is made available. It can be selected by setting =
the
> > >>>> OpenSSL engine argument to dummy-rsa-engine. This can only be done=
 if
> > >>>> the engine is detected by OpenSSL, which works by setting the
> > >>>> OPENSSL_ENGINES environment variable. I have no clue if dummy-rsa-=
engine
> > >>>> is properly implementing what is expected from an RSA engine, but =
it
> > >>>> seems to be enough for testing.
> > >>>>
> > >>>> For a simple PKCS11 engine, SoftHSMv2 is used, which allows to do =
PKCS11
> > >>>> without specific hardware. The keypairs and tokens are generated o=
n the
> > >>>> fly. The "prod" token is generated with a different PIN (1234 inst=
ead of
> > >>>> 1111) to also test MKIMAGE_SIGN_PIN env variable while we're at it.
> > >>>>
> > >>>> Binman will not mess with the local SoftHSMv2 setup as it will onl=
y use
> > >>>> tokens from a per-test temporary directory enforced via the tempor=
ary
> > >>>> configuration file set via SOFTHSM2_CONF env variable in the tests=
=2E The
> > >>>> files created in the input dir should NOT be named the same as it =
is
> > >>>> shared between all tests in the same process (which is all tests w=
hen
> > >>>> running binman with -P 1 or with -T).
> > >>>>
> > >>>> Once signed, it's checked with fit_check_sign with the associated
> > >>>> certificate.
> > >>>>
> > >>>> Finally, a new softhsm2_util bintool is added so that we can initi=
alize
> > >>>> the token and import keypairs. On Debian, the package also brings
> > >>>> libsofthsm2 which is required for OpenSSL to interact with SoftHSM=
v2. It
> > >>>> is not the only package required though, as it also needs p11-kit =
and
> > >>>> libengine-pkcs11-openssl (the latter bringing the former). We can =
detect
> > >>>> if it's properly installed by running openssl engine dynamic -c pk=
cs11.
> > >>>> If that fails, we simply skip the test.
> > >>>> The package is installed in the CI container by default.
> > >>>>
> > >>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > >>>> ---
> > >>>>    tools/binman/btool/softhsm2_util.py                |  21 ++
> > >>>>    tools/binman/ftest.py                              | 223 ++++++=
+++++++++++++++
> > >>>>    tools/binman/test/340_dummy-rsa4096.crt            |  31 +++
> > >>>>    tools/binman/test/340_fit_signature_engine.dts     |  99 ++++++=
+++
> > >>>>    .../test/340_fit_signature_engine_encrypt.dts      | 100 ++++++=
+++
> > >>>>    .../test/340_fit_signature_engine_pkcs11.dts       |  99 ++++++=
+++
> > >>>>    .../340_fit_signature_engine_pkcs11_object.dts     | 100 ++++++=
+++
> > >>>>    tools/binman/test/340_openssl.conf                 |  10 +
> > >>>>    tools/binman/test/340_softhsm2.conf                |  16 ++
> > >>>>    tools/binman/test/Makefile                         |   6 +-
> > >>>>    tools/binman/test/dummy-rsa-engine.c               | 149 ++++++=
++++++++
> > >>>>    11 files changed, 853 insertions(+), 1 deletion(-)
> > >>>
> > >>> Not sure of the changes from last time, but I assume the test cover=
age
> > >>> is finished.
> > >>>
> > >>
> > >> They are listed in the cover letter in the Changes section.
> > >>
> > >> $ b4 diff -v 2 3 --
> > >> https://lore.kernel.org/u-boot/20251121-binman-engine-v3-0-b80180aaa=
783@cherry.de/T//#t
> > >>
> > >> will show you the git-range-diff between both versions for a given c=
ommit.
> > >
> > > I normally review just in email (often on a Chromebook) so I don't
> > > have that. It is also an extra step and I don't know where your log
> > > argument comes from. It would be better to put the change log in the
> >
> > What do you mean by "your log argument"?
>=20
> Basically this is an email review flow. It is true that sometimes we
> apply patches to look into them in detail, but as I said I am often on
> a machine where I cannot.

Please keep in mind that the biggest email review flow project in
history is currently the linux kernel, where this tool originates from.
Suggestions are welcome by the upstream maintainer, please go make them.

--=20
Tom

--JUrvhxaCpW7meZw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTmDuQAKCRAr4qD1Cr/k
Ch/RAQDdPMXnNlvOA/0i2yO96Fizf2lBXEhvzIL02boo3QfYTQD/e1C758mzKB/1
QhMo8rw5CjeOjfAlli8BltH3z0QzeA4=
=OOi/
-----END PGP SIGNATURE-----

--JUrvhxaCpW7meZw3--
