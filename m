Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA64C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 01:17:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFDA387191;
	Thu,  9 Nov 2023 02:16:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ko6/0lw0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE0138714A; Thu,  9 Nov 2023 02:16:05 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9F06871DF
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 02:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53e2308198eso426321a12.1
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 17:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699492548; x=1700097348; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TDc2P9XHwuKVUOcqFPIgc1X4bubakUOpgzcVoyUuyf4=;
 b=Ko6/0lw0apvX8FDVx1EdpGfBWtWfdNrj4Tulu5gQZC92mFn77z+xfCv4+AO1/PaYfv
 tSCY+XWt6F2a5aXwV+18TIwAoxL7X4pPy4O+T5hgNaFcCBpKbvfP0k3un2ua7zALVq39
 N0Yc8o6UFcbWywLfccCXyU0LE6OGAxuIvKDWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699492548; x=1700097348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TDc2P9XHwuKVUOcqFPIgc1X4bubakUOpgzcVoyUuyf4=;
 b=Uo0/wGRE/2+OFF+0hNMx/MFWMZ3zXQaS07iKsq/N/i0DbDIwrB/lnFRo/wloXSGiS2
 hBM2l4A26OpdXaK/iu+IKOxOQCD4M4R8guA8K+6BlKg2OQP/MiAxqD4FwP+rsMbpU3zo
 Ot/zx49uztXtSH0dxxgFTjptUFQ4NiZQHZCJsWCYw5g7G+bJjLVBBNSBXtsrqeMv5nl9
 ffQt3Ex2/5pxhrprNNXv9s6o6T5uCZL45RJuDy0I68K7F4S9I5eE/bBEzQFuGYcxG5pB
 QspVJlFhi/FZPUkqYS9Ffhw/P5TJwHeBF6WfH0/zu0HbfrvKGcStHmmnkS8KZhLjrwqp
 z8aA==
X-Gm-Message-State: AOJu0Yxo9lFGv8PkDx9GnowLTpymeC0XqtJJz+Stuy91QtpkDn9Zrnx2
 8veQPHQfyLe/KDq06tImZKA91w09l752oHezPza6UA==
X-Google-Smtp-Source: AGHT+IFj2ATR4J9Kzt+09rnTdtF/MMAq8pR05YPoJFx1zfGJyiSXGy+REyxf6STc4TDBh8GmJYBVZtlpRuGAO2NqjNA=
X-Received: by 2002:a50:9f6e:0:b0:53e:7781:2279 with SMTP id
 b101-20020a509f6e000000b0053e77812279mr2884547edf.36.1699492547764; Wed, 08
 Nov 2023 17:15:47 -0800 (PST)
MIME-Version: 1.0
References: <20231108085110.883-1-paul.barker.ct@bp.renesas.com>
In-Reply-To: <20231108085110.883-1-paul.barker.ct@bp.renesas.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Nov 2023 18:15:24 -0700
Message-ID: <CAPnjgZ2RYkw6toVcZ1S9dq4gFyxGWO=Yo31wV6dRyt1BBQALMw@mail.gmail.com>
Subject: Re: [PATCH] sysreset: Fix unsupported request return values
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Bin Meng <bmeng.cn@gmail.com>
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

On Wed, 8 Nov 2023 at 01:51, Paul Barker <paul.barker.ct@bp.renesas.com> wrote:
>
> The description of the sysreset request method in <sysreset.h> says that
> the return value should be -EPROTONOSUPPORT if the requested reset type
> is not supported by this device.
>
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>  drivers/sysreset/poweroff_gpio.c     | 2 +-
>  drivers/sysreset/sysreset_psci.c     | 2 +-
>  drivers/sysreset/sysreset_sandbox.c  | 4 ++--
>  drivers/sysreset/sysreset_watchdog.c | 2 +-
>  drivers/sysreset/sysreset_x86.c      | 2 +-
>  test/dm/sysreset.c                   | 6 +++---
>  6 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/drivers/sysreset/poweroff_gpio.c b/drivers/sysreset/poweroff_gpio.c
> index a5c24fd85bca..ad04e4b1a85e 100644
> --- a/drivers/sysreset/poweroff_gpio.c
> +++ b/drivers/sysreset/poweroff_gpio.c
> @@ -33,7 +33,7 @@ static int poweroff_gpio_request(struct udevice *dev, enum sysreset_t type)
>         int r;
>
>         if (type != SYSRESET_POWER_OFF)
> -               return -ENOSYS;
> +               return -EPROTONOSUPPORT;
>
>         debug("GPIO poweroff\n");
>
> diff --git a/drivers/sysreset/sysreset_psci.c b/drivers/sysreset/sysreset_psci.c
> index a8a41528a849..aa09d0b88271 100644
> --- a/drivers/sysreset/sysreset_psci.c
> +++ b/drivers/sysreset/sysreset_psci.c
> @@ -25,7 +25,7 @@ static int psci_sysreset_request(struct udevice *dev, enum sysreset_t type)
>                 psci_sys_poweroff();
>                 break;
>         default:
> -               return -ENOSYS;
> +               return -EPROTONOSUPPORT;
>         }
>
>         return -EINPROGRESS;
> diff --git a/drivers/sysreset/sysreset_sandbox.c b/drivers/sysreset/sysreset_sandbox.c
> index f485a1352993..c12eda81d03e 100644
> --- a/drivers/sysreset/sysreset_sandbox.c
> +++ b/drivers/sysreset/sysreset_sandbox.c
> @@ -21,7 +21,7 @@ static int sandbox_warm_sysreset_request(struct udevice *dev,
>                 state->last_sysreset = type;
>                 break;
>         default:
> -               return -ENOSYS;
> +               return -EPROTONOSUPPORT;
>         }
>         if (!state->sysreset_allowed[type])
>                 return -EACCES;
> @@ -70,7 +70,7 @@ static int sandbox_sysreset_request(struct udevice *dev, enum sysreset_t type)
>                         return -EACCES;
>                 sandbox_exit();
>         default:
> -               return -ENOSYS;
> +               return -EPROTONOSUPPORT;
>         }
>         if (!state->sysreset_allowed[type])
>                 return -EACCES;
> diff --git a/drivers/sysreset/sysreset_watchdog.c b/drivers/sysreset/sysreset_watchdog.c
> index ceada2e47b54..6db5aa75b541 100644
> --- a/drivers/sysreset/sysreset_watchdog.c
> +++ b/drivers/sysreset/sysreset_watchdog.c
> @@ -29,7 +29,7 @@ static int wdt_reboot_request(struct udevice *dev, enum sysreset_t type)
>                         return ret;
>                 break;
>         default:
> -               return -ENOSYS;
> +               return -EPROTONOSUPPORT;
>         }
>
>         return -EINPROGRESS;
> diff --git a/drivers/sysreset/sysreset_x86.c b/drivers/sysreset/sysreset_x86.c
> index 4936fdb76c72..dc772b5ff9e3 100644
> --- a/drivers/sysreset/sysreset_x86.c
> +++ b/drivers/sysreset/sysreset_x86.c
> @@ -87,7 +87,7 @@ static int x86_sysreset_request(struct udevice *dev, enum sysreset_t type)
>                         return ret;
>                 return -EINPROGRESS;
>         default:
> -               return -ENOSYS;
> +               return -EPROTONOSUPPORT;
>         }
>
>         outb(value, IO_PORT_RESET);
> diff --git a/test/dm/sysreset.c b/test/dm/sysreset.c
> index 691683c56740..5aa69e046186 100644
> --- a/test/dm/sysreset.c
> +++ b/test/dm/sysreset.c
> @@ -27,8 +27,8 @@ static int dm_test_sysreset_base(struct unit_test_state *uts)
>         /* Device 1 is the warm sysreset device */
>         ut_assertok(uclass_get_device(UCLASS_SYSRESET, 1, &dev));
>         ut_asserteq(-EACCES, sysreset_request(dev, SYSRESET_WARM));
> -       ut_asserteq(-ENOSYS, sysreset_request(dev, SYSRESET_COLD));
> -       ut_asserteq(-ENOSYS, sysreset_request(dev, SYSRESET_POWER));
> +       ut_asserteq(-EPROTONOSUPPORT, sysreset_request(dev, SYSRESET_COLD));
> +       ut_asserteq(-EPROTONOSUPPORT, sysreset_request(dev, SYSRESET_POWER));
>
>         state->sysreset_allowed[SYSRESET_WARM] = true;
>         ut_asserteq(-EINPROGRESS, sysreset_request(dev, SYSRESET_WARM));
> @@ -36,7 +36,7 @@ static int dm_test_sysreset_base(struct unit_test_state *uts)
>
>         /* Device 2 is the cold sysreset device */
>         ut_assertok(uclass_get_device(UCLASS_SYSRESET, 2, &dev));
> -       ut_asserteq(-ENOSYS, sysreset_request(dev, SYSRESET_WARM));
> +       ut_asserteq(-EPROTONOSUPPORT, sysreset_request(dev, SYSRESET_WARM));
>         state->sysreset_allowed[SYSRESET_COLD] = false;
>         ut_asserteq(-EACCES, sysreset_request(dev, SYSRESET_COLD));
>         state->sysreset_allowed[SYSRESET_COLD] = true;
>
> base-commit: e17d174773e9ba9447596708e702b7382e47a6cf
> --
> 2.39.2
>
