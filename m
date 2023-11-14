Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC0DC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 18:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C32A8718E;
	Tue, 14 Nov 2023 19:04:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZFS0+/ZZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 919498718E; Tue, 14 Nov 2023 19:04:38 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21F1F867E2
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 19:04:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-42135f8e08fso37463351cf.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 10:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699985074; x=1700589874; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8qZNgtDq4mHBXkLe3Ob+z2ecMSBAyg+KOaop7qtu9lA=;
 b=ZFS0+/ZZrJD4EKLmlNINwHdkNNVq/CHFAPMylw+86aXpz1MRWzYl4RfD3EBckLMbR9
 aR0DFJ1RZ8qMxP8cBrk3Hf46srM/jqYIJkqKa1oI9ZjIPcy1joudoIjeqVIaZxsl8PpI
 x7UZfchEdPVDnJgEclHYrje+7/4syWhtL9xI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699985074; x=1700589874;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8qZNgtDq4mHBXkLe3Ob+z2ecMSBAyg+KOaop7qtu9lA=;
 b=D/KrWSnQ52Cx2zte8NQnK3gjzPDOluQ1nb1REBRVixRPcV8n9G3pI/B0ksGNABa29q
 ys4yLNgzMk4Ct9gN16cbc5p5o4yDhCtBA7ofxQ2VB/d2MwTSF+mv/0Wri00lHN/2fLAi
 n9z1wdhxj0T0RbEjc2lz0vu54JoCJNucWbbuirotT28jG805savaknpqsPbgbmkR0meI
 OGo2ZT16qzI18i6mK+cexTRrXW0dmngMbF6/CBZYjYojejRLEidlHdX9I7Hulhant/Hm
 nVl/X/63mSOG47WXNvQ6f8p5Q+Pqr8mITuI1zRiwxfIbnIiWYICyhoYBU8lTFQa3xaA6
 jFnQ==
X-Gm-Message-State: AOJu0YwBButD10A+tGzK6geDaCNLggyc8qqstf0IvNPiKW3eAJFSgANa
 iviDiYgLRJtPHMLVpiASSTwvMQ==
X-Google-Smtp-Source: AGHT+IGi+PyVCxiDwHnZyJHiqJ3fo3L0PTJ1wOM5UfqMMfvybYMlVR9ZCf5YK5WJiI8+Y/ZRugR1IQ==
X-Received: by 2002:a05:622a:1a01:b0:403:a8fa:b4f5 with SMTP id
 f1-20020a05622a1a0100b00403a8fab4f5mr4101600qtb.4.1699985073777; 
 Tue, 14 Nov 2023 10:04:33 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2a5c-a31a-8ead-8e73.res6.spectrum.com.
 [2603:6081:7b00:6400:2a5c:a31a:8ead:8e73])
 by smtp.gmail.com with ESMTPSA id
 m13-20020ac807cd000000b0041b7f89ad19sm2720287qth.53.2023.11.14.10.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 10:04:33 -0800 (PST)
Date: Tue, 14 Nov 2023 13:04:30 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v2 3/5] bootm: Allow omitting the load address
Message-ID: <20231114180430.GZ6601@bill-the-cat>
References: <20231112035001.103897-1-sjg@chromium.org>
 <20231111204954.v2.3.Iae1cd9e0e207784e680480ee52021ec5caed877e@changeid>
 <20231114163846.GX6601@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y2ft/bUgTyBGLHtx"
Content-Disposition: inline
In-Reply-To: <20231114163846.GX6601@bill-the-cat>
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


--Y2ft/bUgTyBGLHtx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 11:38:46AM -0500, Tom Rini wrote:
> On Sat, Nov 11, 2023 at 08:49:55PM -0700, Simon Glass wrote:
>=20
> > The kernel_noload image type indicates that no loading is to be done by
> > U-Boot. This works well when the image is uncompressed.
> >=20
> > When the image is compressed, loading is of course required. The load
> > address in the FIT is used for loading.
> >=20
> > However a FIT built from Linux v6.6 supports about 990 boards. Each has
> > a different memory arrangement, so no one load address is suitable.
> > Therefore the 'load' address in the kernel node is not useful.
> >=20
> > It would be better in this case to be able to omit the load address and
> > have U-Boot choose something suitable. The kernel_addr_r environment
> > variable seems to be a more reliable final address for the kernel. Use
> > that as a backup when the load address is missing.
> >=20
> > Similarly, use the load address as the entry address when the latter is
> > omitted.
> >=20
> > Update the FIT documentation accordingly.
> >=20
> > Note that mkimage still requires each image in a FIT to have a load
> > address, at least for now.
> >=20
> > Another option would be to create a new Kconfig for this, or to use a
> > region of memory known to be free, e.g. calculated from the DRAM banks.
> > But in any case we should try to avoid conflicting with the
> > kernel_addr_r variable. So the approach in this patch seems reasonable
> > to me.
> >=20
> > It might perhaps be useful to introduce an 'entry-offset' property
> > which allows the entry to be set as an offset from the load address,
> > whether that is explicit or calculated.
> >=20
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>=20
> OK, so I dug out what I was trying to determine before, and while I
> might see if I can bisect down to when this regressed, it might be a
> little hard given that my previously functional image is from 2013.
>=20
> What should happen in the case of kernel_noload, and why the later patch
> to fail on kernel_noload + compression, is that we don't move the kernel
> contents of the FIT. We don't need the load address to be set because
> we're using it where it is. What happened before in the case of the
> ramdisk, and more importantly device tree, is what I why I want to
> bisect down to when my image stopped working. But:

Well, it seems I was wrong. I was able to (with only minor difficulty)
go back to v2013.04, which was just after I made the fitImage I was
trying to test and it doesn't bootm as-is. So whereas I had thought we
had a defined and working case for kernel_noload and FIT images as you
describe them, that does not seem to be the case. So please disregard
this and I will review the patch again in light of what I've confirmed
now, sorry for the incorrect feedback here and in the other thread.

--=20
Tom

--Y2ft/bUgTyBGLHtx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVTtqUACgkQFHw5/5Y0
tyxV7Qv+KJUthkgUlB6oBqFY67nejDsVLU6LJcXrPraCaleYhhMH+wH7nnJRA6xN
EMlOVTSulQteSU9Gm0xlVLqFuaTQ1AoZpeTnLU5NBoLtTYhxOaz511J6G0GrHs7a
VsLlM4ljbRKMyEWLKy81K1hm5arCkvqRkOcTZs0qHtfnaTCCEQIVEi1CifADfZwO
a8+JVmkaYoaGlzpGOJ9u2T9mFEw51caxORqXARkwTngRvl+gsd7lfbVMC9M+Dz2j
pvl61J8CJYQUXkX6PpOmswuhH2DO3g4cZVOsgPNc0CM5TIxsO0eof0/3tm4kidcC
V2aozWVOB4tDuOLQkGuhYd0ytiUmD71sI/e4HJ0GjO4vytX0OtqMausTUIqd7wzP
Ykx3aHzVgrvQQYF9YkUuZM7U34LnP4TGHLd7Qm1LdFRQmPXimOChh9P4dKncYxGL
u3k5ZHz6eNg6FMyc3+PqvhmQ96HhNqXhhKYuP/2vEVZPBheVcGkcZ6Jq6OdYeZ0Z
TQhkz9sZ
=clLz
-----END PGP SIGNATURE-----

--Y2ft/bUgTyBGLHtx--
