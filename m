Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2687C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34158849E5;
	Thu,  2 Jul 2026 12:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZsFU0P2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A24BC84A0A; Thu,  2 Jul 2026 12:26:06 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B373684987
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-697edb1bf6eso2386071a12.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 03:26:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782987964; cv=none;
 d=google.com; s=arc-20260327;
 b=CSBe1+YW27OTCfI8BiZafCYF1kL+0Cw9GX3zI81Bxx3rM6MAXNx/b3F9dQgr47j/b/
 3xF1Fex6p6FEcigCugfr7TDW2w7GwUF2RF7c2LO4uNVK7CD4SuzNT5Jtpi+8t+9qdd8u
 VUllWFMbKXFBGLjHFBS36NGef5RAoLbxyQH4jNzl3woZUGjZyHSVzSRGphnH2AhOpsM8
 9q2Q/tKvozfdROj8H1aFtnLBgb5d1SKCRFWaaaTDwKdmj+N2V4kNNU09/Q1xoX7MrB12
 aSsYCFXDyM8BszMMGDxKUftShW1HWkkRP7DoKsTEjV6EDTz3vmqIQADPnGOjYKBprhhP
 uVLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7aMvO5Svxa+YUrwzw/TvgLbam8QxoUX7DqsusiBlXsg=;
 fh=Fs/yyZYTc5Q14i8w3xRC+KkXRdN8vLyIaSM/gOobswo=;
 b=pIFRoeWFYkExYYinuvlYkBronDm6a9dYTr+qEuX9GChYOx31PC60FSD/7jUkpGHwaS
 hPwo8IMJLcjymBxeXQm3CgqBrLOSMu8iWX/cgjFyOYCv+mpRxquFBVyldJtkG3e19NtB
 qG9pavWzikkFoCsfMu388iGLwS5BntX9XnqAsFGgT4HCTuos/M4ztcovJWyMaPsIhZei
 V8mfHRoRzoz61dVU7J9j14HzxKPI46Ec10363Bt0nvE8dDLA0oSKNARHYHvyI1eAwQh4
 ZDexO8teSsmrRTaicztxXPsQlOcWT7GU1hKpm+l5ofa+SDtkFKsqNbLBvbFX7b/FhsfZ
 CDFw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782987964; x=1783592764; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7aMvO5Svxa+YUrwzw/TvgLbam8QxoUX7DqsusiBlXsg=;
 b=ZsFU0P2XikPAT06tEKWO3DiNRxQIuHepjvL+HJV1quL9PfKTQw52iMI93sm5RTldKo
 4TYu6iMQbKJQVt3x2COriwM6m7b02HENVuLnFfH6CvHuteMXYRasOEvFqdVd3ni9C3yL
 18au1tC65WUBPw/NgipDL87SkXyLTR1u1gR4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782987964; x=1783592764;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7aMvO5Svxa+YUrwzw/TvgLbam8QxoUX7DqsusiBlXsg=;
 b=XSlO7JoXGEhI4h58zgeYMIKCoF4LsEyAep1XEosBr8vHU7KemQZDRIEaB9hdhLuYW0
 fylw4NWktE37ltVO9sWIKmovmc6Alf2tkZ+tr89fj5lBxfHNPd5s/XD6BFcfzTGpaq9/
 s6Nlt0WMoIff4X6fisIMbm2tiXXyWBdhLukr9H9lYfIinu2PcAR1GONhccpLOYhoRkN+
 pdIWGOVwGyFezo481JMwJdrWQpaRq0pmsA88gw0frn+ZTfpLOr8eDWR9Sj3H6U0f1Uq6
 kMVv1CDdwXbTgHCMdQzetPoUpo/DU7lIGu6eTi2Qs/gzm5P0KingpVKFk1wiCW+DyNAd
 U+fQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rojw9UxVgk2EWGzCi/ptStktYYwAInlIPhk85Bw08NlfAXwWsk3VGAd+8xbaiAwrod4WUJrnZg=@lists.denx.de
X-Gm-Message-State: AOJu0YxPXoSfPbUXA4oN/RFZYFoTt86geW86V0b4Sgkbrwvtrx/ZjkTA
 zwcWQMaRrIsRgF/+IU4asfJlPKrY7xCdn8U0umIyKe5/Rv1eWRkT+NSX33WBinbBbWU6z7HNn5O
 +kuG+rcmsYtY4qIVLfJzdSYSKTkD9LVuq1McHAiqJ
X-Gm-Gg: AfdE7cncJSRmbKybyfPS5VL0OssLzxd4V7x+NDh5M2OmxzXD4bsd3760C82oMBUGo7P
 TVo7AFRBZiytbAyccFgQwaqvHhemqhFB0lb8JewUOxit1V43WXnPyBWlXyAzVCvBUn8Pm1KvrlE
 KYRuWoT9cu9K9xoQgsVOHDafP22N9yDjoUq16MHnnWbCvYluX/YNTm7MRm0AEu1onN66UBbfEfv
 UgUZqImYhdljXi32xjhl8oSwKxvqIFVbR+Qy7UR//Xq2CHJA7hhUlAaF4yjfgZwtb5xRG4EIA==
X-Received: by 2002:a05:6402:530c:b0:697:f686:80c7 with SMTP id
 4fb4d7f45d1cf-6989f3664e9mr2147117a12.26.1782987964198; Thu, 02 Jul 2026
 03:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-10-me@ziyao.cc>
In-Reply-To: <20260701111808.870705-10-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 11:25:51 +0100
X-Gm-Features: AVVi8CdYt69yVt5VWJrJvcwqHPfjqEWjPuZDVwYBAr_pgm1mjYnBpsSocgCMBBY
Message-ID: <CAFLszTjqWtXVTixyX6hqrzsyqy6A0VzDH6fGCKB_APQ0ODoRqQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/16] LoongArch: Exception handling
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Jiaxun,

On 2026-07-01T11:17:53, Yao Zi <me@ziyao.cc> wrote:
> LoongArch: Exception handling
>
> Add exception entry assembly code, import stackframe.h
> from Linux, provide debug prints when exception happens.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
> arch/loongarch/Kconfig                  |   3 +
>  arch/loongarch/cpu/Makefile             |   2 +-
>  arch/loongarch/cpu/genex.S              |  21 ++++
>  arch/loongarch/include/asm/stackframe.h | 175 +++++++++++++++++++++++++++++
>  arch/loongarch/lib/interrupts.c         | 189 ++++++++++++++++++++++++++++++++
>  5 files changed, 389 insertions(+), 1 deletion(-)

> diff --git a/arch/loongarch/lib/interrupts.c b/arch/loongarch/lib/interrupts.c
> @@ -0,0 +1,189 @@
> +static void show_regs(struct pt_regs *regs)
> +{
> +#if IS_ENABLED(CONFIG_SHOW_REGS)
> +     const int field = 2 * sizeof(unsigned long);

Please use 'if (CONFIG_IS_ENABLED(SHOW_REGS))' at the call site (as
you do for FRAMEPOINTER below) rather than wrapping the function
body in #if - that also lets you honour SPL_SHOW_REGS.

> diff --git a/arch/loongarch/lib/interrupts.c b/arch/loongarch/lib/interrupts.c
> @@ -0,0 +1,189 @@
> +static void __maybe_unused show_backtrace(struct pt_regs *regs)
> +{
> +     uintptr_t *fp = (uintptr_t *)regs->regs[0x16];

Magic 0x16 (= 22 = fp) is hard to read. Please use a named constant,
or add an fp accessor / use the regdef indices.

> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> @@ -30,6 +30,9 @@ config DMA_ADDR_T_64BIT
> +config SHOW_REGS
> +     bool "Show registers on unhandled exception"

Missing help text, and please follow the RISC-V pattern: default y
plus a matching SPL_SHOW_REGS entry. Otherwise the default on
LoongArch is to hide all GPRs on a crash, making triage harder.

Regards,
Simon
