Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F42D73606
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 16:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7287C89645;
	Sat, 30 Nov 2024 17:23:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="brYBOmT3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0626D8964B; Sat, 30 Nov 2024 17:23:53 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7392E89642
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 17:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa53a971480so413071666b.1
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 08:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732983830; x=1733588630; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p5p5r1QxiZzG9FhQTzFwbGgh/19FbmBIrNGfIQfDpHk=;
 b=brYBOmT31hzTU+VXmqFL/BMTJvYO7mwCfb2NJ3AyGb2cq7hMNiiWs/JgaeexUGMU6c
 F7f/9NAfvlixes2O2xQyaR2ObajQCtHin+aFp6tLGHFOtJNO+Lp05xHiIIYLA5JTce8o
 2z5tB6KUGwEQLdvWrhQZyyzm9dGhxPVZ4rb2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732983830; x=1733588630;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p5p5r1QxiZzG9FhQTzFwbGgh/19FbmBIrNGfIQfDpHk=;
 b=vZOf0HW6VnAijtflv9ljABfYX6l4xNSweL5KaHYPjAq5CUZJduSE4RnkMnAk/M5gJZ
 TF7yVErjWOf7IRIIdhgeX5SB/Q8ybM5fmj4ghN7XxhRAaFQqyhnO9aWo+ZA0ZMibverP
 zB7siVrCZ4O96LvJP6Iud3CAmdSE77cl13kOfR2WM4naQRbsYiwtkUJYX4q7PrkAXmbU
 k8UFIK6bimUxNvsLJBvR/zApbqrPh0J4Qa2nZZcSzQFDoIqZPijVrkGAKr18aHOLqyNI
 LRaDXahXgSRtRk1IfpYhw4MpSbgnYHDA15hinGNCuWOaBhVIoLeua1U/mZQtdfEaGMey
 6i4g==
X-Gm-Message-State: AOJu0YwYd83+shcXUC3FyJ1c97rjjtDy/IsH/yeomNd1ztEk7CBvbY5t
 gch10JPLpcGD5EQLcTzJBmr8jO7+XYHv7W6b2lRcCXLcOluz5vDVylPERo6Fcfezcj0Ku7SLKtZ
 gCotn61yvlDp+Z8nw1Pm2zig94YklMGSBdlF2
X-Gm-Gg: ASbGncv+ZIRQIh+gb5afrs5Hq8kqq0JeoFA+UDEtks8v1aZC87LQhMZmhuqQR4WZ3Pz
 ckSnm+386yDYlKF+As7JbA4m5eU2EbY0=
X-Google-Smtp-Source: AGHT+IGnAsU1fhFwXOZxfvCkwalZFU4hE/HHOuWAcI/0TrwPPjKBQ+IEX0mi+OKmUudfLYLdNbos4LMieiOJ7G4cDRs=
X-Received: by 2002:a17:907:7713:b0:aa5:cec:d504 with SMTP id
 a640c23a62f3a-aa580f57d8dmr1453206566b.30.1732983829615; Sat, 30 Nov 2024
 08:23:49 -0800 (PST)
MIME-Version: 1.0
References: <20241128160011.780550-1-sjg@chromium.org>
 <20241128170148.GF3600562@bill-the-cat>
In-Reply-To: <20241128170148.GF3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 30 Nov 2024 09:23:38 -0700
Message-ID: <CAFLszTiBVSesnU456t0rko6W_vEy+BtR-zQfhuoVs-Q1pHC1uQ@mail.gmail.com>
Subject: Re: [PATCH] CI: Add gitlab tags to builds which can use all CPUs
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
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

On Thu, 28 Nov 2024 at 10:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Nov 28, 2024 at 09:00:10AM -0700, Simon Glass wrote:
>
> > Most gitlab runners are mostly idle at present and could happily run
> > several jobs at once.
> >
> > There are a few exceptions, such as the world builds.
> >
> > Add a 'single' tag for the exceptions so that they are dealt with
> > separately, with no concurrency. This is not quite perfect, since it
> > means that a 'single' job can be combined with a number of normal jobs,
> > but in practice this doesn't seem to matter.
> >
> > To use this, for each existing machine, add a new, separate runner, with
> > the tag 'single'. Set 'limit = 1' in its config.toml file and set
> > 'concurrent = 10' (for example) in the global section. The machine will
> > then pick up one 'single' job and up to 9 other jobs at once.
> >
> > In my testing this reduces the time to complete a CI pipeline.
> >
> > My choice of which jobs to mark as single is mostly down to how much CPU
> > they need. For the 'docs' job, it runs for a short time, so doesn't seem
> > worth marking it as a 'single' job.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> This is an interesting approach. What will work better long term is
> adding more runners with the "all" tag because as part of the rework of
> the Gitlab job I've done and you can see here:
> https://source.denx.de/u-boot/u-boot/-/pipelines/23588
> (but isn't ready to post as Ilias wants to look in to the sandbox+arm64
> issue) means that every runner needs some tags and for runners which can
> handle multiple "small" jobs at once (as the first two stages are
> building a board and then testing, or similar) we can make use of that,
> and then restrict the world builds to the fastest nodes only.
> This also means that things like the Oracle "always free" tier cloud
> instances could be used for example as an "all" jobs node, I suspect.
> And the same for any other cloud provider with an equivalent tier.

For reference I had this idea a year ago [1] and it didn't go anywhere
at the time.

For me this patch reduces the CI time to 35mins best case. So I'm
going to pick up this patch for the ci tree. Once you have patches for
your approach (which seems better to me as well), we can go with that.

Regards,
Simon

[1] CAHFG_=USRrEytULOdnezrCmeAcV_KGO7M=ieWCoi1mCzHwmHRQ@mail.gmail.com/
https://lore.kernel.org/u-boot/CAPnjgZ0Gj==Q-YOU+EoD=s3h25Waw5EYa0DEOD_comoAy_bRMw@mail.gmail.com/
