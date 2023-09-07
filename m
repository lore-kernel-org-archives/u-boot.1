Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C77EC8720
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 12:24:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C28A3869A0;
	Thu,  7 Sep 2023 14:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YwHUGN5C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F7CA86863; Thu,  7 Sep 2023 14:23:41 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EF8E86907
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 14:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-58d70c441d5so9277147b3.2
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 05:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694089417; x=1694694217; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WRC94CdEpjPp1tSK5wU6zb48WEOcd6sJIioS3zR1h5s=;
 b=YwHUGN5CdpG1OetF2AwCIhs4EvxlDdeIZfAPZVkk8GYOr9kKamLUNH2X77vCHq9Lo2
 b1XO+5DYnmMFcLDvs5yUuACU56vRhGn3YcpCbS/Rr6DQqDzqsUmh5jTW5uO7w8fAd4/d
 PYHcS9BiZXepvZOpQ/KPgRZhCzfkldx6W7la0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694089417; x=1694694217;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WRC94CdEpjPp1tSK5wU6zb48WEOcd6sJIioS3zR1h5s=;
 b=V/E7Mq6N+GsXqMk3shSOLeF6CdMHIGeGqMnwrjkgpObSXtxFnjRQ1Q43+7/y++2Np1
 pqlnutORFvi3a8UBt00JTAZUSCpYXactAaglZgoBED+hjhLrYG11VJ1UMkj4Do1dm36K
 BBR3uXywxTRmODEomYuQhKDEtCGATWW2isdETs3xpQ8IMZx8+/w/TBz21cQrii0dJt+E
 8YlRH30v4kOHubZbWZU1+NEv1r1/nfBgjp6znCfVoRVV5OxVmK4/DEu3HIDZlonqBsKR
 6KMqgZboPdOE2Dtba7O2MC7xYdtGQDGISppTa9ysngIA3gKj5rW+ARVbgOWpKlhhIY2A
 wImg==
X-Gm-Message-State: AOJu0YxehUC0ApUoiE99gxrkC0q7GtivbMJTzjH1PMsd1xPVxf8QbO45
 TY6pFYn1NntCSyYa2mwTHl5B4vEa8Yg4Qzn8BfkakQ==
X-Google-Smtp-Source: AGHT+IHt4zWUfGyLM1wJdfsx1s+xSQPJxcWQePHz4GNY+QK1Jj2IyaQyL053Ob7jVbTUlgdkv4lzCqHFUM3glt50tLY=
X-Received: by 2002:a25:6b4a:0:b0:d62:ba45:539f with SMTP id
 o10-20020a256b4a000000b00d62ba45539fmr18560703ybm.43.1694089416805; Thu, 07
 Sep 2023 05:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230823184746.842091-1-sjg@chromium.org>
 <20230823184746.842091-7-sjg@chromium.org>
 <CAEUhbmVYRm0rHNkGj4TDR3NcGeOQY9iAqSj3JByx_cDg1FxC6w@mail.gmail.com>
In-Reply-To: <CAEUhbmVYRm0rHNkGj4TDR3NcGeOQY9iAqSj3JByx_cDg1FxC6w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Sep 2023 06:23:11 -0600
Message-ID: <CAPnjgZ1zF+++8_1QC54pKEZD3zJW76HqPyqYnXBXspXwd9QbPQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] x86: broadwell: Set up MTRRs
To: Bin Meng <bmeng.cn@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Bin,

On Mon, 4 Sept 2023 at 03:22, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Simon,
>
> On Thu, Aug 24, 2023 at 2:48=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > The current condition does not handle the samus_tpl case where it sets
> > up the RAM in SPL but needs to commit the MTRRs in U-Boot proper.
> >
> > Add another case to handle this and update the comment.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  arch/x86/lib/init_helpers.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/lib/init_helpers.c b/arch/x86/lib/init_helpers.c
> > index 60a2707dcf1..bf0c921577d 100644
> > --- a/arch/x86/lib/init_helpers.c
> > +++ b/arch/x86/lib/init_helpers.c
> > @@ -15,7 +15,8 @@ DECLARE_GLOBAL_DATA_PTR;
> >  int init_cache_f_r(void)
> >  {
> >         bool do_mtrr =3D CONFIG_IS_ENABLED(X86_32BIT_INIT) ||
> > -                IS_ENABLED(CONFIG_FSP_VERSION2);
> > +                IS_ENABLED(CONFIG_FSP_VERSION2) ||
> > +                (IS_ENABLED(CONFIG_TPL) && IS_ENABLED(CONFIG_HAVE_MRC)=
);
>
> So this combination is only for Samus TPL case, not a generic one, right?

It is certainly targeted at samus TPL, but in a way it is applicable
generically. When TPL is in use, we do the memory init in SPL and pass
the RAM into to U-Boot proper, so it sets up the MTRRs. This is the
same as the only other TPL board (coral). So samus and coral are in
common in this sense...with the different being that samus uses MRC
but coral usese FSP2.

>
> I hate this as it's easy to break. Maybe we should be calling an API
> from the board specific codes to determine whether we should do the
> MTRR programming. Thoughts?

I am not sure how we would do that. I did suggest a special Kconfig a
while back, so that boards can overwrite the setting if needed. But in
any case we would want a sensible default for that Kconfig.

>
> >         int ret;
> >
> >         /*
> > @@ -23,11 +24,9 @@ int init_cache_f_r(void)
> >          *
> >          * booting from slimbootloader - MTRRs are already set up
> >          * booting with FSPv1 - MTRRs are already set up
> > -        * booting with FSPv2 - MTRRs must be set here
> > +        * booting with FSPv2 or MRC - MTRRs must be set here
> >          * booting from coreboot - in this case there is no SPL, so we =
set up
> >          *      the MTRRs here
> > -        * Note: if there is an SPL, then it has already set up MTRRs s=
o we
> > -        *      don't need to do that here
> >          */
> >         do_mtrr &=3D !IS_ENABLED(CONFIG_FSP_VERSION1) &&
> >                 !IS_ENABLED(CONFIG_SYS_SLIMBOOTLOADER);
> > --
>

At least until we figure out something better, this seems clear enough.

Regards,
Simon
