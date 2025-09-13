Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D47CAC587
	for <u-boot@archiver.kernel.org>; Sat, 13 Sep 2025 15:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A63382FC7;
	Sat, 13 Sep 2025 17:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YEUyMMxW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F359F83043; Sat, 13 Sep 2025 17:51:06 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFAB382AE1
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 17:51:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-423fc1532bdso3918675ab.1
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 08:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757778663; x=1758383463; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CI4rGP583IiO2r9ZtJzDJj+2IzyEHheklXjgvyxtgV0=;
 b=YEUyMMxW74iJLCiFXcfhFWF5gR/MtTIG++vLXvkF3E4zX1TWNrW8pB4Pnxaaw/47sQ
 fU4oCocPa37eF5qh82m5jjZtyg0Sp2Pxy/dv/5FxQn+nGdgPcdXuNLLQsk6NtS3en4/y
 yWwmpktkB17O0i99IIqj+7VAc0d74L2OBi2sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757778663; x=1758383463;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CI4rGP583IiO2r9ZtJzDJj+2IzyEHheklXjgvyxtgV0=;
 b=Jgl2irxSrasdDxBLkte9GIP7BlqZbXBpjv7x40Xn4vGZOOA80xMrW1CZztZEfwNAnI
 1zhY9CWKv2xI1WHxt390aUpQT8tU+1pUNVk+FEQZIAopmo0gvqpSDMH8O2kxxDMvnkpU
 8+zb0OjC+k62ERVxRyHT9oPAU2AGcZieds6aRPLbinXDWWG4e+XUfDekjHW6eh+701ne
 X1kBADSObZ25mWt507Uk9q/qVmdva8XYCr8t39RzY6T+APtcqzapAeGsNwvwK1IjmD7t
 9nqj3Jsaf2YhYl0MfoXC50o9zY3y30cA0oRuaFOW9hJMNZWhiUh6IY8nHhkoPE5PwoUZ
 13oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuYxHSIMdreEM6grE+PT63PkUjDiqmiEAWaBE4iLADcMRIMClIyFyK0ZcGz7Zb1sagvbYYPQw=@lists.denx.de
X-Gm-Message-State: AOJu0YxQJiWnn0vP1JqL9zcfzxOHvhDBbu2k0OAam5DVcTlFMWjAuccD
 whuM310IcJ8wC+SJzaUWLLJyUcrVMjUzJ8h2371pUwT9abTBYTXyPnHnCkb7fCdwrP0=
X-Gm-Gg: ASbGncvGjVy+rdRvEjTmNTHezoGcOXKfWu8qsW4NRz65xrneCFY40ACuQT8uLbukHZ6
 4Rn8qTLlPpv9QhwiaAdDae3KPqE0nrlCOrkCyCjNewTAAaq5S4GDQJ/n7pXWREQD9sDBbwaDBHV
 Lr3rBJbpDZN947AbB0BarUkQh+/Auy/ys/MN6cF0DP5Oc5DTPtFHCYw+Zm8fNCN0G8Ts0eEyzVI
 yZZGgZ4QwRI+OZRfLJz0Du/hss1YnPc+j6fXvszjscBF8bMaGEtATt+beVG9cdg0ty0/7LLk8iO
 onu83wR9ya+2hsu+vOEOkdCa/JC1pjrR/YVR9anfOk6IRyBrZbdYLweQXBc5Nt6zccXgWT0eyez
 Lx4xgI5KtkYfQumb3pvrMVjFHdjK4RlI7ls/JGzMeB3gLRtRJduRY6JYsqju38OUx//Q=
X-Google-Smtp-Source: AGHT+IF5XAI7vVNFJhqCF995C+BzWEJw9qawQbrSYrcAlpl/O7CBN9940QP5Fl/LqnbQckQehEUzuA==
X-Received: by 2002:a05:6e02:1988:b0:3f3:86f:520c with SMTP id
 e9e14a558f8ab-4209d7e0f28mr83218675ab.7.1757778663380; 
 Sat, 13 Sep 2025 08:51:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-41df8eb44besm34094855ab.22.2025.09.13.08.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 08:51:02 -0700 (PDT)
Date: Sat, 13 Sep 2025 09:51:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
Subject: Re: [PATCH RFC 4/9] serial: serial_meson: add minimal non-DM driver
Message-ID: <20250913155100.GA67696@bill-the-cat>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-4-37395d9ff5af@postmarketos.org>
 <829fe59a-10e5-4cd2-a032-d293d87f68d1@gmx.de>
 <DCPE9A29ADNG.5XDSJ73VEPCS@postmarketos.org>
 <3875c210-7d29-4bca-b535-0522dc615cc8@canonical.com>
 <DCQ2ZF3T8VMM.1JN4QJ324NFM2@postmarketos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Aky8MjDGurDYPGYM"
Content-Disposition: inline
In-Reply-To: <DCQ2ZF3T8VMM.1JN4QJ324NFM2@postmarketos.org>
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


--Aky8MjDGurDYPGYM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 03:37:07PM +0000, Ferass El Hafidi wrote:
> On Wed Sep 10, 2025 at 8:30 PM UTC, Heinrich Schuchardt wrote:
> > On 9/10/25 22:14, Ferass El Hafidi wrote:
> >> On Wed Sep 10, 2025 at 7:53 PM UTC, Heinrich Schuchardt wrote:
> >>> <...>
> >>>> +static int meson_serial_getc(void)
> >>>> +{
> >>>> +	struct meson_uart *const uart =3D (struct meson_uart *)CONFIG_VAL(=
DEBUG_UART_BASE);
> >>>> +	uint32_t status =3D readl(&uart->status);
> >>>> +
> >>>> +	if (status & AML_UART_RX_EMPTY)
> >>>> +		return -EAGAIN;
> >>>> +
> >>>> +	if (status & AML_UART_ERR) {
> >>>> +		u32 val =3D readl(&uart->control);
> >>>> +
> >>>> +		/* Clear error */
> >>>> +		val |=3D AML_UART_CLR_ERR;
> >>>> +		writel(val, &uart->control);
> >>>> +		val &=3D ~AML_UART_CLR_ERR;
> >>>> +		writel(val, &uart->control);
> >>>> +
> >>>> +		/* Remove spurious byte from fifo */
> >>>> +		readl(&uart->rfifo);
> >>>> +		return -EIO;
> >>>> +	}
> >>>> +
> >>>> +	return readl(&uart->rfifo) & 0xff;
> >>>> +}
> >>>> +
> >>>> +static int meson_serial_tstc(void)
> >>>> +{
> >>>> +	struct meson_uart *const uart =3D (struct meson_uart *)CONFIG_VAL(=
DEBUG_UART_BASE);
> >>>
> >>> CONFIG_SPL_DEBUG_UART_BASE only exists for CONFIG_DEBUG_UART=3Dy and
> >>> CONFIG_SPL=3Dy. Shall all configurations depend on CONFIG_DEBUG_UART=
=3Dy?
> >>>
> >>> Creating this dependency does not look right to me.
> >>>
> >>=20
> >> All Amlogic defconfigs have CONFIG_DEBUG_UART enabled, but I can remove
> >> the dependency on CONFIG_DEBUG_UART_BASE if you think it doesn't look
> >> right.
> >
> > We should avoid the possibility of build failures for changed configura=
tion.
> >
> > Will CONFIG_MESON_SERIAL depend on CONFIG_DEBUG_UART
> > or will CONFIG_ARCH_MESON select CONFIG_DEBUG_UART?
>=20
> Then it might be best to not use DEBUG_UART_BASE.  I'll fix that for
> next revision.  Thanks!

The way we normally solve these kind of things, since they aren't
actually configurable (it's part of the chip itself) is just #define
them either in the driver header or some <asm/arch/..> header file.

--=20
Tom

--Aky8MjDGurDYPGYM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMWS3wAKCRAr4qD1Cr/k
CgNrAQDj42u/PHcPNZLcy06QtK9FlPCAUMvnmqOfHKnSuO3PbgEAx/yEqpzyEsS6
JnN8n6jWOLulzrySYh3UW7yS3dtoBww=
=fpui
-----END PGP SIGNATURE-----

--Aky8MjDGurDYPGYM--
