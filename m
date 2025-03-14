Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A434C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 14:28:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BE1E81DE3;
	Fri, 14 Mar 2025 15:28:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mg2bmJ4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EB5981D3B; Fri, 14 Mar 2025 15:28:06 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1701480F9A
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 15:28:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-474f0c1e1c6so4307111cf.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 07:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741962483; x=1742567283; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0obWbRKbU97kYzZTFbAkXixYSdb+9ZhMcxNsTaKvQGw=;
 b=mg2bmJ4B5lFoyfFS2gOW7K70pXLF75nsP3lfadO25iMWpyV84uwF1EV5Jn0sQ+tN2f
 jdObHJ02WuaE9u2ExGt8U/aEdPUDBjTx4cOCMacQmraEgMaNUiWgZRY8rSZOQoW2dNa2
 5Nqv1evtkv1y/NuFgpEhyM+0w8nXklXdwklS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741962483; x=1742567283;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0obWbRKbU97kYzZTFbAkXixYSdb+9ZhMcxNsTaKvQGw=;
 b=m3BVutB9Ju/WJXupbM8DnDYdBylug6Fot6xB8crH8vGLgea0surqKViqfudBfXWFrC
 y1tRv5chKV6cUFQJbau0dbJyFnxTh08W/WY4UGqzFl+5dOo7m1z9aTZ83k8TO0ZwdsVc
 S8wvYSBVnDWXWrJJKxbAxje9pPgKhjEMtTgTWCRAzNbmnaGaYAThsWXaqmK5L3j5GhIT
 M28C30aap8SAz3ed5+sKPua1R/WLvTSyoz6ua4StchIvESdrO22AyAIsYW8ZzuzXJoL2
 3X59ber2Xc3qHRZqiLxDsf/P88YFZOkrcFU01A8NKgzWxD9eN1CG7JrXng7aoe3BJt8i
 Albg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9QqHKBVM+9VM56cFw/fBnqlVx/ESBe7Bj8R0FK7Z0L6WFp0kE/FXZca9O1fOMdxlm8wjPEQg=@lists.denx.de
X-Gm-Message-State: AOJu0YyNOCeWlD5HT/WXoQhT3uYAMs1eNREkRaA1Oi+S8aY1QMtK8riF
 1en7oW5zXKQIS+jc4bSyuA7nPwqJWpEzJzos7WENCpLNMsFGNcck27B/HDCZsvM=
X-Gm-Gg: ASbGncvNZKKJvOVJ4dd/dmi3ZGyolvKMQUGhEs4KTsvpwlhyy1XUfcklbYwsG4Ak33h
 BvHp0Sv3bThub+Cowg8qy24Bl8YswqdB6RKgIUGA61bURTYOcp214TtV6D7rvjtmJpR1bW2OlNn
 nY2zTrZRTIZYo/kyeBdvzGbyKk+nkO916hGrCYURrYKuPX8fqeh4mBPnKZnzRLsVai6kDS9PwQB
 LBgiS23GvH8JRuAII1onbt6vz9AHgYSqD7JgPQit4goid/yrbaybLTXZCuiK5Ew986N+A708aw5
 S6qRWBOjaTeNK3t8NNWUEzt6ol5u/1vAOleEPMJjt7bEMw==
X-Google-Smtp-Source: AGHT+IFsiSU6nSZbVijbhne73NHyZW1aZBRlQ5OqX6IcUJJnMIRjeN0PSFZ5pdzQz/5/cj4rV2h/Hw==
X-Received: by 2002:a05:622a:180d:b0:476:6215:eaf7 with SMTP id
 d75a77b69052e-476c813f762mr41356971cf.19.1741962482991; 
 Fri, 14 Mar 2025 07:28:02 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb82a5c4sm23436351cf.68.2025.03.14.07.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 07:28:02 -0700 (PDT)
Date: Fri, 14 Mar 2025 08:27:59 -0600
From: Tom Rini <trini@konsulko.com>
To: ziniu.wang_1@nxp.com
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, pbrobinson@gmail.com,
 marek.vasut+renesas@mailbox.org, tharvey@gateworks.com,
 jonas@kwiboo.se, sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH] mmc: mmc_boot: support sandisk and micron emmc boot/rpmb
 partition resizing
Message-ID: <20250314142759.GO2640854@bill-the-cat>
References: <20250314081024.1035144-1-ziniu.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/zYP64BpEXOCVz5e"
Content-Disposition: inline
In-Reply-To: <20250314081024.1035144-1-ziniu.wang_1@nxp.com>
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


--/zYP64BpEXOCVz5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 04:10:24PM +0800, ziniu.wang_1@nxp.com wrote:

> From: Luke Wang <ziniu.wang_1@nxp.com>
>=20
> Current mmc bootpart-resize cmd only support samsung emmc boot/rpmb
> partition resizing. Add sandisk and micron emmc boot/rpmb partition
> resizing support. The commands and parameters for resizing partitions
> are different for each manufacturer. Select the corresponding function
> according to cid.
>=20
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---
[snip]
> +	/* Set EXT_CSD[175] ERASE_GROUP_DEF to 0x01 */
> +	err =3D mmc_switch(mmc, 0, 175, 0x01);
> +	if (err)
> +		goto error;
> +
> +	/* Set EXT_CSD[127:125] for boot partition size, [125] is low byte */
> +	err =3D mmc_switch(mmc, 0, 125, bootsize);

We should define EXT_CSD_BOOT_SIZE_MULT to 125.

> +	if (err)
> +		goto error;
> +
> +	err =3D mmc_switch(mmc, 0, 126, 0x00);
> +	if (err)
> +		goto error;
> +
> +	err =3D mmc_switch(mmc, 0, 127, 0x00);
> +	if (err)
> +		goto error;
> +
> +	/* Set EXT_CSD[155] PARTITION_SETTING_COMPLETE to 0x01 */
> +	err =3D mmc_switch(mmc, 0, 155, 0x01);


And if we don't have 126/127/155 defined today, we should use
reasonable names for them too. Any other command numbers I missed as
well please.

--=20
Tom

--/zYP64BpEXOCVz5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfUPO8ACgkQFHw5/5Y0
tyxNSAv8CrLckh8AxEmDPTuG6grS/QwxWJ4BiMvD+YxnnnUP8EecyfTSfTPEslM9
Un1w41OxpQ9/tcz1ZuabNekd1KwLlbEpvnTGXJeM5yD81WZ+Ew+ffsMV1J61TT+X
D/5qNaIU0M5PRF6FP6FIotMzyKK06DyVklSEiIL15bvuUn2XsNs4lLW1G85piUNm
tnA2u/PJzYYW8l5i71kbKGNSgM5oREO7/zjSctI/NuNwZnkYo+P3/IzaxkRJk5Zi
NNxdS8IJcK4kSv+TYHa5b7WRxcXVWf0UUTE4lc2K+T8HJWcjAaq1Eb3HGnCUT8i+
UpxwerBMbP5Ky+WMWCHtNpEMTWtOkw3MyKj09b48e//TynQN6m0N8OaapYplMLia
jv9d7th9xnFgRwD7Bt7TFpPB/nnmTmfWnDbByx/mTxmnb/WCwsfPOWsgQGYZWRYg
QjkIW1/hzz5gCy0RUPUW+s+ZKbgWpTiqmkvKfASOV7B+bMWJmeg3NVIWVinjDyTp
0gD+apbF
=0OWp
-----END PGP SIGNATURE-----

--/zYP64BpEXOCVz5e--
