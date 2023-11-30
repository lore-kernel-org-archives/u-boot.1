Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E783C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 06:47:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D16D870AB;
	Thu, 30 Nov 2023 07:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lyAUPPQA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E2E487049; Thu, 30 Nov 2023 07:47:09 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CD148713D
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 07:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50bca79244fso868571e87.3
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 22:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701326826; x=1701931626; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pwIuFbfbwi7wcjrDE8Zx8yWvkssth5eeRZpF2B7CmaQ=;
 b=lyAUPPQA9Sv7GH8WO3LR5EGOKNoHrvlY4W8o5QRsCVIWiftaZOMnP/wjXHuLOcfx7Q
 76STZr6y1NXnwUYzRCIUxKhqbC+rszCprzku3jXbStmMCMtafGPn0yFwkbSyUGLgZe9S
 viuTRmhZqjrybki7tlccQbu9a9k9yGusuAagnGfyTGkpGceWzilpS3ifxPi8fanK4KQT
 XH0gPjiI4KVKq+sPYA45+0EFm4ODL0gU3xx7EQMXhuAQQcPKD+7Di1iZdzTbzb/jX3S5
 9jeXG41OUXqpX/dyVgxxPgnXVi2bFQ06bZJ9FoCiWticHzBkIusJQNlTeTawAqY54ifW
 OjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701326826; x=1701931626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pwIuFbfbwi7wcjrDE8Zx8yWvkssth5eeRZpF2B7CmaQ=;
 b=BS09EHBK498X4Zo38gGG+p3y4i6nKhNFW3XxqWpgZwhH/vy4mj43qQaNC21apZ5nkK
 MK8njDOb7u81IJc1ZcIHziJEKrtexqMdUS2MTNhHL072aKm+qF8ITrbfqRF+wSLHcPR7
 aT6XY/M5Lzo5p30KoQb7Oq5O843WZ6WvLiRWp5OKJGBO/xyx7ik4Ik5L6KbWTAwy269t
 2D8Dzx/RHvJJrBxpDJeVQAoOSYUQA0Y4PJa0GcpY3VCyaa1s+fdI+zJELH2mfZwD5kF1
 3rhXqPo5uQw5iwVcrGfyf/jetjwntVf4aLLU3863UqBpKrjzw8SEQIohyf7bC1/Y1E4C
 co9Q==
X-Gm-Message-State: AOJu0Ywrv3kdHUVvSWYeiOYtWV9W7mjZv+uOLlma1PwirKFccPMVqgM7
 gW5zoq4KVYf1V8dyMZ9TYXSbcQg/Mr9JbZkMnLCtpw==
X-Google-Smtp-Source: AGHT+IGV8a+YCaWNibW0qmDxuSJ5nfYFKsfpLu44RReqRBFXAOIXBgUDV91jjd6rLPnq6bFgLLTcdiy9BwLpy/l+t5M=
X-Received: by 2002:a2e:84c5:0:b0:2c6:ee51:87ab with SMTP id
 q5-20020a2e84c5000000b002c6ee5187abmr12704120ljh.35.1701326825570; Wed, 29
 Nov 2023 22:47:05 -0800 (PST)
MIME-Version: 1.0
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-2-ilias.apalodimas@linaro.org>
 <CAPnjgZ2Vo22gasW05um2og==yRoC33YB3eW=xXVt2dE9xqDgVw@mail.gmail.com>
In-Reply-To: <CAPnjgZ2Vo22gasW05um2og==yRoC33YB3eW=xXVt2dE9xqDgVw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 30 Nov 2023 08:46:29 +0200
Message-ID: <CAC_iWjJE=-rOhOLVe4d7sUH8DEJjn5hdHoHpKe70d4gmB7---Q@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] smbios: Simplify reporting of unknown values
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, sean.anderson@seco.com, neil.armstrong@linaro.org, 
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl, 
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
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

Hi Simon,


On Thu, 30 Nov 2023 at 04:46, Simon Glass <sjg@chromium.org> wrote:

> Hi Ilias,
>
> On Mon, 27 Nov 2023 at 10:11, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > If a value is not valid during the DT or SYSINFO parsing,  we explicitly
> > set that to "Unknown Product" and "Unknown" for the product and
> > manufacturer respectively.  It's cleaner if we move the checks insisde
> > smbios_add_string() and always report "Unknown" regardless of the missing
> > field.
> >
> > pre-patch dmidecode
> > <snip>
> > Handle 0x0001, DMI type 1, 27 bytes
> > System Information
> >         Manufacturer: Unknown
> >         Product Name: Unknown Product
> >         Version: Not Specified
> >         Serial Number: Not Specified
> >         UUID: Not Settable
> >         Wake-up Type: Reserved
> >         SKU Number: Not Specified
> >         Family: Not Specified
> >
> > [...]
> >
> > post-patch dmidecode:
> >
> > Handle 0x0001, DMI type 1, 27 bytes
> > System Information
> >         Manufacturer: Unknown
> >         Product Name: Unknown
> >         Version: Unknown
> >         Serial Number: Unknown
> >         UUID: Not Settable
> >         Wake-up Type: Reserved
> >         SKU Number: Unknown
> >         Family: Unknown
> > [...]
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> > Tested-by: Peter Robinson <pbrobinson@gmail.com>
> > ---
> > Changes since v1:
> > - None
> >
> >  lib/smbios.c | 17 +++--------------
> >  1 file changed, 3 insertions(+), 14 deletions(-)
> >
> > diff --git a/lib/smbios.c b/lib/smbios.c
> > index d7f4999e8b2a..fcc8686993ef 100644
> > --- a/lib/smbios.c
> > +++ b/lib/smbios.c
> > @@ -102,7 +102,7 @@ static int smbios_add_string(struct smbios_ctx *ctx,
> const char *str)
>
> I suggest that this function have an additional str property
> indicating the default string. Then you can pass DEFAULT_VAL or
> something like that, to each call.
>

Why? Do you think we need to fill in something different that "unknown"?


> >         int i = 1;
> >         char *p = ctx->eos;
> >
> > -       if (!*str)
> > +       if (!str || !*str)
>
> Does it ever happen that the string is present but empty?
>

With the changes on this patchset yes.


> >                 str = "Unknown";
> >
> >         for (;;) {
> > @@ -151,8 +151,7 @@ static int smbios_add_prop_si(struct smbios_ctx
> *ctx, const char *prop,
> >                 const char *str;
> >
> >                 str = ofnode_read_string(ctx->node, prop);
> > -               if (str)
> > -                       return smbios_add_string(ctx, str);
> > +               return smbios_add_string(ctx, str);
> >         }
> >
> >         return 0;
> > @@ -231,7 +230,7 @@ static int smbios_write_type0(ulong *current, int
> handle,
> >         t->vendor = smbios_add_string(ctx, "U-Boot");
> >
> >         t->bios_ver = smbios_add_prop(ctx, "version");
> > -       if (!t->bios_ver)
> > +       if (!strcmp(ctx->last_str, "Unknown"))
>
> That is really ugly...checking the ctx value looking for a side effect.
>
> Can you not have smbios_add_prop() continue to return NULL in this case?
>

Hmm I don't know, but I wonder why I am not just checking t->bios_ver for
Unknown.
I'll have a look and change it

[...]

Thanks
/Ilias
