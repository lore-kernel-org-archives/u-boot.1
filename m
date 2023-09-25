Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B5DCE7A91
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 00:54:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1721A86C04;
	Mon, 25 Sep 2023 02:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dNB+POCX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2813A86B9B; Mon, 25 Sep 2023 02:37:41 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F47F86C0D
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 02:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-59be6bcf408so62919557b3.2
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 17:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695602256; x=1696207056; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1DyHRlZC1e+ykEDW1kW/LABAXczw/9dcVSGFsScICWs=;
 b=dNB+POCXQmdYhOwpDnIMy5b3rMf+RxiG3CX/q1fogmSEPRIbLFBamRv2YPRDPWJNRN
 rhsrFBw6NV2zN8saLUk6963O3SxbqRxjB209vfdN/3WCo9yPYP1A1aUBZ0PnjnTuxKa9
 MJufrdsIxjzZ2pHUXKaBFlBMs7mj6v1uT30r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695602256; x=1696207056;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1DyHRlZC1e+ykEDW1kW/LABAXczw/9dcVSGFsScICWs=;
 b=FjWvQIwAhXeEzOlJlIWudDe787HAWCqgb1biZjP0SqrIC2BZ4XJVBgB3zRcM+reeun
 WJFU86wO/A4VgZKL5DoS1/GkczsTC+1bgGa/1tRLQPHlz9dOpcfqJSR+p9C15YpagPK4
 wPQMLTiRg8Qgx+SI1PCUfIKz4AtEiAo72NPGZiYAanjU8cN+hpy+SIwrre309U8vMsEC
 OBP3PqzJDJzRMekfOY3Gcjzs1O9Cg+qViS481w5ZnfoAmPMO2LgDSad8rxi2b+2Mw20X
 nah6+EYgdfHL8LjqMoravyIyK/No1CoHOctYgbwlCgoMNZKgrqs+owYQvvaJDC4HJ1RO
 XBqw==
X-Gm-Message-State: AOJu0YzpK+eDEEJ9DYLDxfH530/cTQOYPM1OrXwIM/gUAgQLFi+QdB9J
 aipxoz5hK6mgomU+LzqfjENfXg==
X-Google-Smtp-Source: AGHT+IFe7oacKqC3/WPkOIwveN623MYJa9QXe/pdK4nfx7S93JIJAL1JLA++vfeyL8gAhAnRRP/6xw==
X-Received: by 2002:a81:5709:0:b0:59f:72b3:e590 with SMTP id
 l9-20020a815709000000b0059f72b3e590mr1541154ywb.45.1695602255752; 
 Sun, 24 Sep 2023 17:37:35 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d32b-b307-decd-cdc4.res6.spectrum.com.
 [2603:6081:7b00:6400:d32b:b307:decd:cdc4])
 by smtp.gmail.com with ESMTPSA id
 i2-20020a0df802000000b00582b239674esm2146890ywf.129.2023.09.24.17.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 17:37:35 -0700 (PDT)
Date: Sun, 24 Sep 2023 20:37:32 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Fabio Estevam <festevam@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Harald Seiler <hws@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Suchanek <msuchanek@suse.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rick Chen <rick@andestech.com>, Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>, Stefano Babic <sbabic@denx.de>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Tobias Waldekranz <tobias@waldekranz.com>, Tom Warren <twarren@nvidia.com>,
 Troy Kisky <troykiskyboundary@gmail.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 00/25] Tidy up use of CONFIG_CMDLINE
Message-ID: <20230925003732.GN305624@bill-the-cat>
References: <20230924203953.1829820-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="at3BdeWA/ipiBw1y"
Content-Disposition: inline
In-Reply-To: <20230924203953.1829820-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Mon, 25 Sep 2023 02:53:48 +0200
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


--at3BdeWA/ipiBw1y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 24, 2023 at 02:39:18PM -0600, Simon Glass wrote:

> It should be possible to disable CONFIG_CMDLINE and have all commands
> and related functionality dropped from U-Boot. This is useful when
> trying to reduce the size of U-Boot.
>=20
> Recent changes have stopped this from working.
>=20
> This series repairs the feature for sandbox and adds a test to stop it
> breaking again.
>=20
> Note that quite a lot of functionality is lost of CONFIG_CMDLINE is
> disabled, e.g. networking and most booting options. Further work is
> needed to make the option more generally useful.

I worry there's a lot of "make it compile, deal with it later" in here
rather than unwinding so that $X works with CMDLINE disabled or we truly
must have CMDLINE.  Perhaps it would be better to start with to take one
of the platforms that enables say networking in SPL, where we
functionally don't have a cmdline, and make that build with CMDLINE off.
Having *PL build and link and work with CMDLINE disabled would possibly
save some space too, which is always a good thing there.

--=20
Tom

--at3BdeWA/ipiBw1y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUQ1kkACgkQFHw5/5Y0
tyy6xQv+OmIa3JulIeFO0EzpiRW8pWX8S/tufRGYnP8vb7li/Umzf8OsRESlRuLL
PobvrHDArshHmVu0DyQnCx2awpjUr/cPuMf2Gsf71f9qo4zvJx0guzzkUG37ArcS
7Pr1hPlGcG3MgYARIZKdwiWoKHdwIhmvxZTpctqyCIlZptPAT7r7tc3Z/OnAZ3BG
Rjj8pzFiABR6JZzq2h0VLpvOvcroifYhQLi6+S8E6++d10pzUHOC0hmwuXmMrQLq
u9AJr0I2voNIYG9UiTO2kYE/OL9dQklh+NGDzHzBCmXb1Ce9GMSGpiosgvO6ffDP
zpXm3D1aAl2c5Y1T3xetC7Kqbt1YUaQ0N0QTB8JhN8OCkf4gf7jAWyxq84gRYjQb
AnjnLpbdpZrfYlmjkBiqKVvwB/WuqTrYUqc0a4t6MsOWtyyE92lveyDTEkTwN0Vo
ZiSKlz9wnjUt446NwNS+wPRmYtz59JoBu2zOxZWjn/y71OpCiDPeps/phCjslUua
isu6yPOU
=mh/t
-----END PGP SIGNATURE-----

--at3BdeWA/ipiBw1y--
