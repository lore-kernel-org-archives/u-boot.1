Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1F6E92733
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 16:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A61583E7F;
	Mon, 29 Dec 2025 17:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hh/EPfoR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEC9783E85; Mon, 29 Dec 2025 17:18:23 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 458DB83E21
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 17:18:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-64b61f82b5fso12251031a12.0
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 08:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767025100; x=1767629900; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s3X9xdbmucKB/kXWtMLQ3GW+c0vETVxPvsqQBst+eK8=;
 b=Hh/EPfoRqGuVaI2GaXzlfYuMvVb7vltWGSxbTyDw+wOj0Ddza0ElbWbVlVVdbKCQ6v
 FiicfzjSjF0/1w79HTQ+7BmTUUY3iMkDtH6iINmjf2sUu+ouA1xTBLZ8Xj+GUUHpqLoI
 HgyXwIGlMNLscYHxOIEHRbg7Deri6R/erIdow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767025100; x=1767629900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s3X9xdbmucKB/kXWtMLQ3GW+c0vETVxPvsqQBst+eK8=;
 b=AQZOBPtPdqJLvTbk7F3O27t8Q1qXg7FZsrvubkDYo5SF9uikCsf3icSHH7U0eGomcu
 wxWI/msNDn/MbBJXSUEaPvgpk9IF7mQeXStwr0D3SP+MXU8y7CNfPKMpK51zX0Rou5Va
 +h7ZFB14zc8IbEkrhpY+6s+c+dFbVTEeV9erKorKvtX/i6QKkCznLS5OK47G6604JUeh
 wJi3eyW4O37IdnWWn1AcTpBUQLRQ5laVqzug+2MjyscDc+CcQFaFxkUR9iquS1KNN8LD
 f3Y/fyeokyWTRu8ctM5+P6ad7DtrlSYzhOAEFUTxSrvtDLjJsmTIild9kCpGEvHzxS0T
 QggA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXioYCG1AfQDi99nS/AITIrpxuOoy542zHjpkaMyplqWb41r/1x+BZLTPFlzBoonzs1sqr5dtg=@lists.denx.de
X-Gm-Message-State: AOJu0Ywc6bUdyjlm8lImtqeVhEDJNgR7eoR2DXZBrC/goypTiWlESATz
 uXAFhq4J25LWL9mw3e6w7OU37fa9iBPSjl+Lsz4B4rkSqTd/M7HHan/IW9SG4aFdQ+NZ8ZYkWMt
 zhx0inHBtvrLsYPktbDAf7AcC++LmMPShykxffJPu
X-Gm-Gg: AY/fxX7wYyfueZkicD53SxEajMG3+inC6NxK/CVvJNcpUWye0Yil2rQi2sAWVz/TYm/
 SrXCqFBNj/XGFVQ36vBDyhEG49MWECYhIzrQYhvaU2GPEqSi/dnf8RIA4TETruwNl4EeHXCM+oS
 kVQ4bwHVptcX/Q7jBMo2o7i7AmmHiUCv589ERvfmifY6lEk7cjoIg2YhJ0bJ7ZsU2XIBSQf4Dqt
 Gpn6tyMKC/QGzvHIzgjqqfR/mTBnMJSibzkFCMU7WJYC6DV3wLK21GZpP/XFq/x+0oX7Q==
X-Google-Smtp-Source: AGHT+IGmlh+V7X6RTwim2SkHPFfICZX3o5wmivauabx1S9E1cRPQSPhP4kLD9ze6OXSMD5MaNx7AiLDLfVifbNkwL8I=
X-Received: by 2002:a17:907:3f89:b0:b72:134a:48c8 with SMTP id
 a640c23a62f3a-b8036f63805mr3353366266b.14.1767025100096; Mon, 29 Dec 2025
 08:18:20 -0800 (PST)
MIME-Version: 1.0
References: <20251221015859.738112-1-heinrich.schuchardt@canonical.com>
 <20251221015859.738112-2-heinrich.schuchardt@canonical.com>
 <CAFLszTgiG=NyaVrGAnTJsmkpYc4OOaUo5ebKy=mTrw4Nwc46jw@mail.gmail.com>
 <fc5976c3-0cb1-488c-ad66-1adc5510ea00@canonical.com>
In-Reply-To: <fc5976c3-0cb1-488c-ad66-1adc5510ea00@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Dec 2025 09:18:07 -0700
X-Gm-Features: AQt7F2p_PPgbC2SNQRAjJgig7WfjSMzWD8pfY4PeZhxT9k_ArmLUFM_av5WG8dc
Message-ID: <CAFLszTgqkwe7EbEqovaOpZaxrx7s+p-bJVojshyYvM3GsrT8ew@mail.gmail.com>
Subject: Re: [RFC 1/8] trace: correct handling of recursive call
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Yao Zi <me@ziyao.cc>, 
 Raymond Mao <raymondmaoca@gmail.com>, Sean Edmond <seanedmond@microsoft.com>, 
 Heiko Schocher <hs@nabladev.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Mon, 29 Dec 2025 at 05:27, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 12/27/25 14:45, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Sat, 20 Dec 2025 at 18:59, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> __cyg_profile_func_enter() adds timer information to function traces.
> >>
> >> Commit 852d4dbd70ba ("trace: Detect an infinite loop") introduced a logic
> >> letting any recursive call to __cyg_profile_func_enter() deactivate
> >> tracing.
> >>
> >> This implies that a lot of the DM core and timer drivers functions need to
> >> be marked as `notrace`. This in not desirable as those functions are part
> >> of what we want to trace when not invoked by __cyg_profile_func_enter().
> >>
> >> A better approach than switching of tracing is to immediately leave
> >> __cyg_profile_func_enter() when reentered.
> >>
> >> Reported-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   lib/trace.c | 59 ++++++++++++++++++++++++-----------------------------
> >>   1 file changed, 27 insertions(+), 32 deletions(-)
> >>
> >
> > Please see here:
> >
> > https://docs.u-boot.org/en/latest/develop/trace.html#board-requirements
> >
> > This really just papers over the problem you are having. You cannot
> > use driver model to obtain the timer as tracing starts before that.
> >
> > So please instead do the small extra work of defining timer_get_us()
> > for your board.
>
> Hello Simon,
>
> Thank you for reviewing the series.
>
> Making timer_get_us() driver model independent could alleviate the
> issues that I tried to address with patch 2/8 (trace: initr_trace must
> succeed initr_dm). Yet, the current patch is about handling recursive calls.
>
> I think we should use notrace only on the minimum set of functions that
> are used by tracing only. All functions that may also be used from
> outside of the tracing framework should be instrumented.

Yes I agree with that, so long as we include 'get the current
timestamp' as part of the tracing framework.

>
> This patch addresses how to avoid recursion when instrumented functions
> are called by the instrumentation entry and exit functions. This should
> be handled gracefully instead marking it as a total failure and
> disabling the tracing framework.

Adding a trace record requires a timestamp. Are you saying that you
want to trace (for example) timer_get_us() in the normal case, but
want tracing to be automatically disabled for that function only when
it is called from the entry/exit functions?

To me that seems more reasonable, although I worry it will paper over
problems that people should look at, like having a trace-safe timer.

Regards,
Simon
