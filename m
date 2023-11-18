Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C72AC072A2
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 00:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C07828751C;
	Sat, 18 Nov 2023 01:57:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cGWVa7zC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00CFE86DA2; Sat, 18 Nov 2023 01:57:39 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9589887512
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 01:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-41ea8debcdaso14375481cf.1
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 16:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700269055; x=1700873855; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZrrLn44hPC5DdB8PmEIM29gY0gQHgjdcU3vcHaebtMQ=;
 b=cGWVa7zCwd7yEjBTaFc9ut5v+JqCiFHkj3Z5Cb2+nbQ1acFlkM1bf+IAHEJ6dwcGoI
 SijN/UrU/Q+xQfVAoyxulXBIiw2mTxOnHemA1ID0VafzpzVbcSKs/dUXd5sACiJI7lH7
 8YHITDQ8ouxmcFCPCK6BlrrIBowa4wi59xqBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700269055; x=1700873855;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZrrLn44hPC5DdB8PmEIM29gY0gQHgjdcU3vcHaebtMQ=;
 b=SSCi0LZ1ovrTQPFGY22+y1jlT6B9MHlwq95SEZe/+Hkg6yXAaPetDIukSaXqeYeMwo
 zi3Oz/R8NfBJr1sUFpQdQs4FvAAPnqBN6FtyPMuVwnrD9eWWpsWteCXdcvl7nnAYsrAi
 N/9Jjr/0b9vzriR3wNsFu5Arfp7NAbyyH+QGC4nUqmseyVH+Qqeey088gJslTSSGkORL
 JBgxFH1VBSy7ma6+2AWLFwwlwLdUi0VsPe7e4hAi9O5CUg7hJY5QoB6qyzaU/BYlg9wl
 wQpw9Eqf1Mm8lVF9FqP+gGMP/T75Ux1WUeN9vjOHyTHNuWIKY0hC21EiYDb0q/41C39w
 cADw==
X-Gm-Message-State: AOJu0YxaWigOi4m1/VWf3p8M0t1IAT3Bc+drDSSJAr21JYGxHu6GE1Dl
 UNpPfjfLNhC0JPh/OhxU6ibQYJO8uWLMG/XsULcGaw==
X-Google-Smtp-Source: AGHT+IFugYVpIBsDz6Vecw4rOnvrfffJryk7U6sdgR/cpYUBzvw2xKmjDRL4NWiA6xcf9Z48YcZUDQ==
X-Received: by 2002:a05:622a:8e:b0:41e:453a:4dfe with SMTP id
 o14-20020a05622a008e00b0041e453a4dfemr1322665qtw.36.1700269055394; 
 Fri, 17 Nov 2023 16:57:35 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-dbd8-aafa-ccfe-bf84.res6.spectrum.com.
 [2603:6081:7b00:6400:dbd8:aafa:ccfe:bf84])
 by smtp.gmail.com with ESMTPSA id
 h8-20020ac87448000000b00419714dd0b9sm946787qtr.62.2023.11.17.16.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 16:57:34 -0800 (PST)
Date: Fri, 17 Nov 2023 19:57:33 -0500
From: Tom Rini <trini@konsulko.com>
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, pbrobinson@gmail.com
Subject: Re: [PATCH v5 3/3] net: bootp: add config option BOOTP_RANDOM_XID
Message-ID: <20231118005733.GH170968@bill-the-cat>
References: <20231118004826.157835-1-seanedmond@linux.microsoft.com>
 <20231118004826.157835-4-seanedmond@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8oBRsGBtAsjCpQwn"
Content-Disposition: inline
In-Reply-To: <20231118004826.157835-4-seanedmond@linux.microsoft.com>
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


--8oBRsGBtAsjCpQwn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 04:48:26PM -0800, seanedmond@linux.microsoft.com wr=
ote:

> From: Sean Edmond <seanedmond@microsoft.com>
>=20
> The new config option BOOTP_RANDOM_XID will randomize the transaction ID
> for each new BOOT/DHCPv4 exchange.
>=20
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--8oBRsGBtAsjCpQwn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVYC/0ACgkQFHw5/5Y0
tyy2ZAv9FSgMkqecvo+JsKoxXEDuN9SPDqvxDd+urK0hDEcVxSuVf8882+B3+DUP
blmeTFamwNL4AcR5uM2CRntgO4vIe61XJHKOAHSaIScNdyEilTx182nvA062QTIx
fPZQhCfPfPp3JbV2c2DV/G6lBD3kbNZh7ZIkHyQppjGZHxWACwzq4eP9Wwun9pSA
DFmR3HByPecPvQkKlexFDtNWfkwTRSFT72j9Y9CRuUEvJR7J1By5UoIVtmlLIN/z
SHW64yalLaY9x1yPoWQhwq6OhfCe1lNvq4CT0tf0hzG8xYFL0qzkX+wuWOS9lNKV
TwEifGjiCMl1S3uh8zuplCjxVT9y1mgqoptoRKdX8Y96W+HPIRCAxzYXj9gGzYaD
h9ksJCgr6MrWPwrY0Mr5JaJ8Mi3ScW3p8nzo8W0sK6EGggrBYHc8poLfSeWWhk72
Bp7itn2/TW3Nz4xtqYUWIpephAhhZCZdNr3Ef86kroCMPICmxdxDHjc5w84UXkjM
tdJCYDKk
=xIrq
-----END PGP SIGNATURE-----

--8oBRsGBtAsjCpQwn--
