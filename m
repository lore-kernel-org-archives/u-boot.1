Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23D1C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 22:48:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2F4F88C2F;
	Thu, 22 Aug 2024 00:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CQ0Y0wsw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EFCF88C30; Thu, 22 Aug 2024 00:48:00 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F138788BC4
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 00:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3db51133978so103800b6e.3
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 15:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724280476; x=1724885276; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GU0K+3SgirlE08l4qkE95qtHq1jgyCVoItG/NgRnH2w=;
 b=CQ0Y0wswNzOKaVPoHl6sv7vLkRLBU2IlwYTmeUbNEvC1PNTI/abrl5TIGK04v5cjBb
 IRTrUiIu0OV5svHxKUfNqTXHHmtg428COvHkWUs9PGHlB21ZAnuKW4s3fTvLcfsa3meG
 iVlmbDoXDT9J6j1LqTpxjcD1bVE164kNN2PG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724280476; x=1724885276;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GU0K+3SgirlE08l4qkE95qtHq1jgyCVoItG/NgRnH2w=;
 b=I/pbAoWvpk+eu0XWEbm4AUphIK4CGEbtJRjXyQzcfVxlnpvblK5ZUqldOduHymX8Fl
 eftqXLfkH8BJYCrKtxFncqpwUQiT4KLLJ2p1MigrNGntzeDnI18wpeDvjovEt7YI3VJC
 p5iosDFPQ3LhQ0oqyMsMqEpR240k8ugYFFeJZAhMPzt5AXxwr8281+EdTyBH/vYVucYx
 N5JvAxjBAN+qiIkjk9HHgs2dkThywypurmhr3Vc+Ew+sMmGtFpx/A91ToMEZfLW8PhQt
 uJc32ib4z51aBxgs9CLuHtArOkPdQXcGp4FRPP2FR2uu/TkEwty0MN2bkAtURKcC7l0I
 XJsw==
X-Gm-Message-State: AOJu0Yxjnk3s8wp58pgily5SH5d3jrIICrahjouwMpd7lGZsqJeIlSuZ
 YwYDplJ3s3ZSpIR8otdcnDfwN+403pXAZV0iIzZ/dkDZ9Cp3ex87K1GmYndbcao=
X-Google-Smtp-Source: AGHT+IHqeND22R8gqbkeoiFFN61gy8LP2WKV8MtnhZZde/9FGk3G0uJDKFdDie/4srmo+4Pno1JASA==
X-Received: by 2002:a05:6808:221e:b0:3db:2afc:b19 with SMTP id
 5614622812f47-3de194f7588mr4375347b6e.12.1724280476510; 
 Wed, 21 Aug 2024 15:47:56 -0700 (PDT)
Received: from oliver.lan ([2806:370:5564:d86d:5d21:f5a9:a623:3821])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3de22556216sm65295b6e.23.2024.08.21.15.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 15:47:55 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:47:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: Re: [PATCH v3 00/27] Make LMB memory map global and persistent
Message-ID: <20240821224749.GA104928@oliver.lan>
References: <20240821105839.2870293-1-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="efu6VcBEy67K7qWc"
Content-Disposition: inline
In-Reply-To: <20240821105839.2870293-1-sughosh.ganu@linaro.org>
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


--efu6VcBEy67K7qWc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 04:28:12PM +0530, Sughosh Ganu wrote:

> This is a follow-up from an earlier RFC series [1] for making the LMB
> and EFI memory allocations work together. This is a non-rfc version
> with only the LMB part of the patches, for making the LMB memory map
> global and persistent.
>=20
> This is part one of a set of patches which aim to have the LMB and EFI
> memory allocations work together. This requires making the LMB memory
> map global and persistent, instead of having local, caller specific
> maps. This is being done keeping in mind the usage of LMB memory by
> platforms where the same memory region can be used to load multiple
> different images. What is not allowed is to overwrite memory that has
> been allocated by the other module, currently the EFI memory
> module. This is being achieved by introducing a new flag,
> LMB_NOOVERWRITE, which represents memory which cannot be re-requested
> once allocated.
>=20
> The data structures (alloced lists) required for maintaining the LMB
> map are initialised during board init. The LMB module is enabled by
> default for the main U-Boot image, while it needs to be enabled for
> SPL. This version also uses a stack implementation, as suggested by
> Simon Glass to temporarily store the lmb structure instance which is
> used during normal operation when running lmb tests. This does away
> with the need to run the lmb tests separately.
>=20
> The tests have been tweaked where needed because of these changes.
>=20
> The second part of the patches, to be sent subsequently, would work on
> having the EFI allocations work with the LMB API's.

This generally feels like the right direction, but for v4 can you please
look at the assorted checkpatch.pl warnings? Don't worry so much about
trying to use IS_ENABLED and so forth if it doesn't enhance the
readability but there are "func (....)" and some other issues that
should be fixed. Thanks!

--=20
Tom

--efu6VcBEy67K7qWc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbGbpEACgkQFHw5/5Y0
tyxxVAv+J70k7T1GTCPTQQtoJhnBE/W2bmpg7jK/r6bKzekR6ro0e6mOJGGIj+fJ
X8v4xuP892Dh1IRIvrNKS5poPu1OJHkqLHhaWJTLQ4ScFMNNUk0/0MaitlYcA6MV
n5YOt/LnoKdKWzawGNIc8pZexFWcB6WiLFoyc7gTKx5qt4KFDgMSQ/ILGF/QHNL9
h+LlHkmz/XPhjinJkZ5/+K0+vvgwDq1RY8u/mxFs49Qdjdk3tsKK7xnbsWGA7c2W
99R5XSXzdc8FzoLCECDASYhgTFbujCRFQXTfAXVN4l1KrWp6AcTezA3/gfipcuDV
RO3UfsYsq5RtYdmwNY61rfvUTgQ5OJrrWmPOvlvC+NCbnaxjN03xRhYongDBcS4b
mvdtR5EcOLaIjp40LugrD9dzGq0DcCZVTEM4i91GpANpbY96uf/yI3y9qMmdeNqb
3ANL4sTNwFUpKa1CRo5UDo8gNOAGIsIpWDlzvs2Zpf/X+8IaLucwy29BcgNuzuia
K++nYRp3
=QOeO
-----END PGP SIGNATURE-----

--efu6VcBEy67K7qWc--
