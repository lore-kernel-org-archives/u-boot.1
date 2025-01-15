Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56C8E77188
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 01:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 840B78073F;
	Wed, 15 Jan 2025 02:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AT5aOhi5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B04C48072F; Wed, 15 Jan 2025 02:17:22 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95170806D6
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:17:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa6c0dbce1fso885725566b.2
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736903840; x=1737508640; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=txTyXqsjH4ySMyxJjcUOYl1e0+x0CDRl5YZIJIvDzNg=;
 b=AT5aOhi562HFSS5Xoh01e/x7ID+odkfTG26OV85Cwe+dvGqD6S6RVeXr28yYYj0arS
 UZfy9A2TfDj9tPNu9DHi5OTmf00M5ruinUV6yDEQ7tjNFBXRaV6JkL9Z9g2lPeVj7fTT
 8UxKdMi2WkAqup+IcsT7G908pq0PaTwfiNk7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736903840; x=1737508640;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=txTyXqsjH4ySMyxJjcUOYl1e0+x0CDRl5YZIJIvDzNg=;
 b=DFR9B2M6Et5iNAN8hCBHtLdU5N1Tw4/jKSlxXY0EbtaQn+hqeMu4yI8zsZW3a6TcWX
 ma2w7cjCCsiRHftUwiERhpTy5A9t6YX2S+9PMSRmy1PQwd/U1hekV1fXJBA2qdZoQwCH
 sWjnOSRLMAZpn10iADvo5a+SuphvwpxCF//R9J7e0czkjGeuPs/Dg9ICWQoTFvEvqves
 QdG2qvpXv/asCv9Pr092uC+ISLDm+Kfm3p8ZYdPc4BDtoSJlxnLwJK1vCD/6YUF7y0ye
 opQ+vsbV7ifUNtJHKUV9MESG4ub4YZ0Uf7K9DufXEh6CjaE//4oR4IG1E0cOIevNkatM
 UCig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV+RM+ImNUxLTYHjUFCyuII2KI0RAQYQiRaSLRFBBNy24VgozRX1JEk0U0S7aRhtxlHeaK8gE=@lists.denx.de
X-Gm-Message-State: AOJu0YznDogUIq8dA3lsLp7Ot1bXAczIe4RPbZ+0+40rJbr3cs8tdZGj
 PK6J3GTRECQwBNrk4vQps2zijmjk1GPDt2EEzGvWxC4oovD+TBglDovYfXyGn3yRHRSi9FONivh
 OWqlU//HCVIuPcTi8ENgWQP3Z+Runhl9HfzfUwoHX2K7ICbk=
X-Gm-Gg: ASbGncvhY+02Kz8CdWvnDDyaWbUfbwU5+mqNWCcsjmFzcEjv+AJi2OUmXHA6C0e3B4J
 gNCbBKJiEKQYMzcy4W4y60W3ArOdxSEJlhvTd6BU=
X-Google-Smtp-Source: AGHT+IEM2wH/yqMp/gy1io5pNcXVlM7F+r9lsSXTCd/FT6OrNf5D5Hder+e6G01JnMXisSdl19hr0KPfrWzqgfE2Quw=
X-Received: by 2002:a05:6402:26cf:b0:5d4:55e:f99e with SMTP id
 4fb4d7f45d1cf-5d972e1d7dfmr67001176a12.18.1736903840072; Tue, 14 Jan 2025
 17:17:20 -0800 (PST)
MIME-Version: 1.0
References: <20250112034213.13153-1-semen.protsenko@linaro.org>
 <20250112034213.13153-3-semen.protsenko@linaro.org>
 <97107163-de68-45dc-9462-c4f7cae06e31@gmx.de>
In-Reply-To: <97107163-de68-45dc-9462-c4f7cae06e31@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Jan 2025 18:17:07 -0700
X-Gm-Features: AbW1kvYSycPhOU3DblmAQfS78WUFCTXINYwm-CY44VBL-SzDq5AdwU9frZ7vigI
Message-ID: <CAFLszTj4Ezr5yZ+-7aUmAimy3zi1N5Vqsi0aqgX11H2CYiM+9Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] bootstd: Probe bootmeth devices for bootmeths env var
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Heinrich, Sam,

On Mon, 13 Jan 2025 at 00:40, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 1/12/25 04:42, Sam Protsenko wrote:
> > Specifying efi_mgr in 'bootmeths' environment variable leads to NULL
> > pointer dereference when 'bootflow scan' is executed, with call trace
> > like this:
> >
> >      priv->fake_dev // NULL pointer dereference
> >      .read_bootflow = efi_mgr_read_bootflow()
> >      bootmeth_get_bootflow()
> >      bootflow_check()
> >      bootflow_scan_first()
> >      do_bootflow_scan()
> >      'bootflow scan -l'
> >
> > That happens because in case when 'bootmeths' env var is defined the
> > bootmeth_efi_mgr driver is not probed, and the memory for its private
> > data isn't allocated by .priv_auto. In case when 'bootmeths' env var is
> > not defined, the std->bootmeth_count is 0, and the execution flow in
> > bootmeth_setup_iter_order() takes "no ordering" path, which in turn runs
> > uclass_get_device_by_seq() -> ... -> device_probe(), so issue isn't
> > present there. But when 'bootmeths' is defined and contains efi_mgr, the
> > std->bootmeth_count > 0, so bootmeth_setup_iter_order() follows the "we
> > have an ordering" path, where devices are not probed. In other words:
> >
> >      'bootmeths' defined           'bootmeths' not defined
> >      --------------------------------------------------------
> >      priv == NULL                    priv != NULL
> >           ^                                ^
> >           |                        device_alloc_priv()
> >       no probe                     device_of_to_plat()
> >           ^                        device_probe()
> >           |                        uclass_get_device_tail()
> >      dev = order[i]                uclass_get_device_by_seq()
> >           ^                                ^
> >           | have an ordering               | no ordering
> >           +----------------+---------------+
> >                            |
> >               bootmeth_setup_iter_order()
> >               bootflow_scan_first()
> >               do_bootflow_scan()
> >
> > Add an explicit device_probe() call in "we have an ordering" case to fix
> > the issue.
> >
> > Fixes: c627cfc14c08 ("bootstd: Allow scanning for global bootmeths separately")
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >   boot/bootmeth-uclass.c | 7 +++++++
> >   1 file changed, 7 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

> >
> > diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
> > index ff36da78d5a1..049389403191 100644
> > --- a/boot/bootmeth-uclass.c
> > +++ b/boot/bootmeth-uclass.c
> > @@ -11,6 +11,7 @@
> >   #include <bootmeth.h>
> >   #include <bootstd.h>
> >   #include <dm.h>
> > +#include <dm/device-internal.h>
> >   #include <env_internal.h>
> >   #include <fs.h>
> >   #include <malloc.h>
> > @@ -146,6 +147,12 @@ int bootmeth_setup_iter_order(struct bootflow_iter *iter, bool include_global)
> >                               struct bootmeth_uc_plat *ucp;
> >                               bool is_global;
> >
> > +                             ret = device_probe(dev);
> > +                             if (ret) {
> > +                                     ret = log_msg_ret("probe", ret);
> > +                                     goto err_order;
> > +                             }
>
> This would mean that we fail boot if probing one of the boot devices
> fails. Shouldn't we remove the device from the order instead?

It is actually a bootmeth failing to probe which causes problems, not
a bootdev. I think that is catastrophic enough that failing is fine,
at least for now.

Strictly speaking we should not probe the bootmeth until it is
actually used. One way to do this is to probe it in
bootflow_iter_set_dev(), or in its callers, where we already probe the
bootdev.

> > +
> >                               ucp = dev_get_uclass_plat(dev);
> >                               is_global = ucp->flags &
> >                                       BOOTMETHF_GLOBAL;
>

Regards,
Simon
