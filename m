Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839BCC3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 16:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0E09876FF;
	Wed,  3 Jan 2024 17:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rlYVQyT9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43867877F9; Wed,  3 Jan 2024 17:32:10 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BEE786EEC
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 17:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-42832d5ac39so8274051cf.0
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 08:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704299526; x=1704904326; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jrnFlq3WzJ7E5rmvtlT/0PV/VV2iMFOCKXpIUUuO6x4=;
 b=rlYVQyT9D0iS+ywciBmmh8Jlc5Gv9oSVq2cJIVrpBLaueKaSU/laCkrPQe1khaXhln
 NF1RhfFfx6tnNjXlfT8cQzwELHyGu0E235YaBTMCp+DyXPlxag82D89BpUGTriz8ZUnW
 CVEq0g1yAsNd19Ws0VH6kFuXsqpx1CMUxDDeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704299526; x=1704904326;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jrnFlq3WzJ7E5rmvtlT/0PV/VV2iMFOCKXpIUUuO6x4=;
 b=MJqE1aXB4a9nRNrgIA/CqF2zDhg+q9Hs8plaAxp2nMFEj48mAmc1dcXNa4vGJVv3tR
 Kv+tsyfXJucDqVKm8Eqr02Uel6pRb4X4nt8hnMwXIrK67Q7iWZXwt6FJblwuXOkpFPyV
 tqhqg6XSVYaNs+OaRt2YglwqBCq7to74pTO11pDRgJPGWrYRd6SAUFcCYPM/+ySKOC8C
 iPCJI1yse5vVPFP2Wt6frmmH1bZw+2YHkLRCi1Blk+nN9u1OZaYO5Y8ZChpj+SeK4IbX
 3zFR06pLhMyHgFNPSwMe6sWiemUiKYkFWg23Si/OmK0t4AvFYlZ3Bz089zg1kDC/VkzP
 03CQ==
X-Gm-Message-State: AOJu0Yzw2AASwONGf9uVc1UmUw5yVWzLIgdVFJf6e0P60hjsUyQvCAuT
 W39vtGZbjDf+67r35pq/2Nnay8W4kyhrXA==
X-Google-Smtp-Source: AGHT+IFWKVxwaXEaZqBekpJSGUmqMkZnZk4DvcRe9G0zx0/HwdeZJbCrrO7BVZtmWFo0ReFO9jPZCA==
X-Received: by 2002:ac8:5d42:0:b0:428:1837:bb8 with SMTP id
 g2-20020ac85d42000000b0042818370bb8mr8438346qtx.127.1704299525912; 
 Wed, 03 Jan 2024 08:32:05 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 y8-20020ac81288000000b004283435fef5sm1402465qti.34.2024.01.03.08.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 08:32:04 -0800 (PST)
Date: Wed, 3 Jan 2024 11:32:01 -0500
From: Tom Rini <trini@konsulko.com>
To: Rob Herring <robh+dt@kernel.org>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, sjg@chromium.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 ff@shokubai.tech, daniel.thompson@linaro.org,
 dgilmore@fedoraproject.org, pbrobinson@gmail.com,
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
 mibodhi@gmail.com
Subject: Re: [PATCH v3 5/8] doc: devicetree: Updates for devicetree-rebasing
 subtree
Message-ID: <20240103163201.GL1610741@bill-the-cat>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-6-sumit.garg@linaro.org>
 <CAL_JsqJ9Y1XCefsiCz11v2Lyk27g5ACMXO4qiFCEHSb3ZqyKhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zg749Kiew2EbbPCX"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ9Y1XCefsiCz11v2Lyk27g5ACMXO4qiFCEHSb3ZqyKhw@mail.gmail.com>
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


--Zg749Kiew2EbbPCX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 09:19:40AM -0700, Rob Herring wrote:
> On Thu, Dec 28, 2023 at 4:59=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org=
> wrote:
[snip]
> > +In order to maintain devicetree files sync, U-Boot maintains a Git sub=
tree for
> > +devicetee-rebasing repo as `devicetee-rebasing/` sub-directory. It is =
regularly
> > +kept updated with every new kernel major release via subtree pull as f=
ollows::
>=20
> I would suggest dropping "-rebasing" in the u-boot tree. (I wish we
> had in the original repo). I don't think it's relevant.
>=20
> We're not likely to regenerate the tree, but any clue what 'git
> subtree pull' would do in this case? It could happen if we switched to
> git-filter-repo.
>=20
> > +
> > +    git subtree pull --prefix devicetree-rebasing \
> > +        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devic=
etree-rebasing.git \
> > +        <release-tag> --squash
>=20
> I'd put this in a script to run. Documentation tends to be not quite
> correct. A script could also be smarter and figure out <release-tag>.

Since you had mentioned elsewhere moving the kernel scripts/dtc/ to
something using subtree, I do hope to learn some lessons from what you
do there. The first thing is that given the size/nature of the commits,
I had figured I'd be the one doing this as a subtree pull+squash then
push, rather than posting to the ML since it'll be huge and
un-reviewable, but with a note sent off to the ML that people should be
aware the next sync has been done and retest as needed. But Sumit, were
you planning to do some of this instead?  The second thing is that if we
move the subtree part in to dts/ instead (where we will still have the
Makefile/Kconfig we have today and then our Makefiles within the
directories, this might get more complex and so really require a script
to keep it from getting error prone?

--=20
Tom

--Zg749Kiew2EbbPCX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWVi/oACgkQFHw5/5Y0
tywF4wv8Cv8VwZUmNoNGn+CVaQS7mVoUPKfdE7jjURICGdCzyyr/VV9Y4OyK0wAF
9MbFtVq/xI357dY9MXVbo4oigm2b8g89P41lalE6xiNC+dtfGWhSsTANobLKhPXI
EdPe5NM/r7tETPIXAfonjJGiMY5ejjwernsDiJuOb/RCmEApbdcoE66lilc192T1
V667ITnZq4dlMXfhzCjZHPaHxc8ByE7H2hrZuPe75Kkg/XQANb9Lco9KWd8/fGhi
v9C8E50DXQLz83X+sYhQar9BxGaQGTqmKRTavqlACxSBdLw8VJnVcBBcG+OM+oER
QQvuyWHWu8NVMQaoskk4/RUTClRle+s1cq2hyrqV9LspJS0jpa0pYLTWfYCVW0VM
5JASAjJZH5qjuQEjB8q1mPo493RqZr0MaClwz5fQE2BMwXyJARID3VwmicoiqxN5
dsjI6LsXxxmaUeujGxccjNUYKpq83eU3L/zOtAD1Im4uWTmxVQHagLz4vAsiNkXa
V8jRTaY5
=/kID
-----END PGP SIGNATURE-----

--Zg749Kiew2EbbPCX--
