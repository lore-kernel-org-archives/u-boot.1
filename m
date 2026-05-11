Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7184CD484A
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 15:00:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4399283CD3;
	Mon, 11 May 2026 17:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hNzOscbi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28CE383C51; Mon, 11 May 2026 17:00:45 +0200 (CEST)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94D7781E18
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 17:00:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-479d593a0c3so3780817b6e.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 08:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778511641; x=1779116441; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HZer0JJRs882jr3CqHezN5Jrys2caL4o3WEYEVsuF/o=;
 b=hNzOscbiJa/hlYcuVQBzz/bkS7pdCZsBm2rbTMXsX4P4x4QCBsm306QXXghEbYDMsL
 xSmOaHFOA/oMpDJMNXkTRzrLkJmnLId2EmV1l9FHmKxJun2fuYOxHQzX7hrQo2zfqh2M
 l7Rlr6tNHlXDvR3OY+Xw3foxnFt3dB7V2Vxu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778511641; x=1779116441;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HZer0JJRs882jr3CqHezN5Jrys2caL4o3WEYEVsuF/o=;
 b=kYhX3DDibD9gkmEIftYoZr7PUxUTSG/8t7qToZaQSYfe1FMOycIjqtwLYBhc3A0cc3
 FD03TkwVi946cFHYWf+gKtY7H7BY19Ykaj9xLzZw2NEYOcHIf1GbGDO289x9ZacbnxOj
 bgWnVjmDZDsK5eBnatYPKhX4tNNhXTCRDjIq0eg8PeVgAuLcOeTTVyc0giZlhvWSxyl6
 VCZb05+eIRBiq00f1q45GWTrD0tUG5uLDVhAoZWbeQYCeGSb0WY1+Gq5l35eHA5jD948
 I1OcasUSNoaUJrz1wXr0LkwS+58aZnTyiUyEK02MI2fTca4q+4KC/eEmqwkLl/t1ksSv
 BAfA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xy0V27xV5/rh8F9PrlrNcml/XRNrVAGQxjqtAsbHo/KhJk41xqV3nd7tBTLUACBKQrsDjrUI=@lists.denx.de
X-Gm-Message-State: AOJu0YxQcPGb4OFtcYcsrOzLIIv8KjsAo5wbiuK40Su/gIaALO41aXs3
 x/OwUbPELDABhl7jXfsGi9Xmhi4XfTeRgUYPYNml5reDKWpSbZ13K8fzd8fGlFbAozh9D3a8kc+
 Z8lCSmoxhXrtNrcc=
X-Gm-Gg: Acq92OHCAjs1yHcPF9VNOozLb6GkDl/gj0FHrNAw2RQZWjA9E8+QOt1ihnnmbQWVijQ
 /rlt1CQcYKUZkf5Akf1rQwG/tnUK8ZVY4vxUC7jLpxb2KhLblhbqAly4xLFWJQ3BhUFUgLvQ2sV
 bmy94X7GkVWeC/tbl6Fw4mVLNZBKqVQ085oNdkMDMHG/IrDXHmoqZErgCqmpHqTOWtIQ4XAFfk0
 pmq+kFbzMrDAzMSRksnmAN+F6wipCWE+/OEQfEmq7nvxpX4Bk1woVXa1PSIO9uAwdeHgFkB6WgI
 /RKmqC8l1p40kIHyjwQMBn96fbxLuM1yS2gDLi52fVzS8rVnq49LKeKIulRiH57z5jyPGAscQPX
 HxH3PTRSYJga0a3BjHEvgtGQa+XC8QM6LwACK9gk7KmCBjFloebN2sONLQdJcXKGFqyYMOaRR6Y
 0LkCqSM/t4iLvTV/ULuNSbAa2tWYY8Anq2VxqDaZjBL/Pttl5utoRZCpCbLZjFoLdsSbB9ELirF
 ZhqNdQikD2FGh7puBJnWljKleJrCmW8/ln4h4f5aaVpaSQK8tkKm6HAnWGagg==
X-Received: by 2002:a05:6808:3509:b0:463:a42c:503a with SMTP id
 5614622812f47-48061be33bamr10149774b6e.14.1778511640970; 
 Mon, 11 May 2026 08:00:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76986f9dsm20651377b6e.16.2026.05.11.08.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 08:00:40 -0700 (PDT)
Date: Mon, 11 May 2026 09:00:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com,
 sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH v6 0/8] Add virtio-mmio support to m68k virt machine
Message-ID: <20260511150038.GH1858239@bill-the-cat>
References: <20260505074948.2603870-1-daniel@thingy.jp>
 <20260508192952.GA1948090@bill-the-cat>
 <CAFr9PXnAt2y9-yRqmTdUmn9CHQHZ3HjJ=MWeW6Mi4MxHRx9ivw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0WnhQ/PlQD3D022W"
Content-Disposition: inline
In-Reply-To: <CAFr9PXnAt2y9-yRqmTdUmn9CHQHZ3HjJ=MWeW6Mi4MxHRx9ivw@mail.gmail.com>
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


--0WnhQ/PlQD3D022W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 05:50:40PM +0900, Daniel Palmer wrote:
> Hi Tom,
>=20
> On Sat, 9 May 2026 at 04:29, Tom Rini <trini@konsulko.com> wrote:
>=20
> > We hit another error in CI now, with "allyesconfig":
> > drivers/sysreset/sysreset_qemu_virt_ctrl.c: In function 'qemu_virt_ctrl=
_request':
> > drivers/sysreset/sysreset_qemu_virt_ctrl.c:41:37: error: passing argume=
nt 2 of '__raw_writel' makes pointer from integer without a cast [-Werror=
=3Dint-conversion]
> >    41 |         __raw_writel(val, plat->reg + VIRT_CTRL_REG_CMD);
> >       |                                     ^
> >       |                                     |
> >       |                                     phys_addr_t {aka long long =
unsigned int}
> > In file included from ./arch/sandbox/include/asm/io.h:257,
> >                  from drivers/sysreset/sysreset_qemu_virt_ctrl.c:11:
> > include/asm-generic/io.h:168:67: note: expected 'volatile void *' but a=
rgument is of type 'phys_addr_t' {aka 'long long unsigned int'}
> >   168 | static inline void __raw_writel(u32 value, volatile void __iome=
m *addr)
> >       |
>=20
> mmm that one is interesting. It seems like it's triggering because
> sandbox doesn't define __raw_writel() so the generic version is being
> used and that is a static inline function so it doesn't cast the
> address to a pointer like most places do. But for riscv writel() is
> already a static inline function so it should have broke the build for
> riscv before the change?
>=20
> Anyhow, I added a patch that I think solves it for v7.
>=20
> > Please see https://docs.u-boot.org/en/latest/develop/ci_testing.html for
> > v7, thanks.
>=20
> I didn't realise I could trigger a pipeline run so thanks for the
> information. Anyhow, I triggered a run for v6 and it completed and I
> couldn't actually find where the error in the result. I triggered it
> again for the v7 and it passed too. Is there something I should check
> before I send it again? The run is here:
> https://github.com/u-boot/u-boot/pull/964/checks

That's very strange. I just re-checked v6 and still get:
https://source.denx.de/u-boot/u-boot/-/jobs/1446347 and both Azure and
Gitlab run the job the same way. Can you trigger it locally with
allyesconfig ?

--=20
Tom

--0WnhQ/PlQD3D022W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagHvFQAKCRAr4qD1Cr/k
CoImAPwMLv7r2ihDANm6m0PdasHxsb/dxiHXgeVaYjpuq8YuSwD/TNN1NQDsiv7d
SsA5SXJUEnLFLAcbusltsT40pkrIvAA=
=T86E
-----END PGP SIGNATURE-----

--0WnhQ/PlQD3D022W--
