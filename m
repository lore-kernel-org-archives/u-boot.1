Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63E4E784BE
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 01:55:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93A7A83BFE;
	Mon, 29 Dec 2025 02:55:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="DrMgJeT+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAF2F83BFE; Mon, 29 Dec 2025 02:55:00 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 266D783B48
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 02:54:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-34cf1e31f85so7032485a91.1
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 17:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1766973296; x=1767578096; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TctRCgsIrOERvXQi0pQ/ow52mcNr+SUHeZGNl2iIeWo=;
 b=DrMgJeT+jY/nAl+Ql407GfgKnTG7X++tpyE+3wVRfpU0EMybkH0kMnR9cWEQu2kevN
 83nFsIe4CqfiJZkihQbuw5XnSifTqKoTosgryYqjXbknAV5LLE56kXsuZwtML4WjuawH
 u6tJhuraWD653stRWsKD35wkJDgPz/iygC6u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766973296; x=1767578096;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TctRCgsIrOERvXQi0pQ/ow52mcNr+SUHeZGNl2iIeWo=;
 b=TAIS7FZSTCoKQZw0zaLq6irpLSr/pROczQkreUAF+NdHSgTmhcDM5SEPRZPusSFhA9
 0ydULJ9pFI9Dr4xxJE+qDeoUpGRKiN51/MzA5dCT/P64sRIqfYj89xsQUDCnQIddjUC7
 /ygZ4yfLpQISz9tFmuf29iCKeqb23V8TpM3oJwWgpn+GPL8zEw2GNaiYz+1qBcxz42n+
 76bU8RHNiHIkmy5nzNETcxmPt+hX+U9E7adrlNKkgNTamAnBgfy6/S/7Xv6KjIpIpqR+
 QUIIK0r0yza9XzC+wSp+lfbzI1r/N9p7JbRrnd7pdYyMDTz/jcSc23F+8CPQR+WArPdv
 MQ/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOh9I70UwHIz4ZRqmxTHFGbJeVIK4fStRcn4JjayY+4yblHkkBOvuaHvbYSoRNTOiJx6TCMb8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/ynBn7s8cZXBGSOQifW4qhYW0KAxDgwripND5BwMfhkhbh3SZ
 ln91w4MDlNGQww+Fu87BKDDjbvluzgjZHr7GLyXAOpTTSRPEPHwbze3tLhu9JoLs8FRaxkBDPMe
 waVps5qY1TdBJA/KFFFSUcxltrYa2mLyySdBAt0yGdQ==
X-Gm-Gg: AY/fxX60ukwlYu8PIHlTZR4P2bSGv1BaBzoJhP3vDofMiNuGmPCfQVIiPtsbhJRNP9C
 y+7a0RBB2JyWFbSWEmyrwzyvsPJpNiiZf286NCHHj7x/WxaEvTNPFjNGaYtz+jz5WNClxaF14sG
 NgLKMLD1osVS7kjXlkHFEwhrl7SareUDJvcPRa+X3n2UEcA4zRmw0Ah93q5+4DqxQuUrKLEbkvu
 3r2lLusKNZhzq0ICz4IRXwnIC8SwAdtkqKcEPCS5WnTORvuMN+D3f/qKxiFKiAkxvQPfBPY
X-Google-Smtp-Source: AGHT+IF0ugI8DgQ668KL+mUXhSkcFzXBDxZuPXfRs8sDSd8SSP6x+HLYwdBaNBZHxcMliVQitUlP+BpNxxHbwQ2b0wg=
X-Received: by 2002:a17:90b:3d8b:b0:33d:a0fd:257b with SMTP id
 98e67ed59e1d1-34e921f0b38mr21697730a91.36.1766973296337; Sun, 28 Dec 2025
 17:54:56 -0800 (PST)
MIME-Version: 1.0
References: <20251226175400.1154417-1-visitorckw@gmail.com>
 <20251226175400.1154417-3-visitorckw@gmail.com>
 <CAFr9PX=JzXVa-HTvV-Cbw3m+kvwYP_7RiG_jE8+WW+KKG59unw@mail.gmail.com>
 <aVGFEFCFKsmYIT0b@google.com>
In-Reply-To: <aVGFEFCFKsmYIT0b@google.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Mon, 29 Dec 2025 10:54:45 +0900
X-Gm-Features: AQt7F2ph0QKemWHQ3fnrRcDSdE0yH1R-K7QQxV6DMXFU17lrGTkgGgkO025juFI
Message-ID: <CAFr9PXkL8pDrtM86pmaw3U9RXCH2z-33X4hjqKUiJQAnQk-K0g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] m68k: Add support for M68040 CPU
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com, 
 me@ziyao.cc, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
 u-boot@lists.denx.de
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

Hi Kuan-Wei,

On Mon, 29 Dec 2025 at 04:29, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> > Connecting GDB and single stepping to work out where it is going would
> > be helpful.
>
> I did attempt to investigate this using gdb, but unfortunately, the
> root cause remains elusive. memset itself appears to execute correctly,
> successfully zeroing out the global data. However, using it seems to
> trigger a side effect where initcall_run_f() returns (which should not
> happen), leading to the hang.

Maybe a QEMU bug? If I get some time I will try to reproduce it.

> > Since there is now a goldfish RTC driver upstream
> > (drivers/rtc/goldfish_rtc.c) we could take the timer part from my
> > version (https://github.com/fifteenhex/u-boot/blob/mc68000/drivers/rtc/goldfish_timer.c)
> > and supply a real timer to the board. Right now I think anything that
> > uses delays will get stuck constantly reading back 0?
>
> My original plan was to focus on a minimal boot to shell support in
> this series and add rtc/timer support later. However, if you prefer to
> have them included in this series, I am fine with that.

I looked at adding the timer parts of my "goldfish rtc" driver to the
upstream one and it's not very clean.
So I have removed the unfinished RTC bits from my driver and moved the
whole thing to drivers/timers/.
That seems like a better way to go. I think having working delays etc
would be nice even for the initial support.
I guess if you send your initial stuff and someone asks "why is there
no timer?" you can tell them I'll send a driver for that in the next
series?

> Since the timer driver is authored by you, I assume I should add
> Co-developed-by and Signed-off-by tags with your name to credit you
> properly. I wanted to explicitly ask for your permission first.

If there is anything in my branch you find useful you have my
permission to just copy and paste without adding any tags etc.
Credit is nice but I don't really mind.

> Also, regarding the tags, would you prefer I send the integrated patch
> to you privately for verification before posting v3, or is posting it
> directly to the list fine?

Can you put the branch on github or something for me? If you send me
patches I'm going to have to import them to my local checkout to look
at so if you have a branch I can access that's less steps. :D

Cheers,

Daniel
