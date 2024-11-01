Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC93E6F06C
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2C0088E14;
	Fri,  1 Nov 2024 16:37:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aE8sZ1Te";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92C3688DF5; Fri,  1 Nov 2024 16:37:34 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A42AA88E14
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:37:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9aa8895facso325691866b.2
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730475452; x=1731080252; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JB9RFNqJljcjSQyHgstgjHwzrwrbu6TDhh/Wb/4ehlw=;
 b=aE8sZ1Tew0FK7qJE4mr/YyVnqvPXbFV/oUEfs1juHWvkXxq9NZ4ppuGbFd3ADvzX0M
 KQBEgrSbYjDfM0Z/GoKV8ulVasitk+r7oPv3at3wL/Cd10hVBGHF8rhj4szXxxEVaymG
 UetT6lcTxIuQpyLGBdeohXdxY953bVBYoa2Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730475452; x=1731080252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JB9RFNqJljcjSQyHgstgjHwzrwrbu6TDhh/Wb/4ehlw=;
 b=CO8AlJ57h37I+kJkj4ZFGVB/2tmGpFKiWhpqFkzXU1nvPJ6T2lMQxgh63ZmGSGClWE
 zF+WWgT3E4By+kI5A6A324GRqEyiKRfzofrisZt+q4nOCvtZ8zjbWKuKG5g++XZeY5mV
 VV73t9imOTNm3zttds4QJcRwQEvMIQsX2dxBVSUQ3ZAf3QQqsHVSUeRF7GaJznGIi01s
 qJZbIrHKpJ3/TQq7h2wPcM5vs5bPifDD1oUOq2ERB7IsyhB3rZLNtN11isyHO6BvK/Ql
 pemzwGb/y6PAZRX10PRv1x43hQ8ht+ZrcqwTJ5GUA4rBIqf+8CJLTnj/1+H+xJ9wlez8
 tm2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCtd75dj9u5vmdpHAOb3jMTpxzdHdM/4QMbLlZALb8A+NpYDc9ph4znyjvoE4utFEhR3hcFkg=@lists.denx.de
X-Gm-Message-State: AOJu0Yzho+2uqv7CdF6TJCcDJ/Wd7cD2hz/zT+kkZx8Jv/5tCvxDtYCZ
 Mawgk+65AVaA2ucyjhCC5MWuPFqk5GlkNvG/fc53skEtmFHAVFuP/Z+2B4lTneCyma27ppL9Zn3
 pmHO8GJ7dHnLhan8O1ZXXDvtzzarlvKjAIv4G
X-Google-Smtp-Source: AGHT+IHXwur5QKCFfkCjAnw3QbPrVm7FcIKP2JESUZPB5cFS+PIHOtTeREMU9M752pc8Sk7cAoi4bTHWKoU36BjMx+c=
X-Received: by 2002:a17:907:1b92:b0:a9e:45e6:42cb with SMTP id
 a640c23a62f3a-a9e45e69b52mr592550166b.18.1730475452082; Fri, 01 Nov 2024
 08:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241026120252.865215-1-sjg@chromium.org>
 <20241026223346.GI4959@bill-the-cat>
 <CAFLszTg-Lr3uWu41YX1z=JTbBbiT8Gh2oydLHpq5dtyZbRUtKg@mail.gmail.com>
 <82825184-692b-4245-8935-57d87f84692a@linaro.org>
In-Reply-To: <82825184-692b-4245-8935-57d87f84692a@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Nov 2024 16:37:17 +0100
Message-ID: <CAFLszTijo+=OuCXBKfDKKyL=LajNzZosovfqRLGc92B1AccLkw@mail.gmail.com>
Subject: Re: [PATCH v2] sandbox: Add a build without CMDLINE
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
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

Hi Caleb, Tom,

On Mon, 28 Oct 2024 at 22:54, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 27/10/2024 15:52, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sun, 27 Oct 2024 at 00:33, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Sat, Oct 26, 2024 at 02:02:49PM +0200, Simon Glass wrote:
> >>
> >>> Something this breaks, so add a build to keep it working. Since sandbox
> >>> enables a lot of options, it is a good board to use. The new config is
> >>> created simply by copying the existing sandbox and turning off CMDLINE
> >>>
> >>> Once we have tests for non-CMDLINE operation, this can be adjusted to
> >>> run those tests.
> >>>
> >>> Create a new build which will be picked up by CI. Update the maintainer
> >>> entry as well.
> >>>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> ---
> >>>
> >>> Changes in v2:
> >>> - Create a new build instead of messing with CI
> >>>
> >>>  MAINTAINERS                         |   1 +
> >>>  configs/sandbox_nocmdline_defconfig | 365 ++++++++++++++++++++++++++++
> >>>  2 files changed, 366 insertions(+)
> >>>  create mode 100644 configs/sandbox_nocmdline_defconfig
> >>
> >> Please use the #include mechanism instead of a full config that will
> >> also now have to be kept in sync.
> >
> > Hmmm we still haven't come up with a way to deal with the #include
> > mechanism in buildman. I've forgotten where it got to, or even what
> > the problem was?
>
> qcm6490_defconfig needs to re-define CONFIG_ARM=y for buildman to be happy.
>
> Why is buildman looking at the defconfig anyway? Maybe it could just run
> the pre-processor first?

It could, but I really want buildman to understand things. If we can
say that '#include' in the file is the only thing it needs to deal
with, then I believe we can update Kconfiglib to deal with it, or
perhaps preprocess the file. That uncertainty (as to what the 'spec'
actually is) is what has held me back from looking at it too
seriously.

Regards,
Simon
