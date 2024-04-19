Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1C0C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:35:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EBDD887C8;
	Fri, 19 Apr 2024 18:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aT7FSPV/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D572C887D1; Fri, 19 Apr 2024 18:35:16 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E14D0887C6
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 18:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-51967f75729so2641544e87.0
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713544514; x=1714149314; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ihkc0o/Ra1ZckFtv4VQU7vWDx/JfuSlrokBhM0Ytby8=;
 b=aT7FSPV/dt4Ujm/KDME4Df7FZSamMfxn5XyohUcByNCQR6KLHci9CGs+nb8UHhetG4
 IJsS6cS1XlVd0I6MENI8mvUxceioMC1Y0ITQG6Tpny+nh8sT1YfqwWiW/zPJORzixPWl
 R+95kHo0ep9MPt6DUs7dyvKP59A4YbAf90pq5v6gNO+eYPYyDUtBMjSzOOuD5xkAHmF6
 JOW6o8G3Segb3EOA62g5xmCYhlhRhlQ0PblSkiQUJGBY9kgJs9ySqLcorVdEWurex/WH
 wPw1isIw9BOjMH48BC4tJsJpS5FAiuodNAlG6RoZTtI/WtAHONguMUTgx2X/gGW96bxO
 xIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713544514; x=1714149314;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ihkc0o/Ra1ZckFtv4VQU7vWDx/JfuSlrokBhM0Ytby8=;
 b=RqGJctMYhLXW3+h6ZkH5QO3oz4k1qbSUj74heG+Bi1ifxcDJHOcbSxnDreqTD70uql
 4ftd+cpzYlxjMEosuYGozSRxGk6uSuAjxf1UE/Ffq1lOgdyf7FeRLC07/IbMJrqyEvoy
 4hTPsGDrJ0DDwLNhmEFQDzLOGwVwFmEIfXJWScqlQtnxmzPuZ3kqgz4WBuKz93YALMHV
 3RVpHEF8mqmjYssMSwMncbJO+uLg4UNeKe1dPvo83DHSZOuj16AQtqmbmYjsCSx2zFdi
 BH01e3A8CSwqW9h3l1h5uV2K5QMPjnSTDjvy1whCR/zrXvkApILBm2YC6X7gTOFhzBt5
 9sQA==
X-Gm-Message-State: AOJu0Yxd6i9hC8QQD29+8asISdv79KxBPd/2pTM++ZTBj8NsVLsZfd+h
 /nc2IH/kjyQTyVi0UA9BCbx+8Qku3flRfMbe5etXY6XG0yqAE5+1
X-Google-Smtp-Source: AGHT+IEiynJcw4Hf7ByzW+NJwEXUb7wEjXReWyJ/sr+XYYWZmN0pU44vBrnkGC0xzsEJytgrlKg35g==
X-Received: by 2002:a05:6512:445:b0:519:1bcd:87cf with SMTP id
 y5-20020a056512044500b005191bcd87cfmr1694355lfk.27.1713544514025; 
 Fri, 19 Apr 2024 09:35:14 -0700 (PDT)
Received: from localhost
 (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 dn22-20020a17090794d600b00a5577f7be5esm1946110ejc.81.2024.04.19.09.35.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 09:35:13 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=3190de95c8ae6ba4a909af83bb26ffaf6cf44d0178834b6931a149bdeddd;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 18:35:12 +0200
Message-Id: <D0O8U1YLJFTY.QJ6XFLZ3NS3K@gmail.com>
Cc: <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 10/18] video: tegra20: dc: enable backlight after DC
 is configured
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Thierry Reding"
 <treding@nvidia.com>, "Anatolij Gustschin" <agust@denx.de>, "Simon Glass"
 <sjg@chromium.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-11-clamor95@gmail.com>
In-Reply-To: <20240123171633.246057-11-clamor95@gmail.com>
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

--3190de95c8ae6ba4a909af83bb26ffaf6cf44d0178834b6931a149bdeddd
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> From: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
>
> The goal of panel_set_backlight() is to enable backlight. Hence,
> it should be called at the probe end.
>
> Signed-off-by: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/video/tegra20/tegra-dc.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--3190de95c8ae6ba4a909af83bb26ffaf6cf44d0178834b6931a149bdeddd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYinUEACgkQ3SOs138+
s6ExzhAAmVjGoW6rbcwomWHDNaFEpXWMpJtjtC5Gz6txtmUsHf5lF4XXMtXsEqWY
pnuWG5zJfyg7SVhFcOymBRsDkn6Gxfp+rKP/85455+lKC2o358EVf86YVJHqFfg4
DfIHXhGaT6oJmaJpnj/YZhDK//abNzmFQqRlVi5WoDDQRSQgiyT3D4L3x6dp2Ko6
G/e6EBKBdqbx+Z87QGHGXSrHlLRb7rM3b7pF8Wl6JsLm1Xz0u2Pb8fGJMOyJPCX0
a7YDmYS0AWjU6C1dIkdZpQaFnQvAMQSfIWsIz120s/5vGIGLzoktgfS9GrOY2+2v
qEnSR4sKWHFRyVcz8Zdkgq6UQ45ez6kwWliyNhqfNwUvVV+7/1J1f4q8HAhOfaup
9jSWwY4LDBASkhYpSj3r7yscSo5Noa7/D51kzkAm/xjZYEupxgDSc4fBdiPOy1hu
eiOZvuHpzwM5qBGe9L2tAyhE35O1Q/1CrvrG1x9GgHoA+DGByycNqzpE7nKBIIC9
DCNkGMbKb/nIGOqn7BhjZk/yqerYtTJu6EdR3wzXrR980Sk1aDzi7KryAB9mgDcO
QaxOXqyQcu/wnVVddHgBZRWJ2p6akGoR9OfeqYCJj4Xmlrb8PTy29ZLuahmo9Dye
LRkumMeJZ93nX63UO02AYa9h28kmXtYkMcs6RZys76ivgo6638Y=
=NyZa
-----END PGP SIGNATURE-----

--3190de95c8ae6ba4a909af83bb26ffaf6cf44d0178834b6931a149bdeddd--
