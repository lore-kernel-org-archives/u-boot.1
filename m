Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C46EC71156
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 14:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5031586E65;
	Fri, 18 Aug 2023 16:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kyq6cBgG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B69EF86E64; Fri, 18 Aug 2023 16:23:44 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0499086E58
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 16:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d63457dd8b8so972391276.1
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 07:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692368620; x=1692973420;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rEEt/H1YfovvwpoR3elnDKhKdFBN5mXfUmoEvJw2Gqo=;
 b=kyq6cBgGLdXcOwwsCorX/Zd7AvQNlx4ctTzcUnraHmJ0/tlHt67bk4JwEPEl6crcJW
 u4O88JMBusMMZYsSp/QRc7Ta8EdxtPoTFrMVoQqRLtYfFGGZ+pgsegWY12RRtpCHIFME
 tsOqZQ1PD90IcCjSfDpPYOE8m6i2hA4nmjFHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692368620; x=1692973420;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rEEt/H1YfovvwpoR3elnDKhKdFBN5mXfUmoEvJw2Gqo=;
 b=CqqctVrYmAJRbEfAyK4f9+QOHW7mqbMkd/6fwN54WmXaTyekJWk6w5y72usn8Wt3CP
 poQg2Tzyg4QtkX5rgBIwaewhnuvPYV6mg4yVcVVRuXbIsknmgwiXAGUk+Lb9Aw8+63Sb
 SCAcqGa5tjFYn6AmbckIxF7TZ9OC8Uld1oFCSoO8tHxcnwki7ztMljS3AloOr5cDEjzY
 gyFhKKcMPPzYqrilbajwERkbEmDajWxd2dbtGGiPIMWmgLSwqPIlthpt7yibITOavLQR
 /q5q6dWJ7XTi0AmKOY1oDiwxqDQ4CtzKobJd5pzBdzXDYzf6o0sm0gsm1GdgRCqfGGwo
 TwUA==
X-Gm-Message-State: AOJu0Yzivw6PLvKxgeRRnpXmN9y9wsOrTD69Pexgmqflwybctggo4Mle
 GJLSplmfUYm+gpa92n2/z+5kHQ==
X-Google-Smtp-Source: AGHT+IGIXQrU7x6EpPJEtxA/dGUuuS8Zdgc/hEpDzV38M87AGDXCOlq8FnhIrIoHKzwEVnU/3fgUww==
X-Received: by 2002:a25:40ca:0:b0:d4e:ea00:dfb6 with SMTP id
 n193-20020a2540ca000000b00d4eea00dfb6mr2803898yba.58.1692368620612; 
 Fri, 18 Aug 2023 07:23:40 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-38f7-b1b8-9b5e-5709.res6.spectrum.com.
 [2603:6081:7b00:6400:38f7:b1b8:9b5e:5709])
 by smtp.gmail.com with ESMTPSA id
 z9-20020a25e309000000b00d728a2738f1sm433560ybd.61.2023.08.18.07.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 07:23:40 -0700 (PDT)
Date: Fri, 18 Aug 2023 10:23:38 -0400
From: Tom Rini <trini@konsulko.com>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/6] cmd: gpt: Remove confusing help text
Message-ID: <20230818142338.GV1515023@bill-the-cat>
References: <20230815162726.1524958-1-JPEWhacker@gmail.com>
 <20230815162726.1524958-2-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="buILZ61PhF/Yyfc4"
Content-Disposition: inline
In-Reply-To: <20230815162726.1524958-2-JPEWhacker@gmail.com>
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


--buILZ61PhF/Yyfc4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 10:26:55AM -0600, Joshua Watt wrote:

> This help text appears to be a fragment of the text shown when
> CONFIG_CMD_GPT_RENAME is enabled, but is confusing so remove it.
>=20
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--buILZ61PhF/Yyfc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTffucACgkQFHw5/5Y0
tyyPDQv+PJ/6EhfJCZ7ay97u2ggYBon0335QNSDAPYQ4KI/zR+/R6cd9NdQsAkqS
HmKHVnu6wIb+RyCFgqBCpe5eqRHhE2ld+pkbseuW4trJ+c0XiqxQ/nrXsDi8bRFH
uS/yiLDrkCXZoBozXsfeiEGXh8ej0oErUtPY1WEBHhEJap+5XVtNMsONJAfbVpee
ueXXzukGgTfbiJv1gKrpHwyCuHAhF2v7Z9rs55072AB/rdMjmR3J+W4C6U1QW57h
WqMkL6pz0Tf7hv+TpNRJQ+nhy1K5mbXTk+Fo/8F2CQW7jDTek9ZhUACetZP192X1
7FgDCPR5MiuN+dvToUlQNgGvK5zAcLpmOkqvymHu2qfZfkEBzfNV2qh732P7JSK/
CtF/7of+4FEE9Wl4Pr+9tdbrkDo+Z0z/r+1efzvHgjB+nTSdIuNBHYYvS6QtJ24k
s06oJ9ZIC+bUQnjl/kY01PtiVaorqnnc7AIk3MLB4lRniSNirO25rg2mhP73zwcC
VpU0BUfp
=CgmQ
-----END PGP SIGNATURE-----

--buILZ61PhF/Yyfc4--
