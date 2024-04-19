Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989CCC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:05:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A82E3886F3;
	Fri, 19 Apr 2024 18:05:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QTXdG5r4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4582F88777; Fri, 19 Apr 2024 18:05:15 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 518FF8861B
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 18:05:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a5557e3ebcaso369544566b.1
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713542712; x=1714147512; darn=lists.denx.de;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9Tt7iD8MSmPWPHGs3r9zvtI0WlgugInFsVB226gM9VU=;
 b=QTXdG5r4Bf17pgcy/uGdwl3v5ozQFKSGuRZ94qOtbXVIZaK1DIzyrmE0aBzN3hRcVB
 YJk97+BX9KCsKZfcIhHEHWGnwi5koU8WxOkf2Tjy2A3UEr0jSW8Qd9eL/SG9itds8+kM
 yPXgJKGzgtt9uH0r3IfujJhPnvwG8szkAxo//bjwwn8Pwd3GoaMXWD+swwkwhbw6Zfdx
 d04yZmtA7zsUwIy0Z2ZK0tyyQpwbGcb3mA7BZOMjAiuZ+99ODlYvDuFUtOqZs1lyX3Am
 4RrFonEQHllN1t+kEjGPaNhKBc80E/C8lOe+hUGW6dmLwf1GP0m1JRQzZJpdkDrpiUnc
 empw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542712; x=1714147512;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Tt7iD8MSmPWPHGs3r9zvtI0WlgugInFsVB226gM9VU=;
 b=KpjCxgCZkyvXr216Y+ISCsyUQ08kil6eqraLSUjfez3QDL+5lgDKZW5JvFGufGZHKY
 7uOCv0LK7//XTQzHb/7Ndi2PZ3PfXf/wwuqGYlcpgDIex/jZn8IOEnQWRgwQrgVKz/qN
 0Y7nDxSoN6/2SlI+ttLNeVfFDJ8+IpqVBgQnur0H8be4uWt4fOQF9xc/kgUCrbgMvKKV
 9crJevHyTLOjgahJ0TWFgVzk0vRftAJpYpIN33D7Xx0Y6dgnQQZYNvKd5bxWLzyuB/Ef
 1iyP+mBvwoZH0m8YUPhxP43/0SJpJs3giXP3VMv7m9Iddbj9HakthJl2bM67EIrgLWED
 Np2A==
X-Gm-Message-State: AOJu0Yx7cmvzhfqaaO0hW0A+9NWkzJHUzVcw34rcAa3wwQiq4MhydWyv
 cSDAk29zNn1jvlEW7JveEbsQ3tO6vEmtvaW/x/c2/FitetiYJdgf
X-Google-Smtp-Source: AGHT+IF0tdE/eQ3pqiLMejP/cwoza7fR73OmtBlIGycqmjOQXfgCJGnzVraH6J2hghJFPZH3W6iASg==
X-Received: by 2002:a17:907:1186:b0:a55:6d66:3989 with SMTP id
 uz6-20020a170907118600b00a556d663989mr2657384ejb.1.1713542711954; 
 Fri, 19 Apr 2024 09:05:11 -0700 (PDT)
Received: from localhost
 (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 cw11-20020a170906c78b00b00a556c5190ecsm2376320ejb.221.2024.04.19.09.05.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 09:05:11 -0700 (PDT)
Content-Type: multipart/signed;
 boundary=d573c7bfac2cd8bba806a4ee804e2500e8fe42749585e4c1e0671a261c6c;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 18:05:10 +0200
Message-Id: <D0O8720SNXUY.58M29AZIXYVC@gmail.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Thierry Reding"
 <treding@nvidia.com>, "Anatolij Gustschin" <agust@denx.de>, "Simon Glass"
 <sjg@chromium.org>
Cc: <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 06/18] video: tegra20: dc: add reset support
From: "Thierry Reding" <thierry.reding@gmail.com>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240123171633.246057-1-clamor95@gmail.com>
 <20240123171633.246057-7-clamor95@gmail.com>
In-Reply-To: <20240123171633.246057-7-clamor95@gmail.com>
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

--d573c7bfac2cd8bba806a4ee804e2500e8fe42749585e4c1e0671a261c6c
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Jan 23, 2024 at 6:16 PM CET, Svyatoslav Ryhel wrote:
> Implement reset use to discard any changes which could have been
> applied to DC before and can interfere with current configuration.
>
> Tested-by: Agneli <poczt@protonmail.ch> # Toshiba AC100 T20
> Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101
> Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Grouper E156=
5
> Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/video/tegra20/tegra-dc.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/teg=
ra-dc.c
> index 56a23b3c97..35abb6fe46 100644
> --- a/drivers/video/tegra20/tegra-dc.c
> +++ b/drivers/video/tegra20/tegra-dc.c
> @@ -10,7 +10,9 @@
>  #include <panel.h>
>  #include <part.h>
>  #include <pwm.h>
> +#include <reset.h>
>  #include <video.h>
> +#include <linux/delay.h>
>  #include <asm/cache.h>
>  #include <asm/global_data.h>
>  #include <asm/system.h>
> @@ -342,6 +344,7 @@ static int tegra_lcd_probe(struct udevice *dev)
>  	struct video_uc_plat *plat =3D dev_get_uclass_plat(dev);
>  	struct video_priv *uc_priv =3D dev_get_uclass_priv(dev);
>  	struct tegra_lcd_priv *priv =3D dev_get_priv(dev);
> +	struct reset_ctl reset_ctl;
>  	int ret;
> =20
>  	/* Initialize the Tegra display controller */
> @@ -349,6 +352,20 @@ static int tegra_lcd_probe(struct udevice *dev)
>  	funcmux_select(PERIPH_ID_DISP1, FUNCMUX_DEFAULT);
>  #endif
> =20
> +	ret =3D reset_get_by_name(dev, "dc", &reset_ctl);
> +	if (ret) {
> +		log_err("reset_get_by_name() failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	clock_disable(priv->dc_clk[0]);
> +
> +	/* Reset everything set before */
> +	reset_assert(&reset_ctl);
> +	mdelay(4);
> +	reset_deassert(&reset_ctl);
> +	mdelay(4);

Are you sure this works as intended? It's been a long time since I
worked on this, but I seem to recall that most of these resets are
actually synchronous, so in order for them to do what they're supposed
to the clock needs to be kept running.

The Linux driver certainly does this differently.

Thierry

--d573c7bfac2cd8bba806a4ee804e2500e8fe42749585e4c1e0671a261c6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmYiljcACgkQ3SOs138+
s6FcjRAAplaMv3YqgeCDkvL4NePvIfVNGtI4Qra1WANBSjkxjJmwCfg27NFmw341
dd5b/yBPF6bdT/R8ZjOiZu7ER4d5/coskPvBbcN3MholtC+HvSZWi/21PhX3h5Dc
umP8n7DKbHdfUxnGZ7NjOqOq+fZwydIIlthRDXns2/D0KFghIXGqAkfQ3bUWF5oz
NdsU8ezuG2EbOvvrABclnDMUYkQMT/An0Ou7kg7wFgG+6Qns6gl9XuwemXevHXhD
x/Ujiw0AoMDZVJbCY2nWC48bTAUGwcbn08tFXuSkmoOA6LEWUWnKSdNKVnqL1s7g
I3B2NBLwWkzCC6iE2rqVywiw7g6rDhCjOwUHBR97gyPwly+brDTg/atRhHG/PXKF
p+tqwQvou6Gn5gxUIE6PGKhPkJNjNq+FgsgdnYn7coRMnp4DokvOlMcAOONKrM9V
46DdtgRW0KkCXuxh/GChbXqObzGCoVGrL8vTtD8bCBzLM7oxLN9Vhq7SuhwrmsQe
ndDEIoc0H+ifWBKDd5YG1zJviOGiMxKBJjzeiDRVWJ2M4280nl1zue2qKwQurx5C
TdnszcBa8pdjj0Au8J2vLzodFWnEcvJYMPGrwW+VSBKT6+dQuCOD3PxsCuFEqq2y
W224LK6V8YNDAxpmPPoMteYouU8w4eFkqh5rwhGm1dlcuI7Ak5s=
=aGkk
-----END PGP SIGNATURE-----

--d573c7bfac2cd8bba806a4ee804e2500e8fe42749585e4c1e0671a261c6c--
