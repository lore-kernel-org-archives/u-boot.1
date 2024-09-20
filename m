Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7466CCF9C59
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9049588C2E;
	Fri, 20 Sep 2024 18:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G/s9VQLs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9BAE88CB8; Fri, 20 Sep 2024 18:01:37 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0560888C45
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:01:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6c3552ce7faso17987126d6.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726848093; x=1727452893; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JHDPy/Uyh1BNJqiIi30GAaSZfYlzB+dOUzAzsyXg2jc=;
 b=G/s9VQLsHyYheWMfcnp5ylpbme2rhn0kskEk1rOLksiYAyw+DyGYREzSEHCIADfL3n
 HbKnaQO56r49oxLQjj21LylgjkseEb9mgE29GQHXMTr50WujNjzELmxRaiK3nwPGFzPT
 4Gy/cfqNVX5p2uuXDR3nzuNDmsDCVEYes+piU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726848093; x=1727452893;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JHDPy/Uyh1BNJqiIi30GAaSZfYlzB+dOUzAzsyXg2jc=;
 b=SDzhbkyuoj1xZlQzczk+DoBIlC8rG7Obwi8ZzqvsOM+omrToYAVI73jfwwwJWwqQaI
 xet9Ta06H2uWrN0mfc/hR0xYGsd8sXq12lZ5y1crJIUrISys1FP/tdPp0RfvsG+Q2QKx
 PR3PI+zhqEhkI6GIwA4UDTCHJRi6bed1OSsXq0FzLfz1hSmFtlZgOB1Yut/ABTKZ/J9M
 8dSAg6d+e9rMpVN+IyXb5xtJ3d2htMY73Cs3/Yeop13OCtqUmKGPLEY+/XnNW02hTmIw
 EI6VKNpbjUpIx6s5mKKywp1etQ4lYm5DvgYTND3iKrIsjbsqwRzeTVF7Hyie769ki92j
 IiIg==
X-Gm-Message-State: AOJu0YzUQl1pdjqOgxsMgJ7GgLLwCv3G2pESi7yqnNpbByJT/Piz/CGG
 sNWAvtFwtD5sgSnjmksx3H4VTAqbVMNaFW7L+us/iC8QA0fg/nD6XkQrBa+OUQyI+E5PMofEOuH
 gPnUobW/se9PZ/Pl66Av59F7LWRQLDVwwxMYDYOFsUAvPNKlugpJp
X-Google-Smtp-Source: AGHT+IEIJ8i64o7FcBTx4+JclKfTX28PxJ5cagT2qTKwV+ZhVwupabMZKcTv7PZPbYanLdgMOPdyIuEusQTrkKOkDSQ=
X-Received: by 2002:a05:6214:3a0a:b0:6c7:89b1:450a with SMTP id
 6a1803df08f44-6c7bbbfd20emr76744126d6.17.1726848092767; Fri, 20 Sep 2024
 09:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-8-sjg@chromium.org>
 <94949f6b-9f82-452c-9d38-5c8683a21ddd@cherry.de>
 <CAFLszThRvPSiZrsQEzbMS+Lg=sB1jijEMj9F=cG3h0MQH76t5A@mail.gmail.com>
 <2c9402fa-17c1-45a6-8823-d18d1ffe128b@cherry.de>
In-Reply-To: <2c9402fa-17c1-45a6-8823-d18d1ffe128b@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 18:01:22 +0200
Message-ID: <CAFLszThz6uDFZUx26V=_0c4r=-28vhP57xdvujwuNozwDM0eHA@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] log: Avoid including function names by default
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Quentin,

On Mon, 12 Aug 2024 at 10:56, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 8/11/24 4:50 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Tue, 6 Aug 2024 at 08:16, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 7/21/24 5:25 PM, Simon Glass wrote:
> >>> Unless function names are requested, the logging system should not
> >>> compile these into the code. Adjust the macros to handle this.
> >>>
> >>> This means that turning on function names at runtime won't work unless
> >>> CONFIG_LOGF_FUNC is enabled. We could perhaps split this into a
> >>> separate option if that is a problem.
> >>>
> >>> Enable CONFIG_LOGF_FUNC logging for sandbox since the tests expect the
> >>> function names to be included. Fix up the pinmux test which checks a
> >>> logging statement.
> >>>
> >>
> >> I now understand the statement in patches earlier in this series :)
> >>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> ---
> >>>
> >>> Changes in v2:
> >>> - Update commit message to mention the runtime impact
> >>> - Leave assert() alone since it is only compiled in with LOG_DEBUG
> >>>
> >>>    common/log_console.c      |  4 ++--
> >>>    configs/sandbox_defconfig |  1 +
> >>>    include/log.h             | 16 +++++++++++-----
> >>>    test/cmd/pinmux.c         |  8 +++++++-
> >>>    test/log/log_test.c       |  4 ++--
> >>>    5 files changed, 23 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/common/log_console.c b/common/log_console.c
> >>> index c27101b8fe2..9376baad664 100644
> >>> --- a/common/log_console.c
> >>> +++ b/common/log_console.c
> >>> @@ -38,10 +38,10 @@ static int log_console_emit(struct log_device *ldev, struct log_rec *rec)
> >>>                        printf("%d-", rec->line);
> >>>                if (fmt & BIT(LOGF_FUNC)) {
> >>>                        if (CONFIG_IS_ENABLED(USE_TINY_PRINTF)) {
> >>> -                             printf("%s()", rec->func);
> >>> +                             printf("%s()", rec->func ?: "?");
> >>
> >> What about setting _log_func to "?" if LOGF_FUNC isn't set?
> >
> > That would require all call sites to pass a pointer to the string,
> > rather than just NULL. I suspect it would increase code size?
> >
>
> I probably missed something, but log_rec->func doesn't seem to be used
> in many places (common/log_console.c and common/log_syslog.c).
>
> log_console_emit() is only called through log_dispatch() itself only
> called from _log().
>
> _log is called from:
> - cmd/log.c:do_log_rec(), the func parameter is provided by argv[5]
> which I assume cannot be NULL because argc<7 is checked.
> - common/log.c:_log_buffer() which is called by log_buffer()
> - include/log.h:log()/log_buffer() which is modified to swap __func__
> with _log_func (so __func__ or <insert placeholder> which is NULL or "?"
> I suggested there). the rec->func argument cannot be changed from any of
> the caller.
>
> So I assume we would be fine?
>
> As for the size increase, I would hope that the compiler knows it can
> store the same string at only one place and then reuse it instead of
> having it in many places, but I know nothing about compilers so it's
> just me guessing :)

Just a note that I never got back to checking this. Common strings
with the preprocessor end up with a single string in the object file,
or at least they do in my experience. Since the function name is
likely unique within U-Boot, this should be fine, as you say.

Outside a single compilation unit it can be a different story. I
suspect (and hope) that LTO would deal with this OK, but otherwise I'm
really not sure what would happen.

>
> In any case, either is fine by me!

I suspect we may tweak this again, but this patch does resolve the
code-size issue that bugged me.

Regards,
Simon
