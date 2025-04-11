Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44505C369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 18:31:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A88A18421F;
	Fri, 11 Apr 2025 20:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g+AMNjYI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DDDC8421C; Fri, 11 Apr 2025 20:31:10 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 630A98421A
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 20:31:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e66407963fso4238071a12.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 11:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744396265; x=1745001065; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X8BaMQ75IFRvpHNwFWvL9cIZFl26JKcu6ZYfkucyj6w=;
 b=g+AMNjYI0C0Qn0fLZ8MUkHY+UDmiV2n/nwtDKMSnKw2mubePIphz8uN3qedBSYEJkf
 Xq2x/I/uHjaCmdVhIv1x5uWjq+t2VKh6SvHaLyoKjM8j3EPL6AbGL0h6hw788jDA/dU5
 h4NY5jAqSd+PgwaeMiJ/VmX8If15kSYTGQ6p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744396265; x=1745001065;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X8BaMQ75IFRvpHNwFWvL9cIZFl26JKcu6ZYfkucyj6w=;
 b=aCA070w6sZk3Zldq9M1JaphAU3ltdf/mRsiFIk7VXGeJGTzrQUT7A2tDygMgXjW7pN
 3Z8Av22hYcuib5na14ARTab+a/zIzl7GYiFQEbLfrj+xOAoyQnM934ZuD+0tVl1du0qD
 8aIObzbVp6niNfFVmowRBTabRvttj71fkuDdyURJFcnA8jBqSv3ldEZPbqJn5SjbaIu+
 bC8AkvT2UMGqYtuearPpkGHWPocVRnc/XRZ6tHG68oYvgAiqQC6UQm0fDf9tbTxnxlnq
 utfzKxABTm+/yaOeQJG4QJRb2FeXnJjwZ9TZus+DbBcUxLeiL6o7i/xY6xqufgNIWEav
 CpCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo7YJZ6Cm2tHSnPlcH9t4NAa41AUWdJ9mmCK+VVU0lYUnhn/S//Aa76mt1/By7LYHgJy9MPP8=@lists.denx.de
X-Gm-Message-State: AOJu0YwI0sPlNPgBIS/Yd2w7lf4k1rqyKKWDJFsgzLzaKcnvQuQpf5Kt
 v+GdIz2vA65JnyeQzg+h/1DX2MiYEPxfhf+eU2LpfQgrmnNA9hDMEdFOJaS1D6e2ACtUl4Rp6YW
 ErnI1PaM/9ZL5qbuu1SrKgytVaZAeIFpf/pyF
X-Gm-Gg: ASbGncsYlvVDydCEanQ5SZk0Ipkb3fcYzEgFkSNw9xIOtegjBsF7MvNIYFNldKT9RxY
 vUvc3zRXPascB8Upl76rWoYeYGUgMC7xOry19gqmnHBRB3J80h2I3LIC7QoZ4X1LgE3L22EBTNJ
 kycvgBO5dJQfSMxQDQ6EgQe7Q=
X-Google-Smtp-Source: AGHT+IEZBIlep0zAMBwpGYNN0QcT4lKUl0QSDuGqZV1SJhyl7sDEXCAoE3G8K3TORIsnTmKf8LoJ8xKwKPHk7141cTc=
X-Received: by 2002:a17:907:970a:b0:ac7:4d45:f13e with SMTP id
 a640c23a62f3a-acad3494137mr340716266b.13.1744396264094; Fri, 11 Apr 2025
 11:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
 <20250409-livetree-fixup-v1-1-76dfea80b07f@linaro.org>
 <CAFLszTjLGv0a3W=hPW+pexa1ASaSrrKAcbRoo5cF_LChj-bizA@mail.gmail.com>
 <d807638b-c6ac-429f-b177-ce9427b504f6@linaro.org>
 <CAFLszTgEGd1hHS7D6C_Y8RMrkQ8k_+UgzvZO2zE6rhBizSQXBQ@mail.gmail.com>
 <6e9bb23d-566f-4047-8d02-58dc6170fb5c@linaro.org>
 <CAFLszTgyZ507jXXEcxWpY0V8LV90V2P7GhcH=2wS58cyGvR2dg@mail.gmail.com>
 <1c1bcd1e-bec5-4e6a-9f09-e1d2895969b3@linaro.org>
 <CAFLszTi30x=Qj82kXWfZnV1JjMXcdfxnUSYabyYeRRrgz4yeiQ@mail.gmail.com>
 <36c07837-6569-401d-9003-6735c64126a5@linaro.org>
In-Reply-To: <36c07837-6569-401d-9003-6735c64126a5@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 11 Apr 2025 12:30:52 -0600
X-Gm-Features: ATxdqUGXBoIhClazaes1HWGJErcsQ7_uohT1oJvRhJGfMv17vUws7HHvdOCmUH4
Message-ID: <CAFLszTjaZY_nBKtOjPVwFWXW4EhpN+FxX1TS7LjPvDWr9mrHpA@mail.gmail.com>
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

On Fri, 11 Apr 2025 at 05:52, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 4/10/25 23:25, Simon Glass wrote:
> > Hi Caleb,
> >
> > On Thu, 10 Apr 2025 at 09:41, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 4/10/25 16:15, Simon Glass wrote:
> >>> Hi Caleb,
> >>>
> >>> On Thu, 10 Apr 2025 at 08:04, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 4/10/25 15:07, Simon Glass wrote:
> >>>>> Hi Caleb,
> >>>>>
> >>>>> On Thu, 10 Apr 2025 at 07:00, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>>>>>
> >>>>>> Hi Simon,
> >>>>>>
> >>>>>> On 4/10/25 13:27, Simon Glass wrote:
> >>>>>>> Hi Caleb,
> >>>>>>>
> >>>>>>> On Wed, 9 Apr 2025 at 11:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>>>>>>>
> >>>>>>>> OF_LIVE offers a variety of benefits, one of them being that the live
> >>>>>>>> tree can be modified without caring about the underlying FDT. This is
> >>>>>>>> particularly valuable for working around U-Boot limitations like lacking
> >>>>>>>> USB superspeed support on Qualcomm platforms, no runtime OTG, or
> >>>>>>>> peripherals like the sdcard being broken (and displaying potentially
> >>>>>>>> worrying error messages).
> >>>>>>>>
> >>>>>>>> Add an event to signal when the live tree has been built so that we can
> >>>>>>>> apply fixups to it directly before devices are bound.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >>>>>>>> ---
> >>>>>>>>      common/event.c  | 3 +++
> >>>>>>>>      include/event.h | 9 +++++++++
> >>>>>>>>      lib/of_live.c   | 3 +++
> >>>>>>>>      3 files changed, 15 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/common/event.c b/common/event.c
> >>>>>>>> index dda569d447851f559a83f98fb7b1f3543156eab5..8d7513eb10b61919e1e784481dfdcc076be14986 100644
> >>>>>>>> --- a/common/event.c
> >>>>>>>> +++ b/common/event.c
> >>>>>>>> @@ -47,8 +47,11 @@ const char *const type_name[] = {
> >>>>>>>>             "ft_fixup",
> >>>>>>>>
> >>>>>>>>             /* main loop events */
> >>>>>>>>             "main_loop",
> >>>>>>>> +
> >>>>>>>> +       /* livetree has been built */
> >>>>>>>> +       "of_live_init",
> >>>>>>>>      };
> >>>>>>>>
> >>>>>>>>      _Static_assert(ARRAY_SIZE(type_name) == EVT_COUNT, "event type_name size");
> >>>>>>>>      #endif
> >>>>>>>> diff --git a/include/event.h b/include/event.h
> >>>>>>>> index 75141a192a48b0931667632f41be8ff4d6139f7c..3fc673ba635ed45467aae8587705d37bef1c2a3f 100644
> >>>>>>>> --- a/include/event.h
> >>>>>>>> +++ b/include/event.h
> >>>>>>>> @@ -152,8 +152,17 @@ enum event_t {
> >>>>>>>>              * A non-zero return value causes the boot to fail.
> >>>>>>>>              */
> >>>>>>>>             EVT_MAIN_LOOP,
> >>>>>>>>
> >>>>>>>> +       /**
> >>>>>>>> +        * @EVT_OF_LIVE_INIT:
> >>>>>>>> +        * This event is triggered immediately after the live device tree has been
> >>>>>>>> +        * built. This allows for machine specific fixups to be done to the live tree
> >>>>>>>> +        * (like disabling known-unsupported devices) before DM init happens. This
> >>>>>>>> +        * event is only available if OF_LIVE is enabled and is only used after relocation.
> >>>>>>>> +        */
> >>>>>>>> +       EVT_OF_LIVE_INIT,
> >>>>>>>> +
> >>>>>>>>             /**
> >>>>>>>>              * @EVT_COUNT:
> >>>>>>>>              * This constants holds the maximum event number + 1 and is used when
> >>>>>>>>              * looping over all event classes.
> >>>>>>>> diff --git a/lib/of_live.c b/lib/of_live.c
> >>>>>>>> index 90b9459ede313e492e28c8556c730f3bd8aaa9df..e1962b8f1fb9d8c2c87d04ca4e238a1e4d00376a 100644
> >>>>>>>> --- a/lib/of_live.c
> >>>>>>>> +++ b/lib/of_live.c
> >>>>>>>> @@ -10,8 +10,9 @@
> >>>>>>>>
> >>>>>>>>      #define LOG_CATEGORY   LOGC_DT
> >>>>>>>>
> >>>>>>>>      #include <abuf.h>
> >>>>>>>> +#include <event.h>
> >>>>>>>>      #include <log.h>
> >>>>>>>>      #include <linux/libfdt.h>
> >>>>>>>>      #include <of_live.h>
> >>>>>>>>      #include <malloc.h>
> >>>>>>>> @@ -334,8 +335,10 @@ int of_live_build(const void *fdt_blob, struct device_node **rootp)
> >>>>>>>>                     return ret;
> >>>>>>>>             }
> >>>>>>>>             debug("%s: stop\n", __func__);
> >>>>>>>>
> >>>>>>>> +       event_notify_null(EVT_OF_LIVE_INIT);
> >>>>>>>> +
> >>>>>>>
> >>>>>>> This should go in initr_of_live() since the function you are dealing
> >>>>>>> with here is supposed to just do the live build.
> >>>>>>
> >>>>>> Well, we only every call this function from one place right now, but if
> >>>>>> it was called multiple times for some reason then I would want to be
> >>>>>> able to re-apply fixups to the new live tree.... I guess it should
> >>>>>> probably pass in *rootp to the event handler, let me rework that.>
> >>>>>
> >>>>> There's no need to change the root, so what you have is find here.
> >>>>>
> >>>>>>> Same for the EFI_STUB thing which I just noticed, actually
> >>>>>>
> >>>>>> what EFI_STUB thing?>
> >>>>>
> >>>>> Oh, it's your EFI stub patch which isn't in Tom's tree yet. Just for
> >>>>> when you get to it, then.
> >>>>>
> >>>>>>> Also please check for error
> >>>>>>>
> >>>>>>> Otherwise this seems OK to me. I do wonder why we can't use
> >>>>>>> EVT_FT_FIXUP though. Could you add mention of that to your comment in
> >>>>>>> event.h?
> >>>>>>
> >>>>>> Because FT_FIXUP is for fixing up the flat tree before starting the OS?
> >>>>>> these are obviously different things imo, im not sure how i could
> >>>>>> clarify this.>
> >>>>>
> >>>>> Well, what is the purpose of your code? Are you saying that it is used
> >>>>> within U-Boot, but not passed to the OS?
> >>>>
> >>>> Yes, please read the cover letter and commit messages. FT_FIXUP allows
> >>>> for the FDT that is about to be passed to the OS to be fixed up,
> >>>> OF_LIVE_INIT signifies that U-Boot has finished building it's livetree.
> >>>> The livetree is obviously not used outside of U-Boot, being a totally
> >>>> custom in-memory representation of the DT.
> >>>
> >>> Oh, I wondered what '(which is not passed on to further boot stages)' meant.
> >>
> >> If you don't understand what my patch series does, it would save us both
> >>    a lot of time if you asked me to clarify some specific point than to
> >> reply with your stream-of-consciousness ponderings about what perhaps I
> >> might be doing.
> >>
> >> I've tried -- again -- to explain what we're doing here, comments below.
> >>
> >>>
> >>> Sorry, no, we can't do that.
> >> We have been for months already
> >>
> >>> We are moving towards using livetree in U-Boot
> >>
> >> indeed, mach-snapdragon has been using it for 372 days now
> >>
> >> commit 1534186f2953d99dcbc757a19b43e4fac644e8a9
> >> Author: Caleb Connolly <caleb.connolly@linaro.org>
> >> Date:   Wed Apr 3 14:07:49 2024 +0200
> >>
> >>       qcom_defconfig: enable livetree
> >>
> >>> - there is already the fixup thing as mentioned.
> >>
> >> The FT_FIXUP event which has absolutely nothing to do with livetree or
> >> this patch series and which is triggered at a different point in the
> >> boot process for an entirely different purpose (preparing for the OS
> >> rather than preparing for U-Boot itself)?
> >>
> >>> We just don't yet have the flattening at the end before boot.
> >>
> >> Which is exactly what we leverage in mach-snapdragon to bridge the gap
> >> between U-Boot (a bootloader that intentionally has a simplified model
> >> of the hardware) and upstream DT which contains a lot of additional
> >> context which is (as far as U-Boot is concerned) noise that we have to
> >> filter out.
> >>
> >>   > If you have time you could look at that.
> >>
> >> this is something literally nobody wants that wouldn't even be used in
> >> most cases (since EFI DT FIXUP protocol passes you an FDT anyway).
> >>
> >>>
> >>> Your event to modify the livetree is fine, but any modifications
> >>> should be passed on to the OS.
> >>
> >> As stated clearly in the commit message and the cover letter, making
> >> modifications that don't get passed on to the OS is the entire point.
> >>
> >> Assuming you didn't take the time to look at mach-snapdragon/of_fixup.c,
> >> it is literally rewriting the livetree to patch out the USB superspeed
> >> phy and only initialise USB in high-speed mode. This is quite simply
> >> because U-Boot doesn't have PHY drivers for superspeed USB on Qualcomm
> >> platforms yet.
> >>
> >> We absolutely don't want this to be passed on to the OS because it is
> >> entirely an implementation detail in U-Boot. It's functionally All this
> >> additional complexiequivalent to adding a bunch of "#ifdef
> >> ARCH_SNAPDRAGON" ... "skip the superspeed phy" in the dwc3 driver.
> >>
> >> This is really basic abstraction, and hopefully you'll tell me that I
> >> didn't need to explain all this because you did in fact take the time to
> >> understand how mach-snapdragon is using the livetree before replying
> >> (like by reading the big comment at the top of of_fixup.c).
> >>
> >>> If you don't want that, then your fixup would need to remove them, I suppose.
> >>
> >> why why why???
> >>
> >>   > Does the OS actually care, though?
> >>
> >> The OS would almost certainly be unhappy at the tree U-Boot is using
> >> internally yes, because we don't bother fixing up stuff like the
> >> usb-connector nodes which are unused in U-Boot.
> >>
> >> I know, I seem very frustrated, and I am. I have no problem with you
> >> misunderstanding a patch or asking for clarifications, but you keep
> >> repeatedly misunderstanding fundamental technical realities of an issue
> >> or patch series and then seemingly doubling down and just saying
> >> whatever comes to mind without exerting any effort to understand the
> >> other side.
> >>
> >> ----
> >>
> >> You didn't ask, but I'm going to explain how I review patches to
> >> hopefully convey some of my confusion here because I'm worried this is a
> >> pattern that is repeating itself and it is starting to wear on me. I've
> >> never been one to beat around the bush I guess.
> >>
> >> My first thought when I don't understand some change a patch is making
> >> is "huh I wonder why they did that instead of this", but you will never
> >> see me say that verbatim on the lists because I immediately go and read
> >> the code to remind myself what it is doing and validate any assumptions
> >> I might be making, as well as to try to understand the thought process
> >> of the author.
> >>
> >> What you WILL see me say on the lists is either
> >>
> >> 1) A (usually backed up by references) explanation of why I think the
> >> change is wrong, or
> >>
> >> 2) If I'm really confused I'll usually try to explain what I think
> >> they're trying to do (again backed up by code references where relevant)
> >> and ask for clarification.
> >>
> >> This way in (1) the author can say "oh yeah my bad, thanks for noticing
> >> that" or point out what I missed that makes their change make sense.
> >> This is easy, painless, everyone can go about their day (unless there is
> >> a technical disagreement, but really that's besides the point here)
> >>
> >> In the second case, they can confirm that my understanding is correct
> >> and respond to my (typically pointed) questions to clarify both how they
> >> understand the code and whatever context I'm missing. Assuming I'm any
> >> good at asking the right questions, this results in the same outcomes as
> >> (1).
> >>
> >> This works because I'm trying to bridge the gap between my understanding
> >> and the patch authors, I have my own mental model of how things work but
> >> it could be wrong, so I want to convey what my model is so that it can
> >> be corrected in that case, and so that if the authors understanding is
> >> wrong then they can correct it.
> >>
> >> Your reviews don't do this, they leave me guessing wildly at what you
> >> might possibly think my code is doing.
> >>
> >> There is no polite way for me to say "this comment you made is so out of
> >> left field that I think you fundamentally misunderstand this patch", but
> >> if you tell me what you think I'm trying to do (if you're at all
> >> unsure), so I know what foundation you're working on, then I can easily
> >> and politely say "ah your understanding here is wrong", you can re-do
> >> your review with a correct mental model and I don't have to try and
> >> parse things the way I have done above.
> >>
> >> If I were to go as far as to define a rule for patch review, it would be
> >> "whenever the words 'i wonder' go through your head, try to find out
> >> before sending your reply, and include your findings if you don't find a
> >> satisfactory answer"
> >
> > I'm sorry for upsetting you and I really hope I can improve the
> > situation here. I also really appreciate you taking the time to write
> > all these details.
>
> Thank you>
> > It is true that I struggle to find time for reviews at the moment, all
> > in my spare time. Even then, I just checked and I am number two in the
> > review tags for the most recent release. I am definitely pulling my
> > weight here. Also I have knowledge of many of the subsystems. Yes I
> > wish I could dig in and understand things more and I will try to do
> > better. But my intentions are good.
>
> I wouldn't have taken the time to reply if I thought otherwise.
>
> >
> > Here is how U-Boot should (eventually) work:
> >
> > Flat DT
> >      |
> > unflattened
> >      |
> > used in U-Boot               some-other-DT-packaged-with-OS
> >      |                                       /
> >      |                                   /
> > this is where the fixups happen
> >      |
> > flattened
> >      |
> >      |
> > passed to Linux
> >
> > The branch is due to the fact that the OS may have a better
> > devicetree, but ideally, in the fullness of time, the devicetree
> > provided by firmware would be good enough.
>
> we're on the same page here, though you're glossing over the complexity
> of potentially un-flattening an OS-provided DT, doing fixups, and then
> flattening again, maybe the cost is small enough that this is acceptable
> for the relative simplicity, but only if ALL boards can migrate to this
> approach.>
> > I don't believe it is a good idea for U-Boot to use its own
> > devicetree, separate from the Linux one. U-Boot should use the same
> > one. That is the idea behind the dts-upstream feature in U-Boot, to
> > make that easier.
>
> Right, and this has been a huge success for Snapdragon. But there are
> cases like I described above where the Qualcomm drivers in U-Boot are
> lacking, and we need to "simplify" some interfaces, like removing
> superspeed from USB.
>
> We can do this with really gross driver code, or we can have some
> relatively clean code that rewrites the live-tree. I picked the latter
> approach and leveraged the *convenience* that we can do this rewriting
> and not have to undo it because the livetree is not flattened again.
>
> This code is already in mach-snapdragon and in use, you're now telling
> me that in the future we want to flatten the live-tree and pass it to
> the OS -- ok, sure, whatever, but we cannot do this on mach-snapdragon
> because the livetree that U-Boot is using has been patched in ways that
> would break the OS.
>
> I am certain that we will find ways around this, like a generic way to
> do reversable hot-patches on the livetree (dynamic overlays I guess), or
> just something less elegant like having two copies of the livetree
> internally.
>
> But what I've got from you is "no, you can't do what you're doing
> because it doesn't align with my vision" and I just don't think that's
> the right way to go about this.

Well there are two things here:
- what you want to do for your particular board
- how you want to change the semantics of livetree/flatree in U-Boot

A simple (alternative) way to solve this would be to add a flag for
USB3 to struct usb_plat, set it in your board code (after devices are
bound) and then update the USB driver to respect the flag.

>
> >
> > For the EVT_FT_FIXUP event, the intent is to do fixups on the livetree
> > as it should be more efficient. There's a lot of existing code that
> > uses the flattree and I haven't figured out a clever way to migrate
> > it.
> >
> > But overall, the way to think of the livetree and flattree is that
> > they are the same tree. We can unflatten, modify and flatten, but not
> > unflatten, modify and throw away. We certainly don't maintain two
> > separate trees within U-Boot.
>
> In an ideal world this would be great, and I can appreciate why this
> mental model is appealing. But it isn't how U-Boot works today, and it's
> something we'll have to move towards. Maybe the dynamic overlays idea I
> mentioned above would be a good compromise?
>
> I believe I understand how you see things and want them to work, I see
> the reality (and potential compromises) as a superset of your view. I
> think there are some assumptions I glossed over that could have made
> that clearer.
>
> >
> > I suspect the main problem is that this part of U-Boot is in slow
> > transition. Perhaps some better documentation of the eventual state
> > would help?I think it would be better to propose your ideas in a way that ties in
> to what boards are doing today, and offers tangible benefits. The
> livetree could simplify a lot of FDT wrangling in U-Boot, dynamic
> overlays could be an appealing way for vendors to handle different SKUs,
> something like that?
>
> So far the primary motivation I see from you is that this is what you
> think makes sense, but then you totally ignore how much worse it
> actually makes it for mach-snapdragon.
>
> For a while (as you can see in this series) we had DTS overrides in
> U-Boot for some boards that we manually undid in ft_fixup, literally
> just for one property, and it was a total PITA.
>
> The way I see it, the livetree is U-Boots internal representation of the
> DT and NOT something to pass on to the OS. It is literally "live". The
> desire to have U-Boot function with upstream DT without modifications is
> self-evident, obviously we want this, Qualcomm was the first to adopt
> OF_UPSTREAM (ahead of time, even).

That's incorrect, though. The livetree is the 'only' tree - the
flattree should have gone away. You are actually using a back door
here. When it goes away, what will you do?

>
> However, once the FDT gets handed over to U-Boot, what U-Boot does
> internally should be treated like a black box (as we do for other
> consumers of DT). If U-Boot wants to only read the board compatible and
> then hardcode literally everything else per-board, so be it. U-Boots
> internal abstractions (like the livetree and the ability for board
> specific code to mess with it before drivers parse it) should have
> absolutely no bearing on whatever code comes after it.
>
> To me this is obvious, and is the assumption I've been working from but
> I really should have made that explicit earlier.
>
> Through that lens, I do really disagree with your idea that we should
> treat the DT as something pure to merely be looked at (and maybe
> tweaked) before being passed to the next stage. I think it's absurd to
> justify clobbering a perfectly good abstraction that U-Boot has today
> (whether intentionally or not).

I have no issue with changing the devicetree. It's the idea that it is
a temporary thing that is the problem. Once we are doing fixups in the
livetree, what do we do with your changes? They need to be reverted in
the DT fixups, I assume.

>
> >
> > If you are still unhappy, how about we organise a call to discuss
> > this? I really don't think we are on the same page at all right now.
> > It might help to reduce frustration.
>
> Sure, I'd be happy to have a call next week to flesh out whatever our
> differences are and clarify what I've said above. I don't doubt that
> we'll be able to find a solution that doesn't involve doing away with
> our ability to abstract away board-specific requirements from generic
> drivers.
>
> Today we do this livetree fixup already, but in between
> dm_bind()/of_to_platdata() and dm_probe() which is actually super duper
> brittle, because some properties have already been parsed. Introducing
> this event will let us make it much less brittle (and is required to
> change some of the properties I want to change with this series), can we
> please get this in?

Right, I don't like that either.

I suppose this issue is caused by dts-upstream, since in U-Boot we
could normally just change the dts temporarily. How come you can't use
a u-boot.dtsi file to make the changes?

>
> I'll re-send this series (picked it a little prematurely, sorry for
> that) to fix the missing error check and add some data to the event
> (namely the root node pointer).
>
> Whenever we get around to implementing your proposal to do fixups for
> the OS via livetree, perhaps a good migration path would be to have the
> OF_LIVE_INIT event also signal the intended use of the tree (for U-Boot
> or for the OS), then board using the FT_FIXUP event today can switch to
> using OF_LIVE_INIT and checking that property.
>
> But for now I'd like to leave that out of scope if that's ok.

That's an interesting idea, having a tree that has been hacked for
U-Boot only, while keeping a second tree around that we will use for
fixups. I can definitely see situations where it could be useful.

It might be confusing / inefficient to have multiple trees, though.
Wouldn't we just want to change a few nodes and then revert them
later? But that is probably brittle, or annoying, as you say. So I
think multiple trees for this case makes at least some sense to me.
It's the sort of thing that could be useful in the early days of a
board's bringup.

Anyway, if you were willing to do that as a follow-up then I would
normally be OK with your series and I'm quite happy to have it in my
tree, since I can change it later if needed. But for Tom's tree I am
concerned that:

- I won't be able to change things later (e.g. by making fixup from
livetree work, which you are not offering to do and fair enough),
since any patch that Linaro objects to doesn't go in to Tom's tree
(EFI, bloblist, devicetree, etc.)
- various of my series have been blocked by work that I have offered
to do in future but Tom has required that I do first (including
Linaro's lwip)

So yes, I suggest we have a call at some point to talk through the
options, e.g. I might be able to contribute a few patches to help
here, once I have your ideas from some of my questions above. I'm free
from Tuesday next week.

Regards,
Simon
