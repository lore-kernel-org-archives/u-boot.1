Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37E1E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 16:54:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 398818005B;
	Thu,  9 Jan 2025 17:54:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FjiCxbzu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3DF0800D0; Thu,  9 Jan 2025 17:54:37 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8010F8001F
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 17:54:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b6fc5bf609so82765085a.1
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 08:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736441674; x=1737046474; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kypZNBzB8zvVcyA9yzDZKjZdVUMUwhhuIEC4E5lghAY=;
 b=FjiCxbzucYsR5R3AMN552cztmL4UtwnGf1BbED/1Qmup5r2hZHwIlWO7KKmmsZqKOp
 4VJEX49KrsuEdodTerZ773s/ZfB9/pQTXatXnuRqy7gIVMvWg3rYj7CPV8Uj+Ws11f1Z
 4CSuRRU/dUuJC600fw9DgpPpY8wLSsjRGRzVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736441674; x=1737046474;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kypZNBzB8zvVcyA9yzDZKjZdVUMUwhhuIEC4E5lghAY=;
 b=KtCS20GsUJlDR6jRsTgSF8qBjltx6E7IajHmtqSErFrlXHyqkDb+ZvBcJxJiEHSO3C
 aD4J9Nn0C4oZFCyRER2d9IaVkbvrpqAzJhNkZeFy7oVvxcKGuREMvmvEdY+rz9KAszBx
 MSlVAAd5eSxbPUViDWvVl6JEUOELsywB60hgZ1q37e9PW9fIA3PV+bpKuMo70pVz6zwg
 aONoI0dxpNMOhVGavE24Ojvj0eIb/WnVk3clDGTuc9Dz0XYSoLhNqDyVQkjzzUrAHcB1
 qipG3fxZE1OFyZRr5XkwZwqQ1ZpxE/ZV6IdjP2xX3eA8UHzfRyKeRUiz77XVYVXwaXQ3
 kLOg==
X-Gm-Message-State: AOJu0YxFZh9uTlzcCuXUr3FV9V3qCoKEvU74OkTFt+zjsuvze4v4p6iD
 aqzErvsg3zQirZITgvqLIpiJfTV3B/vOlBHZkmJb9y538Pi3j/v8ZJu77rq4/2I=
X-Gm-Gg: ASbGncsmRh6srH1JaHCgof+HcuZM1XYVRfRxHW6AEWx62VMz7MCRUcJvDpIXx3pTzr6
 2DR9qYWd9L1QXsNY+v9NboVOBqNHPR7dqCXvf24jrj8I9j3E98xC/z77zE+ak4RgNhlBy2cWabq
 tGRutVuhNPjxBrWsKWUnMOECNXDcKACNjT6y+5gD2LCKq5jfyWsWjzb+7NvgkN432+4epqRv+lb
 IJV9vLPdkoH5hjNR0W6mMdIlot4NgtwuwcTihS/7vZOQSDT3po2qww=
X-Google-Smtp-Source: AGHT+IGv9VMeVcW1nAvmATmAkNNZUb68uN+elN8Ixd19Wl7ioS1HA4KGjeAqP5iGk/zWFqyYKVJMzQ==
X-Received: by 2002:a05:620a:1a29:b0:7b6:cb1c:aa22 with SMTP id
 af79cd13be357-7bcd9727b98mr1181939485a.1.1736441674332; 
 Thu, 09 Jan 2025 08:54:34 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce3237fedsm84421485a.25.2025.01.09.08.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 08:54:33 -0800 (PST)
Date: Thu, 9 Jan 2025 10:54:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>,
 Lothar Rubusch <l.rubusch@gmail.com>, Simon Glass <sjg@chromium.org>,
 Olivier L'Heureux <olivier.lheureux@mind.be>,
 Yang Gang <yanggang@byosoft.com.cn>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: Pull request efi-next-20250105
Message-ID: <20250109165430.GA3476@bill-the-cat>
References: <6c11a4a5-8a38-4665-bd04-3e20a662d714@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="viQKhM8VAOt6us3q"
Content-Disposition: inline
In-Reply-To: <6c11a4a5-8a38-4665-bd04-3e20a662d714@gmx.de>
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


--viQKhM8VAOt6us3q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 05, 2025 at 03:57:25AM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> I have removed the objected patch
> "efi_loader: run bootdev_hunt() to find ESP"
>=20
> The following changes since commit ec9263b4f15c4cf82eb6a211c67baa6385065b=
8e:
>=20
>   Fix neighbor discovery ethernet address saving (2025-01-01 14:40:04
> -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-next-20250105
>=20
> for you to fetch changes up to 9c6c7e30aa006a3eab52302e5399f5eb592184ed:
>=20
>   efi: Correct ECPT table GUID (2025-01-05 02:30:49 +0100)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/24077
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--viQKhM8VAOt6us3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd//0YACgkQFHw5/5Y0
tyyS2Av/QI3VraqHU7tpzx0+iygJJHzl9fDLNwWshufLjw0+CZI4g/nRE1c063wg
Sga7mmAFJx1zo/RbuECPvxu8ueJ4T//VWCFVjW+V5EGYFGaHfgmTXxdXJty8BkUt
quJF4XGYkEYHqj1nClLl6VZ/0hy/zUSvNul4glb6Vx+MNIZE0AOcd2jQYzCMKs0u
nBw2S6KHVlwCWtMFhsVmCyXWyehn4WCrArMT7RuFnHBKTnQDGFfNz0iaIjKtNiao
xL4hrQ4Uc6ITCPJXcJaK2DT0wGvbxJ1M29yR79+d0wxmQskoOyVVTWdIGq+plrLW
hwqHQRsSaRvb8PxAAXGoPVEIya1t9kBvyzVBrMSWtlfQZD/o0RFQbE966KtCUiBx
bMF6NI3p3K2qPQJ6M7PzPYOfSl5yHWxcKhYzNV9gLKqeyWze2pImBi+J9iA8dTZ/
KWWiWb7jOaI7vq4Q7DsVBEY/4kOiBzp42m3Xs8jsGy0F1DVqqytvuMCzNo3nGLrz
+mUuDDR6
=lb39
-----END PGP SIGNATURE-----

--viQKhM8VAOt6us3q--
