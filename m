Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609EFC5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 20:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8286805D7;
	Wed,  4 Jun 2025 22:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aQ2uNVgm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25F628070C; Wed,  4 Jun 2025 22:07:10 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEE17801BE
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 22:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-60be8b6f1e2so145834eaf.1
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 13:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749067626; x=1749672426; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yoOATCiWlca5fNko3DI+2R65yYi6e0xzPSmfrrqLfik=;
 b=aQ2uNVgmmTs67fw+Mwh7vVRR1ASNam8Uhhb7M+uCXT5la/PpzW/hOypyRva4Jt9vmH
 eQclrAAu8R/i40MbvxNPy4Gm8oLG8TcvmIpeJPsT/Hsqm68wbP0fGK+pAwj7C0RGSSoX
 UdAu09SjelmdleoLUvHP92o9my74XLxJfJqnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749067626; x=1749672426;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yoOATCiWlca5fNko3DI+2R65yYi6e0xzPSmfrrqLfik=;
 b=C6egccWMCWAF1T/XPee8tyvAqSLCXQQkK/TcPMGfkbl3jywMwONDUL4rSpqnLEKfOO
 tYPHa1GsoNO/Ns0jFv4Gq9C9Emec6mUbR1ZCkbjk1VxngJinW/CC377rwtqsxA9DZJtB
 kO6kVAUndo1qVRf6SPl82Yd8ktrl5Ls8w+FLZXhUvTq7jt1sHiSVtXzIsAklwn3ftYsT
 QFdDc+FHAoTEmRNCNFLxblH3t2OazsE2P46xVSBqMDlsKPBt+5RbRRqqFItbjRqeu6GB
 DGbmF4E96pcN2R41eNXXlY0hTjxsOwZZAzts7ngy+f6eGzoEzrd9zDg155RaPsL3Lg0L
 kdQQ==
X-Gm-Message-State: AOJu0YzvBlkBRerc0HXvEL7P3b4OHnxFS7oQBK3qcuepWxr6LKzJp5Sn
 uvCFAyPGT3wWAd4ZFS8emQ2LJX7OeD0rTSHzNYj9NEi+vqcah/NPSdKu2O4j3kyKyJc=
X-Gm-Gg: ASbGnctqdqOMePuAeT3hVYRDyHfDCHiZMXWRO6ymPLCxQb6piq3K8JBu4wY2Qls/B3U
 yM9eHLkJEea2WeKy2KHE4bZiEBvExY63E0incWN4DzHAQLtgnuLMnrmsRALIvvHytqlHfLOe5TF
 AJFk3eqgX4A6Xh9ZsbFfd+CBaV0AwjKlQZ+jfLf32X1LzLsx7YOUBWDLxk0Zm26MgTNiss3T02e
 OtiyGSXwDK2i6V7lAFDeibUCp9whe0d5H3CuLCX5+g1k6W1gGpFhAHL7cUH0YQ9AX/1qfRAC+VO
 TVZfYV4g+vUnVywuwFB6JlngB2Jji7A+oIWEC/qNlJJ6/5XxTFtB7EKxKvSyxzw00W7+3rYm7Ke
 Qb6RxPEC3iyQC
X-Google-Smtp-Source: AGHT+IGyRxpZvzFBDHVwO1RXSqFEoKkHdaE3CXx8Fc5vT8mdXUF3NNnq9UnhiKLmbIjSZ24KaJNJUQ==
X-Received: by 2002:a05:6820:1888:b0:60b:c5b1:d751 with SMTP id
 006d021491bc7-60f0c86d07fmr2764348eaf.7.1749067626383; 
 Wed, 04 Jun 2025 13:07:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60c14c427d2sm2327934eaf.4.2025.06.04.13.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 13:07:05 -0700 (PDT)
Date: Wed, 4 Jun 2025 14:07:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Alexey Brodkin <alexey.brodkin@synopsys.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 uboot-snps-arc@synopsys.com
Subject: Re: [PATCH 00/12] drop volatile from global data
Message-ID: <20250604200702.GS1382132@bill-the-cat>
References: <20250604195612.2312979-1-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BWQj8QZc4RVd3BF+"
Content-Disposition: inline
In-Reply-To: <20250604195612.2312979-1-ravi@prevas.dk>
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


--BWQj8QZc4RVd3BF+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 04, 2025 at 09:56:00PM +0200, Rasmus Villemoes wrote:
> There's really no reason for the gd pointer to have the volatile
> qualifier.
>=20
> In fact, I claim that it's completely unnecessary and just pessimizes
> code generation and forces ugly casts in lots of places. For example,
> see the casts in drivers/core/tag.c where elements are added to
> gd->dm_taglist, or a helper such as cyclic_get_list() that should not
> be needed.
>=20
> Also, it is what ends up standing in the way of an otherwise
> innocent code cleanup of list.h:
> https://lore.kernel.org/u-boot/20250522165656.GB2179216@bill-the-cat/
>=20
> Note that riscv, x86 as well as arm64 with LTO enabled has not had
> this volatile qualifier, so it's unlikely there's any generic code
> that depends on it.
>=20
> CI seems mostly happy:
>=20
>   https://github.com/u-boot/u-boot/pull/775/checks?check_run_id=3D4346308=
3829
>=20
> The one failing test seems to be an infrastructure thing unrelated to
> these patches ("docker: filesystem layer verification failed for
> digest
> sha256:379cc6cd06dc3fc80e31d5170204c0cfcc25cb3b3ad457ced23bed2b38ec9f36")

Azure seems to be having some hiccups, sadly. I know from my end I can't
hit "rerun failed jobs", is there an option visible to you like that?
Thanks.

--=20
Tom

--BWQj8QZc4RVd3BF+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhAp18ACgkQFHw5/5Y0
tywmTQv/YTs9WhQDSICrghyz3pf8SuMACAAQk4YKEn7IxadSJCz5ucbHUnCVGFvS
X5yE2D4IL8L9FMQUZiYQ966WnH0aXzt30OVgBzf70qoH1xFvd3koidApmlWOVXFx
ixRVwtBK5s0GvB10bDW83GPczlzgsYd46QAMfOX39ZTFqCGw9HM9X2/Z1xl3H5Al
8vW0uYa6euvQRTnkBhMPz+c7niPsctE9zX9OYKDgzYHfNq430c7UDoiNbRlXX0eD
9hk3/llcIPpI5KLbxmoySoHk8mcKK6GFdFRpyq8b+rSX2Q8UcayiZWWyoRHntS36
+1SsyxwSl1GGDJaDEnGIMNHi4pUdN+wSIb/nwVBiL4zpXBKeGihE/0DyUTlCoe2g
WZ5WrqzostqkYk9eW1QHvHbYzAe1h+4wsf0eeNM1ZI1vy4bVW+XauK9tkT+E7Xpr
i6MWVHqC7Zw+3p6QtQzLGCD717HXX2iRqW+uPm2u6xjtE1q15kkb911Yp5fLqkt+
uWupYMq9
=KDYJ
-----END PGP SIGNATURE-----

--BWQj8QZc4RVd3BF+--
