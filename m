Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0F6109C05B
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:42:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC97D83DA6;
	Wed, 25 Mar 2026 20:42:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dbzqxqy8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDCB283A91; Wed, 25 Mar 2026 20:42:42 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B12E183A91
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:42:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-661b16ac011so287345a12.2
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:42:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774467760; cv=none;
 d=google.com; s=arc-20240605;
 b=VUoClnhAP55ozCY5E2UjFphaQTMg0dAY1ylpIpmCoa6R0ub1e4TA81l+OXNfKTVrVK
 6tdICaElSQg+8XEpfzos0TUTUuYSbhlTPq2HhY9qI7c9JhpyuEHx1MN3QcuD4hNWYXJa
 z/G3sI8pE0RfiM9LXh2lnC96u1N9GKuepXiLz/06rreW98fh8FxY38zYOHk3LDBLgzu/
 QuPrUmQmmK0Y+78Tl3e2ZikQgatu6gb/r+bqtHVFbYxUCPUiHlWLrSkO6racJQptue75
 UpuraGo5+oYR6Hagc0a9nw+FXf6e/927O84lpPtukevtcTKEDeN7ElMq+U4VuIjoJkmG
 OVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5KdlOta9gDf3G5L7GzqGhhU+oGp5xOQdettJOiUCQM4=;
 fh=mBbzgUwAC/cvA9PajMg/FGw60vI/H1uvB8EZSssaSW4=;
 b=cj0jG5MFNi4eru8EiGXBgBH5K1xV+W4EHkqUED5IY6Oj828pDs8iaLDvX6csAevsSz
 IodqUW2CveyHkhB/kykj2pPrrEFDPXAvXlK61EadJJyPsYm+lFYliCadAPir1V3BFN5W
 h5T96prG21cV55u91OUDKxn9RUwrTfJ4cLZlmud+DNcGHQuPdzT6djsQfW39SKqKAfIC
 vO2xS30ECuj8VGzRw8+5O6KK44d4/+W2j4DuzFgrTu0XGmx9Q2SxwHbwDMlXN2GVzRWn
 0dkE1wpAHuCNDPHp7/XMhGkvHKaXsZYpVMaVy97cMiTT01h0NOidFID7byNiMHinryCK
 LE3A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774467760; x=1775072560; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5KdlOta9gDf3G5L7GzqGhhU+oGp5xOQdettJOiUCQM4=;
 b=dbzqxqy8HEips3UP3Y7rCc4sF4J4hcDccjYNKSoEzzmLHv78IVjdUM9fGfoEa29EhY
 fFH0wJdz1k7WaOn+1RiAZlVCKRp/B0TL5kTxkhtlMiU5uDzWIhQWLt2L/XeH55lm8zqw
 CmYtFNTE4vZogYjvtyhfhjCq5pgiOyA8UgnRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774467760; x=1775072560;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5KdlOta9gDf3G5L7GzqGhhU+oGp5xOQdettJOiUCQM4=;
 b=HbBif6/TuC0WeQMnLa29RGjHievTvCVqGt66QdylPV7pghvqjLxSiaqXq6Alu0KBY/
 hFEJ//vwawOiIktIfnLi7RYNTk1oFB0iAj3LqcT4RDqksWO5Ei1/AK+xD71JjOjpXSSQ
 jl7b7SO4VMx2hoRSMIl09ajw15ealTTQHC5Id0fBWtuEPb0V+1weZJhYOliz1cmSc2Bv
 +x6QyV5mmIqJOJ4ca93IdnAf+8+10B6hCLuuQoHVEoj4T/xqomcsnCXyV2Lw6NAyeolX
 cUEJGWetEFdlmWhFEWwf7lasmWkLX98grZLpnJXf1Lu+pOuZp9UveDkEqLJW5tccIEb4
 iPUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQTa416A02TJwz5o/ktpMNSXrtjVTxV6pvifIFGGvNOBMAPa/I7uU1Tqph/IE16NjdIbHxHZs=@lists.denx.de
X-Gm-Message-State: AOJu0YwGblG16KrBr6ARaeeCiPz2TrmG5zH8O5JboavofXqRcQMrxCv5
 wF4ItypkFcZC66ie9D1NYTewkVSASsnCnu9bdWrm7KpG3DV1e1lUcSifvb7QyyEU7JO0I6/aevQ
 /0L0XBPquTx7xZQOD0qlRnG9Y9w+Niq2jnKAiPK2xfr4FW4FIUhH2mBcD
X-Gm-Gg: ATEYQzyaAEIGdBv+GJ2NtJHD3h5BObcfKNlUFgqx5dR9XaNv1MKidKvt+qSlQH5eDUL
 Xjc3E9NPpJ2WKda5U9m19msZy/RgqXQeS9MRMjUMxEFkLovU0bVBxBPBpEgYEjf99gSkd3IYFcQ
 5VT5XeFWo5nubOaJcJKhVhS9IAzwb3AFv+GkJ7Lfz1wnndhxdAGUiNB4Xkl3DzBAV3IRj+j0rFH
 CZtMb8A2rebVYZH2tipcOYlEn0wcXPksWII3D5sM7KCf4nBMaxjDONlcX2kiGaOZDNt+PZjOo2R
 iuNdCMc=
X-Received: by 2002:a17:907:9997:b0:b98:32c1:249d with SMTP id
 a640c23a62f3a-b9a3f17037fmr373690066b.5.1774467760138; Wed, 25 Mar 2026
 12:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260325190025.3428560-1-trini@konsulko.com>
 <fb6ee141-3369-45e6-8320-e91f67ec6b1e@kwiboo.se>
In-Reply-To: <fb6ee141-3369-45e6-8320-e91f67ec6b1e@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 25 Mar 2026 13:42:28 -0600
X-Gm-Features: AQROBzBoi9JsxD6LYmGvM1jQY6bNUVelxxJ_5TdRCWHxCEPCnQ0fOJP4WMCWMOs
Message-ID: <CAFLszTiF4RDyo8+4RZhsNViSNquU3Ouq2fNr5NjG7PvK+2zrtg@mail.gmail.com>
Subject: Re: [PATCH] arm: rockchip: Guard call of board_early_init_f in SPL
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
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

Hi Jonas,

On Wed, 25 Mar 2026 at 13:31, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Tom,
>
> On 3/25/2026 8:00 PM, Tom Rini wrote:
> > Today, no platforms call board_early_init_f, and rockchip provides a
> > weak default function. Change this to not providing a weak function and
> > only call board_early_init_f if CONFIG_BOARD_EARLY_INIT_F is enabled.
> > This will allow any potential future needs to be taken care of, and make
> > future consolidation easier.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> > Cc: Kever Yang <kever.yang@rock-chips.com>
> > ---
> >  arch/arm/mach-rockchip/spl.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/mach-rockchip/spl.c b/arch/arm/mach-rockchip/spl.c
> > index e989c148079a..8026cc0abb8d 100644
> > --- a/arch/arm/mach-rockchip/spl.c
> > +++ b/arch/arm/mach-rockchip/spl.c
> > @@ -97,11 +97,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
> >       return MMCSD_MODE_RAW;
> >  }
> >
> > -__weak int board_early_init_f(void)
> > -{
> > -     return 0;
> > -}
> > -
> >  __weak int arch_cpu_init(void)
> >  {
> >       return 0;
> > @@ -111,7 +106,8 @@ void board_init_f(ulong dummy)
> >  {
> >       int ret;
> >
> > -     board_early_init_f();
> > +     if (IS_ENABLED(CONFIG_BOARD_EARLY_INIT_F))
>
> This patch seem to introduce a change in behavior for chromebook bob and
> kevin, they do not seem to enable BOARD_EARLY_INIT_F, yet they have a
> board_early_init_f() in board/google/gru/gru.c no longer being called
> after this change.
>
> I do not have a chromebook_bob/kevin so I cannot help verify if this
> change break anything, hopefully Simon can help test/verify.

Kevin spews some junk to the console with or without this patch.

No change observed on bob or kevin. BTW both are in the lab so you
should be able to test if you push to your tree.

Tested-by: Simon Glass <sjg@chromium.org>  # chromebook_kevin
Tested-by: Simon Glass <sjg@chromium.org>  # chromebook_bob

>
> > +             board_early_init_f();
> >
> >       ret = spl_early_init();
> >       if (ret) {
>

Regards,
Simon
