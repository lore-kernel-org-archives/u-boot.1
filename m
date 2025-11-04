Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0C7CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 21:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 396CB8391C;
	Tue,  4 Nov 2025 22:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N2w/MYiT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4A738392C; Tue,  4 Nov 2025 22:33:28 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFB0F8004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 22:33:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-74526ca79beso4264770a34.0
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 13:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762292005; x=1762896805; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CnpPWU7XuxcTVdQpWSTi5tfg9a+FIC+uzf3hpry8Qfg=;
 b=N2w/MYiTKwzepWtD9k5Ak3ddeT1dK46ULI9e2+nbXL1okRf1MmOC29Bw5cyViQv/Yk
 ZxrtmkWSOyyTo0yWm2vg0EBbkknlhoeOI6m8Sj61e70N/z/YLzIVZZAJYGmGVEUcTHYC
 1/0+n88QJ46in1VxyD3AafSfVecflhjajMHSiZYAB+nwzLbdiJRHVcxeFHqALt84uWIy
 h7e1oNurV6fSBSPXBTgfwmXNXfakkNREMIU6dTporo/wU/jnUjpnxazhhgZl5JShpC8A
 COX/G/dBTCfMBYSKmFqi9bRozqEyLpxP1mkr3HpCKgks/c2DmRGqPCkNRxygSl3wL5RK
 iwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762292005; x=1762896805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CnpPWU7XuxcTVdQpWSTi5tfg9a+FIC+uzf3hpry8Qfg=;
 b=JriwMULtEaG8S2kAz83ISuwriRa/VhqV8KRadyQ04QyR3wFmEHkEVreTYDytJS5ur4
 RY5Y/9kgfwURfqKls0haiVYstAyp/+gBW98iTsNZ0OjYPHR0icslX0AGa/gpig/Khv/m
 QaKuA/YgUlBFPhl8/nOt573njfSERrdSinU2PlG+lfZssaQj5qQ1XU09TmDTK2dTk3tv
 JZe3/ujKca75L13BKcuzjYT/LyHdNBBykvLIeRo98SZvTlEfKuOvEweKsJZu1UjTZMie
 levQd1yHR14VGALwYV34OjvrNH/O5He/5v1KhAU3oif2egn3mYuNB1mJ/dkd0jLKXFIt
 UdXw==
X-Gm-Message-State: AOJu0Ywgw6LDI5yZRnA81+WF2qCkfH9LK+kmw/DcxoV46m6+LghUT46m
 wbZ4EPFNQnHXgLM27T+FNRT2BRt51oedlzV+Esf45MKE/LllSpNVgzXGEY5egZsVW1nHyxf8jOJ
 h4NKXVxkQ487AB8/wktlE/M5nt6N/kjz4zoiTmW0=
X-Gm-Gg: ASbGnct05jt4orMjbAMnBGmeO0EZdFuQTH9e+SJBfDQgp07eheJ6FRfDIMhyrXgvCkj
 ZqyuKytQ0/bktBiWwLjG6hZC8IPG3HRw2WcJts7coL6+162tLvcSYFU0X/IIavV2JgVz/iztv63
 TVfdaNT7YiW6SWaqVy0tdT/0IUC4A1bNwI9wsOgd3T4ivw+UfnoZMU7vWIwZsaVAok+hOoG6ceq
 9OGUfZDB9HsO/sgzOkXL4lWO3O+YhMnoRUQp/DmwfwyVfzCId2hT569RzSb
X-Google-Smtp-Source: AGHT+IF5akLTKJyG33rn2X15C4wBdVsXpgcivmaznnPSEUlGJ1H3Z2gwgoZL5SFdUff+Nk4wbs2xinKl+nWST5rEBts=
X-Received: by 2002:a05:6830:2403:b0:7bf:6dca:2055 with SMTP id
 46e09a7af769-7c6d12f9715mr657244a34.4.1762292005337; Tue, 04 Nov 2025
 13:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20251104010003.525-1-briansune@gmail.com>
 <20251104175123.GE6688@bill-the-cat>
 <CAN7C2SAvyfUyTqy8sqKxPWPG9Bu+aYiXGjMzfVJxR+mc59TD4A@mail.gmail.com>
 <20251104211832.GI6688@bill-the-cat>
In-Reply-To: <20251104211832.GI6688@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 5 Nov 2025 05:33:15 +0800
X-Gm-Features: AWmQ_bmRIdTqc-orn-iKgbRtJz37CL4ys2lLR7MasHpSsYwaR39igWRcBebTkY4
Message-ID: <CAN7C2SCLbo-9=QS8qURd=zwWyOYidAsCtb6E-CGbCmh7yrN9nA@mail.gmail.com>
Subject: Re: [PATCH v6] Add optimized Makefile support for SoCFPGA handoff
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

> I'm sorry, but I don't think that's an appropriate response to me saying
> that if you're using an AI to generate any of this then you should
> disclose it.

I didn't generate any of this via AI. I just use AI to analyze the syntax cost
what you pointed out previously on the slow down.
I think there is a very distinct difference. Asking syntax vs telling AI to
generate the code is not the same. Otherwise any copy paste from
google is considered the same act.

However, I should not mention this in the first place because people are
so much trouble with AI tools these days. It is "voldemort" don;t say it's
name!

Back to the original issue.

Indeed $(src) is missing.
HANDOFF_BASE=$(src)/$$BOARD_DIR/hps_isw_handoff;
and
python3 $(src)/tools/cv_bsp_generator/cv_bsp_generator.py

With the above fix it should run smoothly w/o the issue you pointed out.

So you will insist me to move it to arch/arm/mach-socfpga/config.mk?

Brian
