Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78ADC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 21:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F338A8384E;
	Thu, 10 Apr 2025 23:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YGAN5mOg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABBEB83877; Thu, 10 Apr 2025 23:25:50 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B2D282105
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 23:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac298c8fa50so210129566b.1
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 14:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744320347; x=1744925147; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BIJbzeRW6q1QaGfw159biB/huaLE22zBTOlQEdtPAds=;
 b=YGAN5mOgcfHsAHCyYCcpU54upKk+FEfzVe6GaW/dhA5QGfynH/Llks32BKclb0Weag
 bUQzcTAdEUx4+8SwcbDR/pS/z1P84oDg/ATx7Y2SkHE8wb0awymPeED8ZPhjZ9wnzY7V
 wMgn4sRAJvc8VMicNthXeywitVYdtm2auNFwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744320347; x=1744925147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BIJbzeRW6q1QaGfw159biB/huaLE22zBTOlQEdtPAds=;
 b=aKwKpajSxiAMS/PNJdzMh97XxeaAQVyc0449aoP9N2hqwImYIhaNtTPLis1PJFaUK5
 7DgR6ZeCvWDRrnxRGwW5PxzbtgcMcdgVkuNCC08lNCQ1Ebd8A+uGxxr4inmR/E8tyskI
 BTrbQQsidgQuazV6wZ/j2/QIt+fw0ZpEOV/ktzM7F+n9Y3R3tgJPdBIQyRUoFpVTzM7z
 I6BJioROhImZwerSz76A7tHgMtduz0JuuI4QKAzIRt4jG2/4koOLuzqiGhXTHDrrTUlM
 INFMiYbbF7i5NfSEYoNo+aUqYwyaJnAfps0pk24gxKKPVg2CaZduTZQv94oZ9lcq0Wqk
 GjRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHp0mtLst01XGI3DySZxTKh0KRJt5mpCnj6ChxacH6rmLv6ZKtIOscZwtaozvRjX/0z2pwglQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzbmZs5H2BVB5riwphXxJ6R0F6xLLB/wBt1riMAfF0mEpJoEeRF
 XoLOyIM9oBrP1NdlSziudtvMNg+IcnQE6yeNnDsKb7jeI2GecE5MKBhHTZnBVOyZ9MNhx8VPsvM
 lvMzUHHel5/uSOkXDB8uNUYtC8AccsW3Ookd9
X-Gm-Gg: ASbGncuTSbHKWi/M504Nu4sjBPP6UplqoDuEEF4qqTjCo7bhCeZqM3hVwjOhiYP1nWl
 Ysn9T+aHFJzJIl5YOBfgd2pFD5bmE7SHOlibMjjRN00mvPICSKGAjc8lYKLKen3JeU7vzhvchoA
 UiM8cJdPw5e9cSNgLS1ekWAAM=
X-Google-Smtp-Source: AGHT+IG/0TxE39QUyDSTNf/eeynVzFrMaSEXd6jr/80fCX7C96gOIc5eJUmPkx8YCDQlJdtcli69dq2l1CjQhz4TeJs=
X-Received: by 2002:a17:907:3d4a:b0:ac3:8a3a:e924 with SMTP id
 a640c23a62f3a-acad36a408dmr19457466b.39.1744320347283; Thu, 10 Apr 2025
 14:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
 <20250409-livetree-fixup-v1-1-76dfea80b07f@linaro.org>
 <CAFLszTjLGv0a3W=hPW+pexa1ASaSrrKAcbRoo5cF_LChj-bizA@mail.gmail.com>
 <d807638b-c6ac-429f-b177-ce9427b504f6@linaro.org>
 <CAFLszTgEGd1hHS7D6C_Y8RMrkQ8k_+UgzvZO2zE6rhBizSQXBQ@mail.gmail.com>
 <6e9bb23d-566f-4047-8d02-58dc6170fb5c@linaro.org>
 <CAFLszTgyZ507jXXEcxWpY0V8LV90V2P7GhcH=2wS58cyGvR2dg@mail.gmail.com>
 <1c1bcd1e-bec5-4e6a-9f09-e1d2895969b3@linaro.org>
In-Reply-To: <1c1bcd1e-bec5-4e6a-9f09-e1d2895969b3@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 10 Apr 2025 15:25:35 -0600
X-Gm-Features: ATxdqUGekhAkUMq3SIqyMF08LDtQZPH1s127R_wJc129pVO7-gCyvTDypeyJGzM
Message-ID: <CAFLszTi30x=Qj82kXWfZnV1JjMXcdfxnUSYabyYeRRrgz4yeiQ@mail.gmail.com>
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

On Thu, 10 Apr 2025 at 09:41, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Simon,
>
> On 4/10/25 16:15, Simon Glass wrote:
> > Hi Caleb,
> >
> > On Thu, 10 Apr 2025 at 08:04, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >>
> >>
> >> On 4/10/25 15:07, Simon Glass wrote:
> >>> Hi Caleb,
> >>>
> >>> On Thu, 10 Apr 2025 at 07:00, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>>>
> >>>> Hi Simon,
> >>>>
> >>>> On 4/10/25 13:27, Simon Glass wrote:
> >>>>> Hi Caleb,
> >>>>>
> >>>>> On Wed, 9 Apr 2025 at 11:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>>>>>
> >>>>>> OF_LIVE offers a variety of benefits, one of them being that the live
> >>>>>> tree can be modified without caring about the underlying FDT. This is
> >>>>>> particularly valuable for working around U-Boot limitations like lacking
> >>>>>> USB superspeed support on Qualcomm platforms, no runtime OTG, or
> >>>>>> peripherals like the sdcard being broken (and displaying potentially
> >>>>>> worrying error messages).
> >>>>>>
> >>>>>> Add an event to signal when the live tree has been built so that we can
> >>>>>> apply fixups to it directly before devices are bound.
> >>>>>>
> >>>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >>>>>> ---
> >>>>>>     common/event.c  | 3 +++
> >>>>>>     include/event.h | 9 +++++++++
> >>>>>>     lib/of_live.c   | 3 +++
> >>>>>>     3 files changed, 15 insertions(+)
> >>>>>>
> >>>>>> diff --git a/common/event.c b/common/event.c
> >>>>>> index dda569d447851f559a83f98fb7b1f3543156eab5..8d7513eb10b61919e1e784481dfdcc076be14986 100644
> >>>>>> --- a/common/event.c
> >>>>>> +++ b/common/event.c
> >>>>>> @@ -47,8 +47,11 @@ const char *const type_name[] = {
> >>>>>>            "ft_fixup",
> >>>>>>
> >>>>>>            /* main loop events */
> >>>>>>            "main_loop",
> >>>>>> +
> >>>>>> +       /* livetree has been built */
> >>>>>> +       "of_live_init",
> >>>>>>     };
> >>>>>>
> >>>>>>     _Static_assert(ARRAY_SIZE(type_name) == EVT_COUNT, "event type_name size");
> >>>>>>     #endif
> >>>>>> diff --git a/include/event.h b/include/event.h
> >>>>>> index 75141a192a48b0931667632f41be8ff4d6139f7c..3fc673ba635ed45467aae8587705d37bef1c2a3f 100644
> >>>>>> --- a/include/event.h
> >>>>>> +++ b/include/event.h
> >>>>>> @@ -152,8 +152,17 @@ enum event_t {
> >>>>>>             * A non-zero return value causes the boot to fail.
> >>>>>>             */
> >>>>>>            EVT_MAIN_LOOP,
> >>>>>>
> >>>>>> +       /**
> >>>>>> +        * @EVT_OF_LIVE_INIT:
> >>>>>> +        * This event is triggered immediately after the live device tree has been
> >>>>>> +        * built. This allows for machine specific fixups to be done to the live tree
> >>>>>> +        * (like disabling known-unsupported devices) before DM init happens. This
> >>>>>> +        * event is only available if OF_LIVE is enabled and is only used after relocation.
> >>>>>> +        */
> >>>>>> +       EVT_OF_LIVE_INIT,
> >>>>>> +
> >>>>>>            /**
> >>>>>>             * @EVT_COUNT:
> >>>>>>             * This constants holds the maximum event number + 1 and is used when
> >>>>>>             * looping over all event classes.
> >>>>>> diff --git a/lib/of_live.c b/lib/of_live.c
> >>>>>> index 90b9459ede313e492e28c8556c730f3bd8aaa9df..e1962b8f1fb9d8c2c87d04ca4e238a1e4d00376a 100644
> >>>>>> --- a/lib/of_live.c
> >>>>>> +++ b/lib/of_live.c
> >>>>>> @@ -10,8 +10,9 @@
> >>>>>>
> >>>>>>     #define LOG_CATEGORY   LOGC_DT
> >>>>>>
> >>>>>>     #include <abuf.h>
> >>>>>> +#include <event.h>
> >>>>>>     #include <log.h>
> >>>>>>     #include <linux/libfdt.h>
> >>>>>>     #include <of_live.h>
> >>>>>>     #include <malloc.h>
> >>>>>> @@ -334,8 +335,10 @@ int of_live_build(const void *fdt_blob, struct device_node **rootp)
> >>>>>>                    return ret;
> >>>>>>            }
> >>>>>>            debug("%s: stop\n", __func__);
> >>>>>>
> >>>>>> +       event_notify_null(EVT_OF_LIVE_INIT);
> >>>>>> +
> >>>>>
> >>>>> This should go in initr_of_live() since the function you are dealing
> >>>>> with here is supposed to just do the live build.
> >>>>
> >>>> Well, we only every call this function from one place right now, but if
> >>>> it was called multiple times for some reason then I would want to be
> >>>> able to re-apply fixups to the new live tree.... I guess it should
> >>>> probably pass in *rootp to the event handler, let me rework that.>
> >>>
> >>> There's no need to change the root, so what you have is find here.
> >>>
> >>>>> Same for the EFI_STUB thing which I just noticed, actually
> >>>>
> >>>> what EFI_STUB thing?>
> >>>
> >>> Oh, it's your EFI stub patch which isn't in Tom's tree yet. Just for
> >>> when you get to it, then.
> >>>
> >>>>> Also please check for error
> >>>>>
> >>>>> Otherwise this seems OK to me. I do wonder why we can't use
> >>>>> EVT_FT_FIXUP though. Could you add mention of that to your comment in
> >>>>> event.h?
> >>>>
> >>>> Because FT_FIXUP is for fixing up the flat tree before starting the OS?
> >>>> these are obviously different things imo, im not sure how i could
> >>>> clarify this.>
> >>>
> >>> Well, what is the purpose of your code? Are you saying that it is used
> >>> within U-Boot, but not passed to the OS?
> >>
> >> Yes, please read the cover letter and commit messages. FT_FIXUP allows
> >> for the FDT that is about to be passed to the OS to be fixed up,
> >> OF_LIVE_INIT signifies that U-Boot has finished building it's livetree.
> >> The livetree is obviously not used outside of U-Boot, being a totally
> >> custom in-memory representation of the DT.
> >
> > Oh, I wondered what '(which is not passed on to further boot stages)' meant.
>
> If you don't understand what my patch series does, it would save us both
>   a lot of time if you asked me to clarify some specific point than to
> reply with your stream-of-consciousness ponderings about what perhaps I
> might be doing.
>
> I've tried -- again -- to explain what we're doing here, comments below.
>
> >
> > Sorry, no, we can't do that.
> We have been for months already
>
> > We are moving towards using livetree in U-Boot
>
> indeed, mach-snapdragon has been using it for 372 days now
>
> commit 1534186f2953d99dcbc757a19b43e4fac644e8a9
> Author: Caleb Connolly <caleb.connolly@linaro.org>
> Date:   Wed Apr 3 14:07:49 2024 +0200
>
>      qcom_defconfig: enable livetree
>
> > - there is already the fixup thing as mentioned.
>
> The FT_FIXUP event which has absolutely nothing to do with livetree or
> this patch series and which is triggered at a different point in the
> boot process for an entirely different purpose (preparing for the OS
> rather than preparing for U-Boot itself)?
>
> > We just don't yet have the flattening at the end before boot.
>
> Which is exactly what we leverage in mach-snapdragon to bridge the gap
> between U-Boot (a bootloader that intentionally has a simplified model
> of the hardware) and upstream DT which contains a lot of additional
> context which is (as far as U-Boot is concerned) noise that we have to
> filter out.
>
>  > If you have time you could look at that.
>
> this is something literally nobody wants that wouldn't even be used in
> most cases (since EFI DT FIXUP protocol passes you an FDT anyway).
>
> >
> > Your event to modify the livetree is fine, but any modifications
> > should be passed on to the OS.
>
> As stated clearly in the commit message and the cover letter, making
> modifications that don't get passed on to the OS is the entire point.
>
> Assuming you didn't take the time to look at mach-snapdragon/of_fixup.c,
> it is literally rewriting the livetree to patch out the USB superspeed
> phy and only initialise USB in high-speed mode. This is quite simply
> because U-Boot doesn't have PHY drivers for superspeed USB on Qualcomm
> platforms yet.
>
> We absolutely don't want this to be passed on to the OS because it is
> entirely an implementation detail in U-Boot. It's functionally All this
> additional complexiequivalent to adding a bunch of "#ifdef
> ARCH_SNAPDRAGON" ... "skip the superspeed phy" in the dwc3 driver.
>
> This is really basic abstraction, and hopefully you'll tell me that I
> didn't need to explain all this because you did in fact take the time to
> understand how mach-snapdragon is using the livetree before replying
> (like by reading the big comment at the top of of_fixup.c).
>
> > If you don't want that, then your fixup would need to remove them, I suppose.
>
> why why why???
>
>  > Does the OS actually care, though?
>
> The OS would almost certainly be unhappy at the tree U-Boot is using
> internally yes, because we don't bother fixing up stuff like the
> usb-connector nodes which are unused in U-Boot.
>
> I know, I seem very frustrated, and I am. I have no problem with you
> misunderstanding a patch or asking for clarifications, but you keep
> repeatedly misunderstanding fundamental technical realities of an issue
> or patch series and then seemingly doubling down and just saying
> whatever comes to mind without exerting any effort to understand the
> other side.
>
> ----
>
> You didn't ask, but I'm going to explain how I review patches to
> hopefully convey some of my confusion here because I'm worried this is a
> pattern that is repeating itself and it is starting to wear on me. I've
> never been one to beat around the bush I guess.
>
> My first thought when I don't understand some change a patch is making
> is "huh I wonder why they did that instead of this", but you will never
> see me say that verbatim on the lists because I immediately go and read
> the code to remind myself what it is doing and validate any assumptions
> I might be making, as well as to try to understand the thought process
> of the author.
>
> What you WILL see me say on the lists is either
>
> 1) A (usually backed up by references) explanation of why I think the
> change is wrong, or
>
> 2) If I'm really confused I'll usually try to explain what I think
> they're trying to do (again backed up by code references where relevant)
> and ask for clarification.
>
> This way in (1) the author can say "oh yeah my bad, thanks for noticing
> that" or point out what I missed that makes their change make sense.
> This is easy, painless, everyone can go about their day (unless there is
> a technical disagreement, but really that's besides the point here)
>
> In the second case, they can confirm that my understanding is correct
> and respond to my (typically pointed) questions to clarify both how they
> understand the code and whatever context I'm missing. Assuming I'm any
> good at asking the right questions, this results in the same outcomes as
> (1).
>
> This works because I'm trying to bridge the gap between my understanding
> and the patch authors, I have my own mental model of how things work but
> it could be wrong, so I want to convey what my model is so that it can
> be corrected in that case, and so that if the authors understanding is
> wrong then they can correct it.
>
> Your reviews don't do this, they leave me guessing wildly at what you
> might possibly think my code is doing.
>
> There is no polite way for me to say "this comment you made is so out of
> left field that I think you fundamentally misunderstand this patch", but
> if you tell me what you think I'm trying to do (if you're at all
> unsure), so I know what foundation you're working on, then I can easily
> and politely say "ah your understanding here is wrong", you can re-do
> your review with a correct mental model and I don't have to try and
> parse things the way I have done above.
>
> If I were to go as far as to define a rule for patch review, it would be
> "whenever the words 'i wonder' go through your head, try to find out
> before sending your reply, and include your findings if you don't find a
> satisfactory answer"

I'm sorry for upsetting you and I really hope I can improve the
situation here. I also really appreciate you taking the time to write
all these details.

It is true that I struggle to find time for reviews at the moment, all
in my spare time. Even then, I just checked and I am number two in the
review tags for the most recent release. I am definitely pulling my
weight here. Also I have knowledge of many of the subsystems. Yes I
wish I could dig in and understand things more and I will try to do
better. But my intentions are good.

Here is how U-Boot should (eventually) work:

Flat DT
    |
unflattened
    |
used in U-Boot               some-other-DT-packaged-with-OS
    |                                       /
    |                                   /
this is where the fixups happen
    |
flattened
    |
    |
passed to Linux

The branch is due to the fact that the OS may have a better
devicetree, but ideally, in the fullness of time, the devicetree
provided by firmware would be good enough.

I don't believe it is a good idea for U-Boot to use its own
devicetree, separate from the Linux one. U-Boot should use the same
one. That is the idea behind the dts-upstream feature in U-Boot, to
make that easier.

For the EVT_FT_FIXUP event, the intent is to do fixups on the livetree
as it should be more efficient. There's a lot of existing code that
uses the flattree and I haven't figured out a clever way to migrate
it.

But overall, the way to think of the livetree and flattree is that
they are the same tree. We can unflatten, modify and flatten, but not
unflatten, modify and throw away. We certainly don't maintain two
separate trees within U-Boot.

I suspect the main problem is that this part of U-Boot is in slow
transition. Perhaps some better documentation of the eventual state
would help?

If you are still unhappy, how about we organise a call to discuss
this? I really don't think we are on the same page at all right now.
It might help to reduce frustration.

Regards,
Simon
