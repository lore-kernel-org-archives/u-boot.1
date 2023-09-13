Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FA9EE01FD
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 18:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09D7E86A69;
	Wed, 13 Sep 2023 20:07:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y5rPgph+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3533D86A1D; Wed, 13 Sep 2023 20:07:35 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 364CB86A40
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 20:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-501ce655fcbso91777e87.2
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 11:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694628451; x=1695233251; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r3ozensYymgx1FFD+6wMYx2H4HzCD5SdvaF5IpxvnbA=;
 b=Y5rPgph+oNr+37c2TZZoDxCTYpSBCi4m40pKygwW3MmGjtcxZeDpjHV91ve1ciGGvh
 XtUIjZsswyLY9Pkf4O5wataqt26XO2pIQytywzhbl7IOLl3d1NHdM0DZMErvQS6UDx51
 qyaR2YuEyXSKCdynB6+9Rbf2iMo55G+VukOEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694628451; x=1695233251;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r3ozensYymgx1FFD+6wMYx2H4HzCD5SdvaF5IpxvnbA=;
 b=rB650mtvQSPnrssIkcRQIfsrZJ0hyqiLlOIZQxKsgJNRX+a5ynlflmG7CL6//pEWye
 GF8PFXCaxQnL3sdgeHoH2JY5il5P2zXIb6x16WNp+agpftLSqSMcny1Pk3JP3rEt5qt2
 X9sFWQyFHnviNbljpVkLKggYdL0jBc+ITyLzOVB8vl6iJzQl7D3TgRykbHhTTB31XI2B
 Bd0WV3QF102DD0jG8hpUjZJbOvQAPrwSzYskZETc9bT0Nx4+ENNIhsrXn/iFUeqkliJu
 dBzXdl1znnGGZkRLORdbCF1b+1nUXMgZ3c38KixW/UDQkok6isMOg2Aa8ewUovsR0Cw3
 MgTg==
X-Gm-Message-State: AOJu0YyWSRM19EJ0VxUl8IPtAKybzFkpyJ/wP773obdUTD2zDioHsbLM
 ITWmmEHTR2LqaGXqEFVh0ZhgUKwixXUnS1rOpVEf0A==
X-Google-Smtp-Source: AGHT+IEfrnzvkePJVugSk/mcnoxuTfnfebbykZh2D0wM+XpvS2TPIATY+Ltl/Aq8IhvWAaZCWcuDW9EUaY0coD0JRZk=
X-Received: by 2002:a19:ca0b:0:b0:502:d85b:5de with SMTP id
 a11-20020a19ca0b000000b00502d85b05demr2207528lfg.68.1694628451055; Wed, 13
 Sep 2023 11:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230908120002.29851-1-sughosh.ganu@linaro.org>
 <20230908120002.29851-4-sughosh.ganu@linaro.org>
 <CAPnjgZ3Zi3hmQg7d5+0461hRK+5O_V89PY=QxMwQarhhqUW6VQ@mail.gmail.com>
 <CADg8p97cQJYogd_MZT_hCH71XjqkO85VEay2fb7hZx1YwX+OPA@mail.gmail.com>
In-Reply-To: <CADg8p97cQJYogd_MZT_hCH71XjqkO85VEay2fb7hZx1YwX+OPA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Sep 2023 12:07:14 -0600
Message-ID: <CAPnjgZ1EBJJ7ZtHZVo1vp24gCrN-A-m4Hk3udLbKPS18C3QNqw@mail.gmail.com>
Subject: Re: [PATCH 3/8] binman: capsule: Generate capsules through config file
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Tom Rini <trini@konsulko.com>,
 Malte Schmidt <malte.schmidt-oss@weidmueller.com>
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

Hi Sughosh,

On Mon, 11 Sept 2023 at 08:13, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> hi Simon,
>
> On Mon, 11 Sept 2023 at 00:44, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Fri, 8 Sept 2023 at 06:00, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > Add support in binman for generating capsules by reading the capsule
> > > parameters through a config file. Also add a test case in binman for
> > > this mode of capsule generation.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > >
> > >  tools/binman/entries.rst                   | 35 ++++++++++++
> > >  tools/binman/etype/efi_capsule_cfg_file.py | 66 ++++++++++++++++++++++
> > >  tools/binman/ftest.py                      | 29 ++++++++++
> > >  tools/binman/test/319_capsule_cfg.dts      | 15 +++++
> > >  4 files changed, 145 insertions(+)
> > >  create mode 100644 tools/binman/etype/efi_capsule_cfg_file.py
> > >  create mode 100644 tools/binman/test/319_capsule_cfg.dts
> >
> > I think we discussed this some time ago. The problem I have with this
> > is that it adds another way of specifying the image description,
> > separate from the binman definition. This introduces all sorts of
> > problems:
> >
> > - the question of where the filenames are located, something which
> > binman tries to handle cohesively
> > - binman has no knowledge of what is being put in the capsules
> > - the resulting fdtmap lacks any information about what is in the capsules
> > - it seems to create two ways of doing the same thing
> >
> > Binman can presumably already create multiple capsule files, just by
> > adding to the description.
> >
> > What need does this feature meet?
>
> We already had this discussion earlier about the need for generating
> capsules through the config file, where I had explained the need for
> this [1]. This is functionality which is supported by the
> specification, and we have folks who are interested in having the
> capsules generated through config file, and also in generation of a
> single capsule file consisting of multiple input payloads.
>
> I understand that this model does not fit with the usual way in binman
> of generating an output image by specifying it's inputs as DT nodes.
> But just because this does not fit or align with the design of the
> tool does not mean that we do not add support for the functionality.
> Why can't we support this in binman as long as it is properly
> documented as to what is being done. Moreover, my initial versions of
> this patchset were attempting to achieve this by adding a make target,
> but you had shot it down [2]. So it either has to be done through
> binman, or through a make target.

We have a lot of balls in the air right now...I would like to pause
this one until we get the other things sorted out:

- simple capsule update in sandbox (see my other email)
- example of how to use all this on a real board (Tom is going to make
a proposal there)
- tidy up the testing so that it is easier to understand and fits
better with the test framework
- figure out the DT story, since we are still struggling to align
there (Binman bindings, removing nodes, etc)

We don't need to get all those done, but we do need to at least agree
on the direction.

Regards,
Simon


>
> -sughosh
>
> [1] - https://lists.denx.de/pipermail/u-boot/2023-July/524849.html
> [2] - https://lists.denx.de/pipermail/u-boot/2023-June/521103.html
