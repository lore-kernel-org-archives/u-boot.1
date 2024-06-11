Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3955BC27C77
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 22:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40D5F886AE;
	Wed, 12 Jun 2024 00:22:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bbugvtbQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 401688877B; Wed, 12 Jun 2024 00:22:41 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A10588732
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 00:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b07308fe6cso14986306d6.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 15:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718144557; x=1718749357; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UmgxbM7eHgfQhDkyBrsKcinYMIO0RhQx/OgrbS5PtWY=;
 b=bbugvtbQKh9DOGaB3FpW+OrGjGRK8K74E4jWQrYmuBlyMjNE+G2ZOcP2ZjlraSNWxW
 AlPFkORfiG1qDoiKPma5iBy/LBv7yXVwANUL/kk1aFqPSmIZe2W39o7VqxWCzaR0HX1Z
 bCgOGER3hhbo2ke5PTqCy2stmsFCjHQu6zAQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718144557; x=1718749357;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UmgxbM7eHgfQhDkyBrsKcinYMIO0RhQx/OgrbS5PtWY=;
 b=kiDaZV3GOV2dUJ2DEJlJBC8X/cv4P7eYyFtfDSoWHpzvihTD3fAW5MnTjkTDvsF2tB
 pTxZ6NsT51K58PDvJ794iVgdnxZt7Jc0T37y/ohaJ/aim9uGRhzO8bv/i6m3FxpuO72Y
 crJF/7QVKQwlaj3hS9wgQTDnYp/ogPkQ4aoATnYhQAq3dKudiZpUfbPxblfdWK+7Ad/C
 o10Cw8gawUAajh7DV2UNvRQOmp8+n2s9Jb7ucJgltP7HvhtX1FMtGDgzVZEts0/8QSOd
 CuUZT1Kaic3U7B6pCssPjzHLjwIDC3bt9rU5rN6E1elNKs/B3N4fdw7MpO4cGEucwGMv
 JIag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkmssOCC0xhi3pNHFEnnUnp2AeAa2WcOjyPG43lYJqpA5bgjoCAknnupvd7eF57u2jug1z1+Iu8OyQv5q/wwzxNTqZkA==
X-Gm-Message-State: AOJu0YwvtZMJkjmhpv2YQUlNutbazpoeEpdh+w9w60x5JLJFmMJqjvoJ
 9N4ql8XPmdj09AQCGqE0DL77Yvsu5yCc4UJsl2Asi/C5DGUHXoyWtJMe/ate4YUl4ypxcifoP8L
 +RW8+DQzgoL8a3BZQNBWFYfoin+Lqr1aA7uK7
X-Google-Smtp-Source: AGHT+IHGcBp9FtPYWpkadmA/HihQgGRD8T0SDcxbi27BNVaU6Od3z8iIoBog1GJg0exv6+iZkKXGL0tiktpw561CnF4=
X-Received: by 2002:a05:6214:419d:b0:6b0:7b34:21c0 with SMTP id
 6a1803df08f44-6b19e4ba443mr156756d6.34.1718144557437; Tue, 11 Jun 2024
 15:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240611210025.798978-1-jiaxun.yang@flygoat.com>
 <20240611210025.798978-2-jiaxun.yang@flygoat.com>
In-Reply-To: <20240611210025.798978-2-jiaxun.yang@flygoat.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 16:22:26 -0600
Message-ID: <CAFLszTguujqx2SCpbUvXx=A+sgD5rKdyg9gbQG_VA7ZBdYOfOw@mail.gmail.com>
Subject: Re: [u-boot-test-hooks PATCH 1/4] qemu-vexpress*: Pass -audio none
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de
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

On Tue, 11 Jun 2024 at 15:01, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> Those boards have build in sound card which cause
> problems on CI runner.
>
> Pass -audio none to disable sound card backends.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  bin/travis-ci/conf.vexpress_ca15_tc2_qemu | 2 +-
>  bin/travis-ci/conf.vexpress_ca9x4_qemu    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/bin/travis-ci/conf.vexpress_ca15_tc2_qemu b/bin/travis-ci/conf.vexpress_ca15_tc2_qemu
> index 83d703269377..55e40038b379 100644
> --- a/bin/travis-ci/conf.vexpress_ca15_tc2_qemu
> +++ b/bin/travis-ci/conf.vexpress_ca15_tc2_qemu
> @@ -21,7 +21,7 @@
>  console_impl=qemu
>  qemu_machine="vexpress-a15"
>  qemu_binary="qemu-system-arm"
> -qemu_extra_args="-nographic -m 1G -net user,tftp=${UBOOT_TRAVIS_BUILD_DIR} -net nic"
> +qemu_extra_args="-nographic -m 1G -audio none -net user,tftp=${UBOOT_TRAVIS_BUILD_DIR} -net nic"
>  qemu_kernel_args="-kernel ${U_BOOT_BUILD_DIR}/u-boot"
>  reset_impl=none
>  flash_impl=none
> diff --git a/bin/travis-ci/conf.vexpress_ca9x4_qemu b/bin/travis-ci/conf.vexpress_ca9x4_qemu
> index d07be2b12984..b5ed72934c3a 100644
> --- a/bin/travis-ci/conf.vexpress_ca9x4_qemu
> +++ b/bin/travis-ci/conf.vexpress_ca9x4_qemu
> @@ -21,7 +21,7 @@
>  console_impl=qemu
>  qemu_machine="vexpress-a9"
>  qemu_binary="qemu-system-arm"
> -qemu_extra_args="-nographic -m 1G -net user,tftp=${UBOOT_TRAVIS_BUILD_DIR} -net nic"
> +qemu_extra_args="-nographic -m 1G -audio none -net user,tftp=${UBOOT_TRAVIS_BUILD_DIR} -net nic"
>  qemu_kernel_args="-kernel ${U_BOOT_BUILD_DIR}/u-boot"
>  reset_impl=none
>  flash_impl=none
> --
> 2.43.0
>
