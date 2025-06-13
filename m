Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA09C71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 16:52:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85A0782E58;
	Fri, 13 Jun 2025 18:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C+c14ArT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9D6D82E36; Fri, 13 Jun 2025 18:52:37 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4C1D82CA0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 18:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-72c47631b4cso1555125a34.1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 09:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749833554; x=1750438354; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5QuB03dTgKwm2R4blKHeYm8oMm4SiFlOUTkPF2EjFIg=;
 b=C+c14ArTVnNK6xufcT132nX9Vhn3SL8KjeUa7/5simE4bKmmFVMVTX8MV9ODpNBhPr
 FS5oclXTBrPaHQfDFYXWBcD9n9ypVEKUQNy9PAcn4/Kv0AQ8kFnbkLxd8F/BLOidriUV
 baKWDf8zd132F5k7UEDKxOfheiDO+nT343Mao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749833554; x=1750438354;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5QuB03dTgKwm2R4blKHeYm8oMm4SiFlOUTkPF2EjFIg=;
 b=qoSdaxPRrL0tbc80ykQ3Et0TRnFJs0C/N5KL73neQ/ZYMfaB4t9KXneHAaewUlVSpE
 w9+2h8w+4yJxGJpEXeJBdGavEDlMkMUymqvvwdp5cEUsVHZoOvR3E3i2OXMVlOy4Ayb2
 Oq6u+5Dl/UoLZvpFPJ0TT+k8yFaE1kU+6InH9ah12oKRzzKGO/JXCdZVSlcLWxgAJebB
 ph8s0b+Q7wx0skyaHa9BmoLikCYmNAe9TrCKxofgYX/Ra5bEJwwTvrh3xYrR/sxHd2z8
 fip2MH5t1n0E+eWR0aQ64wUGTlnyPQrsTXYDMaID0CHBuFzbZ2mT13K0DG5cqI4ib4y9
 E6fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUojsgB4sQ8mjLquVeJMlqmK7tWHBsF2Ok+wrztaL8Tov8NrVut/0X6T2yDAstAsEwGUsxCfXY=@lists.denx.de
X-Gm-Message-State: AOJu0YwJx6aaQER41KS9Z5TVHw0C5dZl/2rBsvU7BKVdKfKaaq5prCxU
 sDSo0amhCTVuYZMFmGaYIcFrxeOlomqMGmhyLAsdmF8IKSU6PMkna44moOPfH26djS4=
X-Gm-Gg: ASbGncukz7GofRl0bLjpkzY3aTvFzhgphnwW4A7/fkFD4IKdJgBf6mw0NGVn9oYbxM/
 WrGNs3WdYYwk+ZCP2gPEijZF5VdcqI3vq9trxtDfe/L0LCJH0cW5Zn7S6tKMLmLac3pIuxpjIVQ
 ZU7mEaIxUDzlzcHWlXSJcKV3ps8S7kKkI63X3gDP/RT9hBh9GonT4FjqVnzb/UXPjQKCa4ZdRBP
 z8twlQYxjsQVPFWFQH2h8Ce0MVj928imTjY8YdbTtHkecGl0pAqSJFWl8UTMdVvxFILipM098E6
 PT5o0il1bF9SO989OD1wwIhqEC2RzcAEYPrWXF9JqqBQ5NsNJ8f8ECC/s2McBr5v2jaxN8ZrQYv
 dQe748TIW35d00O4gZyYCWWU=
X-Google-Smtp-Source: AGHT+IFRyLxydqEgmmzwroqI3DEYPYF6cUt+8s59IhviDHNKv0EIyS/MkLIpXaWRHMp1e5FZ7ZJxkQ==
X-Received: by 2002:a05:6808:19a5:b0:404:f14a:1345 with SMTP id
 5614622812f47-40a7c166852mr57466b6e.20.1749833554380; 
 Fri, 13 Jun 2025 09:52:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a74172ccbsm329385b6e.29.2025.06.13.09.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 09:52:33 -0700 (PDT)
Date: Fri, 13 Jun 2025 10:52:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: rick@andestech.com, ycliang@andestech.com, u-boot@lists.denx.de,
 nazar.kazakov@codethink.co.uk, joseph.baker@codethink.co.uk,
 fran.redondo@codethink.co.uk, lawrence.hunter@codethink.co.uk
Subject: Re: [PATCH v2 1/2] riscv: add build support for big-endian
Message-ID: <20250613165231.GA1382132@bill-the-cat>
References: <20250613161258.1805957-1-ben.dooks@codethink.co.uk>
 <20250613161258.1805957-2-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UGzPvMgCaoa8jxSc"
Content-Disposition: inline
In-Reply-To: <20250613161258.1805957-2-ben.dooks@codethink.co.uk>
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


--UGzPvMgCaoa8jxSc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 05:12:57PM +0100, Ben Dooks wrote:

> Add support to build code big-endian if the board supports
> it. Updates the makefile to pass the correct compiler and
> elf flags.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--UGzPvMgCaoa8jxSc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhMV08ACgkQFHw5/5Y0
tywIgAwAmOnwZECOOf5k1UsYyatLMyYmC0OfrW3ce0eVkQqSfa9vYCVU0bpAUlvx
28FV4hdejJGZpO6ct+4sMjOLDh66U2KzjoMgdp7eFFcXDkCA+eQhoobtNcNOFLye
XUGlCBKMHFXQwx36HzRCd3LqIuEZP4WDrB9C9W2rGyvarOdKNuAidUFLYxxIchoi
JuBtQXqm3xkHqpLQLiwto6rL+57Q8GnEUP0G3WxrRDG67BFKHOX5E0dugwEmLE9g
gRyIlZFwsXWcNXrb0ZAeQsrHbrUAQiCpfXQMD71Kg7RFe/A0t7pJC9/Bnjh85RUk
Pa6VBkpuz/TcL4g6d3o4YRT/mfq+HqUNOQsmoRBjk5TFoNbfN8g4/jrpHGz/QQ31
nYcxUDiufiK6yJSKZRsAyiwqus2htbVEUohteB/vOielx6lyfvN9na09sRs/yW9E
pJ34DUilFCwT4zvb3KXdzZxl5zybjnFaGADyRlEatcRUxd9g9RWUSTsCsJN5LR2W
TcRH0TCw
=/c8h
-----END PGP SIGNATURE-----

--UGzPvMgCaoa8jxSc--
