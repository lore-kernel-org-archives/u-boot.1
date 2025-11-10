Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5526CCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 16:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BB8483A32;
	Mon, 10 Nov 2025 17:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B4qn2pRL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3C9183A41; Mon, 10 Nov 2025 17:47:58 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A672F839D6
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 17:47:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c707e11e01so1320428a34.0
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 08:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762793275; x=1763398075; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nWesKivi+BvLf7A9GqPZB29jYSOYZwrQZUgORdgqHpo=;
 b=B4qn2pRLn9StdgbzJo9wDrP7eisKCVkRZ2oWOk6njaaEQiLv2KvBYGVTHL0i8G6NaX
 rHJPZhqaD1cnkDBehmRy2dx90sZZwH3rciJLegXZMLbBhLr/YEophhbT44H9QyYsTj0C
 mhtD6fOAf3+JQV2X1NmOpPKIrkbl0oy58CRBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762793275; x=1763398075;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nWesKivi+BvLf7A9GqPZB29jYSOYZwrQZUgORdgqHpo=;
 b=VhevxsVUA/5DGV0TiYhWUGuPM/giGuu5IP6y1rKj80REeEbhZFg4VRDEIFzva/fxj5
 1lehWattyir8byIyE5cghdclt9uUHq8LA3XkXegC+nNLWfud9eQyg8ZyRjCl7r9xq65Y
 iMdrLuY1/8P3hA7dyw+ELclXAQlOGRAcVqS6EqJ6UGjcxOhOe44lJ/3gv5s/bElYMVK9
 c+tQ7jGeotzcig6OPUECHhepSGVO4Y8VnMMGfCqDI3idHtJNulWKrOj5naqrCYvZL4op
 +hMgjRPhn37R63UjQLYDQBqqs3X++3DbNhyBhF8fClTySIkB4KfQkr5gkZljH4LO9jt3
 LaWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+VrBgDvsTHodP0jbJgRG7mnRpyuDpuBCC6e1TiEA5ZyGWjIf0suMuQ38BLJWYty6qmCwt5aI=@lists.denx.de
X-Gm-Message-State: AOJu0YzI7cc3DkCJzB7aFaVOK2ze1nWdPpnkrLuJb3RPcybvILTDXJeo
 nrfMZ9tqRdBsGcSm5mZR6sGBIYIbp/j6yDpo3cBTgXK0QMebsfwjqC7qaao1Hvb0LAs=
X-Gm-Gg: ASbGncv3JM4iKMoAkLWIo25kg5zhv3Zi37X6B+y2X0XEEmMeYFdFlmIAqp9/vP6gxrp
 sPTbeRgCdbTOHxBFfFpyq2W/DvBu4p95aIdMIzPZ7/7QGoKy7QyBcSInBVCVx75J94bGiOyOQWe
 jNdbAg6gA7VHoDyY/VUHDPL48nTlS0ibCvStThOPxSaFoeP+3zdqQiBmslmx3q1IREHLbg954Gj
 2KkbKlwlAVuYJXOPJmxs4QnaliBmZKQYkWDh59Su4Yq7epOd/z/dqdg9ehxhBr40TtG6BgO9TJP
 uR14CGey+ypC6bQ5qufmuwCv4oYeAgG8r1VsZyZX82IDVUCCwQXST5IFwRLraKQU/pqs8wsJZwh
 mBdO/rvaR4VS9Fd0OkEry90ywBB/e0ZHX9ARTJhT0KQcDt0EXF7Qcz5/sXApMX5tP4sya0YFh9+
 5gp9Py0/sqEmnM6q1MZVOg7GD2vJPQrivvv8KvU6HlrMm/70pARQ==
X-Google-Smtp-Source: AGHT+IFbKJ4o2yYbMVRJnMwzr21NzDM9cDfYdBzwyrKi5aqSmZSS+1KSm5ghLPFukCZ42XyhRFX/rw==
X-Received: by 2002:a05:6830:2aa7:b0:745:4f2e:4508 with SMTP id
 46e09a7af769-7c6fd827f5fmr4245042a34.36.1762793275374; 
 Mon, 10 Nov 2025 08:47:55 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f1132123sm5834099a34.29.2025.11.10.08.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 08:47:54 -0800 (PST)
Date: Mon, 10 Nov 2025 10:47:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Sam Edwards <cfsworks@gmail.com>, u-boot@lists.denx.de
Subject: Re: [RFC][PATCH] kbuild: Produce diff between base DT and U-Boot
 augmented DT if DEVICE_TREE_DEBUG=1
Message-ID: <20251110164752.GL6688@bill-the-cat>
References: <20251106210826.371672-1-marek.vasut+renesas@mailbox.org>
 <417e1b1a-0346-4297-9a72-7befc5b94311@gmx.de>
 <537299e3-05a1-4ff4-b594-9c73ed41a0cc@mailbox.org>
 <20251107155650.GE6688@bill-the-cat>
 <4b14ce54-6ba0-4e35-abad-6787b2d994fb@mailbox.org>
 <58fe0639-d545-4573-8e6d-1990ff416027@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z1246teUDhjw0Jor"
Content-Disposition: inline
In-Reply-To: <58fe0639-d545-4573-8e6d-1990ff416027@mailbox.org>
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


--Z1246teUDhjw0Jor
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 12:44:31AM +0100, Marek Vasut wrote:
> On 11/7/25 5:44 PM, Marek Vasut wrote:
> > On 11/7/25 4:56 PM, Tom Rini wrote:
> > > On Fri, Nov 07, 2025 at 03:06:47PM +0100, Marek Vasut wrote:
> > > > On 11/7/25 10:12 AM, Heinrich Schuchardt wrote:
> > > > > On 11/6/25 22:08, Marek Vasut wrote:
> > > > > > In case DEVICE_TREE_DEBUG is set, produce a diff between
> > > > > > the base DT and
> > > > > > DT with U-Boot extras, to show how much does the U-Boot DT diff=
er from
> > > > > > the base DT. This is particularly useful together with OF_UPSTR=
EAM, to
> > > > > > minimize the diff between upstream DTs and U-Boot DTs.
> > > > > >=20
> > > > > > Example usage:
> > > > > > $ make r8a779g3_sparrowhawk_defconfig && make DEVICE_TREE_DEBUG=
=3D1
> > > > > > $ cat ./dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dt=
b.diff
> > > > > >=20
> > > > > > This still has a downside. Even 'dtc -I dts -O dts ...' applied=
 on
> > > > > > base DT and U-Boot augmented DT can produce different phandle I=
Ds
> > > > > > for the same node in those two DTs, which results in a lot of n=
oise
> > > > > > in the resulting diff. The only way I can think of is to patch =
DTC
> > > > > > to emit full paths in those phandles instead, something like a
> > > > > > phandle =3D <&{/full/path/to/remote/end} ...>;
> > > >=20
> > > > What bothers me is ^ this part.
> > > >=20
> > > > Hello Heinrich,
> > > >=20
> > > > > Without documentation developers will not know about the new feat=
ure.
> > > > > Could you, please, add a doc/build/ change in the next iteration.
> > > > Sure, although I am not convinced it should go in in its current fo=
rm.
> > > > Please see my first line of comment.
> > >=20
> > > Maybe we put it in the u-boot-extras repo for now as a standalone
> > > script, so people can be asked to run it and look at the output?
> > I'd say no, because the output is full of noise unless the phandle non-
> > resolution gets somehow improved.
>=20
> If I run this with "DTC=3D/usr/bin/dtc make ..." , then the phandles are
> correctly retained. This uses system DTC 1.7.2 instead of in-tree DTC 1.4=
=2E6+
> .
>=20
> Is there still any reason for us to carry our own copy of DTC ?

I think the answers last time came down to needing to first re-sync the
dtc flags with upstream kernel again (to ignore new things that won't be
fixed), then possibly fixing at least any big scary warnings that do
exist, and then we can just document and use host dtc. Dealing with
pylibfdt may have been its own issue as well.

--=20
Tom

--Z1246teUDhjw0Jor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRIXMAAKCRAr4qD1Cr/k
CvgyAP9yxqlLuWVKjY0O3lnu+S0yymqUugFClXHiPDBVplwerAEAiuWsalfIxE7l
2wO5nont+7VEC/APAPRKFxaRK+ewgwg=
=ZIlz
-----END PGP SIGNATURE-----

--Z1246teUDhjw0Jor--
