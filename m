Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD699CA1000
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 18:26:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC95483A13;
	Mon,  1 Sep 2025 20:25:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fb22EOja";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93CAE83A34; Mon,  1 Sep 2025 20:25:57 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75E8F83990
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 20:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-319814953a8so575598fac.1
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 11:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756751154; x=1757355954; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vRtRlZQdToIB0guD22etfjUP5l55PeQoZeina6FfBuM=;
 b=fb22EOjaGG4TbRMl+Ic58CqRp9VpIAEVn3hAZxAZWksuNSNqWZCv5AzdnswhSMSV9r
 1Rwr0lI//52EW+uV1KxqTnsryDCU2jsa8FbuRG6gin6vQ5MnLyrY1+lD3lg6iNcPY9Tq
 +vyU2Z4KS1GtMLBh+P9oBFwtw0O3LPid6e7k8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756751154; x=1757355954;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vRtRlZQdToIB0guD22etfjUP5l55PeQoZeina6FfBuM=;
 b=mmBkRxTUG6oThypJ7wFBDmKSUjNJb82sXvgauaiZG1xX5OtDBBu4TZQXSO4gzYLld3
 q+rPTqHP4rUPGU8ZGta6JZJ1C5trcf/68uLMcw+sDckDsKkPOTmuFsFXd1rAQL3SsAqo
 BnBQTQrttMgjlsPnr1UH/QHjnlUJ2nAdQsPT0KQ8kCBaYO8z/1O/5ca7SCzf6Gi1/cQ+
 aEw4fDKjN1hvsaxnPgSALP760qQG5W+s3gsbA3iUc9Cnx05n5IioEysLfuOSPtEmMHnq
 4GN2pcXaBBE4cp4IMBu3HPaUGc33C3h6sBnlVftl1TcFB39FSR5JhI3Ntpq7J/WWN9Cv
 jZNg==
X-Gm-Message-State: AOJu0YxhKrMOv8yJXywcpPKzmJUV65dr29VWMp0dKtjVACdDS3Gq64U/
 yiNDvikinDC5pdsasTZ3VWI+r/21utkUrqdB9O5WxCU826VM1jFTyEhbT4teb82uslI=
X-Gm-Gg: ASbGncu7md7sSGX40qUioTzKaK8BWtMWrXNCjscBRDAhfgkoVYgnhsm9M0xAVoBG2ev
 ZJa2o7Mjo/9Q9Ogrm78iPQZPL52zniCnNg8lF3OuS6LzME7NGpVEHRKaUiFs5zE5dFtVyCiyCwZ
 LO5kezOqzJejinxKjyVqGWeKj+x4S4V6rExD3JQggjnGOjN6V0oIVIEoK1XPGOTleKUQ3yKvAFi
 ObSu+QCtalBvjGZHFZNIOtT64eAVIpiL16b1XB3DpKRwyCkmpV0XwXg6aJU/RVF4TmI5/9fu/QP
 xQWWrM5His46t4bTK0NZrNSrAPhPeognz+xWQ+R1qJFlwxYQduswO/DL3nXsHTZAynh2myYCVNm
 wKddVGjiY0DT/Z3HSs5o6sig9gVwaKwlPFMsTcNNrnF1owziirqPcUGui
X-Google-Smtp-Source: AGHT+IEscXHsRW12RRYdLiUdsyLajpjLbYy/0FrDom7/nDG1SzCfkA+Bb/4SvUnWX6qI6p9tMIAU+g==
X-Received: by 2002:a05:6870:5115:b0:315:aaea:cbd1 with SMTP id
 586e51a60fabf-319630c2587mr3801199fac.12.1756751154168; 
 Mon, 01 Sep 2025 11:25:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3196d46dec5sm1830436fac.19.2025.09.01.11.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 11:25:52 -0700 (PDT)
Date: Mon, 1 Sep 2025 12:25:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 2/2] ti: Do not remove ft_board_setup for CONFIG_NO_NET
Message-ID: <20250901182549.GD124814@bill-the-cat>
References: <DB6PR05MB45517FBC403C54F9589F03878307A@DB6PR05MB4551.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="woCDMeEvjxHk8afS"
Content-Disposition: inline
In-Reply-To: <DB6PR05MB45517FBC403C54F9589F03878307A@DB6PR05MB4551.eurprd05.prod.outlook.com>
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


--woCDMeEvjxHk8afS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 01, 2025 at 04:06:10PM +0000, Maarten Brock wrote:

> Even when CONFIG_NO_NET is selected there is still need for a
> definition of ft_board_setup(). Thus move the checks for
> CONFIG_DM_ETH and CONFIG_DRIVER_TI_CPSW inside the function.
>=20
> Signed-off-by: Maarten Brock <maarten.brock@sttls.nl>

Shouldn't OF_BOARD_SETUP be disabled in that case?

--=20
Tom

--woCDMeEvjxHk8afS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLXlLQAKCRAr4qD1Cr/k
CmsmAQCZnIdRkfTNuyVNf57zoamui5c1WJD3FumE2BVBvfPwoQD/ZN8DRQvZ83pS
YY1TnWg2tpCm0k1DCzvmLU0rqWNBhAs=
=Yh6r
-----END PGP SIGNATURE-----

--woCDMeEvjxHk8afS--
