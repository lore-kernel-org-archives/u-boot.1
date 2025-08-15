Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E513CA0EE4
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 18:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0400783AEC;
	Fri, 15 Aug 2025 20:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kNy96g5u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F369983AED; Fri, 15 Aug 2025 20:58:25 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBF0283AEA
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 20:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-88432e76dc1so139158339f.3
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 11:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755284302; x=1755889102; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Or7qpOtUhNEC0eH9fYk2JpaAZAA9z3ABK7FvyZo6ik0=;
 b=kNy96g5uPEqAKPMazHdAI5W6IzfzMbNdjWz+N2a5TN3RnQNIXDUsgoq2mO9ydgcWgI
 vu2A+wi+FcpqhSpVA87Vus7Ix3WtMNtIW28oJK89m2iI5gj9nylyTge0PhcktdtjKuwr
 TMNIe7/dbTuUTpBKRLDddPr4Ys6HDXP+ufCZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755284302; x=1755889102;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Or7qpOtUhNEC0eH9fYk2JpaAZAA9z3ABK7FvyZo6ik0=;
 b=eHTVBrpFWeEAuw6N+SxAnpdxCxKtuhNDY05EmGtGpVS7KtTKzJ9p5IrWwNmVRWy6Rz
 W2N2pKxLHCNsUYAMy3/9mnz4BDgz+6w8lxefhQP09uC+LzlXzLZHUZt5c4hks33+lR/z
 y46zBacqwANIX3R5GhrdDT9kct9o25EDYvqYx4H30i1Xsn6YPZsMr4SB+vaSLCflZ4Qm
 VMUIdUVgunbHxohrevjg4BtiUjxlidzRpPKy2GkfFXS8KTe98k6iyNqnULuXS/2QQ+ZI
 ByyLHm9Wxjjd+KZy/fqz22zaDdKdcnmY2vuD1DQv1mIXsvrU+BUQtYwS2V0hpWb1b8a7
 k+Gw==
X-Gm-Message-State: AOJu0YzT5dlt7vkwF2isClQ6ISrqY/E/aEYeRAJBKmWr4sfd3+u4vu+m
 mPPvMdxfHAu28c/jcVg8FeoL5fREGTqY2KB7yQ3mKPrjsvlNcrtTTc68tfbLiEZd+9g=
X-Gm-Gg: ASbGncut8uQkJZD72ag5I3N436zP7XW/BN0KY99zqVvBdFOWFxNZ844PwlkUAq4dn/3
 rm6xFC+opHdzy33B50wMSFCQ8sPKMoopllV2dJMpDyOiuRl0kO3ENtPBdK7f0VJY1Jx8GSHzUOm
 XanJd7DmKl+pjTIO2cwYr2krKZDq/M0BRZwk/nV3VVRvpzDMqb/CoNPucrPIzlTT9cadDdbQnvy
 7van5SSBW+okXNbmn201Equ/0FHrjk2JXlzHvYkBVS5cFJhbLoGsxpbyh64IB/4vdHSKx5BaXNL
 GYy72Siln6kkDwRTA1FNVJo20nflp3/sw6V9LSQQE3QQaBWCUGjUMdiy+ItQuiYX8AAG9m94v1L
 khfjjb0VIk4Zlepeb+RL0mfG9n95oWOM5F8SuMzPi5l5EPs8AyRqTK2dO8zfY/Ko6zvo=
X-Google-Smtp-Source: AGHT+IEOS4wtw8mE8CPg82Rr+lLAZP0qvzK5EcsD/Yh07Qs4cGAD4UJN8OE3rg6nlYdIJaR4gAnLVw==
X-Received: by 2002:a05:6602:60c5:b0:881:7e3a:4a37 with SMTP id
 ca18e2360f4ac-8843e3761e3mr691078139f.6.1755284302462; 
 Fri, 15 Aug 2025 11:58:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50c9477f44fsm589413173.21.2025.08.15.11.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 11:58:21 -0700 (PDT)
Date: Fri, 15 Aug 2025 12:58:18 -0600
From: Tom Rini <trini@konsulko.com>
To: alif.zakuan.yuslaimi@altera.com
Cc: u-boot@lists.denx.de, Tien Fong Chee <tien.fong.chee@altera.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Subject: Re: [PATCH v1] misc: fs_loader: Initialize actread variable
Message-ID: <20250815185818.GA55961@bill-the-cat>
References: <20250805024630.24558-1-alif.zakuan.yuslaimi@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nB7zsVmSSKtptOul"
Content-Disposition: inline
In-Reply-To: <20250805024630.24558-1-alif.zakuan.yuslaimi@altera.com>
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


--nB7zsVmSSKtptOul
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 04, 2025 at 07:46:30PM -0700, alif.zakuan.yuslaimi@altera.com w=
rote:

> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>=20
> Initialize the actread variable to prevent undefined behavior
> that can occur if the variable is used before being assigned a
> value.
>=20
> This will help to prevent potential issues, especially if
> actread is used (e.g., read, incremented, or returned) before
> being explicitly set elsewhere in the code.
>=20
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>  drivers/misc/fs_loader.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
> index 66803f4b997..cc07bfa7f14 100644
> --- a/drivers/misc/fs_loader.c
> +++ b/drivers/misc/fs_loader.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>   /*
>   * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>   *
>   */
> =20
> @@ -148,7 +149,7 @@ static int _request_firmware_prepare(struct udevice *=
dev,
>   */
>  static int fw_get_filesystem_firmware(struct udevice *dev)
>  {
> -	loff_t actread;
> +	loff_t actread =3D 0;
>  	char *storage_interface, *dev_part, *ubi_mtdpart, *ubi_volume;
>  	int ret;

A one line "initialize a variable" is not sufficient for adding a
Copyright line, please drop in v2, thanks.

--=20
Tom

--nB7zsVmSSKtptOul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJ+DRwAKCRAr4qD1Cr/k
CrmiAQCPFnJuEOADyCBnc1eEubQliM47GZqEZrLvxDuLe0FlkQD/W1CFCDZugxvU
3YjAquX4HjHp8pSVJpvyWgXuioqWuQ4=
=WCu/
-----END PGP SIGNATURE-----

--nB7zsVmSSKtptOul--
