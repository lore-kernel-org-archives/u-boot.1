Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197D9CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 16:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97556839DE;
	Wed,  8 Oct 2025 18:57:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zcpsj9qN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03A0083A5C; Wed,  8 Oct 2025 18:57:11 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC47C839B9
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 18:57:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-639e1e8c8c8so56933a12.1
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 09:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759942628; x=1760547428; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gsxv8oyhCjgEEnal+U1aqTz65iaTT8jY5UuB6z4kgZU=;
 b=Zcpsj9qNFuyz1n6L+mQ4odqzBbMYvFShozEKb/JkdTpswW6A5lVUuYDr96Y6IUAard
 Hxteigg9fsw5p3r/b1QF36nT1n/O3hs9BQtv2JcbwMocEwBwsOFfqHv9Ph6O11cAfySm
 QD4SvRKw4/gUwQk/aMu+/RB6ulfJaor0XwNns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759942628; x=1760547428;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gsxv8oyhCjgEEnal+U1aqTz65iaTT8jY5UuB6z4kgZU=;
 b=uGKUtgkfMXHMZmcI6tnNRTWfYWlakDxJ0y4sCC9yIovz/rGOfiyHlJ9ySFZ6ed67di
 XMG4QCIZvO9ZDeckeU+LyNsqsRDp0lD+TTSf0rGNfAUgi8ek2oYKrrPltpZ9Pl1hWkvU
 u945UYqR0gilPxPUiWiMIcuCJiktfMD1fv5OUMIAZcTSV1BkpJjrI3f+Lrau+CgbvSBU
 CWkrSO97vBuA97wgXLVBbUS9qAwZoN6OehcJ/kLy7z4XjMoVGeIqWMhq8Y1mcv0Tifq0
 0VbNyG1Vte0aTIfQCCe9t3wcAMc+fp2JwquhPBwxKV1/cGledw+Ssp4RFNc7ib+cWkgV
 a4TA==
X-Gm-Message-State: AOJu0YyLNQFuz7sX5hfI8pcBycTeJGtsa5M15eMRiFIdS/6J3SnfwtZg
 99fByuTArjOIQxUI30mWqW933Bn4HkoouQ6dWChWnQCVCvdj1EFibR6S5jYjMBT+rNEgE1iK2K9
 lWcDNriVk6uTeHHS6gfHASUIGPQjI4rdXuYSr1Y4Y
X-Gm-Gg: ASbGncv4z77+pCkMVa3tqmNEk1V+JZ2agSDKf315d1HxPew3MU7uDQ5Op8yTl9U8RPB
 WzN8Qv9r31WAkCmt0IGIt9Q0xUlmnbxOmLSyZ0NnhMaaBt0QzvH0Mc6koBUaEMLJzoe6c124QVb
 e/O26ACMGNamfJObJRxQ2WWnpEUyyRgHGfnwQuEd7yg/KWfZxNYPUxcMOCd0S47FkuOzoQXGgHo
 ejygjRLGxsiDyVS/AGmD5s0JlFvI6HXcXShlJYQ
X-Google-Smtp-Source: AGHT+IH9LekyU5bM/W1FrWI/vh9YPJiyUJx6MqSg3X+cMHVXCIEFPXIUtfMAkwt1COOhu+2BRA5Hp/cbdaTJn8oScKQ=
X-Received: by 2002:a05:6402:278b:b0:639:e11d:6529 with SMTP id
 4fb4d7f45d1cf-639e11d6e8cmr2473635a12.5.1759942627894; Wed, 08 Oct 2025
 09:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-7-sjg@chromium.org>
 <20251007175849.GN298503@bill-the-cat>
 <CAFLszTjEDa-YueKQu7i5E7C=qP15HnEhLour0xynvws7P76SZg@mail.gmail.com>
 <20251008153221.GY298503@bill-the-cat>
In-Reply-To: <20251008153221.GY298503@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Oct 2025 10:56:53 -0600
X-Gm-Features: AS18NWCLnJujJRKGuUl157o_zYcbvx4RaJLm9GEke4epiTjUUCMwg35zrqcyS78
Message-ID: <CAFLszTiMys9ArN8b0u-8wzYdAS2yQcbSAV0-kCUjQ42L=rO+xA@mail.gmail.com>
Subject: Re: [PATCH v2 06/17] boot: Add a new test for global bootmeths
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

On Wed, 8 Oct 2025 at 09:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 08, 2025 at 06:54:21AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 7 Oct 2025 at 11:58, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Oct 01, 2025 at 03:26:31PM -0600, Simon Glass wrote:
> > >
> > > > These have different behaviour from normal bootmeths and we are about to
> > > > enhance it. So add a test and also an extra check in bootflow_iter()
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > [snip]
> > > > @@ -388,6 +390,49 @@ static int bootflow_iter(struct unit_test_state *uts)
> > > >  BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
> > > >
> > > >  #if defined(CONFIG_SANDBOX) && defined(CONFIG_BOOTMETH_GLOBAL)
> > > > +
> > > > +/* Check iterating through available bootflows to test global bootmeths */
> > > > +static int bootflow_iter_glob(struct unit_test_state *uts)
> > > > +{
> > > > +     struct bootflow_iter iter;
> > > > +     struct bootflow bflow;
> > > > +
> > > > +     bootstd_clear_glob();
> > > > +
> > > > +     /* we should get the global bootmeth initially */
> > > > +     ut_asserteq(-EINVAL,
> > > > +                 bootflow_scan_first(NULL, NULL, &iter, BOOTFLOWIF_ALL |
> > > > +                                     BOOTFLOWIF_SHOW, &bflow));
> > > > +     bootflow_show(0, &bflow, true);
> > >
> > > Here is the one call of bootflow_show outside of where show_bootflow is
> > > called today, and bootflow_show is called by the end of this series.
> > >
> > > > +     ut_asserteq(3, iter.num_methods);
> > > > +     ut_assert(iter.doing_global);
> > > > +     ut_asserteq(2, iter.first_glob_method);
> > > > +
> > > > +     ut_asserteq(2, iter.cur_method);
> > > > +     ut_asserteq(0, iter.part);
> > > > +     ut_asserteq(0, iter.max_part);
> > > > +     ut_asserteq_str("firmware0", iter.method->name);
> > > > +     ut_asserteq(0, bflow.err);
> > > > +     bootflow_free(&bflow);
> > > > +
> > > > +     /* next we should get the first non-global bootmeth */
> > > > +     ut_asserteq(-EPROTONOSUPPORT, bootflow_scan_next(&iter, &bflow));
> > > > +
> > > > +     /* at this point the global bootmeths are stranded above num_methods */
> > > > +     ut_asserteq(2, iter.num_methods);
> > > > +     ut_asserteq(2, iter.first_glob_method);
> > > > +     ut_assert(!iter.doing_global);
> > > > +
> > > > +     ut_asserteq(0, iter.cur_method);
> > > > +     ut_asserteq(0, iter.part);
> > > > +     ut_asserteq(0, iter.max_part);
> > > > +     ut_asserteq_str("extlinux", iter.method->name);
> > > > +     ut_asserteq(0, bflow.err);
> > >
> > > Nothing in the rest of this test is checking the output of strings, and
> > > nor should it since the test is checking the struct itself to be as
> > > expected. Am I missing something? If not, I don't think we should bother
> > > with the previous patch.
> >
> > You're missing that when the test fails you need to try to figure out
> > why...it is much easier to do that if it prints out info on the
> > bootflow. In my case it was printing a completely different one.
>
> I want to come back to this for a moment, because (along with a few
> other parts of this series) it shows the hard question of:
>
> - After debugging a problem, how much logging / debug statements should
>   remain?
>
> More comments are always good. There's no size cost, there's no run time
> cost and it helps everyone who comes along later understand the code
> better.
>
> Given that CONFIG_LOG isn't usually enabled, on the one hand log_debug
> should be fine as that should be compile-time optimized out. On the
> other hand, is that information that we should have available already?
> Do we need a debug statement about returning -EFOO vs the caller(s)
> printing "got %d as ret" ?
>
> And then it's also a question of "will anyone use this again? Is the
> churn to git blame for adding '{' here worth it?"
>
> I often lean towards the last question being answered with "No" and so
> just making sure comments are correct. That also means not keeping in
> things like show_bootflow being a public function now even if I had
> exposed it as a quick "what does this number mean again?".

The best initial debugging aid I have with bootstd etc. is to enable
CONFIG_LOG_ERROR_RETURN since it shows a trace of where things
happened. It doesn't have a code cost unless it is enabled.

For myself, I do like adding things like show_bootflow() in tests. It
is so much easier to understand what is going wrong when you can pass
-v and see the test output.

Regards,
Simon
