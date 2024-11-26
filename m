Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191F5D3B9A4
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 15:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F052895D0;
	Tue, 26 Nov 2024 16:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k9bpJp+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 240E488D13; Tue, 26 Nov 2024 16:39:41 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28F2F895D0
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 16:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so779876366b.1
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732635578; x=1733240378; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xLUWOTh2epVmrGyvp/QUuEXT9x3RKhi/RCU155Dti28=;
 b=k9bpJp+pDYq2Hf0eYdjvfhX+sJmaDwU3lB9NEz/YwXoTvUqG+QYBmH7vuWZ85v97rw
 GIP4NJUpoptcMokvinrZGrXA9iADWIne/jd5/ITyZwbO0NS0yzSQK8AWHct3ROPiDccH
 /MW9ibnWDpOh/haHUE9eBU/5OL8aJ6UPr8eP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732635578; x=1733240378;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xLUWOTh2epVmrGyvp/QUuEXT9x3RKhi/RCU155Dti28=;
 b=PmcBxDeRq0cDq4zmxuqNUyxJGOKliMmJ7qxSzcHjoQeJd/x3vB7fe5Ln5NLHby3kdW
 8TNhFNDOh63p0/7SxKYnWZJ8n19nH+EKsB+Rt6Mvzi2fAkyTTDG1G0rX9G59OW9+P2J8
 zGSE+SdzPHmZNqrApTrXCx4sC7yPnWlp4n2+SydX8JyrVK1q3cZFUZJWKT0wlo1V2y9C
 kHYjqtwwZEgHpJlBgraOE3cmCyS10tM6Yuqadvdr9sn7v1s21aNEpJq+6bFpwUi9hXT0
 93pzyWmHqAufXPvh4AEoI5A/R1MCyDl5SAuJ0iFGxCfbRH1XLXsoaLbOF72/zFwr2zSk
 wnGw==
X-Gm-Message-State: AOJu0YxmEDXQqSELtkOcQc7UKp5f/4BNqqmsX5+er6LDw2WOJlcknvFX
 kTELGcHjgRsq6CfBqzyhNHfPoJKoy/DSPMm9fZgN3BR8c8IzHHCmwFSrlohnsKub7NzcZk0RdVl
 JvovwlsG5uKzm7YD7uh/gyUzPZ6V/uihZEtT6
X-Gm-Gg: ASbGnctak1malfoN0RbowE6G6RbwPKJVmHmMdvRhNM4GA+ZRCwnOUR8GycWFWmJHMg/
 6bJW8XV6s7Wz6JLHc3mr65yXziCetE0Y=
X-Google-Smtp-Source: AGHT+IE+B9X1RdYH4ArcFejZuslbuqZS8aFAUEsQ0wpbJhIZmHJ770JcL1vjvPYrvKMaZS2pf5MQ+3xZYOpDsJz33f4=
X-Received: by 2002:a17:906:2192:b0:aa5:1a75:dcd5 with SMTP id
 a640c23a62f3a-aa51a75e26bmr1391694766b.44.1732635578633; Tue, 26 Nov 2024
 07:39:38 -0800 (PST)
MIME-Version: 1.0
References: <20241112131830.576864-1-sjg@chromium.org>
 <CADg8p96cKqSEmZWLaOV1-onUwT4uwBp11=t4K7tmmPwZ-6UvXw@mail.gmail.com>
In-Reply-To: <CADg8p96cKqSEmZWLaOV1-onUwT4uwBp11=t4K7tmmPwZ-6UvXw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Nov 2024 08:39:25 -0700
Message-ID: <CAFLszTjw8ihHESoDk0RE6+00idN4Y-7=72NbUp+yOqpyCYqexQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "efi_memory: do not add U-Boot memory to the
 memory map"
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Sughosh,

On Thu, 21 Nov 2024 at 00:53, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Tue, 12 Nov 2024 at 18:48, Simon Glass <sjg@chromium.org> wrote:
> >
> > A bisect of Ubuntu 2022.04 boot-failure on qemu-x86_64 resulted in this
> > patch. I am not sure how to investigate it.
> >
> > The boot hangs at some point during booting of the install image, before
> > the Ubuntu logo appears.
> >
> > I will sent a series with a script showing how it is run.
> >
> > This reverts commit a68c9ac5d8afc51c619c5d3e865fcf147bea90cb.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
>
> I did some digging into this issue, and it turns out that the revert
> is only masking the real issue. What this revert does is mark the
> memory region occupied by U-Boot as EFI_BOOT_SERVICES_CODE. The x86
> kernel seems to mark memory regions other than
> EFI_{BOOT,RUNTIME}_SERVICES_CODE as not executable -- and this is
> precisely why this crash shows up only on x86. The actual cause of
> this issue is in the efi runtime functionality of U-Boot. The kernel
> is calling the SetVirtualAddressMap() runtime service function, and
> that seems to be calling some of the boot service code of U-Boot,
> which it shouldn't. We do not get the crash after disabling the
> ConvertPointer() and SetVirtualAddressMap() runtime functions.

OK, so what is the solution here? Did you send a patch?

Regards,
Simon
