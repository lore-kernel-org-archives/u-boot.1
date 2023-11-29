Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31941C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 17:55:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86AA3875A7;
	Wed, 29 Nov 2023 18:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A9razKH4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49D6087784; Wed, 29 Nov 2023 18:55:46 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C6C086BA8
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50bc7706520so116924e87.3
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 09:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701280543; x=1701885343; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kgzuyvuTeBREZTboDcPVfMtTP2tmKDpC6OVGxsRK1Cc=;
 b=A9razKH4/XZZsi9/h3qtYd2TX2Of0WE2T7mw1RlSohjwyGfTvKHWRax5zS4cBsEC7j
 zo16CepZUp/fMw8D1ITaJFO2FSxM8PDaEMzJcAuI+lNYQux/SvMrgiOExyjAuL7Rj5w+
 Ka0HPgACm0+dtKOSsRm7rDeHPSe0wwFjbtydPTgaA9EEG73Z5nbQ7tIdfX4IKpEsPGUa
 E+k8hYKdBoHSYyxxO+S+LzExslzwxoeBeYMuSD1vQbeOm4CmL2JcuDqgtKw0NGyRa2pF
 jMN9+YMuVZPWsNrfHm2MjWo1Lylsik1398UezLFAAj1+ViNZYim2ANyLA5sH8nL72UI+
 N4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701280543; x=1701885343;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kgzuyvuTeBREZTboDcPVfMtTP2tmKDpC6OVGxsRK1Cc=;
 b=kzKnoSvkXIk8ZrqDAZPCJQiC6Fnz8Q8mpepjczfjB5neO7RyCRRo35coQQBq2/J7sN
 CUYraBpgzU8WO92RHYbUF+pjJtHI5V3H7cTqxEaUlyHKlwjjvgFKjgM7QxRw/qKpfSci
 JXTanch6KxoOc/EOuBnEu0Hd0/M9qAv4Rvg8OIcnhEdWwLh/ejQg5gA8LQS5z6AxjJx/
 qYMzDj6kWRtlOBVSaThLBw6s9w/uIYHSA5w+a5xYpZ2eaGgkBwrsz/iIzl3k/8nSJWE7
 qWZ5U6Ei7B3IslzJEmz83KNYT+KZPaFdqqPEdKCrDd0DGyN3KylsXgq3S9hcwC7R0TGZ
 bo7g==
X-Gm-Message-State: AOJu0YxaST4fAJETbdHTmoZqlR0DiYPEW4jV+GXuRrvQckQU1RdMT4Oq
 3dN03zRJhN9QkxmYcK9fksKp6pxLdfmySzgFEwNYew==
X-Google-Smtp-Source: AGHT+IEsML7ro1VJjk0Wro7qXtWwfkRL3I3DIrE50dYiruG12BdPMAb36gcD0Xr9rcM2QiaZauDT8jz0kFEVm0ViAgg=
X-Received: by 2002:a19:654b:0:b0:50b:c0cf:7408 with SMTP id
 c11-20020a19654b000000b0050bc0cf7408mr2822412lfj.18.1701280543178; Wed, 29
 Nov 2023 09:55:43 -0800 (PST)
MIME-Version: 1.0
References: <20231117020207.948636-1-seanedmond@linux.microsoft.com>
 <20231117020207.948636-3-seanedmond@linux.microsoft.com>
 <CAPnjgZ3F5AFLaAS66s43p1fFdK=PzTmkLd9BEzR1agQuHotjzQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ3F5AFLaAS66s43p1fFdK=PzTmkLd9BEzR1agQuHotjzQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 29 Nov 2023 19:55:07 +0200
Message-ID: <CAC_iWjJZ1TtzOjT5hW1cCgTW0t_2f9ONUphcQ+B9p9h0LfUucw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] fdt: kaslr seed from RNG device
To: Simon Glass <sjg@chromium.org>
Cc: seanedmond@linux.microsoft.com, u-boot@lists.denx.de, 
 dphadke@linux.microsoft.com, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Wed, 29 Nov 2023 at 19:47, Simon Glass <sjg@chromium.org> wrote:

> Hi Sean,
>
> On Thu, 16 Nov 2023 at 19:02, <seanedmond@linux.microsoft.com> wrote:
> >
> > From: Dhananjay Phadke <dphadke@linux.microsoft.com>
> >
> > Add support for KASLR seed from the RNG device. Invokes dm_rng_read()
> > API to read 8-bytes of random bytes.  Performs the FDT fixup using event
> > spy.  To enable use CONFIG_KASLR_RNG_SEED
> >
> > Signed-off-by: Dhananjay Phadke <dphadke@linux.microsoft.com>
> > Signed-off-by: Drew Kluemke <ankluemk@microsoft.com>
> > Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> > ---
> >  boot/fdt_support.c | 36 ++++++++++++++++++++++++++++++++++++
> >  lib/Kconfig        |  7 +++++++
> >  2 files changed, 43 insertions(+)
> >
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> > diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> > index 49d14a949be..12defcf645c 100644
> > --- a/boot/fdt_support.c
> > +++ b/boot/fdt_support.c
> > @@ -12,7 +12,10 @@
> >  #include <log.h>
> >  #include <mapmem.h>
> >  #include <net.h>
> > +#include <rng.h>
> >  #include <stdio_dev.h>
> > +#include <dm/device.h>
> > +#include <dm/uclass.h>
> >  #include <dm/ofnode.h>
> >  #include <linux/ctype.h>
> >  #include <linux/types.h>
> > @@ -650,6 +653,39 @@ int fdt_fixup_kaslr_seed(ofnode node, const u8
> *seed, int len)
> >         return 0;
> >  }
> >
> > +int fdt_rng_kaslr_seed(void *ctx, struct event *event)
> > +{
> > +       u8 rand[8] = {0};
> > +       struct udevice *dev;
> > +       int ret;
> > +       oftree tree = event->data.ft_fixup.tree;
> > +       ofnode root_node = oftree_root(tree);
> > +
> > +       ret = uclass_first_device_err(UCLASS_RNG, &dev);
> > +       if (ret) {
> > +               printf("ERROR: Failed to find RNG device\n");
> > +               return ret;
> > +       }
> > +
> > +       ret = dm_rng_read(dev, rand, sizeof(rand));
> > +       if (ret) {
> > +               printf("ERROR: RNG read failed, ret=%d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       ret = fdt_fixup_kaslr_seed(root_node, rand, sizeof(rand));
> > +       if (ret) {
> > +               printf("ERROR: failed to add kaslr-seed to fdt\n");
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +#if defined(CONFIG_KASLR_RNG_SEED)
>
> You could put this if() in the function above
>
>
> > +EVENT_SPY(EVT_FT_FIXUP, fdt_rng_kaslr_seed);
> > +#endif
> > +
> >  int fdt_record_loadable(void *blob, u32 index, const char *name,
> >                         uintptr_t load_addr, u32 size, uintptr_t
> entry_point,
> >                         const char *type, const char *os, const char
> *arch)
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 19649517a39..4f5dfc00d6f 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -477,6 +477,13 @@ config VPL_TPM
> >           for the low-level TPM interface, but only one TPM is supported
> at
> >           a time by the TPM library.
> >
> > +config KASLR_RNG_SEED
> > +       bool "Use RNG driver for KASLR random seed"
> > +       depends on DM_RNG
> > +       help
> > +         This enables support for using the RNG driver as entropy
> source for
> > +         KASLR seed populated in kernel's device tree.
> > +
> >  endmenu
> >
> >  menu "Android Verified Boot"
> > --
> > 2.42.0
> >
>

 Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
