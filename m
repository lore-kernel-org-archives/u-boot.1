Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89347CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 04:42:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7A89846C0;
	Wed, 27 May 2026 06:42:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K7+aDSKS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31CCA846CA; Wed, 27 May 2026 06:42:16 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26A67841D7
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 06:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bd8f6ef4ba6so1696206366b.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 21:42:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779856933; cv=none;
 d=google.com; s=arc-20240605;
 b=akdm4JdvRtF4oHUlj3TydsRr+xFN7pAXxwGUNz0o7uUbk/+3in+eLrhLkoyhZZM0sB
 rd0JdKhyd9OHknPSNTdd3+HlqjR+wjUnX0Xyy3+xFh5yKZ7EvNEqyF5xYiGB/CH/4d3x
 t4ldn4ippYCS6R59lsLgWnDhGO0DGg2SFHwy10XcWN9ZSl5lj/am2bhmNPU5cVOj3Hn6
 IhmZqURMjOLchyt+Q8rkOZp1KiCwltM99nc7yNczBseKyXqg/AhKpYA5toII76XhXtYg
 F+oK7QIKOXtabqQZvsai4wOcSZXUbFzDLm9Xi/XJQiop2FTnTUfEAVXld59D70g9lavE
 CgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=86TinltFs/Vs/q18qFE1PYu7QTnWQoJ3VW1fduY/JfI=;
 fh=77GWSjT2mlmLf3PtBjW8TPqEIXbpJQfI8TB2+BGo2u8=;
 b=lwKb5oku5vHRixtj5x0zVOFoHsPo3hndqkXtTVgYU/EGTWcw4l0GQGWrnYubmctJcj
 oa1bU3o+5fIC0WlWESbU45MkOWn/OpwbgXNVhRkidtKpuXv7IWGmu+ElZJYWpvMvfPxx
 pKWOnmyP9CP4c8c5IOpcNK6kad6PfQ4iX5xRQ4Xm+i8gs9dlp6VGi0Bg407dEJKggcoc
 YvrRtbC3HmdZJvMpP28Uc189KX8irn7IgMJH3SXLLnN0vFMqjuDM/3xOozEgfLrbfEpM
 YYoxleHXMMm0FRsv2kIAagEFQCRqZVsZv6RGnSPqCCyaue1qfJ6eULGIqaI8TtkE6V9K
 qfHg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779856933; x=1780461733; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=86TinltFs/Vs/q18qFE1PYu7QTnWQoJ3VW1fduY/JfI=;
 b=K7+aDSKSdU0U2GxZBqjuTe/NF4WbH+3iut3GZdlBjy2pKc9hRhOC6zK7rtAoexwPtL
 lTRbiH9V6MTgJbuGcIAnw0ULBk8wWgzzyjPUzpXZz/Z9DzquFsPt5ZQEJ8UEhNPqw5Zp
 7ulVfVEpa+FMSoMgKzuxMcJPuMu24BOy0g3rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779856933; x=1780461733;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86TinltFs/Vs/q18qFE1PYu7QTnWQoJ3VW1fduY/JfI=;
 b=QoC0Ii5Us2HcOYKS22dF4IyQyu1LEjsg0lD04rMMXOV63Zv4nRPkT9dzAI3o2dQ2Ww
 ThSlLRW9pDEd0xrsyimLn1iCjkGHQUmW2wvnDH0glaOLEg0eNKrdRyDCTG+DmA+E50ht
 xjsuxfiLABvUx3RxxQWJPrR9W8RP9HhgDEWBvz+PSoGi90EhV00C6RI4VIuRRqkzg9+x
 Ru0J308MvZlkIpnYu/FzqWkM0wdS33eWxs87QGNq1pB47AH3M8gqqmFwr7SoUlhDnh+6
 B1xr/ONA6vCvpToWjnDcqAUsGd0TVuXqMxkBqDSlb/56D2EKKHJy49w2v0oqnu47MkMq
 SOaw==
X-Gm-Message-State: AOJu0YxR8DpchYelH0yURrvN3icsfSzRQ7xuefnDWXg60cb6xsceRQet
 G9NzN0BmBUIizPf07Kwa4vVlv/e5HqiXaTdgxZ0XhyotPd5LOyvlzbaJRn5QyEo6hcTQN+cGvMM
 F9YflgGq65C+4tSFKKHzxkO6NVOk/0gJkCZ66oJhA
X-Gm-Gg: Acq92OFozvPQdO2wC6ggZTLExzVZXNb/eGneEX+S1VZ3Akxi6mBwH5vC+B8ujlh+xeL
 oBcdYSr4XBko9Tm9w7NC7045dqtfheJaFGwjSEREjqc+c1eDsMEKjqa4sBoenQMFQGUl1L6u/Ep
 jkq39YaS0elRq7EjLhNNGtWO4z11h4/K3D0feOYAHbBvCebMbmPSp2WfFIjE58VDozC5W4zx2xl
 Wh3Y+qZgI2DllNuWAaAdsAdnLQEpha4/Ln0sKfPNIsO+mmF5pLId9P09TFQA9RD/HL0VsZLn3I3
 HcrJF30/eRXqdtiY
X-Received: by 2002:a17:906:8474:b0:ba8:e7b5:39ad with SMTP id
 a640c23a62f3a-bdd1fca4d43mr963045466b.0.1779856933496; Tue, 26 May 2026
 21:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260522212756.3169222-1-ravi@prevas.dk>
 <20260522212756.3169222-6-ravi@prevas.dk>
 <CAFLszTi-se65R5w99LSUT3BwgJbe9UrXzB7VoTVo3CSSVg9Pkw@mail.gmail.com>
 <874ijtg81f.fsf@prevas.dk>
In-Reply-To: <874ijtg81f.fsf@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 23:41:59 -0500
X-Gm-Features: AVHnY4KHWIUuUCy2swnJ8Fg8MIuV_hRjuRX7JL2vPaY6PidloBHq8hTpJT5TTn8
Message-ID: <CAFLszTjE7hcNLfJUpkDfYRzyQKRfz-O22hX1NNrKKKRhEuVrBQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/9] linker_lists.h: drop _2 from section and symbol
 name prefix
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Rasmus,

On Tue, 26 May 2026 at 15:44, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> On Mon, May 25 2026, Simon Glass <sjg@chromium.org> wrote:
>
> > Hi Rasmus,
> >
> > On 2026-05-22T21:27:48, Rasmus Villemoes <ravi@prevas.dk> wrote:
> >> linker_lists.h: drop _2 from section and symbol name prefix
> >>
> >> Since commit e2138cf1e60 ("linker_lists.h: drop never used ll_start,
> >> ll_end macros"), which removed macros that would create
> >> __u_boot_list_1 and __u_boot_list_3 sections, the first _2 in the
> >> linker list section names doesn't serve any purpose and is in fact
> >> just confusing. So remove it.
> >>
> >> There never seemed to be a reason for the symbol names to have that
> >> _2, other than perhaps for consistency with the section those symbols
> >> belonged to. Regardless, remove that as well.
> >>
> >> All linker scripts use a '__u_boot_list*' glob, so they will work just
> >> the same without that common _2.
> >>
> >> Keep the _2_ part in the separator between list and entry names for
> >> symbols, since that is called out in the documentation to allow one to
> >> define sublists and iterate over those. I cannot find any current use
> >> of that feature, but a later patch will make use of just that.
> >>
> >> [...]
> >>
> >> include/linker_lists.h | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> >> diff --git a/include/linker_lists.h b/include/linker_lists.h
> >> @@ -19,11 +19,11 @@
> >> -#define ll_start_section_name(_list)        '__u_boot_list_2_'#_list'_1'
> >> -#define ll_entry_section_name(_list, _name) '__u_boot_list_2_'#_list'_2_'#_name
> >> -#define ll_end_section_name(_list)          '__u_boot_list_2_'#_list'_3'
> >> +#define ll_start_section_name(_list)        '__u_boot_list_'#_list'_1'
> >> +#define ll_entry_section_name(_list, _name) '__u_boot_list_'#_list'_2_'#_name
> >> +#define ll_end_section_name(_list)          '__u_boot_list_'#_list'_3'
> >
> >>
> >> -#define ll_entry_symbol_name(_list, _name) _u_boot_list_2_##_list##_2_##_name
> >> +#define ll_entry_symbol_name(_list, _name) _u_boot_list_##_list##_2_##_name
> >
> > The linker scripts all use a '__u_boot_list*' glob, but several other
> > places hard-code the old prefix and this patch does not update them:
> >
> > scripts/gen_ll_addressable_symbols.sh:14 greps for
> >      '_u_boot_list_2_[a-zA-Z0-9_]*_2_[a-zA-Z0-9_]*'
> >   which is fed into the LTO keep-symbols build step (cmd_keep_syms_lto
> > in the top-level Makefile). With the new names this matches nothing,
> > so LTO builds silently lose the __ADDRESSABLE() guards.
> >
>
> > scripts/event_dump.py hard-codes
> >      PREFIX_FULL = '_u_boot_list_2_evspy_info_2_'
> >      PREFIX_SIMPLE = '_u_boot_list_2_evspy_info_simple_2_'
> >   so the script (and test_event_dump.py) stop finding anything.
> >
> > test/py/conftest.py has
> >      RE_UT_TEST_LIST =
> > re.compile(r'[^a-zA-Z0-9_]_u_boot_list_2_ut_(.*)_2_(.*)\s*$')
> >   which is how test.py enumerates ut subtests - this breaks test
> > discovery for individual UT suites.
>
> Ah yes, thanks. I wonder how I could miss those.
>
> They are of course all trivial to update. But for the
> gen_ll_addressable_symbols.sh script, I do wonder why the __ADDRESSABLE
> wasn't just made part of the ll macros. It has since grown another
> __stack_chk_guard, but that too should be able to just have its
> ADDRESSABLE marking in the (ordinary C) TU that defines it.

I'm not really sure, but perhaps it was so that the same mechanism
could be used for all such symbols, avoiding __ADDRESSABLE bleeding
out into the rest of the code?

Regards,
Simon
