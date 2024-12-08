Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D54E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 12:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9349E89515;
	Sun,  8 Dec 2024 13:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CXQRkDFd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EED948951D; Sun,  8 Dec 2024 13:24:10 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA3CF894E5
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 13:24:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6f00b10bc1dso1585157b3.3
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 04:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733660647; x=1734265447; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5/mjTg2KbiHsX7IxYH1mWA0yQD9N/XQy+MdmJmdD9bI=;
 b=CXQRkDFdu9htTFInFIqE2fUIMuNPFONAxXontL4OcF0WaCcmoLNo960jio0K1xXvU7
 wF9mffhiC0ujBUA7jIA1t9Gu736edDk9mvQrYeOycJxlqOS2Zv7a9oGC70sEDC0JbWQ3
 uFYJAFfovSDK5cRlhr0O3MLYDSWOKWd/YDnjHKHNrZ9dzVC7bEiB1608RWuSALIFSwTb
 06KqIp6x1ssDo0c8gVt4odJnK89yQwgerSj7g+0Xkq1Eax3cJJ/keqymNjGnEZzdSq2n
 H7Yu10dEsgLzL+Sryqdtz95ndC1G+jWZyVxufuyfEBjgUNevsNF1/gF7s+PrxM0cCV9X
 rqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733660647; x=1734265447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5/mjTg2KbiHsX7IxYH1mWA0yQD9N/XQy+MdmJmdD9bI=;
 b=wn1JXGLEqCEQMBBwhNLlPykK0tNpHlRzxN7y/sRyenOGGTJYWA3RmLRjIxlj1QgZT3
 5qBeItmPrQXs9Pubo4+QEZCwgIK/n0KR3lzdnfVUTpGO/aLpv+q6DJnqX6+H8vtjUJ9+
 EF1+HA09+7jrCEtbeEqLTTm5Ob9AHUW2bywtCpbpAyTCG2dbnPHqtesgnlFOEhbR2Nqg
 XfIendFF/ejkWZyoXN3ik4S0dK1FzvnoqjkL3t3UWFzhf2VJ+siRxUq7eo5IVEfgTIDW
 NaHxccOgimscpr/b163KrR2Pqp9Dio3uzB1T5m/K5pcFmMljZufmmp51227l+Tz6eAlP
 7BWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkqkjAahkd59AdSXQkRXCF3peGCRJycQb5wrrHSB1Td57rMKeQB7CZDR5f2Rmnwn2vnA7n/54=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8bGBaLY4qy2kTC4pISX6ozsZY6Rz1wpBageccf7jZZH4UE6zz
 VHfhKICQyLxPz97jntvNPNiuzfUby9iaY1fKHvp/aQee/l+VHVGH1wvxwwAbfD0YZuQ25KjTfwl
 nf1RxM+cNWtlD8B2Jzc6Kmhc8xJO9trY1yNMcmw==
X-Gm-Gg: ASbGncsJFKfMSMs3hd/6vV6KieYjfnjd/q0o2WaAWRldxzeq60RB01DBH/Eh9gxG51q
 +C4mfx8+7yrglmjiDNXaAcc/x8jg6R3U=
X-Google-Smtp-Source: AGHT+IFNpPDT1GGJcAR5cdcghI1HYLjj5OmsHdrvf3Oj3AdP3sey0AGYc488daTonC6Bfitd/qjDR2FLEoCAY+nHfEo=
X-Received: by 2002:a05:690c:63c8:b0:6ef:a474:b26b with SMTP id
 00721157ae682-6efe3c12818mr83451217b3.25.1733660647525; Sun, 08 Dec 2024
 04:24:07 -0800 (PST)
MIME-Version: 1.0
References: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
 <20241208105223.2821049-3-ilias.apalodimas@linaro.org>
 <F4F7021A-F167-4180-96F5-A2679A183979@gmx.de>
In-Reply-To: <F4F7021A-F167-4180-96F5-A2679A183979@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 8 Dec 2024 14:23:31 +0200
Message-ID: <CAC_iWjK8FF5yfAtnOqsPfKe2B26YBGx+esNcAyYQruj6+1pyFA@mail.gmail.com>
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

Hi Heinrich

On Sun, 8 Dec 2024 at 13:31, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 8. Dezember 2024 11:52:05 MEZ schrieb Ilias Apalodimas <ilias.apalodimas@linaro.org>:
> >There's no point subtracting -1 from the calculated addresses and then
> >check for a <= b. Just remove the -1 and check for a < b.
>
> I once thought that, too. But it makes a difference for end= U(L)LONG_MAX.

If those addresses overflow then we have to add more checks -- e.g
if (base2_end < base2)
{
     Do something wrong
}

In which case, I prefer modifying the function and add those checks

Thoughts?
/Ilias

>
> Best regards
>
> Heinrich
>
> >
> >Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >---
> > lib/lmb.c | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> >
> >diff --git a/lib/lmb.c b/lib/lmb.c
> >index a7ecbb58831f..c7bf5120696f 100644
> >--- a/lib/lmb.c
> >+++ b/lib/lmb.c
> >@@ -36,10 +36,10 @@ DECLARE_GLOBAL_DATA_PTR;
> > static long lmb_addrs_overlap(phys_addr_t base1, phys_size_t size1,
> >                             phys_addr_t base2, phys_size_t size2)
> > {
> >-      const phys_addr_t base1_end = base1 + size1 - 1;
> >-      const phys_addr_t base2_end = base2 + size2 - 1;
> >+      const phys_addr_t base1_end = base1 + size1;
> >+      const phys_addr_t base2_end = base2 + size2;
> >
> >-      return ((base1 <= base2_end) && (base2 <= base1_end));
> >+      return ((base1 < base2_end) && (base2 < base1_end));
> > }
> >
> > static long lmb_addrs_adjacent(phys_addr_t base1, phys_size_t size1,
>
