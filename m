Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B0CC5ACB3
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2E8787083;
	Sat, 18 Nov 2023 18:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O062TygP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BB4487103; Sat, 18 Nov 2023 18:59:18 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50E8986F1F
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:59:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-daf26d84100so3052927276.3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700330347; x=1700935147; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+ynffNwnLIaxtgXVCStI6WnnK5FHvt2m6FmiUTFCR1A=;
 b=O062TygPjmm6wFncZCbnKn/rGmKbLalsVCwJAFIzUh8Fr38R8SKZSfJzBugHhSNLUW
 9hbqeC1B0Ti1LUkq0XZpoWQ9wZHrBQRZOF9W4LC4TrNj5fuhtet+rj6dv6HGKTP0kjUw
 tXqfiJS45j5ESva9pd2giRrsVpBkdNTdDHCkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700330347; x=1700935147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+ynffNwnLIaxtgXVCStI6WnnK5FHvt2m6FmiUTFCR1A=;
 b=SwuVJv2h3HV7f8axWOtF2RJakPmRqkfSIfiVo6LCJSd9hb6kv0xGzaDrx8hloKMGjF
 1Pg07pjoL1J0UOJAhcdl1+P3DSAokFcW2O58AB0VQwHguej1krqMaBkrlPF08XuUIO9f
 7XC1uCgau/7Kh6G2DZ/SmbXqcbLIsJ1FMNjKBJqZRl2ftHbKp3Avm/iPdht1GNWgytr7
 9ywAuGz4NB2WG5Wq6/yrTO3Dz3DCn2Uoso1FIHrOhqdCfoCMGIGhc9ut8qxTBq/3bb7U
 0VhAtw9T6rMCZpGzefpyTE9qW2Ngag7+BBYVQN0VC/kvyUj8K5xHwpXJiny1xh3ibQ5h
 1HDA==
X-Gm-Message-State: AOJu0Yxy1b7FpUg3ajrLhDAUd2d/zU3z7PRokyWyhvRSEiLgsLSeZ9QI
 0zncUSHb4tWkQJptWDDeO1d2y/b06WheRTu/JaXOgQ==
X-Google-Smtp-Source: AGHT+IFzaQ1IO7aCdOQ8dwXAwFd2uu0PERBk9QyJWGmXaFfLEej2BZIcC9CSBGRHp4BguvlbtdYqRssoI5gfIhFP47k=
X-Received: by 2002:a25:d84e:0:b0:da3:7764:41d0 with SMTP id
 p75-20020a25d84e000000b00da3776441d0mr2863977ybg.31.1700330346778; Sat, 18
 Nov 2023 09:59:06 -0800 (PST)
MIME-Version: 1.0
References: <20231116092928.21633-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ27mmK9BYE=rbGKGe9=xvZdG9reU659n-0D_wRfNemX5Q@mail.gmail.com>
 <3dd07df2-a261-47e6-9627-34e4529584c4@canonical.com>
In-Reply-To: <3dd07df2-a261-47e6-9627-34e4529584c4@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:58:49 -0700
Message-ID: <CAPnjgZ2kFYiQuwzw5GP8OJteKhhGVRqdnNtAGY5v-C+3c-KZ+A@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: create memory reservations in ACPI case
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Sat, 18 Nov 2023 at 10:34, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 11/18/23 18:10, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Thu, 16 Nov 2023 at 02:29, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> ACPI tables cannot convey memory reservations for least ARM and RISC-V.
> >> x86 uses the BIOS E820 table for this purpose. We cannot simply ignore the
> >> device-tree when booting via ACPI.
> >
> > Why is that? I had thought that we had to use one or the other. Isn't
> > the devicetree irrelevant when booting with ACPI, so we can just drop
> > it?
>
> Linux Documentation/arch/arm64/acpi_object_usage.rst, line 718f
> describes the mechanism to convey memory information as follows:
>
> "For arm64, we will only support UEFI for booting with ACPI, hence the
> UEFI GetMemoryMap() boot service is the only mechanism that will be used."
>
> With the patch we tell the UEFI sub-system which memory areas are
> reserved (e.g. for TF-A on ARM or for OpenSBI on RISC-V). This
> information is inferred from the device-tree. The operating system will
> collect this information by calling GetMemoryMap() immediately before
> ExitBootServices().
>
> Without the patch Linux on RISC-V using ACPI crashed when illegally
> accessing the memory reserved for OpenSBI.

OK thank you, I misunderstood it.

Reviewed-by: Simon Glass <sjg@chromium.org>

Perhaps someone could convert efi_carve_out_dt_rsv() to use the ofnode API?

Regards,
Simon
