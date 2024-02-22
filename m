Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD67C54791
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 17:46:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BB3E88087;
	Thu, 22 Feb 2024 18:46:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YokobKki";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B309387E64; Thu, 22 Feb 2024 18:46:44 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8E5A88087
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 18:46:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-607d9c4fa90so84776107b3.2
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 09:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708624000; x=1709228800; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ut7LU7fONQunQpIWrxdtxNiek2O2koju6VGzSJxElQs=;
 b=YokobKkizpTKe8nHY8fxiUPxsfvrIGyv8+Gu7jDDBGdSHNGis87yXRjd+SS86esZQc
 iDi7Ah/OC35AYWOsEx1WbT8hqgRYvjo7OFRGDGlhnJzmnesYiQisqh+CCzC8GZi3PROd
 hbCN92x+jhdv4JEI/NuBuZNxhOTYo1M0TYXn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708624000; x=1709228800;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ut7LU7fONQunQpIWrxdtxNiek2O2koju6VGzSJxElQs=;
 b=U3Oo3qPf+V+2zJiDYtUux0tjkewXWRk4Am5qVMxBZ0QMwfB+SXGjUh+8aGarrGhhWI
 AaJOQbbPGB7Kxnua4a08XgY1+ZJV80RD/KIOoTvIb9ehyW3eGUdiK6EGPXkleCEYhYj2
 tu6GIufQdwb2wV3qU8M+k184cxEaajt3v6EA9NVOy2Mr3/UoP+iRY+qWqtxDKZhdnG/4
 A86SuuvHR6kiNMWnF76kuK6mRcR/4uHBdojz3C4AybjgnOkdHgD+uPMuAFYArw9luzA/
 z0UVTJLdM/xIurzAWPQ2ok67FgsrMRsW916+4Mt6Wkdo07H2OgSr1DO3n6ekfIekpOCX
 Y5Uw==
X-Gm-Message-State: AOJu0YwWu5Ms+/kLdeJJcXxPBqnRteMbm6YaoODoXNl/f8WRgvJYMzP2
 LYkn4StUw0Y8F1ygEIweFTp6VL//bk5HprzjQrR0QTDYczWoKQUnmbKhns/OQBmiqdXoOHp3PFi
 Y
X-Google-Smtp-Source: AGHT+IGRQMjStUV8p7AfOSQKzTtWVu5xb1Rc4tieOE8fMYBaJce6xmvK+NLuy/Dxqk8OKcfjCEeGNA==
X-Received: by 2002:a81:ac1c:0:b0:607:f09d:b2af with SMTP id
 k28-20020a81ac1c000000b00607f09db2afmr17406711ywh.1.1708624000411; 
 Thu, 22 Feb 2024 09:46:40 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 p184-20020a0dcdc1000000b005fff0d150adsm3181123ywd.122.2024.02.22.09.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 09:46:39 -0800 (PST)
Date: Thu, 22 Feb 2024 12:46:38 -0500
From: Tom Rini <trini@konsulko.com>
To: Ivan Orlov <ivan.orlov@codethink.co.uk>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: eeprom: Fix config dependency
Message-ID: <20240222174638.GA2599242@bill-the-cat>
References: <20240219181838.85391-1-ivan.orlov@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wZXU+O5ODTV6Z25P"
Content-Disposition: inline
In-Reply-To: <20240219181838.85391-1-ivan.orlov@codethink.co.uk>
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


--wZXU+O5ODTV6Z25P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 06:18:38PM +0000, Ivan Orlov wrote:

> We should have CONFIG_DM_I2C or CONFIG_(SPL_)SYS_I2C_LEGACY enabled in
> order for `cmd/eeprom.c` to compile as it depends on the i2c functions
> which are not compiled otherwise. Update the Kconfig entry for the
> 'eeprom' command correspondingly.
>=20
> Signed-off-by: Ivan Orlov <ivan.orlov@codethink.co.uk>
> ---
>  cmd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index a86b570517..6a1a64566c 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -740,6 +740,7 @@ config CRC32_VERIFY
> =20
>  config CMD_EEPROM
>  	bool "eeprom - EEPROM subsystem"
> +	depends on DM_I2C || SYS_I2C_LEGACY || SPL_SYS_I2C_LEGACY

You cannot enable commands in SPL, so SPL_SYS_I2C_LEGACY doesn't make
sense here.

--=20
Tom

--wZXU+O5ODTV6Z25P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXXiHcACgkQFHw5/5Y0
tyyqzwv/e1LEBOgzkcJ3BBza4RfjHXHmTrlKM3uyZsCMIUFlMrHFnhkOkILJCZrw
+33ZAubde/yqY6+75a2InKDXHBs2XYtshYgl/9XdLjmpp2tlrKHc99oujvc7OQKI
EnNzwq8K9eJbOK1gP8GeUb4kAlL8KqS/+wY0bbvrDuN30KM99svxfdrILub2H6v1
ie2Ubq9m9bLUjn43qUaYo9Y78HrGoxHd8XzeUH+CH9kl0jBDCMsQvHz0YbRqualZ
ZdoLW9M362BMY/lm/5oJu2xNEmLs4xmPMaonzT9L0sEUzf2IHUBeVX893WeHsGH0
68DpGLZsYDONzyyflIXVa3WmQsq233Uj8cltb+XJASzkXYWHlvnrdOQxvIhenQnZ
LNa0cEd2L+VZ0ituiLz7CqnVo7X+MxbIGw/4NE0zzavW5AoALSBD51leLzsGMcoV
JUGRgIKeBXa7R3jY1mavMOAE/2O27pZGBeTMO4pMU5H94rz30EVNnU/WVMF0YMtw
jo7g9VtE
=6t/L
-----END PGP SIGNATURE-----

--wZXU+O5ODTV6Z25P--
