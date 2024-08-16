Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72B6C531DC
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 14:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE7FA88BAE;
	Fri, 16 Aug 2024 16:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XgmoevwQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45E7C88A99; Fri, 16 Aug 2024 16:49:42 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16E8388B23
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 16:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2d3c071d276so1576797a91.1
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 07:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723819778; x=1724424578; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uYKNKYX2v0NoD5RqzmpvGH2qYSNmR6ca8GWSZUoNygc=;
 b=XgmoevwQQcpZHncXRl/+3fP+HlwLaerlDSHHSh2AqiSHyCBLTIlXApbNLC7mGESbyM
 9aipYilWUxp9xGJsNK6av2DJhOlajCYd/Vnca2BFwcmXi4yLu+D+XMs7zEaa7XOGZUdM
 RnPLwB6K4qu2ZZSqjBuY7rMPBHrMl0Oq+dcpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723819778; x=1724424578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uYKNKYX2v0NoD5RqzmpvGH2qYSNmR6ca8GWSZUoNygc=;
 b=Z+02WBFQlF5YPMTa9PDnsPuSv5FcN/dSUBLsarzJ3KYBe2Ef/VmDCVVEadt2Rb+NW0
 yMeu57VxmFkXLttPhtKAXEZCpV7Vy9ijFc6AJdaJMW2jT+uBR/CnHGpKlIKZBKhicpPl
 qYnkHxX9rU6Pz2Tq5qCdBnbb/lWg9w+1oSkLnQW1XtXdk9veXTV/lJyl9HlSsIylKzJ2
 /96x6dg04Gu8IbvgjfucpTFzCgqgVWMLQihiIuYoZH13KqjID2cI2lLvl8q8vKwu2ZbO
 KpPCxL+N6AKangzTFpKcZcOn83GjzHwtEBIAy9kAu1P5KvJwcxH1AL4ftj0jCUoE9mgd
 yAkg==
X-Gm-Message-State: AOJu0YwnQlGoJN1B3FjYReJbut1rPB8HoeaDA7kNsYX7TSUWVfUxT0Q1
 irFnUT4gWfazgCKXQzB1qk2p9ArFQrmE6orhwcgptGJcIZC1TUaEoczlkHTZDdH4/OCFrzJSLwT
 8MqnHuF78CtJxvneJHz1AjcVbvzxMpjrk4KQV
X-Google-Smtp-Source: AGHT+IEvIjly4/ZPyG2nanIyuT74aEYiWRqYhKytiLeXjWQgcF2ntpBECq9khjSWqT7eZmK7pvAAIBhxeL5LiFEdX0g=
X-Received: by 2002:a17:90a:d983:b0:2c9:923e:faf1 with SMTP id
 98e67ed59e1d1-2d3dfc6dfbcmr3506170a91.18.1723819777689; Fri, 16 Aug 2024
 07:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240816034905.3541020-1-trini@konsulko.com>
 <20240816034905.3541020-2-trini@konsulko.com>
In-Reply-To: <20240816034905.3541020-2-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 16 Aug 2024 08:49:23 -0600
Message-ID: <CAFLszThni1D1Q7ad_4YgpFj6rKASsZO4cSvsn8=3QDx5-TEwNQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] test/boot: Make BOOTSTD tests depend on UT_BOOTSTD
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Thu, 15 Aug 2024 at 21:49, Tom Rini <trini@konsulko.com> wrote:
>
> While we have a symbol for controlling if we will be testing BOOTSTD or
> not, and it depends on SANDBOX, we do not control the building of
> test/boot/ content correctly. Guard the current bootstd tests with
> a check for UT_BOOTSTD and leave the measurement test available.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
>
> I'm unsure about the VPL and UPL tests, but they aren't causing failure
> to build yet, so they can be sorted out later if they're a problem.
> ---
>  test/boot/Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/test/boot/Makefile b/test/boot/Makefile
> index 8ec5daa7bfe7..d8eded20d4ff 100644
> --- a/test/boot/Makefile
> +++ b/test/boot/Makefile
> @@ -2,12 +2,15 @@
>  #
>  # Copyright 2021 Google LLC
>
> +ifdef CONFIG_UT_BOOTSTD
>  obj-$(CONFIG_BOOTSTD) += bootdev.o bootstd_common.o bootflow.o bootmeth.o
>  obj-$(CONFIG_FIT) += image.o
> -obj-$(CONFIG_MEASURED_BOOT) += measurement.o
>
>  obj-$(CONFIG_EXPO) += expo.o
>  obj-$(CONFIG_CEDIT) += cedit.o
> +endif
> +
> +obj-$(CONFIG_MEASURED_BOOT) += measurement.o
>
>  ifdef CONFIG_OF_LIVE
>  obj-$(CONFIG_BOOTMETH_VBE_SIMPLE) += vbe_simple.o
> --
> 2.34.1
>
