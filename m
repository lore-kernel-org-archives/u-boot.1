Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AB1CD98F7
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 23:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE28D83E8E;
	Fri, 14 Nov 2025 00:34:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fy+x3S+1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB21883FAE; Fri, 14 Nov 2025 00:34:19 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87B6A83E86
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 00:34:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-64088c6b309so2382099a12.0
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 15:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763076857; x=1763681657; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UQSdkuVMNJraBLWuNbBXVJ4RyJjBv8AZtY1l9ZZZoK0=;
 b=fy+x3S+1G5iJvgA9tRA1Azl9urOKeX+3Rix8gsi9VaLtyeAfRjCbc7mKnKSeYR4lhx
 imLH9JTnuhFhXss4jTvXZryLFOlWkpDol0Pevx9L3K3+XC5jlOLDorCVmC+pulBoTWrN
 yAwVCFVNFpWSYCN0WA/Xggy07ytJyPjaw2m6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763076857; x=1763681657;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQSdkuVMNJraBLWuNbBXVJ4RyJjBv8AZtY1l9ZZZoK0=;
 b=ePXtO0UqJTq3GNeo4GxFTxVR/PwFOkr5/rg7zfmD6gZo7OcF7wJKAs79GgTcES57Bx
 rlbzmWyM+AbIe2d1w66NdEvcVybDBr2B3lisbJ1RoO3ezLHt6VfOJrvA03C5cfqdx24Y
 OuZ4dCuCuks3R8NrATOIwbEO2pqMei/CPbhNZ2BHXG25iWu9F49xka1+il/rGK3IJT1s
 NrsM0MnQG17YLx4wZSudXthUpGdWNpN8yICPFhqWb3hGMVgWV4v4rkabGZQCeozq8Ee/
 pkxR0OXtDJHiaihk8oLzCPw2lQ8dtgzoVSiIAwZiXf13c1F3cmaepFNva3B/IInU11OR
 /moQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL+L7cX8UnICClbM19R8h09veT8rN/M0g/sOFJztT7gKAe5Mu90B6TnZir0YxPqIbzWPzaOdc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0lpNysZicyLx37FI9roTzFWyAPzCDxhpOwezMACpOw627/Wlh
 v1vA7Yso1OQF37ufaOn+14gqvphIE88H18C8TjJXCmsKnuVcCCDfbAPcRS3GtqUY3tvvzAABrdm
 gltw9V+8vOgMO+ILvMR9Bwc6LsGOYDRPGWg1jSrQx
X-Gm-Gg: ASbGncu1HnwKt0lU7iJU1gN4u/He8zdrhWTVmsyhUD1obY1X1Jw//aUinvCvSOUkSq9
 SWBZc+Ov1VVjfp8eadU1IZQ2u55Viqx8gfggiWFMbhk6vmZRxAad2YmIX50pVUPNHERSwf3A9vH
 xr7q/V/u4UZ75tNr+W6XSProUph6x5RFl88oVC8M2NaSMD7xbAlAbBzp4NHsALDH8cKuefvsHCq
 1UnV4yLr9alorsAJmk6s+bxNo1pUuTOI0DxEr0YjGa0/PbKYMcLO1qGzliWzHOORpXqkQ==
X-Google-Smtp-Source: AGHT+IFFC76IcNVwcFNerlIoDSUia6V+z50H33tBHxfUoT3D2/2hehew4LXRgg1iPbLi16VTRmKdbKAEJGSxI5U62hU=
X-Received: by 2002:a17:907:3fa0:b0:b73:1756:3718 with SMTP id
 a640c23a62f3a-b7367869dcfmr106966766b.4.1763076856921; Thu, 13 Nov 2025
 15:34:16 -0800 (PST)
MIME-Version: 1.0
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113122145.949112-4-marek.vasut+renesas@mailbox.org>
 <CAFLszTgRxLTWjCCbxxme9XtG2E80CrYOesry_86YuagL8uPJ-w@mail.gmail.com>
 <8a4ba995-840a-41ed-b496-6c32965d4ce5@mailbox.org>
In-Reply-To: <8a4ba995-840a-41ed-b496-6c32965d4ce5@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Nov 2025 16:34:05 -0700
X-Gm-Features: AWmQ_bk4d0m30hXouilz1ZCqUU_YqrlxBJ2vNtWf-ogPwzMCaP0JKx-22eEgVGQ
Message-ID: <CAFLszTg6dF1dmJJDh8-2ZjUf6i9+ZOFvWNSxNRS_PBQ3CDNtHw@mail.gmail.com>
Subject: Re: [PATCH 3/3] libfdt: Check fdt_offset_ptr() return value
 unconditionally
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sam Edwards <cfsworks@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Marke,

On Thu, 13 Nov 2025 at 14:57, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 11/13/25 8:33 PM, Simon Glass wrote:
>
> Hello Simon,
>
> >> The fdt_offset_ptr() may return NULL pointer, check the return
> >> value from fdt_offset_ptr() for NULL unconditionally to prevent
> >> sandbox crashes.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> ---
> >> Cc: Adriano Cordova <adrianox@gmail.com>
> >> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> >> Cc: Christian Marangi <ansuelsmth@gmail.com>
> >> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> >> Cc: Sam Edwards <cfsworks@gmail.com>
> >> Cc: Simon Glass <sjg@chromium.org>
> >> Cc: Tom Rini <trini@konsulko.com>
> >> Cc: u-boot@lists.denx.de
> >> ---
> >>   scripts/dtc/libfdt/fdt.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/scripts/dtc/libfdt/fdt.c b/scripts/dtc/libfdt/fdt.c
> >> index 95f644c31f9..d16cc3d4730 100644
> >> --- a/scripts/dtc/libfdt/fdt.c
> >> +++ b/scripts/dtc/libfdt/fdt.c
> >> @@ -168,7 +168,7 @@ uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
> >>
> >>          *nextoffset = -FDT_ERR_TRUNCATED;
> >>          tagp = fdt_offset_ptr(fdt, offset, FDT_TAGSIZE);
> >> -       if (!can_assume(VALID_DTB) && !tagp)
> >> +       if (!tagp)
> >>                  return FDT_END; /* premature end */
> >>          tag = fdt32_to_cpu(*tagp);
> >>          offset += FDT_TAGSIZE;
> >> @@ -186,7 +186,7 @@ uint32_t fdt_next_tag(const void *fdt, int startoffset, int *nextoffset)
> >>
> >>          case FDT_PROP:
> >>                  lenp = fdt_offset_ptr(fdt, offset, sizeof(*lenp));
> >> -               if (!can_assume(VALID_DTB) && !lenp)
> >> +               if (!lenp)
> >>                          return FDT_END; /* premature end */
> >>
> >>                  len = fdt32_to_cpu(*lenp);
> >> --
> >> 2.51.0
> >>
> >
> > The can_assume() is there to be respected and helps to reduce code
> > size. What problem are you actually seeing?
> fdt_offset_ptr() can return NULL, and it does in test_spl on sandbox if
> I recall it right, because the U-Boot code passes in offsets which can
> not be resolved properly and that makes fdt_offset_ptr() return NULL and
> trigger SIGSEGV when it is dereferenced here.

That sounds like the FDT is corrupt? Here we are parsing through tags,
so we should really figure out why it is corrupt.

But if note, then we should not be passing bad offsets...so what is
the root cause of that?

Regards,
Simon
