Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58512C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 15:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 889E587559;
	Thu, 25 Jan 2024 16:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Tykr44FX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D89D87897; Thu, 25 Jan 2024 16:04:10 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28E0B87134
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 16:04:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6818d263cb3so47520726d6.2
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 07:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706195045; x=1706799845; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zHj+GY+dKxCo9JwwpM78JMUy6biA2WMU4dqQ3GsXW2I=;
 b=Tykr44FXprnRW2yUCNeefkLLSV0kgCzRbY8aj37yNSLtmoe/NKDJbo0HYtp8/U4Okn
 XDlrJ1t/7vopMF+Tfx142YeuJh46MOEv2y3jVtGgt6TiPqYyfZRBSUXpGXUrXOTFtPH+
 g5c+8vANpRrGBQab+wN06+pVAq1imyCNkWzgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706195045; x=1706799845;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zHj+GY+dKxCo9JwwpM78JMUy6biA2WMU4dqQ3GsXW2I=;
 b=jLpT6KkiOydtAiHZHT0oJLgJ0Kokb33Qowt7RkldTOZbszt/kG2oFNbykw9r3JmqZl
 rF1+M3iLkGsa2PfX2vUIzOuvLox/3/oQlM3S8Yr7iZwwnJA4FEQqn+wTyfbV6hgZEINa
 yieCMd/hC0W9QWVs0/fBh7WD8vJ6CLrmynFfppol3vMT7x0aPMo/MSKKAh2PW7FIwpJl
 IHKZu7FISo0ESseTB1LcbQ9GB7nD4Xl+KlgBQG7eWVNClNJgVHWOXq5/nha11kTeN3H4
 jR1XbrKnxDA9p6IkV5ztCLYytz3EqtOUZ9L70e918O+OW8UIW2h9/BO+s12JbSJTJEj8
 ASdw==
X-Gm-Message-State: AOJu0YwM5Of8733jtSJSRULb8JkGR6hHco93J29A33K5pnFnddu0cT3k
 /InbeTyuO6tluEOJhqf8dYz6zP8GjpEuKZQO6IHd5T8H4GgX6adNc9hndaHpIic=
X-Google-Smtp-Source: AGHT+IGuohF7IVVqZS0ugmYETim1ESaYT8qCB9JPSkJ38LIl/3VaeLcW7S0hYsVnBgG1OEVKcTtYcA==
X-Received: by 2002:ad4:5c44:0:b0:684:e4e3:3a49 with SMTP id
 a4-20020ad45c44000000b00684e4e33a49mr1688219qva.48.1706195044631; 
 Thu, 25 Jan 2024 07:04:04 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 ny18-20020a056214399200b006868e6d8b37sm4206977qvb.23.2024.01.25.07.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 07:04:04 -0800 (PST)
Date: Thu, 25 Jan 2024 10:04:00 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Marek Vasut <marex@denx.de>, Caleb Connolly <caleb.connolly@linaro.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, sjg@chromium.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor@kernel.org, neil.armstrong@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
 mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance
 within U-Boot
Message-ID: <20240125150400.GM3652023@bill-the-cat>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <82d509de-3d47-4cc2-8217-c38dc78fad28@denx.de>
 <7b4ff8e8-2f21-4d07-9848-fb0d5652819e@linaro.org>
 <4d8aede8-5ea8-45a4-87fe-d555a025ef8e@denx.de>
 <CAFA6WYN1tFs1id7UxTwLEyp69zx2BPUP7bffVZn80FKPLx2yJw@mail.gmail.com>
 <48125705-e78e-438f-90ac-2816432cd747@denx.de>
 <CAFA6WYMuerS5YTsquGvc+OHr+0a3JXrM4AQ_ReV4tPhvxv9H0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ve8452iyz3omAKn5"
Content-Disposition: inline
In-Reply-To: <CAFA6WYMuerS5YTsquGvc+OHr+0a3JXrM4AQ_ReV4tPhvxv9H0w@mail.gmail.com>
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


--ve8452iyz3omAKn5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 12:54:22PM +0530, Sumit Garg wrote:

[snip]
> But at this point we have to move away from apprehensions about DT ABI
> breakages and provide real examples of the DT ABI breakages in the
> past. Are you aware of any DT ABI breaking change backported to Linux
> stable releases? This is the sort of information we would like to make
> DT bindings maintainers aware about.

Well, how far back are we going? There was a serial related one, but it
was probably closer than not to 10 years ago and lessons have been
learned from it already.

The real breakage comes in the form of (from the Linux kernel):
commit 37685f6a63eeca2135d1f704e7638409a071b1f6
Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date:   Tue Feb 19 08:46:33 2019 -0800

    ARM: dts: am335x-evm: Fix PHY mode for ethernet

    The PHY must add both tx and rx delay and not only on the tx clock.
    The board uses AR8031_AL1A PHY where the rx delay is enabled by default,
    the tx dealy is disabled.

    The reason why rgmii-txid worked because the rx delay was not disabled =
by
    the driver so essentially we ended up with rgmii-id PHY mode.

    Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
    Signed-off-by: Tony Lindgren <tony@atomide.com>

And this is of the style "the DTS was wrong before so we can break it".
This is the specific example (as the board is in my lab) that comes most
clearly to mind but there have been similar examples in 2022/2023.

The other just as painful examples I think may be where Marek is
concerned and it's around nodes being renamed for correctness. We've had
a number of cases where a - turned to _ (or vice versa?) and whoops,
platform stops booting. Down the line, tooling would catch that, and
it's a problem of not being able to use better tooling until we have the
updates that might break the boards that need the better tooling.

And really this gets to the crux of the problem, how much testing do we
insist happens prior to a re-sync being merged? Do we want to go with
the whole of the dts files are re-synced, or do we leave it per vendor?
I think it's been noted that a subtree merge commit doesn't really "git
send-email" well.

I really am inclined to start with keeping everyone to the release tags
for everyone and merging them as soon as the next window opens. I
_think__ and we'll be able to find out quickly enough, that we can
cherry-pick fixes from upstream in to our subtree and have subtree Do
The Right Thing in the next merge window.

[snip]
> > I think upstreaming the bootph* properties would still take a while, but
> > is not relevant to the aforementioned question.
> >
> > Assume there is a sync, would the current in-tree -u-boot.dtsi files get
> > updated to work correctly with the newly synced DTs ?
>=20
> As long as they contain nodes/properties (eg. bootph* etc.) which are
> compliant with upstream DT bindings then yes they should work
> correctly with the newly synced DTs.

This is a good specific example. The bootph* properties should _now_ be
easier to get accepted upstream as our tooling handles the transitive
property of them correctly and so they don't need to be manually applied
so much (a problem upstream maintainers had, after the binding was
accepted, was the sheer number of them being added, this is now fixed).
But also applying these properties via -u-boot.dtsi was tripped up in
resyncs where the parent node was renamed for correctness and there's no
tooling that we had that complained. In the future, this would have been
caught because we would have been dtbs_check clean, or at least clean
enough that I'd be running it and caring about deltas from before/after.

--=20
Tom

--ve8452iyz3omAKn5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWyeF0ACgkQFHw5/5Y0
tyx5ugv+PBFaZTYi7jWCJPRlFphI1G24s6Zqd9w4jX8oLzdsfpuVygzycneYrtyb
4+i6bSOLLwjZnGwqps9JTMtqAJ/oOLdIHo9/7MTKmdUeX70R/1FKGGxlgO3/jMJj
0IUo5NW9dZsUyIR3OD0/Se3ZmzE85QGLpe9oSwOcZQXGw9iyskdAnJlTdQ/hdnbw
8HpHoDk0JT7ikqFhFx7zgFurpkkfv95/SiH8JDyzUi/jwRGQSjfFcVQSdoFwNZg8
msMkyNVoh4iWtAaIY1KulO1S/T3SHOh30DEMrjEqmAMY/mkRtxE0BwPzuXidWR79
Jq+E9PulWxgbBJ8Kcrrnd4SXfqZ0XZKniBwijgfomM10Rz3oXb8mZkEPcxtp4+Tb
EcxLD1+QKYKLSu/LWATXRDbSh1rflowvAOyc2Bxh8PXof8RvsHs/W7ajzXoZ6zY6
NwyOCmG2fqEqfBaYrltHbC7XIz1VDzTfPDb9yVImhUFhJSslOCO8tNmldb8WIRxf
zpQ6wuPb
=195M
-----END PGP SIGNATURE-----

--ve8452iyz3omAKn5--
