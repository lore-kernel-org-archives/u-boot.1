Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C260FD875C
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 12:29:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45C558429E;
	Tue, 17 Mar 2026 13:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IEzuuSAB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9008B842A4; Tue, 17 Mar 2026 13:29:16 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFF4C84297
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 13:29:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so791565766b.0
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 05:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773750553; cv=none;
 d=google.com; s=arc-20240605;
 b=HRlf3sMr+PNCA/0MwciGfR5QtkfJIph0JQQs2Gc3VQbGouTWjWxaJ/y3NRNo8yorSi
 DYXxH7wnrVt/ORyz0G0zUQAq7CEzNfCr+FJJn+om05+l8C1Ml21kzOKEC9s96xny3OUF
 yDCCyfj+76oy2vknPYJE9HiLx8eZ/MWlhscmZiWZBhTXpPkNusx11t4IY5dzpqsQGGOU
 gGypPFrFgZSLfqglmQstKeYVex8XwKY/1r1WN4oXogq1Dt4iifFUtMCCkukQDrQLF3uY
 +GJVOFnk9oKaoAIZhxL5NZdkx9+gOogLzYUInKntMxbWJ/zrPHvt7u1rPtjCjz7Q+X5i
 3rOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1NQUU8sUIhU5Xj3GkE9Z/5WFRG/SdZKcQ1ssF/Novd4=;
 fh=77GWSjT2mlmLf3PtBjW8TPqEIXbpJQfI8TB2+BGo2u8=;
 b=WnXd+fMlHgKrNY6ceUtZ8nJcHaAFxEubu1st9uJi788SBK3iXADkWe/0olOT+TGwqQ
 PKJtBOlr6E2TKcMTYjl3Ins0Q6OVeFbIciS99opCImCUsfw7ELo+HR8OFT3GwnberooA
 5m4Xsyb7nxl8I1SQ90Y6MqaWlxmZZu9mZ1ZAkDBg/IMEw8SC50HfSk5pjGz0+ZW0dUE4
 yMrT9xeKnIBuieqa1+UcPzkAA7PAFA0d62t56OMQ3eoO7QXjTruEMcpUzhoOFtuRV6VD
 QSKAKAiiVQNK+EhtEtPSfPGqF1lmfeE7Od+NzOAHGH+wNaChKTVFsKzUlU2Z9SR4TzTH
 upQw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773750553; x=1774355353; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1NQUU8sUIhU5Xj3GkE9Z/5WFRG/SdZKcQ1ssF/Novd4=;
 b=IEzuuSABpgfj5oFx7/JRoyncpCkpn/FeDjcLrtiRqyAtMLR/+7Q3pwsP+WxPYjcGAk
 svT5OKp/lLyn/4lPUjM+xYYXiEoonLy0pcHWkBPLRJC019aArNhpT1TkW1GeoSZniiBx
 x1i8wTTlbNWVpQUnmmSY7Zi3Fpr1l/GeXr5Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773750553; x=1774355353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1NQUU8sUIhU5Xj3GkE9Z/5WFRG/SdZKcQ1ssF/Novd4=;
 b=b06Tc7+7pSMtiA293AIr2N/sX1K0BrsM6jf0+x3j9RFTjiCgzjkzkx1bEwgiAorOEu
 1dNXtWPcTYjiW0RlIa6ZNa8HC0OU2IKfu2eexaTZQVAGI2K+08G8gy+6DImT2TZ6tA6r
 D058Mfo3ZMiZzwjPuaeWq/HmzrUvh/4adZykzD6M3KQqADCwk1jGLMFi7qalXUMDtXtF
 DLTEtWpkKnAFwuGFVDqKe3ZUBzpfFtYXVcXFKyhJ4L014Gr/vIitMPeMYCBLBjUPFn2K
 y/1xCoYi/Nrt4HM5yodV3pU8JoycTW/9BkvJs5IIRCniG9x5/NbuQFHuz0tHJHYszefB
 JSNA==
X-Gm-Message-State: AOJu0YzqdPShbJ1Mk9oqcJ1y2piWn6MBed4AyiflXImOOMHegSldDO7l
 rzF1OVwxKXCuqMzrfDRnTCWj9qhffJWLfBi3APGDzIW6ucMMFGtQ6kCOXtBNyz8JNIIklYJv/ku
 +DIC/6OG0NqbaC4+6zrQz7EqflBU1hwJ120q6QmmuYy8AkXgt8OM=
X-Gm-Gg: ATEYQzwBIvii1p/nnWx0lyl5spiOgW6u6hwejKg5IGDztK23oNE2xP+FeZCeauDp6a4
 vaew/kyuzRI3cx7gt/R813jDXSfUz8IsU6EiK4csdpwBcjhiaXGTWlITj4CdS8FfcL/Ha75hqRZ
 jS9vEs/excyAyDp08UNBELzwm1Pk96lM9bpczOt8QXBDfGNScLkGSMIexUkTJQhdLKIeqP+fgb1
 BaZ7iwUflgBfglfW5NeixnjnyBRizm0LWXND1vKRCibezph1SpN/LD/vL/SciEiYZ0V7fQuvbZm
 v9plPg==
X-Received: by 2002:a17:907:a42:b0:b97:17b7:d8eb with SMTP id
 a640c23a62f3a-b9765392026mr1096857066b.38.1773750553220; Tue, 17 Mar 2026
 05:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260311120910.3934114-1-ravi@prevas.dk>
 <20260311120910.3934114-3-ravi@prevas.dk>
 <CAFLszTjObK850TKYL7PmwFqrQRtdTtSAftVZpLUGSDwo8mApZA@mail.gmail.com>
 <87ldfsp4sr.fsf@prevas.dk>
In-Reply-To: <87ldfsp4sr.fsf@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Mar 2026 06:28:57 -0600
X-Gm-Features: AaiRm513lddp8ArENjHhE_KFWc4fz9Ad1MTSTWvnnNX1Kt8QtUFOpmI_rYtgugE
Message-ID: <CAFLszThvNq_KXzoyvOULU74EVWDRYcu2OYz0GS6N+D+mT-BD4w@mail.gmail.com>
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

On Mon, 16 Mar 2026 at 02:17, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> On Sun, Mar 15 2026, Simon Glass <sjg@chromium.org> wrote:
>
> > Hi Rasmus,
> >
> > On Wed, 11 Mar 2026 at 06:09, Rasmus Villemoes <ravi@prevas.dk> wrote:
> >>
> >> Duplicate a few of the existing test cases, using the [ spelling, and
> >> also ensure that the presence of a matching ] as a separate and last
> >> argument is enforced.
> >>
> >> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> >> ---
> >>  test/hush/if.c | 31 +++++++++++++++++++++++++++++++
> >>  1 file changed, 31 insertions(+)
> >>
> >> diff --git a/test/hush/if.c b/test/hush/if.c
> >> index ea615b246a9..148e9a53e90 100644
> >> --- a/test/hush/if.c
> >> +++ b/test/hush/if.c
> >> @@ -315,3 +315,34 @@ static int hush_test_if_z_operator(struct unit_test_state *uts)
> >>         return 0;
> >>  }
> >>  HUSH_TEST(hush_test_if_z_operator, 0);
> >> +
> >> +static int hush_test_lbracket_alias(struct unit_test_state *uts)
> >> +{
> >> +       char if_formatted[128];
> >> +       const char *missing_rbracket_error = "[: missing terminating ]";
> >> +
> >> +       sprintf(if_formatted, if_format, "[ aaa = aaa ]");
> >> +       ut_assertok(run_command(if_formatted, 0));
> >
> > How about using run_commandf() so you can do this in one line? Looks
> > good apart from that.
> >
>
> I did cringe a little when I saw that repeated sprintf()/run_command()
> pattern all over that file, but I preferred to stay consistent with the
> existing style.
>
> If anything, one should do a whole-sale conversion of that file, but
> then I'd not use run_commandf() directly, as one would still pass in
> that if_format argument every time, so rather create a local macro that
> wraps run_commandf() and provides that if_format as a literal string,
> which would also enable format checking.

Well you could have a helper function which takes the string argument
and does the assert. The duplication makes it a bit harder to
maintain.

sprintf(if_formatted, if_format, "test aaa != aaa");
ut_asserteq(1, run_command(if_formatted, 0));

could be something like:

ut_asserteq(1, check_operation("test aaa != aaa"));

If you had the energy to adjust the rest of the file, that seems good too.

Regards,
Simon
