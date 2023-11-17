Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DC4C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 13:42:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E0C4874CC;
	Fri, 17 Nov 2023 14:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p9BF9GIV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A466787021; Fri, 17 Nov 2023 14:41:16 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BC8787083
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:41:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3b6ce6fac81so1185208b6e.1
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700228471; x=1700833271; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iAgb+xHL3hJrqoO1aukuPWnWyHCFBIC0Gqt/ZsDDJg4=;
 b=p9BF9GIV4ZFlPkL52w4/i04yWolvJsXpnwOLsJ8aKBbyLNWLcr9m1w6/kxuCUArMYb
 HMs4bBbhQLvVYSVTWXV6p89MDOqQuHV2HnT8VgLq76l5f/TpVCIBttzXb8bf8qk6Dr3w
 YFkz1EllyuI74TxWtHu+POy/MlW13Up11E+Zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700228471; x=1700833271;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iAgb+xHL3hJrqoO1aukuPWnWyHCFBIC0Gqt/ZsDDJg4=;
 b=Z4/STQcHN/kvYm+YIb+7Lux4rZsCNwe93slzHTalFOt239JJ28sUQf8Ulq6hlPOVVz
 S2N0my6B07FfkFhByOnyIEzHtAWXFeJkHDcfPlp/PnUslNhmueNL6gS8Zfmlq3/TQCV0
 ClppAJii3/L42NqkIsUQzmH95kIOqEbFZgwnOsyDgPdgAWNOc+VEkcKNs7fDwrCulLha
 FZ97BWwBczSfdyHPFvtSM0KywTIJrIqfFG0iR28fADwA6uey58NFwlJ2jtvY2vKTD2pG
 7a0OX0b8sl3yMmHUunprOlGXv5sOlpzPJGxR8dMXgoSvhTIFAdjC5028xEBl2a+bBanF
 ieRg==
X-Gm-Message-State: AOJu0YyvWbVxywl6bpHU1tN5JrhHsbPVQjqHgZw1rz4mdIg5iafJW9MY
 N8qbYjrQtmWQ15pjiWvKwuGRpQ==
X-Google-Smtp-Source: AGHT+IGkiznn7xRWmEP6alhMmMZKdq7txkIWzecNg9gSW7QPzWPaMnsXQy9y8/JsrlJXW7ln4RgRHQ==
X-Received: by 2002:a05:6358:720b:b0:16b:ac0b:3b16 with SMTP id
 h11-20020a056358720b00b0016bac0b3b16mr15308787rwa.19.1700228470963; 
 Fri, 17 Nov 2023 05:41:10 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 e13-20020ad450cd000000b006263a9e7c63sm629443qvq.104.2023.11.17.05.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:41:10 -0800 (PST)
Date: Fri, 17 Nov 2023 08:41:08 -0500
From: Tom Rini <trini@konsulko.com>
To: David Oberhollenzer <goliath@infraroot.at>
Cc: u-boot@lists.denx.de, jmcosta944@gmail.com,
 thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH] fs/squashfs: enable LZ4 compression support
Message-ID: <20231117134108.GK170968@bill-the-cat>
References: <20231106101403.80409-1-goliath@infraroot.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+kO2IHyVUrsd7ZU6"
Content-Disposition: inline
In-Reply-To: <20231106101403.80409-1-goliath@infraroot.at>
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


--+kO2IHyVUrsd7ZU6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 11:14:03AM +0100, David Oberhollenzer wrote:

> The structure is identical to the existing compressor implementations,
> trivially adding lz4 decompression to sqfs_decompress.
>=20
> The changes were tested using a sandbox build. An LZ4 compressed
> squashfs image was bound as a host block device.
>=20
> Signed-off-by: David Oberhollenzer <goliath@infraroot.at>
> Reviewed-by: Joao Marcos Costa <jmcosta944@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--+kO2IHyVUrsd7ZU6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXbXQACgkQFHw5/5Y0
tywbOQv/RsgNIg4UgX2m26RFtZUdS58FzWiYFwaP8VZTciS35OfYZdLG3fy21pis
MER4FX59b8xdfwJ0Yop+BNXoJ/ocRwi5RQBR9lBvu8oxB8H2ruPdJz0GG0zjE5q+
Y6hOdi4NVL1DOCIrXk1tXqg8ady0ZOdYR4On8NJBM3BH0Oe5imWmzfXP1SfUxsiO
BnTxhLrxoKAKNLferukyT1Mh2LjEGmAUbKtVvLLxVtkebbOUDW2MWS+yDqGMWvxT
x155IW5PlCXwYkObYWxr2IC+5CCfsLXuHq2pKgLSGK6P1VKYfYnOs+/Ox+zB54Cc
fyOmZvt0n6Fjqjg78oB/vYzTcx9eCPlIbGHL4KYnZ9XjuiEtkkqGdh/xyRkRCL33
iP8G02Xvr024MD3Fciz/zGd/60oPQidU+uBUoQEm7UZmRYqhI7z/5PzJH0RSXjN+
jAotL4ZE/cqVBFhwyII3O+QcwOoIxcj+ffugBP9JGN5qluSrzDlbB0dJaU1qySFV
yVZiVbhe
=ZC0r
-----END PGP SIGNATURE-----

--+kO2IHyVUrsd7ZU6--
