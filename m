Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE78D75E41
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 13:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26AC18982D;
	Fri, 22 Nov 2024 14:37:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OrnJTBfM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC0118982F; Fri, 22 Nov 2024 14:37:16 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 756828982C
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 14:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5cef772621eso2682579a12.3
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 05:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732282634; x=1732887434; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WhWLKAB9k94SwaJxJ9HodOQJ2LQEzTUeBpsZMqducLM=;
 b=OrnJTBfMzdDyeNzWuEX8IUpVyt1F8za8mvYghSxoneHvAzUgJZaadPKj15KM6vs3Ii
 9A2/Ufo8Nk2WZwpU1hHK7stS/PJg9RSFoboUo5l4pfW7GRikQgDVqZI8GP+ubmOyKrBo
 3EbnW2osQdlFrLeUNJUALxcjAfLwKvuWdYMmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732282634; x=1732887434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WhWLKAB9k94SwaJxJ9HodOQJ2LQEzTUeBpsZMqducLM=;
 b=anw3EsIgi1mBVwpBbPNAy77OLps0wr8Z5oAUAonFjZ/te8ax/aSfU7FHPDJbfKD0WE
 Sa31uW3a0R0dAG6Jpb0qoJihs4C3+TmK4Kxet75P2ngMu4km0ZfsAP7T3zJi4ueVbALR
 34ufXx3Jl6tnWRu1NbjsUQL2SxCZdG3e7jtfjjhrw5n93NF1r46eduR6eR2oI69eT40z
 b3qbWpWobjdkHvV2YrJDkJ7dn73rAOjNYlD63PdNxt2GtdNoYmoUwHMstqZaBgUrQYTY
 nlRZ1ygEuILz7SnXLQhMjqphffN/8Fk8xn/oVXOfjrmZKhF+org7MOH54+ymljDO4OCf
 6idw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEjjqXtLh5IFOFkBNzb14SIN0jnN5nOccyTXZLvyQ7tLYsERYUPc3JiK7nHQpjb1QEgEr/Ek0=@lists.denx.de
X-Gm-Message-State: AOJu0YypgB4EWftwLJ+88c3UVD8xaKT/WxBdb43uJPVtkfIuphvVX0Fr
 a3gu/ozaoEFu/hjkuVHVhE63JSiwdFhBtllCaWd21KCjwWpns5HBixramJUAqGYoSgWHFqzKhxF
 w+Nn6+PbnmDomDMcyTHfSpEgzk1KpAoWUcEt0yhzg3+JtU5Sf+A==
X-Gm-Gg: ASbGncvUp1FvrRVHcPgwAAG4YNAJqK1FD9fc/T4T0XrFJRB+JlPhb9WW0mjgsv4bIAd
 8dd990nolVuLJun3i3e7gWEQ0yK5DXPh4
X-Google-Smtp-Source: AGHT+IE9c/CVYX6n2Tl5vznSgnizP5azP5wrR2k5ZHEFNj/aT4L79mlkkReC2yTxnEIuF0GTbBIppARYTkFHodsohDk=
X-Received: by 2002:a17:906:cc9:b0:a9e:e1be:158 with SMTP id
 a640c23a62f3a-aa5099eb837mr265209466b.31.1732282633766; Fri, 22 Nov 2024
 05:37:13 -0800 (PST)
MIME-Version: 1.0
References: <20241121-bootstd-test-fix-multiple-bind-v1-1-f6c06b9581b1@baylibre.com>
In-Reply-To: <20241121-bootstd-test-fix-multiple-bind-v1-1-f6c06b9581b1@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Nov 2024 06:37:00 -0700
Message-ID: <CAFLszTjvoOSD+yADG9Oin__tKLs_W-TEkpZ3DPhtRCB4YxmhzQ@mail.gmail.com>
Subject: Re: [PATCH] test: boot: Bind bootmeth_{cros,
 android} only once per run
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Guillaume La Roque <glaroque@baylibre.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Mattijs,

On Thu, 21 Nov 2024 at 08:03, Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> We make fewer calls to dm_test_restore() since
> commit fbdac8155c89 ("test: Expand implementation of ut_list_has_dm_tests()")
>
> Because of this some valid test combinations are now broken:
>
> $ ./test/py/test.py --bd sandbox --build -k test_ut
> $ ./test/py/test.py --bd sandbox --build -k "bootflow_android or bootflow_cros"
>
> Shows:
>
>   Expected '  2  cros         ready   mmc          4 mmc5.bootdev.part_4       ',
>   got '  2  cros         ready   mmc          2 mmc5.bootdev.part_2       '
>
> Here prep_mmc_bootdev() is called twice and it will bind bootmeth_cros twice.
>
> Since bootmeth_cros is bound twice, 'bootflow scan' will find 2x the
> expected bootflows.
>
> Before
> commit fbdac8155c89 ("test: Expand implementation of ut_list_has_dm_tests()")
> this did not happen because a cleanup was called each time.
>
> Check if the bootstd already has a "cros" or "android" driver and only bind it
> if it does not exist.
>
> Fixes: fbdac8155c89 ("test: Expand implementation of ut_list_has_dm_tests()")
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
> Initially, this was found when merging some Android bootflow patches
> from [1].
>
> However, this can be reproduced on 'next' as well.
>
> Here is the test output that's broken (we have 4 cros bootmethods instead of 2)
>
> => ut bootstd bootflow_cros
> Test: bootflow_cros: bootflow.c
> Showing all bootflows
> Seq  Method       State   Uclass    Part  Name                      Filename
> ---  -----------  ------  --------  ----  ------------------------ ----------------
> 0  extlinux     ready   mmc          1  mmc1.bootdev.part_1 /extlinux/extlinux.conf
> 1  cros         ready   mmc          2  mmc5.bootdev.part_2
> 2  cros         ready   mmc          2  mmc5.bootdev.part_2
> 3  cros         ready   mmc          4  mmc5.bootdev.part_4
> 4  cros         ready   mmc          4  mmc5.bootdev.part_4
> ---  -----------  ------  --------  ----  ------------------------ ----------------
> (5 bootflows, 5 valid)
> test/boot/bootflow.c:1192, bootflow_cros(): console:
> Expected '  2  cros         ready   mmc          4 mmc5.bootdev.part_4       ',
> got '  2  cros         ready   mmc          2 mmc5.bootdev.part_2       '
> Test bootflow_cros failed 1 times
>
> [1] https://lore.kernel.org/r/all/87mshvxhq3.fsf@baylibre.com/
> ---
>  test/boot/bootflow.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index 9397328609d0..835d2e6e35a6 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -552,15 +552,21 @@ static int prep_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
>         /* Enable the cros bootmeth if needed */
>         if (IS_ENABLED(CONFIG_BOOTMETH_CROS) && bind_cros_android) {
>                 ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
> -               ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_cros),
> -                                       "cros", 0, ofnode_null(), &dev));
> +               /* Only bind the bootmeth once to avoid duplicate scan results */
> +               if (device_find_child_by_name(bootstd, "cros", &dev) == -ENODEV) {
> +                       ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_cros),
> +                                               "cros", 0, ofnode_null(), &dev));
> +               }
>         }
>
>         /* Enable the android bootmeths if needed */
>         if (IS_ENABLED(CONFIG_BOOTMETH_ANDROID) && bind_cros_android) {
>                 ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
> -               ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_android),
> -                                       "android", 0, ofnode_null(), &dev));
> +               /* Only bind the bootmeth once to avoid duplicate scan results */
> +               if (device_find_child_by_name(bootstd, "android", &dev) == -ENODEV) {
> +                       ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_android),
> +                                               "android", 0, ofnode_null(), &dev));
> +               }
>         }
>
>         /* Change the order to include the device */
>
> ---
> base-commit: dc1859f8d2ac3faaa5e2e1d465ec4bd8980520a5
> change-id: 20241121-bootstd-test-fix-multiple-bind-159bd2523414
>
> Best regards,
> --
> Mattijs Korpershoek <mkorpershoek@baylibre.com>
>

Instead of this, could you add flags to the test to tell it to reset
driver mode?

UTF_DM | UTF_SCAN_FDT

Regards,
Simon
