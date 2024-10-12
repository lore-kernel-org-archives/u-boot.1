Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55456D0EE1C
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 01:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 982F18943A;
	Sat, 12 Oct 2024 03:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OpcO1+C6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A48BB8943B; Sat, 12 Oct 2024 03:20:12 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 951258941B
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 03:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-45f059dcc77so26948781cf.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 18:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728696009; x=1729300809; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nDnW2BD0aGUASIIzoMTJmcpgoGOLqykj8oDUW5NNli0=;
 b=OpcO1+C6NrzoJnX338IQUQedb3u+8sp01LmfSlLdUhfJvhUPQgD6n9/pmOmJGf3WLl
 5l/k690/mWeawzFBltl6Sz2l3ax7yAjtSwC4FVLAuMrXmzfF3eHDwdo683oU3JBlRK8j
 xmV4LAZxPJkrzuSTH5yXSMRslBczQCRRLI2HM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728696009; x=1729300809;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nDnW2BD0aGUASIIzoMTJmcpgoGOLqykj8oDUW5NNli0=;
 b=iiWow+PMhEotaVndAjIMkjpU4uyWU9YcsumdD+A/Zcc0b8lCp8vTj/uAvT3jX7Ws3o
 7ZLPPSwobOThOB0WgAx3/hDpUn+VddX0gZYOsVbsxLTBCdM7npGO3HmoOBnUHYL8MXQ+
 T9DDw9iAPn1u9g2FJTOM3MTbUeu9RYXm0WPTuh8vL61g9n+OtgURUW2w5QEgVtmQ9u7b
 deJqXqVXVWjz+iS9UrBh5FH5Mn06th01af289HyMNMLH74RL8Y34VGmo6HmXaXrJ7nIX
 5J2Rtik77iyYIEu1bUezm1ZJgAPv8O4Ov1vcE94deyURoLWpnCVkWD3cqmRxO1N/EDCu
 LmOA==
X-Gm-Message-State: AOJu0YwUedHf/koAZ3MkYh7jPNrDRfnM/ZGpEFM+W1uz2ah3kEISLJjO
 uB5Wj0pSUn/0CPUTs9DsshctZ++hYtm/gdUz5e7MzVP4FoC2qBRf3fpqa1eU/FQ=
X-Google-Smtp-Source: AGHT+IFusHWmcHm2bMXFrx8LyqFgmnzp/AOWapc2Kbj7NjGMwfiuCSKqFStEeaTp/klP15LLNWH62A==
X-Received: by 2002:a05:6214:5f11:b0:6cb:ae56:1965 with SMTP id
 6a1803df08f44-6cbf9d20984mr20123886d6.15.1728696009333; 
 Fri, 11 Oct 2024 18:20:09 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe85b695fsm21172636d6.37.2024.10.11.18.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 18:20:08 -0700 (PDT)
Date: Fri, 11 Oct 2024 19:20:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v4 1/5] efi: Drop the memset() from efi_alloc()
Message-ID: <20241012012004.GD14210@bill-the-cat>
References: <20241011212126.747741-1-sjg@chromium.org>
 <20241011212126.747741-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1xzeOjQeFeHxXf9P"
Content-Disposition: inline
In-Reply-To: <20241011212126.747741-2-sjg@chromium.org>
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


--1xzeOjQeFeHxXf9P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 03:21:22PM -0600, Simon Glass wrote:

> From my inspection none of the users need the memory to be zeroed. It
> is somewhat unexpected that it does so, since the name gives no clue to
> this.
>=20
> Drop the memset() so that it effectively becomes a wrapper around the
> normal EFI-pool allocator.
>=20
> Another option would be to drop this function and call
> efi_allocate_pool() directly, but that increase code size a little.
>=20
> Move the function comment to the header file like most other exported
> functions in U-Boot.
>=20
> Comments were made in v3 that another project uses memset() when
> allocating memory, but that is not required by the spec. In any case, as
> above, from inspection, none of the users need the memory to be zeroed,
> as they fill the entire region with their own data.

The other comments made in v3 about another project (EDKII) is that we
want to remain implementation compatible. This is a case where (a) if
needed, we can reach out and get the spec clarified to say zeroed memory
and (b) even if it's not, this is a case where real world
interoperability is more important than strict spec compliance. If
there's an app out there relying on the zeroed behavior and it's fine on
EDKII and not fine on us, it'll be a problem for us because we
stopped matching behavior. So unless in the end Heinrich and/or Ilias
drop their previous objection, I don't think this is a good idea.

--=20
Tom

--1xzeOjQeFeHxXf9P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcJzsQACgkQFHw5/5Y0
tyxT9Av/V2EPAbUbCDm7PzuA5Yx6mDaWGUmNBSUaKZXCkBCib0MjXQdy7DgpqQRS
5IOOSxg9KrBfOGyRWBpyrcbGJbMRCjyyvnDoHwuBWpCcoMR0Xos00nz00yU8njSZ
y+KXpHV+3zavBSpZBmza0Eerae8NBmI4Z8HQ3xCE/EgMozPEvawM7sE0d7BWxVax
FVM5CCOV0c+sF+uMw6HtUnYxT1sh/JbB1z8uIKtzUbsrg13w8Hx+mL5mKQw8LQ4c
4lwcnRyVhk3uddd9Y3ftEQKRnYMbhE9Bg+joX52xIUPprKdW7CnQXg1nmeyT6Jvi
2OLTNFQUrTODPkoqVYD80h5uRNjvM19nAWuZYzwJeivk0e+TMCMxN9mxmpXTHBgZ
EKW9lf4Q0twnXxwxD14UkXvkyGWG1z5NN7V2lktrgi7LnNEIwLKzswYDWddmHnWg
IhSzz0ZhbuMFFNMxlLQVNs5yo23K2+/11SJa8+5meT1PNIni6RxrD5sY7TU/IY2g
mq3/Eanm
=MpVc
-----END PGP SIGNATURE-----

--1xzeOjQeFeHxXf9P--
