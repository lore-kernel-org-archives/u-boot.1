Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280ADC27C75
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 20:24:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7823887C3;
	Wed, 12 Jun 2024 22:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NbfcNVKF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F196C882FE; Wed, 12 Jun 2024 22:24:33 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E16C6882B6
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 22:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-627e3368394so3191887b3.2
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 13:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718223871; x=1718828671; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eBylGjEFqxvaXOym7olkucFBOL4ybFGlGYPdkscyJdY=;
 b=NbfcNVKFO27+kI5iYH96yWIFtBHGe4xTxVZrMlAXWM0tAX2rjBHpHfLu9WoSaNz4nA
 GuSMrNvz+ltygtrL2acMvor3oiL/mDGdfppPafjUcPaRgwVKgx3cBuXGKMiQiBgkg6cN
 zrwgccpya1jMsY/w48QEupqgYZjKK/Z9IB4rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718223871; x=1718828671;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eBylGjEFqxvaXOym7olkucFBOL4ybFGlGYPdkscyJdY=;
 b=s1qmkBsFHGjeoaNxOcFyY3LlbMnMWx76KqtobXNAqdqF6Lk+fXc+MyB6GbOSj+QIis
 6+ChpT9aJdgV21oF78HIu+mrS6sAP6tGZPAotQ9pm7klOOY8Jkp/dKeF3QYN5fThDuHv
 FVShIi6bsbfuiCBO3zHxpa4KLRfZssJGu5b+z7ejTVXtXFaVG9Fc4zMezFJN7Jen2h1R
 0DOAB6GEtnPq5yZzF44OpUnpkrOQoBULU+GO4ksc0f8Wi4TW6ZVEiHm5Vc2RbncQESdX
 e4xv6cVLYM6ZeVarPnt7zXNTMUmGdfUbFi1V0+/VAxIcYIei0dL9mufGbEt2BnwGZ3Bg
 p8Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrsN/xlhPfho5ZpNIEOWDrwPQdNTbxJI2AncvxFxTaCOSbPMzGmqL2sZQD/ciXPCCwcX+fe0+IxDI57Ov9QRG8MkUUXw==
X-Gm-Message-State: AOJu0Yyahu+wf45Oh3+BMCAWtDfa3kvsgmO4YLRBWPudMFxNQMZa7pYs
 PQtmfTELqz6RoHxJBzw4WZrxvhyJlCgPPGc6lwS2YWeTCqkVZAUVc/mT3rMXKwfYWMZFAfvrhbt
 RBs5lqPZtGho5O1N1KETq2zGpz3IQhpnlBSVc
X-Google-Smtp-Source: AGHT+IHIZ5fkZrqajq3Tvq4dCiMXL1BhjcpIKs05MZAgLSi1SETrAHA+qOjvVezSEOClanoVKqOICwtpfga4KG6r0RY=
X-Received: by 2002:a25:ef50:0:b0:dfb:be1:b1d1 with SMTP id
 3f1490d57ef6-dfe6775a306mr2822438276.35.1718223870731; Wed, 12 Jun 2024
 13:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240612-bootflow-efi-crash-v1-0-27b71b0ff08a@cherry.de>
 <20240612-bootflow-efi-crash-v1-3-27b71b0ff08a@cherry.de>
In-Reply-To: <20240612-bootflow-efi-crash-v1-3-27b71b0ff08a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 12 Jun 2024 14:24:20 -0600
Message-ID: <CAFLszTgFMD-j-GzcKXrdGRUiahgmEku752CD7ftJgXA6PsztDw@mail.gmail.com>
Subject: Re: [PATCH 3/4] doc: bootstd: fix typos
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Wed, 12 Jun 2024 at 08:58, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> This fixes a few syntactic issues as well as typos and grammar.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  doc/develop/bootstd.rst | 50 ++++++++++++++++++++++++-------------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
>

Thank you!

Reviewed-by: Simon Glass <sjg@chromium.org>
