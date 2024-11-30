Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE60D7360B
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 16:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 093D589665;
	Sat, 30 Nov 2024 17:24:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kTLMOEfY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 402ED8965E; Sat, 30 Nov 2024 17:24:29 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 192D4898AB
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 17:24:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa52bb7beceso313097366b.3
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 08:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732983864; x=1733588664; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4lAl0l9BnBzcGcc0rid0dZSYEDLOaPZ7GCy7bxPrVy8=;
 b=kTLMOEfYxLdGbLygsGRA1+5HSekPxlm0LizyM8HCvq5ZgsF93dRyyx11h7/Clg6+W/
 m14NvQiamVV0UlaCg8S4QTRb6vPaXfye9gNNpMYVfeMeigvMDt4tWiEq7G9U1YBsc+Bx
 a3zZ+h/9JA83XmzqnN7rpY67jc74PxL26lRI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732983864; x=1733588664;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4lAl0l9BnBzcGcc0rid0dZSYEDLOaPZ7GCy7bxPrVy8=;
 b=XUqo6NnLu5kXwL1vTvz0MrrAbt3pAvyE9ZxmvwEpfPTy7Iubqy+h+5AwUfazQZ0nLp
 eGBLMdZ+i+bl+SHFaNqNwSKuzCluHjQsaSWl80z160SmSxO1vP5Dohl7X0zXUy9xaci0
 Omqk5c9AVRBV78u7V4QYl+rVBeCJUqgJslYcRJ0MIpj+QWIz/Mx3adso/hfoOSI0Pm4B
 MSKBPcmk1Kv+4AbPPngE0C40ER6nVIQ3ZWUwyiGHCNScJRjdQTXion3A7WwK4WJ5Pcw8
 MZhXEXLlYgGE4CblqdINhOA/xDi593mPWunoAdXdLH9pGn9ufm/Yx/vAXjS50QA+GMGX
 7OWw==
X-Gm-Message-State: AOJu0Yy3IodNjZkui6A3F1LQBsCF/EPN6p1tkxSde5gy2G8I7fzwTzWb
 ORtkpaaG9f5uK77l9U1wMV9BV+MXoTmVlvs8vxD/TdSY/UEoH6FfaYCNJkD0t6Ip3mAx+X28BS8
 kcjrYhMwJUZBPURQniOweap7Ije/H+L9QIsRX
X-Gm-Gg: ASbGncvwIjOMyQoiT4EY7bfLx8ENmMWnolzIEANNLj+59vw1Y1eawgN2Zbqrj0VMuWg
 8muRKngibv6/yYJpUfuV7EIjrhxGGWb0=
X-Google-Smtp-Source: AGHT+IF2i4hDsvicX2oqBFSrxZgI+4sG1qzC9IujOGR5jCDWnND14wpeZsR8V5hjK+zYu5Uko+ikXPiYUU+REeD6V70=
X-Received: by 2002:a17:907:6d19:b0:a99:eb94:3e37 with SMTP id
 a640c23a62f3a-aa5810634f8mr1693252966b.58.1732983864432; Sat, 30 Nov 2024
 08:24:24 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 30 Nov 2024 08:24:23 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTiBVSesnU456t0rko6W_vEy+BtR-zQfhuoVs-Q1pHC1uQ@mail.gmail.com>
References: <CAFLszTiBVSesnU456t0rko6W_vEy+BtR-zQfhuoVs-Q1pHC1uQ@mail.gmail.com>
 <20241128160011.780550-1-sjg@chromium.org>
 <20241128170148.GF3600562@bill-the-cat>
Date: Sat, 30 Nov 2024 08:24:23 -0800
X-Google-Sender-Auth: pD9B88yPK3Ag4fHLZ-CgMkugr74
Message-ID: <CAFLszTgPhq6vQQ_gZ6MAjA_jn0vxBGUx-tZmAE+KEN+rH+3Cgg@mail.gmail.com>
Subject: Re: [PATCH] CI: Add gitlab tags to builds which can use all CPUs
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
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

Applied to ci, thanks!
