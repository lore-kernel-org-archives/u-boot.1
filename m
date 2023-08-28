Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F182C83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 17:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C4EF864CB;
	Mon, 28 Aug 2023 19:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="de+g9C83";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81B8E864CD; Mon, 28 Aug 2023 19:54:57 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7A3D864CB
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 19:54:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-58d70c441d5so43998637b3.2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693245293; x=1693850093;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KQLseBlTUGU4DDdLZtZcvHi5/NX/uEAsFXD1GhiiSGo=;
 b=de+g9C83UKTEvKKZ7Qa+/Z2h69iB4XjzjlrngAIU7vNnZd3/njCs7dop2O0YjkGmyz
 L1BD3OhY/lcjGHD5xN0YXOohFMS3u0CWi3PQPjV7bf2NCelNIgygHnuSWITTRMGQo0sa
 DRZSXdVEVaVQyl/ATbjrUqbQSQt5wZBquL9Pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693245293; x=1693850093;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQLseBlTUGU4DDdLZtZcvHi5/NX/uEAsFXD1GhiiSGo=;
 b=U65PjhWYMAGNxTa2VSR5VkVMVCoenDtU2y4Ka94PTnjL1m0XdvVjw7WY/HiyZQkrud
 PGJLbjUopYMiF2RGi7L0b1CpmPivFrCpv/dvL8+6lNSexbLw3rf5UxrkwkxvPGLsphOA
 eE2FrnM/iQTcDOTR484O/LMureRGC9IhgvNK8TCnsrZAynyz7nQXivt3dJ996PKMfntq
 j5V3bDcoERyDUS874dcUVWB9O1p/pZd2U3rvYF6YGDstBfLj7VnpWwwcyc39kRJUqFMa
 20ebKvssIaZNCmEDJFfgXIejToPtVBUKS+7DQhWt4ztH9fLkpsU+R+xFAfuCXBdBy/+b
 E4wQ==
X-Gm-Message-State: AOJu0Yx5dS3AErvLLPfttxboDUh3yVuHhO25pTVlF5aj3V6E73K5fkPS
 a95ydnITcqnZi/v8XYIW7jK4eQ==
X-Google-Smtp-Source: AGHT+IFPO4KSr5TJQXFTwi3ZQa8a/TFwTZXLhxArXMygQio3Mi0ndGUnOiobDbAuvDMNr2hHNN5vNQ==
X-Received: by 2002:a81:7cc4:0:b0:592:3d93:647a with SMTP id
 x187-20020a817cc4000000b005923d93647amr20786355ywc.29.1693245292415; 
 Mon, 28 Aug 2023 10:54:52 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c01a-9a8d-1e42-2ea4.res6.spectrum.com.
 [2603:6081:7b00:6400:c01a:9a8d:1e42:2ea4])
 by smtp.gmail.com with ESMTPSA id
 o3-20020a817303000000b00583f8f41cb8sm2240066ywc.63.2023.08.28.10.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 10:54:52 -0700 (PDT)
Date: Mon, 28 Aug 2023 13:54:50 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
Message-ID: <20230828175450.GJ3953269@bill-the-cat>
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ewDm33lSo9mljmpT"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
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


--ewDm33lSo9mljmpT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 10:19:55AM -0600, Simon Glass wrote:
> Hi,
>=20
> On Sat, 26 Aug 2023 at 03:07, Sughosh Ganu <sughosh.ganu@linaro.org> wrot=
e:
> >
> >
> > Provide a way for removing certain devicetree nodes and/or properties
> > from the devicetree. This is needed to purge certain nodes and
> > properties which may be relevant only in U-Boot. Such nodes and
> > properties are then removed from the devicetree before it is passed to
> > the kernel. This ensures that the devicetree passed to the OS does not
> > contain any non-compliant nodes and properties.
> >
> > The removal of the nodes and properties is being done through an
> > EVT_FT_FIXUP handler. I am not sure if the removal code needs to be
> > behind any Kconfig symbol.
> >
> > I have only build tested this on sandbox, and tested on qemu arm64
> > virt platform. This being a RFC, I have not put this through a CI run.
> >
> > Sughosh Ganu (5):
> >   dt: Provide a way to remove non-compliant nodes and properties
> >   fwu: Add the fwu-mdata node for removal from devicetree
> >   capsule: Add the capsule-key property for removal from devicetree
> >   bootefi: Call the EVT_FT_FIXUP event handler
> >   doc: Add a document for non-compliant DT node/property removal
> >
> >  cmd/bootefi.c                                 | 18 +++++
> >  .../devicetree/dt_non_compliant_purge.rst     | 64 ++++++++++++++++
> >  drivers/fwu-mdata/fwu-mdata-uclass.c          |  5 ++
> >  include/dt-structs.h                          | 11 +++
> >  lib/Makefile                                  |  1 +
> >  lib/dt_purge.c                                | 73 +++++++++++++++++++
> >  lib/efi_loader/efi_capsule.c                  |  7 ++
> >  7 files changed, 179 insertions(+)
> >  create mode 100644 doc/develop/devicetree/dt_non_compliant_purge.rst
> >  create mode 100644 lib/dt_purge.c
>=20
> What is the point of removing them? Instead, we should make sure that
> we upstream the bindings and encourage SoC vendors to sync them. If we
> remove them, no one will bother and U-Boot just becomes a dumping
> ground.

It's about having a defined process to remove them, rather than an
ad-hoc process like one can do today to remove them. And it's about
having control over the situation rather than dismissing it, as vendor
can already say they used $this version of the software for validation,
so patches-on-top aren't out of the question.

--=20
Tom

--ewDm33lSo9mljmpT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTs32oACgkQFHw5/5Y0
tyyqJwwAoNr5qkXVmJo7OMkFVa4VcXX0mQueBPjqOiSIIgGZ/5u7o3bTZbrL3NA9
eJY6AMKBAxGytWJozA+gW+mGbzY5zKdjs8qmiG/AoPv6oEcwdAStMHbFhLLUHHQE
pEI5cGHW2JrXz0QIjYdj2rKM7DdMxzdIrM72TjJBnMqvNyfw6zBWoUpxPYk4wcbT
pvNtmCOXoOUV18LxoLjTkhmrpAb4x29k7HCBZREUrVkhsYiX247hfzVlmH6XS8ua
oUDk1RzoXfUyQ5cPWBXYt7kYyPJ7G8/QXOiA9T7MOt0ba72n+NS4AtJqST/o6ZyV
3FjxGQLA79RueyT8//DBtcVe4ld7Z5T8oNsbLG4wkLf4gKS5Wd4vlvbqX1oFVW4U
jI25I3JhBz0CU6lBtRACZFpfCp4A88I7i85fMp5kwlIEl6Zw71c9lwgtbR0H+2zK
bDRLhKIUlaLTBvTfvwgQ9oCsQLjgFAa96NJMrZiJfq6SSqyzqQawcwPIYDv501ej
vW3WJ3Q6
=ywcJ
-----END PGP SIGNATURE-----

--ewDm33lSo9mljmpT--
