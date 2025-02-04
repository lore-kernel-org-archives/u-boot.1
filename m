Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911C4C02192
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 00:39:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D62F0800C1;
	Tue,  4 Feb 2025 01:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h1I0l5Qe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E587E800C1; Tue,  4 Feb 2025 01:38:59 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED62A80050
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 01:38:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5dc7eba78e6so9325702a12.3
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 16:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738629537; x=1739234337; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vr9ppZh7x7smybpjGrUTSeYw1yLA7pBnxQGdY2gggn4=;
 b=h1I0l5Qe/Ubg8a6pcbXfRdQHOZReibnLp+55Zg7T20geq+HXUKl+6M65Rxs+8gL1dn
 xwFyYj2GrcUy6CgQLSEU4hmOyRonaBVexmKguJeVJ5rAZR2pl60ZypWSRwo+43X8HNwj
 DnTbrKWKwh3QgMUoWVp2eZ2uDZfduhahYgrng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738629537; x=1739234337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vr9ppZh7x7smybpjGrUTSeYw1yLA7pBnxQGdY2gggn4=;
 b=wp/18c9vEapmpxdVP4EAGl92DdeeXWb/53eSI+MdKcyQXee/lhpV7NINP1TSZp8Xfb
 +GN83o7CK6BDxP/l/pbWL2qE0iog/kX/dQzt/4iSruEKOBdPhl4mJwWFWz4SXYulqtcb
 kDIPm5c8EaUf5q5Y8mAN91lfXhx2MBAeO+BvCEHZNGGN2I5kLB2YI7WWjLGo5f6Ct2bi
 Io2UqE55SBVCTO19BK3cZoKh6m1b/jkJ6ryLitVIBumnn3dNANbqJ5fdKJfMr7Oc06TC
 fvwABBinK/oyd/ayn2kvE4dKxCClIJjrJ4Qkf3IMRMg5Y218vgAUP7SUvxLDmsE8mN5m
 ek3A==
X-Gm-Message-State: AOJu0YwPHTVDFE+yo6fJ2BiQQIXJP3CeSVEbrRwxGkYpEc6fIPggQwjA
 iDL649gx7UZn7bGlY7KBEfOLpVE6h0b4WatFhH+QHUVSyGEgXTQsBuuxQBYMv7HYuPr6iaVTQK+
 0LBctL3y5YmS4tAegumeTvL5aLqQntLlVkjmtKSam99uvI8k=
X-Gm-Gg: ASbGncsHqQfVEXZJO/u/qdpe0bKBv36nqWRSvzhx2YewsWHsa3sxURNcdG8Ffv70xtY
 jAgwsvib7/aQQIUvRyA3SpCHLxea5NNUO/oAIPym54lGgMSWmR+dyZMbWkSZZjxODFbV6nMe/hw
 ==
X-Google-Smtp-Source: AGHT+IHUdwoI2L2LGqyEUUuwxR4XzbSxe2YbL7+FjnwRrDqKazD4k+wjQAMnoYcobqIQD/XOjTwIbk3CCI21No0YhMM=
X-Received: by 2002:a17:907:2d8f:b0:aaf:117f:1918 with SMTP id
 a640c23a62f3a-ab6cfcb35a6mr2717003166b.5.1738629537438; Mon, 03 Feb 2025
 16:38:57 -0800 (PST)
MIME-Version: 1.0
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-16-sjg@chromium.org>
 <20250203200911.GI1233568@bill-the-cat>
In-Reply-To: <20250203200911.GI1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 3 Feb 2025 17:38:44 -0700
X-Gm-Features: AWEUYZkmoHDDz2jwBsMXRQGyZzgBEZwRhzkV2gHarOPX4Bo9TfkUTDvOnZxjr2k
Message-ID: <CAFLszTgSD+jACUegQ4yw6yOogvk+LVtsC9kOCs8zJ9ECDiZG3Q@mail.gmail.com>
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

On Mon, 3 Feb 2025 at 13:09, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Feb 03, 2025 at 10:42:08AM -0700, Simon Glass wrote:
>
> > The app does not have this symbol. Also the memory where the app is
> > loaded is not under U-Boot's control. Disable this reservation for
> > the EFI app.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  lib/lmb.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 588787d2a90..420eae4d0b8 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -560,7 +560,8 @@ static void lmb_reserve_uboot_region(void)
> >               lmb_reserve_flags(rsv_start, bank_end - rsv_start + 1,
> >                                 LMB_NOOVERWRITE);
> >
> > -             if (gd->flags & GD_FLG_SKIP_RELOC)
> > +             if (!IS_ENABLED(CONFIG_EFI_APP) &&
> > +                 (gd->flags & GD_FLG_SKIP_RELOC))
> >                       lmb_reserve_flags((phys_addr_t)(uintptr_t)_start,
> >                                         gd->mon_len, LMB_NOOVERWRITE);
>
> What prevents U-Boot from overwriting itself, with U-Boot commands? Also
> how is this linking today? I see lmb_reserve_uboot_region in
> efi-x86_app64 for example.

The only memory U-Boot can use when running as an EFI app is that
which it has allocated using EFI calls. The actual U-Boot code is
certainly in memory somewhere, but does not lie between gd->ram_start
and (gd->ram_start + gd->ram_size)

Regards,
Simon
