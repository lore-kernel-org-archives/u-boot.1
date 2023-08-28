Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98081C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 08:03:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02A6C8645E;
	Mon, 28 Aug 2023 10:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="VXefVpPf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7B25803AB; Mon, 28 Aug 2023 10:03:50 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD41F86496
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31aec0a1a8bso1786859f8f.0
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 01:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1693209827; x=1693814627; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y6Gj1lNFM9wGEPhjSzE9SaA1L8B3q3BqnJZdDML2/eo=;
 b=VXefVpPfok/lcEVdl/W+q0mRDu1dbZLlXWhOIOHcs6FPJUFAOCT4ls3/UzVBIVpjgW
 /c18xKGQuNi2lAuNrO09B/Y4Delefw6lMZCy+wSejB5Kfp1cEdhRoIlwp1TtRiT7xjE9
 F4QEfTHxrQ4uwoXvV2fn2CNnFZCNyaOngsJS4yR3pI7mK912NAS+ocSt5lHa8tdFkmO6
 H4SN9J9V3jH6lz1ozzZhbF/+o4E3KVVa8zZ9oe1gYsngwIiWffj9oS7UfLyVxddYDJpA
 uNUPwQlJ9C4JBa/25/lTXcd0OM26vlX8DTDwM1RjiT3e7wkq2t52eavNJiKMzpy+Lz3p
 EWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693209827; x=1693814627;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y6Gj1lNFM9wGEPhjSzE9SaA1L8B3q3BqnJZdDML2/eo=;
 b=UTRikN4574UpzZYCwQTT4gYTkTc8Yvug7Nqqxdy9fWe1HjXulqFQjsDOXxKT47cRPW
 +AgTjJIeawdVBkqVKV222TfeYG4ZPcTy2sIdUHl4/DqfgQVvPomLMUzL2nQQWlVYOVRU
 dRdg0PlmhU0neE4FPK5Qb4Ls8l+AHiM/SXLAoZg6MwCcQT7OOnE42S5ZEQKB7/cbQNOv
 PdnHzMLXBJDXaAWYua48pRtkEei6ghF9zRoSXa65k74f65pCCrzoH7aEdpr1PPmJ0KEz
 M/CBBKCgPlYEo9gchJvgORJG7TvXP12namQNMy6w5YBeII6ov3BLG1rYlGItbV2bsFNn
 vgqw==
X-Gm-Message-State: AOJu0YzN4+evqY7U8xCn/jmeiMl6D8bAw+EuF4HCa8/JJVRLIsbxYWr1
 zA9IrHA1WOKYHbQqVj4VAySV+w==
X-Google-Smtp-Source: AGHT+IGh5LPUq0D3t9plKKW2CIyOaATA2R5XJi5/YU/vbSbmTHJaRamYh9rhsC4ITiS0rLEIudWaQQ==
X-Received: by 2002:adf:fe50:0:b0:319:7626:517e with SMTP id
 m16-20020adffe50000000b003197626517emr18381653wrs.19.1693209827247; 
 Mon, 28 Aug 2023 01:03:47 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a5d6a11000000b003142e438e8csm9720243wru.26.2023.08.28.01.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 01:03:46 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>, Neha Francis <n-francis@ti.com>, Tom
 Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Nishanth Menon
 <nm@ti.com>
Subject: Re: [RFC PATCH 1/2] doc: sphinx: Add sphinx-prompt
In-Reply-To: <20230824154036.3650607-2-nm@ti.com>
References: <20230824154036.3650607-1-nm@ti.com>
 <20230824154036.3650607-2-nm@ti.com>
Date: Mon, 28 Aug 2023 10:03:45 +0200
Message-ID: <87y1hvwq3i.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On jeu., ao=C3=BBt 24, 2023 at 10:40, Nishanth Menon <nm@ti.com> wrote:

> Sphinx-prompt[1] helps bring-in '.. prompt::' option that allows a
> better rendered documentation, yet be able to copy paste without
> picking up the prompt from rendered documentation.
>
> [1] https://lore.kernel.org/all/87fs48rgto.fsf@baylibre.com/
> Suggested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Version picked is the best that works with Sphinx 3.4.3
>
>  doc/conf.py                 | 2 +-
>  doc/sphinx/requirements.txt | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/doc/conf.py b/doc/conf.py
> index 00f241366477..5e2ff1c8f5e2 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -39,7 +39,7 @@ needs_sphinx =3D '2.4.4'
>  extensions =3D ['kerneldoc', 'rstFlatTable', 'kernel_include',
>                'kfigure', 'sphinx.ext.ifconfig', # 'automarkup',
>                'maintainers_include', 'sphinx.ext.autosectionlabel',
> -              'kernel_abi', 'kernel_feat']
> +              'kernel_abi', 'kernel_feat', 'sphinx-prompt']
>=20=20
>  #
>  # cdomain is badly broken in Sphinx 3+.  Leaving it out generates *most*
> diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
> index 4f411f78d030..6ccbe527ee79 100644
> --- a/doc/sphinx/requirements.txt
> +++ b/doc/sphinx/requirements.txt
> @@ -15,6 +15,7 @@ requests=3D=3D2.31.0
>  six=3D=3D1.16.0
>  snowballstemmer=3D=3D2.2.0
>  Sphinx=3D=3D3.4.3
> +sphinx-prompt=3D=3D1.5.0
>  sphinx-rtd-theme=3D=3D1.0.0
>  sphinxcontrib-applehelp=3D=3D1.0.2
>  sphinxcontrib-devhelp=3D=3D1.0.2
> --=20
> 2.40.0
