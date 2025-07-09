Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF449C83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 15:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D5A783479;
	Wed,  9 Jul 2025 17:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T+PK0rsG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F08CD83526; Wed,  9 Jul 2025 17:50:52 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0E6F8344C
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 17:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-40b54ee16ddso53081b6e.1
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 08:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752076249; x=1752681049; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RtPPvAa4MYRAj/mJd5lKDWQUbgHapNlY4ubBPWhPoBI=;
 b=T+PK0rsGOOmiR8F7zg7O0fv48P3YNg5MWUs+EQFgFtoXnKehIYMOtxsE7HsPcUY2ug
 UurbU43DnTirD6H3rMfa51jRRPyFl4lLtuJvn9qXS4ScMWI3SZbb7tEr3E6tg6rTa0SC
 Mnq3nRZtTqZq1KPV4GGk7fvuxenyaPsnB8+QQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752076249; x=1752681049;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RtPPvAa4MYRAj/mJd5lKDWQUbgHapNlY4ubBPWhPoBI=;
 b=w2S/J9S2kb9jblU/qjkItQI+tlfZkNoDCqnT1LdZZMiaMOKZgKlP/FPzw1yWhlZqtE
 aqQovmYSw320dH6kHQH/rqFvZPxpg3MBDnsqqavycR9zWTGaO3haUd/DK0lEuxGidD5d
 n40f4LtP00D+e8wseullQfpNQpsQF/wanfGN9luPm1helVU4MRms3TtIACgoDoKEB+qI
 40BzjxEotik42kkglMnwlrOlIO9xoiVNn7CQwZqK26w/9qefifyITIRUCHliINWzJeL4
 alJsSZascHgSj8AmMKE2ppR6At7wwLC9CWM32Gn8tFf7YJcKg+JyT3/tcyIsiX2vVEIc
 I7Qw==
X-Gm-Message-State: AOJu0YzQwEk8cpb/8gH5FK9FGYyCfcRN1Xi7GKJHtEAGI0eUKNAbfVhh
 a0qUN/0DFW+fq9YTC+I/ekSXR5GEriowBPd57PZHuNiRgtKWKnslydQ7VimtdXrX/vzfT8PSk69
 SI9UArPE=
X-Gm-Gg: ASbGncsyuYRp5RFsAr6TvXMF/GCt27BFauSrB62JyJ+8uQJShdKmQJjs79MO4r462wV
 W3Qm485QrNb6/FqLzqzXjh69cIhbthwRRlBtX1B5wiX2pAhdJa4ifu01N1i2L+pHe0O6K1QeT+F
 E795rk/E4wiZZOH2m2bq7ndz4HEr1GqqhfT6Kpr8YdxpXi1oGPxfdLB7SmL/KvBzKNJKpsxyduG
 E3S8jNavg3RmOSmOVqcoEuGfNfTcwcp4kYeXJjWUolUZznyjPcFgInvjSdIm9P+6qtzUU2tFgpK
 4TLZNULT4EMazciQ09cCKtnDuKM6V2/B+bZYwa5vQg1NAc/61WNXCKjeFrbI3dkVMZx7OLhrHMr
 6dG/9uFVe7DWdXoYxMhvu
X-Google-Smtp-Source: AGHT+IEHmioTicHLyBAuGvwdhxoeFrkZSM+P7UBKMKJ0c76DTq7O2T5+9AT150sGha6EoldSfy4tpA==
X-Received: by 2002:a05:6808:2021:b0:405:6b13:ca55 with SMTP id
 5614622812f47-413aea7b6a5mr256569b6e.37.1752076249495; 
 Wed, 09 Jul 2025 08:50:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e4adca8sm1935444eaf.8.2025.07.09.08.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 08:50:48 -0700 (PDT)
Date: Wed, 9 Jul 2025 09:50:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] boot: bootflow: Ensure sel_id is initialised before use
Message-ID: <20250709155046.GA1823165@bill-the-cat>
References: <20250630-bootflow_menu_fix-v1-1-5d75ced54484@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q1541Ce8GiMzn0XL"
Content-Disposition: inline
In-Reply-To: <20250630-bootflow_menu_fix-v1-1-5d75ced54484@linaro.org>
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


--q1541Ce8GiMzn0XL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 02:25:44PM +0100, Andrew Goodbody wrote:

> sel_id is only assigned to in the case of EXPOACT_SELECT, anything
> else will leave sel_id uninitialised. Initialise it on declaration
> to ensure that it is always valid.
>=20
> This issue was found with Smatch.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  boot/bootflow_menu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Can you please rebase this on current master? Thanks.

--=20
Tom

--q1541Ce8GiMzn0XL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhuj9MACgkQFHw5/5Y0
tyxL5QwAo5TmP2cVNOMqkf9msFTYm1jd7vdCiDGtmd4BEaHxDsn54u8j6ZF2N2hG
nM9PMXiFEFKD3ftri+HNSceqtXvgWxnWLX/5pbEFzuJowO/T290SSm0U/xY8nCfS
nPYGoL6cOIufbOtc+KWYRR4NLlP/DOCpwoF/YHynJ+YSjteKiiMu/ao4b2d4g6lS
LVah6a6mTqhBzJd4XdsH8l5fn+HO886sI+epr7l1j6tf6e2x5AChOSqESWLst3Qy
Ek6katDDOTwskL5EP9JGZB9j860gn/aeLQ6iwwdKnYXWtQvriXkonKe6pPFKOZmW
Y12rTWbi1EDtZPI0CmQ8iDGUm/im2PyoGHVAMwDsfQfePlVCSZm6ZVqYOUwX25Rd
WrXv5ywn6GUvPKXqhmOuk19RIbQwF7mXE2TysTcimlGvjKYE+TXVugI0RX9rG0p8
TGW2F+nwStOHCRLAqv0vvuncVWFVFlxBbEfNQHZULsxhNdni/4FiBVJPo7vk4aBq
fobbibku
=ihlv
-----END PGP SIGNATURE-----

--q1541Ce8GiMzn0XL--
