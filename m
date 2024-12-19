Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEBDE77188
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 02:44:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71F52803C8;
	Thu, 19 Dec 2024 03:44:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LbC4lbG5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C75DF8032B; Thu, 19 Dec 2024 03:44:00 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C66C280326
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 03:43:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa6a618981eso49034766b.3
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734576238; x=1735181038; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UQrSBAniD9HxmOfauj/BoU4VtYAruq+z5gVVWXAFADs=;
 b=LbC4lbG5mN2SxitBoMRuNoqXVya/9Rk0s2RRF51x+oANwvO31dDr55R/b60Q8dNI0k
 RbUDS8QuMbQ3r1+Pw0RAcozF+lm3/yfWyuabsjYeKvPt/EwEhwMwVLhkgeaEz1zkNk22
 lXElvSVp16tL4OM4IFEvBBbMrlRY5Ofgilf7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734576238; x=1735181038;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UQrSBAniD9HxmOfauj/BoU4VtYAruq+z5gVVWXAFADs=;
 b=Wr2iGrD4RYZYjvO0mF2164dzg2+WrAYkKBUfikmovNHBaxeBTnlg1ks93QhZ4fx1Vm
 qMb2nFHu2yPUWFRXfE6BUoafOtldnmi3p/VBniuf+zXNqwP54EPUS0Tm4kp7vk3Iyf7a
 jOgF1ml7/YfKk3a5sft0DD72MkSJ0TwKlyZ3IYE58Bd0o2JhzMpT01O8K7JmgD3kwp0B
 DW3vwqkqvPf2C8QSheG/XmwJAnskZqfR4wBwij8r9m8GGpxd8KFjNPPrHb+LH6kmTJrE
 cMCjS2c6XhdS6u5bwlJoar9RGJRfwWCSLhOyrtdxerVQYJz0m9hKwtWSvyrc6Dh/T4f7
 WX7w==
X-Gm-Message-State: AOJu0YzKRUAMOp4YsrpJkVeLLyyBEdnA78Vy+yH+WpS9y+YTCn4PXbfs
 kYtv54e/NnYDAVkNb9e4txY4chzbDa3smY8VO0Csh9Kwm4Vjs/Ovg9QHeip6emoo4GmLdgh8T9Y
 diLekGGCEPRqfgKWE1m18Zz+OkDqBLpHK+eHI
X-Gm-Gg: ASbGnct3DNHAkkwuwVkXoKyo6FMk1LqExmPUt753eJichCUjbu2R5eaiURwh1FftGPg
 A+VH36Fgp8r7NluimUScncC0VL2pXRwJpqBrOB7Q=
X-Google-Smtp-Source: AGHT+IFzFfSSqV6xUIKOaSvvOUuhgmYEM0USnV97c5mr8BeX1qUV0/+y6GZnlxD3SI8baGVOt5gQvR1J7/LnJySnDaE=
X-Received: by 2002:a17:906:3119:b0:aa6:94c0:f755 with SMTP id
 a640c23a62f3a-aabf47067a4mr385478566b.1.1734576238279; Wed, 18 Dec 2024
 18:43:58 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Dec 2024 18:43:57 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAC_iWj+CpxZ4nd9Y+k+=2cEuWMGknPjqtHt+hvkJ+vEW9kGv_g@mail.gmail.com>
References: <CAC_iWj+CpxZ4nd9Y+k+=2cEuWMGknPjqtHt+hvkJ+vEW9kGv_g@mail.gmail.com>
 <20241211223822.2446254-1-sjg@chromium.org>
 <20241211223822.2446254-2-sjg@chromium.org>
Date: Wed, 18 Dec 2024 18:43:57 -0800
X-Google-Sender-Auth: 7Agayfj-kjdNit3U7lakZNPXf3Y
Message-ID: <CAFLszTgLndCsGS=eCu9P1OfwWzZ06KaCqEp-m7E7fnKfKnKw8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] efi_loader: Refactor device and image paths into a
 function
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Moritz Fischer <moritzf@google.com>, Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Thu, 12 Dec 2024 at 00:38, Simon Glass <sjg@chromium.org> wrote:
>
> Move this code into a function so it can be called from elsewhere.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  lib/efi_loader/efi_bootbin.c | 53 +++++++++++++++++++++++++-----------
>  1 file changed, 37 insertions(+), 16 deletions(-)
>
Applied to sjg/master, thanks!
