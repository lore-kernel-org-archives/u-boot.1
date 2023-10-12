Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49381CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 15:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0A1B86E42;
	Thu, 12 Oct 2023 17:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BG6Mjvkt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D53786E5E; Thu, 12 Oct 2023 17:28:42 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0398186C78
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 17:28:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-533c5d10dc7so1990962a12.3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697124516; x=1697729316; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fvZlHnwZXleMaafp9owXXODYTKW/EYKiWAQzz6tyKy8=;
 b=BG6MjvktaQCRjgVm2LGZZQdRw6zY2yqwcbpFH8duEF5D4ab9fpWalmBeFn4yAtqvtG
 Wey+r7Xt9LTitNzzac6Usob2amGx60GxYYSktogGnQkxvXMVpjcVVsZnXYtGuZ9zjOtg
 5dc/Gdk/9tqQOxkmQzA0QJb93IsTa85+5nLww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697124516; x=1697729316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fvZlHnwZXleMaafp9owXXODYTKW/EYKiWAQzz6tyKy8=;
 b=wJcvO5BQCisIMNsOuNC0kHsnPwJVr1WxJi98C4CqLYAkbVBtPpZ/S6n39LWx2ZkTSO
 O+y0PAgE19/LTLAk9kSavrBg4QOkC7+xM8nMuau/HBkscrfIPhFNPOpNQOTSr6DGm0fP
 YQ+OpPBmQugMuD7qXXGvn7KMQXeM7ayWvnLj8fZraT0qLgSrhM94icbzVyssCNGDaA1u
 Hk0OWovUdAIGnyHLaI4eVMVxtitoJouKlk/O6+tZBz1GckVN7x9hLDFbXbtuF08YufG6
 hjiadDJ1ZKfcDM9iYeqEKURNYxDwJnvACHZzRzLtlc7jUeE06nm+NBpNUM3m5lFvmvlC
 CGVw==
X-Gm-Message-State: AOJu0YwW287GIWKk6ZwLyj4p2iL9nhy7D6L4gkelwT4uTVm8DtP8I2US
 gYCJpgNaUvnnT1wjSnBKBuMGVOje3x6CqFdtHbO4mYf8h7lFpLdFelE=
X-Google-Smtp-Source: AGHT+IGqNtlmcxtx892pAYROEqIiOGrLJLOFuy3nnejr3L4EvwedfhgyCbmzcu47SVWMr41bPeNNl740CCd/2P3Iz2k=
X-Received: by 2002:a17:906:ce:b0:9b2:a078:4461 with SMTP id
 14-20020a17090600ce00b009b2a0784461mr20523775eji.44.1697124516417; Thu, 12
 Oct 2023 08:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-4-seanga2@gmail.com>
 <CAPnjgZ2RWZZbQMfF9_KUN+FsoVGoHKPq_sJ9=1GorNkrftwmbA@mail.gmail.com>
 <96125bdb-8363-62a6-1702-53b4bb63dea2@gmail.com>
In-Reply-To: <96125bdb-8363-62a6-1702-53b4bb63dea2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 12 Oct 2023 08:28:25 -0700
Message-ID: <CAPnjgZ0zAuJySerOn=tc+U6c_d_zY3DCqtkB9wZJZV+aV8Od_A@mail.gmail.com>
Subject: Re: [PATCH 03/26] spl: fit: Fix entry point for SPL_LOAD_FIT_FULL
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Marek Vasut <marex@denx.de>
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

Hi,

On Wed, 11 Oct 2023 at 21:28, Sean Anderson <seanga2@gmail.com> wrote:
>
> On 10/11/23 23:41, Simon Glass wrote:
> > On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
> >>
> >> The entry point is not always the same as the load address. Use the value
> >> of the entrypoint property if it exists and is nonzero (following the
> >> example of spl_load_simple_fit).
> >>
> >> Fixes: 8a9dc16e4d0 ("spl: Add full fitImage support")
> >> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> >> ---
> >>
> >>   common/spl/spl_fit.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > The check for 0 makes me uneasy, but I can't imagine it being valid in practice.
>
> This is mostly to match spl_load_simple_fit:
>
>         /*
>          * If a platform does not provide CONFIG_SYS_UBOOT_START, U-Boot's
>          * Makefile will set it to 0 and it will end up as the entry point
>          * here. What it actually means is: use the load address.
>          */
>
> SYS_UBOOT_START doesn't seem to be set very often and defaults to TEXT_BASE. That
> appears to be undefined on
>
>         efi-x86_app64 efi-x86_app32 xtfpga 3c120 10m50
>
> but none of these platforms define SPL_LOAD_FIT. So maybe this is moot?

Yes, it should be fine.

Regards,
Simon


>
> --Sean
>
> >
> >>
> >> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> >> index ce6b8aa370a..e3cdf8e5c05 100644
> >> --- a/common/spl/spl_fit.c
> >> +++ b/common/spl/spl_fit.c
> >> @@ -884,8 +884,10 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
> >>                  return ret;
> >>
> >>          spl_image->size = fw_len;
> >> -       spl_image->entry_point = fw_data;
> >>          spl_image->load_addr = fw_data;
> >> +       if (fit_image_get_entry(header, ret, &spl_image->entry_point) ||
> >> +           !spl_image->entry_point)
> >> +               spl_image->entry_point = fw_data;
> >>          if (fit_image_get_os(header, ret, &spl_image->os))
> >>                  spl_image->os = IH_OS_INVALID;
> >>          spl_image->name = genimg_get_os_name(spl_image->os);
> >> --
> >> 2.37.1
> >>
>
