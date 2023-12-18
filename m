Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DE2C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 15:05:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC14687E78;
	Mon, 18 Dec 2023 16:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I8SUzTMi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A63A687E6C; Mon, 18 Dec 2023 16:03:01 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C271C87E66
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:02:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-dbd4a10735eso163288276.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 07:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702911775; x=1703516575; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+xdujjdt0UduLCNYyDZcsiPjCg+Bw2EPQb5nRFNYgbo=;
 b=I8SUzTMirlBHCOtBQAab4v7sl1as6qEdNZjPGDNF3h6/wWrxLiMZT1k0Qb1D4pIwWj
 QwHoA0G5YjhdBt7G+xufbZhFnHXubn2NKJItijiS14QfNqcL5qD9OA8RcstuSTfRWr/q
 n89bR1dnpvhpLwHux0xdKQgTRc7GfXdXkVFF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702911775; x=1703516575;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+xdujjdt0UduLCNYyDZcsiPjCg+Bw2EPQb5nRFNYgbo=;
 b=Gk3nr71MHycNkwItysp2XLUqmme2uNU1ASQTzRNxxmeWcOSoQN6MI5Hap/ZQCzJ7vs
 QOhbs96hmladx95WqrXkE7R2jIwakIKcuYuCIeYrpFziMpcJZTKVwctnI2wegs2DC7Rb
 8LBLap9eZY/wK2mIOXvB6Cf+R0WJJg8JAUzIWUVVel1tzO13piBoJY6YCg9+lT/DJcZC
 99J2v8JPHvj8oSrvzJFM6GJkqyqDXljsBaHr9eUu23TpvEGw0mXzHK/6Xl63cqHYbYDM
 cFXHa8TzySDv/lLeotj0f6xF3NiM9KS7Md+61xCqCU/31JVPiHWqxtyYYAkbErtsFCyK
 aFuA==
X-Gm-Message-State: AOJu0Yzz+/bPLiOpIfwoeNpf5FBEjxbw90Zk1Wn1n9yo6BrLz4vVdNn8
 YiXVR7/fENYYXeqtPEySvpxvaEdbfQRiqd82xo7OLg==
X-Google-Smtp-Source: AGHT+IEOABzbdyvLfDNf0Sk8jS2GGaJBW+bKYMeSuIaMaFkLCOGQzHx/bhktE1+ROjf7e1/Tx5e76sCtXIcrzZKO43E=
X-Received: by 2002:a25:cdc7:0:b0:dbc:ea09:b545 with SMTP id
 d190-20020a25cdc7000000b00dbcea09b545mr3205993ybf.111.1702911775267; Mon, 18
 Dec 2023 07:02:55 -0800 (PST)
MIME-Version: 1.0
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-2-ilias.apalodimas@linaro.org>
 <CAPnjgZ2Vo22gasW05um2og==yRoC33YB3eW=xXVt2dE9xqDgVw@mail.gmail.com>
 <CAC_iWjJE=-rOhOLVe4d7sUH8DEJjn5hdHoHpKe70d4gmB7---Q@mail.gmail.com>
 <CAC_iWjLrmk2AwxoO8tDtG8notrLQuSdRtqzLpTzBRuM1QO0wzw@mail.gmail.com>
In-Reply-To: <CAC_iWjLrmk2AwxoO8tDtG8notrLQuSdRtqzLpTzBRuM1QO0wzw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 18 Dec 2023 08:01:53 -0700
Message-ID: <CAPnjgZ3XXtD24cqn1eEtZu0rxuJz4DR8vttu2YDwes3_ToJNkQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] smbios: Simplify reporting of unknown values
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, sean.anderson@seco.com, neil.armstrong@linaro.org, 
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl, 
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
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

Hi Ilias,

On Wed, 6 Dec 2023 at 04:36, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> [...]
>
> >
> >>
> >> >                 str = "Unknown";
> >> >
> >> >         for (;;) {
> >> > @@ -151,8 +151,7 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
> >> >                 const char *str;
> >> >
> >> >                 str = ofnode_read_string(ctx->node, prop);
> >> > -               if (str)
> >> > -                       return smbios_add_string(ctx, str);
> >> > +               return smbios_add_string(ctx, str);
> >> >         }
> >> >
> >> >         return 0;
> >> > @@ -231,7 +230,7 @@ static int smbios_write_type0(ulong *current, int handle,
> >> >         t->vendor = smbios_add_string(ctx, "U-Boot");
> >> >
> >> >         t->bios_ver = smbios_add_prop(ctx, "version");
> >> > -       if (!t->bios_ver)
> >> > +       if (!strcmp(ctx->last_str, "Unknown"))
> >>
> >> That is really ugly...checking the ctx value looking for a side effect.
> >>
> >> Can you not have smbios_add_prop() continue to return NULL in this case?
> >
> >
> > Hmm I don't know, but I wonder why I am not just checking t->bios_ver for Unknown.
> > I'll have a look and change it
>
> Ok, this can't be changed as easily.  smbios_add_prop() will not
> return NULL in any case. It returns an integer. With the cleanup, it
> will always writes 'Uknown' and not return 0 anymore.
> I can add that default value you suggested but the ctx->last_str is
> still used on the next line anyway.

Would you mind if I tried to create a version of the patch which does
the same thing but with less code, and perhaps a test? It might be
easier to discuss it then. I can't claim to understand all the
different code paths at this point.

My main concern is that with so many code paths it will be hard even
to refactor the code in the future, since it will become
'load-bearing' and anyone might turn up and say it breaks their board
because different information is provided.

Overall, so long as the information isn't used for anything important
in userspace, and we find a way to report SMBIOS to Linux without EFI,
it is OK to enable this feature (with a new Kconfig so it can be
disabled). But there is already authoritative info in the DT, so this
transformation into SMBIOS really should just be used for user
display, etc., not for anything which affects operation of the device.
Do you agree? If you do, how to ensure that? Perhaps a special string
in the table like 'GENERATED'?

Regards,
Simon
