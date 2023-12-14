Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5735DC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 17:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B119487B02;
	Thu, 14 Dec 2023 18:51:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sSYOUhlX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 827B887AEB; Thu, 14 Dec 2023 18:51:23 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEB6487B1C
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 18:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5e2be6dde31so11303747b3.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 09:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702576279; x=1703181079; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q+dCg+5eeqPF4SwmUvLz7tzaDVcEB12G19AeOsMhHas=;
 b=sSYOUhlXHdV4v8h+Wm+oBzPhhFdk94YMWYTog9jeZLGT46OEutC6hB1sGt9yu6xq0X
 ljQ/sxz3C3uSLX/Iye/jmq2OyifrlfdPBbjBBvdlV1ia+UUgsZViUJGNvoQKQ6jfdpJA
 QvSqS8vLKsX5Qz/j3UoIQcIg0SvWH9JizFB9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702576279; x=1703181079;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q+dCg+5eeqPF4SwmUvLz7tzaDVcEB12G19AeOsMhHas=;
 b=R50zmYDwStBWevWglv1fKAgfGm/MiP6ZGJQcc9cvaeDxWyTZHQQx1AsluqbxXLQjDY
 4tgfPiKlmo0Lh5STHxLS9cB+wF2oqSjLkZfuquxbDkzN+n0Z8x3zr/xugKhOBFzf2MLT
 +1cghzqtuX2AFn+aAt8fQnCqUVLsF27//klBjKU6/KjZsDP5A6MfT2cLiShxRzNW/Yk3
 iGMauNWsuD/brQbFyt7jAyUy9IvUs6AkmFVMW8L6ixXruhq0nCKxN0O3Un8uzHGCYrMg
 mXN+RaFehlSCc0/wNjkBgqqRJlS45NbvO/S+CGUQdebfxTogfXpp49WacYjjdkAbhYfg
 lR/w==
X-Gm-Message-State: AOJu0Yyqhx6tOrob5oLXTqYjP43Ye7c7K5WPkhExr2K5hCExKPwBocVw
 /dhp2DwVyvo6XpdaEGB3r0+uBg==
X-Google-Smtp-Source: AGHT+IEAbzlpGEjhZoREZwMmqU7flrQlB8pN56U/jysCWfKHkAxSi/fGTwk4ShKj1sZVtznhtHzTsQ==
X-Received: by 2002:a0d:c345:0:b0:5d7:1940:8dea with SMTP id
 f66-20020a0dc345000000b005d719408deamr5487029ywd.81.1702576279450; 
 Thu, 14 Dec 2023 09:51:19 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a815207000000b005e285504f2asm1787915ywb.94.2023.12.14.09.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 09:51:18 -0800 (PST)
Date: Thu, 14 Dec 2023 12:51:17 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v2 11/21] bootm: Move do_bootm_states() comment to header
 file
Message-ID: <20231214175117.GE2513409@bill-the-cat>
References: <20231214165112.2182274-1-sjg@chromium.org>
 <20231214165112.2182274-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aZIrsslbLQvszsKR"
Content-Disposition: inline
In-Reply-To: <20231214165112.2182274-7-sjg@chromium.org>
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


--aZIrsslbLQvszsKR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 09:50:20AM -0700, Simon Glass wrote:

> This is an exported function, so move the function comment to the
> bootm.h header file.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--aZIrsslbLQvszsKR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV7QJUACgkQFHw5/5Y0
tywZewv+MnmIsKrlnLGEjVY3KV+RAUOR+NA2FKrMl49IyVgw2zSWxA8o8qtVDEp8
JT/0os43sOvTfjqz2zAl6yfnha3THtJvVUPSxj4wJLY+TtL9QGRNuTV/boKsPwD5
SY9RSgdYCQU+2d+uCTxq807Krzogm+SvWLx4dhrEZpyM0hPy+KxRCwzJpT17OQNy
jAAEOLTTF/B/DdF6M/FLYDlht6FUoryRkR+ROGhnqesuPrtYZFkgwyn9evO7rgSb
xiHE0bpZ560YbbS+4xiHlJaG1AXXyrkjCSn/GNIPqJV5rWOAgDsh5oNHTz+glXEn
XbRmLQmFiaQmq4KgxVnDkpFYn+NSF/tZwZdiKScJpa45XINgVzcAtO/1MuATnJ9r
vUzXwRyd78LaopkQTLaYAqSQYgJ/adJWpF4LN3vxUpG6xD4VU5W2+VyVyDh2R4ID
iSEr0CLevehrLBgQKA6iu0HudP0yjJAHYk4b9g5veYkbyD78mdOyd+xpwUPwjVK5
cH1Rxy7O
=bxaI
-----END PGP SIGNATURE-----

--aZIrsslbLQvszsKR--
