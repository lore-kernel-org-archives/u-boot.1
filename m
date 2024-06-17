Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081FDC27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 19:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1D1B88167;
	Mon, 17 Jun 2024 21:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UhojMChZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90A0788167; Mon, 17 Jun 2024 21:54:36 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D3578832D
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 21:54:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3d21c4eec2dso2500982b6e.1
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 12:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718654073; x=1719258873; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=h2IzdZX9wCEV7zcq2dJqWbDd4qIjqTgnshVX1JNiDJU=;
 b=UhojMChZmXwNIKHkaqztxjHUGHTkwlqRGpt36MZB9JAXX7BCaajJGrspOJqHJyQ7tC
 h4lycRLQJW/CHADxJ3TuoiuQrC9/mP637k26eOeGaOpbypZLRFePXEzc1mNZ0Lek+M4Q
 JJ0rMVBjVM3NgVTmg9UJ8KSSPfiZ0WJGQuFGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718654073; x=1719258873;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h2IzdZX9wCEV7zcq2dJqWbDd4qIjqTgnshVX1JNiDJU=;
 b=RdxvxdrtrJFlltNRP2Q0pb1AUW4kvT6gBqszIki78NYWcnLnEuithkOSH26XalZOYp
 ihD+kdN0DQRcrVhSnvJkfZsDmn2SrwAv6T6fTTynEtwUJWUX5aTdvWmoFtdhRy9gkI76
 oOR/qYj6VgjaPhU3R3k3khAjx9DiiToh+n7UiE3uC04xHc1YFiLz+9wDh/EzrWpU5MTa
 bYIuvCNtcd/2TwFq/ULNhmFK68Sz9WSGS+u4neVK1o/1eXnikn2Z8EkKRuzJDRHgl7bo
 LEUJmPTQbNMI/Gt1HsQImAA/67gBVoBD6bIp6HWC1jnsmgx0DQziW5A89o25w2VIZNlr
 +SQw==
X-Gm-Message-State: AOJu0YxYxFT1ZcCxkt2Vju8NQsc28CJrwDFajDheEhktV8jZ+X/NhFgr
 m9Vb1IlpFYe2eeb7RWrM2GC3PInQFlJpc8+UmmIxnQP55lMqzZD4bqkTRtAAMEM=
X-Google-Smtp-Source: AGHT+IEn5kR8wFew5JnsguwKmDVOfJoLIhUYPXlStLlY0nfYgdo3krj600GjGZfW/1CE+w13St2xSA==
X-Received: by 2002:a05:6870:d0c7:b0:24f:ee10:78a4 with SMTP id
 586e51a60fabf-25842b7943cmr12007922fac.42.1718654072670; 
 Mon, 17 Jun 2024 12:54:32 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567a94e375sm2765632fac.4.2024.06.17.12.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 12:54:32 -0700 (PDT)
Date: Mon, 17 Jun 2024 13:54:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v5 0/3] automatically add /chosen/kaslr-seed and
 deduplicate code
Message-ID: <20240617195429.GK68077@bill-the-cat>
References: <20240530220634.155951-1-tharvey@gateworks.com>
 <20240613221807.GA2448330@bill-the-cat>
 <CAJ+vNU1naf11vZyZCctCiELHLUV3g=kCxot5G0qx_t=5eWicdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UuInWjhFQlFQj6tG"
Content-Disposition: inline
In-Reply-To: <CAJ+vNU1naf11vZyZCctCiELHLUV3g=kCxot5G0qx_t=5eWicdg@mail.gmail.com>
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


--UuInWjhFQlFQj6tG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 12:32:22PM -0700, Tim Harvey wrote:
> On Thu, Jun 13, 2024 at 3:18=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, May 30, 2024 at 03:06:31PM -0700, Tim Harvey wrote:
> >
> > > This series will automatically add /chosen/kaslr-seed to the dt if DM=
_RNG is enabled
> > > during the boot process.
> > >
> > > If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
> > > randomize the virtual address at which the kernel image is loaded, it
> > > expects entropy to be provided by the bootloader by populating
> > > /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
> > >
> > > If we have DM_RNG enabled populate this value automatically when
> > > fdt_chosen is called. We skip this if ARMV8_SEC_FIRMWARE_SUPPORT
> > > is enabled as its implementation uses a different source of entropy
> > > that is not yet implemented as DM_RNG. We also skip this if
> > > MEASURED_BOOT is enabled as in that case any modifications to the
> > > dt will cause measured boot to fail (although there are many other
> > > places the dt is altered).
> > >
> > > As this fdt node is added elsewhere create a library function and
> > > use it to deduplicate code. We will provide a parameter to overwrite
> > > the node if present.
> > >
> > > For our automatic injection, we will use the first rng device and
> > > not overwrite if already present with a non-zero value (which may
> > > have been populated by an earlier boot stage). This way if a board
> > > specific ft_board_setup() function wants to customize this behavior
> > > it can call fdt_kaslrseed with a rng device index of its choosing and
> > > set overwrite true.
> > >
> > > Note that the kalsrseed command (CMD_KASLRSEED) is likely pointless n=
ow
> > > but left in place in case boot scripts exist that rely on this command
> > > existing and returning success. An informational message is printed to
> > > alert users of this command that it is likely no longer needed.
> > >
> > > Note that the Kernel's EFI STUB only relies on EFI_RNG_PROTOCOL for
> > > randomization and completely ignores the kaslr-seed for its own
> > > randomness needs (i.e the randomization of the physical placement of
> > > the kernel). It gets weeded out from the DTB that gets handed over via
> > > efi_install_fdt() as it would also mess up the measured boot DTB TPM
> > > measurements as well.
> >
> > This needs to be reworked / update the test that now breaks:
> > https://source.denx.de/u-boot/u-boot/-/jobs/849988#L264
> >
>=20
> Tom,
>=20
> Sorry about that. I sent a v6 with a patch to take care of this.
>=20
> I still haven't quite figured out how to use CI locally to catch
> things like this. It looks like I need to use gitlab according to [1]
> but I'm not familiar with Gitlab and creating a uboot project there
> and pushing my branch failed with a 'pre-receive hook declined'. I'm
> not sure if anyone has any documentation on how to get started with
> U-Boot CI?

Er, the first section is about Azure and non-custodians use that since
it's just a matter of doing a PR against the github tree to trigger the
run.

--=20
Tom

--UuInWjhFQlFQj6tG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZwlGsACgkQFHw5/5Y0
tyzwbgwAlonF0s2q4hFk7u0xUqz/00RZMAGVXj3T/zaJuerViGonpUxkblO6aZo4
YliHpu/gVaV7vA/iHqM2xnT5G8I/DfTwHgZiDl5JNC6iSBMgikGJy+fcvltTiYLb
UA6e0GPzKrrVoVu+YxCW+/nCvzru+/aYM9/HZJBKEfbpiaN4ZgNR2FnTRioz8yO6
SWvCD+JSXDYpBDMyoE2pA1r9c8o/DaQITG+vfOehCWB0UTpbRcus7zFesjfBaDDe
Jz7cUj2tCdVJEWREvm+SLXZXhmrI5lJPgg+xQVq3x+wo+xPM5kWni1W3rrUxK8Ua
3pfmtXhG3qVx/4n5GXKrRg7rY8TwPCXrbJ21DvsI7r/V8xPx2rxlVwgSzt2l+2cO
54p8pdn88tvX6jObV7pDi1va/7H47ZHQ7uBFmjQCKQo+tBLUJwMP7jjsJjqmkakD
VpI/1MCSFPZuUYyfDVj7JIrEmCNRgT3WPb6vCVjtL04COnhX7Jo3nYZFia2NKKts
xNZJFGmY
=/spk
-----END PGP SIGNATURE-----

--UuInWjhFQlFQj6tG--
