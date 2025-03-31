Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5574C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 14:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12E2781E60;
	Mon, 31 Mar 2025 16:07:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VjgcilQK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 269F481E6C; Mon, 31 Mar 2025 16:07:46 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F67A81E47
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 16:07:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-30549dacd53so1634731a91.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 07:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743430060; x=1744034860; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/1pLH+v9BB2PVyPKTZeNJdMLs9MBdUbL1AsPdTapCAA=;
 b=VjgcilQKrf/c7dBdZZCLArF781H/IRUrmAXUBcWNtZjWZrFqYZ7iNcIyYhZ3WNUncW
 BfQP1bkrZjj2TxPEB93EeSC+W51ejU/7j5FTnqU8xi4f7GM460pWwpOXmzJ4fGybbI++
 FnONkHKcLW2XPTHfcIS9RPZIWdSqYjaE5Y+r3pmUMO+xKij34q+dU6M3EjsY1mv0VM4R
 UQyXwEuXss0iriAETwliedV+FRc8SI33JHnW/l4HOaWAS8th4bvS4HWwvzkkhh1Ynupa
 9F7NoU+lVcnasdyQSLuM+HUKb/7KBteCDQPSTOtaUvLyRXsMeasxELMVI+SQux80OIVw
 Vlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743430060; x=1744034860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/1pLH+v9BB2PVyPKTZeNJdMLs9MBdUbL1AsPdTapCAA=;
 b=U6WP1MsSkAqN6xJ6P7G7VcgKvgvZJQXo72DSWi8w3JD2Z+jvfLA+3kfrzWMg6fbcOr
 je/bL4VSKYBexOCSu4/5UptUoOyEChxonowNGNr2OT30gGIOO7gmavVI7Vd5UInqneY4
 RAn0fqG+iwkPxBlY+Tj0slbXUJuxaoCbppHouRFJvP2TBaLW09O/ncTvXH6zR7OYoA2x
 GPY3Iz2UppT4ecWrpwDDjp5oiGDp4LlfpQ/G7ZVgJWPNuFRlEv0b/zn04SXDPYVEY9hO
 3n9XhmRxJST6Vas99qp7WiJHqjMJv+l7T6PAe3cxKO1aE3l9tCYv67mZZaytG1GUFR+l
 JRxQ==
X-Gm-Message-State: AOJu0YyuXBIKRzIx017OngJgC1epaKFK6GkLptTrml1qH6TTS2TLHHz8
 PaJ2T7EIJiVria+PfDCcgnS2uqbRtuN9OrsWBU+C5Nhsr1iJ4u2F+7ErZkgeLyltGjAZgOqWcAN
 mgfeeohrdlGyrpUZRr2ZUAxiZyYRROwkxLjTQuw==
X-Gm-Gg: ASbGncsnd32OLM54YIQGp+IFfl8bknuhz60g1L0lt/YG8+4gLIkVscoYtGwS3PxFRAV
 xeK5Ti6N4Zw2FFYn84UIoTFhoNZ3kBbnCUpG2UURppwRNC7cP3jJDrNyrnE5LP5r7LX4iMp/prc
 G/J7/0pQpFwZM4XDpXOqtNGoYkvW+85PrdvIbgSvo=
X-Google-Smtp-Source: AGHT+IESXuiGZ9l8yqLUDrRmZxBVmfD5mPVcReSXBVbty90tWEEfu++NlwRa/FqbOyWtp9iZiKNwuayI/PGqhKdVp/s=
X-Received: by 2002:a17:90b:2750:b0:2f9:d0cd:3403 with SMTP id
 98e67ed59e1d1-305319f07admr14107553a91.16.1743430060637; Mon, 31 Mar 2025
 07:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250327231318.2713201-1-raymond.mao@linaro.org>
 <20250327231318.2713201-2-raymond.mao@linaro.org>
 <20250328235135.GF93000@bill-the-cat>
In-Reply-To: <20250328235135.GF93000@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 31 Mar 2025 10:07:29 -0400
X-Gm-Features: AQ5f1JpWNYSpte784l1De51r4Z4YsrreaMG0s36W553XIN9UiE4GydK7rKv-DoE
Message-ID: <CAEfUkU+ECBuGjGrNra0JXq71BtWGJ4uqMfDS9qxxaFrZ9qy9Rw@mail.gmail.com>
Subject: Re: [PATCH 2/2] env: point fdt address to the fdt in a bloblist
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ravi Minnikanti <rminnikanti@marvell.com>, Matthias Brugger <mbrugger@suse.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Fri, 28 Mar 2025 at 19:51, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Mar 27, 2025 at 04:13:17PM -0700, Raymond Mao wrote:
>
> > Point fdt_addr to the fdt embedded in the bloblist since fdt_addr
> > is a default address for bootefi, bootm and booti to look for the
> > device tree when launching the kernel.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  env/common.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/env/common.c b/env/common.c
> > index a58955a4f42..a38e5d107a8 100644
> > --- a/env/common.c
> > +++ b/env/common.c
> > @@ -16,6 +16,7 @@
> >  #include <asm/global_data.h>
> >  #include <linux/printk.h>
> >  #include <linux/stddef.h>
> > +#include <mapmem.h>
> >  #include <search.h>
> >  #include <errno.h>
> >  #include <malloc.h>
> > @@ -368,6 +369,18 @@ int env_get_default_into(const char *name, char *buf, unsigned int len)
> >       return env_get_from_linear(default_environment, name, buf, len);
> >  }
> >
> > +static int env_update_fdt_addr_from_bloblist(void)
> > +{
> > +     /*
> > +      * fdt_addr is by default used by booti, bootm and bootefi,
> > +      * thus set it to point to the fdt embedded in a bloblist if it exists.
> > +      */
> > +     if (!CONFIG_IS_ENABLED(BLOBLIST) || gd->fdt_src != FDTSRC_BLOBLIST)
> > +             return 0;
> > +
> > +     return env_set_hex("fdt_addr", (uintptr_t)map_to_sysmem(gd->fdt_blob));
> > +}
>
> This part is fine with me and makes enough sense, we can't do this
> immediately so we need some check to know to do it later.
>
> >  void env_set_default(const char *s, int flags)
> >  {
> >       if (s) {
> > @@ -392,6 +405,10 @@ void env_set_default(const char *s, int flags)
> >
> >       gd->flags |= GD_FLG_ENV_READY;
> >       gd->flags |= GD_FLG_ENV_DEFAULT;
> > +
> > +     /* This has to be done after GD_FLG_ENV_READY is set */
> > +     if (env_update_fdt_addr_from_bloblist())
> > +             pr_err("Failed to set fdt_addr to point at DTB\n");
> >  }
>
> I don't know this is the right spot. This won't work when for example
> the environment is valid but stored in a file on FAT (or whatever) will
> it?
>

I can add invoking 'env_update_fdt_addr_from_bloblist()' inside
'env_import()'. It should work in all the cases then.

Regards,
Raymond

> --
> Tom
