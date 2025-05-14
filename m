Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD881C3ABD8
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 21:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0D2E82ABA;
	Wed, 14 May 2025 23:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s6zCSuET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3E1C82AC1; Wed, 14 May 2025 23:50:11 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D69E82A9E
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 23:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7300069c447so187844a34.2
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 14:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747259408; x=1747864208; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8DePTgJEw0RoUaU1owoc2R4l8g6rNPFYDJ3JC8JJS2s=;
 b=s6zCSuETSiwYzMJQIsKAVhXIwvLcwXi6CUdTbBnM1fFPD4k9OoTj0zm+aFA99xaxPC
 cMvG+HZJyaBMp+YH2/A7fveI8Ad4wx9KBbfqQCvTH0axAcO9P86keZ8fARocGaYvKrDo
 4DHDFYPa9VVJ8Mzie2xNVHvLuQJ+NFEqYh2Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747259408; x=1747864208;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8DePTgJEw0RoUaU1owoc2R4l8g6rNPFYDJ3JC8JJS2s=;
 b=KAptu53w0aZfH1NhpvsMCSlmz3Kld/KqYJxBELaMMdYgj9NEVyVW9fQDdm0mewkd2n
 ntZiJMriaM/1uSOaSxGP1LGMJ99wVBbz0+z5w1b1Odh2/PFjx1c1rozSVxcTo2yJdf0s
 V94YOFFvBs0d35gtMmxQNFPXHnbYNmWIk4t6ny2zYmMJZAw+IjXQtm/Za9u2b7twkkr1
 VwOeRoqJTd7inpiPax0fFgM7eycvfQhxiZUGvLDPW1mJneEcd9yhxqSjgk7J0gnVlzIt
 KxCTu9XdlpZC72PUnl/xecb+N35w43VAhlOe3frLaptyAW6+mR9Su7BrPnnp1AKbH61A
 ijmA==
X-Gm-Message-State: AOJu0Yz2E7j+PXLLYpTRcD0a9H8CSOIG1zpf5c25P/BBzKdQxLtK0aeP
 INUoJK0+x3WCkyiCVzPGvxFcSVmazRuip0nmcQFZjFQlXFJErGGuuqZCKBzYmGM=
X-Gm-Gg: ASbGncup3DBuO4DnjoDQ2pKGTD/swc8BoZpyUv10tyGvExMbwfUeJ8zs0wtq4g9FYVT
 JMYWTqwz4gv4eV7BtvrjX/CNQZl93npVo2G5DWAA+AAZ3Ro9SPVfUENLPh9xRQ13xiYzZlgtpLL
 BZ61yLizvJgU9DUrAKlSSMYDaPUTx5+mAcUxf8Cmg3lWZx62zQ5xsPBGR+P4ErnJGNBS1bBltsJ
 vgl5Yr+3G2XSmK3miWgAOVeCd8YnmY1L3FqksOrrsw4B/JG5YGiKhqYhRLaJKhnTO6Zw0xQaggK
 En/KemWsL+1c+43NC8by2WLVgvV7TWxJmZpeqIdlTpk8a697briiccs8OHmEJlAqj510E7f9cM+
 trZEBTeAEHviU
X-Google-Smtp-Source: AGHT+IGOcb+AZe53Gv9GrOlhJG3zt+rs6lSY+SD41CA/V72iRGyR5mJaJrExLim8W2tG15aJ2CMkMg==
X-Received: by 2002:a05:6830:6305:b0:72c:320c:d898 with SMTP id
 46e09a7af769-734e14f6627mr3025638a34.22.1747259408070; 
 Wed, 14 May 2025 14:50:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-732265f6923sm2611169a34.58.2025.05.14.14.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 14:50:07 -0700 (PDT)
Date: Wed, 14 May 2025 15:50:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Uma Shankar <uma.shankar@samsung.com>,
 =?utf-8?Q?=C5=81ukasz?= Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v3 00/10] ext4: Overflow fixes
Message-ID: <20250514215004.GC603748@bill-the-cat>
References: <20250510130642.1575114-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7+oKECzkMHcxdKH1"
Content-Disposition: inline
In-Reply-To: <20250510130642.1575114-1-sjg@chromium.org>
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


--7+oKECzkMHcxdKH1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 03:06:06PM +0200, Simon Glass wrote:

> This series fixes some potential overflows in the ext4 code with invalid
> or malicious filesystems.
>=20
> To assist with this and future work, it brings in overflow.h and part of
> limits.h from Linux.
>=20
> Changes in v3:
> - Split out into separate patches for easier review
>=20
> Changes in v2:
> - Add new patch to bring in linux/limits.h
> - Add new patch to bring in linux/overflow.h
> - Use Linux macros instead of gcc built-ins
>=20
> Simon Glass (10):
>   Bring in linux/limits.h
>   Bring in linux/overflow.h
>   ext4: Avoid expr in declaration in ext4fs_get_bgdtable()
>   ext4: Create a var for the number of blocks to allocate
>   ext4: Check for overflow of block count
>   ext4: Bail out of no_blk_pergdt() if there are no blocks
>   ext4: Replace multiplication with an existing variable
>   ext4: Set a max limit on block-size in ext4fs_init()
>   ext4: Make sure there is at least one sector per block
>   ext4: Check for overflow when allocating tables
>=20
>  fs/ext4/ext4_write.c     |  25 ++-
>  include/limits.h         |   2 +
>  include/linux/kernel.h   |  12 --
>  include/linux/limits.h   |  21 ++
>  include/linux/overflow.h | 443 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 487 insertions(+), 16 deletions(-)
>  create mode 100644 include/linux/limits.h
>  create mode 100644 include/linux/overflow.h
>=20
> --=20
> 2.43.0
>=20
> base-commit: c5a631df96de7421d10ee03dceed1b79db213026
> branch: sec3

Since this commit isn't mainline, there's nothing further to do with it.

--=20
Tom

--7+oKECzkMHcxdKH1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmglEAEACgkQFHw5/5Y0
tyxqpQv/dGKqUp3AcDDYHZ6V/0e1ccpHEgo5zjNSQaYBDZbh0mRhvm9LjdNJs8cd
PnSeWNOa4FWT1V6Pvdrekf9ijsVuKNxaEBZzfOKwsaT83FjVNSVFUFJOViQsq3CR
KY8VVKVTwS82Tg6lIydnbt19y1GbCpED89kdl2BRWZdaSTK68ZNAxz+q7tFc15pj
QCrlOnSAUCPirJOhoJ/rzvvFkiP0WkF60vU5rAdsnAwE1xNLtKnHJ3OkxV2VM5jC
NClWJsa31NRUKPhEG+npSWBOItABL1tGIszELLrGQmIxdfk6f6U1LOYDzJKlTqZN
j9Fu1G1YMEYgefoHueZ9vwpu4HUZKJ7IeJo6cnj8mNJ9clyVsOUMY6l9ZQzZoxth
6MR6ukXgLgPbA0E2qQp5jNYNyyo89Y8WvGvWYHm/en1RiejpRFK4GfLdf+lfJsdN
KwIy6GffTRWEtyBTPTlTf6Kx60TtMbpgVe0xS3/rkU6hXcHDcK8YDNCMbuHstEom
zQrjFRJv
=1avg
-----END PGP SIGNATURE-----

--7+oKECzkMHcxdKH1--
