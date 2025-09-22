Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D47CA100F
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 17:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4EB0832F9;
	Mon, 22 Sep 2025 19:08:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CPI/wbL2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21AAB832F9; Mon, 22 Sep 2025 19:08:05 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A53EA8004F
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 19:08:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-74381e2079fso4679373a34.0
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 10:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758560880; x=1759165680; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aiBe+I4PPBOCysCrKlfxJilqPnDkQcxokRNBRV19piM=;
 b=CPI/wbL2aguVJUPD8nav/n3a2rxMBetGx94sDtWvhT+BnRnygpKkoHod15uTiYP0j/
 g4hwrowq6Xfh0DteDH+cwhbuhXAFu6t3daodqP+z5O0XL6y2hG68P2u5kahZid3e69RY
 GZnmRQt64v62sCjvPGD3AKz28vDm4SlD6XIpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758560880; x=1759165680;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aiBe+I4PPBOCysCrKlfxJilqPnDkQcxokRNBRV19piM=;
 b=bwK/ADjSmdUx9KGqjHBFzDRl4Z/y9XmCj06P9t+MLw3AHDYnazxAWG4k4deIY6eNCQ
 FqZdNQz4jPI8gw9nXtM82XZLfAN9zbWQFyubbfI/BCRndH1s4P24pMTP35byjKQ9VKbH
 HfypXJt/d9sTVZ9/bUkqRa2e0gSe+DZe6Zd+GuOvFMkiP+c4oe1O5rbh2dZWSmQTAi8f
 3MulLf9s0eAgZm8V+Q3nf2QPTpIHRUORWbufcLvdRdTQKgrf8lf5gZlMuun1qP0+QVjr
 cuke92vMuOhAtUI7ZwGlpOArCO7NdxvVZ83ki27jahtKVCMA1ycLRHXSdmXp0CQNl4cL
 R2jg==
X-Gm-Message-State: AOJu0YwaWNAmcvasukrhglO7fxux4ZaWn1LXmtq9vw6ubyieRRUL/cJH
 hzjUneSb/J03VmBHFqH36qsUoVBn/5grI0D59aMKIj+ZeU+cuNdvZv7Tm8s0k5wBI/E=
X-Gm-Gg: ASbGncsz+IBRkj9qQYUqoPK203ClzznO+Ng5e0XbDr1Mgp203tE7nKoqN071CJSMRXJ
 OgULDaG6LQRXSBq12ln8+AabBWvRK8xJOM8Lh0LoEG7lexbAM4MDpJJC6ty2KM5PKFCV2H4ia5D
 aVhriU5sFpYaIGtNdrBxGBCxyKU3r0AYFzfL/98eGIqDMPsl4EzuIb3hH+iK4RG7JEiqeFmEG8d
 XpSinbm8MqPG/0bDlnB6AxEk4TIm34CKsuzBpeUreZt1GwHsmPmjS5l6dqJ5siFZBqnhom7Dfxk
 53LlE6smhBwxaxCvlGHdpzAvhbfpieZg9KA1VwWi+AfOWOeSh2aHdiwhAJ2wLIstNWpCfHhhxjA
 58L4sWfunxOY4xKVuBmPjEbmeadI09UCaJ0OSU3tiwHyi5xWJGhVcDTRh
X-Google-Smtp-Source: AGHT+IGx+Di0lFTig54mhMSWugO39ecExQeqI/k0kGCpcsLGxdPjHTKTZCXNOcCE2AsN0XOyhNp2kg==
X-Received: by 2002:a05:6808:2f0e:b0:438:bdb0:89b6 with SMTP id
 5614622812f47-43d6c24f547mr5982502b6e.34.1758560880167; 
 Mon, 22 Sep 2025 10:08:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43d5c85ef60sm5083700b6e.26.2025.09.22.10.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 10:07:59 -0700 (PDT)
Date: Mon, 22 Sep 2025 11:07:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20250922
Message-ID: <20250922170757.GD124814@bill-the-cat>
References: <20250922141915.208136-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KBlm/GdYCgB7k4dx"
Content-Disposition: inline
In-Reply-To: <20250922141915.208136-1-festevam@gmail.com>
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


--KBlm/GdYCgB7k4dx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 11:19:15AM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/next, thanks.
>=20
> The following changes since commit 464800d91b036cfd2df26598d8df2ac72d4569=
dd:
>=20
>   Merge branch 'next' of https://source.denx.de/u-boot/custodians/u-boot-=
riscv into next (2025-09-20 10:02:00 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-next-20250922
>=20
> for you to fetch changes up to 424103865662603d821028734ecddda8802e43b3:
>=20
>   doc: phytec: imx8m: Style and firmware update (2025-09-20 17:48:20 -030=
0)
>=20
> u-boot-imx-next-20250922

Applied to u-boot/next, thanks!

--=20
Tom

--KBlm/GdYCgB7k4dx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNGCagAKCRAr4qD1Cr/k
CiaYAP0dG8+irNCp75PF0SqdaCD3TbRjUA9mOuASMDSwUULlhwEAkeNrkyW2IWiH
cK5fnqrani3O/PwBwLtBG2lPvVAtjAo=
=rSMW
-----END PGP SIGNATURE-----

--KBlm/GdYCgB7k4dx--
