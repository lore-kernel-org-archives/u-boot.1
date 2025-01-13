Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4825C02180
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 20:04:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1814D805E9;
	Mon, 13 Jan 2025 21:04:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iV8fdk5A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E23B805DA; Mon, 13 Jan 2025 21:04:07 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2718805DA
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 21:04:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so683181166b.0
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 12:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736798644; x=1737403444; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N9/gjK9nmUsctnGdHbeHagtoHbs2bLjBuYWNmWBO/1A=;
 b=iV8fdk5ArBr4vp1Lde4esyiTT9owL2WVUtiM7uCOqc/7Pn3YAG+soj9FPCMz6dg+Qa
 tGC4ycbK74FFwyyXfadqqRiIiRxXX8k+xbtZ8gHGeBCTdmwx2z03Qirim0dUPoYXqMS6
 1mLkfzESbr0dA1SM0a77ex8jJJYaLPSZItZZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736798644; x=1737403444;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N9/gjK9nmUsctnGdHbeHagtoHbs2bLjBuYWNmWBO/1A=;
 b=JnPAPhuosqm1IuxABIqcnDGE2bJpo3C8jU+WJ9XtE1qA3SJTKT4rDQLKWTcNi50Pp0
 js/dTlhVl3vIeIeRjrbhsnHP1gS6Rh3KCXc4DU9TgEB/xldt+/6zbdgMG/R2///CfHfT
 oWiHCRonwOCKwbWJpR2iBMfHkjGCH3i8tmiouZy3a9nW2LYxnMd2d0+HWW7STxiX3m9z
 Wdm+uvAzNg49Ymqlztc9fVjUQfDiEobboxNGmQCEcH+HJLeAGIMCrtrCKd2x7sQV5dRA
 ioqoxItj2G8xzs8ilxFyi5DNkLogFhCEyqN5C1ZYz2j2sVKALUsYWFeqZ8b7gg8v6Dos
 8skw==
X-Gm-Message-State: AOJu0YypUKCt7FdbKnBX56Mhqw980u7ppUGELme3FOWSgdTOi4Q6xvW2
 kUHD+RGEGfeQg8OeAakoO5gecKY8sIya3ByJBCPE8cNwdjDuqPTPL3eXEDC+Gi2dcqWRbRM6ewa
 i4OOdC8p4HY59Qn2qWUQU/R2xsSVbu+1+Soun9SNyiCQHyWBt7Q==
X-Gm-Gg: ASbGncuXxol2HGQZ2LNgc6Upoqb7sDoiz4hgLxptZdY3HGEVG8YLzXeWRDIut0Z3kCE
 FuUykmb7u2oXLkFEcU6EB/oGRycvCQ3qOwOX1nkM=
X-Google-Smtp-Source: AGHT+IHOUs8Ye2jsTKn3AiKJFfEH2vWPWy+poPvszU1K1MBe2pEWH1YCn2+L8MRwLi6U7hgGu4/NKMC57W40gWrmEFU=
X-Received: by 2002:a17:907:7f08:b0:aab:9430:40e9 with SMTP id
 a640c23a62f3a-ab2ab70a84emr1981933166b.32.1736798644199; Mon, 13 Jan 2025
 12:04:04 -0800 (PST)
MIME-Version: 1.0
References: <20250109123010.4005298-1-sjg@chromium.org>
 <20250109123010.4005298-3-sjg@chromium.org>
 <20250111225433.GS3476@bill-the-cat>
In-Reply-To: <20250111225433.GS3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jan 2025 13:03:52 -0700
X-Gm-Features: AbW1kvb2dJ4teOdFn2VagdJj1aaerH0vIDs7ELEHecBZzYQHj64bbPM28NA3cjg
Message-ID: <CAFLszThO9BaSi8R8=3FpLq7Nnx7XdiCungY1vcRfKyfFQ0baJQ@mail.gmail.com>
Subject: Re: [PATCH 02/15] vbe: Split out reading a FIT into a common file
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Sat, 11 Jan 2025 at 15:54, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jan 09, 2025 at 05:29:57AM -0700, Simon Glass wrote:
>
> > Loading a FIT is useful for other VBE methods, such as ABrec. Create a
> > new function to handling reading it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> This causes a bunch of growth:
>             a3y17lte       : all +1328 text +1328
>                u-boot: add: 8/0, grow: 1/0 bytes: 1328/0 (1328)
>                  function                                   old     new   delta
>                  blkcache_fill                                -     332    +332
>                  blkcache_read                                -     240    +240
>                  blk_read                                     -     188    +188
>                  vbe_read_nvdata                              -     156    +156
>                  vbe_read_version                             -     140    +140
>                  vbe_get_blk                                  -     100    +100
>                  simple_read_nvdata                           -      96     +96
>                  crc8                                         -      72     +72
>                  vbe_simple_read_state                      108     112      +4
>
> Which is unexpected for just moving code around that's not newly used.

I hadn't noticed that on the boards I was trying, so thank you for spotting it.

This is because it now uses blk_read() instead of blk_dread(), so if
BLOCK_CACHE is enabled, it will use the block cache. We could disable
BLOCK_CACHE on those boards perhaps? It is a speed optimisation so
shouldn't be used by boards which care about code size.

> And even when it's just a move it's still growing:
>             xilinx_zynqmp_virt: all +128 bss -72 text +200
>                u-boot: add: 4/0, grow: 0/-1 bytes: 540/-340 (200)
>                  function                                   old     new   delta
>                  vbe_read_nvdata                              -     156    +156
>                  vbe_get_blk                                  -     148    +148
>                  vbe_read_version                             -     140    +140
>                  simple_read_nvdata                           -      96     +96
>                  vbe_simple_read_state                      452     112    -340

Unfortunately this one is hard to fix. As you know, whenever you take
code from a single module and put it into another, the compiler cannot
optimise away the function-call overhead. I'll note that there is no
increase when LTO is used, e.g. with xilinx_versal_net_mini_qspi

So let me know what you think.

Regards,
Simon
