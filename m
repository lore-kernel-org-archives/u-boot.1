Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33446CF3185
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 21:54:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FFEC88E03;
	Tue,  1 Oct 2024 23:54:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n1BgnKus";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF98D88DFB; Tue,  1 Oct 2024 23:54:38 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EDC388E03
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 23:54:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6cb399056b4so44824696d6.0
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 14:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727819675; x=1728424475; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rVTF65WfKHz7Y7D/De+R+r/zxvSKouhpC2Bvhcy67+k=;
 b=n1BgnKusu+mFfnVtTuLK+PeA+1Xoy1pVwP+eQwu7Rzj5fT+rPRUP/ePxUcyJMrnBG3
 qSjwYc3jJb2VTpLOHGPMLKmovMGhBYVO48+CitPtLnrKBoMGPXzxgkJF4d2rZsw4ZTII
 ut6tK1wrzSV8JDkaxQ7TA9PEvoX2IJ0oVN75g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727819675; x=1728424475;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVTF65WfKHz7Y7D/De+R+r/zxvSKouhpC2Bvhcy67+k=;
 b=hVwmIieKxu3GuoIM3BtfzuHo4TToW3NaDJqXmEvggsV0jwZBTRz8TH9XiBc+g6Q5ex
 exDddpTcz3FvLiihHR9STF/yMlUvl4aHexbuvP5vxfuER/OzES1+rXEyW3X/gS3Lwxl3
 G2Q56ntfoTJWmojqP+WU8u5tl+eVSTGPpNdZDb/qt8Kk1ZqFt0Y5U9PMzx1zKHvi+clY
 eKWRJ6yG5JJdN1ySZImD1x4jYACpzpjpyd06u9MXUvo6lfFq5/zaocqKYNd3RrycwnL/
 bzkufB8iivkzfCqRoRgXpeF+dGc5b6pVtpvf+S2qBdEu2hx46pDBC6+bKTJzvL9N6HXv
 fTvw==
X-Gm-Message-State: AOJu0YxIu3LKSZcxT26Nq2p+s8zpjRx43Fxhf3cou/adlASqHr1uuMt3
 +4LVmoARVDVSEAfU224PpULgGokQGOKYA1EKTqU0cyrmRe07Yqsm3j6Ja96JA/o=
X-Google-Smtp-Source: AGHT+IEj3h0qXwyIj8j9i1kYyC5eGKqAXBsZIvk0NhFt6H7c2dh/HyPba5gW+z1pJPAOrOlM6TX9Pg==
X-Received: by 2002:a05:6214:5b13:b0:6cb:5418:4523 with SMTP id
 6a1803df08f44-6cb81b99b5amr14410316d6.40.1727819674766; 
 Tue, 01 Oct 2024 14:54:34 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66ceb7sm53767046d6.90.2024.10.01.14.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 14:54:34 -0700 (PDT)
Date: Tue, 1 Oct 2024 15:54:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Anton Bambura <jenneron@protonmail.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Leo <ycliang@andestech.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Resch <resch.max@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Nishanth Menon <nm@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Randolph <randolph@andestech.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v3 31/33] global: Rename SPL_TPL_ to PHASE_
Message-ID: <20241001215429.GJ4737@bill-the-cat>
References: <20240930014956.1434060-1-sjg@chromium.org>
 <20240930014956.1434060-32-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SFkIKWeWx7f4Ic8w"
Content-Disposition: inline
In-Reply-To: <20240930014956.1434060-32-sjg@chromium.org>
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


--SFkIKWeWx7f4Ic8w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 07:49:54PM -0600, Simon Glass wrote:

> Use PHASE_ as the symbol to select a particular XPL build. This means
> that SPL_TPL_ is no-longer set.
>=20
> Update the comment in bootstage to refer to this symbol, instead of
> SPL_
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
> diff --git a/common/bootstage.c b/common/bootstage.c
> index dca33148192..dd6aed7c2fd 100644
> --- a/common/bootstage.c
> +++ b/common/bootstage.c
> @@ -351,7 +351,7 @@ void bootstage_report(void)
>  	}
>  	if (data->rec_count > RECORD_COUNT)
>  		printf("Overflowed internal boot id table by %d entries\n"
> -		       "Please increase CONFIG_(SPL_TPL_)BOOTSTAGE_RECORD_COUNT\n",
> +		       "Please increase CONFIG_(PHASE_)BOOTSTAGE_RECORD_COUNT\n",
>  		       data->rec_count - RECORD_COUNT);
> =20
>  	puts("\nAccumulated time:\n");

This is a 2 byte rodata reduction because we change the constant string
to be shorter. Perhaps this (and the later debug() message) should be
reworked to read:
"Please increase BOOTSTAGE_RECORD_COUNT for this phase\n"
which is hopefully enough of a crumb to lead someone to the right CONFIG
option?

--=20
Tom

--SFkIKWeWx7f4Ic8w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb8b5EACgkQFHw5/5Y0
tyxenAv+Owd7/fDF2lzRYtoqqChmc5hTZPaFMOpejaeude6xGjAVyOL9eeH+yu2P
65VAAlZSLKcKa4cw6h8R2bRPMDzYJ9oBehTUGErcSKrLkt8XrpWKODLn39mh9roT
QOoZJLiFj9pCl+TtBRFNhEW7KlJgyvx+HX1syiTOl7GKqrVkaUVUunOg7UEfnLad
WDuMJWIdZGa5YbLfgdmYJkJcvB4/2+e/5UsNBMvNCd2lxgTGX0iZh8W/GCaHZ9q0
BYXrEjLPVewGFuhkCwodJ+SK5vhXO3Qerqfrf8onoXc1rMXMv/lKkv/cuylQjRds
oyQu4O3ANf91z1DMh7huhmgg3XL1roIYb/sumKQymF9b5seuH24IkF1/4AXzpc7f
F0g6hSfLxe7dz1lUY5Kjb4Bz8vqHf1ZNm/Kqbp3qwR/3IDWGxqT8jp9bJhkDgmhZ
AFdegGeLbZ0uxwP9nsvLP6zmZ7sZbpeOdJneYo34E9flxmXlQNL+LK1i3e1zPqeW
vTFGmpBf
=TBx3
-----END PGP SIGNATURE-----

--SFkIKWeWx7f4Ic8w--
