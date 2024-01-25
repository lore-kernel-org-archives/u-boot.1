Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A00C48260
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 14:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A50CA876A7;
	Thu, 25 Jan 2024 15:16:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pzSjnDpH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E87C876EF; Thu, 25 Jan 2024 15:16:08 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46619865F5
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 15:16:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-682bfd39ac5so33950866d6.2
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 06:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706192165; x=1706796965; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cmy9286LKMsKpSq4sm8RCcfUJwRiZ6FsL/ChEF6TwdE=;
 b=pzSjnDpHaZ0MX5RUnLHFgGUj+28t/7iN5P+9Qyj2qVP4NFriIBWT5Q8YYDDxHH95M9
 ZN/RMfvEIFErsbDvUeH5OTiRnK02lv2VVqQQFcvwYYXGYuYuRicVfmS3A3ouBU5LS6CB
 yJPKjLTSkDaHb453RSNmyDmBEYBKeLV+C7fYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706192165; x=1706796965;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmy9286LKMsKpSq4sm8RCcfUJwRiZ6FsL/ChEF6TwdE=;
 b=cD+veDRotxCkvGax/zH4vJ8m6J54TufWAjNbOhEMZhrD75HzA8iUJNzMxCL1cNHUkM
 9gxivOKmIziFjpYhcDKdVn17UJ5+rPJ6ipBuI57flj4OdkW3wb//ZuEUFZw6Qs5uWWDv
 2MMKNydrWoyV4UnZ9dvNZ0q0HCMV7LbDcAxkD0qUAXloTK8l4zxcrVF00KETNw4MLCIu
 3j3hty4TR/YvAG2HiO92rEqEiLPPv42nEPcffpsKEuNLqdyCy3yPSNQMzLkxUGsjQ3N6
 Iho0PdybFSkowSTNe/GQiu10txd198UMooePX5E57++uTVhqz7PMzX90DrNMJ8FVBv93
 1gAQ==
X-Gm-Message-State: AOJu0YxNWXBQZh114X7dC14nNkcQQvb4zLGrbeZwGDaQoQe66ge5wcrU
 T3nVTJwK30gEMX6X2lBZCra7+EDTR2zYzQqwLzWoJXYqYMJPae/G4qUtQNq/nHAW0VpMtcGjnYH
 k
X-Google-Smtp-Source: AGHT+IE7tlezC+Ky3HSaG3lH95+KnjQDQAq6RNnusVumstbPZTwU7kF2dmMUQYEx5qPH6Ee7o/FIMw==
X-Received: by 2002:a05:6214:e82:b0:685:56e3:cb8f with SMTP id
 hf2-20020a0562140e8200b0068556e3cb8fmr1231409qvb.88.1706192165081; 
 Thu, 25 Jan 2024 06:16:05 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 oj10-20020a056214440a00b00686ad84d8c1sm1663825qvb.131.2024.01.25.06.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 06:16:04 -0800 (PST)
Date: Thu, 25 Jan 2024 09:16:02 -0500
From: Tom Rini <trini@konsulko.com>
To: kleines =?iso-8859-1?Q?Filmr=F6llchen?= <malu.bertsch@gmail.com>
Cc: u-boot@lists.denx.de,
 kleines =?iso-8859-1?Q?Filmr=F6llchen?= <filmroellchen@serenityos.org>,
 Bin Meng <bmeng@tinylab.org>, Leo <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 1/1] riscv: Support building with Clang
Message-ID: <20240125141602.GJ3652023@bill-the-cat>
References: <20240120002049.GO12635@bill-the-cat>
 <20240125140659.28229-1-filmroellchen@serenityos.org>
 <20240125140659.28229-2-filmroellchen@serenityos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z/S7Efqi7IHhI0LI"
Content-Disposition: inline
In-Reply-To: <20240125140659.28229-2-filmroellchen@serenityos.org>
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


--Z/S7Efqi7IHhI0LI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 03:06:59PM +0100, kleines Filmr=F6llchen wrote:

> The -ffixed-gp option of GCC has an exact equivalent of -ffixed-x3 in
> Clang.
>=20
> Signed-off-by: kleines Filmr=F6llchen <filmroellchen@serenityos.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Z/S7Efqi7IHhI0LI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWybSIACgkQFHw5/5Y0
tyzXbQwAoGs1/GL9eciB/eeUqfrQt2I/ruRcQDefeD/ozjrhthbpT/CMR6on+Kmu
RjYBy20dQwWHPWbRkp8b0jjJzTtIQvKG9vVXIbe+dHr0rN+BMMz4rp/CeKQgLPhL
/s4lQE7gykjodR7c5K5Ctg2WfqeQUvEaCyY/g2Rycr+AeGcMu9df2xMLbS+eGtue
BfBGxnJeGJtJ3XO74c82UW5EukMH01D+cbr5kLzj+C14Z89XzpA6WAqirV8/+AaB
7kKEWvNANW4I+1Fvq8KHeAwznEm/TbySX3YRmVQzBhSlkwUnxByhQvQif6ymE86n
Vsd+vFl9C9AekxjdzFkoFDGKqUDwcCR6se1BTRIWIqLxA+qApOcNdrH1K2WaC4T3
85V3feBSigl0Ii3iJzl3aT9C+wwNZOItDZY4xerxWcEmRjZVGakwfiuNcIfkwHdQ
gJ6Q90lHDNLLWbMOmaAkUXCboNsygAmh/2aSf50auA2HKDbcE/vJW4mIAeG5ued2
oZHTLv1d
=Ihwm
-----END PGP SIGNATURE-----

--Z/S7Efqi7IHhI0LI--
