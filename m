Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08554CE7A91
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 23:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D919F86C5D;
	Mon, 25 Sep 2023 01:27:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lOeFmEvd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C724186C2C; Mon, 25 Sep 2023 01:27:05 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9E1D86A63
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 01:27:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-59e88a28b98so79379907b3.1
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 16:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695598022; x=1696202822; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TknaoYgouHCQEv+KfujJYjrCF5n7UUeHwfKd1f+mMW0=;
 b=lOeFmEvdRAD3AQTByxeJf/mhp0+gzs9XLPCMVD1IvSmEsMVOOmaE4VImpSJLyYGkwz
 1IQKABotDFCz5+U/Bl0w80K4kxskEY1nCue1AWrWEAqZ4OdYqi6+U3KyUsIVJVqSxnh3
 6SkgqO0j9u5XTyO8daKzZ5Fha6uYuPZiKZVKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695598022; x=1696202822;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TknaoYgouHCQEv+KfujJYjrCF5n7UUeHwfKd1f+mMW0=;
 b=QN6xNABUy7f+gQp0x35kh8rKNqv9aIcnYHNUB3d/skXNyaMTkESdLQN54uyB3K/REq
 jZ18LATI8SyidlHjmSx4WnROcU8LQKIWJ2G0/eR5XkxUoUb/xjHhxsYljCRXcB4JQSEc
 LU+v5te3lGe1gTyT5FWMXn7vgv8M7saCvkLkZAddSQE/OwxdE0r/9FijZSzHTWywBa0z
 tAHs+JkhQ2EUt4BrdAknFqbb6sj8bo3aEOW9ioR4yIlFoedfKG8wBKpaBlkqBZWNug6c
 +CavGNOt086XXLwB0e/FavCn5oloqsm2ACMCO+dcB0Joo9Juf48GnWA959myjMwobzfA
 WeAA==
X-Gm-Message-State: AOJu0YwKAl2UDGZ9rfGaPZp9c0RZ8P25qxeiyAtog1tGbsdS6Vt/26H5
 qTo5LiAR6VgTBK6vOPnSKYs04T6umpJwenMb+ho1/A==
X-Google-Smtp-Source: AGHT+IFxHqLn3G502xdW+feoG0rVmBXV4QJdKO8QUltIhqSS3nxV4EtG0VDY50rVaw3xlMiHiX+1Ug==
X-Received: by 2002:a0d:df86:0:b0:589:f9c3:8b2e with SMTP id
 i128-20020a0ddf86000000b00589f9c38b2emr3381679ywe.20.1695598022501; 
 Sun, 24 Sep 2023 16:27:02 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 n185-20020a8172c2000000b0059c01bcc363sm2121992ywc.49.2023.09.24.16.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 16:27:00 -0700 (PDT)
Date: Sun, 24 Sep 2023 19:26:58 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Fabio Estevam <festevam@gmail.com>, Leo <ycliang@andestech.com>,
 Michael Walle <michael@walle.cc>, Michal Suchanek <msuchanek@suse.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Rick Chen <rick@andestech.com>,
 Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 05/25] treewide: Correct use of long help
Message-ID: <20230924232658.GM305624@bill-the-cat>
References: <20230924203953.1829820-1-sjg@chromium.org>
 <20230924203953.1829820-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fi7JdFpR8IKyXWTs"
Content-Disposition: inline
In-Reply-To: <20230924203953.1829820-6-sjg@chromium.org>
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


--fi7JdFpR8IKyXWTs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 02:39:23PM -0600, Simon Glass wrote:
> Some commands assume that CONFIG_SYS_LONGHELP is always defined.
> Declaration of long help should be bracketed by an #ifdef to avoid an
> 'unused variable' warning.
>=20
> Fix this treewide.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]
> diff --git a/arch/arm/mach-imx/cmd_dek.c b/arch/arm/mach-imx/cmd_dek.c
> index 6fa5b41fcd38..25ea7d3b37da 100644
> --- a/arch/arm/mach-imx/cmd_dek.c
> +++ b/arch/arm/mach-imx/cmd_dek.c
> @@ -393,11 +393,12 @@ static int do_dek_blob(struct cmd_tbl *cmdtp, int f=
lag, int argc,
>  	return blob_encap_dek(src_addr, dst_addr, len);
>  }
> =20
> -/***************************************************/
> +#if IS_ENABLED(CONFIG_SYS_LONGHELP)
>  static char dek_blob_help_text[] =3D
>  	"src dst len            - Encapsulate and create blob of data\n"
>  	"                         $len bits long at address $src and\n"
>  	"                         store the result at address $dst.\n";
> +#endif
> =20
>  U_BOOT_CMD(
>  	dek_blob, 4, 1, do_dek_blob,

This really doesn't read nicely.  I would rather (globally and fix
existing users) __maybe_unused this instead.  I think there's just one
example today that isn't "foo_help_text".

--=20
Tom

--fi7JdFpR8IKyXWTs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUQxboACgkQFHw5/5Y0
tywk7QwAshUBGIrDpRCBKN6vKDzJ1EzZkEZlJS1B702ViUn8nq8bTW9BZUaC6h1Y
zRXHi4IRRy0zPpUW1lO/3oonc+yyBV32spYIRv685JgRrgMn07cNC+C8qw2+OJtl
XXaBFsfbBOQ0CbEgonFNcMi/CbuoZMq7CTok0HtYpqUTpoe/tCJwVaXwlFZQ8IqZ
sG/Eum+HpF3XMrkTaqtSIE+c94aLiIe4+r/8BUXQukgkO65HCiZtw1zWOIGs97Vl
eTh0Y7pVePMMEQGu1ibO6mC0t1P9winiGYpx0AAysrKN9RnnDf/LuJ5yjKGWFVpj
3dk/OxpmR2RluZ9UNj70Y30JUqOTL3NUgP6QZ6pmW7HAiAlrd4q5oaTq96fBf6vY
10bgEMoxOtRPpLaHwK/RrAJrbwgyArmu3w/strZ77CtDmHSLCfoJA9fOHoP9rzC4
ZMj9gGzGkmwJ0ExvBcpdKph3VEY2a1qk/203XifwnUl809/OerroSc0coa4xYC+y
l7hQ+me4
=sRIo
-----END PGP SIGNATURE-----

--fi7JdFpR8IKyXWTs--
