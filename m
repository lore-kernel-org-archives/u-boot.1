Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FF5CFC279
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 09:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A805788E3C;
	Tue, 15 Oct 2024 11:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gE/Ih2Yc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12AAD88EDE; Tue, 15 Oct 2024 11:25:46 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3CCE88AB2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 11:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2fb4fa17044so17760151fa.3
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 02:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728984343; x=1729589143; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vZ4iVetLRhEiftrWaGGVsU3rVMErHVBW6T5zj+dV+6U=;
 b=gE/Ih2Yc6I5OfqWao7kMFaDLUsMPrijDMyj+httMGsOeUrr2HZCsdBtCCTqbJZrOrV
 exsNl+Wi6BU3QNiJND5wzRbIjnq6TdpVNq5YADYqOCWl0Mv6HvfQwfoPG2TIOQQ3S5eV
 sXvVDYgjz+pV4vJbR9jXW6ymV9jBS+ET2maFcdxbW5wRiNZ43oG4r9+zNepOXqdHQMby
 zQRAJra0rLBdqr0O5VLcSMbxazhT1H0eSWPR+ajvUiJJMqviZuFKiZdI9w04nNVb4jTG
 dxtOqvcdRXZZLbhdNZgvDtpgW6SzLbbn2R/SEfdchfUgV6IRQBW83jwSeH9MLArZDTbZ
 P2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728984343; x=1729589143;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vZ4iVetLRhEiftrWaGGVsU3rVMErHVBW6T5zj+dV+6U=;
 b=UQ+Mpz3oJaJ42Hg0nmDFd8LFkP01lgnFH2Aj6/fnbA0V9h+6cz2fixqZrroLsUa+di
 SEd0TEdMtWAYzTDjil3De3as3eY20ivFi4zGJ0jZvIiZRJA0WReKlnya1MD5UHG9qE5r
 ApWTg+dofxvZdLjSVZ2duot+DS8cvuDGFsGAuYFArHcNnowQUKB3De91KXFOHVkxOZo3
 gD551Ncrs/rNhXQTxrn6/iN6hE1D2vqAq2m7cC2aU5ZhxT4o/5jiSeQoR0Nh1CqFkp3I
 RxjNH7S2msC7aDk0bhxnyCmxHfB8puACqUb7jz/YRpFu7ZX1/+LWfacmOPtoGb/Xl5wg
 +z6Q==
X-Gm-Message-State: AOJu0YzMXXukQe/sIXZOYFkLPVgPStMba0sYgEe73pRA0l963MKhm1JT
 gumpsZhWnCvduJcyTNHJDcaVJO74NVZa8BnroZe+JoGH2icemArlVxtOCu7mc1d6AGrJLtOLnRs
 z8iIFFp5Xkwdu+IUxRdX4T79ZZBmiUntTZimBzQ==
X-Google-Smtp-Source: AGHT+IH/ugj3AgW/nb+fFJX20OG2plc7uuyGv7tEK5ophOw7Y2EWMs/bEVpQLGtTiQGbF+NatM84g/TXqOmwGbXGqGQ=
X-Received: by 2002:a2e:958f:0:b0:2fb:cc0:2a05 with SMTP id
 38308e7fff4ca-2fb3f30c7bdmr36680711fa.37.1728984343133; Tue, 15 Oct 2024
 02:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-2-sughosh.ganu@linaro.org>
 <CAFLszTgVQH-4ef7kj+ziSUKrpwjjZB8QnJASpgn6nRFmKO7jGQ@mail.gmail.com>
In-Reply-To: <CAFLszTgVQH-4ef7kj+ziSUKrpwjjZB8QnJASpgn6nRFmKO7jGQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 15 Oct 2024 14:55:31 +0530
Message-ID: <CADg8p9634OCn4UY8nvnXBu-fnZ7CafkAaSw-Xu_ZJ0BM-3DsMA@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] lmb: add versions of the lmb API with flags
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

On Mon, 14 Oct 2024 at 21:20, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Sun, 13 Oct 2024 at 04:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > The LMB module is to be used as a backend for allocating and freeing
> > up memory requested from other modules like EFI. These memory requests
> > are different from the typical LMB reservations in that memory
> > required by the EFI module cannot be overwritten, or re-requested. Add
> > versions of the LMB API functions with flags for allocating and
> > freeing up memory. The caller can then use these API's for specifying
> > the type of memory that is required. For now, these functions will be
> > used by the EFI memory module.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V2: None
> >
> >  include/lmb.h | 56 +++++++++++++++++++++++++++++++++
> >  lib/lmb.c     | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 140 insertions(+), 1 deletion(-)
> >
>
> lmb_alloc_base() should call lmb_alloc_base() as well. It looks that
> you fixed that in this version?
>
> I'm not very keen on __ before functions. That is normally reserved
> for the C library. I wonder if a single one would be enough, or use an
> underscore suffix instead?

Okay, I will add a separate patch in the series to change the __ to a
single underscore. Thanks.

-sughosh

>
> Other than that:
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Regards,
> Simon
