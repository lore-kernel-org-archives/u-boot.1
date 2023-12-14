Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E58EC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 17:52:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 599B087B46;
	Thu, 14 Dec 2023 18:51:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n+E4kbCP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46A3E87A92; Thu, 14 Dec 2023 18:51:39 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2967F87A92
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 18:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5e266e8d39eso28326277b3.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 09:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702576296; x=1703181096; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JmAunETMfAMvtmIMueXKgBAz3jvlLc189MEAOOM68Ow=;
 b=n+E4kbCP9+GB0+GuKr+SyLWgrCYgnoBMwW5YfTpV1IVPbpIv9uq2DShrsNhDR1qGfn
 8ygnFFQXwIKA5EUZAyGNYfSdoK/eA1vzOvAlob8dJ6lnMhK0SRNlS7Nbt0duMasrvR18
 Cjk/y7OKeeizk68zjsx7p9vq/rqY9sNg/h4Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702576296; x=1703181096;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JmAunETMfAMvtmIMueXKgBAz3jvlLc189MEAOOM68Ow=;
 b=I00iCaNYpeahqm5vs+RpoxpkmGnj+z67dVX1qC63GVRl60M41yHbEicO78SprNfY6r
 Hdd/GdvzCx5INfjK9r0mmuvAlH5E3eM0qMz4s7R6pC4cCnz6O21KuMbOePkU5EISYWuj
 zINTozC2ym+DGadRwvJ+ib6S5gYRbgETTM8l6R9mSdwC3J3HpFq+CWZTQsjir1MnrsEF
 YOGTqN2ehPwSKRnese6NgHa8u/q47IHK3xivkgcIif9LyJBFYEzAViSwo2gW3IafAqsV
 vqMdt+4URSzB4rrzu49qYq38B3VieO5ToDo8A4gvxGlYw/N1XeHb8vfJMUDOljPb7Aa0
 Oe0w==
X-Gm-Message-State: AOJu0YwJkAi9jpZ/N+AH5s42yBWx4IOgw/bCDprCBP/0rJ+yXyw/8tU7
 OlpZPtCk+BcA08OgxjdjAUcUCJ8S+v13OgvkjyQ=
X-Google-Smtp-Source: AGHT+IEcUSJszryecEuovOFeecTVa+FbEhbcybNVRmmM98bRj7tkfVw3qzR8vC01PKhLip3rmvMAwQ==
X-Received: by 2002:a0d:d489:0:b0:5e3:e273:a50e with SMTP id
 w131-20020a0dd489000000b005e3e273a50emr741874ywd.94.1702576295857; 
 Thu, 14 Dec 2023 09:51:35 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 n186-20020a0dfdc3000000b005d37b4b7cb6sm5642371ywf.77.2023.12.14.09.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 09:51:35 -0800 (PST)
Date: Thu, 14 Dec 2023 12:51:33 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v2 10/21] bootm: Add more fields to bootm_info
Message-ID: <20231214175133.GI2513409@bill-the-cat>
References: <20231214165112.2182274-1-sjg@chromium.org>
 <20231214165112.2182274-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4xwMf/jOewGgEQwF"
Content-Disposition: inline
In-Reply-To: <20231214165112.2182274-6-sjg@chromium.org>
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


--4xwMf/jOewGgEQwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 09:50:19AM -0700, Simon Glass wrote:

> Add fields for the three bootm parameters and other things needed for
> booting. Also add a helper to set up the struct correctly.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
> diff --git a/include/bootm.h b/include/bootm.h
> index 85c560d5a0ae..c9ab55f18d39 100644
> --- a/include/bootm.h
> +++ b/include/bootm.h
> @@ -19,17 +19,52 @@ struct cmd_tbl;
>  /**
>   * struct bootm_info() - information used when processing images to boot
>   *
> + * These mirror the first three arguments of the bootm command. They are
> + * designed to handle any type of image, but typically it is a FIT.
> + *
> + * @addr_fit: Address of image to bootm, as passed to

Maybe we should just call this addr_img ? I was fine with this at first,
and then started reviewing 14+ and it just reads oddly at that point.
Since we use this for starting everything in memory I think we should
name this a bit more generically, and avoid the editorializing about
being typically FIT as well.

--=20
Tom

--4xwMf/jOewGgEQwF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV7QKUACgkQFHw5/5Y0
tyzD6gwAhgpE2n53QUKQXRf3gRZV+t/j0f3vJvLydRw3y/x3/ZIGJM213I72rDrB
VzILpJKHyf/1AG1PPP3nLbeOKgNIkU39Ps4vMOvdTIO41PuU/1NKHJkCpyQUv6Qv
ryFv6XqIGraKX06cNi8xhgqIg5aB0ClqfjmmJRRomjNVaCPPA9v6n/+kiuAvXFpW
LLIARbYq1v/0FwPHWWga2yY1wDA1fYuC4YDe4VTg9NROlFbxTbx9ud6iJwfiB5lP
X60kW9YqZvImuP2+qVmTPB7vbAS9Z/1LXxrvYanbCw6aNHRdg6tD9hG9ePJ/nqyz
meCY1Sn7uH7iQPji70YYU5imQWaMkWzdbECbn/XJyQJKMkuo4izqs3gdxB6fHjL7
l+CnA33AmlZhls7SNgaoTsKJHmKvbusfsvkUPw+cElvH1/UYIGIJWpbHYC5MyX+e
zti19YhZ4vcLd4AliblATlxM/EYVMLkkaCmylbzWV7BepuD/bl2fRzJjsEoL5AfO
E4bdqj4L
=XUMd
-----END PGP SIGNATURE-----

--4xwMf/jOewGgEQwF--
