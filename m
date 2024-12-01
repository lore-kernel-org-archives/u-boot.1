Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9DED49773
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:06:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 454DF89138;
	Sun,  1 Dec 2024 16:06:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qwffrg6J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AC4C89138; Sun,  1 Dec 2024 16:06:08 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E077188D3C
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385e35912f1so1009184f8f.3
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733065565; x=1733670365; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yt5/7jMtlOlnQ74ttNL3MHc+PwYfms2gFvrm972+9tE=;
 b=Qwffrg6JfQuBGCK5e6bw6ylnpkRILczZXgMZNxtBUQRxQ2rAeACsQNLIiOIj0G1RQf
 OUX+xQSsN2fKwrhDE719YM59nzWZdMGJ4HFsIXsxZ4cxj3YloEBpskQM7UWFNhhM1nk5
 UwzBvcxdWLOV9O1cRzKI4k/wnDJfRKFvHxZMS2r+fXdRVaownPklwF3zNXe7Z3gbK5XJ
 7xZS4S6m9rLm9KoNlI90aFbja9/Hy4dIDI4V3esKbIBzHmJ81rT+2uQU/prKWXEGtqF2
 8RiV5rgPWKgihp/Box5KOOHvBcOk2EpjS/6FwupFxKhmMiUpidrcAVdUIL/5xdEfw7qx
 VyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065565; x=1733670365;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yt5/7jMtlOlnQ74ttNL3MHc+PwYfms2gFvrm972+9tE=;
 b=d0UWICZ1wfrRjPyy3tNbwZeruOHuJc/hRmRFX6XsCqMODndTavSwBO+6gMhOjtn9dg
 K1n5m/f+jvx/qTVVJlLoM1HhwuWuKsPSac/pxQRivs8WNx8uLKU+vDjCSp2+fqFk8xco
 HLZ5soErPr44zANyUR3OM8cpnlHHGQwA6dEljogAo5bSMWGi2Lt/PgqL5ZKbdOu7dfLl
 KQbaANkS8MCfnjSfTbpMaBXKsQkB9c7lV9oTE2Us9xYoXjg8o/JzZysQU5ljDYcaCU60
 R6MNcW9Dz9VE3+UVneRAsPWm3aYULOc5HdsOrUmBDxeZEUJi3EGy9/T4hS3iVS5JWrrb
 Zleg==
X-Gm-Message-State: AOJu0YzKnh59yTG41BLvg5Sj1Xzp+Q9sk6Kd5SE014bPwhEKI3TGHLOP
 +/J6pMgfWTsdGnq/zkc6Nf7GGr/KD7hbEd2gfEg6xfDNtjhwwLpC9J7bQ4BxvI+Vd9i6G7RecTt
 ExlC9wTco/y/KRoZJYtRTZCmoYJs=
X-Gm-Gg: ASbGncsSjrPYryqLd2lyMFvH6ucYdEJ5xR+ov+ZDOobD6C8+PkCdJ+5H0xB4FbNKZMK
 ItQPA8ItoARx1qwB0it5kToNZYD8OO+TV
X-Google-Smtp-Source: AGHT+IEr5efYgIRGyc7MPw9bDdd3zYlATsi/wWLMB5JPMab6YxhtBGn8wy6JIqJPZduFR74IrIuMWr45B/r04wNh9dM=
X-Received: by 2002:a5d:6c6c:0:b0:382:3cc2:537c with SMTP id
 ffacd0b85a97d-385c6ebef55mr16432604f8f.26.1733065564933; Sun, 01 Dec 2024
 07:06:04 -0800 (PST)
MIME-Version: 1.0
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-3-sjg@chromium.org>
In-Reply-To: <20241201144240.1664398-3-sjg@chromium.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 1 Dec 2024 17:05:53 +0200
Message-ID: <CAPVz0n0RGrgUSrNzyT16FKMBcqYs00qb+3jEHsq4tiYyWGR-Nw@mail.gmail.com>
Subject: Re: [PATCH 2/8] Revert "power: regulator: Trigger probe of regulators
 which are always-on or boot-on"
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marex@denx.de>, Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
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

=D0=BD=D0=B4, 1 =D0=B3=D1=80=D1=83=D0=B4. 2024=E2=80=AF=D1=80. =D0=BE 16:42=
 Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Unfortunately this commit causes a problem on nyan-big:
>
>    U-Boot SPL 2024.10-rc6-00632-g51c4679d2f84 (Nov 30 2024 - 13:28:40 -07=
00)
>    Trying to boot from RAM
>
>    U-Boot 2024.10-rc6-00632-g51c4679d2f84 (Nov 30 2024 - 13:28:40 -0700)
>
>    SoC: tegra124
>    Reset cause: POR
>    Model: Acer Chromebook 13 CB5-311
>    Board: Google/NVIDIA Nyan-big, ID: -2
>    DRAM:  2 GiB
>    failed to read ID1 register: -121
>    failed to read ID: -121
>    failed to read ID1 register: -121
>    failed to read ID: -121
>    failed to read ID1 register: -121
>    failed to read ID: -121
>    failed to read ID1 register: -121
>    failed to read ID: -121
>    failed to read ID1 register: -121
>    failed to read ID: -121
>    failed to read ID1 register: -121
>    failed to read ID: -121
>    failed to read ID1 register: -121
>    failed to read ID: -121
>    failed to read ID1 register: -121
>    failed to read ID: -121
>    failed to read ID1 register: -121
>    failed to read ID: -121
>    Unknown PLL id 14
>    failed to read ID1 register: -121
>    failed to read ID: -121
>    initcall failed at call 810029c8 (err=3D-121: Remote I/O error)
>    ### ERROR ### Please RESET the board ###
>
> This reverts commit 51c4679d2f848e91b4a0cf867a426ffe5bb094b2.
>
> Tweak a few tests also, so they continue to pass.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  drivers/power/regulator/regulator-uclass.c | 22 +++++++---------------
>  test/dm/regulator.c                        |  6 ++++--
>  2 files changed, 11 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/r=
egulator/regulator-uclass.c
> index decd0802c84..3da7c09ef14 100644
> --- a/drivers/power/regulator/regulator-uclass.c
> +++ b/drivers/power/regulator/regulator-uclass.c
> @@ -433,8 +433,6 @@ static int regulator_post_bind(struct udevice *dev)
>         const char *property =3D "regulator-name";
>
>         uc_pdata =3D dev_get_uclass_plat(dev);
> -       uc_pdata->always_on =3D dev_read_bool(dev, "regulator-always-on")=
;
> -       uc_pdata->boot_on =3D dev_read_bool(dev, "regulator-boot-on");
>
>         /* Regulator's mandatory constraint */
>         uc_pdata->name =3D dev_read_string(dev, property);
> @@ -446,21 +444,13 @@ static int regulator_post_bind(struct udevice *dev)
>                         return -EINVAL;
>         }
>
> -       if (!regulator_name_is_unique(dev, uc_pdata->name)) {
> -               debug("'%s' of dev: '%s', has nonunique value: '%s\n",
> -                     property, dev->name, uc_pdata->name);
> -               return -EINVAL;
> -       }
> +       if (regulator_name_is_unique(dev, uc_pdata->name))
> +               return 0;
>
> -       /*
> -        * In case the regulator has regulator-always-on or
> -        * regulator-boot-on DT property, trigger probe() to
> -        * configure its default state during startup.
> -        */
> -       if (uc_pdata->always_on || uc_pdata->boot_on)
> -               dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
> +       debug("'%s' of dev: '%s', has nonunique value: '%s\n",
> +             property, dev->name, uc_pdata->name);
>
> -       return 0;
> +       return -EINVAL;
>  }
>
>  static int regulator_pre_probe(struct udevice *dev)
> @@ -483,6 +473,8 @@ static int regulator_pre_probe(struct udevice *dev)
>                                                 -ENODATA);
>         uc_pdata->max_uA =3D dev_read_u32_default(dev, "regulator-max-mic=
roamp",
>                                                 -ENODATA);
> +       uc_pdata->always_on =3D dev_read_bool(dev, "regulator-always-on")=
;
> +       uc_pdata->boot_on =3D dev_read_bool(dev, "regulator-boot-on");
>         uc_pdata->ramp_delay =3D dev_read_u32_default(dev, "regulator-ram=
p-delay",
>                                                     0);
>         uc_pdata->force_off =3D dev_read_bool(dev, "regulator-force-boot-=
off");
> diff --git a/test/dm/regulator.c b/test/dm/regulator.c
> index 449748ad52f..59cdd6a3e98 100644
> --- a/test/dm/regulator.c
> +++ b/test/dm/regulator.c
> @@ -186,7 +186,8 @@ int dm_test_power_regulator_set_enable_if_allowed(str=
uct unit_test_state *uts)
>
>         /* Get BUCK1 - always on regulator */
>         platname =3D regulator_names[BUCK1][PLATNAME];
> -       ut_asserteq(-EALREADY, regulator_autoset_by_name(platname, &dev_a=
utoset));
> +       ut_asserteq(-EALREADY,
> +                   regulator_autoset_by_name(platname, &dev_autoset));
>         ut_assertok(regulator_get_by_platname(platname, &dev));
>
>         /* Try disabling always-on regulator */
> @@ -288,7 +289,8 @@ static int dm_test_power_regulator_autoset(struct uni=
t_test_state *uts)
>          * Expected output state: uV=3D1200000; uA=3D200000; output enabl=
ed
>          */
>         platname =3D regulator_names[BUCK1][PLATNAME];
> -       ut_asserteq(-EALREADY, regulator_autoset_by_name(platname, &dev_a=
utoset));
> +       ut_asserteq(-EALREADY,
> +                   regulator_autoset_by_name(platname, &dev_autoset));
>
>         /* Check, that the returned device is proper */
>         ut_assertok(regulator_get_by_platname(platname, &dev));
> --
> 2.43.0
>

It seems that I have found a fix for this issue. Simon, please test
this commit https://gitlab.com/clamor-s/u-boot/-/commit/6149722aa48f84d9ea0=
37ae990141a231106244e
