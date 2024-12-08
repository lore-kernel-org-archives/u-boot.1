Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F9DE7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 15:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D98A489628;
	Sun,  8 Dec 2024 16:29:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kpK5zgm9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 602F889606; Sun,  8 Dec 2024 16:29:37 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBECF89586
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 16:29:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d3f249f3b2so663702a12.3
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 07:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733671774; x=1734276574; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zt59CkSzbIYY+cXVdZhjXn1Ao6uzc0LFT4nzTbwgWf0=;
 b=kpK5zgm9t7WO7Jhb950vNP1nmo+3whdHL0bkHkbiVWNEi0Z2JfQ3RuGGTZeA+rgCd7
 hnRFUwsYVTwnSQuYxkzI0SXs7Fv4v2vqK36XOBTxdSPPFr5TgqvTIoF0qKgklxewHWlq
 gECU1jEMbW9jrKkv2a7VUJXKr4HEvtgAxH+ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733671774; x=1734276574;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zt59CkSzbIYY+cXVdZhjXn1Ao6uzc0LFT4nzTbwgWf0=;
 b=aQuoVBTVQOraaS/QYR3Sk9ohvY1eRbAuJQXITpZ6qKwWFMlbD1+759TxgP/R17K+pF
 3ngjyUBnUzoZFs/cGJN/ahBgnG06XrHzUgkvtRuGbm4vkJVniiFNeVNqxdDK+LOiVWPX
 6JZWHiFFUsoIwP6uG1+qx8Vs+JsKCjmvjYfidbUCpJmcSA1kLo3GDsiNcCDaigqIzRa8
 0bg6yQy4O4X38VqU1cI/f083T1FdhyEtEwjKENmfKnDeZQX2FCdc2x99jlVt7mmmTVWt
 ZQG4eXwCelzcLY/XCCl2mxaxKZR4bqcsjWEzLXPZeGAFZdQhdS+PGfkt7Nbrz2RzEeFj
 l/ng==
X-Gm-Message-State: AOJu0YxpLTu+TmW9w5oOditX0xagjeXpUXH/xpjniRz3+ovmtPeATlJ+
 j7WBBGmTwhrx4VfU5EZZNrYNhtMgCA3P4aDfJAZN9yG5dsFbz6FiH1gTvIkiOLd6ZH9H3ND2pvw
 oPrvHKAD7HWGy2IXafW7W6E4K/nDG3Jagz4Id
X-Gm-Gg: ASbGncttRmqKjThHyyDJZvfrzX071h4zXJyGDg7mbanNGWQcL6vKoxWRBsFLpZ0ioP+
 UjB0z0Cqc9xU66dl++LpDzCsOuj1zGTZ5
X-Google-Smtp-Source: AGHT+IGKRGf1a0IveLtYcSa1djKwiDGhM6PbklAqt7GGpFChnJF/XjEhwiwqW64hAzPM2nfJmLyBvNJrGjSJZ/N5u+4=
X-Received: by 2002:a05:6402:540c:b0:5d0:81f5:a398 with SMTP id
 4fb4d7f45d1cf-5d3be661893mr22907645a12.1.1733671774301; Sun, 08 Dec 2024
 07:29:34 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 8 Dec 2024 15:29:32 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTis_2t=hPC9aVQKMtoy5=OyEDQJDS17hqeJG=U3Qdn1hw@mail.gmail.com>
References: <CAFLszTis_2t=hPC9aVQKMtoy5=OyEDQJDS17hqeJG=U3Qdn1hw@mail.gmail.com>
 <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-3-mjg59@srcf.ucam.org>
Date: Sun, 8 Dec 2024 15:29:32 +0000
X-Google-Sender-Auth: 3-0U9YacNq3S3snb3oVLmFnrSUM
Message-ID: <CAFLszThg78C4Oyp2d6kmP2XahUgv8u6JLhzRH0y0Gf=-Q=YrTA@mail.gmail.com>
Subject: Re: [PATCH 02/10] Add part_find command
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Matthew Garrett <mgarrett@aurora.tech>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Matthew Garrett <mjg59@srcf.ucam.org>
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

Hi Matthew,

On Sat, 23 Nov 2024 at 12:56, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> From: Matthew Garrett <mgarrett@aurora.tech>
>
> part_find takes a GPT GUID and searches for a partition that matches
> that. It then sets the target_part environment variable to the media
> type, device number and partition number that matched, allowing
> $target_part to be passed directly to bootm and similar commands.
>
> Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> ---
>
>  cmd/Kconfig     |  10 ++++
>  cmd/Makefile    |   1 +
>  cmd/part_find.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 167 insertions(+)
>  create mode 100644 cmd/part_find.c

Reviewed-by: Simon Glass <sjg@chromium.org>

Nits below. This needs an update to doc/usage/cmd/part.rst and a test.
There is a ChromeOS bootimage used in the bootflow tests which might
be helpful here, as it uses GPT.

>
Applied to ci/master, thanks!
