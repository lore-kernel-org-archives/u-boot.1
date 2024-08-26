Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A64AC5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 18:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B398F88AA8;
	Mon, 26 Aug 2024 20:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kz1+5uuw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C046F88A74; Mon, 26 Aug 2024 20:25:28 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8D9988AFF
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 20:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-709346604a7so3583867a34.1
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 11:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724696725; x=1725301525; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TixgmDYKe/vUfhtuOJULhq8FInU9GjjJjJeHme4/R24=;
 b=kz1+5uuwk5Y/skIXRhRrvsIPXvH5/1CnYOmi6UtCexG3MS9QPb6qeAOO09htUK0QYk
 NxpC0iu0t+fnciBiM4bLttUQ+gepwxeevoFPpznmC9cdbpRMoTU8H03PCVpvOKdGVd8j
 LceCIDyDZMhn8sIn/2Nv/alV8F/l6sTNRaC5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724696725; x=1725301525;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TixgmDYKe/vUfhtuOJULhq8FInU9GjjJjJeHme4/R24=;
 b=UU9PZjyMrGs+ze+pR3otLNmdK8hAzOCb0ItRF4oPfyFpUJqa3AtkirvnYxNTYBgI2A
 2Ry47IJaBSgOMxcRgLk6dw5IGuC9XQEOjMbt6uw16DJL1dvS7WXJs6Ok5cOIn8Luy4Fy
 bYDk6sH3DDCqGjV1l2c7ZmCpAyIdIDnTtDaq7xKyEN7gHTNY9BKyDNk3Og7eLEHactc3
 G8pFgQ9uRdXl0lOT88DbiX0NPFBCOd0Ulj1um/puIaS1/jESU0z9hLCaeILDvXWvfmHP
 V/TCruVZ2/oSZVpXzA1aY9hJSegAjyd3FBMZX3Hdsu2oEzV7NfXIgteO7hi6guUlS9/9
 MesQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEmfXVUzlFZFUzoX7ZZgtS3ZkEapas1ARXP7uXsajQsIySN4V2aMsCAugdJiGU8uosuZ61Rqk=@lists.denx.de
X-Gm-Message-State: AOJu0YxEqbDkvtuXAOj/RKC5r3jcf2Bgw2A5sZuJET0FfB5DOsV6qFPz
 UykH/7DtdR2z38818RqDza1dbMJ9CYfoYfFtITK4k3nk4xK9QWh9/TlC0/qf5Tw=
X-Google-Smtp-Source: AGHT+IGOK03gmxw/IvGDfYE2uw9e+sUR5ppxUdeoBff/hzSfr3wPRumvb06nTZZiKDC8qtWYbXO4Xw==
X-Received: by 2002:a05:6808:1914:b0:3dc:14dd:c455 with SMTP id
 5614622812f47-3de2a88f420mr12071084b6e.19.1724696725312; 
 Mon, 26 Aug 2024 11:25:25 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe196d10sm45892951cf.71.2024.08.26.11.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 11:25:24 -0700 (PDT)
Date: Mon, 26 Aug 2024 12:25:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Keerthy <j-keerthy@ti.com>,
 Amjad Ouled-Ameur <aouledameur@baylibre.com>, u-boot@lists.denx.de,
 Hiago De Franco <hiago.franco@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH] fs: Fix SPL build if SPL_FS_LOADER is enabled and
 FS_LOADER is disabled
Message-ID: <20240826182521.GK2479150@bill-the-cat>
References: <20240826181933.252020-1-hiagofranco@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZCDzvfnsNKajghEF"
Content-Disposition: inline
In-Reply-To: <20240826181933.252020-1-hiagofranco@gmail.com>
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


--ZCDzvfnsNKajghEF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 03:19:33PM -0300, Hiago De Franco wrote:

> From: Hiago De Franco <hiago.franco@toradex.com>
>=20
> When SPL_FS_LOADER is set to y and FS_LOADER is not enabled, the SPL build
> fails with the following errors:
>=20
>   AR      spl/boot/built-in.o
>   LD      spl/u-boot-spl
> arm-none-linux-gnueabihf-ld.bfd: drivers/misc/fs_loader.o: in function
> `fw_get_filesystem_firmware':
> /u-boot/drivers/misc/fs_loader.c:162: undefined reference to
> `fs_set_blk_dev'
> arm-none-linux-gnueabihf-ld.bfd: /home/frh/tdx/src/u-boot/drivers/misc/
> fs_loader.c:185: undefined reference to `fs_read'
> arm-none-linux-gnueabihf-ld.bfd: drivers/misc/fs_loader.o: in function
> `select_fs_dev':
> /u-boot/drivers/misc/fs_loader.c:89: undefined reference to
> `fs_set_blk_dev_with_part'
> make[1]: *** [scripts/Makefile.spl:527: spl/u-boot-spl] Error 1
> make: *** [Makefile:2055: spl/u-boot-spl] Error 2
>=20
> Fix it by replacing the FS_LOADER with SPL_FS_LOADER in the Makefile, so
> the fs.c with the necessary function definitions are compiled.
>=20
> Fixes: b071a07743d4 ("drivers: misc: Makefile: Enable fs_loader compilati=
on at SPL Level")
> Suggested-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ZCDzvfnsNKajghEF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbMyJEACgkQFHw5/5Y0
tyz21wv8DzRjJXGLxYu6nOOWd/GeQ7sqXMiNi2kzef3PuM+TtRcaG2zuLE+Yu2UU
yzAsEoEKSOnRa86iawtIulgV/l3aMUjfUGfz+h/EdIEhbbP3aHsVcaTMXVH0MJJN
JTuEGfw7aXFGFKiPg/AfAz9lKNefBpp7K0v6CJqjnO/3Vi4i3pzYdrzJgnlSzd0Y
//SQWFnzs0+abAwlcRgKuCA76YgNpPh3V8+dfbUm61iBaBudRdIHRjq2JJ9qCf37
2XebpAjVJTCk+jxeeSCBIDVpe/R4eZelA12ebEHXXUSkHHhUqVOQxki1uWs4CBky
3etGEW2mzAIk9x0h25zvDOIGvw8edXedH6mVTeoW/L11S50feefPcGPHJ/J4gMUM
HqP2kYpjsPdnTFNZnw7kPARIR813ihf1nkD10lGnbAGQvKYjQT8LhZg8GEoew25E
domi/mXTdIcuYUCiq8JekyprtfQqYm6DIaAE9heKZwjUYBPnE2CugWIRzaMUfALG
6dQHH+r/
=8vMg
-----END PGP SIGNATURE-----

--ZCDzvfnsNKajghEF--
