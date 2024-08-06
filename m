Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8475C52D6F
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E96BB88B49;
	Tue,  6 Aug 2024 23:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cfbFrCMp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 634E688B5F; Tue,  6 Aug 2024 23:51:35 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0766088B5B
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7163489149eso821129a12.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722981087; x=1723585887; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cDi0vwfUKhpxpvl6fMsLcxXnGMCfhi7D1zN1RsTV0wg=;
 b=cfbFrCMpr971bP6gf+cPc/zVM1OtsZDP9ZaFnSTBux9ieY14HMW7gGJ/U3tqhE7OzW
 TlWRhkGFWupUboSviqn0gm1NIQaWtZRj5IBCc9pCds/yXGyHUtXi1QN3C46+6SUmd19J
 Nf/gfoTYeFgG3aJPKutiaA6TfnSkvSghRDi1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722981087; x=1723585887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cDi0vwfUKhpxpvl6fMsLcxXnGMCfhi7D1zN1RsTV0wg=;
 b=fUaJEr6GlTq/GjdPDSz0D4ttwEQnpM/1CL99MKHzyw4jfsK2BQQOgT6YB9zcrQNufY
 lUcCLgVLcayja7rqAcvGyqJzQCh7+WFdXu9vqnF1CEmJJ85mvQcPodAzX20skNBBXM+A
 pBY1bQub2WAnlMW7UxuvZig4Y4kG2MHf7IROS2ALm98oWAxzlKSsXoWAMCAl6BT1U1ae
 tK1UX+Fpk0CLmSjmipJWllJtVnSp4RPJ8hWucp1/N41M6y2Bvq+bzZjzWEeKgqpm1x3K
 2zpz3SF1UKV7xEAsAKEKo7OJ7arPzr0SOsp+nXpxvI68zcLdJj/yCtJK00Sy1HEQ/1FM
 rQVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyGQ/7/B5XhH3e1xlAtfXK4QIiqyK9GaRFfHDuL0VVxKYN/Egj/iUI8uvufm9N7amzojsQmoIbOlTmvLIi0mjpXDS6Tw==
X-Gm-Message-State: AOJu0YySWyCHXcDRAHVR1hUU0gEBL/pITiUEWfu7BDxZkRQUb7q97Qdg
 UA5sBmQLdU9kjM3DI2Mgk5yytvP6B5LC2sFzkkPeKxMUw6Jq8+bz9GYfVpIbXLlBooHkSg2EVP8
 J9m207C8p6xdSdFG8jFg3I7/34Lvb+kba4Wzd
X-Google-Smtp-Source: AGHT+IEOagyhanVmCwon85CNVJNEBUCwio4aeZpivJGnxRxtq/ImrLoIrXEoP1DntO1/MXXdezNDuXav/V3TUjPr1CA=
X-Received: by 2002:a17:90b:2307:b0:2ca:7636:2214 with SMTP id
 98e67ed59e1d1-2cff9414339mr20209969a91.4.1722981087233; Tue, 06 Aug 2024
 14:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240802092820.917450-1-admin@hifiphile.com>
In-Reply-To: <20240802092820.917450-1-admin@hifiphile.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:50:42 -0600
Message-ID: <CAFLszTh3x8JDjjRWSffTz10x4YEjtrKv-OuGTQYzw79rOF=WMA@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: udc: Fix duplicate uclass name
To: Zixun LI <admin@hifiphile.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

On Fri, 2 Aug 2024 at 03:31, Zixun LI <admin@hifiphile.com> wrote:
>
> Currently both USB host uclass and USB gadget uclass are using the same
> name "usb" which break uclass functions like uclass_get_by_name().
>
> Rename the uclass to "usb_gadget" to fix, also makes bind/unbind by class
> index (or sequence) working.
>
> This breaks the capacity of using "usb" as DT alias sequence numbering
> which needs a fix afterwards.
>
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
>  drivers/usb/gadget/udc/udc-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
