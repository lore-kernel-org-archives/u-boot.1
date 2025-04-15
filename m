Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6A5C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 09:19:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6547A8192A;
	Tue, 15 Apr 2025 11:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fXBIWLfO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38C58820E8; Tue, 15 Apr 2025 11:19:48 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E832B80F6B
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 11:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e643f0933afso5069079276.1
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 02:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744708785; x=1745313585; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=817p92EDvF4U2G0rL7gZdQbsu+1DL325FWZSdYSyTvY=;
 b=fXBIWLfOeND8zP2j+usqPjqfmuR0uTNTu8pj05UYkgckXG1wWSSxgVzd4Hjm63Znb3
 5Rh313D9cyV2p3Q/6qczA889ww3volicXHGqvxmMKzCNC3Bz4G0IGvzuoLV3N10eoKlh
 OLtEgAKJ7wvRPavK7Pxk6ZPu+1EO0w6UFCWxUN3baeRqcuYhOzDIaUWBgHDyZRulhqWN
 3Sp8R/Nyf5ZdiwteJtkFIrwgyMgd7saYoiSSz+3m7nYuOIGAN08bRUbPrA8wBqEWZBd8
 x3vzpCRQgWstukRSIFR6qSs1+nF9ao30o2uYE0Lt+1X1z1ulAHEX0sdtVsQ9A0N3p/uH
 8tAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744708785; x=1745313585;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=817p92EDvF4U2G0rL7gZdQbsu+1DL325FWZSdYSyTvY=;
 b=fskyFDO1wAyLphqObJxzp/ipSAknSErIucWK271YlUujtNNifpRzUJMHl527GrC+mo
 xJ9fQI0N7vDqtBCJdlnYWW7fzXwbKNXoVMs2ZN8kk2/cZWu+hX20bYVmR2ASSk48Bt5w
 1oU6CvApPPXfYoWGrpZcoZ2JcZrMonTzhIoVWim6vE0iBX/wfGdXIsZi53GER0VwH1aX
 mi2BGwLue6VzzKno8xy4CGzAbjW1y22BfsrsoGFr52XK4VkqQ11lWStxU7Vs/ren/Bh7
 M9j8imSFqn4jpQyK68mVPgFLEbFuWS+QnSr1r7itj53+KtgS2KqoU2MoeboUMi/LLt8p
 Mi+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnGQBxobUMsdBc3Z9dW0xK5KTq9qpqHvzzYAHl2dYH09ZAXcMsW8dBLqmNOQliqa82q6y1Dkw=@lists.denx.de
X-Gm-Message-State: AOJu0Yzna5+EXdIgj0Bmscq/1VyOIWgCLiPwEtRpz3QDwsNe6ncTezv/
 GWTniK74zRnEeNNTJFYe15PJXQJcPOAcfNUnEUAwyG0xw+7r+wfYOA00e85i/aDFWkkzk5vuWjS
 ja/58OB7TUKdHR1iwh6cIERdH/TDOhqTehDvrfPZLJ9aigfeV+EI=
X-Gm-Gg: ASbGncupqhYrstkOeZW1GeOLqTjy4ATrrjVc2Ei6lHVdnZgaithl6x4LCLpEulDua41
 MaCaXmZRW7fgkkJIhCEC4G7NyQPiH8hMAJ45qtRwB//pwjvMYeOmfjC0UMmimvxgcUiuD54imz8
 sOkNbKLxzfBeAmbcApwFFI+G977ASAvI0djg==
X-Google-Smtp-Source: AGHT+IG74PToWjKX4XKmRLHBnl5r0qJckcPd2VaCB7Hw3lD9DxrFFA+8WIEHhwep4wXpTzunjFs2qM1h5zgKgpImchY=
X-Received: by 2002:a05:6902:2489:b0:e58:36ad:a1ba with SMTP id
 3f1490d57ef6-e70a607587cmr3850686276.16.1744708784714; Tue, 15 Apr 2025
 02:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250415091159.36204-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250415091159.36204-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 15 Apr 2025 12:19:08 +0300
X-Gm-Features: ATxdqUFQUHh6XYZUygM01lC_2Ni9Vb9iFvrIzbYuvvbwMExepTWX8C8-_DLb5O0
Message-ID: <CAC_iWjLK0r=XRx=7umCcCK3v4_MWySQuvwUkG8Xs44=+dzC+jg@mail.gmail.com>
Subject: Re: [u-boot-test-hooks PATCH 1/1] travis-ci: qemu-riscv64_na: add a
 second network interface
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Tue, 15 Apr 2025 at 12:12, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> U-Boot allows to have multiple network interfaces and switching between
> these. This functionality cannot be tested if QEMU only emulates a single
> NIC.
>
> Provide a QEMU configuration with multiple network interfaces.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  bin/travis-ci/conf.qemu-riscv64_na | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bin/travis-ci/conf.qemu-riscv64_na b/bin/travis-ci/conf.qemu-riscv64_na
> index e9190cb..97c3469 100644
> --- a/bin/travis-ci/conf.qemu-riscv64_na
> +++ b/bin/travis-ci/conf.qemu-riscv64_na
> @@ -5,7 +5,7 @@
>  console_impl=qemu
>  qemu_machine="virt"
>  qemu_binary="qemu-system-riscv64"
> -qemu_extra_args="-m 1G -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device virtio-net-device,netdev=net0 -device virtio-rng-device"
> +qemu_extra_args="-m 1G -nographic -netdev user,id=net0,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device virtio-net-device,netdev=net0 -netdev user,id=net1,tftp=${UBOOT_TRAVIS_BUILD_DIR} -device virtio-net-device,netdev=net1 -device virtio-rng-device"
>  qemu_kernel_args="-bios ${U_BOOT_BUILD_DIR}/u-boot"
>  reset_impl=none
>  flash_impl=none
> --
> 2.48.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
