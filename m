Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309BEC02196
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 12:33:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DEC68091B;
	Thu,  6 Feb 2025 13:33:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bJclbNBC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1C3F8092B; Thu,  6 Feb 2025 13:33:33 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0638E807FB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 13:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361f796586so9296745e9.3
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 04:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738845209; x=1739450009; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ztm7+S8MVpfEsXMJ0eg8onRh7qq6+25cqLyOLUDVL5A=;
 b=bJclbNBCdkHgMAstGCFNSJ7u1HvsreJ8LDTQjMy9Zu9kR8E9qf/8/kFrlMSx2AaeP7
 R/59D0mCrA6Sh/QqD8QhPt7Sl8RjV38uUSeRClw5KjRDs7KAKYlWrQnE3x1jWsdZCZ58
 1L8l3NqZv/Pldnpoydo5zojw2L3HEGneFS2O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738845209; x=1739450009;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ztm7+S8MVpfEsXMJ0eg8onRh7qq6+25cqLyOLUDVL5A=;
 b=LLsYJbMU0gr/TVhZjyzaHXTf5v8ukaMZpVMOQWmSL6gg+auuRWZL7gTUv7eQGkKH6y
 YeHhGV8vdy6spg5o7wu/ljf11/hBMxkItYfVWbv2j5oHr+H/vMiZFplsNLlLACaw3M9w
 i0ySPR0PGG/UnEtWYmtnOdkFdkJ65mxEVmMML/aJ47jsALfxRY5iT/qRFDpjNMdgApVD
 SOMH1+pSGz8aTyrVcSGNypLd31xUE/5owSYQg56auwJqqpwe3/9DaDvUN5pZUamOr4KO
 pvod4mjurxExn7pUtqXHMNw5aUCCBBPnyHi/pd4oNyL1ohyYsXUV10e7Y+K3omOBCrGI
 BpMA==
X-Gm-Message-State: AOJu0YzmPipeu/AIglxFK/odsAkIuePLcX0tHceTykLyOUY176OSmGFC
 LJdEpsF72/CdvmFXhUPatOeXBmMnPVh4WyeDXqVyYp5CJ19QsXCASHfi7NAQ7plmhArh9uD/rGj
 lfGAssr4Qr4565c1JMYrpwhLtOF+Sv+GvkuTM
X-Gm-Gg: ASbGncuwg+6Amek7oS2VJLEqHSMkNF5tpplP5KpecILqAFX3oTvpip936JNuNNUtmSw
 VA/C20H+9rBwQ1oD6j9yBHxUY62ecTT5canTS9fZtkTBiFE3ZH7XdiHmS37Y3CgLpsNXKNKqgVQ
 ==
X-Google-Smtp-Source: AGHT+IFXaOnl+dB8pf4ENTurGik4T/itMGjEslkp+9ZzJawKNlsRKvovpSek9Ep30cnPE8EB8GsBbVeKk76iJdEk1S8=
X-Received: by 2002:adf:f206:0:b0:38a:2b39:9205 with SMTP id
 ffacd0b85a97d-38db48b8186mr5412357f8f.33.1738845209428; Thu, 06 Feb 2025
 04:33:29 -0800 (PST)
MIME-Version: 1.0
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-16-sjg@chromium.org>
 <20250203200911.GI1233568@bill-the-cat>
 <CAFLszTgSD+jACUegQ4yw6yOogvk+LVtsC9kOCs8zJ9ECDiZG3Q@mail.gmail.com>
 <20250204021250.GD1233568@bill-the-cat>
In-Reply-To: <20250204021250.GD1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 05:33:17 -0700
X-Gm-Features: AWEUYZlfh5qetc6ReIqVqnf2uVpQa9ug06mXlZVPotMgi3IM6-zlMuXa3jlsvfQ
Message-ID: <CAFLszTiWvD1TJgiR6YyAHceWV6o5p8GPDLDcUVz46UL8cX1geQ@mail.gmail.com>
Subject: Re: [PATCH 15/32] efi: lmb: Avoid access to _start
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Janne Grunau <j@jannau.net>, Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Tom,

On Mon, 3 Feb 2025 at 19:12, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Feb 03, 2025 at 05:38:44PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 3 Feb 2025 at 13:09, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Feb 03, 2025 at 10:42:08AM -0700, Simon Glass wrote:
> > >
> > > > The app does not have this symbol. Also the memory where the app is
> > > > loaded is not under U-Boot's control. Disable this reservation for
> > > > the EFI app.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >  lib/lmb.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/lib/lmb.c b/lib/lmb.c
> > > > index 588787d2a90..420eae4d0b8 100644
> > > > --- a/lib/lmb.c
> > > > +++ b/lib/lmb.c
> > > > @@ -560,7 +560,8 @@ static void lmb_reserve_uboot_region(void)
> > > >               lmb_reserve_flags(rsv_start, bank_end - rsv_start + 1,
> > > >                                 LMB_NOOVERWRITE);
> > > >
> > > > -             if (gd->flags & GD_FLG_SKIP_RELOC)
> > > > +             if (!IS_ENABLED(CONFIG_EFI_APP) &&
> > > > +                 (gd->flags & GD_FLG_SKIP_RELOC))
> > > >                       lmb_reserve_flags((phys_addr_t)(uintptr_t)_start,
> > > >                                         gd->mon_len, LMB_NOOVERWRITE);
> > >
> > > What prevents U-Boot from overwriting itself, with U-Boot commands? Also
> > > how is this linking today? I see lmb_reserve_uboot_region in
> > > efi-x86_app64 for example.
> >
> > The only memory U-Boot can use when running as an EFI app is that
> > which it has allocated using EFI calls. The actual U-Boot code is
> > certainly in memory somewhere, but does not lie between gd->ram_start
> > and (gd->ram_start + gd->ram_size)
>
> That's not what the commit message means to me. But the next question
> is, is EFI_APP setting SKIP_RELOC?

Yes, there is no sense in relocating from one alloced region to
another. U-Boot is not able to relocate to the top of memory, nor
decide what other parts of memory are used for. This is in the nature
of EFI, after all. We have an API, but not policy.

Regards,
Simon
