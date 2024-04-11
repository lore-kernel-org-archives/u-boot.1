Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B919FC4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 23:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF5EB88137;
	Fri, 12 Apr 2024 01:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YV+5B8zY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 871F3881D6; Fri, 12 Apr 2024 01:53:07 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64F9488211
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 01:52:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-78d62c1e82bso21520585a.3
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 16:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712879577; x=1713484377; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XalpfpZe71VzTnV5XROTRkFEj0iwJ8bz9IQKqPLnZI4=;
 b=YV+5B8zYQebH4tfFkepcb50U6J04lk4uy6ruaQf4AifDz92kKEN1LP9Z3C0NDdgWen
 eWj6wdY0NjOqFRVd/5toHl58+sXkG/fmCQOeoNJB2RIQATyrvomWOjrLkmtKrksJzlR4
 7d4fTuV3TaSNeVcaJjqb1zMCj7G8EWf8agjP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712879577; x=1713484377;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XalpfpZe71VzTnV5XROTRkFEj0iwJ8bz9IQKqPLnZI4=;
 b=Zzxqu7pRSDUHswE6toP6HxkjOy7oPQTUjIdqk+hrULlEkt15r5SHeziY/go0j6mrcy
 hOET+MOZaqmM3K56TA9RlpBLru99vs4Pr8Lx61ICLzpVJbhL33tqX0bjJO4FQRQhX4fQ
 STkNLHXhoY0BEzi1oqSz0xD5VSOwCnMd2Fd9xlmo7BhGy9IvQVME3/0ylwCW9AXiHazX
 JjfJw3vNNVCuDZdToHDESM1gsj/gyx4FP9tFbR3ZUAIu8Liyp0gq4CMZ3mDngLAK+76Y
 8WftPSiSOBptba1dmwtQQR2FS6L8v1EBC3ihvcEOQCjwhOwHw4ZhN2wvrtkA5Gz3ZdCY
 LTCA==
X-Gm-Message-State: AOJu0Yx7DuGCiY8/jpd1pFSEJyRm0FmZKOz3ISxHYrNGEx+L7AlIezrF
 bDaTc6xZ2d5cX5yHngXF/hyXO1c6yT+9xr3bV/L6sy3Lecn20uqTEcDE9Lbwccc=
X-Google-Smtp-Source: AGHT+IGGIMoMbgOFfcV75GA6icdqGbXK6CZE+kWBDAC3lP9mWsDopjmh8GTb0EBBnxhA2vh7LSxc3Q==
X-Received: by 2002:a05:620a:7fb:b0:78e:c0db:c2e6 with SMTP id
 k27-20020a05620a07fb00b0078ec0dbc2e6mr1112314qkk.32.1712879577140; 
 Thu, 11 Apr 2024 16:52:57 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 xx1-20020a05620a5d8100b0078d6e468099sm1637381qkn.113.2024.04.11.16.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 16:52:56 -0700 (PDT)
Date: Thu, 11 Apr 2024 17:52:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Greg Malysa <greg.malysa@timesys.com>
Cc: u-boot@lists.denx.de, Matthew McClintock <Matthew.Mcclintock@analog.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Alison Wang <alison.wang@nxp.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Andy Fleming <afleming@gmail.com>, Angelo Dureghello <angelo@sysam.it>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ian Roberts <ian.roberts@timesys.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Linus Walleij <linus.walleij@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <monstr@monstr.eu>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Samuel Holland <samuel@sholland.org>, Scott McNutt <smcnutt@psyent.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Thomas Chou <thomas@wytron.com.tw>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Wolfgang Denk <wd@denx.de>, Yang Xiwen <forbidden405@outlook.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: Re: [PATCH 0/3] arm: Add Analog Devices SC5xx Machine Type
Message-ID: <20240411235250.GK2493117@bill-the-cat>
References: <20240411234021.14534-1-greg.malysa@timesys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5is1G2jMx0W1JCfv"
Content-Disposition: inline
In-Reply-To: <20240411234021.14534-1-greg.malysa@timesys.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Fri, 12 Apr 2024 01:59:21 +0200
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


--5is1G2jMx0W1JCfv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 07:37:27PM -0400, Greg Malysa wrote:
>=20
> This series adds support for the ADI SC5xx machine type and includes two
> core drivers that are required for being able to boot any board--a UART
> driver and the clock tree driver. Our corresponding Linux support relies
> on u-boot configuring the clocks correctly before booting, so it is not
> possible to boot any board without the CGU/CDU configuration happening
> here. The clock tree itself is only used by the UART in this minimal
> patch set, but is of course broadly useful for all other peripheral
> drivers to be submitted in future patch sets. There are also no board
> files or defconfigs included here, but some common definitions that will
> be used to build board files currently are.
>=20
> Some of the configuration code in dmcinit and clkinit is quite scary and
> causes a lot of checkpatch violations. It is modified from code
> initially provided by ADI, but it has not been fully rewritten. There's
> a question of how important it is to clean up this code--it has some
> quality violations, but it has been in use (including in production) for
> over two years and is known to work for performing the low level SoC
> initialization, while a rewrite might introduce bugs that could take a
> significant amount of time to detect in the future.
>=20
> Please provide any feedback or comments that will be helpful in creating
> a v2 of this patch that will be ready to submit for inclusion into the
> main tree, as well as general observations that we should consider in
> other driver patches before submitting them.

Does this series pass CI currently? Thanks.

--=20
Tom

--5is1G2jMx0W1JCfv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYYd88ACgkQFHw5/5Y0
tyxxJAwAiU27UcaYCKF7E96m5dS7xlEIMCJmgCb6PgoEdtfagRK2jAlndAoo62Bq
ZXFkvW6AnB1YJMit4+V6ZPoBN+gpTl5PZqpF50H/Bzy70ahdijifphzhTaqbahfD
K7ol4Yx2wrC8pfkRQ0Q70SuRrydRgO/nGCyPhj4ftL+E98HQGlE7EXYIqYPy/j12
BPmhKoPlRkBhdvoWfgtEhGzB3mMGVugIpzSdF5mbfm/xPRs8f5dgOdWQ3QXBH9gR
OWZgVG9huxVH0XU+nDaApkyMJdqvVArOaUG+kTxqltMSxyljAfBZy4UBRTtiCqIJ
T3O3wL+Q4TMocNYCnp3uz3JZ8e+bghytY4VmUizjTXXRviFcLgFfT2v1nojSlAWU
LF8Stqhqbb+58okR6mmwgdV7vFuFa3Zm5BKOFUSW63JsbM/bkMDItAlOD+ZBILSn
yC+3JZPlzLZ+DyJ0GiDp1FGycsZ3u74eSRiLRrazz8Yu/XZOXki4m0ovrVzN3nnS
ro73gd+U
=8s0c
-----END PGP SIGNATURE-----

--5is1G2jMx0W1JCfv--
