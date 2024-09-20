Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F246CCF9C55
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66E7688CA2;
	Fri, 20 Sep 2024 18:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GcYfbL/O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A45788C71; Fri, 20 Sep 2024 18:01:42 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00AA888883
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6c548eb3354so15915076d6.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726848098; x=1727452898; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gdOOHIN3xD7cAAoiQqOkiG+SIk710uEbHGXr+BeXkJE=;
 b=GcYfbL/OiTSurK+A0jx2t9wbtT+f2oqlryun7kYBYYkhF5/caQ+vM/BSUTD/A8UeuL
 OVzt2IrES6/51jgQqGj/VSb6OXMRS1InP9DSc+VVIZmfDDLda/BKvMXmZBudQr0qhI6P
 Bbzokd7x/epoQbcXcaXsy+FWQPK67u1O0lfhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726848098; x=1727452898;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gdOOHIN3xD7cAAoiQqOkiG+SIk710uEbHGXr+BeXkJE=;
 b=ZRTl0/uvp+niv0ADn90cd9GGspWDINImz62AqAMbZqJOEuQrldk5HAqelcUghvqrk7
 zRfM83FD2J34zY4JKjAjWXykK40x9Jt/cxTw3nJv/2gzf9mWAkzWtls6VsyF3rLlI9MT
 4mIwX9d90/EfahOlUApaNveL8zqySl8xWmEmH3A4qqXcK16Y5Wgf0mdMIuWdy/rpRgyj
 ap8bimhPqA98adrlJVj/p313MBa3cHsL4vVbwyiep0caZtGExRZ2x4HSERpHcDKo5dx/
 9nBv1QboU3XgO04FfuXSVewde5VqDcDT85TKpPF4vBrheFcEvYPCWfCL9vLT2D3lkOB1
 Oa9w==
X-Gm-Message-State: AOJu0Yxo/hxr+GtQ9L1L/jBADPoku7EmGvKlobdYEh3y0gYgmsIgasH0
 n1ds85lIbDzz6ymADqmFhke3kI+kCZ683nr4Y6XnWX7N1dYiWHqDIPChmSfwBa9Tl/+rhGjquy5
 /rlE2We/vOoGsp+Kfe4s5GyTIjt7Q1ZUgUHor
X-Google-Smtp-Source: AGHT+IGWhxegq/DQIupLMrME1/XC4QcyL5yx9/U57hKyiXZQICfPJ42jF6ZJH6Ni+cyo1L+tkDcIMOQMYYCRLLbXxi0=
X-Received: by 2002:a05:6214:5a0c:b0:6bd:7460:fedc with SMTP id
 6a1803df08f44-6c7bd600120mr35573516d6.45.1726848097866; Fri, 20 Sep 2024
 09:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240710071612.1717460-1-rasmus.villemoes@prevas.dk>
 <20240710071612.1717460-4-rasmus.villemoes@prevas.dk>
In-Reply-To: <20240710071612.1717460-4-rasmus.villemoes@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 18:01:27 +0200
Message-ID: <CAFLszTj3m3HBP1zpnRRTprBW1iS_rBdh=s1h710LZyg1ic0GzQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] test: overlay: rename overlay source files to .dtso
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, 
 Maxime Ripard <maxime.ripard@free-electrons.com>
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

On Wed, 10 Jul 2024 at 09:17, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> Distinguish more clearly between source files meant for producing .dtb
> from those meant for producing .dtbo.
>
> In this case, the files are really meant to be compiled to .dtbo ->
> .dtbo.S -> .dtbo.o that get embedded in the image, which means that
> the begin/end symbols generated by the makefile rule changes to
> __dtbo_ rather than __dtb, so the consuming .c file needs updating,
> but this should not result in any functional change.
>
> Note that in the linux tree, all device tree overlay sources have been
> renamed to .dtso, and the .dts->.dtbo rule is gone since v6.5 (commit
> 81d362732bac). So this is also a step towards staying closer to linux
> with respect to both Kbuild and device tree sources.
>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Simon Glass <sjg@chromium.org>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  test/overlay/Makefile                                     | 4 ++--
>  test/overlay/cmd_ut_overlay.c                             | 8 ++++----
>  ...-overlay-stacked.dts => test-fdt-overlay-stacked.dtso} | 0
>  .../{test-fdt-overlay.dts => test-fdt-overlay.dtso}       | 0
>  4 files changed, 6 insertions(+), 6 deletions(-)
>  rename test/overlay/{test-fdt-overlay-stacked.dts => test-fdt-overlay-stacked.dtso} (100%)
>  rename test/overlay/{test-fdt-overlay.dts => test-fdt-overlay.dtso} (100%)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
