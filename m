Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA824C369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 21:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EB4782DB8;
	Thu, 17 Apr 2025 23:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HG1K7jiz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAF2883086; Thu, 17 Apr 2025 23:37:22 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8770C82CF1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 23:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-abbd96bef64so198758566b.3
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 14:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744925840; x=1745530640; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UpsgRjn+SWc9QzeUgQHYdbCXgxnbH2cwVhrwxHCNy+0=;
 b=HG1K7jiz6/3lKCC5i5r1RlJs80XyF4PyfyFMlacixtAT36o+6bcWE2AnpoCBB8+9Og
 3pPtQ78xOZ09e63seraeEi51yVfxvRJmujtFV85N8qh7G+XjiezIk0fDDGqQlnIJ9mO/
 KwsrJG3so1/rC+LEg7y5xL0QdNNEKc3NPGEmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744925840; x=1745530640;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UpsgRjn+SWc9QzeUgQHYdbCXgxnbH2cwVhrwxHCNy+0=;
 b=L+MFj0R2RD0Q60vkGB98EI+m3ADspxagjRFuRZLBQmI6XuxeWrr+ojDPFtbVAAJD0D
 m2T27Q6Hh41F5ZfRbi1LV1EEt3ULbbFKZyYoRZLz/aRreP9YkUirnJrfEdNoosIqhIzO
 Hrru3dD3xpc/uGUHKf5ZN9KjoQCbTEWI3fkIHOUUtsy+xQugon+UJU9nMGU0dePvJgpe
 WcUdcB7PSh+7LRz8xDrHgEfdLzJkh9Xa4/Ar5FgY2Pa7oYKLOwLiYgvGTBgLst7k8aR/
 w/sDWKbbHmXopXGluy2gBz05b5gZKajnlEuKMX/8DXqSIVZjecgW+ZR6kaUrv3KyZsp4
 ih2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtWx+4mmijfmYkd9yUdVA12VhifjTLKnz3Ahx5P5IetM8iXDToQDwtiz/YwcaI6TVWLB0NSFc=@lists.denx.de
X-Gm-Message-State: AOJu0YzQHNG2+mzqTKMXau8Hr88DPMA+Qx/hfRHGyRfoe3J0BaA/9SfA
 n5EPyM2oVN1eG8wK/6AEGWATY+e7NfM16Fs3Jbh38QaaJYzOndSsa5mEti3qCrYnZ2+NP8dsVyz
 mzr7Rh4NZPRGwCK9sj9moTljBFLv3y0PDL++9
X-Gm-Gg: ASbGncvcnqk/P0BusYPLEXZkwRyZU4TbmRsIn2/LwK5EMmpcimpXppSWQS+X1Gnij5+
 6HPG+cNwZmma0DIMq4r9lqKTvvHkmcN18ozqilSnieVgMFfWfrFf9UVq/o75kzuwr6rTht5f6Ik
 udc8YHAPhN5O3QudtJAajvZ2Q=
X-Google-Smtp-Source: AGHT+IHbuAY2yF9r1fG+b7T4ZmY+r/8NngBmnBMvMjrtTNQ/ILo8y+F5YRET6MiSG7eCWBIE0p6/1cs1vGiI/4NGaJw=
X-Received: by 2002:a17:907:2da5:b0:aca:d571:7790 with SMTP id
 a640c23a62f3a-acb74b2e840mr38378666b.16.1744925839842; Thu, 17 Apr 2025
 14:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
 <20250411-livetree-fixup-v2-1-1236823377bb@linaro.org>
 <CAFLszTg9d97fFaosbCfQqCyBHivfn00S01_0wK9mB3RXZ7VbRA@mail.gmail.com>
 <e8a45df8-d71e-4e2f-8b4b-440684438c06@linaro.org>
In-Reply-To: <e8a45df8-d71e-4e2f-8b4b-440684438c06@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Apr 2025 15:37:07 -0600
X-Gm-Features: ATxdqUEwYHooYh2gM9nGHNbYSLViaZ8YmQhp4Dk8-RUrmZJYswS9d3oFcrpajkE
Message-ID: <CAFLszTjwL0dpyy3hX55_bQDZ8U3RcZPF54tCgup+=_+cme4CJA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] event: signal when livetree has been built
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

On Mon, 14 Apr 2025 at 06:33, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Simon,
>
> On 4/11/25 20:27, Simon Glass wrote:
> > Hi Caleb,
> >
> > On Fri, 11 Apr 2025 at 06:47, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >> OF_LIVE offers a variety of benefits, one of them being that the live
> >> tree can be modified without caring about the underlying FDT. This is
> >> particularly valuable for working around U-Boot limitations like lacking
> >> USB superspeed support on Qualcomm platforms, no runtime OTG, or
> >> peripherals like the sdcard being broken (and displaying potentially
> >> worrying error messages).
> >>
> >> Add an event to signal when the live tree has been built so that we can
> >> apply fixups to it directly before devices are bound.
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >> ---
> >>   common/event.c  |  3 +++
> >>   include/event.h | 18 ++++++++++++++++++
> >>   lib/of_live.c   | 11 +++++++++++
> >>   3 files changed, 32 insertions(+)
> >>
> >> diff --git a/common/event.c b/common/event.c
> >> index dda569d447851f559a83f98fb7b1f3543156eab5..8d7513eb10b61919e1e784481dfdcc076be14986 100644
> >> --- a/common/event.c
> >> +++ b/common/event.c
> >> @@ -47,8 +47,11 @@ const char *const type_name[] = {
> >>          "ft_fixup",
> >>
> >>          /* main loop events */
> >>          "main_loop",
> >> +
> >> +       /* livetree has been built */
> >> +       "of_live_init",
> >>   };
> >>
> >>   _Static_assert(ARRAY_SIZE(type_name) == EVT_COUNT, "event type_name size");
> >>   #endif
> >> diff --git a/include/event.h b/include/event.h
> >> index 75141a192a48b0931667632f41be8ff4d6139f7c..1d267f1d10547642d381fa287ab4981a2bf03543 100644
> >> --- a/include/event.h
> >> +++ b/include/event.h
> >> @@ -152,8 +152,17 @@ enum event_t {
> >>           * A non-zero return value causes the boot to fail.
> >>           */
> >>          EVT_MAIN_LOOP,
> >>
> >> +       /**
> >> +        * @EVT_OF_LIVE_BUILT:
> >> +        * This event is triggered immediately after the live device tree has been
> >> +        * built. This allows for machine specific fixups to be done to the live tree
> >> +        * (like disabling known-unsupported devices) before it is used. This
> >> +        * event is only available if OF_LIVE is enabled and is only used after relocation.
> >
> > Add a bit more detail, e.g.: before it is used by U-Boot
> > post-relocation. This means it is possible to affect the devices bound
> > by driver model.
>
> I think this is really implied and made obvious by context clues. IF
> there comes a time where we build the live tree more than once (e.g. to
> build it as part of the DT_FIXUP_PROTOCOL for some reason) then the
> extra info you propose adding would no longer be correct, where the
> current wording would remain correct.

OK, leave it alone if you like.

>
> >
> > You should also note that the flattree is inactive when livetree is
> > used and any changes may eventually be passed onto the OS, if it
> > doesn't have its own devicetree. This is the point we were discussing
> > on the other thread.
>
> This information is totally irrelevant though, and there is no broad
> agreement with your proposed changes. The livetree API is also set up so
> that one could build multiple livetrees (for whatever reason), this
> event is modelled to reflect that (where you can see in my v1 patches
> that the event assumed you would only ever build the global tree).

Hmmm, if Linaro is going to block livetree fixups then we are going to
have a problem. I have not heard that, but let me know.

>
> >
> >> +        */
> >> +       EVT_OF_LIVE_BUILT,
> >> +
> >>          /**
> >>           * @EVT_COUNT:
> >>           * This constants holds the maximum event number + 1 and is used when
> >>           * looping over all event classes.
> >> @@ -202,8 +211,17 @@ union event_data {
> >>          struct event_ft_fixup {
> >>                  oftree tree;
> >>                  struct bootm_headers *images;
> >>          } ft_fixup;
> >> +
> >> +       /**
> >> +        * struct event_of_live_built - livetree has been built
> >> +        *
> >> +        * @root: The root node of the live device tree
> >> +        */
> >> +       struct event_of_live_built {
> >> +               struct device_node *root;
> >> +       } of_live_built;
> >>   };
> >>
> >>   /**
> >>    * struct event - an event that can be sent and received
> >> diff --git a/lib/of_live.c b/lib/of_live.c
> >> index 90b9459ede313e492e28c8556c730f3bd8aaa9df..c1620616513c2e32448b4a6d156a9162d97c76b7 100644
> >> --- a/lib/of_live.c
> >> +++ b/lib/of_live.c
> >> @@ -10,8 +10,9 @@
> >>
> >>   #define LOG_CATEGORY   LOGC_DT
> >>
> >>   #include <abuf.h>
> >> +#include <event.h>
> >>   #include <log.h>
> >>   #include <linux/libfdt.h>
> >>   #include <of_live.h>
> >>   #include <malloc.h>
> >> @@ -320,8 +321,9 @@ int unflatten_device_tree(const void *blob, struct device_node **mynodes)
> >>
> >>   int of_live_build(const void *fdt_blob, struct device_node **rootp)
> >>   {
> >>          int ret;
> >> +       union event_data evt;
> >>
> >>          debug("%s: start\n", __func__);
> >>          ret = unflatten_device_tree(fdt_blob, rootp);
> >>          if (ret) {
> >> @@ -334,8 +336,17 @@ int of_live_build(const void *fdt_blob, struct device_node **rootp)
> >>                  return ret;
> >>          }
> >>          debug("%s: stop\n", __func__);
> >>
> >> +       if (CONFIG_IS_ENABLED(EVENT)) {
> >> +               evt.of_live_built.root = *rootp;
> >> +               ret = event_notify(EVT_OF_LIVE_BUILT, &evt, sizeof(evt));
> >> +               if (ret) {
> >> +                       log_debug("Failed to notify livetree build event: err=%d\n", ret);
> >> +                       return ret;
> >> +               }
> >> +       }
> >> +
> >
> > This should move to the caller of this function. We should also have a
>
> Why move it to the caller? Then every caller would need to signal the
> event and we'd pointlessly duplicate code. The event signals that /a/
> livetree has been built. Today this only happens once and we make the
> assumption that this livetree is to be used by U-Boot and only U-Boot.
>
> Should this assumption become incorrect in the future, it would be
> trivial to introduce a variable to the event_data that describes what
> the livetree is and/or where it will be used so that anyone catching the
> event can decide what to do.
>
> Since we don't yet know any other usecases, it would be overzealous to
> try and capture this information since we just don't know what's important.

There is (and will only ever be) one caller. At this point I really
don't mind what you do.

>
> > sandbox test for this feature, e.g. catch the event and add a
> > node/prop and check in a test in test-fdt.c (or similar) that it is
> > present.
>
> What would this test other than that the event is sent? We already have
> tests for the event framework...

If the CI tests pass, then it's fine.


>
> >
> > I'm not sure if you need to update test_event_dump.py but since CI
> > presumably passes, I guess not.>
> >>          return ret;
> >>   }
> >>
> >>   void of_live_free(struct device_node *root)
> >>
> >> --
> >> 2.49.0
> >>

Regards,
Simon
