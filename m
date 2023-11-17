Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7AFC072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 14:00:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46CF9874B9;
	Fri, 17 Nov 2023 15:00:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B0qUqrW4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30BEE8750E; Fri, 17 Nov 2023 14:42:28 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B55C874F6
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:42:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-677a0ac3797so10883416d6.1
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700228542; x=1700833342; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CwpSEwEOllI6LcYna/uH5XoLf8aB0NQ1HjeNtDeZ/+s=;
 b=B0qUqrW4HHXlSImE7ofI+nAM0Z0NxbCbBrCEdhbgN8DJXcs6rXaiiSMDTyHaV1AElr
 E6dM9Zj3TKeJA///RfwUUS9eyOZaHAvAoo6RvJlfCXZhqQjdnL3sGIepWcAaFQEGDEYZ
 taztvYzOMrRFVu26ntnP0WB09HJucjw4K4KXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700228542; x=1700833342;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CwpSEwEOllI6LcYna/uH5XoLf8aB0NQ1HjeNtDeZ/+s=;
 b=Xyx68U40VjOuR5E96OOez6me6PScJMBQu4q8yyoHGAYFg2uOjSxorxKzKHTPpY0+n6
 VIPwWb2uoZDWqcHeKE5FHiY3PlAA3xT6Neyyat5SguzEfrX/8xAtvjHtAuUKqfm72QMY
 VtphJ4rIR3PXvRsy4DZHZ7W30KpPKli8ky/EL6U0YUgXcULL8q/xTpiSJJTnM5ZM3wPs
 jXYTCVGdknuZbbTc4aD2A5hXxPk8TaB5Je0OOWTVXlqYi5MiAc57RFwT982rIGpbwuqC
 g3bEFyjnwKhuvAAfeHaTH9+HqHTCXSZXW+3cC71lw7t4+P1tgbOL5Rn8e7NdNUAg/4wx
 3lzw==
X-Gm-Message-State: AOJu0YzqZ32PTz7/iqInDH3k/j6KZ3HS51bG6Jsk+FgRTS6J13AQPD+6
 jt3GHK8g7wTEYJSvtx0VhiZmzw==
X-Google-Smtp-Source: AGHT+IG8bs097idczyBjCQcx/JPWWKqKMp2vgvsDKMWNFO0nsL7TxnHfcJXLkkJDFppCHML52hvGjQ==
X-Received: by 2002:ad4:5ced:0:b0:66d:1ffe:bcd4 with SMTP id
 iv13-20020ad45ced000000b0066d1ffebcd4mr15239232qvb.44.1700228541027; 
 Fri, 17 Nov 2023 05:42:21 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a0cee68000000b0065afbb39b2dsm636295qvs.47.2023.11.17.05.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:42:20 -0800 (PST)
Date: Fri, 17 Nov 2023 08:42:17 -0500
From: Tom Rini <trini@konsulko.com>
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: u-boot@lists.denx.de, kernel@sberdevices.ru, prusovigor@gmail.com,
 Alexander Dahl <ada@thorsis.com>, Anatolij Gustschin <agust@denx.de>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Balaji Prakash J <bjagadee@codeaurora.org>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Baruch Siach <baruch@tkos.co.il>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Heiko Schocher <hs@denx.de>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Joel Stanley <joel@jms.id.au>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Bosch <stefan_b@posteo.net>, Stefan Roese <sr@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Weijie Gao <weijie.gao@mediatek.com>, u-boot-amlogic@groups.io,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 3/3] treewide: use linux/time.h for time conversion defines
Message-ID: <20231117134217.GW170968@bill-the-cat>
References: <20231109171004.193521-1-ivprusov@salutedevices.com>
 <20231109171004.193521-2-ivprusov@salutedevices.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8Gqn10LtVtC4MbKp"
Content-Disposition: inline
In-Reply-To: <20231109171004.193521-2-ivprusov@salutedevices.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Fri, 17 Nov 2023 15:00:01 +0100
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


--8Gqn10LtVtC4MbKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2023 at 08:10:04PM +0300, Igor Prusov wrote:

> Now that we have time conversion defines from in time.h there is no need
> for each driver to define their own version.
>=20
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com> # tegra
> Reviewed-by: Eugen Hristev <eugen.hristev@collabora.com> #at91
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org> #qcom geni
> Reviewed-by: Stefan Bosch <stefan_b@posteo.net> #nanopi2
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Applied to u-boot/next, thanks!

--=20
Tom

--8Gqn10LtVtC4MbKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXbbkACgkQFHw5/5Y0
tyzjMQwAs4rUe7sR2Krrdo8v0Y+HdHSbxhMrLe/+H98rOzQKwJgzI5zqQJ4lVqmQ
gxf3X+4TOHshwxet0N94fLbTFIZ8ly1cWHDU6O6H+rb+SzZVtL+s+YhCkIA9u4qO
BYCzr2CjevSy17JFYSA1yrv/MSU7FiX1bW2U/PHczFtSIyzJ7ZDZDKr0GsEw5gyr
2WX/CD/fnBAERbQi9VFeAe0ZkvhM3LkwhdaAaaR1h2TRmWdFpXtkhIxqJ8cHgjp0
ejfzMtigPROA7Ca3wyJAijLU0MvIJ/iJVQz4Auig+1PvEFaYhwxqgh9dT3fgDUOe
Ck/AnfXJBjuf6drrvE9eRFmOzvxZMsPHDR7QzpeSjcoIW4nOjNuMNjTfP3IDim93
wi3UiSTj6u5TDC9hg/gVlK1/RAm0AkS86I7cqx+GNwbyMqMFQYkWiJPRxUMMoBo5
MyJHyiyc2d+K6rzEUsCgpHCTiVxPIKnKrIdrgzvhXic3XOHGMMTPiBJWZTxOVk9J
fuaNI41E
=adIm
-----END PGP SIGNATURE-----

--8Gqn10LtVtC4MbKp--
