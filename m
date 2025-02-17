Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC076C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 13:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 655B780CB0;
	Mon, 17 Feb 2025 14:16:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Nm6lI2hw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0327B80104; Mon, 17 Feb 2025 14:16:41 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C1A080CB0
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 14:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ab7430e27b2so742540766b.3
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 05:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739798198; x=1740402998; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EP3vHgv/N4hxlBW/LZRJxAZwuvufFF7Tz+xM+wq+qDw=;
 b=Nm6lI2hwzQg3XimzZ2D/wHOq0Qo5I6xuAgZgdDoicDtrk8nNRprIqCuEUUKDPtxFsX
 XqKNuTT0r/Gq2Er3kEfsx2sWA/rT46JvDeo9JhttVs1wJSTR3TqBlS3S2/fbc5P9HQxi
 VU0SXo7RAAGdvfF/pL2/j1PP+jwG6CofYmsQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739798198; x=1740402998;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EP3vHgv/N4hxlBW/LZRJxAZwuvufFF7Tz+xM+wq+qDw=;
 b=uD6yT6wZ93r5osW9mQpk1oy5MVVeFH2N4NJ+C8osGyWpZrKg4hzqzmhflWGpiGK8ll
 2Sd50kUhA9kg3Uu5aY6JSTdajgkslSC9FNihy65mQm5SK1GS9qqAXJ08akUXEj67CYS1
 /z45pZq5NMxOMQmmlRtfeX+hWtkcrAmH6obBi7kyS6iOtw3TiGWqxxvoyV7V4iAvZtQn
 7y7+3zEuFZXrCPUuPf+pjGBb+UA1EfgPMHtUeVtuptzSPus8VuDBGyFB58H+e68VzHia
 fppstdIk+HNzzylohg4DHF8IE0+F2hrkkdRr7SaWJxFKMeXN2Z0LXE3Z1p6DJ7NEx4bH
 Jm4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjQwWeqhEymc+iJQ4f2p6w9gKVp0kdLOhze0pBMvSKAcoG+3zASlBC7B6ceLsqAX8StuhmpU4=@lists.denx.de
X-Gm-Message-State: AOJu0YwpzAxhFMv1G+HMdXAYzRPUkWa90yvEy9//V/uTlDCFdrqjdS/x
 bCcnH73GB2b3p69HlnMGaK7cQgkpLVRl5cAJf2BALlz8eYr4H89ED+BMC/dMz5fSBCL8xxeJ0BB
 EoPM0aoUhCebWUkG9YCnYWwsuH+GhAQAVRddD
X-Gm-Gg: ASbGnctO8HlebunVibCv2CBPhAjixtUUb2+IW0AOet0OXo+Pi0P9le4r4HIsUukMjDG
 HtYFczYPNETflpZqD4sxJxrFRVUgTpsXjj+PAOjXPbM3p9BHHDI7pOAKKxjZjnpIk7AnG+RMl6Q
 ==
X-Google-Smtp-Source: AGHT+IFsmTrsHqBrvddodbNyDVZNbHkR4CFxwGTktyXa3m6Jw4rmEqvILWkr+hb6v476a5NZyAmDb991AFOaWgswHKg=
X-Received: by 2002:a17:907:9486:b0:ab7:f8b3:d962 with SMTP id
 a640c23a62f3a-abb709213b3mr953063566b.6.1739798197927; Mon, 17 Feb 2025
 05:16:37 -0800 (PST)
MIME-Version: 1.0
References: <20250211135829.3467088-1-fiona.klute@gmx.de>
 <CAFLszTgiA3_SsQEPg_+denTdJ3hMrWyKPsQUho5=EjeOF_W5XA@mail.gmail.com>
 <5654352d-3919-4fa7-855f-b0d8a2dde84f@suse.com>
In-Reply-To: <5654352d-3919-4fa7-855f-b0d8a2dde84f@suse.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 17 Feb 2025 06:16:24 -0700
X-Gm-Features: AWEUYZnARk6_vrV4vNkEJ84CxHczHUdZ4WcU36SeRU5OER75tuQdoGq2nkiDlvw
Message-ID: <CAFLszTh7E7MqotWEtO3FLmK8JPhR0EvyW_WQ2iA4HtKFqdjLLw@mail.gmail.com>
Subject: Re: [RFC] Raspberry Pi: copy /system/linux, {serial,
 revision} from firmware
To: Matthias Brugger <mbrugger@suse.com>
Cc: Fiona Klute <fiona.klute@gmx.de>, u-boot@lists.denx.de, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Matthias,

On Mon, 17 Feb 2025 at 01:10, Matthias Brugger <mbrugger@suse.com> wrote:
>
>
>
> On 15/02/2025 13:05, Simon Glass wrote:
> > Hi Fiona,
> >
> > On Tue, 11 Feb 2025 at 07:56, Fiona Klute <fiona.klute@gmx.de> wrote:
> >>
> >> Both the Raspberry Pi downstream kernel [1] and some userspace tools
> >> [2] use the revision property to identify the board, and the latter
> >> fails if it is absent. The firmware creates the /system node, so we
> >> need to do the same.
> >>
> >> [1] https://github.com/raspberrypi/linux/blob/0f292fbb6346b05766152902076895558ac23f9a/arch/arm/mach-bcm/board_bcm2835.c#L23-L33
> >> [2] https://github.com/jgarff/rpi_ws281x/blob/7fc0bf8b31d715bbecf28e852ede5aaa388180da/rpihw.c#L579
> >>
> >> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> >> Cc: Matthias Brugger <mbrugger@suse.com>
> >> Cc: Peter Robinson <pbrobinson@gmail.com>
> >> Cc: Tom Rini <trini@konsulko.com>
> >> ---
> >> I'm sending this as RFC because I'm not sure if creating a temporary
> >> overlay is the best approach here, advice on a better way to create the
> >> /system node if needed is very much welcome. I know I'll need to add
> >> more error checks, I'll do that after I know I have the right approach.
> >>
> >>   board/raspberrypi/rpi/rpi.c | 37 +++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 37 insertions(+)
> >
> >  From my side, if my rpi seriesl[1] results in my becoming a rpi
> > maintainer, I'll take a look at this and other pending rpi patches.
> >
>
> I think your review would be highly valuable, being a maintainer or not.
> I'm not sure what conditions the maintainer role with doing a review.
> Actually the normal road for getting a maintainer starts with reviewing patches.
>
> Handle that as you like, I was just puzzled by your message.

Point taken. I've been scaling back my reviews mostly to things I
directly maintain.

I hope it would not be impolite if I express my puzzlement as well,
that you took the time to reply to my email but not to review the
patch :-)

>
> Regards,
> Matthias
[..]

Regards,
SImon


> >> +       fdt_overlay_apply_verbose(fdt, fdto);
> >> +}
> >> +
> >>   /* Copy tweaks from the firmware dtb to the loaded dtb */
> >>   void  update_fdt_from_fw(void *fdt, void *fw_fdt)
> >>   {
> >> @@ -560,6 +595,8 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
> >>          /* The firmware provides a more precise model; so copy that */
> >>          copy_property(fdt, fw_fdt, "/", "model");
> >>
> >> +       copy_system_node(fdt, fw_fdt);
> >> +
> >>          /* memory reserve as suggested by the firmware */
> >>          copy_property(fdt, fw_fdt, "/", "memreserve");
> >>
> >> --
> >> 2.47.2
> >>
> >
> > Regards,
> > Simon
> >
> > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=437666
>
