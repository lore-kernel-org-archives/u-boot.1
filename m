Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF22C25B76
	for <u-boot@archiver.kernel.org>; Sat,  1 Jun 2024 04:39:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68541887F6;
	Sat,  1 Jun 2024 06:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HITdWU9K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D39F1887F6; Sat,  1 Jun 2024 06:39:22 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B19EA887E2
 for <u-boot@lists.denx.de>; Sat,  1 Jun 2024 06:39:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6f8d2ec8652so1634016a34.3
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 21:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717216759; x=1717821559; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XImtIIL393tB2fWjalqL5cReSbWdwMtr60k9rVny3aE=;
 b=HITdWU9KQd3POKfGfIHPGJ+SVmJTaaCKSt1jvn1evBQGxf4xzXnNKNu2vgzyaHX8dU
 E7MrHI3giX6uYxXwZpVEtTX/YQlGTgYU9NVfPukXsk8OZMJdTzz65MyItfEnRMo/CEox
 Bxcu0Pl/LvkW4HWkizDIT60apTqNMeAqCyB0uYBkGbGwKiEBx9Tr6nDenrdkzAXoYKtT
 MYANfORjjgn8mVinXKEYBdLSb+VoPPfNr3YuZ+3dHtZCyZu1gsE/+o9BXG0KMdIR7KMH
 R6f32SA8NlPM/zg5fCfDHp0mG2bCqvbsGTbNcfpbGzBA1poSi9fBA+fLNRjPXhYH6Uxr
 heOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717216759; x=1717821559;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XImtIIL393tB2fWjalqL5cReSbWdwMtr60k9rVny3aE=;
 b=Vam5ZdKQBciT+NExlIkkyPmfG5fAEKlNIiHBvbFv5CywbHZG1TnoQ6lvKnZK+wcLdl
 7cRyVagHfiek3cztQmPcwBAGS9y8vNxQ3gDiz6bgKfrZDSpHRjxZJTE76JjdDednCLrd
 HvIGe+r62JBzD22CdtK4PoojcFSM0RP0dRhDSb+T7SWyjZU/+2aBjzlzRC5o2w/nQ1c9
 vjuPFhda9Nz4zr4AjdzZ9Ft37ftiLWsw+Zvd+sDPGs7Glss+GZOm2nrEBYsJfWlLL8Zo
 PAKRz0BxLl/ZXoO8jTzlOFNGEvtDI/r76ZFYL1TFCmYbNRbNZYOxGbkKmdUGOIVIzyjY
 qNNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDCZZkUL0ECz0PorxyXvK0Qo/J9tsjCl42ePNDLF6WHBLWAFz8lTVYSNXg4+aZfKnYivu3p25OZJjdls9PPjWTCb6J9g==
X-Gm-Message-State: AOJu0YxbryiTBYzUTBPNMzf3GtWFAgWw9qvXSF/yQ147PK8uyxeMC/uq
 zxtEXYVBURB5W1+auXqRAtVepbM6SfFApSnGTHWfO+neOSZYJbK9dHOfrO5vsUyXHXqR99p9lMS
 7eZ7ofcs3QU4I+uRSzlaxQaos02w=
X-Google-Smtp-Source: AGHT+IGy0E5gE3zUlpQ/dfqfmLItG7qFaCcw40RGL/6+uaFe/ioLUMuKw9lIMVCKkvAbH7u5YXR8Zf+sWyG2cl/Iyck=
X-Received: by 2002:a05:6871:58a9:b0:24c:afec:f0a with SMTP id
 586e51a60fabf-2508ba91b97mr4290692fac.26.1717216759189; Fri, 31 May 2024
 21:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240531141837.13189-1-linux.amoon@gmail.com>
 <20240531141837.13189-23-linux.amoon@gmail.com>
 <99479aa4-6bdf-4265-b30f-ab571ec3adca@kwiboo.se>
In-Reply-To: <99479aa4-6bdf-4265-b30f-ab571ec3adca@kwiboo.se>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 1 Jun 2024 10:09:03 +0530
Message-ID: <CANAwSgQnHA4tMir+H48+T3Q2KTKW4o4dXofdgAQnFAYxjGYAaw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 22/23] sysreset: rockchip: use fst reset for ARM64
 SOC
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Anand Moon <anand@edgeble.ai>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jagan Teki <jagan@edgeble.ai>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
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

Hi Jonas

On Fri, 31 May 2024 at 22:14, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Anand and Kever,
>
> On 2024-05-31 16:18, Anand Moon wrote:
> > From: Kever Yang <kever.yang@rock-chips.com>
> >
> > Rockchip ARM64 SOC will change cpu entry, only fst reset can reset it.
>
> What is this trying to fix? And what SoCs is affected?
>
> My arm64 RK SoCs seem to reset using warm reset (second global reset).
>
I found this patch related to CRU so it was added in this series.
My goal is to test all the remaining SoC and see if any thing is missing
in my testing.

> >
> > Cc: Jagan Teki <jagan@edgeble.ai>
> > Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> > ---
> >  drivers/sysreset/sysreset_rockchip.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/sysreset/sysreset_rockchip.c b/drivers/sysreset/sysreset_rockchip.c
> > index f353f9b4c7..17aa191349 100644
> > --- a/drivers/sysreset/sysreset_rockchip.c
> > +++ b/drivers/sysreset/sysreset_rockchip.c
> > @@ -22,7 +22,12 @@ int rockchip_sysreset_request(struct udevice *dev, enum sysreset_t type)
> >
> >       switch (type) {
> >       case SYSRESET_WARM:
> > +#ifdef CONFIG_ARM64
> > +             /* Rockchip 64bit SOC need fst reset for cpu reset entry */
> > +             writel(0xfdb9, cru_base + offset->glb_srst_fst_value);
> > +#else
> >               writel(0xeca8, cru_base + offset->glb_srst_snd_value);
> > +#endif
>
> If this is needed maybe use something like this and let it fall through
> to SYSRESET_COLD?
>
>   if (!IS_ENABLED(CONFIG_ARM64)) {
>         writel(0xeca8, cru_base + offset->glb_srst_snd_value);
>         break;
>   }
>

Ok I will update this in next version

> Regards,
> Jonas
Thanks
-Anand
