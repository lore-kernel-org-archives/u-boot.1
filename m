Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70C7CFC29F
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 19:09:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15CA983A8A;
	Fri, 21 Nov 2025 20:09:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DROT/gVk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ADEC83A8C; Fri, 21 Nov 2025 20:09:38 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EF8083A41
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 20:09:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b713c7096f9so377191566b.3
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 11:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763752176; x=1764356976; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TnehiqjkSJUM9VckYiEJm/fExTs0w4yv6hvFmRr7MK4=;
 b=DROT/gVkrYJODwOQ5bf+/AquMcSOszWIXiy9tSKn88SpQRCuX3fIByTm7HfLgo8akn
 8X1Kvu2dE+PgV8twxx19Wzo2D9L8BvPS7hY3pJVVNJhV7VUkQOUfdr4bSjGP9Rh6Kem4
 VeVjH7GGXdNiYCMo5xa/VpX64cFNGGBj6N80E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763752176; x=1764356976;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TnehiqjkSJUM9VckYiEJm/fExTs0w4yv6hvFmRr7MK4=;
 b=HNS/pOjrvDz9oKRpF0kbjz4K6gVo1VnFpp10FV1qPk/qaspxsJnZVLG3QSJSIYdHPC
 XNSgvV21v9UVsjbjhnczOY9Su6Ayd1nvw0ApF0TRlLK4X7n84+QLrKtVqLEYYVwg0E1f
 XXZ6CidCoNLXqENdpfTYLVUWw+BjHF4f4iM3YFcPr0HhHggfuq7V5yG5/Nc5CwnSGr4I
 pGvCk1+EIVVNosj6vtC2EI4TSMwkrXFVMSRdxWLyy0VmWqnesENc9/WpMgRSIu406JI1
 k+ZB+0sy/ayMrvVLopYn67roGQGZ82REg1te4bdODqHXqDVZNXGce6U3Zvovf456VPNo
 Y+Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXhK+CuAp7cFM5AyRqxC9PK/0twR395B8Y0KFy0yGX8Mx/W8n4ZHPoDJgmscLKc+oql7Hj9w0=@lists.denx.de
X-Gm-Message-State: AOJu0YyuihBZ/nlv0J5QxaWQArHHczqlf1A6cQpqlEopyx9dJCcwPZId
 whLsfY+qI4hH7mWgC2UVsBuXVjzvF5lzllHHs/jPYSJslxF3C0A6RAtijSM750J+VKRjvMnLESt
 gKvVqBXZNqjBawgPWhKLE+6vSfyQM02qZF2qC9LLVdBAoHyFeq9o=
X-Gm-Gg: ASbGnctSxR5UrdkhR1cTFa23yPSabuvqMVZ5jXilPgXEUqrMS+DX2H8XnvtkFqT0wgj
 1yRBZ5ZKAP9rZUNrbLg0HDz+dAcNgnne8cOUNJGeB0t2pu13J6mx4CyUXdfIitZBfpSCnXCaPz9
 a9WcRuKs/KeVKTcmNHnQRhv7UjdO+cT5jjKVphDx3hNo+P+f4adEqYoeNdELGoA5q50C/EMvhd2
 5Oqjd12/WBKxnTQT4ccXM4QFcnWRTNuvtLhh9DxDOC6pAWe1LywqQTWps7udj+xn0MI6tzDuUO1
 vTu4
X-Google-Smtp-Source: AGHT+IE5tLF3rvXO+Sr6aO+FnTRlLVmrjhWWxDl31MswKNR/fySVQmh8iirW+L8DRIviRxsKGNPkqiUJRdkAPjAaj58=
X-Received: by 2002:a17:907:3f2a:b0:b76:45bf:ce38 with SMTP id
 a640c23a62f3a-b76715abc23mr366939066b.19.1763752175687; Fri, 21 Nov 2025
 11:09:35 -0800 (PST)
MIME-Version: 1.0
References: <20251120041526.817288-1-marek.vasut+renesas@mailbox.org>
 <6a902e2d-b1be-1ba1-5d8b-e0a07ea2aebe@nabladev.com>
 <12ddeda7-f0a6-4cc8-8728-ba979cf6cc49@mailbox.org>
 <CAFLszTghtOKZWaVZH+hYdWvwUWZUTVPZ_mqkW3MCHRH6wRN0iw@mail.gmail.com>
 <b7063159-f5d0-4f8d-be35-2e7fa5f8f750@mailbox.org>
 <CAFLszTjyXo9yh6Jzdaev9GhN8OZ4Z5xz9phgNHnKCvA0ASzbaA@mail.gmail.com>
 <60b12c96-4e63-4cf1-8c27-25eabead529c@mailbox.org>
 <CAFLszThg+6LdxHXOYy9x8-nat+bsspbUT8Dg_vqnmx62aO0a2g@mail.gmail.com>
 <a8fa7ff0-1324-4213-b45b-b4df637e6bee@mailbox.org>
 <CAFLszTgLjRT_x1+tX0xpBzTy9bDJSYXw=5gOBvvNSqdOZDiZoQ@mail.gmail.com>
 <c75bacd5-532a-4783-9f1f-02884eee7918@mailbox.org>
In-Reply-To: <c75bacd5-532a-4783-9f1f-02884eee7918@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Nov 2025 12:09:21 -0700
X-Gm-Features: AWmQ_bmOLwsou5Idwv8lmVM2SGT8X_UdmT4RcbUtBMh94LmWh3Sth1Leef_XOWE
Message-ID: <CAFLszThKSE7v6TJhfeP2jGTS=GkpVuDpYHNHh_fMFL9TSjrnqA@mail.gmail.com>
Subject: Re: [PATCH] i2c: sandbox: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Fri, 21 Nov 2025 at 11:01, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 11/21/25 6:40 PM, Simon Glass wrote:
>
> Hello Simon,
>
> >>>>> - create a new VALID_OFFSET assumption (split out from VALID_DTB)
> >>>>> which checks offsets in fdt_next_tag()
> >>>>>
> >>>>> The latter might be best. It would likely be very cheap in terms of
> >>>>> code size. In fact, I should have thought of this at the time.
> >>>> Wouldn't it be better to not misuse libfdt ?
> >>>
> >>> It actually isn't a misuse. It is perfectly OK to pass an invalid
> >>> offset and libfdt has defined behaviour in that case, absent any
> >>> 'assumptions' we force.
> >>
> >> It actually isn't OK to pass in invalid offset if we compile FDT with
> >> disabled tree validity checks.
> >
> > We are saying exactly the same thing, if you read both of the above :-)
>
> What I wrote is, that it is NOT OK to pass invalid offset to libfdt IFF
> the DT validity checks are disabled. This is yes a misuse.

Yes, of course. It IS OK if you enable the validity checks.

>
> >>> Remember, in Linux these checks are enabled. We added the 'assume'
> >>> thing to reduce code size. Here you have found a situation where it
> >>> breaks stuff, so we should back off the assumption a bit.
> >> U-Boot also has those checks enabled, SPL does not, and things break
> >> when OF_PLATDATA is enabled and there is no valid node associated with
> >> the udevice.
> >
> > Right, so add SPL_OF_LIBFDT_ASSUME_MASK for SPL and check the code
> > size. If it is too much, add a new level FDT_ASSUME_EXISTS before
> > FDT_ASSUME_SANE and use that for the necessary checks (there will only
> > be a few, from my reading of the code).
> The SPL assumes the FDT is valid, and disables FDT validation in libfdt,
> to keep the code size low.
>
> U-Boot does enable that validation in libfdt, and grows its size a bit
> because of that (and also because the DT might come from outside), but
> SPL can not do that (and control DT does not generally come from outside
> in SPL).
>
> That is why these few fixes actually repair the misuse, instead of
> re-enabling the validation in libfdt.

Enable basic validation if !OF_REAL ? Create a new level of 'assume'
for just what you need?

It just seems really odd to disable validation and then try to not
call the functions in case they will crash. The next person who comes
along will have an unexplained crash. It's just too brittle.

Regards,
SImon
