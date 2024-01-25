Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC99C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 16:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 202DF87BDC;
	Thu, 25 Jan 2024 17:14:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZxMTuoVA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A75F87BCB; Thu, 25 Jan 2024 17:14:50 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 464F587C08
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 17:14:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5ebca94cf74so68000127b3.0
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 08:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706199286; x=1706804086; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xEJ9KYA+vQtgAGhHVjiW8lWboE4jHkh4LJ8KcrWFaBU=;
 b=ZxMTuoVAwh6h/qDdx+scH7pgCqtlkvYXkcvmo8k8MoTGfmkSwcnLTnLKvpdXx7EMBE
 FwP1sr0Kml5uC0y5IocKaARjU6Y6TY6beRf10zcmkzkf2ZMbJduIKGPdxCMk1bbuYtlJ
 6uHHH5KUuV1DaCSV7zAVpr8uMTqklfcpFq0J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706199286; x=1706804086;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xEJ9KYA+vQtgAGhHVjiW8lWboE4jHkh4LJ8KcrWFaBU=;
 b=hgx/W18SKY5IJv/vKndU9/OthrEBd/H1XL+WmyRAXNgVaGnXStNTTzONCNfnRkKDQ6
 7fCAMiotkwWKLRFgAhvkjrCR9KoSZOkwNLKSBmHRLwhmwd6WLbCTiUvawndwVGDeoB65
 rb+9R/7VHhzU7bZldyZ2SgqLljgInx9O8qXOhZjPcDeSf3qLQPAJK4K7P9ap76NwGY0H
 ssDep0PXxS1hiOAieHkJjJgcmnR6uw+s+Y4ZwOE/XlNYnD4m1s7FPfiz9xshjZAADTbx
 qfBzus9i+X01+NUsjutwNCpeeAFwQppYi1rt8yjPlMPTH3qWtRXRKOokv1toKuGzr9nO
 ctFQ==
X-Gm-Message-State: AOJu0YzTALwmkcsSV/Mx+KkbJyC01eVEKbPTKkd/Z2Upck/n9x2K9rsJ
 FO4+hJQ2SKY3N9caBgliWzf6RsaxqVlm4TxdNHf4CAts55IXWsG/vuzYe3L+l0rsuUyW+BZ3yTj
 c
X-Google-Smtp-Source: AGHT+IEZCALIGKFSfR+YJ67oflusiEaI3kLRsCWKXAuuQNpg55UlEXSbSBSagUaMwuGgtsu9YsK2Wg==
X-Received: by 2002:a81:9b17:0:b0:5e8:61ec:4d7f with SMTP id
 s23-20020a819b17000000b005e861ec4d7fmr35213ywg.38.1706199286000; 
 Thu, 25 Jan 2024 08:14:46 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 bg10-20020a05690c030a00b005e703079702sm737046ywb.87.2024.01.25.08.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 08:14:45 -0800 (PST)
Date: Thu, 25 Jan 2024 11:14:43 -0500
From: Tom Rini <trini@konsulko.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v2] common: console: Fix print complete stdio device list
Message-ID: <20240125161443.GT3652023@bill-the-cat>
References: <20240117123714.50380-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lDoYZQjGBiCxMcjv"
Content-Disposition: inline
In-Reply-To: <20240117123714.50380-1-patrice.chotard@foss.st.com>
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


--lDoYZQjGBiCxMcjv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 01:37:13PM +0100, Patrice Chotard wrote:

> In case CONSOLE_MUX and SYS_CONSOLE_IS_IN_ENV are on and
> stdin or stdout or stderr are missing in environment, as fallback, get
> these either from stdio_devices[std] or stdio_devices[std]->name.
>=20
> Fixes: 6b343ab38d ("console: Print out complete stdio device list")
>=20
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/master, thanks!

--=20
Tom

--lDoYZQjGBiCxMcjv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWyiPMACgkQFHw5/5Y0
tyxbHQwAsXS+tNUymfVqnuB3gPO5CfvWRKPjdpAPdibWLyD4E4T6G5JSlKVzoOsq
p8jqa5WEw3BJjtm956fRH+ghpNvX5pIZGv7THO78QVjMvtCwt55/XEdYNHOR3L3m
IMjj3/RBKftq9agl9X2wMFFXtr1p63DYy8bPdxWZ7UWJpXmesFz7DkAKL2Jl/xNb
KWHgA0Ar7XavMkFU1THqe2wdzFco40Oz0M9jbgY2VFFMZc7f2MvATffPj4SooL2I
WRoubSvCDIhhPiBv9CQAxJYE+O0YnZmyFk5nKY95v4w7ebGxATVlvywlInrcN1w4
YDe58P+GjrdpSLgVTil17siSRWyKTMD6Kznxqx0pJWqo9KCQDNKZ8N16iVaEJYhH
l0gLDi5TO727+SQHH5F7p3wvbw5oCU3m/DEmsqN7CTvGaeU8d4dQWbW1Ba8D5B3h
7eW0E9Po73ES9NZnLd5EvM8qkKyJQOjkonGDI4i9PaTwwDysf4u7nN/wJd1AwGHe
i8FUGxlr
=YKtV
-----END PGP SIGNATURE-----

--lDoYZQjGBiCxMcjv--
