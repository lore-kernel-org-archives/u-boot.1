Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5247C369A6
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 14:15:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3160282944;
	Thu, 10 Apr 2025 16:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HQpBuRxj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCD3D82A4B; Thu, 10 Apr 2025 16:15:18 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85481820F6
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 16:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac29af3382dso156358666b.2
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744294516; x=1744899316; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KA82gB+vUozFOZJ+iH+Q1khhOQZezPtVdhFV7Qq/1D8=;
 b=HQpBuRxjIpQElVuGHpT63p090wRbClKSNnsP3t/w9fBhtFLGnL4c9bFoqwWORzba5c
 zdy14BDe5FXUzDtqyBWSKJ5RhwXGawcWwEqfypIBFa1V7sthcspsOf5ZhuKXIyW8XN4V
 8LiyzVbNwUDlkUGAyCsMq41rkKJYptbRONtoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744294516; x=1744899316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KA82gB+vUozFOZJ+iH+Q1khhOQZezPtVdhFV7Qq/1D8=;
 b=iiMqmp4mdNjPxW431tTj7DHgOrAnq+7kLNFoX5yvG4LTrCq9MN9MRJkAErgfMmoZHN
 yOMqGAxSQTPG4gFwejTLJvUda1tB2bPDcPE+h1Ey5X53ouUiB3hSvyL5x149TdqOzoJA
 o6FVvbfpJg8ua5ifbQe4t47A0C1JzTpTUHeuNFXfLQDqxR+qO+SZnjJ/ezb7+8UNQ0v/
 odHkoOVucFjLIJB7X8yiumvVc1epfWL8o+KDwwlvpF4LYnM9C92+r7pzpL9sxNoChNDq
 fxQ2zH51Vu7zxxhiA/BfqfwwQl5BzOReNm9XoOHXtawXl56tRe9w7cvFmwTAFnWLNwhl
 Iwcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFat3UPnJZ/A6cBbZWU+8ZlWIJ2lN+iROj1oVMttW3l68VfBXqclWJyRiU7KXfCft/FA2hciw=@lists.denx.de
X-Gm-Message-State: AOJu0YxerSNIUpfNmidNu7FAUC7mqcEwkSIGtkahKZxuN9och1fPLlq2
 wtQN9SESaIFZqm5eh4X37mJ8ARfI0ageflD+uVOhsnAVRIcu38ZbrqyoJsn+ccdiwXfveSlDk+X
 SIUDZDTOsPE5D9+o/R5MFd9ZWbv2Ncnz4AD3k
X-Gm-Gg: ASbGnctVZizVOlyKCxR83lpK8HNKKnhzxIP1KOXRCJP1AmVdq1k12V0qJfH+NekW1Rl
 cI+OBmKKVN14CZqtx2Wy33EzjLF6TyGuWJMf8uQctQSVpAaSXyo62wOBGWoLjxra4MOfmb1rUoz
 NDpopv5YwD5yRedpukcLdDk7E=
X-Google-Smtp-Source: AGHT+IH38RVaCfMrrxqZ4Nl+QUHdEXMH97jDkK/q3tQy/z3oszyX17Ak/cHlV4EdBkNb2jjsZl7bT0jwPSZPSeu35gM=
X-Received: by 2002:a17:907:f818:b0:ac2:7a6d:c927 with SMTP id
 a640c23a62f3a-acac0339ff0mr257170666b.50.1744294515563; Thu, 10 Apr 2025
 07:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
 <20250409-livetree-fixup-v1-1-76dfea80b07f@linaro.org>
 <CAFLszTjLGv0a3W=hPW+pexa1ASaSrrKAcbRoo5cF_LChj-bizA@mail.gmail.com>
 <d807638b-c6ac-429f-b177-ce9427b504f6@linaro.org>
 <CAFLszTgEGd1hHS7D6C_Y8RMrkQ8k_+UgzvZO2zE6rhBizSQXBQ@mail.gmail.com>
 <6e9bb23d-566f-4047-8d02-58dc6170fb5c@linaro.org>
In-Reply-To: <6e9bb23d-566f-4047-8d02-58dc6170fb5c@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 10 Apr 2025 08:15:02 -0600
X-Gm-Features: ATxdqUHu-D4ptEdyG_JL5SPTqatwvFki9LTme6Dz2L61V9_JKUfeUOhJkAHz_3Q
Message-ID: <CAFLszTgyZ507jXXEcxWpY0V8LV90V2P7GhcH=2wS58cyGvR2dg@mail.gmail.com>
Subject: Re: [PATCH 1/6] event: signal when livetree has been built
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

Hi Caleb,

On Thu, 10 Apr 2025 at 08:04, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 4/10/25 15:07, Simon Glass wrote:
> > Hi Caleb,
> >
> > On Thu, 10 Apr 2025 at 07:00, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 4/10/25 13:27, Simon Glass wrote:
> >>> Hi Caleb,
> >>>
> >>> On Wed, 9 Apr 2025 at 11:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>>>
> >>>> OF_LIVE offers a variety of benefits, one of them being that the live
> >>>> tree can be modified without caring about the underlying FDT. This is
> >>>> particularly valuable for working around U-Boot limitations like lacking
> >>>> USB superspeed support on Qualcomm platforms, no runtime OTG, or
> >>>> peripherals like the sdcard being broken (and displaying potentially
> >>>> worrying error messages).
> >>>>
> >>>> Add an event to signal when the live tree has been built so that we can
> >>>> apply fixups to it directly before devices are bound.
> >>>>
> >>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >>>> ---
> >>>>    common/event.c  | 3 +++
> >>>>    include/event.h | 9 +++++++++
> >>>>    lib/of_live.c   | 3 +++
> >>>>    3 files changed, 15 insertions(+)
> >>>>
> >>>> diff --git a/common/event.c b/common/event.c
> >>>> index dda569d447851f559a83f98fb7b1f3543156eab5..8d7513eb10b61919e1e784481dfdcc076be14986 100644
> >>>> --- a/common/event.c
> >>>> +++ b/common/event.c
> >>>> @@ -47,8 +47,11 @@ const char *const type_name[] = {
> >>>>           "ft_fixup",
> >>>>
> >>>>           /* main loop events */
> >>>>           "main_loop",
> >>>> +
> >>>> +       /* livetree has been built */
> >>>> +       "of_live_init",
> >>>>    };
> >>>>
> >>>>    _Static_assert(ARRAY_SIZE(type_name) == EVT_COUNT, "event type_name size");
> >>>>    #endif
> >>>> diff --git a/include/event.h b/include/event.h
> >>>> index 75141a192a48b0931667632f41be8ff4d6139f7c..3fc673ba635ed45467aae8587705d37bef1c2a3f 100644
> >>>> --- a/include/event.h
> >>>> +++ b/include/event.h
> >>>> @@ -152,8 +152,17 @@ enum event_t {
> >>>>            * A non-zero return value causes the boot to fail.
> >>>>            */
> >>>>           EVT_MAIN_LOOP,
> >>>>
> >>>> +       /**
> >>>> +        * @EVT_OF_LIVE_INIT:
> >>>> +        * This event is triggered immediately after the live device tree has been
> >>>> +        * built. This allows for machine specific fixups to be done to the live tree
> >>>> +        * (like disabling known-unsupported devices) before DM init happens. This
> >>>> +        * event is only available if OF_LIVE is enabled and is only used after relocation.
> >>>> +        */
> >>>> +       EVT_OF_LIVE_INIT,
> >>>> +
> >>>>           /**
> >>>>            * @EVT_COUNT:
> >>>>            * This constants holds the maximum event number + 1 and is used when
> >>>>            * looping over all event classes.
> >>>> diff --git a/lib/of_live.c b/lib/of_live.c
> >>>> index 90b9459ede313e492e28c8556c730f3bd8aaa9df..e1962b8f1fb9d8c2c87d04ca4e238a1e4d00376a 100644
> >>>> --- a/lib/of_live.c
> >>>> +++ b/lib/of_live.c
> >>>> @@ -10,8 +10,9 @@
> >>>>
> >>>>    #define LOG_CATEGORY   LOGC_DT
> >>>>
> >>>>    #include <abuf.h>
> >>>> +#include <event.h>
> >>>>    #include <log.h>
> >>>>    #include <linux/libfdt.h>
> >>>>    #include <of_live.h>
> >>>>    #include <malloc.h>
> >>>> @@ -334,8 +335,10 @@ int of_live_build(const void *fdt_blob, struct device_node **rootp)
> >>>>                   return ret;
> >>>>           }
> >>>>           debug("%s: stop\n", __func__);
> >>>>
> >>>> +       event_notify_null(EVT_OF_LIVE_INIT);
> >>>> +
> >>>
> >>> This should go in initr_of_live() since the function you are dealing
> >>> with here is supposed to just do the live build.
> >>
> >> Well, we only every call this function from one place right now, but if
> >> it was called multiple times for some reason then I would want to be
> >> able to re-apply fixups to the new live tree.... I guess it should
> >> probably pass in *rootp to the event handler, let me rework that.>
> >
> > There's no need to change the root, so what you have is find here.
> >
> >>> Same for the EFI_STUB thing which I just noticed, actually
> >>
> >> what EFI_STUB thing?>
> >
> > Oh, it's your EFI stub patch which isn't in Tom's tree yet. Just for
> > when you get to it, then.
> >
> >>> Also please check for error
> >>>
> >>> Otherwise this seems OK to me. I do wonder why we can't use
> >>> EVT_FT_FIXUP though. Could you add mention of that to your comment in
> >>> event.h?
> >>
> >> Because FT_FIXUP is for fixing up the flat tree before starting the OS?
> >> these are obviously different things imo, im not sure how i could
> >> clarify this.>
> >
> > Well, what is the purpose of your code? Are you saying that it is used
> > within U-Boot, but not passed to the OS?
>
> Yes, please read the cover letter and commit messages. FT_FIXUP allows
> for the FDT that is about to be passed to the OS to be fixed up,
> OF_LIVE_INIT signifies that U-Boot has finished building it's livetree.
> The livetree is obviously not used outside of U-Boot, being a totally
> custom in-memory representation of the DT.

Oh, I wondered what '(which is not passed on to further boot stages)' meant.

Sorry, no, we can't do that. We are moving towards using livetree in
U-Boot - there is already the fixup thing as mentioned. We just don't
yet have the flattening at the end before boot. If you have time you
could look at that.

Your event to modify the livetree is fine, but any modifications
should be passed on to the OS. If you don't want that, then your fixup
would need to remove them, I suppose. Does the OS actually care,
though?

Regards,
Simon
