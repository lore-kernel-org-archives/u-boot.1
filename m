Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44E6C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 20:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01C138719D;
	Thu,  9 Nov 2023 21:42:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W6fdlm/1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FD6A87516; Thu,  9 Nov 2023 21:42:03 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3958C870F4
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 21:42:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1ef36a04931so706320fac.2
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 12:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699562520; x=1700167320; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fsq8uPaIGhR6LnWRCoZKowrupeDJ8gvnmreMewafoO8=;
 b=W6fdlm/11VL4HLpkOSp+XOBaDxPdGU/Gsv7tBwgpnKQ/jUbGdDOeK5sl3aSllNF2AR
 YnSIgPiy7O3QOS+diMcsj7FMHzsMf89ZuYJ5dTsYIuMiX60PGBCFGZpOLKKFFJ20BBs5
 kyu5GF34Pb5fA7uQHUcch7RJPovV9PJgXh25Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699562520; x=1700167320;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fsq8uPaIGhR6LnWRCoZKowrupeDJ8gvnmreMewafoO8=;
 b=uVCiLKnEzt+jvWWeo6Ej2wdqYwKVGXApElQVxKCXQ2VIfI52p/abPxi4cHhwakXJXj
 2IcvUrTbEnCqRlRRwvsnqyaA3WAPFHzvgXu4ku8biRIeAs9HB+/6ShUD7OznibN/+UZG
 K8lUnstH6qiTEw5zD1q/Dgj4kNU+djDTkMotFBZXBaOwssmk9//lrdfg48kRjkVDmATp
 3IFjBLRmhAGCMcei+uvLpdg5XLGAJLvT+QzrIi8gszAurIG2eiMMY2uJB+N5uCRJoMSm
 qwjsWiqxgJx/W4G8YKH6AewoKE0DeBnik7wQQRzksmfl2F/PDtonRioW/hP1dWpk4ddc
 jvjA==
X-Gm-Message-State: AOJu0YwVk9DgkVaRahtZlNwGnkInkkM7Ms8Z/XbMgy5icjXXkWZ9E8Ah
 oAzCD5XOAAqTJgz9GIEqUNRYW0cx6BgJtNfUWX31Bw==
X-Google-Smtp-Source: AGHT+IG/dzjS9w77XYr/FxNTMMaNw2B4qSQOLYhZf0UiEQdGwuvcZ8pOTBQPm+4bZnOovcnrDzPceg==
X-Received: by 2002:a05:6870:9691:b0:1f4:a122:6b02 with SMTP id
 o17-20020a056870969100b001f4a1226b02mr1057779oaq.45.1699562519778; 
 Thu, 09 Nov 2023 12:41:59 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-58a3-ea36-c2a1-60cb.res6.spectrum.com.
 [2603:6081:7b00:6400:58a3:ea36:c2a1:60cb])
 by smtp.gmail.com with ESMTPSA id
 eb4-20020a05620a480400b007757fefea79sm171141qkb.130.2023.11.09.12.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 12:41:59 -0800 (PST)
Date: Thu, 9 Nov 2023 15:41:57 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] acpi: move acpi_get_rsdp_addr() to acpi/acpi_table.h
Message-ID: <20231109204157.GI6601@bill-the-cat>
References: <20231109172302.54324-1-heinrich.schuchardt@canonical.com>
 <20231109192419.GH6601@bill-the-cat>
 <9525398a-1326-470e-9894-afb160cde2e6@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tr3Apj/aSLtQJOWi"
Content-Disposition: inline
In-Reply-To: <9525398a-1326-470e-9894-afb160cde2e6@canonical.com>
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


--tr3Apj/aSLtQJOWi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2023 at 12:28:26PM -0800, Heinrich Schuchardt wrote:
> On 11/9/23 11:24, Tom Rini wrote:
> > On Thu, Nov 09, 2023 at 09:23:02AM -0800, Heinrich Schuchardt wrote:
> >=20
> > > Function acpi_get_rsdp_addr() is needed on all architectures which
> > > write ACPI tables. Move the definition from the x86 include to an
> > > architecture independent one.
> > >=20
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >   arch/x86/include/asm/acpi_table.h | 9 ---------
> > >   drivers/misc/qfw.c                | 1 +
> > >   include/acpi/acpi_table.h         | 9 +++++++++
> > >   3 files changed, 10 insertions(+), 9 deletions(-)
> >=20
> > My question here is, does this work right on non-x86? I know you can
> > have ACPI without UEFI on x86, but elsewhere doesn't the location have
> > to be provided in some manner by UEFI? I know I'm thinking that's the
> > case with SMBIOS (with a few exception).
> >=20
> > I'm assuming you're doing something here with qemu and its qfw interface
> > and risc-v.
> >=20
>=20
> Hello Tom,
>=20
> yes, I want to enable ACPI passthrough on QEMU RISC-V. There will be more
> patches needed. But the current change seemed obvious looking at the code=
 so
> I did not want to pile up more patches first.
>=20
> Do you know what the status of ACPI passthrough is on ARM?

On U-Boot? No. I know a while back I asked Simon to, and he did some
hacking such that on a Raspberry Pi you could do UEFI boot and pass
through some ACPI tables and it was somewhat functional (which was I
think an issue with the ACPI tables as much as anything else). And I
mentioned to some Linaro/EBBR people that it was because in part I don't
object to U-Boot being able to do SystemReady ES level support either
(and to be clear, I don't mean instead of, or preferred over IR, just
that ES mandates ACPI and if we can pass it through .... and yes,
there's more to it than that, I know).

And yeah, I see now I had mis-interpreted the "rsdp" portion of the
function name.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--tr3Apj/aSLtQJOWi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVNRAsACgkQFHw5/5Y0
tyz7rQv/QCaXaukuaxaqLp7sax8GDdj88rCuDHEMZ0/E2Vly4R8MCZQLaWtgS/R0
x4lkkTFbIWKMJeCT0/0YXpHdhKYbwSZYytB+6+GZAFW/bnac5nXhb0MyW0xNbrJO
sfDeLgSZCA9BYsHixqING9Ni5Ni8nJxB2HiU/OfaZbUbcmCkaJXzrCNwtLTPxboH
wJFxYQur7J8LWm5IAlSE8EXKDaKvMNkK4xn9VzJesUrvwShBsloG7JTCsicmoVeE
ENuheyQRDJWr2mcCHseRziXmnuUibEDhso2TnM53b/K7mwZVsk3lf5p2ppPDP3/D
yoNwFxISgmmoNKJQ+vqIypTZrtnpKxgOSCtHjo2Gx/9FunAZ3joLLIVieEIRgcUo
Egqifb67UB9MDljX/ULNPrcaVuW3mLtcavSfOmsjay60s4aejgDdvnDE34hv92sl
A/ikal5Tbxo+K4+htlT9y29SvaCzzFMcT5tagwC4UNeqF849oN16otSopVN6a4U1
p1oI1sHP
=xKhk
-----END PGP SIGNATURE-----

--tr3Apj/aSLtQJOWi--
