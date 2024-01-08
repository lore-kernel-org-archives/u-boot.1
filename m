Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805A1C47073
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:21:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5DC687AD9;
	Mon,  8 Jan 2024 01:16:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WyreyAwX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A205E87A4F; Mon,  8 Jan 2024 01:16:41 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BA4A87AB0
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-680c7cf2ab3so14491316d6.3
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672998; x=1705277798; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0gwb/iPHuWkF+kPoNVuTlsutzKO7Rl8eA10n9vX1R9I=;
 b=WyreyAwXq848WjyMOv/lOfgNsJynMuHNAnDtWS+dD7Ag4BaJscMZ9R9Nm5fpOurzWg
 jXiJSeMLIg2/yVr2J7YLqKjl1fbjr6LY54xhIoasKEgslMNpaBc18Wy1Iamhjd6PIQ6I
 ucGxzPKLlIjOmxKja3oSfv6K6vwINOez6nxB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672998; x=1705277798;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0gwb/iPHuWkF+kPoNVuTlsutzKO7Rl8eA10n9vX1R9I=;
 b=seoG49wDmc8CcFLVCAiLbGXLycWjb+HNLQOnw4J9wMEZ1gr32f5rq30T05c9AdiM36
 IQMv9B9V8kSYSUfimMB99rl7mJ4RqPLOEM0N8yWSTcp5vVHDeOzAkhAs1N6Lk2EN4sWz
 luMPKFDRNSO/YkFvyjgjDlGGgAy4w2czTEpWd5rjNdo8RKZvMVWyzVM5puvS2R58hGOk
 S8dSHyxdxlxJJNjcFxVA9MytkmWA5Pq9y/KbSbKpMiOvbzRcAADP3dm5pY0GGUReY1hu
 XsfeQHnXKbY9VOTJiZ4IaPs8q9O3FjOm3pXF5D+mwaV+OltugKNMZi+Z0Wevr25+s9tx
 bi/w==
X-Gm-Message-State: AOJu0YyX4a17lGTTsk9YZ/Amz+clnoP2zUx01GNcHS75Evroa53UjAvb
 qUaha+SNChdJaagDJ7jHm7Af2fx+Ige9P3sH8V9Zd06wTcII
X-Google-Smtp-Source: AGHT+IHRbR0OMVM+sDWLl6Nc/4wImSqOaBQhxLZPHysIzzLcH9qgTDBnwzLMjOjA3O1hyWI61204jDvbjAfAvSZJRNg=
X-Received: by 2002:ad4:5dea:0:b0:67a:b1f1:9c57 with SMTP id
 jn10-20020ad45dea000000b0067ab1f19c57mr4123923qvb.26.1704672998545; Sun, 07
 Jan 2024 16:16:38 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:38 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ2WdXAj=6=jTf1mYxDRR-8ow3OFr+tjrrvqKBNWJV78Qw@mail.gmail.com>
References: <CAPnjgZ2WdXAj=6=jTf1mYxDRR-8ow3OFr+tjrrvqKBNWJV78Qw@mail.gmail.com>
 <20231216081200.7677-1-heinrich.schuchardt@canonical.com>
 <20231216081200.7677-2-heinrich.schuchardt@canonical.com>
Date: Sun, 7 Jan 2024 18:16:38 -0600
X-Google-Sender-Auth: 0rkeoPjulQh4GHZKAFFcPhq8qos
Message-ID: <CAFLszTir8ni0Vv_XJLry3+fprbhOwy-GPRX09PkyxF5c8i7Jbw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] acpi: use 64-bit addresses in FADT table
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Sat, 16 Dec 2023 at 01:12, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Fields X_FIRMWAE_CTRL and X_DSDT must be 64bit wide. Convert pointers to
> to uintptr_t to fill these.
>
> If field X_FIRMWARE_CTRL is filled, field FIRMWARE must be ignored. If
> field X_DSDT is filled, field DSDT must be ignored. We should not fill
> unused fields.
>
> See the field definitions in chapter "5.2.9 Fixed ACPI Description Table
> (FADT)" of the ACPI Specification 6.5.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/x86/cpu/baytrail/acpi.c | 9 +++------
>  arch/x86/cpu/quark/acpi.c    | 9 +++------
>  arch/x86/cpu/tangier/acpi.c  | 9 +++------
>  arch/x86/lib/acpi_table.c    | 9 ++-------
>  include/acpi/acpi_table.h    | 6 ++----
>  5 files changed, 13 insertions(+), 29 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm/next, thanks!
