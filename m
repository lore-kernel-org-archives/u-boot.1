Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B10C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 04:42:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7746088A74;
	Wed, 21 Aug 2024 06:42:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BB5PFpyK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A28AC88A2D; Wed, 21 Aug 2024 02:48:38 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F47988A64
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 02:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7093d565310so4625670a34.2
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 17:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724201313; x=1724806113; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F4cpnRUbnAoAqk+Kfcv48x3+t0Pl/Y7FVWFKZHEx7sY=;
 b=BB5PFpyKTsYiBQClJO+NDhBniH3o1bvMHWBkY45AxRTpSIOGqr9tvP1kbdI+4J1epB
 6MgAWv9sz9G5sn+wb9DnEkdTlzph5CO2QLHDEhEMbIYGqW/EK9+vnVjr3Mb5QraNVD4N
 7oh5ECgZ+c1x0z8Lt1yTzU3XoywS76wvweK5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724201313; x=1724806113;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F4cpnRUbnAoAqk+Kfcv48x3+t0Pl/Y7FVWFKZHEx7sY=;
 b=gIn6IVpo0UFuyBYeqeSOFJT/HfNtqwyeynSuq8liMATNghzq6s/nLPgsxC1ZH2J+KR
 Io8Urwd0OL8qBIvW88Uuw3s8tZlCdIozzhFy9cbSq7lmpwPeKZryUX0QT+P898PYu1Oh
 Q2zT02AJECMEofIktkrSYeAYTQUHKIUBLONkPndGUKr9Sn2v1UB9bLCk/MYtWE3+mt8y
 bkFULQCSIl+4m+nC0dOGRexp/jxe/x0hXT3E1pImddG+D8vK7z6yQS7bT+ntZwewh2+V
 tz6eV/+7R8tHstUyh0fnMM7cusbWswwIt6NhipM0QSK80nvGAqM8gSMBanaNEcP1jgqH
 h85g==
X-Gm-Message-State: AOJu0YxTt8EeSy4ZUNgDWvCxXOnk7aYdaZ6VMuAfrvXbqFf7xfW+I4Tb
 Am3TSONauEDvW+sOsc9wmqzHUEHnLbcfww7bwV29LR/WICtYrpcBMLW8cOkn8N0=
X-Google-Smtp-Source: AGHT+IG8h7o6NKe523EqkkJz77o9p3Zyi8U7l79DFcmFTr+AZR8rXaRn3X0GI04OwOPxyxMzvz1eVQ==
X-Received: by 2002:a05:6871:8a8:b0:260:e2ed:1abe with SMTP id
 586e51a60fabf-2738be3c4f9mr610175fac.39.1724201313204; 
 Tue, 20 Aug 2024 17:48:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2700410cff0sm4012851fac.0.2024.08.20.17.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 17:48:32 -0700 (PDT)
Date: Tue, 20 Aug 2024 18:48:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Aaron Williams <awilliams@marvell.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Anatolij Gustschin <agust@denx.de>, Andrew Davis <afd@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bin Meng <bmeng@tinylab.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>, Enrico Leto <enrico.leto@siemens.com>,
 Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Huan Wang <alison.wang@nxp.com>, Ilko Iliev <iliev@ronetix.at>,
 Ion Agorria <ion@agorria.com>, Joao Marcos Costa <jmcosta944@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 MD Danish Anwar <danishanwar@ti.com>, Mario Six <mario.six@gdsys.cc>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Michal Simek <michal.simek@amd.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <sean.anderson@seco.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Stefan Bosch <stefan_b@posteo.net>, Stefano Babic <sbabic@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Troy Kisky <troykiskyboundary@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Wasim Khan <wasim.khan@nxp.com>
Subject: Re: [PATCH 00/35] global_data: Reduce size of struct global_data
Message-ID: <20240821004828.GA1030206@bill-the-cat>
References: <20240724150922.2343249-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HhXs4EgSa9WoTRDA"
Content-Disposition: inline
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 21 Aug 2024 06:42:54 +0200
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


--HhXs4EgSa9WoTRDA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 09:08:47AM -0600, Simon Glass wrote:

> The global data structure has grown quite a lot over the years, being
> the best place to put an important pointer or something that must be
> accessed before and after relocation.

Please rebase this on top of current -next, thanks.

--=20
Tom

--HhXs4EgSa9WoTRDA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbFOVwACgkQFHw5/5Y0
tyx3cAv/VvH05fyFQMnSTd0EAVhEGawloVLu6vPbXguyKVhDYMA8A0iJ92djwKkk
XKUcF6Ao8Us2pL5DCL+39plO7M9el9jWXghZ8HqUE48lB3fjv6BSjdagpiWbHgHP
Bu05aRozXcBPFnUlcVXBR+Aqr2OWINn3DKuDl2Enx9gbFvrmJXUSuv31ZBPaz1TY
LmSvmokLhZNqAv1KnFNFzjCeczMCLPKZhEwG8ayLMhHHbVIelD3TwkZrVN24P1aD
ji82mv2F8hkHo7RqHXBtzc/a3G88/iPO3ppfbWggvUkjtJmutpr/g3BlDWGcGbqF
XEfmbvM1OhfYpocCBRttRxCQUU4roQXbQiMCy/h3fUWuOyDlfr1Qjva17jXF7sO6
jYtrQPILTFdyOk3pWTE5zAl/U7FRrdrdn+tP1JC0HASUeidEIwS7OeQvUiSSRcyD
5LMw8Z64jlhZJKjoFZ0oaylrnZsXqHS4b+/bp0dna6r4Jy1mmnKrGMW/be+/6kdQ
H144qAgH
=dgcS
-----END PGP SIGNATURE-----

--HhXs4EgSa9WoTRDA--
