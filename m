Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6484C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 15:02:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 417B987E2E;
	Mon, 18 Dec 2023 16:02:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cYbCrniK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68BDA87E30; Mon, 18 Dec 2023 16:01:59 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E90287E1B
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:01:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a1ca24776c3so814054566b.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 07:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702911717; x=1703516517; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=teOZNP/5GVaJ4WSwIQ61OKImPm325QYo7v7uaatujeU=;
 b=cYbCrniKiAy3IGglBW7vfYOZ2keOfdK9iKgvWN+0KZfVJz2ZGWkWTSdGcq5M9kuWwf
 0JgU+nRKwomuO8jxDicM6imnfm9L4+YEivqYR6uLvN0XnbHzzmvMawdLYuiab9BEsM7x
 hxl2uJitXG+kACeTlVVI9g6IzVNLYUU8t30FU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702911717; x=1703516517;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=teOZNP/5GVaJ4WSwIQ61OKImPm325QYo7v7uaatujeU=;
 b=pwoZAayJiiVGAym08BzZKaoeTy/xqwV8Y8KVwUBHKwzY+s8O4D0ewflLah8G7FLkjU
 kgaRhA61X7lcSCwS20EmsTWDV4EB0tYSsRtp7/QDvhifqSDY38osktWJznTMF8VNA9A+
 nGkCaYnA7WbsFNz5DufHYVPVSyT6YHNpbb5FppFx0g6KGuSAlVz+smKIRJURzbpMZyV/
 WvH0dZHQgI9rgLDdRWzK2IMyrtI85l9ndJhMLWrl/02iAUvq9hKC89Qt4ggex8B4zbqE
 9+jgdQ+Tx88AWZyXwps5AcYrF0O909N+EMe6CRRWFXv593s39dkdzY4Igk2XQfNJebfX
 16AA==
X-Gm-Message-State: AOJu0YwzqohZe+g0bdmZFEAsd6YfKqWihto3IzLZq6Rf/t+FmwGNb5fR
 tCkzbqVU8ZT6y3qIXkMfc9ZRV5bbIrB3Hr4/3aJg55sqS01gg2p1Nrw=
X-Google-Smtp-Source: AGHT+IExT0LiYf+lmgEwhq9E5x+RWmQS6TUD/xjEWzsFW9oZaonakiAcZVc0aFsZndSVceb46K7ANxUgxpmrZ5fYRA4=
X-Received: by 2002:a17:906:55:b0:a1b:7700:2c0b with SMTP id
 21-20020a170906005500b00a1b77002c0bmr18100819ejg.19.1702911716845; Mon, 18
 Dec 2023 07:01:56 -0800 (PST)
MIME-Version: 1.0
References: <20231112205516.183410-1-sjg@chromium.org>
 <20231112205516.183410-4-sjg@chromium.org>
 <082aeedd-4371-4ba4-a29a-bf0f0730b77b@gmx.de>
 <20231121132110.GQ2513409@bill-the-cat>
 <CAPnjgZ30CjQZ0+DMp2gy0HzrnRsjcY5NMi1YVVRQiN8UG-5oBg@mail.gmail.com>
 <c8f1c7cf-346f-42b4-9652-69476e763d5f@gmx.de>
In-Reply-To: <c8f1c7cf-346f-42b4-9652-69476e763d5f@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 18 Dec 2023 08:01:35 -0700
Message-ID: <CAPnjgZ2DM55YjF845k2uGscwr6-yrQ7KU=mZFsoo9K-6Gik1WA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] efi: Avoid using dm_scan_other()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

Hi Heinrich,

On Sat, 16 Dec 2023 at 14:02, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 12/16/23 21:46, Simon Glass wrote:
> > Hi,
> >
> > On Tue, 21 Nov 2023 at 06:21, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Tue, Nov 21, 2023 at 01:18:09PM +0100, Heinrich Schuchardt wrote:
> >>> On 11/12/23 21:55, Simon Glass wrote:
> >>>> This function is defined by bootstd so using it precludes using that
> >>>> feature. Use the board_early_init_r() feature instead.
> >>>>
> >>>> This requires moving quite a lot of code into the board directory, butt
> >>>> this is the normal place for code called by board_early_init_r()
> >>>>
> >>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>>> ---
> >>>>
> >>>> Changes in v2:
> >>>> - Drop duplicate acpi_xsdt patch
> >>>> - Put the board_early_init_r code into board/
> >>>>
> >>>>    board/efi/efi-x86_app/Makefile  |   5 +
> >>>>    board/efi/efi-x86_app/efi_app.c | 205 ++++++++++++++++++++++++++++++++
> >>>
> >>> Our target should be to enable building the EFI app on all architectures.
> >>>
> >>> Only x86 specific code should be added to board/efi/efi-x86_app/efi_app.c.
> >>
> >> A later enhancement to make U-Boot as an EFI app more generic would be
> >> good, but outside the scope of this patch which is moving generic code
> >> out from "lib" and in to "board".
>
> I cannot see that this patch is moving any code our of lib/.
>
> But why should we move generic code into board?

It isn't really generic

>
> >
> > This patch was marked as old /archived in patchwork so has been
> > forgotten. I have marked it new and non-archived in the hope that it
> > can be applied to -master soon.
>
> There is nothing x86 specific about the code. Generic code should be in
> lib/. Please, provide a new version of the patch.
>
> >
> > I believe that having the EFI app support bootstd could be a useful addition.
>
> That was not disputed.
>
> Best regards
>
> Heinrich
