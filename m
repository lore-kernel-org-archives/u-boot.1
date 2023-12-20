Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2AC4C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 08:25:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BBE38701C;
	Wed, 20 Dec 2023 09:25:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hNuzhob9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AF7B8744F; Wed, 20 Dec 2023 09:25:07 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACF9586FFE
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 09:25:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50e548e0bd6so187137e87.2
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 00:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703060702; x=1703665502; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TR1YEEjd81+0wONqJHaVnY1Ll/IhQ7kluYGQhwBaiXA=;
 b=hNuzhob9aBLx8f0wgtzhTmfpInzgXXzrTRGxbfjG9EwzVEvYU0cOlELhSQTBAVdhTn
 8WoHR6ssVDNUn8LJWM2FfPgBblE7A770phGEDi/3EjclCIWgxcHLKl6iFivkpw0oBMBF
 z4ByGeTT+Rfa66iaobyVxRKYAz8/06DrjUt/8J0voLtUQEwdMz5UYaobmtVBZs6n/3QT
 riHQ5xhDwH5M+gNxtMzCwt0AEdt6nRgRcD0n4IovxJwOw2VHr/AovWKbrcz7zOTLVkjk
 4Dx4ge763CIxwjbpCb00tsNu8IRGdefNiln0bDbtgjqD/ogKol+RsvMHbpYj3AA/e2sB
 enwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703060702; x=1703665502;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TR1YEEjd81+0wONqJHaVnY1Ll/IhQ7kluYGQhwBaiXA=;
 b=sz13iJUJB/cKRPhV5ztE4mIQ/+DfcCeLO3H9dEVHZ768G3K1aeGBkiVnRt4gigaKi+
 Dj/lEfo6Wo5YF3WhyH3qHiVRJrnwOkWUs2VscfFdX6L32EnQAf2r1n8KMKJZB9q8jJJh
 IhR3I7bnlquyvQe927gEgVHT+1gmQQaf1Uhf5B92r6S0cC7qI2I6RFfEqWW2aVOHDAmZ
 XhV5SRMJwbhfx7wkYwOFfNoRWiM0+Ws4zGRDLNuvHObUtTaI2l01H8Zy1W5hX/XIhDfT
 jzNTuQm8VqjNJI1Q2Xjlq4pMbT6XGCloFgOQUi4QlVsek/RshNwZExebM5tqL0Yb1+nd
 Z7Pw==
X-Gm-Message-State: AOJu0YxxqP2iMDSUE5zA88WJnPusAM2BLL5lmcojyIwLm1wpnbdK72Cf
 jMK4+PzFl/yNoYkovo3DvW+wrNdlL1Y8DFPtKWNvtw==
X-Google-Smtp-Source: AGHT+IHD4zhPrFdwNRUPs6SIi0Cz9EZ4sqxbw5f3M7C5G1FDJPwCe/ruK2ey9bb6oAsTuPn5ES+bULWU4Qmei+QQ1kg=
X-Received: by 2002:a19:e04b:0:b0:50e:34e3:abab with SMTP id
 g11-20020a19e04b000000b0050e34e3ababmr2473217lfj.18.1703060701970; Wed, 20
 Dec 2023 00:25:01 -0800 (PST)
MIME-Version: 1.0
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-2-ilias.apalodimas@linaro.org>
 <CAPnjgZ2Vo22gasW05um2og==yRoC33YB3eW=xXVt2dE9xqDgVw@mail.gmail.com>
 <CAC_iWjJE=-rOhOLVe4d7sUH8DEJjn5hdHoHpKe70d4gmB7---Q@mail.gmail.com>
 <CAC_iWjLrmk2AwxoO8tDtG8notrLQuSdRtqzLpTzBRuM1QO0wzw@mail.gmail.com>
 <CAPnjgZ3XXtD24cqn1eEtZu0rxuJz4DR8vttu2YDwes3_ToJNkQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ3XXtD24cqn1eEtZu0rxuJz4DR8vttu2YDwes3_ToJNkQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 Dec 2023 10:24:26 +0200
Message-ID: <CAC_iWjLk1=hbAvTje6oOZcayfQTvZ7sCu3TiXKGPpj-5W1Ou5Q@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] smbios: Simplify reporting of unknown values
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

The discussion is mostly on v3 now, so I assume this is outdated?

Thanks
/Ilias
On Mon, 18 Dec 2023 at 17:02, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Wed, 6 Dec 2023 at 04:36, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > [...]
> >
> > >
> > >>
> > >> >                 str = "Unknown";
> > >> >
> > >> >         for (;;) {
> > >> > @@ -151,8 +151,7 @@ static int smbios_add_prop_si(struct smbios_ctx *ctx, const char *prop,
> > >> >                 const char *str;
> > >> >
> > >> >                 str = ofnode_read_string(ctx->node, prop);
> > >> > -               if (str)
> > >> > -                       return smbios_add_string(ctx, str);
> > >> > +               return smbios_add_string(ctx, str);
> > >> >         }
> > >> >
> > >> >         return 0;
> > >> > @@ -231,7 +230,7 @@ static int smbios_write_type0(ulong *current, int handle,
> > >> >         t->vendor = smbios_add_string(ctx, "U-Boot");
> > >> >
> > >> >         t->bios_ver = smbios_add_prop(ctx, "version");
> > >> > -       if (!t->bios_ver)
> > >> > +       if (!strcmp(ctx->last_str, "Unknown"))
> > >>
> > >> That is really ugly...checking the ctx value looking for a side effect.
> > >>
> > >> Can you not have smbios_add_prop() continue to return NULL in this case?
> > >
> > >
> > > Hmm I don't know, but I wonder why I am not just checking t->bios_ver for Unknown.
> > > I'll have a look and change it
> >
> > Ok, this can't be changed as easily.  smbios_add_prop() will not
> > return NULL in any case. It returns an integer. With the cleanup, it
> > will always writes 'Uknown' and not return 0 anymore.
> > I can add that default value you suggested but the ctx->last_str is
> > still used on the next line anyway.
>
> Would you mind if I tried to create a version of the patch which does
> the same thing but with less code, and perhaps a test? It might be
> easier to discuss it then. I can't claim to understand all the
> different code paths at this point.
>
> My main concern is that with so many code paths it will be hard even
> to refactor the code in the future, since it will become
> 'load-bearing' and anyone might turn up and say it breaks their board
> because different information is provided.
>
> Overall, so long as the information isn't used for anything important
> in userspace, and we find a way to report SMBIOS to Linux without EFI,
> it is OK to enable this feature (with a new Kconfig so it can be
> disabled). But there is already authoritative info in the DT, so this
> transformation into SMBIOS really should just be used for user
> display, etc., not for anything which affects operation of the device.
> Do you agree? If you do, how to ensure that? Perhaps a special string
> in the table like 'GENERATED'?
>
> Regards,
> Simon
