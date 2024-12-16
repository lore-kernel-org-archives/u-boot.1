Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A56E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 14:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6160D80104;
	Mon, 16 Dec 2024 15:52:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UpysHc8m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34E1580141; Mon, 16 Dec 2024 15:52:29 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 142488003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 15:52:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ef8c012913so2979658a91.3
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 06:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734360744; x=1734965544; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hLs0qBLRlJiew40bKYdWJ6tzY7LZh+UTo0urAY1fdHM=;
 b=UpysHc8mgpVknowl2leBNMs76pNBiotMPjZ9ZLLnQAmfbG14OyA88fYIWdVyqnUpP6
 01e6Bs4UK541CXGUFRn7/eaTGIEQsFk/ntmayp8MbhDGGu/R12/tpKEk3Akm0tukyV7c
 Zv7yDvp8JoPjJXulBPMpfiQWodYDttX8FfwLYIvINk29ap7J8z0kNeSSVKQizInCQQaZ
 /9R14o77LIEoJ8bOTJtkNZVD8tOV/DLk3BS6WFZXaQo27K3EYx1I4FoZFEoAMEItf+UD
 kpQZuPG0qzjdUhLaiSpfGE+pr67VYaOZdWTX12YL95Gqjve0isuAmLq0ClJBF4aXeS87
 7FdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734360744; x=1734965544;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hLs0qBLRlJiew40bKYdWJ6tzY7LZh+UTo0urAY1fdHM=;
 b=i2/g5uP59o++QPqtkFMda/f6V8wuykmM7E3mkWeXDXBvY4250MNY/7JB5MSVuq3f9S
 VLxXWuHFu+uaB64R9JjHXkA+aIJT7v0G4kr6euKDErCxYe8yryxSOHru7BF45Yeo28kE
 ohBthVdf2lkvSifwjtML5rosZWUkSdhqZzpzNyfQktmCv7TXSXnjCjwB1sakvdbG/dNu
 wXoz64FDkcdjNBBqxSOR6Z0Gt7Xs0dyyBwta1WM+hIVQtxpQ10KHs94x3qEaqkjer199
 ooPAULCNFlfs68NMfiMVNktgt5OoCmd2zNHZJR5LskBEHjjzcyVFSiS9ZQ3xe8sQAfA5
 HBEg==
X-Gm-Message-State: AOJu0YwxtBJ2eefdA55TrxYWj+180I4XmMGNmS7reTTGd8tovKHYpEtX
 ya8iJG47oaWS1qpSQ3692fo4fKEd+883YNyCSoNi1omRrTf49SAHYGEUqNNIckuXVIvZcCbWbU2
 VylXTQzPdNPgKDPq24TAhmJBAxjE3wauwZABI0A==
X-Gm-Gg: ASbGnct/BLXL/1lN0V1R44lNx5YWVTLjUngu72UpmTU1f3zeVTG7lXr+sds7ID6QOQG
 Kc2puGELg+ig5Zbt9Na5xqZxcZz5jQXxaff8n/Ob+BPtV2fsZ0EJwo5Xlf8+z9yaHfg9naPA=
X-Google-Smtp-Source: AGHT+IFlpkl7uVcSomuEwpmFQDt2+BA0miqpDQS/2neiH+CHzaG/BV1OypezA4dsVYI55RJ3YAkaJ7D0Q0c1u5a4LFE=
X-Received: by 2002:a17:90b:4b51:b0:2ee:92bd:3a6 with SMTP id
 98e67ed59e1d1-2f2900a9fa1mr17186152a91.25.1734360744363; Mon, 16 Dec 2024
 06:52:24 -0800 (PST)
MIME-Version: 1.0
References: <20241213225543.392282-1-raymond.mao@linaro.org>
 <20241213225543.392282-2-raymond.mao@linaro.org>
 <CAFLszTiVmZGxETFkngDbsv0PCLN_bVv7ox6MFiAoGGN2v7tbKQ@mail.gmail.com>
In-Reply-To: <CAFLszTiVmZGxETFkngDbsv0PCLN_bVv7ox6MFiAoGGN2v7tbKQ@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 16 Dec 2024 09:52:10 -0500
Message-ID: <CAEfUkUL1EyJ6si_N6k6Ku1ZM9dWF6uHYXrQ14dueUeTEYzSRNQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm: get tpm event log from bloblist
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon,

On Sun, 15 Dec 2024 at 19:25, Simon Glass <sjg@chromium.org> wrote:

> Hi Raymond,
>
> On Fri, 13 Dec 2024 at 15:56, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Get tpm event log from bloblist instead of FDT when bloblist is
> > enabled and valid from previous boot stage.
> >
> > Note:
> > This patch depends on:
> > [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE options
> >
> https://lore.kernel.org/u-boot/20241212151142.1562825-1-trini@konsulko.com/
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  lib/tpm_tcg2.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> > index 7f868cc883..acaf0acb88 100644
> > --- a/lib/tpm_tcg2.c
> > +++ b/lib/tpm_tcg2.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/unaligned/generic.h>
> >  #include <linux/unaligned/le_byteshift.h>
> >  #include "tpm-utils.h"
> > +#include <bloblist.h>
> >
> >  int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32
> *active_pcr,
> >                       u32 *pcr_banks)
> > @@ -672,6 +673,12 @@ __weak int tcg2_platform_get_log(struct udevice
> *dev, void **addr, u32 *size)
> >         *addr = NULL;
> >         *size = 0;
> >
> > +       if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE) &&
> !bloblist_maybe_init()) {
>
> Please drop the second term...the bloblist is inited by U-Boot already.
>
>
As an independent library, from the tpm library's angle, whether the
bloblist init was already called or not is agnostic.
I think this is the purpose of the "maybe" function.


> Also please drop the first term. If you find it in the bloblist, just use
> it.
>
>
I think here we should have the same logic as the existing one in fdtdec:
If bloblist is not enabled or errors observed, do a fallback to the
original process.
At least I want to keep the same logic in different places before
everything is ready from TF-A to U-boot.

[snip]

Regards,
Raymond
