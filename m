Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2DFC072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97A808745B;
	Wed, 15 Nov 2023 23:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TsvXfLh+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A6038727A; Wed, 15 Nov 2023 23:37:59 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05A958745B
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-77896da2118so7239585a.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700087876; x=1700692676; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XkugyreAspy1D39pAYqsZTPua8iMpkYsjJ8ONy0hZng=;
 b=TsvXfLh+UQkIm+jSwqteBpA2jV8SirEpD2XxHqOwC2hWYgQqRmjNdjs2zfFxv4T5J9
 eQGQVKGrYdM62V/1h2LSXlXPMEXW2VtpXRddokeNPjlf1gvjwLZrwZqOUTatueIsu4SM
 lV+w4EO9iCXs1ZmmgHmEw/74YDMKR1zqfdzKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700087876; x=1700692676;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XkugyreAspy1D39pAYqsZTPua8iMpkYsjJ8ONy0hZng=;
 b=Ji138q+VhjWdGtyLV/SCgv4yKyz17Ei5d+yMRtMiLjLF45SwWV9VZuKhQRrKJsJHQC
 /33nIQ0nf9rX7xr/Q7NWprwQ4nZ0PExMCkEZ1YaR6FNmo2UzRPtqoxXCZI5iT3IWD39z
 JivrRD4vtMlryIBdZ9FaXIILAvGLpC0g2oS+OQ4gk+smXeCP8wy3shR9Go9PrxwWenmh
 vF7y5/NmjDl8lsHCgisn4ldmcX6zCwiLzQdSDE5ji2Q9NwMQVjXiZqdwy4rIMM470qxr
 YlgXvR3uBOI2WawDiFF7B3mowBFWRwM6inY2OJq2wiDBeV/OXQoE/Kbukr5kJQiVH9+T
 mpAw==
X-Gm-Message-State: AOJu0YzyVRU/F1Pz4GbgDZzkIXBKdSXrU+PE5k82rlXo8HEAgZASqflK
 putsK9G7cEuDa0N+i6aM5qTuJA==
X-Google-Smtp-Source: AGHT+IHfhNGfe/YtI0cUPirDqcPetAvRF1e+t+CQ1kSHBQOEahCIDP3gU5a1RngWgmCm88Mn6J464g==
X-Received: by 2002:a05:620a:288f:b0:76c:8998:1866 with SMTP id
 j15-20020a05620a288f00b0076c89981866mr8907352qkp.40.1700087875802; 
 Wed, 15 Nov 2023 14:37:55 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a05620a12e300b0076e1e2d6496sm3788957qkl.104.2023.11.15.14.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 14:37:55 -0800 (PST)
Date: Wed, 15 Nov 2023 17:37:53 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH 24/29] bootm: Simplify Android ramdisk addr in
 bootm_find_images()
Message-ID: <20231115223753.GD6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-25-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9ecpVrXJR5pvZ07d"
Content-Disposition: inline
In-Reply-To: <20231112000923.73568-25-sjg@chromium.org>
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


--9ecpVrXJR5pvZ07d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 05:09:09PM -0700, Simon Glass wrote:

> The Android mechanism uses the loadaddr envrionment-variable to get the
> load address, if none is provided. This is equivalent to
> image_load_addr so use that instead, converting it to a string as
> needed.
>=20
> This change will permit passing img_addr to this function, in a future
> change.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--9ecpVrXJR5pvZ07d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVSEEACgkQFHw5/5Y0
tywL6Qv+Lmp32/bRMtreOJOe3xiTo+2uwrpRBL4BCGRfHLwGKheZ1Frws/72qf3r
u/9q81BebQeyiBdalwgyWL2ViVURb0/XedY2n690gkFzIPLlECYwu6m6fgldlQSU
0HeYVz12AUGPkdhcEJubDslL8ccd4/aqkT7qo4S+ESPGUt6luNezRlUuiHzE4ent
nPm23dDJXwDE3S8s/T2TD/lnjDvbXMV9Hs1r6fHiWp5f8WO3GoBjTs8LRGyQ+jaB
qcae9Hqf7dVpb7DuwX3kw+741Z4AejjX5K8u+FJNadnJy30Y8KW31dortWmJzMxa
BoUx31IMK0/XeBz7yPhJ7Wix49fDvPdSef/1zNQCfGdbbUjqR+bEthwN0a8sWPFS
A2ylyZSEaNYrqXin+VhCvzO59miVDfsxnw/spreyhO15SFr0d2UBBO4tmfOgwaFE
wNxG0h79B975P0oq5wH3NqDXEKyL8ntM/sadleM6Gh83oxkzU1g7lOWmvk3BHg/w
SIXGc6c9
=Vo6c
-----END PGP SIGNATURE-----

--9ecpVrXJR5pvZ07d--
