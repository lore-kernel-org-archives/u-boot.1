Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C282AC0218D
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 17:11:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 378F380EFB;
	Sat, 25 Jan 2025 18:11:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HrmOhIsE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A39480836; Sat, 25 Jan 2025 18:11:48 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0DDD80836
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 18:11:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ab2aea81cd8so573914466b.2
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 09:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737825106; x=1738429906; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FgakT+Dt3EuNNry7juosRKDR6D9f61IG9MmzcbY2FlA=;
 b=HrmOhIsEKRv32OU3JY7ipSGnFjOGPhICAxZ6EVwTeS3mIzyRJvFT3Kj2TCOUDmThzC
 Y+ZavxKwGiyglYX17Xe4rtZJepw2kKrJd1HWRi2x1XCIXVM7hVZMjzTc/NCmIOtzQudn
 fHnEmg445DSzbFdtGprYrNKmuKWdoWSkQL/QM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737825106; x=1738429906;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FgakT+Dt3EuNNry7juosRKDR6D9f61IG9MmzcbY2FlA=;
 b=ESQcHrs3UlAROUzyaaLlWQni619Ymm2R78gspt/crR9dH4QeQD2fJQTk+KnN53pKSK
 KYl1uck8Is3BChLBnXoxmMBqsucqxB+PkqGbgFqx0BNAn/BdT3pQ5oOrtIjE3r6JNnZc
 wPXofgw9f7wb8wCemJlEMqCXTdG2KKqyg1k5/wAI7OCEh0IrMm1KSf6BSkCUzaet/9Ji
 MW5vN1DyF84raRhSHFseLHzR0TUt5WKOtIMYyE/5ugs/v0J911PWBxgDw9ZnNyv9lVFn
 dQel1IFqEPXYhkAXY9cymEkT5ySe2UFEpU+qeQDpIsum1H5BJvNA4k2vnCr8xKL85cob
 2cUw==
X-Gm-Message-State: AOJu0YwUwalLbuxA1m3HCl8908a/KrFuFM+rwEkaD7KxTsKBlXD/R9VX
 KU9DpdxxwagMxKd0wyUQ7RW889mBQQ34oS/x9irlXzCfacRcVrQsV3OF5DkQsp9gW5KmmexHDA5
 wxZAH+7TxA+PluLW9Lyx+AYwPnzUsbJm1cmL/5gkb+UZtc1Q=
X-Gm-Gg: ASbGncsgXRCaW6tX34BwhVfiLQ+vP0QOPh/DCbRmhUlUNMV1OpKDJ+dy6p+vk16fX3t
 vo0MDCPfZfHIoYQ1xwkYpzETD/ESEsrXl0uFCGJQCdhTUTDtiMlc2uperokakUT4=
X-Google-Smtp-Source: AGHT+IEos6d6TBElBJy/KARvV/m43OuHIG325tcOEXukcQwYOGL03GdNGN0dr3I4PvB2NS97I7ypH00wd+okEmp00mc=
X-Received: by 2002:a17:907:989:b0:aa6:a844:8791 with SMTP id
 a640c23a62f3a-ab38b378d8fmr3245634766b.45.1737825106045; Sat, 25 Jan 2025
 09:11:46 -0800 (PST)
MIME-Version: 1.0
References: <20250123161114.84071-46-sjg@chromium.org>
 <20250123162834.GL60249@bill-the-cat>
In-Reply-To: <20250123162834.GL60249@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 25 Jan 2025 10:11:30 -0700
X-Gm-Features: AWEUYZk0EhgyiQzbckwJEQnW3WZTPUMFHeazMo2_o3f3EFq4Tez1SngDuRkc3gM
Message-ID: <CAFLszTgkgoLJSkQwMJg1YWTuNpjiMfWbvWu41miRVE6wdaFq9g@mail.gmail.com>
Subject: Re: [PATCH v4 45/46] pxe_utils: Refactor to separate reading from
 booting
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>,
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

Hi Tom,

On Thu, 23 Jan 2025 at 09:28, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jan 23, 2025 at 09:11:06AM -0700, Simon Glass wrote:
> > It is useful to be able to select a bootflow and read its images,
> > without actually doing the boot. This allows adjusting the bootargs, for
> > example.
> >
> > Provide support for this in the pxe_utils module, by adding a 'probe'
> > method which selects a label and saves its settings, so it can be booted
> > later, if desired.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v4:
> > - Fix the force-prompt logic to leave the flag alone unless forced
> >
> >  boot/pxe_utils.c    | 71 ++++++++++++++++++++++++++++++++++++++++++---
> >  include/pxe_utils.h | 41 ++++++++++++++++++++++++++
> >  2 files changed, 108 insertions(+), 4 deletions(-)
>
> In the future can you please use --in-reply-to so that patchwork and b4
> will track this correctly? Thanks.

OK will do.

Regards,
Simon
