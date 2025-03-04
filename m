Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6D8C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 18:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3940580805;
	Tue,  4 Mar 2025 19:03:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NQkM4MKM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16AA7808A2; Tue,  4 Mar 2025 19:03:48 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB1E180805
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 19:03:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6f4bc408e49so53316187b3.1
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 10:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741111425; x=1741716225; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4XWLrx4OgBSiP/ovAhpQab1yt7tO8NZDoeCiJ3jk2/w=;
 b=NQkM4MKMAzign5xs5CvnpeHuMXVKcH0waGANHdHAxSQgr695AD0/AzADFReskosH4b
 /CwZ6kT/llgmKbNMTVGDhE6WPHGA3mlFxLkjVKIfFAW0VcM6XT2Vh6q95jyFXHdUqZ96
 T5/ODrttLLKbgRvwUrKr7wTboXVebPU7rTrtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741111425; x=1741716225;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4XWLrx4OgBSiP/ovAhpQab1yt7tO8NZDoeCiJ3jk2/w=;
 b=WA7lqVK9Pp9GD2KabXfsCgxGXbwhjU+BvzBuAjPZNmR5e5Tv7cWS5+ksqrX4U5VkEH
 nC7eTqcwT+xRn+gscuSX0ZiN2eFl0vbiNTvYmjF8Qln9j7VBAfQ62u0eJeegbt0teWmU
 Vmgws4DN4gw1L9oiPKJEof4ggREPFMW4MII3JC4bIPivo1n7SGNWsqV3So3a6Mw89Pdv
 ZPaQniJl/81ddJyrauTUbDnM0S3+0Bv3Ya0jmt6UlP7T4woSdfhdg6CyOSR3djdGmr0o
 DhIav213qOyNMPfBklZ/VRTUJwyaNWCSE2IJyzPGdvy/ba6YLR9zTP11NBK2hX/D3s/j
 rZ4w==
X-Gm-Message-State: AOJu0YyoeimOPUwdCRifuMulw5w1Wc2itwv/SI26IeWjBPfodewI3u9b
 Fl3bY48RCk8xDqgrnUNzWv9t3upa3a3/Y3wS+suFOEfGbs0fXlZVChJbdckjMYc=
X-Gm-Gg: ASbGncu6RxSiad9TFeF+IqutHaXtDKmswRrBrAD9kuBqSrCDiV8LVRolOoQmPFIF8OF
 o8Dylrtmfcs4tTKQ5Uq44TXLsMZgxisvSEhYxFrwG9B5h927ch7mrLOxWUcAAjuU/sHSrlppQ7e
 noYZRfv9Nb2Ran7kDksbZhiNrwvwVIXR0FUBY0xWJBgqoBofk7B5Kj76PYg7hkZYjXVBxXjIHqv
 pZUJGL2eZgOneqT4ztNOiGWORqWv2D6hMBYiYRVlkJomv1UJ0/GD1JIB9cG+qBzFRmpa7UGJtfs
 ZDSsaxMupJ/Ix4tlioB8QSDwvqFBLHkxbymyXYugFvI=
X-Google-Smtp-Source: AGHT+IHQlX+ccYo5o86cJh21ec9N+T3fJ76VsCRZfbjLGO11AmVyATPIASbqyUgzz8Kn/ngoRfcYGg==
X-Received: by 2002:a05:690c:6402:b0:6fd:4780:6d14 with SMTP id
 00721157ae682-6fda3036b32mr3704737b3.20.1741111424748; 
 Tue, 04 Mar 2025 10:03:44 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3cba16a8sm25469047b3.111.2025.03.04.10.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 10:03:44 -0800 (PST)
Date: Tue, 4 Mar 2025 12:03:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: Re: [PATCH] lib: ecdsa: fix prevent memory leak in
 ecdsa_add_verify_data
Message-ID: <20250304180341.GH2640854@bill-the-cat>
References: <20250206214758.353228-1-ant.v.moryakov@gmail.com>
 <174106331644.1753567.4740910842414947988.b4-ty@konsulko.com>
 <edaaac09-22e5-4d6b-90e0-16f672206255@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xddr1teh1OWpIwdp"
Content-Disposition: inline
In-Reply-To: <edaaac09-22e5-4d6b-90e0-16f672206255@cherry.de>
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


--xddr1teh1OWpIwdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2025 at 01:37:21PM +0100, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 3/4/25 5:41 AM, Tom Rini wrote:
> > On Fri, 07 Feb 2025 00:47:59 +0300, Anton Moryakov wrote:
> >=20
> > > - Ensure `free_ctx` is called in both error and success paths.
> > > - Fix memory leak in `ctx.signature` when `do_add` fails."
> > >=20
> > > Triggers found by static analyzer Svace.
> > >=20
> > >=20
> >=20
> > Applied to u-boot/next, thanks!
> >=20
>=20
> I believe this commit is not doing anything at all, especially not what it
> says it is doing.
>=20
> I believe this is a false positive from the static analyzer?

Yeah, you're right. What we had there before was written more compactly
than required, but this ends up being a no-op to the compiler and just
easier to read code.

--=20
Tom

--xddr1teh1OWpIwdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfHQH0ACgkQFHw5/5Y0
tyx3Gwv7Bc+Wjlyr5AIsccHh9bUyeuiOjTKVwrwrCHU1vbpZYAei1aXrjePJnxwk
6jBmcGAtwDJkkCiOj96Olg07kpYvlbZrshf3NyvEkGAVaHV7XCHSl6qqDy7sUzCF
u14LrF/CqAM+D9Dqe2jPxhXOcYGulrkByYg2exkf01I+dn5mDTHjMKEiKJuM897B
u5cU4bMMV8/qTeMQZiuKHp5Z/YfcRirP6jawIjVMoCtbZv4P/ySVMy+MyMxE1jr2
ttjZor8T2GgQOibhHMFMAGQ5/xFl9KMR3R5XJ3Cn2T6X9yPzMbI06ayLdrWXrNwp
YYQINTOXK+FzCx1hfLYJyToirhAz00+vzQHFeZCxfg7E0zZNGGFkiElrxs6gL0ow
iRtW9P0yuWWiCqQVJD9EGYrmTh3Bu75PMuLRd6TB1x/fR+nu0san0LrY4OJ1pC+w
86+hayks0plEHxKf45DhSKaM/FYz78O2KwTRfha1N67DnI76YD6M9NzAvomYi75/
uIJK/clH
=KmB4
-----END PGP SIGNATURE-----

--xddr1teh1OWpIwdp--
