Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C86C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12B8A84A35;
	Thu,  2 Jul 2026 12:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NKLQqW6j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D43C84A38; Thu,  2 Jul 2026 12:27:04 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6144784987
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-698acd36d67so1085761a12.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 03:27:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782988022; cv=none;
 d=google.com; s=arc-20260327;
 b=C5For1ieMq/kK34HE/CdW8+HXzN8BV3HNinxfVkokZuVpnysUxb2C5/XB5V+q+yDp3
 N63s/5gp3BmdlHAuS6GZ7MtOeP3TtuPhYRLyC59Mo/teHBJEfnXPL0vTpPdHndN58pmD
 ICT6MOrXHxXmQ42inFqpAywGBoOfk6Lp1UPvjhsAakyueumVOqfCXQ9OpSc+YQ+i7pU7
 bBj6mOptZLkm/I9ScfOyOzviL/4Ccg2hDqIJ7bB9bBN2K+5U4vqabgfQXWnOh4oOAeMb
 gbA8dHZp9L0WFkSDPEijcKBFpn/NXtroQs/JENB7eAeYNEC5j1Ys3KB77lEXZTXgVLzT
 d6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XOTw3k4DAHeefBH9zYhhQ05wHtZJcRESxlCICfW6F+c=;
 fh=OqCZD9h/X9iz1FEoGOApxQwRgv4sUc4gLfnTdEpK8FQ=;
 b=hinjpo9iadSMeY7dcTw638p7/Gq5H7qaEWnwYIK6zxK4bkwCJTb9tZVeDmWJ9ZeW8b
 ulIgBXSEZfCGp8QYzgFWRvCrlzfaV8BQqUnSX69uzGjuxzjqPMNaOW4L/6g6mVE1raIF
 NHer2qHqUbYQWBupQSI9JpNvG+Q9kE/beJXlfZ3+t6ye4KJM4gKszIrc2BJjRnFwJExX
 ewOak+FQkR8Nm4goET4ZduL54il0dH/7tyGcJFUmdXe++4PIU7j3AZIRpvuDeCD+2qXd
 h/K/6Vw2dnuMlOSKridQ4ua208RfLwGtunmU1FuXhEOOpSGeGpblgs0eznkokEjX6XcI
 v/WA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782988022; x=1783592822; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XOTw3k4DAHeefBH9zYhhQ05wHtZJcRESxlCICfW6F+c=;
 b=NKLQqW6js4k2ABk99QE0jeXngLbCKHP/2+5QRZ7f3vq1rJzH4/xkqZS6t476f7JFys
 lrfLxpzBdFCBAMpaWHv5iJN6BuK9zZZne/tPiBZxMk05RSh8UaDaxM5HrT6MNBzTT/Rf
 g/O91qQ62KRMR2/ioP7Fip5W8/cNfQ9u+Rm40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782988022; x=1783592822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XOTw3k4DAHeefBH9zYhhQ05wHtZJcRESxlCICfW6F+c=;
 b=gIwGURSC42a3XHrUrfL9Z433flVgXc2IbZ1u98mVW9k7yZN3cebvfzENRXN1SGHGld
 ioxe9ck4FUkhkNU9gXZE9fPPh/pVV1FeNIgbo1IQN1TqG/0UHuVpzXYmLaD+WxIeTDPa
 znf9iv1aqSAgF34fQt1EUZzlxtQL+AOXcPppL8dVyPmli9IB+YdNgOMtd42Wiq0Jhiu6
 VT1RKMYGvvKxkn/UfX7YoK7MO/F60z4rf4K6OONfwSYdirdF/eSpNOuJ6mrFbRc96Hnp
 K1bBkBEAMIYEe0XAlGCQLi9QunJSo4zubJKsSJxw3S4a7XIxhk4Y4xRm/3AuE/fb5cgr
 JizQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr4C9u8KDEHrt4vNA8pOVz8PXKmh3hA5Y1TcI27lo3rjurptD1srRjyNKey9Z6i5xJra0FgJro=@lists.denx.de
X-Gm-Message-State: AOJu0YwJ3o3bor0NCpKkIHqeQDP8RDAkP4B8vczjP+K5IHci1930WNc1
 rkUFlpHUV3K81TsHKi26qPNP1yU8ShBj2IPRB/uwBkNpQncGwmeOP+3q7EaAAgfcQtisv9+LFe+
 WQMvuer4DpiYoer4cnz9gt8NQ0X/TN2AgfMREz5Ft
X-Gm-Gg: AfdE7cmC0MFpsvo/e9MtnsbhKQ9SQcxh97/80VujjBKPRQZxI1EPDyXqDdiIvEki3Er
 hYvBVxz1gIeuLtT3plNqObjx7VkRhbFvb63MJBek/xc7nAGYB6Q2TNZVxPiwHkiSjgFUVscimNU
 kVDl2oNQQpr3d8ukYcvhSsqlAL93aUSQm06aFXMcGOSYSq9JFdIst/XHpj34mRT2aG2ihqJxDbK
 R+0Uo4jUEH1rZk+W3nwWJGHTwN1Bs0ckH9wrIuSHYhMgOQXZaYYm1cuOtnK50uPQtQFPHBG1Q==
X-Received: by 2002:a05:6402:2747:b0:697:cec5:d056 with SMTP id
 4fb4d7f45d1cf-6989f25f646mr2260663a12.0.1782988021882; Thu, 02 Jul 2026
 03:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-13-me@ziyao.cc>
In-Reply-To: <20260701111808.870705-13-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 11:26:42 +0100
X-Gm-Features: AVVi8CdL2cKSOiK25WGl01TdAeP2Cj6Uj2pDYkRLPWCq3iSVHB23Ko9hsTD3m8g
Message-ID: <CAFLszTh5vei426TaqWxa0X6Sh0YhGdtb6sVN-duKAOcg7wib-w@mail.gmail.com>
Subject: Re: [PATCH v2 12/16] cpu: Add loongarch_cpu driver
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
> cpu: Add loongarch_cpu driver
>
> Implement a driver for LoongArch CPU solely for gathering
> some information bits from FDT and CPU level config registers.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
> drivers/cpu/Kconfig         |   6 ++
>  drivers/cpu/Makefile        |   1 +
>  drivers/cpu/loongarch_cpu.c | 148 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 155 insertions(+)

> diff --git a/drivers/cpu/loongarch_cpu.c b/drivers/cpu/loongarch_cpu.c
> @@ -0,0 +1,148 @@
> +static int loongarch_cpu_get_desc(const struct udevice *dev, char *buf, int size)
> +{
> +     const char *cpu;
> +
> +     /* We try to get CPU name from IOCSR first */
> +     if ((read_cpucfg(LOONGARCH_CPUCFG1) & CPUCFG1_IOCSR)) {
> +             int i;
> +             char vendor_buf[9] = { 0 };
> +             char name_buf[9] = { 0 };
> +             u64 vendor = iocsr_read64(LOONGARCH_IOCSR_VENDOR);
> +             u64 name = iocsr_read64(LOONGARCH_IOCSR_CPUNAME);
> +
> +             if (!vendor || !name)
> +                     goto get_desc_dt;
> +
> +             for (i = 0; i < sizeof(u64); i++) {
> +                     vendor_buf[i] = vendor & 0xff;
> +                     name_buf[i] = name & 0xff;
> +                     vendor >>= 8;
> +                     name >>= 8;
> +             }
> +
> +             snprintf(buf, size, '%s-%s', vendor_buf, name_buf);
> +
> +             return 0;
> +     }
> +
> +get_desc_dt:
> +     cpu = dev_read_string(dev, 'compatible');

Please drop the goto - it jumps out of an if-body to a label at the
same scope. Close the if-body when the IOCSR read is valid and let
the DT path fall through.

Also, snprintf() can silently truncate if size is smaller than the
composed string; please return -ENOSPC in that case, similar to the
DT branch below.

Regards,
Simon
