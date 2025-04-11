Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88009C369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 18:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA1C48420C;
	Fri, 11 Apr 2025 20:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eSQNkLFH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E85082B70; Fri, 11 Apr 2025 20:27:57 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB3182B30
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 20:27:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-abbb12bea54so448050766b.0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 11:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744396074; x=1745000874; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Llr963Miw0KpCh7paush0KNQ9dCej96YT3m1WLvDnUU=;
 b=eSQNkLFHH/qSGfSCGATG+ESA+V0i4hofc386zpKEsRAcNvezEFcs3tvPxIA7TI3Svc
 YgdBY+IHQQ6mbgp111+D1pIxtcderxAU2zMNoI3FdvWPycAzgh6tsC0d9OnmClsr4w7H
 rIcfufrgr+kFquA28ZbsgLzbCyo5VmMKIohB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744396074; x=1745000874;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Llr963Miw0KpCh7paush0KNQ9dCej96YT3m1WLvDnUU=;
 b=X4g6vyi7Fsk9B1UFDbnT0ul3QsrRbqLDQOOz2/1pb5DM3kSQikog1eptcUOsb6DZhT
 SoaZfpqrbO6/eyclp1DbK8AWpWAyIw0pYC7pI7e3xpycccoWXV/gJX7wtjAyw4bmlebV
 8gUk4N8iv4Uxa0FBRhA827gRc4cSVuH3HPZThk30Q+M03zKlOHvTXTER7IqOPlgarBVW
 glechtWjmPgRU8KDT5nny5PGlxk4tarM8dBTjVGLpQSQ5oscRDq459+Iwe5jPyab8Yay
 zbGcNkXx8Atbb2UuL9IesXC0Zwvm/QiAbWAVD9hmOo52N5VmTKvm5zKEGPaijEsApY/B
 M/NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4yupvOmLQum5Pc3H4CeQ/i52UbIHqdRZFM3BNa4ALSFPNJ8rk+LqEa3BvqP2Ndbw7FRLQar0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz15m4C75Hiv1m4qEMwkKVkK0WPBpB4/Tjd4lxcU4fBVZCIGZGv
 k8zkGkkzehDgJbgyM3dC0XYsuJwavm7IFFzXyx+aB27fqDlkoH65sllBVJsnk40Xb8KVX6oGGy9
 EolNa2rwSbHqk8V3+GFZbDnNYgAAF/KtuPwtqzfNVTvWD/OY=
X-Gm-Gg: ASbGncuqk1FFKKLmiO/K8bFbp0B3SFV8Eoq06CKSmX3J2XqDnd/IuAm/+EaDvWT6DD7
 D6LeQVQ6VJOGLyhpW8p8QF7I1T6T7MV6vqw+dtmwhSq5Sf+o3LjJRNDd8gLGd5zAfNqDvStNH2X
 uLrd4JaJdw0CzyLdWwrIPGOTE=
X-Google-Smtp-Source: AGHT+IEJT+uBPHJlL26TJa5R9Ig0yc6FyOl6J11HJTpMG3EtywFA8tcwzqglij8Kdc72OeSpUqrwCONi9sj1bFCwmDI=
X-Received: by 2002:a17:907:1c15:b0:ac8:1798:a796 with SMTP id
 a640c23a62f3a-acad36c22femr389203666b.54.1744396074072; Fri, 11 Apr 2025
 11:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
 <20250411-livetree-fixup-v2-1-1236823377bb@linaro.org>
In-Reply-To: <20250411-livetree-fixup-v2-1-1236823377bb@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 11 Apr 2025 12:27:41 -0600
X-Gm-Features: ATxdqUFwssGHhv16sM-KYVSuJoVFXAPwKILpT1EmxomB6y2A96JoS-zY1MiMA-A
Message-ID: <CAFLszTg9d97fFaosbCfQqCyBHivfn00S01_0wK9mB3RXZ7VbRA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] event: signal when livetree has been built
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

On Fri, 11 Apr 2025 at 06:47, Caleb Connolly <caleb.connolly@linaro.org> wrote:
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
>  common/event.c  |  3 +++
>  include/event.h | 18 ++++++++++++++++++
>  lib/of_live.c   | 11 +++++++++++
>  3 files changed, 32 insertions(+)
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
> index 75141a192a48b0931667632f41be8ff4d6139f7c..1d267f1d10547642d381fa287ab4981a2bf03543 100644
> --- a/include/event.h
> +++ b/include/event.h
> @@ -152,8 +152,17 @@ enum event_t {
>          * A non-zero return value causes the boot to fail.
>          */
>         EVT_MAIN_LOOP,
>
> +       /**
> +        * @EVT_OF_LIVE_BUILT:
> +        * This event is triggered immediately after the live device tree has been
> +        * built. This allows for machine specific fixups to be done to the live tree
> +        * (like disabling known-unsupported devices) before it is used. This
> +        * event is only available if OF_LIVE is enabled and is only used after relocation.

Add a bit more detail, e.g.: before it is used by U-Boot
post-relocation. This means it is possible to affect the devices bound
by driver model.

You should also note that the flattree is inactive when livetree is
used and any changes may eventually be passed onto the OS, if it
doesn't have its own devicetree. This is the point we were discussing
on the other thread.

> +        */
> +       EVT_OF_LIVE_BUILT,
> +
>         /**
>          * @EVT_COUNT:
>          * This constants holds the maximum event number + 1 and is used when
>          * looping over all event classes.
> @@ -202,8 +211,17 @@ union event_data {
>         struct event_ft_fixup {
>                 oftree tree;
>                 struct bootm_headers *images;
>         } ft_fixup;
> +
> +       /**
> +        * struct event_of_live_built - livetree has been built
> +        *
> +        * @root: The root node of the live device tree
> +        */
> +       struct event_of_live_built {
> +               struct device_node *root;
> +       } of_live_built;
>  };
>
>  /**
>   * struct event - an event that can be sent and received
> diff --git a/lib/of_live.c b/lib/of_live.c
> index 90b9459ede313e492e28c8556c730f3bd8aaa9df..c1620616513c2e32448b4a6d156a9162d97c76b7 100644
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
> @@ -320,8 +321,9 @@ int unflatten_device_tree(const void *blob, struct device_node **mynodes)
>
>  int of_live_build(const void *fdt_blob, struct device_node **rootp)
>  {
>         int ret;
> +       union event_data evt;
>
>         debug("%s: start\n", __func__);
>         ret = unflatten_device_tree(fdt_blob, rootp);
>         if (ret) {
> @@ -334,8 +336,17 @@ int of_live_build(const void *fdt_blob, struct device_node **rootp)
>                 return ret;
>         }
>         debug("%s: stop\n", __func__);
>
> +       if (CONFIG_IS_ENABLED(EVENT)) {
> +               evt.of_live_built.root = *rootp;
> +               ret = event_notify(EVT_OF_LIVE_BUILT, &evt, sizeof(evt));
> +               if (ret) {
> +                       log_debug("Failed to notify livetree build event: err=%d\n", ret);
> +                       return ret;
> +               }
> +       }
> +

This should move to the caller of this function. We should also have a
sandbox test for this feature, e.g. catch the event and add a
node/prop and check in a test in test-fdt.c (or similar) that it is
present.

I'm not sure if you need to update test_event_dump.py but since CI
presumably passes, I guess not.

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
