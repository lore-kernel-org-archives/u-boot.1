Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75DBCFC279
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 09:32:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 500558901E;
	Tue, 15 Oct 2024 11:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dpXAOF0A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A3D889020; Tue, 15 Oct 2024 11:32:01 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDE2988E36
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 11:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c9625cfe4dso4351193a12.0
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 02:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728984718; x=1729589518; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qClL+uJSLKFnkD8SdgTAsWj3BjXZbwnrL3Q1X7BRi7M=;
 b=dpXAOF0AgsBDr9/rPiY/t+I8hzt4von+cCh8R8Hi6p6hxNXTuM9WIrcCtStTbvq3Kh
 2u6lum+9JP/jQfbbk7U5o05oVHQG8idtrKz2sCKr57hNzU6ZwU9KkpF6t8rUZPvl732p
 iC0LxnAbvocBhzy/O6kL0BYj4Mg4iyRn9DGTaWMSbU77FPRK72DpZSAWCi4v0KJpaXun
 5bE0F9uGk03iDtSwPuZzyXaoygsyG36D4LlD4nrPvIL+HaBwNBr+L0aDFVD9Pg3liZCs
 /n/XiHKuksT3SQWBS8kQn1mC+MCTYG7oTt1IQntf1G3BDL3mv9zWXz7NCKIVEAI8E/Z8
 Ls1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728984718; x=1729589518;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qClL+uJSLKFnkD8SdgTAsWj3BjXZbwnrL3Q1X7BRi7M=;
 b=izLNX1huhC6z3Z2lgNiEiL0pBxvVcF0qDeDoP9dM8z5JrKVUB3rFlYzpvNNyKJwJWX
 sRdtxz9ulT9sOgF6WQecgwb9jYbjOfoiOpnGbFkaZfcxpp3iUW/eK9TYBjlTCBzfmnEf
 LVh2qlVD7yOUIlI/PXFPHk2fay+g5r98sGla5a4oKlhb/U4VLpb7MqwDv1vMAcTWkFH+
 anNs8/txSZU0LXyo+BsdTmYm7IC6F2g9bq6LJIVMe84FNY5konZRkVt2BsShrmHIDE3y
 EQfPrOfJ2g0Bm+7vD1r80RwWAosU8iki4g0Yxng/AtBjQuj0n0A7bhLYZqVjx9QvCtjT
 8MwA==
X-Gm-Message-State: AOJu0YxIQPzNq2r3r1CSpcuGHNyeDnEHng2PfUicrMWXL3HjFxXzM32/
 1SQC4KbfwXCrNC9bTvgShvTWBRSc9Kvv2SZXupIMoVGenhycAbZiw58Ulq32b4H7ce7un+mXj1I
 H5btA3dg2pWPCu8BrCwrkQdoP/uTmpByDjRYlWQ==
X-Google-Smtp-Source: AGHT+IGqg0z0A7jhuAaNXuCsLv4O3/0zYkmRc/3rJ0PrawUWh9d9js0WrgzLkbG8HaFrEBOwEevKnUlZR5AlBulmnEA=
X-Received: by 2002:a05:6402:2811:b0:5c9:76f3:7d46 with SMTP id
 4fb4d7f45d1cf-5c976f38053mr5437830a12.21.1728984718300; Tue, 15 Oct 2024
 02:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-11-sughosh.ganu@linaro.org>
 <CAFLszThkoMSEgxnHQQBYEswbHcFHuDWn0RiJOCN6jV7g=Y+9Qg@mail.gmail.com>
In-Reply-To: <CAFLszThkoMSEgxnHQQBYEswbHcFHuDWn0RiJOCN6jV7g=Y+9Qg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 15 Oct 2024 15:01:47 +0530
Message-ID: <CADg8p95iXsJP=oEuxwfzLm1oLDoJMfTfGH4pw1TV-rRF7vVLJw@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] lmb: allow for boards to specify memory map
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

On Mon, 14 Oct 2024 at 21:21, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Sun, 13 Oct 2024 at 04:56, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > Some architectures have special or unique aspects which need
> > consideration when adding memory ranges to the list of available
> > memory map. Enable this config in such scenarios which allow
> > architectures and boards to define their own memory map.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V2: None
> >
> >  include/lmb.h |  2 ++
> >  lib/Kconfig   | 18 ++++++++++++++++++
> >  lib/lmb.c     |  3 +++
> >  3 files changed, 23 insertions(+)
>
> Since this is in addition to the existing LMB (which protects U-Boot's
> memory-region) I suggest emitting an event in initr_lmb() to add
> things to the LMB.

But I thought this approach had been agreed upon by you. I had shared
a branch with you earlier [1] which had this commit for your feedback,
and you got back saying that this approach is fine with you [2].

-sughosh

[1] - https://lists.denx.de/pipermail/u-boot/2024-August/562690.html
[2] - https://lists.denx.de/pipermail/u-boot/2024-August/563498.html

>
> But for SPL, this doesn't work, since we are trying not to add events
> for SPL. Perhaps I will discover this further on in this series, but
> which boards need to do something special in SPL?
>
> Regards,
> SImon
