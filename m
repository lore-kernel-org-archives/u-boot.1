Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7DDFEDA09
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 01:04:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53EC484027;
	Wed, 18 Mar 2026 02:04:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RhQSsajy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3B8C84027; Wed, 18 Mar 2026 02:04:14 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BCDB84020
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 02:04:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b97d5b790cbso211080566b.0
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 18:04:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773795852; cv=none;
 d=google.com; s=arc-20240605;
 b=XEBgIVJoMu/8OU/C8rRTq3ezVmAKTiWd0AbSYQ6k524kqEorydkYxBYHIHLVaO9aaJ
 7vRngGVdEumqqm5uJsInbtYwp97ikCc5dBnP4tc/06w5Dv9OZs3tm6JXppl7SYOpXqWY
 oX5zFdJypy7JOs3eqnkUsALg/1UZ3/hBmM3/yd6DxqxXtkVpZb0j3hOBNyq7O3dquoRd
 xVrhSPWSfvVI7vVQ/9U9uRfn40DQutpFIA44Vw3P0uqblHUemV7coaE5fI9mLhbhwrNW
 d/itizBX7LGS8wx7kx+VYphntsAPaFi+LSLS6R/qE/OBl6g//xJ6ONgLqlYKCsMrB/lc
 spKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6wQPBF/ZPvNa/j6O+7X+NWlZCOZWoMniKaiVKsy6C60=;
 fh=77GWSjT2mlmLf3PtBjW8TPqEIXbpJQfI8TB2+BGo2u8=;
 b=IBLK3AQ4YIub72khjeMZ91efrTqMqJfnQozh2sBQ/1amda4KUPXBVxTautjjuzS2Dq
 SUawBcB7xATl/gHEaZR3cxqzyGrRI//AfTxd4Fj98trtKlKUrZDFdQQca/YEmtCerCsD
 oSWkZoqbqNoEGShTUAOrpQ10AZKo6AX1XYtA9C6kiR4EvKmOoJfyXSop/i4EGzdmL/vO
 O4IicW2kogt+QUq6tlfRk0FbDr9JvzlpcszjTyVGAasS4PgLhksOEYB7YQhBehGJ0Ue5
 AuLm2mJEg2sUSRCbYT5eG1bSYuNrG/2OQgSsliBmE0vEsDvpaWCTRgM2bLAnuAg8uLq7
 PSRQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773795852; x=1774400652; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6wQPBF/ZPvNa/j6O+7X+NWlZCOZWoMniKaiVKsy6C60=;
 b=RhQSsajyH74AD4JHH1JGeW6/pILWtoh5zSfbFBVmyg1MO/DeshuR16pGlyYQCsk8N9
 YJrVleBh9xM23CC0AtCm1SkwRnLUr12oPmnGeJf4B2JCh+nPu49IJgV/4XUy2paJlKcX
 T8IbKV/w8kEQIUdXsYI5mkpTkPHit2EqoyLCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773795852; x=1774400652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6wQPBF/ZPvNa/j6O+7X+NWlZCOZWoMniKaiVKsy6C60=;
 b=IgRrjGoMUBvJE97Gcbx128vU5QanAYulfq7atD9Fzxcyuv42HHdDS6AxLLIf1+LPxW
 zW8a7VsYTZx8mioz0wtEKpvB4FfCbef8Rs9wM9AM007kZnCm8H1TXSdUbxBemOXHXoWj
 lSVqzJKrukI3BEJmZS99/E+UhdcA1js038namGgfqtmi7q28RAN5TM5C0k28XFVt5DRL
 M9ILJfGc8fktHrAtAQRdhCYQUwSVfv7che0Ek6F2cvZprH4OI/XsoGsXkEB67W8S2uVB
 3ojt2jfvKjSxuagM/pAOxfUbVLwIdcGhv5MhYffSBJpA/FG82ypUHJk/y0xmZMCeYrI6
 1xkw==
X-Gm-Message-State: AOJu0YzT14GmNL12VHNcj8Gz15+bT7kt+WPNJfqMArp/MpkVS156YMNb
 q2lzPXlkHd4as7UI5aPPuaJBWkKb24ubeeqRXzHLK9w2LPbFop+8Akj0sCayOQ2AGiH1JhlqCJG
 1dIkOVHIszYZL2p0e4FLtJv7uaF1i1EgwdSZe8xZf
X-Gm-Gg: ATEYQzwOnUEYtgQ/UViMRaD5y4763XVlY7dRXqH+2TV2x558nRTsP1yY9oVBoTmAE2z
 ws/dkLkStXsWV9mQZiy61CeTEDGLigP5OhLg/Tn1YZbsPsIETs9YStJdZyzAH7IrRyZvTbhepCG
 4goOdMuZc2jYMxajV5xpe8sKruVvv4KuD2RSAbmauu7nO1FfG2YyT1pU4PL23sbLz/CmFBQwy6n
 tOd7tOORTgSBmctOkdPRHZIDILUiLrufIwxAZAu6nABXYqhbzZEu0NyAy5rTXzBxT0HeInjQYh3
 nDiGM24xPFoVTbbZ/MDV72JAdHo+SweCwxJfOVC38QdlPDKIzH8=
X-Received: by 2002:a17:907:703:b0:b97:f2b3:49b8 with SMTP id
 a640c23a62f3a-b97f4b01184mr72675066b.47.1773795851806; Tue, 17 Mar 2026
 18:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260311120910.3934114-1-ravi@prevas.dk>
 <20260311120910.3934114-3-ravi@prevas.dk>
 <CAFLszTjObK850TKYL7PmwFqrQRtdTtSAftVZpLUGSDwo8mApZA@mail.gmail.com>
 <87ldfsp4sr.fsf@prevas.dk>
 <CAFLszThvNq_KXzoyvOULU74EVWDRYcu2OYz0GS6N+D+mT-BD4w@mail.gmail.com>
 <87se9yo5hg.fsf@prevas.dk>
In-Reply-To: <87se9yo5hg.fsf@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Mar 2026 19:03:54 -0600
X-Gm-Features: AaiRm53RNCRJhvcTovvkXzbcCpSHutLstziJWXGH4zmPJ8qAGXN-cJQLRrXwPnU
Message-ID: <CAFLszTj-OyU=v0iomvSkYC-V0CQ2Vt4pcjTmEagWu_q-CQM+fQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] test: add tests for left-bracket alias for 'test'
 command
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

On Tue, 17 Mar 2026 at 09:12, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> On Tue, Mar 17 2026, Simon Glass <sjg@chromium.org> wrote:
>
> > Hi Rasmus,
> >
> > On Mon, 16 Mar 2026 at 02:17, Rasmus Villemoes <ravi@prevas.dk> wrote:
> >>
> >> On Sun, Mar 15 2026, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> > Hi Rasmus,
> >> >
> >> > On Wed, 11 Mar 2026 at 06:09, Rasmus Villemoes <ravi@prevas.dk> wrote:
> >> >>
> >> >> Duplicate a few of the existing test cases, using the [ spelling, and
> >> >> also ensure that the presence of a matching ] as a separate and last
> >> >> argument is enforced.
> >> >>
> >> >> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> >> >> ---
> >> >>  test/hush/if.c | 31 +++++++++++++++++++++++++++++++
> >> >>  1 file changed, 31 insertions(+)
> >> >>
> >> >> diff --git a/test/hush/if.c b/test/hush/if.c
> >> >> index ea615b246a9..148e9a53e90 100644
> >> >> --- a/test/hush/if.c
> >> >> +++ b/test/hush/if.c
> >> >> @@ -315,3 +315,34 @@ static int hush_test_if_z_operator(struct unit_test_state *uts)
> >> >>         return 0;
> >> >>  }
> >> >>  HUSH_TEST(hush_test_if_z_operator, 0);
> >> >> +
> >> >> +static int hush_test_lbracket_alias(struct unit_test_state *uts)
> >> >> +{
> >> >> +       char if_formatted[128];
> >> >> +       const char *missing_rbracket_error = "[: missing terminating ]";
> >> >> +
> >> >> +       sprintf(if_formatted, if_format, "[ aaa = aaa ]");
> >> >> +       ut_assertok(run_command(if_formatted, 0));
> >> >
> >> > How about using run_commandf() so you can do this in one line? Looks
> >> > good apart from that.
> >> >
> >>
> >> I did cringe a little when I saw that repeated sprintf()/run_command()
> >> pattern all over that file, but I preferred to stay consistent with the
> >> existing style.
> >>
> >> If anything, one should do a whole-sale conversion of that file, but
> >> then I'd not use run_commandf() directly, as one would still pass in
> >> that if_format argument every time, so rather create a local macro that
> >> wraps run_commandf() and provides that if_format as a literal string,
> >> which would also enable format checking.
> >
> > Well you could have a helper function which takes the string argument
> > and does the assert. The duplication makes it a bit harder to
> > maintain.
> >
> > sprintf(if_formatted, if_format, "test aaa != aaa");
> > ut_asserteq(1, run_command(if_formatted, 0));
> >
> > could be something like:
> >
> > ut_asserteq(1, check_operation("test aaa != aaa"));
>
> Yes, I'd definitely make sure that each test would only occupy one
> source line instead of two. What I meant was that I didn't want to
> convert
>
>     sprintf(if_formatted, if_format, "test aaa = aaa");
>     ut_assertok(run_command(if_formatted, 0));
>
> mechanically into
>
>    ut_assertok(run_commandf(if_format, "test aaa = aaa", 0));
>
> and having to repeat that if_format thing on each and every line.
>
> Also, I think I would prefer to change the assertok()s into asserteq(0,
> ... ) as I think the mix of assertok() and asserteq(1, ...) is not very
> readable.
>
> > If you had the energy to adjust the rest of the file, that seems good too.
>
> I will fix that in a followup if the current patches get merged (they're
> at v2 by the way), I do not have the energy to start over and doing the
> mechanical changes first and then redo my patches on top of that, so
> please don't request that I do that.

That's fine with me, please do. Yes I think I missed v1.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
