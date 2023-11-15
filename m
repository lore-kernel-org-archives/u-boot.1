Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F69C072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:39:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 376A087485;
	Wed, 15 Nov 2023 23:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cYK09TQu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A054C87485; Wed, 15 Nov 2023 23:38:06 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B952874A5
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:38:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a7b3d33663so1450687b3.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700087883; x=1700692683; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KdK60XL8SnKV/5t+QNC4F1jwQvMc/oCvgYVgTbNbhPE=;
 b=cYK09TQukOXQLKoAEfSz15Qgz7LUuojq3ZvmK16oTmRMbVsj6ZKMkKaHGfI9cer6yE
 Lb75VzS49Y1K3bcO3XU1OXr6Vy0N35MhYLvbZRrlEApX3PnvZ97sWKU3Xp9br8yZYQNC
 iJ5u4gcgOi3keksbGJQM6EcqCcSLQAikIwVY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700087883; x=1700692683;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KdK60XL8SnKV/5t+QNC4F1jwQvMc/oCvgYVgTbNbhPE=;
 b=YKufJ6MNPiUgDPhhxdbcZqqOQ3+T2Nqnn5k5k/UiwP5sVmS57PI7EL0iEzAPLlILra
 KinlP5Bt/olXMi1Mw6VgqHV5l6Zyu5kHvUu6hCGLlF5p2VoxUzxqAR5SFCkqjZDk9+gs
 DljztSGA+LrnEt9RoNRB58j47WFnkZ21W+c4cBkxx7mUJcNGwN5TF1yrQMtQP5cAriT7
 hqwldRZnnZHid4Z6xn3R/dWkyxjg25Ow+St6DrfezmPNqfX9OnP6DmJrOeFlWdBrwgac
 /nVtyvFprPukuidfXFXHq/1Q2VZfL3+jBHGaOrp8DAWLng+kq3K5JtfggyhwBl/KKvrj
 NvWA==
X-Gm-Message-State: AOJu0YxOoFk5PILWmX3Pu+/KwkB035sCEKUsR3FYYEXjtMpdHiYZmgTa
 iK8gnV2RWbdTB5I4gTdDYmyZhQ==
X-Google-Smtp-Source: AGHT+IGJDYEorprG/7wrqXeyVvSBuP1QJ/aVt2EUyb8fFGxEVlBxsmY3C6Q37BaDsq5jkTJcA4bg0Q==
X-Received: by 2002:a81:9a08:0:b0:5c1:1a71:4706 with SMTP id
 r8-20020a819a08000000b005c11a714706mr14245204ywg.42.1700087882992; 
 Wed, 15 Nov 2023 14:38:02 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a0ce8ce000000b00655d711180dsm894258qvo.17.2023.11.15.14.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 14:38:02 -0800 (PST)
Date: Wed, 15 Nov 2023 17:38:00 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH 27/29] bootm: Adjust the parameters of bootm_find_images()
Message-ID: <20231115223800.GE6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-28-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ieQZlVHkLfPWW6jh"
Content-Disposition: inline
In-Reply-To: <20231112000923.73568-28-sjg@chromium.org>
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


--ieQZlVHkLfPWW6jh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 05:09:12PM -0700, Simon Glass wrote:

> Rather than passing it all the command-line args, pass in the pieces
> that it needs. These are the image address, the ramdisk address/name
> and the FDT address/name.
>=20
> Ultimately this will allow usage of this function without being called
> from the command line.

OK, so this goal is good.

[snip]
> +		return bootm_find_images(img_addr, argc > 1 ? argv[1] : NULL,
> +					 argc > 2 ? argv[2] : NULL, 0, 0);

That we repeat this much harder to read test/if/else three times now is
less good.  Can we find some way to hide the complexity here in the case
where it's coming from a command and so we have argc/argv[] ?

--=20
Tom

--ieQZlVHkLfPWW6jh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVSEgACgkQFHw5/5Y0
tyzusQv+Ltu6sMJOigCww9fUiYlgZ9t4dqWqnG0iE+VUsm+tjSytunB9qfojYykk
ol946UPMlO7yIF9WmeszmrbVSUCTJKyGGrwp/H3+8gR2fbnueyn7Z9jsTtUfKwKU
86gZT09ZLFPZDhPs3SqZt2fZI73+4JN0HXUYTha/Df1KCeVhuoPHzGtyOflz2meQ
3IZ6UNJBPSHqZAx2/zFQn9ndAaklBxxGPYuF+6xOqaKjiktJ5+uRjxNVFhtv48+C
+zV/ZcwLtdbmyPu7iwjNJkyHbHJmEOpgobHKTGzcYL6FTHmaCjKepZI59BL1JLr+
pKESGm0harVH2N93PyX8sKBEzH4ZDOb3FG8dn0FNo/ntN1iBjjxJI/steIkxssWt
tTWNeiUQd0DvB7/xvnY8oAFxtgZVREzyIYvhW/9XHzJyOYw6Q6pa57sfJZkMHOK3
fjbM6DEa+LVwgmlvvpBM1CZsd+HV4I8J8F2pbmWS8KyfIPgwbmMyvu3bqb3bSh02
Fvn9KMde
=eMFN
-----END PGP SIGNATURE-----

--ieQZlVHkLfPWW6jh--
