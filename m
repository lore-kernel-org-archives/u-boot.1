Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3185C021BB
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 13:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C919C80F92;
	Tue, 25 Feb 2025 14:04:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hvEce2w+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3432C80F96; Tue, 25 Feb 2025 14:04:43 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF55280FC2
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 14:04:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2fc32756139so8606014a91.1
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 05:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740488679; x=1741093479; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JPCP33IL2VwlwUfSNVL6TGCk8PpZlt6vyx2sPeCbeKE=;
 b=hvEce2w+imRya2W2qOCqRD+kOZ00LAge7lQ2b8T4E/WGgLJdfoZHpH/h92ifYL9TD3
 e02IypbVOQRDA7BjoQD6sa4COKNLeRDaIwjm4nfe3DONTTb6oIZ3asg8jn0DFZcszdHr
 0So+0sw6c2TfyDjs5RjRm7VY3bov3eEtL3p1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740488679; x=1741093479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JPCP33IL2VwlwUfSNVL6TGCk8PpZlt6vyx2sPeCbeKE=;
 b=ZOsbheH5uTlbFajRJY1cHb3q5fxjS4zXgmhtiP2j7MLySnKetAEFI8dXmb2fZ+9yIX
 4YZ+icOXx7kFgaJW0P+SVlCcimq/i0R4G+x7dQ1kHJeDl5Ma+z9uWjrY8bDCa+WYDsa5
 x+190I7GFfJ8lKj3/SbTtG+uZLxwef9Oh0C0rTMzGv7NPvYvBqX1GWJyv8MIgWBSpqmg
 gcDPOd5MU446Kb6nBi/8EWI9slu8t3WR5ik4RryqEZEdEXcsV0dGiCr926Vup2uOUlK0
 DxErWR8bXsAbTXvpa180gyiE5aAiRLQbWsmj9apRaRMznZaCmlC59Ces2+D53aw/wKlt
 Kvkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRD4QymzSaPMCRqr6pP+BHkGE/AIGAXhkKVJnWunGj6NboWds6WdgLgEU9In9Pxzd1ZxoBZCo=@lists.denx.de
X-Gm-Message-State: AOJu0YwNVD7dkG+d9c04PI/LTg9Nn5Bs8e5v/qsec67xTztA5iSTv7qn
 4Djb5kgBU60YXGaaQzlbzYUij9HiAHR4/uGeu7eryxz8PHrPSMgip7VPeJbOQOcPntGNkHb6Ufx
 QNSh0IRSRERBl5H0zPMs412JeK/qFDStfAZFj5vHmQIUq/aU=
X-Gm-Gg: ASbGncunmpqP4TprrCTuElQvRooLItJuz2vN8XmpwlUanpIk0I+8panawvhoJuHunMl
 CWS0e9v6tAGBaAL4cLdlZBNG//JSWjQ/N875wHIznn+qjj+l6PdiyKu5XaFY82SFU+o3T2AiNf9
 RnzlgawcXQ
X-Google-Smtp-Source: AGHT+IFlu3rMKC6Stnw7zG9tXJ+dh4cXyycbhz7sTxdxV8lvxtP/LEY5u7NYyzdYwRdZhS+vHscMJ4q1lip9zjo4VRo=
X-Received: by 2002:a17:90b:2b8b:b0:2fc:350d:9ee7 with SMTP id
 98e67ed59e1d1-2fce86ae630mr29568473a91.11.1740488679176; Tue, 25 Feb 2025
 05:04:39 -0800 (PST)
MIME-Version: 1.0
References: <20250220205900.3127680-1-swboyd@chromium.org>
 <20250220205900.3127680-5-swboyd@chromium.org>
 <20250221010658.GD1233568@bill-the-cat>
 <CAE-0n51YEq9VyJ94NsF0ovNh-pturMBKe89W+W7cPdQpbJoVsw@mail.gmail.com>
 <3db43c95-75a2-4416-93ce-d0aacb542193@linaro.org>
In-Reply-To: <3db43c95-75a2-4416-93ce-d0aacb542193@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Feb 2025 06:04:15 -0700
X-Gm-Features: AWEUYZmI1A8uMCUndqzqKWCsuyeVFBZK__lMPLjMTs_jpmX1rX1JaKJDEISu5_A
Message-ID: <CAFLszTgzx1YmpHuF1WR5-HPkC08oKfp+4ybEZiOMbk1FLV5UNA@mail.gmail.com>
Subject: Re: [PATCH 04/12] coreboot: Move coreboot logic out of x86 to a
 generic place
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Stephen Boyd <swboyd@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Anatolij Gustschin <agust@denx.de>,
 u-boot-qcom@groups.io
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

Hi,

On Mon, 24 Feb 2025 at 08:16, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 2/22/25 01:17, Stephen Boyd wrote:
> > Quoting Tom Rini (2025-02-20 17:06:58)
> >> On Thu, Feb 20, 2025 at 12:58:46PM -0800, Stephen Boyd wrote:
> >>
> >>> Lay the groundwork to run U-Boot as a payload on ARM coreboot based
> >>> devices. Move the coreboot table parsing code out of arch/x86 into
> >>> lib/coreboot. The headers like cb_sysinfo.h and coreboot_tables.h need
> >>> to be globally accessible, so move them into the top level include
> >>> directory. Introduce helper functions like
> >>> board_get_usable_ram_top_from_coreboot(), dram_init_from_coreboot(), and
> >>> dram_init_banksize_from_coreboot() so that boards can still override
> >>> these common functions while also supporting booting as a coreboot
> >>> payload.
> >>>
> >>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> >>
> >> I see how the abstractions get used later on. The rest of the examples
> >> in tree today are of the form foo_dram_init / foo_dram_init_banksize, so
> >> we should follow that form instead. And I'd be inclined, but I'd like to
> >> hear Caleb or Simon's thoughts too, on just overloading the weak
>
> This adds a 6th (!!!) possible way that U-Boot can be loaded on a
> Qualcomm platform, on top of:
>
> 1. Android chainload
> 2. in-XBL (replacing EDK2)
> 3. as-hyp (EL2)
> 4. as-tz (EL3 with TF-A boot info passed in)
> 5. EFI stub
>
> While (4) and (5) aren't supported upstream yet, if/when we do add them
> we'll have 5 different ways of retrieving the DRAM layout
>
> a. builtin FDT
> b. SMEM (qcom memory database)
> c. TF-A boot info
> d. EFI memory map
> e. coreboot boot info
>
> So to this suggestion (and Stephens answer below): The way Stephen has
> composed this coreboot support makes sense to me since I can just look
> at mach-snapdragon and all the codepaths are there. I'd rather not wrap
> the whole functions in mach-snapdragon in an #ifndef, it impacts
> readability and also makes it quite hard for someone not familiar with
> U-Boot to figure out a) why this is done, and b) what functions get
> called instead.
>
> I would eventually prefer it to be a runtime check rather than compile
> time, and the current proposal seems closest to that.
>
> >> function we already have and when we don't, #ifndef CONFIG_SYS_COREBOOT
> >> the existing snapdragon function. I suspect we might longer term need a
> >> bit different abstraction here to make it easier to override things when
> >> U-Boot is a payload and getting this information elsewhere.
>
> Agreed, I think I saw a proposal recently to some info to the /chosen
> node for this. Not sure if that's the correct approach but I do agree
> that we should have some kind of API in U-Boot to let us collect info
> from previous stages and metadata so that we use it later to inform
> decision making.
>
> >>
> >
> > Ok. I struggled for a bit trying to understand the design of the weak
> > functions. I'll rename it and have it overload when nothing is
> > different. That means board_get_usable_ram_top() can override all the
> > time. The dram_init() and dram_init_banksize() functions likely need to
> > stick around though and be called explicitly? Maybe we can have some
>
> I think Tom is proposing to wrap the entire functions in mach-snapdragon
> with #ifndef CONFIG_SYS_COREBOOT. Which as above I'm not super in favour of.
>
> > sort of 'payload' level event hook so that depending on the payload
> > that's detected we can call a function to setup memory.
>
> It really depends how far we want to go for a generic build. It would be
> nice if we could source DRAM info from all available sources (since
> there might be multiple) and then pick our favourite. I think this would
> let us do a much better job at defining and documenting all the various
> combos we have in mach-snapdragon too.

I too favour a more dynamic / run-time solution, with a more generic
board. If we can get some of these boards into a lab and connected to
gitlab, so much the better.

Regards,
Simon
