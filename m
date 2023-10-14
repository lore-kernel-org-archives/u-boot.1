Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC40CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF66786F98;
	Sun, 15 Oct 2023 09:02:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Sq68nuWU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BB5286F1B; Sun, 15 Oct 2023 09:00:55 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8DF086FA7
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3b2b1b25547so1274024b6e.3
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697353038; x=1697957838; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uK5FkPH62zfDp6vKP5Rd17LZK66xcBcPVtrJ/+MOyv8=;
 b=Sq68nuWUSr480GkOfdX0P2/bxyj6FbESyNEpJh7N8qR1BNbFvHb2BWh4E1wO+NimMA
 TUdWyp76yngmOK0+Im9oHlYGn212lobscBKV3YOxmk9hjNSSs51ZcQYIVk6kCQdk45Sy
 m71S7INZjc6kXoiYhzQiM3UTnuKKjjKPdAeBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697353038; x=1697957838;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uK5FkPH62zfDp6vKP5Rd17LZK66xcBcPVtrJ/+MOyv8=;
 b=QKFUR06DUuYgQ6hm1ileMFFiORyiNv3dTgGk08afd8W74wDXUEgcLakA99pm4auN1M
 gpZk9KEctzGF3wCrX/2G6/aJq+Afu4D7xE6VGhswLsovwc6wrLG38DROB0ZD5rMaluXH
 Cm7bBGakzT1+aayUj+c2wb9G8qunZ4B3qQZXtPqHxXP1qd0h+XpRvrdMzHrugKhdd0f1
 jv+fVO88JnnVNMA1O0r9DPxucHIf7hoExSXXc/06zsF07ZtvrLSFqFilRb67yNQwLT2e
 UetGVR8xgcP1TByHAbdypAA9E4Da7+cRdNZuatS3+IDXqLa8t7BxJw8cdaLIMa2gSsrK
 HGyA==
X-Gm-Message-State: AOJu0YzJ3z61NFeg2cI+ZFzbHJDgs7XwMPGDa/xMAlU3PPK147iWjXBD
 /H4XnUWFgx5P4ILOpbzuo5Y1RXSFCEeZM+3e0rcFTw==
X-Google-Smtp-Source: AGHT+IFc0TIItrxf84jjwwZiNxXdj2AwlUeAQgpUclyTH1/ROnlPxW2eidpwbATtC3lp2anIFTw4yA==
X-Received: by 2002:a05:622a:15ca:b0:418:4e7:b82c with SMTP id
 d10-20020a05622a15ca00b0041804e7b82cmr35277788qty.57.1697294980581; 
 Sat, 14 Oct 2023 07:49:40 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 ki22-20020a05622a771600b0041b12d5fd91sm1545081qtb.55.2023.10.14.07.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 07:49:39 -0700 (PDT)
Date: Sat, 14 Oct 2023 10:49:38 -0400
From: Tom Rini <trini@konsulko.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: sjg@chromium.org, etienne.carriere@st.com, u-boot@lists.denx.de,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: Re: [PATCH v6 01/14] scmi: refactor the code to hide a channel from
 devices
Message-ID: <20231014144938.GY3119521@bill-the-cat>
References: <20231011100707.1007417-1-takahiro.akashi@linaro.org>
 <20231011100707.1007417-2-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S2crrsJwD46FwwfK"
Content-Disposition: inline
In-Reply-To: <20231011100707.1007417-2-takahiro.akashi@linaro.org>
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


--S2crrsJwD46FwwfK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 07:06:54PM +0900, AKASHI Takahiro wrote:

> The commit 85dc58289238 ("firmware: scmi: prepare uclass to pass channel
> reference") added an explicit parameter, channel, but it seems to make
> the code complex.
>=20
> Hiding this parameter will allow for adding a generic (protocol-agnostic)
> helper function, i.e. for PROTOCOL_VERSION, in a later patch.
>=20
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>

For the series, applied to u-boot/master, thanks!

--=20
Tom

--S2crrsJwD46FwwfK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUqqoEACgkQFHw5/5Y0
tyzZ5wv/UPRXjS2Rg1H27Ahqlb7TvstPcI77dxvx/j1mvbJlYxunBr5/OiP+C9/A
cl/QbVv4WpcrWH8Nv6GdBeePKPu6r5Fb84ffY9QB3DeRoK9TiTuFR5lj/iDiI8By
YCol6EOwZ4wgIpoQfyXRDeZ95LxoSTU6CSCVOUKI9hFO+orvlphnXHDDouxm+KR/
mvxCfWB8NOaOwt61UBpbedJ/k2rpzRTYAWaPlU/+T+npppIpw8rUpcnWRImWIsRK
3ALpUCfrpybR7l61EV+NrM7Ex/pxp3rb3Sswwn+9stGunxk0TO7hLGcXXSjCtrKu
nSelIXfMe9HGS99oK0C26e5LRsdhg2y6/EkKz0YSTmuFYVmXPEHjRpM3SGkNnX1Q
9qIi2nQKWXf09Vhoqj4Ui6k8rTqxAexnNN6Y207mGyXdGQAI63QGjSi2lLgQka90
sTbF7YMTfLz5GXhvxH1qBeJ2gEcWBUvV1Vznq0Zp3f/MP/9ahYAMXxrGLvZUqw0C
uGjokLqv
=Ja+J
-----END PGP SIGNATURE-----

--S2crrsJwD46FwwfK--
