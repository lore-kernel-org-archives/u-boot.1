Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C48E9E31B
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 15:13:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E29EE83A47;
	Wed, 11 Feb 2026 16:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XnEYf25G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA38483A47; Wed, 11 Feb 2026 16:13:04 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A03FD83015
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 16:13:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-409de4132b5so3268149fac.1
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 07:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770822781; x=1771427581; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/h6e+/x3ltoCXGsgvC05VMhzxIzhBtWjKSb4fl9MRpk=;
 b=XnEYf25Gmqyfml++cGobqSU0WK4tDBKVZDBZkD4RRCuooPAjQn9jx8w6s7qM7frtUF
 ZNMOMggHndoGruoolorpzPnsDCpmHfhvUcVFO8BEWV1e24+r1SW4SpHqZWFAEjFeDGlJ
 Bc89Vi0Dns9cKQAGtxPaYGDYz4fVHj6lv28aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770822781; x=1771427581;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/h6e+/x3ltoCXGsgvC05VMhzxIzhBtWjKSb4fl9MRpk=;
 b=WauWT6BDCA64I323bQnox+WWRKiKl4IX1Bu+znAXKeZe+3Zd1MyZIrOXmAbII/IThh
 CfYFc+EsgVVSjO4QXVICdhiQVegIIlhXCrhbZl+T8QFOIiZHoWZyQluMXqDXShneesDZ
 34DiMBubvihceqtubLUnBRIaeED1cEx7R9kP521qHvYcfMoNMThhkVDJlTpj0nDM9KBz
 biAVY7DK03c7CIMAJJH8Lfy/64Ee2VX6ijTXGzetUFyXzJ9TrDh/bi9uDfgV8y0NKmxu
 6yyV5qOgzueyp5mq0BrRo1B6FgrtXugwF5U1ybMYTnNAWFGrFImSwxa82E7cDWfy88Es
 C7lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnVeg6Zz3Xdm6swRSM53Kku5DBUIkVx5XHxNDqo2oiCqVWcQEWwk9dYmtVaDFM35sXKQ3OmXI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9/O9KWdKTtqXEK5fONqcJ6VbKagbcBtQK6uahNNfRJhUyjAxb
 3C9lzhg6so2ZSw/DXLUQNuXACDa/WyRJu7wrcTtICMINFTYqZ2GyLrv7nFgJ9ju3N1M=
X-Gm-Gg: AZuq6aIXS0OORL95iPIGZemAombplpa2LSB1U6uP0X5tbNIgNjpn4+Ag2x8e2uK8mAD
 Qxolo+Qi+SNAKbKWOXfyRkaaD5Yx+alo8GRWSAd+2gbwsclxlI/h+segbcgkQPrzC7UFmcAX6gE
 PPmpivFo0/KeErt0Gp+yWvu8IJ3Rt2m/HHokysCIFwAE0ABm9LRu/xJY9O5XWzJv+nAt/DBUZ6e
 1ztY3L7GV8x0oGoZjvoyDIVc83EgmLUalpR/iZko0iPiZfOWR3n6UGQoe53c4LEBKa9ouZRVjSl
 XDKOqcL/PtSQaYxY3D86GoRicYNqjdH/R4xIfpjXUOqXkJpQXr2lzGzueY5+PD3dCYCMX+pvH0F
 6ulfsSeXNSeFb8BT3NEkGFFVrkVxm8GXceWEos3p1PoCdBIWsL6LMcNtt4fiEwca+Z4mxgkr+v/
 5RWQIlHMQc/jlyj2gO/9IAb4JbBBkjHp5TTOVpvrQbkqwsR3mRWHAEj2/kqYKjlSB8bXW5EGQdH
 uAu+5gWibzQo7QoS3djSSMddHyrBnlwUwUT3eZAyoa+yI9WhFhEzXnUWDAkfQ==
X-Received: by 2002:a05:6870:f29d:b0:404:ef:a54a with SMTP id
 586e51a60fabf-40ea9383952mr1796265fac.5.1770822780767; 
 Wed, 11 Feb 2026 07:13:00 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaf1e858bsm1487367fac.19.2026.02.11.07.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 07:13:00 -0800 (PST)
Date: Wed, 11 Feb 2026 09:12:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com,
 Shantur Rathore <i@shantur.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: Re: [PATCH v7 1/3] efi_var_file: refactor to move buffer functions
Message-ID: <20260211151257.GB2747538@bill-the-cat>
References: <cover.1770119483.git.michal.simek@amd.com>
 <1f50d76c2370b9b032e73c35c05246cc70255b28.1770119483.git.michal.simek@amd.com>
 <CAC_iWjKxshi4fEtUvvrwGrd8quSUNeeuqjTV=gFrW4x6uXi55A@mail.gmail.com>
 <CAC_iWjKyuoFAVVTv=+tajWJoYtEv4bxebWMAxqUehSEk2YMQaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I3aXpLjMty7Kx+QL"
Content-Disposition: inline
In-Reply-To: <CAC_iWjKyuoFAVVTv=+tajWJoYtEv4bxebWMAxqUehSEk2YMQaQ@mail.gmail.com>
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


--I3aXpLjMty7Kx+QL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 05:04:00PM +0200, Ilias Apalodimas wrote:
> So this fails for a weird reason
>=20
> Some boards don't have FAT_WRTE. It seems that the Kconfig order
> matters and those boards pick the new option if SPI is enabled.
>=20
> This fixes it
>=20
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index c13cb8952caa..0f6f927ddaf1 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -112,7 +112,8 @@ menu "UEFI Variables"
>=20
>  choice
>         prompt "Store for non-volatile UEFI variables"
> -       default EFI_VARIABLE_FILE_STORE
> +       default EFI_VARIABLE_FILE_STORE if FAT_WRITE
> +       default EFI_VARIABLE_NO_STORE
>         help
>           Select where non-volatile UEFI variables shall be stored.

The behavior of a choice statement is such that if there's no default
(and in this case, platforms don't set FAT_WRITE, so there's effectively
no default) they select the first presented valid option. Before this
patch, that ends up being EFI_VARIABLE_NO_STORE but after this patch it
ends up being the SPI option. So making it clear that the fallback is
NO_STORE is a correct general clarification / bugfix. It can be its own
patch even :)

--=20
Tom

--I3aXpLjMty7Kx+QL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYycdgAKCRAr4qD1Cr/k
CuPLAQCpLSC9sibdbpJ4ka07fMqfF5l6CKruwXbEPA6L8MI+KwEA4hCtdKEerBxf
sZq8TszwFRl6qVP24OMLESRDJqj3Ugk=
=Lrfk
-----END PGP SIGNATURE-----

--I3aXpLjMty7Kx+QL--
