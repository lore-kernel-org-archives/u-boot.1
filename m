Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A0AD340B2
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 16:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F3C784148;
	Tue, 27 Jan 2026 17:38:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sloEQP8J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B46618414B; Tue, 27 Jan 2026 17:38:51 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 818BA8410D
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 17:38:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d148db5fdcso2032308a34.3
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 08:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769531928; x=1770136728; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Yi72xRAww/5W3u1/1dm1mAmzQf1hn3UWkqfEv9xcWTo=;
 b=sloEQP8JfM3P6FvDOzzQ1Iql2kdTmU8sAh+rzW4NX+RjMUQ09rs7tuZC7ju4mB6m6Y
 DLi6ND94Nb5r3SiRKaQS2eeTu1d3BHCcxJA7GnRtBq5eW5V3lgIysUQeldbE6iEGszS0
 ubI29hBipuerVSKQDBFCrUtRwUKKUJZw5Oc0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769531928; x=1770136728;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yi72xRAww/5W3u1/1dm1mAmzQf1hn3UWkqfEv9xcWTo=;
 b=Yb+ecga1hQQ05PLzMr5wU0aKMy7KzxfwK7ZST/LyYAM9/GLaolx2B+x11ZspuQ39al
 +6+Nu2EzbRMdTF5PnAZCNInTxiFlJzsiBa/zOQPfsurGik9h+SvfTWdIkMJyxFnuRHse
 Yg5J5RGI7glTm1abkfgcUCKmEcGmFkCmOtaUK1ab4gsBdrMQdrxQ3PkDV9ZTpRdbdTlR
 jM9zxzFCPaIQAi15XxFDVOyMwMqQdtIhbi8z70JCFthGgV1WVL7kmmMP1+/RC0RjtRQY
 9XB761sa8xfwjERLYHGFyJ7AoQKZlrIArLGQFhF/ZehkipBZQoX+dbzqp/7E39neRmRv
 cVjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjPmKv9pyezz2h7F1jkpG7slyrB6fdQkSATzJaTU7LrMIsoitj8WZ+ptL7YLyIx9kFWeC5B3k=@lists.denx.de
X-Gm-Message-State: AOJu0YymYTgu9Im7W7p+GtoReJwtNHQWBFslwn2rXnq84k1XcoQeUoP0
 ZTd5NPe9/UbQIgoo4bUKz1XyMayZkaztKRafzgi9WyBEgUpkfoc9M8LbdU2UHruaOeI=
X-Gm-Gg: AZuq6aIgCMq9Pd8gmNu7X+kt0luGg42w44nq5VYGTFg0T1m0PycDnw9CB80rfXEIeJi
 u4GLTSVIE260vkp1HfdNjd++/szhXvNqhyWaYVzut50NF6PfbVIgT+7JPeT+AknTyk1VO2kCd4D
 V4st+Z/ysnYvTIjLnn1heBnY6oCOz6MXp4CWcnR942w8eWmjN3591Waa/0u3Vk+8RCtXFhjBEFJ
 vbOplydVjBM3lEsXUetiINySSwxDBOy3F/CbxsNuyIlP+64SZV5Lr13qk5Kt7LwlIKSscyMtCs8
 1ISIl807xIuieVLW435DMHJzjwJYjO05iVY45C2n01snVn7zRO0hXTXV49HjucuhJqG76/ZL4de
 G5SIG6mrV4pHEsSvT3BQn7ACZtFBd5p81BxUFP6s5H0RZ/jq/09AYg/uJymSMmYE0PzbUJiPHzD
 HQuAYvAPs3n5pxndwsCcHBzygbzp1+0vqFec6k67hDWDE5xRk66+0cTO05upFFMyJuPfu2A76Ly
 cwRzVipsjhaXlCEXlpyHl3MiDnsPglw0iv/Qsg=
X-Received: by 2002:a05:6830:3742:b0:7c9:5959:8de with SMTP id
 46e09a7af769-7d184ffda7bmr1112347a34.9.1769531928076; 
 Tue, 27 Jan 2026 08:38:48 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d18c829923sm106041a34.30.2026.01.27.08.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:38:47 -0800 (PST)
Date: Tue, 27 Jan 2026 10:38:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <sean.anderson@seco.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, Anshul Dalal <anshuld@ti.com>,
 Beleswar Prasad Padhi <b-padhi@ti.com>, ilias.apalodimas@linaro.org,
 malysagreg@gmail.com, sughosh.ganu@linaro.org,
 philip.molloy@analog.com, james.hilliard1@gmail.com, afd@ti.com,
 nm@ti.com, vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com,
 bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3] mkimage: Default to 8-byte alignment for DTBs added
 via -b argument
Message-ID: <20260127163844.GE3416603@bill-the-cat>
References: <1e1f2e09-bfb7-4c7d-abd6-25a79271f256@mailbox.org>
 <DFVWL63A8IDP.23PE1QNTXTMRU@ti.com>
 <6cb4957c-7178-4a31-aea9-ad78d6627c28@mailbox.org>
 <ab3a8a36-eaa2-4030-ba18-6c75647455b6@seco.com>
 <6896afd5-76fa-4b1a-abbd-0798f19185ba@mailbox.org>
 <785327c7-9d8a-4f5f-b792-4a1590796948@seco.com>
 <20260126225842.GY3416603@bill-the-cat>
 <f9310861-396d-4a89-b4a1-d67b9d6cae89@mailbox.org>
 <20260127160637.GD3416603@bill-the-cat>
 <b09e8fbe-1f5f-445a-a28b-ff6386a728a5@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="O3K7fvMiGP3I4Ftq"
Content-Disposition: inline
In-Reply-To: <b09e8fbe-1f5f-445a-a28b-ff6386a728a5@seco.com>
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


--O3K7fvMiGP3I4Ftq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 11:28:03AM -0500, Sean Anderson wrote:
> On 1/27/26 11:06, Tom Rini wrote:
> > On Tue, Jan 27, 2026 at 01:36:59AM +0100, Marek Vasut wrote:
> >> On 1/26/26 11:58 PM, Tom Rini wrote:
> >>
> >> > > > Some validation of "len" has to be done before it is fed into st=
rcmp() here.
> >> > >
> >> > > Well if you are concerned about lacking a nul-terminator then we w=
ill
> >> > > read at most 8 bytes beyond the string.
> >>
> >> Which is wrong, and trivial to fix -- check the "len" that is already
> >> provided to you by fdt_getprop() and make sure it is exactly length of
> >> FIT_TYPE_PROP before doing the strcmp() . Then you should be safe.
> >>
> >> > > The other thing that can go wrong is if we get something like
> >> > > "flat_dt\0extra data" we will match.
> >>
> >> This I did not consider. So maybe what needs to be done is compare the
> >> length and then memcmp() instead of strcmp().
> >>
> >> > > Surprisingly the closest we have to this construct is fdt_string_e=
q_. I
> >> > > suppose this is because most strings in U-Boot are guaranteed to be
> >> > > nul-terminated.
> >>
> >> fdt_string_eq_() seems like the best fit, yes , nice.
> >
> > Bad news, fdt_string_eq_() is an internal call in libfdt. Good news,
> > fdt_getprop() makes use of it via its eventual call chain. Which I think
> > gets back to what I said earlier, libfdt is doing the input sanitization
> > for us, or so many other places are more useful to exploit?
> >
>=20
> No, the check in fdt_getprop is only for the name, not the value (which
> could be arbitrary binary data including many nul bytes).
>=20
> I think the assumption in most of U-Boot is that the provided FDT is
> trusted (or at least not maliciously ill-formed).  functions like
> image_get_checksum_algo read up to 6 bytes beyond full_name if full_name
> =3D=3D "". It's possible to read off the end of the DTB if this is the ve=
ry
> last string in the strings block and there is no trailing padding. If
> we're really concerned about this (e.g. to avoid false-positives with
> ASAN), then we should just add (say) 16 bytes to the end of every DTB
> when we malloc it.

Yes, we rely on the sanity checking in libfdt, which I think the kernel
also does.

And no, I'm not sure if we care enough about all of these corner cases,
but if we do then I'm not sure this right here and now is where to
start. It should start with upstream libfdt to see whatever cases aren't
handled, and then what cases fall on the callers to deal with wrt
security implications.

Because I really, really, really, do not want to block fixing booting on
some large number of boards because now we're going to depend first on a
security audit here.

--=20
Tom

--O3K7fvMiGP3I4Ftq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXjqEQAKCRAr4qD1Cr/k
CnGYAQDmlZq/bDvkipniMsmIC6ysleIiYgoUeOFtwL+uY2J7QwD9EQ0AGfUajb5L
AOSBXT9K5U1rE48pUshAPXShiOr5iwc=
=s1e6
-----END PGP SIGNATURE-----

--O3K7fvMiGP3I4Ftq--
