Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32C4C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 11:27:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B7EC839FA;
	Thu, 10 Apr 2025 13:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VVhkJ8qo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D065383A5C; Thu, 10 Apr 2025 13:27:39 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97343839B9
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 13:27:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5ed1ac116e3so1103492a12.3
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 04:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744284457; x=1744889257; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FCGKrRsqSeuEsRDg8xcGHjg7nIKM2xgTI4v5WP0VL7E=;
 b=VVhkJ8qokawL0dturCspV3pLgpnqAJt/l4AkVD5SJE4g8XtgGGCyPg++Ma5v8cOVFm
 Y4YA/ibmvwERZN4XC1jtpc18Es5v4m4Tbld+gdEl85w3yq20kZ0TB9uVi4bDdoLRQCOM
 oN0G1nuOoPwFc2M0J96Y+tZOKBhyoWWLz1jTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744284457; x=1744889257;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FCGKrRsqSeuEsRDg8xcGHjg7nIKM2xgTI4v5WP0VL7E=;
 b=l5Y9l9pQn71/u3b+lO4qKzZQXlmzigPMpiExdpqJG4gk74xFzAYrj+t0ztvyFKJDiG
 2LJxe8RrSFOFutmSZS25YA36jGpZTgdLdOhCFbU6H3+HGdZMM4o44U7xTZ4zMfX/4YIC
 xWVsSHE3KoB32nK+iQM71oyyQJbEFDuGxIB6FmBxq9DbLVXkG0d3XWYGj3xhD+QrnZnv
 ab6MhjeqaEEi9iI6Jyvh8EhYUiirsPQxdINcBocezBPPpq/47S6DktiRE9rGk+n7Nr3K
 euNQp0WkcT9AjpfxjA6QDpC4H5+Yyv+tWI1fKhiaXpCqb3JqyETUXYYGibOAyzW+BuL4
 BnIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw9OgBNcNsf7N0JDHae742QbWCIOz8BdJ/yhPChoCYyAHKG6nprTlkoV4vYObR1bbvTAAAZ4Y=@lists.denx.de
X-Gm-Message-State: AOJu0YxiAk0wLUZyH3ZuHBIoo7rJ2mMAxvZblGahd1/u1mGso+IPyXhi
 A/h70Eh6F4/8wQazAEwGIAlxvkrh6RgDayaTgy9tTc0r/fY7K1DHC/TSktl+7d176hiDmSmKsUs
 VZ3ahtvTSSDK3DxhkqJyFQReHqQ1yxtJkt/54
X-Gm-Gg: ASbGncsxXr3eYL315VI+JZR8V2HBmaZdteJQ+rqZphjk5OLC48qo+sprAjh9V5MGYSx
 B4hXslS+xptoEUzc9qw3oF96OF7LtcTmRjYe9jdesg7G575P5Hjb3S14te/hQb1ZkyjjseKBGNP
 d+S7AfFAV5cjNusA59C1nYdmYIkRnjNRRXIw==
X-Google-Smtp-Source: AGHT+IFMlNeRa/DeKUNG0phLp1bBpbjVxuPnf8JaIzbmYt+DKtQs7ozoXqlwKPp1S+9SgRWO6A3z7tW2dX3OUehGUYk=
X-Received: by 2002:a17:907:3f28:b0:ac7:ecfc:e5fa with SMTP id
 a640c23a62f3a-acabd4db30cmr215187166b.54.1744284456818; Thu, 10 Apr 2025
 04:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
 <20250409-livetree-fixup-v1-1-76dfea80b07f@linaro.org>
In-Reply-To: <20250409-livetree-fixup-v1-1-76dfea80b07f@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 10 Apr 2025 05:27:23 -0600
X-Gm-Features: ATxdqUG9r1l40pr2E6JkOytSfFpEcKP0ve9R7kvxcg_Oza-a_oQOwEaqbSVR4ZU
Message-ID: <CAFLszTjLGv0a3W=hPW+pexa1ASaSrrKAcbRoo5cF_LChj-bizA@mail.gmail.com>
Subject: Re: [PATCH 1/6] event: signal when livetree has been built
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

Hi Caleb,

On Wed, 9 Apr 2025 at 11:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> OF_LIVE offers a variety of benefits, one of them being that the live
> tree can be modified without caring about the underlying FDT. This is
> particularly valuable for working around U-Boot limitations like lacking
> USB superspeed support on Qualcomm platforms, no runtime OTG, or
> peripherals like the sdcard being broken (and displaying potentially
> worrying error messages).
>
> Add an event to signal when the live tree has been built so that we can
> apply fixups to it directly before devices are bound.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  common/event.c  | 3 +++
>  include/event.h | 9 +++++++++
>  lib/of_live.c   | 3 +++
>  3 files changed, 15 insertions(+)
>
> diff --git a/common/event.c b/common/event.c
> index dda569d447851f559a83f98fb7b1f3543156eab5..8d7513eb10b61919e1e784481dfdcc076be14986 100644
> --- a/common/event.c
> +++ b/common/event.c
> @@ -47,8 +47,11 @@ const char *const type_name[] = {
>         "ft_fixup",
>
>         /* main loop events */
>         "main_loop",
> +
> +       /* livetree has been built */
> +       "of_live_init",
>  };
>
>  _Static_assert(ARRAY_SIZE(type_name) == EVT_COUNT, "event type_name size");
>  #endif
> diff --git a/include/event.h b/include/event.h
> index 75141a192a48b0931667632f41be8ff4d6139f7c..3fc673ba635ed45467aae8587705d37bef1c2a3f 100644
> --- a/include/event.h
> +++ b/include/event.h
> @@ -152,8 +152,17 @@ enum event_t {
>          * A non-zero return value causes the boot to fail.
>          */
>         EVT_MAIN_LOOP,
>
> +       /**
> +        * @EVT_OF_LIVE_INIT:
> +        * This event is triggered immediately after the live device tree has been
> +        * built. This allows for machine specific fixups to be done to the live tree
> +        * (like disabling known-unsupported devices) before DM init happens. This
> +        * event is only available if OF_LIVE is enabled and is only used after relocation.
> +        */
> +       EVT_OF_LIVE_INIT,
> +
>         /**
>          * @EVT_COUNT:
>          * This constants holds the maximum event number + 1 and is used when
>          * looping over all event classes.
> diff --git a/lib/of_live.c b/lib/of_live.c
> index 90b9459ede313e492e28c8556c730f3bd8aaa9df..e1962b8f1fb9d8c2c87d04ca4e238a1e4d00376a 100644
> --- a/lib/of_live.c
> +++ b/lib/of_live.c
> @@ -10,8 +10,9 @@
>
>  #define LOG_CATEGORY   LOGC_DT
>
>  #include <abuf.h>
> +#include <event.h>
>  #include <log.h>
>  #include <linux/libfdt.h>
>  #include <of_live.h>
>  #include <malloc.h>
> @@ -334,8 +335,10 @@ int of_live_build(const void *fdt_blob, struct device_node **rootp)
>                 return ret;
>         }
>         debug("%s: stop\n", __func__);
>
> +       event_notify_null(EVT_OF_LIVE_INIT);
> +

This should go in initr_of_live() since the function you are dealing
with here is supposed to just do the live build.

Same for the EFI_STUB thing which I just noticed, actually

Also please check for error

Otherwise this seems OK to me. I do wonder why we can't use
EVT_FT_FIXUP though. Could you add mention of that to your comment in
event.h?

>         return ret;
>  }
>
>  void of_live_free(struct device_node *root)
>
> --
> 2.49.0
>

Regards,
Simon
