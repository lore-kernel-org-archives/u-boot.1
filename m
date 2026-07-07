Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95395C44501
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 16:40:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A82E984AA8;
	Tue,  7 Jul 2026 18:38:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IXQKhACy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 550DC849D2; Tue,  7 Jul 2026 18:38:13 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AABD84AE3
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 18:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6a198cdc4e4so1489552eaf.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 09:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783442289; x=1784047089; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zKzhrTvyr6uL8HPK5Iw1nNyZsbwmt+HFObQEDCcHpRo=;
 b=IXQKhACyDGJu7BOkcygmOSS204Se1+KP9uruN0exNUXJ7Um+MNFIbkozQyQfK/bETU
 2bFQ6JKAKE+iOyYOrI5y2TGzD/70Pqps6PluoX2193jIQB/4uC2PrDxwwIhInvIk4IAH
 FxjsE+DeMqHlNZmu6mcKEwWA6RafiEmSEi9kQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783442289; x=1784047089;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zKzhrTvyr6uL8HPK5Iw1nNyZsbwmt+HFObQEDCcHpRo=;
 b=FOycSUiG2tN9JxgHds8iuYhVvZLf0/pXIIzrVQi2tlYUpKnUz3gwD1SfwudXiJRccl
 LtHc5gHmWjclbiut8KmCj/UmzAjgI002ooJVNJDrMXGYt+jJHG2h0Nlc1JsTf8CY1U5b
 2QoOV1QMhK2qC0rSWPIJAFJNyV0aeSuXr5p+UZftntbQQJKwfO0DYqt92X33z9abWQLz
 WHp6LIcf37TaKL4DSQv0wOtguxzcjmN6c3U/AuVNOOlMr98gmCSNkJhki6QoYOWR5IPS
 o9dCDOMns6WmdtYnIsG0PktXyOwXyRA0eofZ2nBHw7OmrnIfWWu6UEhGJZHJ6kzlbjn1
 8GJw==
X-Gm-Message-State: AOJu0Yyrl6O6l/dNrsHMULtWsvS50tjhaaOn8SGKPtJPIZ2/qVoApabX
 e4WrV6T4PWV40C83epLsCG3W2KyO+FtfLrnLheTS6fxpGd4B67OSSOx5MdqZrLnvdA4=
X-Gm-Gg: AfdE7clsgMLsIZ/IHzet2tnI+kgvHGl9KRf7wwLlDDORWFPaL1x1PoxoszmwZhu8Ner
 3tlJ8kL7UcE1U9uWsjhonaPlhRP8oxQGukgAgspB5QYKFOTtBgv72DzmcrueREw/OO5c/cNtd1z
 UFcF7rXkNvpAABHCMcjiN4BMU+flncLiwB381gVtebDP2hOWDeDgWod5NthlOGDeAc2AUacFjRO
 qYGBtUOKUCTwJ0Hr78hiVL2hws22JTeO437ihGAJ6jKtUyxHm+vYPzo5KdcSkWX3Kb63A4PLMkv
 Z6ae+61vu7CzfWwLAR1UR1/gdxBlIKwuGrY9ReIJ5SDZJim5Sb6vMcpnuYNRtRazoPV1/gWD3x0
 NUh3Ua0f6sUPyWGAOPFsbTW+uT4+i+NAOmB2f4ize/G5YuiVOxMU/k1fC8RC9q1OyJhIDE47tqs
 Fo5hehuUPE85b5EPu+eBDkom7IsjPiX1VhjpNXiQbTzc3i2L/wLqN2uDYgwydvryieJkXF2T0gc
 pii4aS/Vwxjyth7yzsq99wbcFFIQ2IvE+oWXQQ7YuH/ZkaV
X-Received: by 2002:a05:6820:4b83:b0:6a1:57aa:28a3 with SMTP id
 006d021491bc7-6a3552acb04mr3538755eaf.26.1783442288914; 
 Tue, 07 Jul 2026 09:38:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb13e15esm15137194fac.3.2026.07.07.09.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 09:38:08 -0700 (PDT)
Date: Tue, 7 Jul 2026 10:38:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <u-boot@0leil.net>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Subject: Re: [PATCH 12/12] MAINTAINERS: add myself as ARM ROCKCHIP maintainer
Message-ID: <20260707163805.GK749385@bill-the-cat>
References: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
 <20260707-rk-custodian-v1-12-dbc9c696e613@0leil.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P8vv2dwLoXUkjkja"
Content-Disposition: inline
In-Reply-To: <20260707-rk-custodian-v1-12-dbc9c696e613@0leil.net>
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


--P8vv2dwLoXUkjkja
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2026 at 06:09:26PM +0200, Quentin Schulz wrote:

> Kever has been pulled into different responsibilities at Rockchip and
> this means he has less to no time for his maintainership in U-Boot as
> has been seen for about a year now. Let's try to improve the situation
> and have Rockchip-related things merged again by adding myself as
> another maintainer.
>=20
> Signed-off-by: Quentin Schulz <u-boot@0leil.net>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--P8vv2dwLoXUkjkja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak0rbQAKCRAr4qD1Cr/k
Ci86AP9mu2EwxtyrbQrwgkNyXHOGFuSyJaPlMLl/JgFaQNs54QD/VAu7PNr3ub0G
/3izvA6fESDOL+ab0/ck3cowItHE7ww=
=id7C
-----END PGP SIGNATURE-----

--P8vv2dwLoXUkjkja--
