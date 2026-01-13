Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA65ED0C85E
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 15:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ED20800AE;
	Tue, 13 Jan 2026 16:00:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nR3jQC+K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E31B580325; Tue, 13 Jan 2026 16:00:23 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFB1A80050
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 16:00:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-65d132240acso4671759eaf.1
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 07:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768316419; x=1768921219; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EKGtZiQ2KxrQlbM3C+uLzZ4u1LKvl3P60kYWbjes51M=;
 b=nR3jQC+KZrXnEEIs18x50fGMWLLgmFo9vb4EhNLKUhTqigZXSeJWOby8GdvLiHjL6j
 5tbxtTo9T1qrNiQlKStHMtXFDmFbkPJi2wlsqO8Ln6kZD5kGvkwBFlG3u2GK9y3PV6iE
 5FLB+p8rwmYxAedDPxgiXNJ9hEI6QFqDUY8SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768316419; x=1768921219;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EKGtZiQ2KxrQlbM3C+uLzZ4u1LKvl3P60kYWbjes51M=;
 b=VJkSE6NNXnA9z1UwT/YpPP1zzCRkY9h3H5t/ox+supEWziQOZKXinC2yeARGL9nXcE
 I9qSSfJAB9NlIXvY+vrim2fvmZxJwUeBFkR6kw37OXXue9XULIQumHwvopC1QLhZ6b0Z
 44VjHHPrE8eHKXBcNQPC2oKw0XSVUpceOOLvttO/5rzjH1e8NbaNeK3CWB7p0ot8RsEV
 2/z6KGZPqFuPDQoYWhy3IyuYTR7O/9PCejJrL0NeVm7uVeumTWCAvFHOu0X531S3kbHh
 XlzhzGKee4BUUwY4qnrIF+KKTuwxKXTDXDkJv450oIO/j9p0NrFxXhycK/JnXlJotu6M
 8qdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUihw9QpVY1i1ZhXPUCRU7LFu3BLV5LRGXeNEVLGPdYmQhOBoDkz8gMZsvV1mTdPJ9CxAOVCyo=@lists.denx.de
X-Gm-Message-State: AOJu0YyaPX6EyuRJzi7JHWX594t9JjFcU8UbJdDdHz+AheJVQY/dHr8m
 SWnuOgPyTSMzGu3jItc5Nv415hSvLsG4Jdk3eT4RCO4AEmnlXMy/JVXs07/WS30f6oU=
X-Gm-Gg: AY/fxX7LLs2CdjCTd6ENkg3ZcS/2Vksbm1zoPjs169VrwiRZ+1fL+IsBsDa5tSd3n3X
 fk820r0ocDTYCYpCLliyFOndFk8UzmrD+v7s/adcf6LrYTjIihVLr1PHjoQqPaRvngX2TJiKc5H
 USbQPkzGRVOj2Tz2bNOV8rwRtoblNtO54Zz3D6VA9GiuLg5Hmid+SZl0A7vz59AD3DR+c3KH8/r
 c6iCOQaXgDfE9YD5KV5pIBHy9xj+DqQGQIdROZqdCCW18Zh0IlFyuhEKJGd+TodJOZa/fRJXDuC
 a4YUakJDR4XgIcel0+kcNjKzKL/4ehhxfbM/8oyiDkIw8MO1DntJuPUsxbYeCQdW4xnPXuDx7Ym
 pzVy5kwH0vCwHGiAfxxeGGFQYwpAh3YS9Eqc38gHk154WBkiL8DYdUAFvyV+1NftUbG9s262EpS
 lKqvxWzjhwdrpzo4y7B/kl49HAZ7djDCxPEoLLYPgtMi45Fmf9pNNokNtfPiBaIinZSidJeoxbn
 mnpG33HKheuynmNsuQVMirB2b0tWc+zeAcmiF8=
X-Google-Smtp-Source: AGHT+IFKwa8SaJXDdrpid7pQOULw3KFNujCARO8jo0E99HlutKsa1g86C9f4Cw5uq8ifBYVO9ZXMEA==
X-Received: by 2002:a05:6820:440c:b0:65f:6667:ca54 with SMTP id
 006d021491bc7-65f6667d15amr6589484eaf.55.1768316419450; 
 Tue, 13 Jan 2026 07:00:19 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48cb131asm8863486eaf.9.2026.01.13.07.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 07:00:18 -0800 (PST)
Date: Tue, 13 Jan 2026 09:00:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: "Padhi, Beleswar" <b-padhi@ti.com>, ilias.apalodimas@linaro.org,
 malysagreg@gmail.com, sughosh.ganu@linaro.org,
 philip.molloy@analog.com, james.hilliard1@gmail.com, anshuld@ti.com,
 afd@ti.com, nm@ti.com, vigneshr@ti.com, n-francis@ti.com,
 u-kumar1@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] scripts/Makefile.xpl: Align filtered DTB to
 8-byte within multidtb.fit
Message-ID: <20260113150015.GW3416603@bill-the-cat>
References: <20260112101102.1417970-1-b-padhi@ti.com>
 <20260112101102.1417970-2-b-padhi@ti.com>
 <9257e248-512f-4c42-999b-0f8c4f0f92b7@mailbox.org>
 <2854b18c-324f-4052-a6e5-538df6a0bcab@ti.com>
 <a799f9d0-e369-4ccf-8c64-60623143ca86@mailbox.org>
 <20260112220323.GT3416603@bill-the-cat>
 <e7d8161c-789c-4d44-af2b-19bf69f4eb12@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zfGxjpsuEMf7VXO9"
Content-Disposition: inline
In-Reply-To: <e7d8161c-789c-4d44-af2b-19bf69f4eb12@mailbox.org>
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


--zfGxjpsuEMf7VXO9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 12:53:39AM +0100, Marek Vasut wrote:
> On 1/12/26 11:03 PM, Tom Rini wrote:
>=20
> > > > This we can fix in the Makefile via the dd command as suggested by =
Tom.
> > >=20
> > > My concern is about LEGACY fitImages (means already generated ones), =
not
> > > newly generated ones.
> >=20
> > Why is that a concern? If it's a legacy fitImage for the OS, we relocate
> > the device tree already normally to be aligned. If it's a legacy
> > fitImage of U-Boot, it's an old U-Boot?
>=20
> Not necessarily, it could be new U-Boot using old fitImage, for whatever
> reason (falcon boot maybe ?). We should not break that.

If it's falcon boot then it's the OS case and we relocate it before
passing on, that's not changed. That's why I'm saying I'm not sure
there's a legacy case to worry about, since the big change now is that
U-Boot also demands correctly aligned device trees. The Linux Kernel
essentially always has, and other OSes probably as well. We were just
bad and let 4-byte work for so long.

> > > > > - Should mkimage -E align blobs to 8 bytes by default ? I think y=
es,
> > > > > and frankly, I thought it does so already, but apparently not.
> > > >=20
> > > >=20
> > > > This can be done, but should it be? Not all FITs demand an 8-byte
> > > > alignment right? It is only the FDT which requires this.
> > > Maybe if image type is flat_dt, it should be implicitly 8-byte aligne=
d then
> > > ?
> >=20
> > Well, the device tree spec says 8-byte alignment.
>=20
> 8 byte alignment of what, start of DT, right ?
>=20
> > It's not "FDT for OS"
> > that's 8-byte, it's any device tree should start out 8 byte aligned, and
> > everything else should then be naturally aligned. If we're looking in a
> > device tree for another device tree to use in place and not relocate
> > then that second tree must be aligned.
> >=20
> > Or am I missing something?
> The discussion is about mkimage -E which generates DTs for U-Boot SPL use.
> The DTs in those external data should likely be aligned to 8 bytes by
> default, i.e. implicitly set -B 8 (they don't seem to be right now).

Right. So the only legacy case I can see would be using an old mkimage
to generate a current U-Boot image. And I'm not super sure that can
happen, outside of some sort of external to us tooling being wrapped
around things, and at that point we have little control.

--=20
Tom

--zfGxjpsuEMf7VXO9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWZd+wAKCRAr4qD1Cr/k
Cn0FAQCnXEaC86pgMCWb3VbZN8gulGf34rmAVNczctzBpFdNeQEA41Yc5i8WiCwA
TqMm4RTCnlTFjXutv6NxA9zkoltchwo=
=sHZ/
-----END PGP SIGNATURE-----

--zfGxjpsuEMf7VXO9--
