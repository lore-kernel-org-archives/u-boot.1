Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0DEC77B7C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 18:06:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AED0C82D83;
	Wed, 25 Jun 2025 20:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WU571I/2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9042E82D88; Wed, 25 Jun 2025 20:06:27 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FD2182CDF
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 20:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-408fa4be483so140445b6e.0
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 11:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750874784; x=1751479584; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1gX+ww3H58VKexECfYitQ/L7HySyJcsOW/YIumAb1K0=;
 b=WU571I/2Tq1Cf90OTsZyzd+BpVueiq03Er78+WP+elFFV2ySbZh1ECbNgEfjKW6hy5
 itlA9ogP/i4e1R9yJ7lHBIxlvr86lNTrFD7QJaKM6/xpSpQahyD1T6twC4dHfNfxUGeb
 JE50Hu4qY3hEjVxh8ZGjxL3FdW+ih8G55w2kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750874784; x=1751479584;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1gX+ww3H58VKexECfYitQ/L7HySyJcsOW/YIumAb1K0=;
 b=Hf7PMD7P59j+SXe7t/UuCFY6b5/BjHP9FqCzgBaivNrvW9bRv6JXo7SRUCEcaOyRIF
 4PRXOMynGKluFlu+NefNPiJ7WdJkAyEk8KEJboMUtU8BC8lTqGZXgzjmG2xINR9oqLzj
 qaGmzU7uWosJWUBa0kyN6V9kYLIPblFdORGgOQbNurIR7F0CUdr3/sqLSJCl8Tfbmu13
 NUkhgCpeHGoLYPfQMybEQsupIgitBkkTYQrozG2Yq1S/luCLQzkllHv1Gy8phF5T0wMV
 eivB10CIJ+dTdnBFntyoQ16N8OVF347kWKLrGVRGPv5eEN+KJHD/2ThdxrjKNUH9rHee
 Q9yQ==
X-Gm-Message-State: AOJu0YyhkzPkr0Z2vjea3o2hsXB9tgLFSzSrXt6kmucY99i2LxykNmgN
 EhlnWlYxpyz7IiH/KNhlknFNXvywY85t8K10oT2WI/t8kn2Tt33f4MbHdeYiT1OZryrMiKVYXwv
 hsZJBClg=
X-Gm-Gg: ASbGncuN0f1sB/+BBdhgVzuCQTs1Yt6wfASr5OK8sWrxi06/fZkW2md5Ys2oa+A4JUj
 WMJ8eC074MZE/DVHPhzjudgKichH1Y+P8vyMuHJHRPms+kSvpayDVGE1vv40UtqszmjkQKc2iSI
 rjsntMJBtdyEG9HGrBJzx9uVAPbx7qNfZo07isZtuC9d/TRgEKJU7kQkZQFs4Kc1wQbUKfgtV9M
 tybNsvwR49PAi/vXqDt/D52ll0iGJocEnYIugpcV8ELGIMoqjiIB1H6mXIr6nVdNf7nI9A4xZzO
 yhACey87C8kUJt4qzMAFRv6jp9VpoegGVXIJVRpX+YGZ8tf0d3iX+TzrVXoLGXGJkN77cmVTfCf
 MLvO0tgf2uWv0D915jw8cxdo=
X-Google-Smtp-Source: AGHT+IEKGOAvJUhwgI7fyVBudP/rnKGhA2V+/jZYLm8cqskMfPc55M8Ihm8Qw/gcVc5psBdxQJOnEw==
X-Received: by 2002:a05:6808:11cc:b0:409:f8e:7296 with SMTP id
 5614622812f47-40b057ae183mr2702008b6e.0.1750874783515; 
 Wed, 25 Jun 2025 11:06:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40ac6d3b8c5sm2256918b6e.48.2025.06.25.11.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 11:06:22 -0700 (PDT)
Date: Wed, 25 Jun 2025 12:06:20 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2025.07-rc5 released
Message-ID: <20250625180620.GT4003484@bill-the-cat>
References: <20250623201040.GF4003484@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V3dLfXK+UkKerYu5"
Content-Disposition: inline
In-Reply-To: <20250623201040.GF4003484@bill-the-cat>
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


--V3dLfXK+UkKerYu5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 02:10:40PM -0600, Tom Rini wrote:

> Hey all,
>=20
> So it's release day and so here is -rc5. I will be merging this to the
> next branch shortly and pushing that out as well. As the next tag in
> two weeks is the release, anything now should be either a clear fix or
> clear documentation updates.
>=20
> I also want to repeat the link I sent out last tag and thank the people
> that have reached out so far, but I hope we can find more support still:
> https://lore.kernel.org/u-boot/20250602222738.GC100073@bill-the-cat/
> In short, I think for the overall health of the community and the
> project I need some help from others in the community, on not strictly
> technical matters.
>=20
> We're continuing with a community meeting following the release and is
> the same time as the previous meeting. The meeting details itself are:
> https://meet.google.com/btj-wgcg-euw
> June 24th, 2025. 9am (GMT -06:00)

A short summary of the call is:
- Quick overview of the rc5 release, and note that I need to pull in
  fixes still for something I had just pulled in that fixed something
  else.
- For the next branch, we need to resolve the thumb interwork problem
  with LTO by splitting functions to assembly files as soon as possible
  as the size growth is a problem.
- The patches from Ilias to fixup the IO accesors to be correct for KVM
  on arm64 should be merged soon. OpenEmbedded should be able to take
  this as a backport once that's done.
- Andrew Goodbody brought up the smatch thread he started and in sum,
  I suggested that it's best to post fixes rather than bug reports as
  many things are quite old.
- Ilias talked about the Kbuild resync to 5.1 that he posted and that it
  also disables a few warnings for now until they can be resolved. I
  agreed to look at the series soon.
  - Follow-up: I looked at it yesterday and gave him some feedback that
    needs to be resolved for a v2, macOS is looking odd in the build and
    a few flags we should keep for now were dropped and have functional
    impact.

--=20
Tom

--V3dLfXK+UkKerYu5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhcOpwACgkQFHw5/5Y0
tywDcgwAg1picstrboIKIVA7js2lnnG6ByGd4meiFyjmO0ufxrGKBDAh+RGPR9N9
5GCvy2zINaLvAziPa/3I8sr+j7inOclzc4hrE0YbO7KdVaIRTx2hQ84LHPoXSuPq
oBjhMAiG2d2QnNspNjeAtQv7+HpHGrgsK8ieCHL5dBpLRIe3Sm60TNwyHmtkC5kr
8pqcD93bUm7VgZnnk7TMMs2aGyzAkAEv4fvIaD9h3yT1wmcu05iqnZobtupgWQQl
4zFPJZ1jDZP2s77Bn7AYugoc3iqR6rk7kOrXjxPvz+LOl2E9lmpfl9RlRUZeym3g
OhOYtpbwQeXRDQ8nm5indoIkmG8YpEX5wMMKpj1nc8kkVrIzRquSxJXW1iJR828x
gGoGaMKNU0NPFVLMnyNjmP5jEVCx3i37kctppYKL1G2MeALCKDqGWAZjnFud4Vi+
0mjlSYQZc1rizbtaDjKbtVtmTnS32JVMr8VqWLEqspjUGNldUn0wg+jQBx9sDOz/
NV1i7Jts
=hZZy
-----END PGP SIGNATURE-----

--V3dLfXK+UkKerYu5--
