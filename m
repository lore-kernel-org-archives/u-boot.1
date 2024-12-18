Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50540E7718A
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 13:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0FAA8021D;
	Wed, 18 Dec 2024 14:02:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aZsWuJtc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37D1F80316; Wed, 18 Dec 2024 14:02:11 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D032A80303
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 14:02:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so33997665e9.0
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 05:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734526927; x=1735131727;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WvKG8ZcWjT2lrPXh9Msn/ueAxnr1Hqlppp3x18h//gQ=;
 b=aZsWuJtcX9ejyicvjMOT6bVynftmfqJpAO9xTmVSvQfdmodc+WCe7oaTY4aPqD1qzg
 Muh9RnfGw9mHWjGGASXaosgVL4YqpuaKh7sWRyuzs9UD7iy9X+T3+OuXhviWeAcq0vRP
 vncaSpsYkLG1KlAkFOk9rWKeQdZP+BWTbPERTkdKF1YyfXKw/otrsShGZDkHI+tyDeee
 MIX1bnLgFQGoyy98FVTki9wM7NQNsjF+DOB41Mdu9DdKd7C/N/hM7GhmuRHi2BIEcMZe
 4iukZtpC0K9fjogEQx/lMPp8EcxxSh2Lp+jKz0qjUe6mX0N6/HpRtvRQzd6gx+v3AK/f
 ylcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734526927; x=1735131727;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WvKG8ZcWjT2lrPXh9Msn/ueAxnr1Hqlppp3x18h//gQ=;
 b=PdJLz/spP3CED8LrGTBjD2M/S4kesUSKUmqsuvER2jeqngp/yHuO3lBFYwUyx+0xlq
 7qYkw7xgiOEcJTJYobT6tidgtbEBzjgISnGoB/ly0clNUP0WX9rC9eyiwz7AbQhtleoo
 KrtgC7ql3qUtY/cScus+FJlssHHxVa31rC02BZBhTEE96eDbO4SBu7COZBXbPMduEbfW
 mPQsVwyO7/oe6RynFdifVgACI07rAsO1oo8s7apIzgD7c78G8i5dCp8tYP05SBBiQCAV
 bQYYzH+R1JMx0rphJWdVUED9tABG7/PoeR8zdWDFjgs5FwaH3fMtmd5ZRUO0262CLKhv
 Srhg==
X-Gm-Message-State: AOJu0YwE/oUu0+7/MH2HKKmwkBjM8zsTLDzLVoMtqtnyjdJAe+XBWfea
 uQ/RNoLUIp/0iw0iVhMq3IteCLRRjtfK8n2P3VzWQWAcAYJgOZta8KOFIZNcHiY=
X-Gm-Gg: ASbGncs7ZnnUqY7OkcLKfoVXH9KvKyJDUtwSVnSyusyS+Txxk+QFiO1ppFA/atd0j/w
 GWK5oPknGunBZybhcQlfqrqH5Hh649KM+U8r6R4HRrD2x6gnDsA5FwmBHBMYoyx0Oi7TXjgSJOe
 hLHXtVeSFM/j/bWGWF1+CZVVX08ZAD+b/TOms9TN5EoKbiHp6L8/tpky550B7TjT2B7aTbYHML0
 vMfEa8mV/ibw0ErnF5cbk60yrROlxe0GgTJk6FrTMdaxf1YhymesWt3WHRGDRtFkA==
X-Google-Smtp-Source: AGHT+IEMS/AmJLl19EmCDBVazEQu9lA9idu2DmXehcU51MOpj4huf1DITkQsebDMhQUPiIMA9hV2VQ==
X-Received: by 2002:a05:600c:1382:b0:434:f3a1:b210 with SMTP id
 5b1f17b1804b1-4365540a583mr22658195e9.32.1734526927091; 
 Wed, 18 Dec 2024 05:02:07 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c801a8a5sm14037967f8f.48.2024.12.18.05.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:02:06 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vigneshr@ti.com, bb@ti.com,
 trini@konsulko.com, lukma@denx.de, n-francis@ti.com, afd@ti.com,
 glaroque@baylibre.com, sjoerd@collabora.com, martyn.welch@collabora.com,
 rasmus.villemoes@prevas.dk, caleb.connolly@linaro.org, j-humphreys@ti.com,
 rogerq@kernel.org, nm@ti.com
Cc: u-boot@lists.denx.de, srk@ti.com, s-vadapalli@ti.com
Subject: Re: [PATCH v2 5/5] doc: board: document support for USB DFU boot on
 AM62Px SoC
In-Reply-To: <20241218124542.3519447-6-s-vadapalli@ti.com>
References: <20241218124542.3519447-1-s-vadapalli@ti.com>
 <20241218124542.3519447-6-s-vadapalli@ti.com>
Date: Wed, 18 Dec 2024 14:02:05 +0100
Message-ID: <8734ilw3ea.fsf@baylibre.com>
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

Hi Siddharth,

Thank you for the patch.

On mer., d=C3=A9c. 18, 2024 at 18:15, Siddharth Vadapalli <s-vadapalli@ti.c=
om> wrote:

> Since USB DFU boot is supported on AM62Px SoC, document the steps
> required to build the image for USB DFU boot along with the steps to
> send images using the "dfu-util" tool.
>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> This patch has been newly introduced in this series based on the
> discussion at:
> https://patchwork.ozlabs.org/project/uboot/patch/20241217131658.2920799-3=
-s-vadapalli@ti.com/#3432702
>
> NOTE: This patch should only be merged if all other patches in this
> series will also be merged, in order to ensure that the feature is
> documented only if it is supported (i.e. all patches in this series
> which are required for the feature to be functional have been merged).
>
>  doc/board/ti/am62px_sk.rst | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
> index 99bdc034869..75451ad76b5 100644
> --- a/doc/board/ti/am62px_sk.rst
> +++ b/doc/board/ti/am62px_sk.rst
> @@ -124,6 +124,18 @@ Set the variables corresponding to this platform:
>      :start-after: .. k3_rst_include_start_build_steps_spl_r5
>      :end-before: .. k3_rst_include_end_build_steps_spl_r5
>=20=20
> +* 3.1.1 Alternative build of R5 for DFU boot:
> +
> +  As the SPL size can exceed the limit when building it with support for
> +  booting from both local storage *and* DFU, in order to disable the
> +  configs not required for DFU boot, a config fragment should be used
> +  to not only enable configs for DFU boot, but also disabled the unneeded
> +  configs.
> +
> +.. prompt:: bash $
> +
> +   export UBOOT_CFG_CORTEXR=3D"${UBOOT_CFG_CORTEXR} am62x_r5_usbdfu.conf=
ig"
> +
>  * 3.2 A53:
>=20=20
>  .. include::  ../ti/k3.rst
> @@ -290,6 +302,25 @@ https://www.ti.com/lit/pdf/spruj83 under the `Boot M=
ode Pins` section.
>=20=20
>  For SW2 and SW1, the switch state in the "ON" position =3D 1.
>=20=20
> +DFU based boot
> +--------------
> +
> +To boot the board over DFU, set the switches to DFU mode and connect to =
the
> +USB type C DRD port on the board. After power-on the build artifacts nee=
ds to be
> +uploaded one by one with a tool like dfu-util.
> +
> +The initial ROM will have a DFU alt named `bootloader` for the initial R=
5 spl
> +upload. The next stages as exposed by U-Boot have target alts matching t=
he name
> +of the artifacts, for these a USB reset has to be done after each upload.
> +
> +When using dfu-util the following commands can be used to boot to a U-Bo=
ot shell:
> +
> +.. prompt:: bash $
> +
> +  dfu-util -a bootloader -D tiboot3.bin
> +  dfu-util -R -a tispl -D tispl.bin
> +  dfu-util -R -a u-boot.img -D u-boot.img
> +
>  Debugging U-Boot
>  ----------------
>=20=20
> --=20
> 2.43.0
