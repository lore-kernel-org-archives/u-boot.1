Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45EECDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 15:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D73D84FEB;
	Tue, 17 Oct 2023 17:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UeBtV2sX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88A7785DE0; Tue, 17 Oct 2023 17:38:51 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7112803AC
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 17:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a7cc03dee5so71331497b3.3
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 08:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697557127; x=1698161927; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o5GGxyVU4PEM5WgrQQuFIr/Ah6EBRqmYRhBDxhJ2HYg=;
 b=UeBtV2sXs78NBWzeCgxmeYb8Ni3Fz6TwRwtcTogdjCiZcFmrQ47jfdVmSoiCRJAF7/
 HQSEC+Hjjz7EnTQ/8QE/dIB0RNe8eHiC1J1segZpkgDvM3bZ2PBB190LtmMHWXViYxP/
 fbJebn+m3NU1zoZpkXmEcZ+xWqKDDW+sgHorw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697557127; x=1698161927;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o5GGxyVU4PEM5WgrQQuFIr/Ah6EBRqmYRhBDxhJ2HYg=;
 b=LXwjGogZchOy6ZMqo+5cK1SUbjItA8g5zn5VcYgcoZaCbM8W0066fzTKYcVeerdBWg
 FXXpzMcgXchd6IYbL3HzOaoYYK5doz40BrCTU5G4IOEb6z6wGOS2/VLpRvRnn4DMkjPj
 bbY2ygnUA2MOG9FSBsq9O0kTnINoj1QLgusdn1umBFi1ua/ELUqO/m7TYhwGK3gMbAba
 9nPlC4FojpjSGmBZlz6t5Bx+uV/01wZfEbK11729F23fyXcDTrCcX71q7tc6j/jZGar4
 VrE9ll0CUTS1aHZa+iPt+0vgyTHuY9Au2lvHB4mANw/BeR8Auh9HeIlnE5ECcY137g4F
 QrCg==
X-Gm-Message-State: AOJu0Yyb19UCYGRfEiWQ0w5Nbedozq60gJr6JX9mOK1/5HKjddaBj4eg
 aI8u6O2Ncc+ExzW4SwI5Tq+qZw==
X-Google-Smtp-Source: AGHT+IELe10rcU/+GtKdemT5gycI3d8tQjTGMsr7w/kzuI+mhmHC+O4W4zBDps/U1VK0rniujQK3Lg==
X-Received: by 2002:a0d:ebd5:0:b0:5a7:fbd5:8c1 with SMTP id
 u204-20020a0debd5000000b005a7fbd508c1mr2874585ywe.17.1697557127555; 
 Tue, 17 Oct 2023 08:38:47 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 v194-20020a8148cb000000b0057a918d6644sm694175ywa.128.2023.10.17.08.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 08:38:47 -0700 (PDT)
Date: Tue, 17 Oct 2023 11:38:45 -0400
From: Tom Rini <trini@konsulko.com>
To: Yu Chien Peter Lin <peterlin@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com, ycliang@andestech.com,
 kconsul@ventanamicro.com, bmeng@tinylab.org
Subject: Re: [PATCH] riscv: Add Zbb support for building U-Boot
Message-ID: <20231017153845.GJ3119521@bill-the-cat>
References: <20230809104930.7462-1-peterlin@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2U9ZZOL+NKePaazS"
Content-Disposition: inline
In-Reply-To: <20230809104930.7462-1-peterlin@andestech.com>
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


--2U9ZZOL+NKePaazS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2023 at 06:49:30PM +0800, Yu Chien Peter Lin wrote:

> This patch adds ISA string to the -march to generate zbb instructions
> for U-Boot binaries, along with optimized string functions introduced
> from Linux kernel.
>=20
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
[snip]
> +config RISCV_ISA_ZBB
> +	bool "Zbb extension support for bit manipulation instructions"
> +	default n

The default is 'n' so we don't need this line.  This can be fixed
in-line while applying if there's no other feedback, thanks.

--
Tom

--2U9ZZOL+NKePaazS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUuqoIACgkQFHw5/5Y0
tyxY1Qv/bZb698d6zxWezeuUaIW/Owa6CTqxH8OAtePMitaQqjToHY9vobyzWxl9
LWQSn0XAbQ14d5rhu9YqhSKICXbXJirULFgQiB4vH1essTjjRLtmtG7wm94UYabZ
0yS5su8SuTynw/Vwx9ZyeaJN4pCyfRr5LDsRo0uAKyg5EVmITl/D7VOU+thb08ih
vfnhCkaXs6tQSgZjfFg9vncUgwAknzw//FnKpY2Z73MeGotmi3HRPCYkkchjaffX
5a1W9xcVzv3avXhbkHju5ad5ZStFWtUvtF4omZ1OfElL39dIjxUgznDKe4aa17wk
I/DpkbxgrRYs8IVPQEiZpW2bVUoOJHXOqevJxJNrZ1Uo31KwAajTAC+EskwTFBpe
Cv3dKk9uOMqR80osDpaYGeD0oYp1zokSM04XYT6/VEx8Dx/e6bZeGwm/QdxYyQaz
bnbjks1EgHdnU/SQ/2/YZj45HZldOUXC8VhyJyDba5ptCAujlHREcETO4lB/n7V2
4mJdhWlT
=/rtq
-----END PGP SIGNATURE-----

--2U9ZZOL+NKePaazS--
