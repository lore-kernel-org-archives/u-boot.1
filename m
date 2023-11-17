Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EF5C54FB9
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 22:08:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7785A86E96;
	Fri, 17 Nov 2023 23:08:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p9kwZQAJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B542F86EB8; Fri, 17 Nov 2023 23:08:46 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1147786E42
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 23:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7781bc3783fso152663385a.1
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700258916; x=1700863716; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=coVk7OS4T/V+OJOGSWsotlQM4gavKpmydSpX/cZmkZU=;
 b=p9kwZQAJkOMJxo6RlH+/DnzqUI4CAgLcioE/bDS492SeYMMrpS4er6yYTIAaO5JnSJ
 2UXzP+EQ0qZ+2w1S+kdAhxyZvlG5nExZVji0gU4jlo30uwWt/Wb/0Jyw+QjJ6gG1/Hm1
 O5ad6yk2bAl635CGfwQVoS0ZJwF7xzhGUJ+Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700258916; x=1700863716;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=coVk7OS4T/V+OJOGSWsotlQM4gavKpmydSpX/cZmkZU=;
 b=UKnUADbZ3oFE5nCjmBnbUPDrKtTqv8Qzx4p+1AnFdb1LcwgU9rmXvsdI3VtshBeVDP
 jwzUZlfVQSOsBkMyX/oG8pumL/8bCSD9nRsda7D/Z8Jn+FuZHRlWc8eDR0pnVTyvzlF5
 JE9BuvxsIxAy670GbZhFAKSardy6qLOp4qIyCACxnnz8N3qppSL6gNGNtB7Hd7yZscDk
 1pNz0KKs5Hv72xIoW97pDvtxttjCYsBndRlepg4cJtT/dVOn/AUDQxImF6N7y/B4Bs4W
 JnzRCfgyt11bN6VFTGls5xWBXl5UYsfteg/P5qyvkdU+RDFFiQhiUdOEbVLakhTC35XU
 AGlw==
X-Gm-Message-State: AOJu0YxhkBnT9ZYcNjQ7VtLe9ZlXGKA3qWC80QOU6UKODhApeS93dhOq
 qv9ucpqpSJOBnVMbM3noL34MfA==
X-Google-Smtp-Source: AGHT+IFWKiUN494pGkFP2UP2cBVZv8H9qCrOYBa/oHvkboKtZWA/9m37GjEMq3CwI7rgSdGGFrREoQ==
X-Received: by 2002:ae9:ee03:0:b0:774:3147:425a with SMTP id
 i3-20020ae9ee03000000b007743147425amr886567qkg.16.1700258915820; 
 Fri, 17 Nov 2023 14:08:35 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-dbd8-aafa-ccfe-bf84.res6.spectrum.com.
 [2603:6081:7b00:6400:dbd8:aafa:ccfe:bf84])
 by smtp.gmail.com with ESMTPSA id
 ox15-20020a05620a828f00b0077a02cf7949sm916305qkn.32.2023.11.17.14.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 14:08:35 -0800 (PST)
Date: Fri, 17 Nov 2023 17:08:33 -0500
From: Tom Rini <trini@konsulko.com>
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, pbrobinson@gmail.com
Subject: Re: [PATCH v4 3/3] net: bootp: add config option BOOTP_RANDOM_XID
Message-ID: <20231117220833.GB170968@bill-the-cat>
References: <20231117214925.138486-1-seanedmond@linux.microsoft.com>
 <20231117214925.138486-4-seanedmond@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rO2kDkkT0WBXQJX3"
Content-Disposition: inline
In-Reply-To: <20231117214925.138486-4-seanedmond@linux.microsoft.com>
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


--rO2kDkkT0WBXQJX3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 01:49:25PM -0800, seanedmond@linux.microsoft.com wr=
ote:
> From: Sean Edmond <seanedmond@microsoft.com>
>=20
> The new config option BOOTP_RANDOM_XID will randomize the transaction ID
> for each new BOOT/DHCPv4 exchange.
>=20
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> ---
>  cmd/Kconfig |  7 +++++++
>  net/bootp.c | 31 +++++++++++++++++--------------
>  2 files changed, 24 insertions(+), 14 deletions(-)
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 93bf752035c..244237e6d60 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1853,6 +1853,13 @@ config BOOTP_VCI_STRING
>  	default "U-Boot.arm" if ARM
>  	default "U-Boot"
> =20
> +config BOOTP_RANDOM_XID
> +	bool "Send random transaction ID to BOOTP/DHCP server"
> +	depends on CMD_BOOTP && (LIB_RAND || EXYNOS_ACE_SHA || RNG_NPCM)

This should be (LIB_RAND || LIB_HW_RAND)

--=20
Tom

--rO2kDkkT0WBXQJX3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVX5F4ACgkQFHw5/5Y0
tyxIJAv/fbyngZ8nlTBttCrRve03fYv7P3dWi4nXrtKBkg4+hQ2Cc49YfBdognFD
PmqpKH774CeH+NFuRDW2qXG/zfhwWVjzT4uVPewf20PDaDXOJoEBLM831SJcbxZJ
UfMAyPynp9fasIZfU8AUP7YP8EYsd4fRYI+a2Wl2Xy4e6CyGJU+SKNMSFoKhuxp1
WnsdW+/rueH32AOke49w5lraTx5ZWg9Pxw3/nb2WKeIj2IhBTUnAD88F73+L2GON
WxeFuy/V43MbT4I5IYUxB1F3+TLn2Ld5JPux2yj8s95WKqG7J5/OYVrnUSWjYj4U
2+Cbp6WXG1GnlNbXWSEZBR/mIf4ncMwEPE0MuoP/Kse8pZqEIh2cV9j930Xri4rc
hA4CtDLp6icohaKJSZlBBcTix1H+dBcRzzE9bJAquaKEby9bxYy2Jm3eqOjYQQhd
FmX4HMbFsttCze8gc7JTaiS7EG8pWKJPXzZCgkO1Jd61jLG7VwjXX+37x6LBcVs8
y83PZlpn
=OPpe
-----END PGP SIGNATURE-----

--rO2kDkkT0WBXQJX3--
