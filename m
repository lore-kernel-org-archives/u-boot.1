Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA83CC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 17:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3908A8129B;
	Mon, 31 Mar 2025 19:40:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JR1qd/2A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94F978171B; Mon, 31 Mar 2025 19:40:18 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1F4581026
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 19:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2c2ada8264aso2498770fac.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 10:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743442812; x=1744047612; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LDNnBAERrXi1c28sbn5e7NLBujT8Qu4Y134JuKnQ6Kk=;
 b=JR1qd/2AazmS/nF9s4s+FLkwfYBof0+dKKM8N7mxrqWQIwVJDQGei58A0HlpvBAts7
 qUUzN7zd/AgT3fJ6sthqjB4SgTZJPETwxO2I7eJ7dxfsk+gENxqZjQBiYtd386V3IIcJ
 ySrI0ZfdCtX39Z3c0DWD0UTsyFK0crZPxL+44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743442812; x=1744047612;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDNnBAERrXi1c28sbn5e7NLBujT8Qu4Y134JuKnQ6Kk=;
 b=CQSodwFNmSh/E4i/fOfYbTAgdNekTZvECJRn3/SlxHuLbxPN/MxPtuq2kS8w3LLw1I
 9G+TQgGagtIVzlvmInFv1Cp7i7U38QafYv796R7NgOgox4gCAhCJ8M7ZX5cRyNXelc79
 0VJrP9/G6yViV4V3MLZNzmlxUPaQdU0yT9uSCXMvrqGI0wmbLH5p6L049OmttKJNyyHd
 wwRmqjLsRWTszA7GvN+MZxh4kcvipCTfhyR4zEz2MkSmnmtN+QZyRAIxPD5scUNaWtpO
 QFDqtenElhVWH0jz7tNwJ0G0hIjKcZ7sTYmCoYl5D4IVL8rDaO9PKYnwfhObdgudrx9M
 II0Q==
X-Gm-Message-State: AOJu0YxrgAvQe+J+UkoGh3YQvgfLNn9SRMtFdsRmgP/ELbw5M3lyW3Fy
 K+S6rbqIGfOH0A44US24LqDydM1vKVCQFEBxC864c16+pZJvH2TpOMYF+lOiNB8=
X-Gm-Gg: ASbGncusRBNiEq10HJfjnSgq1n7SDdh2hjBfJBxM+2jyL+NcwVLXZUPFqJkz80mBe74
 1wESCVsK/o3sVTSlS1A0jLUy72pq94X6NB/shRcTm8gyXFykNRmPMlY6jIJl0lzX3226V03TQa1
 FGzNohRbHgsWUVpHNH8GPByCdfPR0roEax9Is7p1+4tPyIElmg/3MYLhXbLQAdYOxfXoLIdpf7n
 nZruj0h/zblbPssG+T7cvhpDR8xqxXSYX6PbIBSWoIK9Qr1zs2vdqSFEkOqqdLKTg72HfxcfOqB
 EpTiKSGO323mKPkBpk3BQHV4qztDvOTzbfx2sgsZ2X0pFt3BTn4sAOU4ueiq/w7mnnxKecG+cpU
 559axHOZKOQHZKwp1
X-Google-Smtp-Source: AGHT+IGv8CnHjNT0vVusuKQ2Dv/PTwCwH2X1A5V/7H9Zrx98DU7oZtX2TKJ0xh78Hmz+boMRy4CIZg==
X-Received: by 2002:a05:6871:ea09:b0:2c1:5fcd:acc5 with SMTP id
 586e51a60fabf-2cbcf4cdabbmr6290577fac.10.1743442812591; 
 Mon, 31 Mar 2025 10:40:12 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a911709sm1920306fac.44.2025.03.31.10.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 10:40:11 -0700 (PDT)
Date: Mon, 31 Mar 2025 11:40:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Baruch Siach <baruch@tkos.co.il>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, Nam Cao <namcao@linutronix.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>, Roger Knecht <rknecht@pm.me>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 00/17] bootstd: Useability improvements
Message-ID: <20250331174008.GG93000@bill-the-cat>
References: <20250319143820.2385092-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Bck87FONNGFXiHpL"
Content-Disposition: inline
In-Reply-To: <20250319143820.2385092-1-sjg@chromium.org>
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


--Bck87FONNGFXiHpL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 03:37:54PM +0100, Simon Glass wrote:

> This series collects together some bootstd improvements:
>=20
> - Improve iteration when there are a lot of devices
> - Add a test image for Ubuntu (to compliment Fedora)
> - Improve the naming of USB devices and bootdevs
> - Add a new command to set the bootdev order
> - Add a little more debugging
> - Use an abuf when dealing with allocate files
> - A few other minor things in bootstd
>=20
> Most of these issues were found when adding the new test image and more
> USB devices to sandbox.

This isn't based on mainline, either:
> base-commit: 569681e993486b830035064f23ec87bcd70795d1
> branch: schc

And I don't know why.

--=20
Tom

--Bck87FONNGFXiHpL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfq03AACgkQFHw5/5Y0
tyxbMQv/e4401n+aq2t0OHxQaxpTPwMJ49jScij3BE9IuKAQQBKt5d5zBQfNwQ+g
Zeusazy48JOYf1MqZ6rt6FYFAxai6MegvDykJgYYfkDL+7a46WtsDdNOJDKD/vGF
xpuMaoIwd25u4teU3CwcbZ07XKCpdKDaWUbyAJZOLBHzg8Lc8qr+QYnbfBtPq6d1
ixowmCHrYkY3rKrxmUeVlWJXQQPz1eDJ83KN9HY/gQBMwjR5ytVKWfpcHvCtZF9k
gbK5O3GOaqoNAbGJwgmJ2QrJFb/4yv/19e3N0p7jimWm2wkWh/SyBz2Q9WS1YB6W
8UObLqHmBVM/njtgB6fsm4EJT+kcddQkH+VgiJyGHRQpW/rHjh9mP/S6/dUMVpo9
YYIk+1JYOM6D4Hi0V8MGWU5/u70nKH1Tl2O9s6L2RKgTWvkuQ/KaxA+8VsuNvgPw
N9ONcD+s9pzly5pBtcw7QJcdau6xR3LT9KSDtjlGkD6e9+NGAAPzwAKZRtY+fv67
WA2uZ74S
=bAhx
-----END PGP SIGNATURE-----

--Bck87FONNGFXiHpL--
