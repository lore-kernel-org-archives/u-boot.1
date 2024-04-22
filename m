Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4D5C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 17:44:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FDD4884B9;
	Mon, 22 Apr 2024 19:44:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aEUwRgmt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 582F3884BA; Mon, 22 Apr 2024 19:44:44 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E9A6884A4
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 19:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-69b4e94ecd2so17805656d6.3
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713807881; x=1714412681; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3+BMuwS5XUzMcszqSI7A7F5l1/5MjawhlgvMDmgbJx4=;
 b=aEUwRgmt7zBS9YEgL2gAc0Ky8Upj7S/fhGQFhlUUo2crf9y3F+yzEAQTX29QHKXW1u
 ruh4cn0xrjlebjXJq0BMBfIEbAv5YG9+fG2EnJz4mpAiOQ8fu6je3M/L6ZHzIVND8ZHz
 fMcsXIPW6bq9PUUTv5olrm8FgaoXj5/Zw11uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713807881; x=1714412681;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3+BMuwS5XUzMcszqSI7A7F5l1/5MjawhlgvMDmgbJx4=;
 b=oHejwvHfa6ujEWSCKdouyLKUjg7/QUxEZoLtJWkikrJuQBOSuyfgmWPKFMTxGXkBMi
 Qq8aL4dZGz0TtqyYuuVqyKeXIoRDpbtOSs6d7NJJGI9dbJmh7bWpyEnnuhhMrtYZXzgE
 BguLS1GSeqvovbmWaZRtEW+An0yjVFJ+hUNGDV5KiV6wUgBDb6926waHBmdjHsADTQy6
 PPiNyTS1Jkg9dLPxPOHlPjsNYvXeadFv9TS4239omtg+sbLmaol/SYSYYk8MmOsRTz3R
 FHcCkunAEGIY4gKP/uuq3iA7cFC5pY0hbzYUKIDg+oSRAgCOrQKrQNRsU8M1VHPBmWHU
 kiRQ==
X-Gm-Message-State: AOJu0YyfD+AaWbgqiE/JC4yAdEelWQ143ncu6fJuTK2bMSsF0TlF2H1g
 uOgrCI2wnbk75r3098J/vX7TDnQLZs7pQXkSRwIxzXfTExPH4jvvoZUETKCr1+gsnTMcQ2dJ9g7
 z+hc=
X-Google-Smtp-Source: AGHT+IHgjPAONftoK8zFBRBaSLFs1qAlbjMVn9d6Nn1NUxmIelnmYAhrNSD/g5w8OmK0xtcViurz1g==
X-Received: by 2002:ad4:4201:0:b0:69b:1ea9:c715 with SMTP id
 k1-20020ad44201000000b0069b1ea9c715mr11065378qvp.26.1713807881077; 
 Mon, 22 Apr 2024 10:44:41 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a0ce48b000000b0069b6c831e86sm4432374qvl.97.2024.04.22.10.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 10:44:40 -0700 (PDT)
Date: Mon, 22 Apr 2024 11:44:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Kishan Dudhatra <kishan.dudhatra@siliconsignals.io>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: gpt: initialize partition table
Message-ID: <20240422174437.GV1054907@bill-the-cat>
References: <20240422172335.166727-1-kishan.dudhatra@siliconsignals.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0KqDBQzlqKw7Pff7"
Content-Disposition: inline
In-Reply-To: <20240422172335.166727-1-kishan.dudhatra@siliconsignals.io>
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


--0KqDBQzlqKw7Pff7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 10:53:35PM +0530, Kishan Dudhatra wrote:
> If partition init is not completed within the gpt write,
> the gpt partition list will not be updated.
>=20
> Signed-off-by: Kishan Dudhatra <kishan.dudhatra@siliconsignals.io>
>=20
> diff --git a/cmd/gpt.c b/cmd/gpt.c
> index d7e96529a6..2d652f480a 100644
> --- a/cmd/gpt.c
> +++ b/cmd/gpt.c
> @@ -643,6 +643,10 @@ static int gpt_default(struct blk_desc *blk_dev_desc=
, const char *str_part)
>  	free(str_disk_guid);
>  	free(partitions);
> =20
> +	/* initialize partition table */
> +	if ((blk_dev_desc)->uclass_id =3D=3D UCLASS_MMC)
> +		part_init(blk_dev_desc);
> +
>  	return ret;
>  }

Is there something more generic we can check for here? This sounds like
a problem for any block device, not just MMC. Thanks.

--=20
Tom

--0KqDBQzlqKw7Pff7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYmogIACgkQFHw5/5Y0
tyzCUQwAnU4u+2g23xwuwwYIgN8FdHXOs3S2UqHLsodX2K/4M6LPBjMKjLVL/46i
SQU0AUfPyMgQiw0pJLqXEFvUknF0wnUh+J/dh6N7oSs4lv09OZHF7IqWjxuyYxCJ
iqBEk5SyEGrCHGgelTN4auug7aNaHux9Oi21YwpEF4CohUC+4YQTdVz4tnzMWpKa
UFw2imFUWlCqLRUGsMocInu3xmj8kNbNqQozSgd5smGIaMSeWyC9vpi/ePBbjb0R
QtQ3Tnoyp/BupWM7gUmFUPtfiil1ZNPJG3sNmU9ULE5oml6BuswQXLR7y5DQ69Ik
5hm49OVc5aDse33nx5zDB6YY9J3VNn7PxISKptPK+3qBxu5iv0HForgQrT4xtS+J
odGd+fMhDZNI4SQLSIUTP1hRa4aKT/djPmjpSnH6/QuJh3OFI4fO9FBDXcjFPzN4
K0ksAFVQhRUHh3DAyZ/WL509sx6QCUZfJx3vk/uC4rCs88aD2Rl/mskr/0yb3wAB
sP9vw0iT
=Pa+P
-----END PGP SIGNATURE-----

--0KqDBQzlqKw7Pff7--
