Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE3FCE7B01
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 12:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6480C840E0;
	Fri, 14 Nov 2025 13:44:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ki0+fFE3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61D06840DF; Fri, 14 Nov 2025 13:44:43 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FE6F840E0
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 13:44:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-340c39ee02dso1730602a91.1
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 04:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763124279; x=1763729079; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PYHOG/0V1Q0Oy8uPqQI5vsan1bRI1RgOymKQxC82lOk=;
 b=ki0+fFE3esOnUf8ggJEIYaFRUpcfAcuW0eCeBREVtmiUvAJeYuFN948kV2in+t1baV
 5J9lcRUhi8wZc19pYtB24w2H8bddpgkFkOdqRrVSGP2A5JeEfkJjsdT5wlxW7JW6MCuj
 zfBYQKLX/0MlMClmQmmcZzAE1Qjgj/kNH/LoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763124279; x=1763729079;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYHOG/0V1Q0Oy8uPqQI5vsan1bRI1RgOymKQxC82lOk=;
 b=ENDG5epnSMhUawsDPX+BIhHRg1Xk0HGw21ShxnP7pWahVMUud9yehcevj4Snu8OZNu
 iG/X4x8cF3oLdMorw/rzM0a49UvJaZef1MLhkNXWmEKwWMk7GfMmUexP6dVmxIo/K4dA
 BjuNezgvrPWSbO6xdN0NUTZI77m6WRifGBoXEvG6MkfG3LfCK+yRL39kZDP78lR2PSoP
 CFm/uiG1r0O6OPYxMArojN5FDjH7Tl8hz+SgjFbSn1MKBs1a9Ma6qZ7vcjNkTUMZlRq6
 TuTpPApmee1FaoLOe+6CAPUHZpHgBf2szFnapB+apxD+0sYj+d9eoPFKGETM45L++H6g
 wB2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWArnuinBM3m8MOGf5JxpCF9gjSiiUIR+UqUl5y6bQb1Skkc0crQtayErp9WgIP1qNJEFAuckw=@lists.denx.de
X-Gm-Message-State: AOJu0YzP/mztVVFQ/M+ocOTCsXdVB5jZuGp8TibU2uSJ8PqaN6xfYycO
 XvccnX5M8y7kufv2AwSGcWYfKry19lsgn3rOssTBPf7UkOEoxVDXL+HD8zxfxziHgJ9e0Dqr4rA
 FfvwoZrPItHwthRr12NVa95QCs+FkSywnkfnsPAkG
X-Gm-Gg: ASbGnctzzzTvpgfxUkAQq2ujccpVCnxFvVIxWeEYa+MPelTjmugXQc8UWHg8fs6r7t5
 OU+BZrKXZb2ZR1JYis5m5dotMtbwYtPVaUTDC/fnMZGb0FcADxyD5tEhRWienQc+qMfOYsF0r8q
 OFq6XhM5FB4g+41O4HGZQOT7YEO1I4GZOBTjOX+bTmo8zURKvlp7Tahi36mFQrXDarCDQuiG0Ls
 Tl7kBj0485FNRhdSQokUf+btPvtnRgY+OdrRGAnmBYOdAKXBCChWcr5uDaJhNjaZa/xf6nWf1M4
 InFZ
X-Google-Smtp-Source: AGHT+IHW4QsQPbE6ftHuExyjNebx14vWknzLj5cZhgonbMykSZ5i8qMK/4/LNPQiSKaX/y0UeyVrHCN3WrDtCN+sKWo=
X-Received: by 2002:a17:90b:4e90:b0:340:a1a8:eb87 with SMTP id
 98e67ed59e1d1-343fa793c83mr3179190a91.35.1763124279593; Fri, 14 Nov 2025
 04:44:39 -0800 (PST)
MIME-Version: 1.0
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251109101010.306268-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Nov 2025 05:44:08 -0700
X-Gm-Features: AWmQ_bkTEz1XwQURO6CTClQDOhYdKIDDjd9JpK4N0QOSxN5pdGG6dxSdhZDV2CI
Message-ID: <CAFLszTgy0enQW_G1rW0RDNVJa4TEK2fL-moY6RarRZ4xc_xH8w@mail.gmail.com>
Subject: Re: [PATCH 2/9] test: cmd/fdt: do not assume RNG device exists
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Harrison Mutai <harrison.mutai@arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Rick Chen <rick@andestech.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Sun, 9 Nov 2025 at 03:10, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> In fdt_test_chosen() currently we test if DM_RNG is configured.
> CONFIG_DM_RNG=y does not imply that a RNG device actually exists.
> For instance QEMU may be called with -device virtio-rng-device or not.
> The current test framework evicts the virtio RNG device even if QEMU is
> called with -device virtio-rng-device.
>
> In the fdt_test_chosen() check if a RNG device exists.
> Ignore 'No RNG device' messages.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/cmd/fdt.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
> index a36f2dcdda8..b950123b6da 100644
> --- a/test/cmd/fdt.c
> +++ b/test/cmd/fdt.c
> @@ -10,6 +10,7 @@
>  #include <fdt_support.h>
>  #include <mapmem.h>
>  #include <asm/global_data.h>
> +#include <dm/uclass.h>
>  #include <linux/libfdt.h>
>  #include <test/ut.h>
>
> @@ -1267,6 +1268,7 @@ static int fdt_test_chosen(struct unit_test_state *uts)
>  {
>         const char *env_bootargs = env_get("bootargs");
>         char fdt[8192];
> +       struct udevice *dev;
>         ulong addr;
>
>         ut_assertok(make_test_fdt(uts, fdt, sizeof(fdt), &addr));
> @@ -1280,11 +1282,16 @@ static int fdt_test_chosen(struct unit_test_state *uts)
>         /* Test add new chosen node without initrd */
>         ut_assertok(run_commandf("fdt chosen"));
>         ut_assertok(run_commandf("fdt print /chosen"));
> -       ut_assert_nextline("chosen {");
> +       ut_assert(0 < console_record_readline(uts->actual_str,
> +                                             sizeof(uts->actual_str)));
> +       if (!strcmp("No RNG device", uts->actual_str))
> +               ut_assert(0 < console_record_readline(uts->actual_str,
> +                                                     sizeof(uts->actual_str)));

But then this test isn't really making sure that the RNG code works.
We need to know whether there is supposed to be a device (as you do
below), rather than making the test vague.

For sandbox, we can assert that the device exists, so at least we keep
some coverage.

> +       ut_asserteq_str("chosen {", uts->actual_str);
>         ut_assert_nextlinen("\tu-boot,version = "); /* Ignore the version string */
>         if (env_bootargs)
>                 ut_assert_nextline("\tbootargs = \"%s\";", env_bootargs);
> -       if (IS_ENABLED(CONFIG_DM_RNG) &&
> +       if (!uclass_get_device(UCLASS_RNG, 0, &dev) &&
>             !IS_ENABLED(CONFIG_MEASURED_BOOT) &&
>             !IS_ENABLED(CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT))
>                 ut_assert_nextlinen("\tkaslr-seed = ");
> @@ -1294,7 +1301,12 @@ static int fdt_test_chosen(struct unit_test_state *uts)
>         /* Test add new chosen node with initrd */
>         ut_assertok(run_commandf("fdt chosen 0x1234 0x5678"));
>         ut_assertok(run_commandf("fdt print /chosen"));
> -       ut_assert_nextline("chosen {");
> +       ut_assert(0 < console_record_readline(uts->actual_str,
> +                                             sizeof(uts->actual_str)));
> +       if (!strcmp("No RNG device", uts->actual_str))
> +               ut_assert(0 < console_record_readline(uts->actual_str,
> +                                                     sizeof(uts->actual_str)));
> +       ut_asserteq_str("chosen {", uts->actual_str);
>         ut_assert_nextline("\tlinux,initrd-end = <0x%08x 0x%08x>;",
>                            upper_32_bits(0x1234 + 0x5678 - 1),
>                            lower_32_bits(0x1234 + 0x5678 - 1));
> @@ -1303,7 +1315,7 @@ static int fdt_test_chosen(struct unit_test_state *uts)
>         ut_assert_nextlinen("\tu-boot,version = "); /* Ignore the version string */
>         if (env_bootargs)
>                 ut_assert_nextline("\tbootargs = \"%s\";", env_bootargs);
> -       if (IS_ENABLED(CONFIG_DM_RNG) &&
> +       if (!uclass_get_device(UCLASS_RNG, 0, &dev) &&
>             !IS_ENABLED(CONFIG_MEASURED_BOOT) &&
>             !IS_ENABLED(CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT))
>                 ut_assert_nextlinen("\tkaslr-seed = ");
> --
> 2.51.0
>

Regards,
Simon
