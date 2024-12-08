Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6746E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 12:35:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DF8A8953F;
	Sun,  8 Dec 2024 13:35:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Hz7foH3B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3666A892DA; Sun,  8 Dec 2024 13:35:04 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53A4289515
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 13:35:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6ef7c9e9592so31608767b3.1
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 04:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733661300; x=1734266100; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ikv1/eBGCbwGKU4CBQeDOvpNol5YU0Dc6BhPNx975Xk=;
 b=Hz7foH3BkIfndgMRCHYl1OtNUQm5QTjb4idfw3rPbv1fVI6Pd5y5cF6cyY1mB0zWme
 C5Wrj+3lrWz0ZT70dgb83nLUxWWpgD3+BuAbpYDrxJGhoJEEVGRFdrTav0zMuJ7Fr7h5
 ZiGgSuMnHDgR4goYOf86dlVixYHdpKuaJvcGYydPYlyRAP3DDUlTGYhEmRf36MsvKAwf
 MbLiFsfGOEoWVEAhp4VStYKdaMKDQZ/Wb459BSMdicGRL4dBG19TDLN5oN+ZjFUh7qDF
 +z0WEP1ZJXaCBlFmkQyQjpiLltuj3TKffIl2yKebKIy5TMOfqAA1rB2wS0euBPWJcp7q
 XCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733661300; x=1734266100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ikv1/eBGCbwGKU4CBQeDOvpNol5YU0Dc6BhPNx975Xk=;
 b=e22LSPUnm/wCvATrXwh7qJ8Iz9iLsn0FrIUhcvfSo2K0G3wkAp1xTo5sUwIZi0KrFz
 HYNNntpaP4zvKbFqmzmcnF4gk5S60Tfh/1tdmX4KtcJQz0NTLbOwj8kGqV6cH5bjdWBG
 ObdoOpoOkI6i4iiW8SN6qSKfflkcAx9jqdoO1tZ6gZGi2Nf45lEzqM8lz3wDK42MhvMj
 1ZQsO6JOKPv5/ZnCFXh4iJmS6ZswcWpO1BYgs+u9DiPjGIFtT9YMaj51/+hXnbn3gyma
 FpZuntEppjHXYqRfPoXWXnIzmEmiNsC87TgD7gWCDBopDhkfOif7laADz+lKMzBcEgyR
 unrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL2Lsjo28N9EIWvU3fUXXTpPRCoKwCZQ0wAzVzJUIfrlN12EseMB4Yll2p0sn5rYnmhwHYPtw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx78PqkR89vLgdPlWS+4EF6KiVUa9S7oUxVwGopvWpTwrVavMOv
 egsKQeVWwnqb667uEQhb/9xW90RR5p/EPJoLekNwPwvzHCdp/wzporlFIlaWH0rQFvGTvlm4iAf
 KC+QBX4RwpKC7W14aV0Emf99lEURDNJhVmWVrVQ==
X-Gm-Gg: ASbGncso8Ng/hCnFnIfCahQj+iD+M6wTmYlWJe980Kb4owG3IEAYwBOTQeUGhjDb40B
 dPwsDe8CzcpPT46KNtsJnPzvz8l0+Cho=
X-Google-Smtp-Source: AGHT+IG7JfdOF7iypkx+olbaQ9Y8+GRyDRJ0pLZ4Ksp1rYU30TG65HCk5wTBQhwRQEyLNgC/AA5HLz44mzNJd4iKaQ0=
X-Received: by 2002:a05:690c:6184:b0:6ef:6536:bb6f with SMTP id
 00721157ae682-6efe3c0ee28mr87416607b3.22.1733661300246; Sun, 08 Dec 2024
 04:35:00 -0800 (PST)
MIME-Version: 1.0
References: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
 <20241208105223.2821049-3-ilias.apalodimas@linaro.org>
 <F4F7021A-F167-4180-96F5-A2679A183979@gmx.de>
 <CAC_iWjK8FF5yfAtnOqsPfKe2B26YBGx+esNcAyYQruj6+1pyFA@mail.gmail.com>
In-Reply-To: <CAC_iWjK8FF5yfAtnOqsPfKe2B26YBGx+esNcAyYQruj6+1pyFA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 8 Dec 2024 14:34:24 +0200
Message-ID: <CAC_iWjJLWDyaPQ0fDP6POQEw3nmdk+PD4j9uEKwa_rC00t0zbw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] lmb: Simplify lmb_addrs_overlap()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: trini@konsulko.com, =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Nam Cao <namcao@linutronix.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Janne Grunau <j@jannau.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Sun, 8 Dec 2024 at 14:23, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Heinrich
>
> On Sun, 8 Dec 2024 at 13:31, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > Am 8. Dezember 2024 11:52:05 MEZ schrieb Ilias Apalodimas <ilias.apalodimas@linaro.org>:
> > >There's no point subtracting -1 from the calculated addresses and then
> > >check for a <= b. Just remove the -1 and check for a < b.
> >
> > I once thought that, too. But it makes a difference for end= U(L)LONG_MAX.
>
> If those addresses overflow then we have to add more checks -- e.g
> if (base2_end < base2)
> {
>      Do something wrong
> }
>
> In which case, I prefer modifying the function and add those checks
>
> Thoughts?
> /Ilias

I'm replying to myself here, but the check above isn't needed it's
already implied by the return checks.
I'll drop this in v2

Cheers
/Ilias
>
> >
> > Best regards
> >
> > Heinrich
> >
> > >
> > >Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > >---
> > > lib/lmb.c | 6 +++---
> > > 1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > >diff --git a/lib/lmb.c b/lib/lmb.c
> > >index a7ecbb58831f..c7bf5120696f 100644
> > >--- a/lib/lmb.c
> > >+++ b/lib/lmb.c
> > >@@ -36,10 +36,10 @@ DECLARE_GLOBAL_DATA_PTR;
> > > static long lmb_addrs_overlap(phys_addr_t base1, phys_size_t size1,
> > >                             phys_addr_t base2, phys_size_t size2)
> > > {
> > >-      const phys_addr_t base1_end = base1 + size1 - 1;
> > >-      const phys_addr_t base2_end = base2 + size2 - 1;
> > >+      const phys_addr_t base1_end = base1 + size1;
> > >+      const phys_addr_t base2_end = base2 + size2;
> > >
> > >-      return ((base1 <= base2_end) && (base2 <= base1_end));
> > >+      return ((base1 < base2_end) && (base2 < base1_end));
> > > }
> > >
> > > static long lmb_addrs_adjacent(phys_addr_t base1, phys_size_t size1,
> >
