Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FFDC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 19:15:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDFEE84BF6;
	Thu,  9 Jul 2026 21:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IkvHWuAC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2A7A84C12; Thu,  9 Jul 2026 21:15:06 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D207E84B3B
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 21:15:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-697cee2eb6dso177306a12.0
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 12:15:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783624503; cv=none;
 d=google.com; s=arc-20260327;
 b=GhzubAztH2Z6Qi7Kd1VpFszTdxyljQ3UTDtph6ydYQlqjmmbtcYTy6XRfj+qnoW1CL
 AYG/t93fmZrhbWOeLOOd9GUOHSr0tTB95AP1j9KsiXP3UdNYf4Fje++G3aoJGsXxAQ52
 HeAm8FiITbAoh0iZPfrhoUNZNZRKJ82+NKr+ayzNxuVpEkEAeRQWgGzY3V+Z0TKT5hbA
 5rscstQ+9dbJAUJGFD1gICJICg7zxQAB5OVWVNQT77vlD1LuTh3g/bOhmrVZvv4E2Un6
 vUZRamUGF2VQsGEnigsmenjRuZMdmBMe087DDIzxMAYWcS1LRH950JF6/KkaMybKq/1Z
 SnDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rYYpBxCh4ny8F52KTAuXB/Wms4oC2OWRbEATraoCvPI=;
 fh=hTc112njtTUhHSTbtn3jeYGU2Zeva3vqsduPgc33LZ4=;
 b=UNfk8wQWaUjCL9dGJNgMmsudkGfy+rapJe41g5DVcFYCRJDvcz5o2TZhn16v3SaxvJ
 vn/guELqc1d36BWkcKmjE7AB8pNXBhPut9myRd2FEvMqUPRchm7K+Yui42OGxdKkYYVG
 iMMCmWHq3lxlcNl0T268si2pkV9PDyuOlzQ4cmoVxMqmWCe4dPmYyABlYEOK21KtMmU5
 tF9nYsdgkxHcsGQCwumBXG8V23TTsYQPzen/TBxEk3vX5qJjlWUf3dqVXU9Fh8teNS65
 k+eWNOGEO4xlFL5jiZOJ3WqXxliUVX0VGt34wVGQqa4y8fbJ/G5pP4SSxhEiRcix2W+Y
 8gLQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783624503; x=1784229303; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rYYpBxCh4ny8F52KTAuXB/Wms4oC2OWRbEATraoCvPI=;
 b=IkvHWuACWEcY9PPPE1FgRnFdGCxOYKdiAIZ9Acdp5oC386/9QqfdY1E1rXDK8/VW+/
 JOzTcLM17TaVBd03Qp7K6+PR2qs9sjsZ2B751kwNuklFT/kuyy8sYFq2kAaCvBDMioNh
 FUMVbZUg9JvrXPn8ZXLpDQCLdi+NsDsj+Vqx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783624503; x=1784229303;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rYYpBxCh4ny8F52KTAuXB/Wms4oC2OWRbEATraoCvPI=;
 b=hOLa4CCFUuCamXGZ+a5ukx0wb9Hvit0fGuT/jVRdPOwH7+oHyBrSDg222d0zn4vBIk
 XsiUUh80QhKsLY6+jg05TrPfKFG+tiCyn9PHImmmsbwHkdjEKAT/6FErpGBHrwuszf5x
 iURHLQn2OicSitFZPzojr/H5l2xZ/EeCdbdn2JNZGM9NuP1FZ1ciUpodd3xTxgGiDPMU
 CqQLrgVPsPw2mnISfa2owwLsYaslPBh/UWqFT5u98CcDtWGRWxewbIgcBZcmVcdOgsH5
 Wwn1OgQHx41abdg5oGUgSbj8Rj/usaVulYH0wH5LjGuC7xUIxxeLu132jVeHvANhGIp0
 Ygxg==
X-Gm-Message-State: AOJu0YzXTTrMx3DFqHP8BliY+Po7/DtKaUG0r8g4sCvGLqWO4FOjdulM
 /dVTPSyM4D254KZQPP8a/iTf3bjtw7b8eX1w/OuO8R6trYK5MXYQ5wpQMXRQ31Skfyeow2lKoAP
 QwUm6jpT03KL5y3tY//5VjHByHOT1Gr1aYNf2xJbh
X-Gm-Gg: AfdE7ckwnHztJIveUvKMPRSsLEvZMBKvhhx6PSIyqLUCvU09A4CrY0OA56kAypq8vHM
 BzBrcvuUbFc5F+TDvLU12z/jpvJ/cH7LBSC6myeeE9Nz0Vb1UTqY1BK1qBvtESQe4Cn4AY3MBS9
 YLNbPg3WYMG38rH9VViybW+dsu7IrtUDCmU3XzvqVqp1Pw55mi1c+UZwnwP8PsvxnOzKb7L3q/l
 dFUN1QYmnseiho3RUpr1nDGPVUcEHmxsiKxGxMZHdCaJWDEghrO9ICurn9wue64nvOjVLw=
X-Received: by 2002:a05:6402:3595:b0:69a:2ee6:4c8c with SMTP id
 4fb4d7f45d1cf-69ab4453e35mr3473591a12.4.1783624503215; Thu, 09 Jul 2026
 12:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260705145445.2339-1-aristo.chen@canonical.com>
In-Reply-To: <20260705145445.2339-1-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jul 2026 13:14:50 -0600
X-Gm-Features: AUfX_mytrLYF6kaNVVayoyny547dExnumxsgUZhQU6IsBUbbTyk2SJHoBxns7tI
Message-ID: <CAFLszTj9vKSrv4L98rLWit32uQYX4=F2gMcE-PjVSx3kJQTmhg@mail.gmail.com>
Subject: Re: [PATCH v1] bootm: teach handle_decomp_error() about the noload
 decompression buffer
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>, 
 Daniel Golle <daniel@makrotopia.org>
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

Hi Aristo,

On 2026-07-05T14:51:22, Aristo Chen <aristo.chen@canonical.com> wrote:
> bootm: teach handle_decomp_error() about the noload decompression buffer
>
> For a compressed kernel_noload image, bootm_load_os() allocates a
> per-image decompression buffer of ALIGN(image_len * 8, SZ_1M) rather
> than the global CONFIG_SYS_BOOTM_LEN. When decompression fails on that
> path, handle_decomp_error() still prints
>
>     Image too large: increase CONFIG_SYS_BOOTM_LEN
>
> which is misleading: increasing CONFIG_SYS_BOOTM_LEN does not help
> because the smaller per-image buffer is the actual bound. Commit
> 2ff26c1e378d ("bootm: fix overflow of the noload kernel decompression
> buffer") worked around this by printing a follow-up note right after
> handle_decomp_error() returned, but the boot log then reads as two
> contradictory sentences.
>
> Introduce enum bootm_decomp_limit and pass it into
> handle_decomp_error() so the helper picks the right message in one
> place. For the noload path it now prints
>
> [...]
>
> boot/bootm.c | 39 ++++++++++++++++++++++++++++++---------
>  1 file changed, 30 insertions(+), 9 deletions(-)

> diff --git a/boot/bootm.c b/boot/bootm.c
> @@ -598,10 +614,15 @@ static int handle_decomp_error(int comp_type, size_t uncomp_size,
>               return BOOTM_ERR_UNIMPLEMENTED;
>
>       if ((comp_type == IH_COMP_GZIP && ret == Z_BUF_ERROR) ||
> -         uncomp_size >= buf_size)
> -             printf("Image too large: increase CONFIG_SYS_BOOTM_LEN\n");
> -     else
> +         uncomp_size >= buf_size) {
> +             if (limit == BOOTM_DECOMP_LIMIT_PER_IMAGE)
> +                     printf("Image too large for the kernel_noload buffer (%#lx bytes)\n",
> +                            (ulong)buf_size);

You could use %#zx and drop the ulong cast, since buf_size is size_t

Also, the enum is generic (BOOTM_DECOMP_LIMIT_PER_IMAGE) but the
message hard-codes kernel_noload. That's accurate today, but a generic
message (e.g. "Image too large for per-image decompression buffer")
would stay in sync if another caller appears. Either way is fine.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
