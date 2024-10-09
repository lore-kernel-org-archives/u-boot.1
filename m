Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09323CF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9834890C1;
	Wed,  9 Oct 2024 03:53:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L038ploY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69F3889093; Wed,  9 Oct 2024 03:52:59 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA67F8906D
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71e01eff831so2114933b3a.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438775; x=1729043575; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=awjF+EEBv+Ta9B3CdcnfZNTIBLr7AmyvgAtpfPGE5xY=;
 b=L038ploYdEB3xz1sGYj5x6P66lG4Ez8w7RGGZVjTNWesok3Srm6opC/34DH0VFfCsa
 5TOa72hlrPyACsTkZXCQwDv3T6Uc3f3gWoH05mg1sRlgBI9TJYitVYhX02JObB8w1kqK
 BN1vTwRfpzzHG3Pb0wZGRcLIkqeWZqb09/a34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438775; x=1729043575;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=awjF+EEBv+Ta9B3CdcnfZNTIBLr7AmyvgAtpfPGE5xY=;
 b=sX1ZqgGFJ7HtVbXvXT2wjxSAsPJ0D2btNTDWfSUixoJ3274aiVn68OMOg5hG7Ife4g
 jIjLossuExZdrqxwWkVDRIFeYo8o1RyR+Sd/t+RynzLr5yGsKlbAvLNSDfjZ90Ia8uLS
 FPZWGMdrL7+m33RiIHeFqolpiwYJjSnqc60FdodZR53G/p2oN8yIHt3lCpexqWbZqX2l
 561C9KRLlQ0v0iMPaxDK6uKoNpvOz7OfJm8C9UmDp2OLNI2SRsoImIR4wrpxVC2vp4vy
 M781f1Rot3VyAtF22GJV7cWDQ5YGmA0q3sVCjsxM8lyZhlu5EPUxvS0bIWxWhAD4LhnI
 jUyg==
X-Gm-Message-State: AOJu0YwISWphAWz9UZB4qQc/DDya4VHj+j5Q6MWC0WgbCU4SWW+N37W4
 /7n8wuRYj6iq9FX0CMEgPSMcAw46KgA5Hvz4hbz8aqC+4mSEC4R8zpI5kuBPPXiIB7qmHoBPvEv
 odN53+9NJIBdAcSNNdIWTQbUIU9DePh1kcWMP
X-Google-Smtp-Source: AGHT+IGQAgEYuueTsC244nGT52vka/lfnDCWWFZyU0ISr6G4BMpwnUzTNU9t14RxUvS1+b/fsa1apQzpsac7iGgmwNI=
X-Received: by 2002:a05:6a00:1948:b0:71e:1314:899a with SMTP id
 d2e1a72fcca58-71e1dbb7f4bmr1334011b3a.20.1728438775545; Tue, 08 Oct 2024
 18:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-3-ravi@prevas.dk>
In-Reply-To: <20241003212802.3810-3-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:52:38 -0600
Message-ID: <CAFLszTiiCgKGrn2vuMSfrg9Et=Oi+VcEEycQjYK7qS7zAQEesA@mail.gmail.com>
Subject: Re: [PATCH 02/13] cyclic: introduce u-boot/schedule.h
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
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

On Thu, 3 Oct 2024 at 15:28, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> I noticed an "unnecessary" include of <cyclic.h> in
> global_data.h, in the sense that nothing in cyclic.h is needed in
> order to define 'struct global_data'.
>
> Well, it's not unnecessary, as it implicitly ensures that everybody
> gets a declaration of schedule(), and schedule() is (obviously) called
> all over the tree. Almost none of those places directly include
> <cyclic.h>, but for historical reasons, many do include
> <watchdog.h> (most schedule() instances are replacements of
> WATCHDOG_RESET()).
>
> However, very few TUs actually need the declarations of the
> cyclic_register() and struct cyclic_info, and they also don't really
> need anything from the watchdog.h header.
>
> So introduce a new header which just contains a declaration of
> schedule(), which can then be included from all the places that do
> call schedule(). I removed the direct reference to cyclic_run(),
> because we shouldn't have two public functions for doing roughly the
> same without being very explicit about when one should call one or the
> other.
>
> Testing of later patches that explicitly include <schedule.h> when
> schedule() is used revealed a problem with host tool build on win32,
> which apparently picked up a host <schedule.h>. To avoid that problem,
> put the new header in include/u-boot/ and hence make the include
> statements say <u-boot/schedule.h>.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  common/cyclic.c           |  1 +
>  include/cyclic.h          | 12 +-----------
>  include/u-boot/schedule.h | 24 ++++++++++++++++++++++++
>  3 files changed, 26 insertions(+), 11 deletions(-)
>  create mode 100644 include/u-boot/schedule.h

Reviewed-by: Simon Glass <sjg@chromium.org>

But could it just be include/schedule.h ?
