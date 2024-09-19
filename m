Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94182CF3943
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ECA7891B7;
	Thu, 19 Sep 2024 16:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pq3XgY4J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAB97891B5; Thu, 19 Sep 2024 16:09:55 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4ACC89192
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6c358b72615so7311636d6.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726754993; x=1727359793; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l+FSqDIXh71L+ct8rXnrsVZVlcz93TZNmPlPVtD51dI=;
 b=Pq3XgY4JCm1wjaOqbU6AJ8yA92qf94IjGUU9pGeTEYjvEymK2/wSJYABuiHVg+t6sv
 EuFaNaYxGI4wmLdiioIjTycKRrq/zu9GooTSNz2cpniM1/mWKYKk4M/XbYafYwofraH6
 uwptJSnsw5dd676Uh0fDjpUgLBpg7brx47OeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726754993; x=1727359793;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l+FSqDIXh71L+ct8rXnrsVZVlcz93TZNmPlPVtD51dI=;
 b=EFEKKGP2GbnC7pNfL3JibfJXw/DqrMcGppc2laaw+7Zhac2HV9t80421GvqpJjN4zb
 EO+3usv8Ep6gteC+n6MrrYo5IzpTSb78tAjZnWEtepqmxrLV/9285bs6HPayNkwbBLi/
 Pr63iszQb2Lhd8jMZ2eKXsq2Ejs3xedFIJ7XYJsGIFFetfXAHceZ/Jga5tatZxNr/HGb
 JRRh4Rl6G5N8tVqh2aX6xnJqDGm7FVNIKTaM7CQ+UvVu9dFWoOHNeXElqkkDM2tvzxGd
 wjNhHAdgMqjVKYJ1ylSPZIfLvA8pI33x2QD/iJybXP4pG8zUgyACkbR5Ytyl56U1HyY0
 zmPA==
X-Gm-Message-State: AOJu0YzWAO9ZD95q2WIrWzbsxulWOVDS79imuLOijKlEPjvy2IBrSRIF
 9vOiNk/e/YBdeqAqApuQwx+uFwErgpBmjRtJgVSN/ps+J3WfG098cMUF6G7713uFtTQKnq/0V8k
 GvhcwXrCBVAptDOF6Psa/TA+vW9SATs2Ie7TKzL6SNvjfVYrMECQa4o0=
X-Google-Smtp-Source: AGHT+IFNZpOUwJR5C1awi04fJO6hp7LatQoG8OmcmjMhVncXjibCffqBcw7/Y8hSx70+8CSDsfxZS4n2UwseZs7TVMs=
X-Received: by 2002:a05:6214:4a89:b0:6c7:5e3c:ed4 with SMTP id
 6a1803df08f44-6c75e3c0f9dmr43816106d6.32.1726754992584; Thu, 19 Sep 2024
 07:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-23-patrick.rudolph@9elements.com>
In-Reply-To: <20240918152136.3395170-23-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:09:41 +0200
Message-ID: <CAFLszTje9cRMsrQW9DsPZY1FTxZ8t=bU6z5mO_XxfEwTH6Pxpw@mail.gmail.com>
Subject: Re: [PATCH v4 22/35] drivers: misc: irq-uclass: Update
 irq_get_by_index
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Patrick,

On Wed, 18 Sept 2024 at 17:22, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Support reading the "interrupts" property from the devicetree in case
> the "interrupts-extended" property isn't found. As the "interrupts"
> property is commonly used, this allows to parse all existing FDT and
> makes irq_get_by_index() more useful.
>
> The "interrupts" property doesn't contain a phandle as "interrupts-extended"
> does, so implement a new method to locate the interrupt-parent called
> irq_get_interrupt_parent().
>
> TEST: Read the interrupts from the GIC node for ACPI MADT generation.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  arch/sandbox/dts/test.dts |  3 ++
>  drivers/misc/irq-uclass.c | 66 ++++++++++++++++++++++++++++++++++++++-
>  include/irq.h             | 14 +++++++++
>  test/dm/irq.c             | 15 +++++++++
>  4 files changed, 97 insertions(+), 1 deletion(-)

Is this a new patch? I don't see a change log so I am wondering if I
already reviewed it?

Regards,
Simon
