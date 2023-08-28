Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAE2C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 09:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D88F1864B9;
	Mon, 28 Aug 2023 11:33:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u0P/caM/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4023A86496; Mon, 28 Aug 2023 11:33:12 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5170C864B7
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 11:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52a1132b685so4260860a12.1
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 02:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693215189; x=1693819989;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vm4XvBsChWX8mGE2iW+BpAPwQrqgWsYao+m3GJM/L1I=;
 b=u0P/caM/jKHpfTUH9ovh1+GnUE5tlfOifY/e6z65ZlbOWNmeeLYWgKi3p9CAkdkEo5
 DAQUlS/Q6L9KOMld/q0iBT1TWQmk0Sr64g47yVr7jjtZgz0eHRmmkXtJAPqAFHD1xOwf
 5v5TgGB4kXulvzEEg2NP6YtLGolfFB/XlWGAD7a5w0kBBPTo2pL/IyV2W/lkkDjfng5X
 6n41xI1rDk7LOpT9oqbgBPeGnedU0YTpxaE6JeD+vHAKY2IKlyQI+oR5PV/mkRYyF5Tg
 3lZBNNWsd5imwlxOKOudFRd1sSxd5M/BjlpQfWuZU8tZ58uNzwS1G4rovt3pIsXZKIaJ
 Vf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693215189; x=1693819989;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vm4XvBsChWX8mGE2iW+BpAPwQrqgWsYao+m3GJM/L1I=;
 b=biCVnZ5bhvH9WWOSrQW2yyWRn5dgBdfEfTRQrSAYBjRaX6MvDogKoioiM87OOW2X7d
 M5MaWeaCVAP2rpnwt3e8dOcrrl851xIBXp49Id75m5dBR1JVi0E72oDvpdQwxzSA4wFN
 uHIJfKd9KzCaFArehrWi6D+Ke1vQO8N/JtviOBXdgWTDxXxdMJSAt/DbISPl5NM5whFj
 km2S14LfG/5PBYeiQXq4wK6ZSY76BLXiagoC92MyGNyCG2il/xIe2haoDkA+cVZ3davu
 aJ2LrwuJ27ijL20xSQ6Ngll+BM8CqGNRN5wWC6lMz80FX4FrOHbvXMbqUhYI7iFCHCbj
 Qghw==
X-Gm-Message-State: AOJu0YyRgGDP7qd3kBxq+Eto/iWOBr63c//fF9BJ4DKcncXUZQDijowu
 I+GxHxW+4RE0mnKwbuPlr8qxqvn2Bwu2ECcP1F0ytg==
X-Google-Smtp-Source: AGHT+IFTFEfg+ZTVYBafh2Z8JagNIAin22L2D/rlBsX/UD4OWUQTD1c/2cuBO1y/U/WkuM/BKVwvWRywUvHL4dpkggI=
X-Received: by 2002:aa7:d9cb:0:b0:51e:309:2e11 with SMTP id
 v11-20020aa7d9cb000000b0051e03092e11mr19871406eds.36.1693215188706; Mon, 28
 Aug 2023 02:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <20230826090633.239342-5-sughosh.ganu@linaro.org>
 <5c05f436-8c92-4b01-fcdf-ed9e0ec31d44@gmx.de>
In-Reply-To: <5c05f436-8c92-4b01-fcdf-ed9e0ec31d44@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 28 Aug 2023 15:02:57 +0530
Message-ID: <CADg8p97io5JX85MJj0U0U0sNCiC5D8bDjioe-fGwvEpPy7AUcg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] bootefi: Call the EVT_FT_FIXUP event handler
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Sat, 26 Aug 2023 at 15:57, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 8/26/23 11:06, Sughosh Ganu wrote:
> > The bootefi command passes the devicetree to the kernel through the
> > EFI config table. Call the event handlers for fixing the devicetree
> > before jumping into the kernel. This removes any devicetree nodes
> > and/or properties that are specific only to U-Boot, and are not to be
> > passed to the OS.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >   cmd/bootefi.c | 18 ++++++++++++++++++
> >   1 file changed, 18 insertions(+)
> >
> > diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> > index f73d6eb0e2..c359a46ec4 100644
> > --- a/cmd/bootefi.c
> > +++ b/cmd/bootefi.c
> > @@ -237,6 +237,23 @@ static void *get_config_table(const efi_guid_t *guid)
> >       return NULL;
> >   }
> >
> > +/**
> > + * event_notify_dt_fixup() - call ft_fixup event
> > + *
> > + * @fdt:     address of the device tree to be passed to the kernel
> > + *           through the configuration table
> > + * Return:   None
> > + */
> > +static void event_notify_dt_fixup(void *fdt)
> > +{
> > +     int ret;
> > +     struct event_ft_fixup fixup = {0};
> > +
> > +     fixup.tree.fdt = fdt;
> > +     ret = event_notify(EVT_FT_FIXUP, &fixup, sizeof(fixup));
> > +     if (ret)
> > +             printf("Error: %d: FDT Fixup event failed\n", ret);
> > +}
> >   #endif /* !CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE) */
> >
> >   /**
> > @@ -318,6 +335,7 @@ efi_status_t efi_install_fdt(void *fdt)
> >       efi_carve_out_dt_rsv(fdt);
> >
> >       efi_try_purge_kaslr_seed(fdt);
> > +     event_notify_dt_fixup(fdt);
>
> The event is already triggered in image_setup_libfdt(). Don't trigger it
> twice.

The reason I put an explicit event_notify call is because the
image_setup_libfdt() call only calls the ft_fixup handlers if the
livetree is not active. So the fixup handlers would not be called on
platforms that enable livetree. Although I'm not sure if livetree
should be disabled before the ft fixup has to happen, or platforms
that need ft fixup should not enable OF_LIVE. Disabling the livetree
is not happening now, so I am not sure how the fixup event should work
on platforms which have OF_LIVE enabled.

-sughosh

>
> Best regards
>
> Heinrich
>
> >
> >       if (CONFIG_IS_ENABLED(EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
> >               ret = efi_tcg2_measure_dtb(fdt);
>
