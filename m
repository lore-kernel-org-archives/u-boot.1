Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E584EC3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:51:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7DF78887E;
	Sun, 11 Aug 2024 16:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BWSsy7z+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F52E88100; Sun, 11 Aug 2024 16:50:28 +0200 (CEST)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23F9688845
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:50:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-821db15a930so895521241.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387825; x=1723992625; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b5Kj9/aqhdL1qKxFvx63Z9SljgkQEXTbhr/HmAWaE14=;
 b=BWSsy7z+aTMUKBhAEBT4Ih2yCwvsH/R+lTKbSAH6hLzjqWa+zag2KFdw0yn6gXLwM6
 XpLGHclf+XSbU8QYzOvcyv4topDBRY4siYAYRVLe92Hi1XW/JYrK1wfjk0UPKnVhk4cZ
 rZi7NFEaoRVG5/MIjSCRwaOFNv5nayU4kDVJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387825; x=1723992625;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b5Kj9/aqhdL1qKxFvx63Z9SljgkQEXTbhr/HmAWaE14=;
 b=GPFM5CFu2dSeEy6bML0cWoKP6HmEKaLHiVySdN9w+HuCEf0WO6mCwTtPsu9j/y4T1i
 RkbL0J20CzdiUvVRCL6kEK5p52tifZWUhjBWlRFkkNzvah3f3MrNz/mIsT5X1tJ7KCi+
 rZA5E0GuYaoBJmoZCBF1kkaLOW797EchfcOayNY+EC/A8A0o3ADgXPMNwRtxj7cx9+HG
 lS2xhVCkRO/U2xnLOhsejvdzi55Cs06VVjD4qyUZDRaWcj19+mhbD5qXrxXDtjOqLUn/
 GpIoL+Yjdm4xh+YN6GG3cv+FsB0/UKIbLLO6ZnqaxYNGqalvuA4aiyXYJLpc+wk/ViQT
 3gvA==
X-Gm-Message-State: AOJu0YyMpBBNeB82dNDkvx2gxLJfyOpOeJQGFfKk/JYbbDAdS+jUINYB
 4Rf2ThcnY+BQRQHL+hGhDJZKpMl4hwpFNXHEipIKwTTo2vT+tEowby8kryutWfSnUHXJ9IBFnh7
 1Z7JfAcucuWmghFDOFc3/YbKBboyqLd/3HUNQ
X-Google-Smtp-Source: AGHT+IG2eW8Ld6jZ1cTOpP1m0XIERaPHxj3rqZlExRH6Z5BIW/s77zyckTFzT8FAmdgX2g5Y+plmWAOXc9Id8B9NRRM=
X-Received: by 2002:a05:6102:942:b0:493:de37:b3ef with SMTP id
 ada2fe7eead31-495d8484970mr9246579137.13.1723387824868; Sun, 11 Aug 2024
 07:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-8-sjg@chromium.org>
 <94949f6b-9f82-452c-9d38-5c8683a21ddd@cherry.de>
In-Reply-To: <94949f6b-9f82-452c-9d38-5c8683a21ddd@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 Aug 2024 08:50:14 -0600
Message-ID: <CAFLszThRvPSiZrsQEzbMS+Lg=sB1jijEMj9F=cG3h0MQH76t5A@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] log: Avoid including function names by default
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Quentin,

On Tue, 6 Aug 2024 at 08:16, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 7/21/24 5:25 PM, Simon Glass wrote:
> > Unless function names are requested, the logging system should not
> > compile these into the code. Adjust the macros to handle this.
> >
> > This means that turning on function names at runtime won't work unless
> > CONFIG_LOGF_FUNC is enabled. We could perhaps split this into a
> > separate option if that is a problem.
> >
> > Enable CONFIG_LOGF_FUNC logging for sandbox since the tests expect the
> > function names to be included. Fix up the pinmux test which checks a
> > logging statement.
> >
>
> I now understand the statement in patches earlier in this series :)
>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Update commit message to mention the runtime impact
> > - Leave assert() alone since it is only compiled in with LOG_DEBUG
> >
> >   common/log_console.c      |  4 ++--
> >   configs/sandbox_defconfig |  1 +
> >   include/log.h             | 16 +++++++++++-----
> >   test/cmd/pinmux.c         |  8 +++++++-
> >   test/log/log_test.c       |  4 ++--
> >   5 files changed, 23 insertions(+), 10 deletions(-)
> >
> > diff --git a/common/log_console.c b/common/log_console.c
> > index c27101b8fe2..9376baad664 100644
> > --- a/common/log_console.c
> > +++ b/common/log_console.c
> > @@ -38,10 +38,10 @@ static int log_console_emit(struct log_device *ldev, struct log_rec *rec)
> >                       printf("%d-", rec->line);
> >               if (fmt & BIT(LOGF_FUNC)) {
> >                       if (CONFIG_IS_ENABLED(USE_TINY_PRINTF)) {
> > -                             printf("%s()", rec->func);
> > +                             printf("%s()", rec->func ?: "?");
>
> What about setting _log_func to "?" if LOGF_FUNC isn't set?

That would require all call sites to pass a pointer to the string,
rather than just NULL. I suspect it would increase code size?

>
> >                       } else {
> >                               printf("%*s()", CONFIG_LOGF_FUNC_PAD,
> > -                                    rec->func);
> > +                                    rec->func ?: "?");
>
> I think you missed a similar change in common/log_syslog.c if I can
> trust my grep-fu?

Yes, thanks.

Regards,
Simon
