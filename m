Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6945D711B4
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 15:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 197C988FCE;
	Wed, 20 Nov 2024 16:33:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PtMgGEL0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C5B588FCE; Wed, 20 Nov 2024 16:33:49 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 057FA87042
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 16:33:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa4d257eb68so204389266b.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 07:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732116826; x=1732721626; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f66R/EP6scfpsBTr58+aROqQ47pohJLVtmXUZyK5Z/U=;
 b=PtMgGEL0bNPAUcor6J7MOxWjClWdlbyHmdbAAyjbj4FzFIuPtvI5lUMo1BfA2jCktW
 xOC60gKKn19jNTUscdTcwUmjfnKoDTc+ZrZrivyixQpfjTniSB7Nmlc3wm3uLOC+PhxT
 pEluY7CWZ0J5CrIp7KU6wqaz7QamdwlG9vkqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732116826; x=1732721626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f66R/EP6scfpsBTr58+aROqQ47pohJLVtmXUZyK5Z/U=;
 b=wKmETkr69wx3Ssdzo1K3b2PIqQihPUr4LGypc/TJ7foM2Sgi8lYumdYoYlUWXjxGfT
 o0+ExwJXuergGHtT+8ryx2btvAwFSR3zfUt9kP7bkfsUTsFKyFe6ewWDjsdZNXCOqyIM
 C8O7NI0VDULFEqI+AgYJlhjfB+QIQQfzCvQj4hnnfpJ55N8M6uibRlETwk9CWd17Lxll
 eervcGHWpKc6Zq5XBP+nDreCw6lRhq7WFaPcuFEapUGYb7JS25BqvYcMDvh1yJY63fmU
 xeSahc/KOFRzXzM6VOLCpQnIT6KDjV+zWO66oXgNI3iJmfechjgGijWtszOTfKpaVIdq
 7KJw==
X-Gm-Message-State: AOJu0YwJ48aS6PZzYuGFfbDA2CryO0SgK2HcChMacdDZjAki5faJE6n+
 cVK6JpmV5CRHH7yFn/MC0Vi/e+UnQOsapMpZAJ5tb+vVShXCqh+1xKGhEEAAOf3r5hSwp/MYHyc
 3rxIpa3sG+wy9w3CMxFMeG2J96KEwNHB/UkoKbskGexwcEtU=
X-Google-Smtp-Source: AGHT+IGactKOBY4D3trok9GY9bCkbyvuEDmDtYXmQXJJuk99j3D347tLV/7EBVx9LHp2LOs2rafoo64bPBsyezNcbPQ=
X-Received: by 2002:a17:906:dac9:b0:a99:f777:c6ef with SMTP id
 a640c23a62f3a-aa4dca2d9e7mr333346966b.3.1732116826475; Wed, 20 Nov 2024
 07:33:46 -0800 (PST)
MIME-Version: 1.0
References: <20241119131844.4078144-1-sjg@chromium.org>
 <20241119131844.4078144-13-sjg@chromium.org>
 <20241120145033.GB3600562@bill-the-cat>
In-Reply-To: <20241120145033.GB3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 08:33:34 -0700
Message-ID: <CAFLszTibZMkhfbpH3RMVfRgS9TJ4rzZW4PBD7BtkRqpOfhNzCQ@mail.gmail.com>
Subject: Re: [PATCH 12/39] bootm: Allow building bootm.c without
 CONFIG_SYS_BOOTM_LEN
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Tom,

On Wed, 20 Nov 2024 at 07:50, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Nov 19, 2024 at 06:18:17AM -0700, Simon Glass wrote:
>
> > This code cannot be compiled by boards which don't have this option. Add
> > an accessor in the header file to avoid another #ifdef
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  boot/bootm.c    | 8 ++++----
> >  include/bootm.h | 8 ++++++++
> >  2 files changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/boot/bootm.c b/boot/bootm.c
> > index 16a43d519a8..0a1040ef923 100644
> > --- a/boot/bootm.c
> > +++ b/boot/bootm.c
> > @@ -633,11 +633,11 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
> >       load_buf = map_sysmem(load, 0);
> >       image_buf = map_sysmem(os.image_start, image_len);
> >       err = image_decomp(os.comp, load, os.image_start, os.type,
> > -                        load_buf, image_buf, image_len,
> > -                        CONFIG_SYS_BOOTM_LEN, &load_end);
> > +                        load_buf, image_buf, image_len, bootm_len(),
> > +                        &load_end);
> >       if (err) {
> > -             err = handle_decomp_error(os.comp, load_end - load,
> > -                                       CONFIG_SYS_BOOTM_LEN, err);
> > +             err = handle_decomp_error(os.comp, load_end - load, bootm_len(),
> > +                                       err);
> >               bootstage_error(BOOTSTAGE_ID_DECOMP_IMAGE);
> >               return err;
> >       }
> > diff --git a/include/bootm.h b/include/bootm.h
> > index c471615b08c..d174f18ac18 100644
> > --- a/include/bootm.h
> > +++ b/include/bootm.h
> > @@ -89,6 +89,14 @@ struct bootm_info {
> >  #define bootm_x86_set(_bmi, _field, _val)
> >  #endif
> >
> > +static inline ulong bootm_len(void)
> > +{
> > +#ifdef CONFIG_SYS_BOOTM_LEN
> > +     return CONFIG_SYS_BOOTM_LEN;
> > +#endif
> > +     return 0;
> > +}
> > +
> >  /**
> >   * bootm_init() - Set up a bootm_info struct with useful defaults
> >   *
>
> This kind of change is wrong in that it moves a build time failure to a
> (potentially non-obvious) runtime failure. If we're moving to now
> dynamically allocating the location where we can decompress to, then it
> should be part of that abstraction. But that doesn't look to be the case
> here.

Yes, sure. The right answer is probably to split out parts of bootm.c
into a new file. I already have 39 patches...it needs a bit more
thought.

Regards,
SImon
