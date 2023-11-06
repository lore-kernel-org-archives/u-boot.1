Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D05FC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:35:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F011087164;
	Mon,  6 Nov 2023 17:33:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Uq4J8Hn7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2FCB8716C; Mon,  6 Nov 2023 17:33:54 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7C3E87185
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:33:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-41cd4446cf5so29422971cf.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 08:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699288421; x=1699893221; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GklM0gQOWVgpcuO4GYgLR8PC6uIcHsk4GXux9jixZTU=;
 b=Uq4J8Hn70nyVeaSj8lhe8HCgyOrUw2lOttdaujxBubaky2RyrlsLSkyVucSSQWgDFe
 d0IZxNzU3/0o18/kiENTHSMa+xvzr4xBDlY8i4uYQe5rYjl8JyhzgxULAgIQ7DX3wrRo
 pmGfn+mhbyoBX9bFAPLfl80YoS7YGh7uV7EDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288421; x=1699893221;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GklM0gQOWVgpcuO4GYgLR8PC6uIcHsk4GXux9jixZTU=;
 b=YBdA5nj3FVrxkuvbp2olisEY7Th2mCxSnJDtA7Wdk3x9PIg+oKajm2HwMqK53op4tL
 UVdz4Zmy+YzM83Ow6VExLTgFiHt0vo1YWUqLaht5oA9iX8j4vLZcrZ++I9NqaeulBw68
 e7OgPdpEhpeArAiM7abhhBRstcXOan0mY6IkwgcviLrmIBbixzdHBHPcgXCSXlq3vlOk
 K9JAuoJOK22zfznCHPMGuiY/FuOZkA1NC8pG9jycYyChQvjceCdzyaFFyOwfgCSvq22F
 E5rqNxX17a3OLvu6oX+hWQi57cFdEGW4btiOgKhAuzrC/vM1RmXC/Aiz1PnVP131QEyV
 cn/Q==
X-Gm-Message-State: AOJu0Yw4ow7j25pcmAB5SsiYRC1fyXxVYqbXCrPw5+QBCgqnx1BoB+Px
 Nbh7gkIEcCAQN8OfOZshnGt5Fg==
X-Google-Smtp-Source: AGHT+IF8ol5DIAr3lXDTMveQ8bOmx+fTA+4K+p11KBYtzFuA+XBbHG0tjXG5mweItUwQ9wNqPz2FmA==
X-Received: by 2002:ac8:7e96:0:b0:41e:4968:12e4 with SMTP id
 w22-20020ac87e96000000b0041e496812e4mr34636456qtj.39.1699288421552; 
 Mon, 06 Nov 2023 08:33:41 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 o4-20020ac85544000000b0041e383d527esm3495718qtr.66.2023.11.06.08.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 08:33:41 -0800 (PST)
Date: Mon, 6 Nov 2023 11:33:39 -0500
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bmeng@tinylab.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] net: e1000: Drop e1000_eth_ids[]
Message-ID: <20231106163339.GX496310@bill-the-cat>
References: <20231011105825.2956485-1-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="txXBtIRzBa73wNE7"
Content-Disposition: inline
In-Reply-To: <20231011105825.2956485-1-bmeng@tinylab.org>
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


--txXBtIRzBa73wNE7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 06:58:25PM +0800, Bin Meng wrote:

> e1000_eth_ids holds compatible strings for e1000 devices, but it
> is meaningless as e1000 is a PCI device and there is no such
> compatible string assigned to e1000 by the DT bindings community.
>=20
> Drop it.
>=20
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--txXBtIRzBa73wNE7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJFWMACgkQFHw5/5Y0
tyxAMwv+KZNMgo6WzmuV4dBqBJhrbTy1WdVeC3Q1UQKmb7vytv0k7CHKBKH2muHt
TEpku8VvWWSQSEzcL2avxYG6VX6YxuXe6JFvmuXV1uzSaUJGuJy0tfLFjqP4ODf5
G6Npsmfj1HbepsMuJ23nSolaW7x2Scp0Puoo4yCdf2uF5XXfz1LH7ZFRbbKPltI3
e/BHJotOt8weeKhx1Wzsh2lBTco5+QF7BkrT9TKIpxKX5DAS84qEBeaABEhUW/+y
yFjI5j1kcXEN3cc0B1wUNUXIA/uS4+27kFKqsc117SnkcJ7g1ZxQ9ZxmpEwULdQE
QsE6QjYLHAMW9COE/Q/G7Fz2O9zJoP2W9W7VPmV8cr4PoNDZlsPX2fkpd14ZiCNh
RyHKn4MSHLB4gEalpQgbyJtAEWniqMqY0MMdwi08+G0a4ON3ve+ZxUySVXi2m2gz
hoeW5IAj9uOdj3t9+x1uVLfdwTVhOgiAV8X4WY2gF4UhBRCGWj6wJPpyemlfHqq7
6w6oC18D
=+v/N
-----END PGP SIGNATURE-----

--txXBtIRzBa73wNE7--
