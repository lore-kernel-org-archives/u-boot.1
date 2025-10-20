Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6280ACCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 15:46:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C358E82E34;
	Mon, 20 Oct 2025 17:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k7tW/dIF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95F1B831D5; Mon, 20 Oct 2025 17:46:16 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4677F82C84
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 17:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c278c25aefso4692297a34.1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760975172; x=1761579972; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xlS7qxqdZH53gvpbwJ0slMAoSDLR381mqeKJiKmWAw8=;
 b=k7tW/dIFcSEKDvLa4f1ZJbPUWFf/3AD1uZbrMpeDzlrW0ncpDBKCoDZnt8UP5DVONQ
 lEKw/AhsZUk9vR58OsecNUXxUHp5gmjLikcE2DdhBtcHcAyF4DIcPxPBanpNNIaL7M9H
 e/jOC64SylmKctdLhfwgNl8GHATTxI0A0SrjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760975172; x=1761579972;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xlS7qxqdZH53gvpbwJ0slMAoSDLR381mqeKJiKmWAw8=;
 b=bggD/DylD3KshGWtdVD/mDfNlDL7H39iSQCwI4vqLTalow3fGlDJKSvKzSRVAmd+wU
 BtUFFMSw9sITAMyTFzXEOq2TUNvWPQnZ7G/TPEbmfl+d8zJHX2ZC3eIGHe7yBJJwgvu9
 6ifRkv9vvyWH0dJ/kF3jGx55cE9Am2Io3kxM2q7O5C9i0WPf5aOYW/jPnCkXSpGa4Y9d
 Rf4PCq085FbGLALH0hpXAo1pEkGYfg3zwbOv7kHHywU5gYFirFcwmu+AqzPoRgj8VD7N
 htCfYxzb9f5fwUDUsBDOaBff63/VbK2ugsKmXrnaNlXaU1QnqB6wal70L58XQXc4dDX8
 oeRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCI6bdv3TC2o75xkiH2GCn10amAAf1qupwZwceAFMesqJwmKncRu3+HDKj+IXH5zhUCZiL8e8=@lists.denx.de
X-Gm-Message-State: AOJu0YzS9hfZKE8qal8egwxOENlBqbb9cz4lIFmo4gVeoKDymSC1cZOV
 k5YLrefVK/hvdQUtx2ThStHx7TA8WRFuBTOk8UzU6dGG7F8EmwlPJS1M8IgGuk4+HSE=
X-Gm-Gg: ASbGnctEdTKy9WHtRJ8Sy+xc9PXOffPZxX9yllKqGQibO7s+ZMkDmC7lwcc4TZrTyzY
 NT6u6EAgZaFOdYJZNrBKyLj3patnn0e+S4S3UnP5pHJiP3jkdkdp5HJet1bhSe+SspFsZxHxIwv
 UQK6hMPtaTvwXa7UegN9AceseznL2cgW9rFNRhP6932XwpLm0C/eBPeXFtuTn6IrhSMZfIcK/9Y
 VL76FxhSjylazVOMll4yQMAjQd3QO/WDdRr8nnyAb4NL5xFdnBBISwRIMwI8EGaQQviRGvM6t6G
 6xtUjKeFFYI4ov86DVatb4aUtxfYWeGI8XOGqBUByI0IyZ5ZDxMlwaaHnRIoDP3CkTt0b4+zlpZ
 v/fEeFVgDUG2LiQvvimvkGfX60+nuXe0vaRi1MrvntzEgEWrqPyJhzTnfo/3LamJKQwAwFNbYSj
 BL+qSTG/YntiSnANcKe/EQAdB/Cn1S6qzl2X/T4+0=
X-Google-Smtp-Source: AGHT+IE9n7QXHnj1rJfkwJb7ugqxygI1b8uKYJeZ0L1nopwVzfufvC1f+cUdOoMGlAiNu69cwyYnaA==
X-Received: by 2002:a05:6830:3c8b:b0:7aa:abca:b464 with SMTP id
 46e09a7af769-7c27c9c3e40mr5666071a34.2.1760975171906; 
 Mon, 20 Oct 2025 08:46:11 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-651d7cc4b60sm1834044eaf.3.2025.10.20.08.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 08:46:11 -0700 (PDT)
Date: Mon, 20 Oct 2025 09:46:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH v4 1/6] docker: add OP-TEE and TF-A build for testing
 Firmware Handoff
Message-ID: <20251020154608.GX6688@bill-the-cat>
References: <20251015141856.4168612-1-raymond.mao@linaro.org>
 <20251015141856.4168612-2-raymond.mao@linaro.org>
 <ea1e0cd6-48d1-4999-987a-38febfd0e70f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hn7egNLkN36WqDf1"
Content-Disposition: inline
In-Reply-To: <ea1e0cd6-48d1-4999-987a-38febfd0e70f@linaro.org>
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


--hn7egNLkN36WqDf1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 05:19:45PM +0200, Jerome Forissier wrote:
> Hi Raymond,
>=20
> On 10/15/25 16:18, Raymond Mao wrote:
> > Fetch OP-TEE (4.7.0), TF-A (v2.13.0), MbedTLS (v3.6) and build
> > bl1 and fip with both Firmware Handoff and Measured Boot enabled.
> >=20
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in V2:
> > - Move OP-TEE dependencies into the common group.
> > - Fetch MbedTLS/TF-A and build bl1/fip in dockerfile instead of
> >   post-buildman script.
> > - Remove Trust Boot related build options.
> > Changes in V3:
> > - Clean-up of OP-TEE deps.
> > Changes in V4:
> > - Minimize OP-TEE build options.
> >=20
> >  tools/docker/Dockerfile | 38 ++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 36 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> > index 5b4c75f8400..73c1589e260 100644
> > --- a/tools/docker/Dockerfile
> > +++ b/tools/docker/Dockerfile
> > @@ -122,8 +122,10 @@ RUN --mount=3Dtype=3Dcache,target=3D/var/cache/apt=
,sharing=3Dlocked \
> >  	python-is-python3 \
> >  	python2.7 \
> >  	python3 \
> > +	python3-cryptography \
> >  	python3-dev \
> >  	python3-pip \
> > +	python3-pyelftools \
> >  	python3-sphinx \
> >  	python3-tomli \
> >  	python3-venv \
> > @@ -227,10 +229,24 @@ RUN git clone https://gitlab.com/qemu-project/qem=
u.git /tmp/qemu && \
> >  	make -j$(nproc) all install && \
> >  	rm -rf /tmp/qemu
> > =20
> > -# Build fiptool
> > +# Build OP-TEE for qemu_arm64
> > +RUN git clone https://github.com/OP-TEE/optee_os.git /tmp/optee_os && \
> > +	cd /tmp/optee_os/ && \
>=20
> I would recommend:
>=20
> git clone -b 4.7.0 --depth=3D1 https://github.com/OP-TEE/optee_os.git /tm=
p/optee_os
>=20
> ...which will directly obtain the proper tag (-b 4.7.0), and minimize the=
 amount
> of cloned data (--depth=3D1 i.e., no full history, just the last commit).
>=20
> With or without this change:
>=20
> Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Oh neat. Yes, please re-order things to be:
RUN git clone --depth=3D1 https://github.com/OP-TEE/optee_os.git /tmp/optee=
_os \
   -b 4.7.0 && \
   ...
So that future updates can be just a one line change. An unrelated
follow-up to optimize the rest of our git clones to be like this would
be much appreciated.

--=20
Tom

--hn7egNLkN36WqDf1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPZZPQAKCRAr4qD1Cr/k
Cr+vAP4n/FwNOjM04I6S6baO2Lhs5tfRFJ/0q7eQzd3tAI82UwD/eAyfpAvxHF73
fwrk+5SRlcNuyMD888IRPMyfQXSGkwA=
=MYqe
-----END PGP SIGNATURE-----

--hn7egNLkN36WqDf1--
