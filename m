Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72004C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 19:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D19E88661;
	Wed, 29 May 2024 21:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QM0xcPsS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3376885E1; Wed, 29 May 2024 21:46:53 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 736A787D2F
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 21:46:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3d1bc6e5f01so25342b6e.0
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 12:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717012010; x=1717616810; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eyyTfUsMg4EU1JuvjUUHb/v7Xh9SjQc712wFC0QIf2Q=;
 b=QM0xcPsS/h+rAPUjwG6SIQiyOE5yqT5DZ7jvMYNU1MhGAwl/B3ury8vVvcekObRE/P
 /RzMdmT6FITCuJxkpF/cjqM1EiL35Y6ON0P4l/bHk6XKEWjpaLCywh6fahhx8xY6suBr
 VWqUCuTxUAUQ9chqRLHl6j5EhHdsGZE/gnI0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717012010; x=1717616810;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eyyTfUsMg4EU1JuvjUUHb/v7Xh9SjQc712wFC0QIf2Q=;
 b=DdayMAohBTsMmJJFIQZD/AYKsbcmDWAz3ocMR75uDCo3ppCP9tZcCjctBdGD0o4ztv
 CvWOa1qzuCCuoyBlaPjbY4/sGCJX+s2uoi9F8hL2p+DwVvRA5MI410rybOYhzOqHuyPL
 LbOCxMpJ+tbnKZlO0+pOglOZyCQBAzeEqVA7oVKs+BVwkSdxns+6w+eeQybkg670oE5Q
 2lbr12HBAZUMzSCKIlfFh6E+0R+eVuG2zxDnqbSpxWtLlohuozQqShVpRRKp+bsQIgjK
 n159LHH8mF8kCV2BbE2vPi70Xjvg6gQzht+8SmI7/nMFLV33+aZU960CtQ3KW2uv0fY9
 75WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKMLN3eSv+YuLODf0JTgeNR8U2xNju3kQUNi01AFfIBG052fJUg/iUBoGMl/XzPbYTKCwBpAWnwCT/kH3tC3VQx8oG6Q==
X-Gm-Message-State: AOJu0Yzt+aR2NPMuclr9NJz1xFmm5CIauPPvnIdDg5x5gbDCvtD3ZMwD
 J/cm1jyyeh+XtnzZzSak7fJdEE9rVTRO8V746IDP2Er3/el3rV+BJrlXF1WTpvkmsq7fvoN4qjq
 6KH5xMyHdtjlAsoyKAszs6oHwPf1QPQ1yh+Wl
X-Google-Smtp-Source: AGHT+IE/JjSqrIZR1vf3uj46Lf7rQ+as4RvVsNTIMsLSzTwRbS4xhCYFzHqdb2u7JABxsL46d1KrLP3XxXykvyX+aLU=
X-Received: by 2002:a05:6808:6083:b0:3c9:bcb9:8fca with SMTP id
 5614622812f47-3d1dcca39a8mr22892b6e.23.1717012010079; Wed, 29 May 2024
 12:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
 <20240529-b4-dynamic-uuid-v2-1-c26f31057bbe@linaro.org>
 <CAFLszTj2Ea8_oFaewsZ8bjNe3T3T9dfYbvFJ6wsw88B1HqDG8A@mail.gmail.com>
 <a58ab575-3a61-47fd-a0b7-1f7b0c1e8b40@linaro.org>
In-Reply-To: <a58ab575-3a61-47fd-a0b7-1f7b0c1e8b40@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 May 2024 13:46:37 -0600
Message-ID: <CAFLszTgSBwD1qcUFSG6-CpV1_4qgfY-wZi1Usg0Lz49AX8BgRA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] lib: uuid: add UUID v5 support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 29 May 2024 21:49:27 +0200
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

Hi Caleb,

On Wed, 29 May 2024 at 12:55, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Simon,
>
> On 29/05/2024 18:30, Simon Glass wrote:
> > Hi Caleb,
> >
> > On Wed, 29 May 2024 at 08:49, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> Add support for generate version 5 UUIDs, these are determistic and work
> >
> > spelling
>
> Thanks
> >
> >> by hashing a "namespace" UUID together with some unique data. One intended
> >> usecase is to allow for dynamically generate payload UUIDs for UEFI
> >> capsule updates, so that supported boards can have their own UUIDs
> >> without needing to hardcode them.
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >> ---
> >>   include/uuid.h | 17 +++++++++++++++++
> >>   lib/Kconfig    |  8 ++++++++
> >>   lib/uuid.c     | 37 +++++++++++++++++++++++++++++++++++++
> >>   3 files changed, 62 insertions(+)
> >>
> >
> > Can you please mention the tests for this? I believe they are in your
> > last commit?
>
> Yeah will do.
> >
> >> diff --git a/include/uuid.h b/include/uuid.h
> >> index f5a941250f48..539affaa47b9 100644
> >> --- a/include/uuid.h
> >> +++ b/include/uuid.h
> >> @@ -10,8 +10,9 @@
> >>   #ifndef __UUID_H__
> >>   #define __UUID_H__
> >>
> >>   #include <linux/bitops.h>
> >> +#include <linux/kconfig.h>
> >>
> >>   /*
> >>    * UUID - Universally Unique IDentifier - 128 bits unique number.
> >>    *        There are 5 versions and one variant of UUID defined by RFC4122
> >> @@ -142,8 +143,24 @@ void gen_rand_uuid(unsigned char *uuid_bin);
> >>    * @param          - uuid output type: UUID - 0, GUID - 1
> >>    */
> >>   void gen_rand_uuid_str(char *uuid_str, int str_format);
> >>
> >> +#if IS_ENABLED(CONFIG_UUID_GEN_V5)
> >> +/**
> >> + * gen_uuid_v5() - generate UUID v5 from namespace and other seed data.
> >> + *
> >> + * @namespace:   pointer to UUID namespace salt
> >> + * @uuid:        pointer to allocated UUID output
> >> + * @...:         NULL terminated list of seed data as pairs of pointers
> >> + *               to data and their lengths
> >> + */
> >> +void gen_uuid_v5(const struct uuid *namespace, struct uuid *uuid, ...);
> >> +#else
> >> +static inline void gen_uuid_v5(const struct uuid *namespace, struct uuid *uuid, ...)
> >> +{
> >> +}
> >> +#endif
> >> +
> [...]
> >> +#if IS_ENABLED(CONFIG_UUID_GEN_V5)
> >> +void gen_uuid_v5(const struct uuid *namespace, struct uuid *uuid, ...)
> >
> > Is this in a header file somewhere? It needs a function comment there.
>
> Yes, see directly above where I add it to include/uuid.h

OK thanks. We are using a different format now - the old @param stuff
is in the past :-)

Regards,
Simon
