Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418A5CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 08:34:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C270983AEC;
	Tue, 11 Nov 2025 09:34:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ua4viDCx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F56783E4C; Tue, 11 Nov 2025 09:34:02 +0100 (CET)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B54983AB4
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 09:34:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-640f88b873bso457789d50.3
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 00:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762850039; x=1763454839; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=393irxKGcuQmHr3OGh0/fJV/cDse8CsCVOKLTiHkcAA=;
 b=Ua4viDCxYnYsFHwKq7WAOATAugFAZ6u+/+HnXtQ2XyyxVaxaxKYUBz7YMRT2kfeIIR
 S/uYzguzK+skXfZrznci4ymOte7xFXuZ0xm1DcdBexBC1DHDOWG0M/cZT81IWXavyPQw
 wechfORNDp0Xhyak1fVIecDM5rqVwNtuaZNFqfenM3sCJQhBP15arZTj9nbQ7D9YsOjF
 Hqovrnxd0vdejgLGfmsFFG9fB66Y//woBplPZRXOrY+DOti90x9UeWgZw/SWXA0Saq5R
 bHr/aFayUFCQ1DUaO6ACJiPwYYG5lGfIvwAxlp9SSfVKDop8tnKIOdxVskVxTzVFa3vy
 Y76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762850039; x=1763454839;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=393irxKGcuQmHr3OGh0/fJV/cDse8CsCVOKLTiHkcAA=;
 b=EWn8ndXzdFGKZSuVizcaX+a0dgSrQmtYni1un7d4jyhOSzi5CClwIwi4rFRv3rnioM
 2XoFURQIcvXWDFJUiA+pOo412Yn0JzBgtk3a9pu1KYnJeJcz8VUxcwTQvZU+gs+L20NJ
 R4FH0ttJr2kqk+jNcRm9DoVRgOOJrUsIKgK6T8AcgmSaR1CBTAB39BAoEjEqjBkt4PDi
 B8NFSCTFUSiMkDdMJw6B26uIQpt1QciRkCDz0wjXIPime+W1+1tjNgIWOE8pGnTG+KI9
 /KfZVrumhcY2NXbC+lYZTuYVNwfZDwZXQlYG+mCA3BTkwIgvSqtUBNhtaJ1C38F7IfcO
 Eo5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb2/vrOm/h4CZ01kxEOqwoyk4/VkBdSWKpxi0ZOsbrDoVW+RWcUh5ErcpkUq/lqZGVFw2/Z34=@lists.denx.de
X-Gm-Message-State: AOJu0Yxzd1lcCwrSqu8xo8mn+iBCYzEbYJWBuPhy2OoVSH4gnrx583q+
 EcfN6vBforLdgu3GhPvIxYk1rs/6oKiV4FYe/5VP2yz5yGKCaHaxs6Lq7YVn9pFTJIeJhAKvVk/
 kyn8M43oN2wM1es9P0VNnbi1fPlBAhI0yy/6d5N0xmg==
X-Gm-Gg: ASbGncsuUlXYpvqoHCYllmhZd/q4NGbE0/xSyYKDlazNMLD54sBlZO1KO/KYWJ2uVMP
 GNvJfRyKmLViz6zKtl4HvN+znfMSZGkdqrro6nUTPCEF1ZOsYjYstnn4ec+pImDnPMwcbf55qOn
 VivA2uWy1j8fXZHoWEfwu8uKRq/0WpOQTfBmMiIs68Q7sW+68yC4iyTF1fe4wiDpGbmuv3u4CjZ
 Dq+RbPCzmss3r7ta9k/1IKhqrPsERLX0H79sOO2bXIOHDdQCcK0iUDLv4A0E7fWgMyiC3IhJWUt
 70zCcJA2UQsvDkAzMQN54REn8dleCBkfCKEL8h8w
X-Google-Smtp-Source: AGHT+IFstWYZtbr0Krtcz4MM2KZrXBSHRyvOP+32boQ7P9NqkPYe7m8MQZ36HK1OxQm3Lmdz9kwtujBznX9lI/Q2Ouw=
X-Received: by 2002:a05:690e:1610:b0:63f:95dd:b2c9 with SMTP id
 956f58d0204a3-640d45fed2dmr7889138d50.58.1762850039042; Tue, 11 Nov 2025
 00:33:59 -0800 (PST)
MIME-Version: 1.0
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251109101010.306268-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Nov 2025 10:33:22 +0200
X-Gm-Features: AWmQ_bksGwNnSkVjopzGKsY167CCfvHfJZ6zygXJW-X-zsAFvSsRzou1kuG0blM
Message-ID: <CAC_iWjLWTrtqT3K=uryYunnDD-wmYhQ1ufZ70E4Ts+ufU=_JTw@mail.gmail.com>
Subject: Re: [PATCH 2/9] test: cmd/fdt: do not assume RNG device exists
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>, 
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

On Sun, 9 Nov 2025 at 12:10, Heinrich Schuchardt
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

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
