Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BE2C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 14:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7668D87C68;
	Wed, 31 Jan 2024 15:14:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jqCtKucl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB9CA87C68; Wed, 31 Jan 2024 15:14:25 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A933876C1
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 15:14:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-78406c22dc7so193586385a.0
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 06:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706710462; x=1707315262; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Gq0lH5a3nmjv/yP+XFON1NE4n3LfdSz/ehsk1Ij+jSQ=;
 b=jqCtKuclg+98qeU28BSVe17hmCcmcEccmnuVFjqgXgnlKsqokHifyz2EQMCtN2TaaP
 9lS7yNhxzcV94c+itPKVJPd9jV6ewoq2jKQxd7+iwN4nNaNVGuwU+mskEFn1EK20FpUJ
 jwvK+n9RPQejaziNw050QjQUDcc/TRnZSbj6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706710462; x=1707315262;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gq0lH5a3nmjv/yP+XFON1NE4n3LfdSz/ehsk1Ij+jSQ=;
 b=WI/AJbW3cUUl6xMUQ5vBSCi1TtQClSp7HhxXKYWpFYxbfGcLtkS+hVzGVYjq/L00FG
 AUw85PA8IfdYKkbPCwdAgxZZfkjRwFjAHro1suQlTYEQ33gaI/Jwe2UHkxlbVZoniTu9
 KcTGNfMB36I7iN76boFSsue5fNni2aFpIpTn3V2QVzsIabenVtByfW25zRbX87T2V43O
 mzqX5DR77rFlsOMBRk/RjygT+0aaumBTth4I4OcTp+UPSlfIS/xn9riFMi3PrW/Cin/1
 moGd6U0SaJZSzCaAkcIdrLE3J24/SH1efLU+iM9pldxSKkt3oA/43PBSVzPf0m2yiBZ5
 LOoA==
X-Gm-Message-State: AOJu0YzVI++9vKe7uChSsIazgvb4NJEpsuxS666+mTf+HNZWiTflwaQF
 Zyd38irqLf0dH98reynCdQ4+pwtkobp5g5lfswkPRO31pbUL+KQje4kFjf8ZoQ6RQ1oITvXm7Pr
 i
X-Google-Smtp-Source: AGHT+IHvCHCU2etDh3S+DIVtn3PCihuczP2DlA/kyIS2A6Kg6CSAjh7pcLAXBN7PbkBLF9fMEFOv+w==
X-Received: by 2002:a05:620a:24d4:b0:784:7b27:4ec8 with SMTP id
 m20-20020a05620a24d400b007847b274ec8mr1727749qkn.5.1706710462380; 
 Wed, 31 Jan 2024 06:14:22 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 qp29-20020a05620a389d00b00783f290c8f2sm3468683qkn.9.2024.01.31.06.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 06:14:22 -0800 (PST)
Date: Wed, 31 Jan 2024 09:14:20 -0500
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: nm@ti.com, vigneshr@ti.com, s-vadapalli@ti.com, srk@ti.com,
 r-gunasekaran@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 0/3] mux: Drop usage of "u-boot,mux-autoprobe"
Message-ID: <20240131141420.GU1152441@bill-the-cat>
References: <20240131133348.182987-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XfaVKKGNfkRMuKmB"
Content-Disposition: inline
In-Reply-To: <20240131133348.182987-1-rogerq@kernel.org>
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


--XfaVKKGNfkRMuKmB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 03:33:45PM +0200, Roger Quadros wrote:

> Hi,
>=20
> MUX driver should autoprobe if the device tree has "idle-states"
> property. Drop using the custom "u-boot,mux-autoprobe" property
> in TI device trees.

Thanks for doing this.

--=20
Tom

--XfaVKKGNfkRMuKmB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW6VbwACgkQFHw5/5Y0
tyw8RQv/Y8eLWotjr+yh+eVDjWysXmrC+DAQw5wrCWbk89dFeFQkst2OYZ7tt9rX
2UZV6Rsv8ayHRRO8mEotqhg2vI4GAv+wAdpYleAduBe7V4PyTspcVlPW3SdMp5rE
QwATURMrE+VfnNBhW7eAzzi95ef6dm5O2LurNrGVcxSGSnxcuZfnwamEVeDEVlCw
JsxQZVVp6ALl0OKoulf7ST7HTPXWYjbWM+shTcSyVLmsEc7EbJPs7l+yvGVDqL8R
r3XvyAKTDWO0LncI/USVXx8r4OQFCCftowdq8RHRzEnjqbbMJ5aNdU06T79pFgea
XiHgKIxFWqgiJ2Aaobk7/rmeRo/Gl4ou2McNoUKYPjAPZCoCQ/ARLGcXRx8WOI0I
u+u4qGHEzsrTijsNOZ4wQxsSg6RiF0mLFAuyleQ4U06dMj675gatLpKCjoOVtq9y
9Eofncphl3BcYp44AdNMOfu40B5zDusP34SHrS133rhEggULGIeQ5z0KKlj4TPA0
7wVv0mci
=dJRk
-----END PGP SIGNATURE-----

--XfaVKKGNfkRMuKmB--
