Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B15C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 13:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5FCF8783D;
	Fri, 15 Dec 2023 14:37:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O8BdTCLx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A273087BC1; Fri, 15 Dec 2023 14:37:51 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD3AB877E3
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:37:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4258b8632f4so5156481cf.2
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702647466; x=1703252266; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0EZ/0VjIUCC/Ubs0jS5M0z4Z38l/xUHRu3xx9c0SbXg=;
 b=O8BdTCLxmBsLBbcEdlIaUP56+Fde77BMRWD8Mbloji7Jiq1ICoI33Q9KvNA4ZEbPUh
 2NLFR6rzvyEIQhQVijbQ7jTf6+EDwyIVZuxQVFATtFg8WCTHqfdyy3O9rt7+VuRBPGmW
 OdMYjwwUK70kyNjDSmZs8R+vTVAZ1hsSF6FIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702647466; x=1703252266;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0EZ/0VjIUCC/Ubs0jS5M0z4Z38l/xUHRu3xx9c0SbXg=;
 b=IGZn90Xze8thiDy6hEkJ1n8s4AyH4kHCbsQciR7SI66LHQkpAXsWZ4PUzw6WniLUPP
 CCpe84opE0AUmffP54DXAvIwZw17w3JUvbEzaRsuSaIwNu339nfEkFkVSgXGQYiw+wrM
 zzWAy8zrtr7vkyxfl+QGZvVrIZv9J16cA8jmT6IGP44V+m4FpDlpjAnOY9IuvSW6WJ0d
 HQHsJzTChNBpiCsFTD/2Hq6d2oyG8gjvTPyFdAPf7L72zymNV7znFsMaKLS8DnQb9hRA
 jieWJ7ZHSDkC51RnmUvLZDLFIW6m7COQETWUb3OdCZkf66eZ5Dye6csaLXiZo6SB5C09
 QSsA==
X-Gm-Message-State: AOJu0YyxS43bkUKmmJQfNhiHKCHT32Cse6nJspl7HplqiTi03qvVQj+v
 syiI/ZvLLPSXG1v4ETpNncYI/w==
X-Google-Smtp-Source: AGHT+IHoo+ixhnCa8FwxDcBKSQGUyGr8UckHLVdhrhHTZqK7H2j68DGFbiwMYxEDLjG40VftLk1yuA==
X-Received: by 2002:ac8:7e88:0:b0:425:a282:71af with SMTP id
 w8-20020ac87e88000000b00425a28271afmr15748316qtj.35.1702647466577; 
 Fri, 15 Dec 2023 05:37:46 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-faf3-908c-f76f-32dd.res6.spectrum.com.
 [2603:6081:7b00:6400:faf3:908c:f76f:32dd])
 by smtp.gmail.com with ESMTPSA id
 o15-20020ac8698f000000b0042388bce404sm6677498qtq.57.2023.12.15.05.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 05:37:45 -0800 (PST)
Date: Fri, 15 Dec 2023 08:37:43 -0500
From: Tom Rini <trini@konsulko.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, neil.armstrong@linaro.org,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
 sjg@chromium.org, krzysztof.kozlowski+dt@linaro.org,
 conor@kernel.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
 marex@denx.de
Subject: Re: [PATCH 0/8] An effort to bring DT bindings compliance within
 U-boot
Message-ID: <20231215133743.GV2513409@bill-the-cat>
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <287883d6-ff1d-4172-bdab-476e880fa8b7@linaro.org>
 <20231214182328.GQ2513409@bill-the-cat>
 <CAL_JsqKTTL2jZfom2J+2Z_vLCS=LgZdaZ198-4yxZ-U1cW-hCg@mail.gmail.com>
 <0a143e84-5379-4455-b3c8-dc97beb9514c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="21xiOT0nItjqqunm"
Content-Disposition: inline
In-Reply-To: <0a143e84-5379-4455-b3c8-dc97beb9514c@linaro.org>
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


--21xiOT0nItjqqunm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 08:50:51AM +0100, Krzysztof Kozlowski wrote:
> On 14/12/2023 20:48, Rob Herring wrote:
> >>
> >> I think some of the important questions to ask are, how often / likely
> >> are the breakages to occur? It seems like these days it's either:
> >> - U-Boot had an early version of the binding and we already state we
> >>   don't support backwards compatibility here. It should be on the
> >>   maintainer to be proactive in this case.
> >> - It's a "the DT was wrong about the hardware, sorry not sorry it's an
> >>   incompatible DTS change now". This too is hopefully the kind of thing
> >>   that at least board maintainers will be more actively aware of needi=
ng
> >>   to deal with in U-Boot, if it's really a problem.
> >=20
> > A common issue in the kernel is with forward compatibility when
> > platforms add new resources from a new provider. Then the kernel
> > expects a driver for the provider and waits for the dependency. Of
> > course, older kernels don't have that provider driver and so the
> > dependency is never met. Not sure if u-boot will have similar issues?
> > At least you should/could know if the provider driver exists or not.
> > (The kernel doesn't because modules.)
>=20
> If some U-Boot platform decides to aggressively sync with kernel DTS,
> then probably the kernel subarch maintainer should be aware of it.
> Mentioned forward compatibility issue is a result of assumption that
> there are no out-of-tree upstream consumers of our DTS. I am certainly
> not aware of any such consumer for Samsung. If someone told me (me
> wearing Samsung hat), hey U-Boot now cares, I would start caring as well.
>=20
> The usual argument of contributors wanting to break the backward and
> forward compatibility, is "there is no other OS depending on this"
> (recent discussion with Johan about order of interrupts:
> https://lore.kernel.org/all/ZWcPZPX-eT-xHAOv@hovoldconsulting.com/ ).
> You need to tell the maintainers of that platform, that now they have
> other OS/firmware/bootloader depending on DTS compatibility.

I think this hints at one of the bigger impacts this might have.
Reminding everyone that other projects do use the device trees and have
for years. Without rehashing history, BSD does use the trees as-is and
for platforms U-Boot supports they are supposed to be re-synced
periodically. This series moves us from an ad-hoc method to a defined
schedule.

And presumably some of the Samsung platforms will get moved over to this
framework, especially the newer ones being submitted recently :)

--=20
Tom

--21xiOT0nItjqqunm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV8VqYACgkQFHw5/5Y0
tyyJ+Av9G1WKVyF/kaxNZ7TeWP9dfPnYJ991s6J3N7JaM+Vy1yZG+onFRsUXLpDe
4xQ/Uz61uuOpAEKQOiFuK6ekYuagB9bmSppddeKtqJQGNGz128lpR5F+aM9lA/NF
8ProVpyjB+aw7bw3TwNA0QBk5yU5J3ivPcDOHYWuLX8OhB2fROcQ1T52fjW/ZhXr
mW242RbqZ2IOwTjhjykLFUds272F8UtnwfOi9yvQTPN2soY0Rc7HD6XoxXzigYhc
Vk1PVhVN+k25q6fQabtx7vtfxf94bWnhmqSDbmFzkPH3CoSowo+07ZfmdcjXcP7d
q4RuEchp9CbqR4k2MlkHOWp2HZ+GgQwgLvukJB8RREa+ElyWVM2U34iGTc3RSE6+
rQfDzu3wbSd+uU4EX4pZSPO/RH4mxJunk8vZ2ckezc7aTkkZpYq2KvMnIrsxs5rP
UnOLjsI2arh541WWpJDTBw6/TStI4jNzQpWEazKl7fpjZRhncbGeqzBrXeuN/o1j
cjtmADsW
=mi18
-----END PGP SIGNATURE-----

--21xiOT0nItjqqunm--
