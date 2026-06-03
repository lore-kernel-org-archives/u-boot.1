Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2119CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 16:52:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 433FD84898;
	Wed,  3 Jun 2026 18:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MAuJq0s6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52B2B8489D; Wed,  3 Jun 2026 18:52:39 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CB6C8341A
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 18:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-36bb3551f6eso5050421a91.1
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 09:52:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780505556; cv=none;
 d=google.com; s=arc-20240605;
 b=NMzKSnSrsGqJOgREXl0//ViDNl9D8eXvPCwbcVSk6Txnk7Ecv2tMxH8uu4g0KmKwWd
 ZTfxYo6uzScdAguKAYAdY9uFnqhq1QMM1jZNtkdIj9PkvLTXqNcC9M7o6lckb20JuNCE
 jcGhAvY9Yjrn77dtaADH5U5zAN5TjsRw3C5+YYs03MKr7TGoYH9LP6lfDOiwZPpmIxCU
 h8M/rbWl5OX25nvdVIhITn7COo8yjenh1N54QsKK9sZsCjeR1Gg3+4n3Adz1/+m+xl/r
 2OwN1xuv5hXYsYRRUw1A3e068qoOQ5VnV0BxmKKsDf2WvJe9YKzHPHPBFGo1y6dMVXQo
 ww5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=F5dzxX09yelGOtFYV4cRqHFojuA6ZrP/mg1xX+0YWlc=;
 fh=LViZcXv1F7BXsbOt0uYU2qXfDQtMrqhOdzDc3t8iX5g=;
 b=WctOlVSXwWECvz5pNFXOUXTUHavNEvXh7eutZfoi6STq/v3D09/rOQIv6g3laBSr7C
 LUf0ePwELjSggIhsHIWCtujGeTnxWMZ6rf+QVI6NZPSGbMI5IGDUJQoDQlxJhyLz+bp7
 SW9/SYCsqn4dhm5lX70vsijA47eL/oZ9ufVWbCZsgzdoGBp/XTrcawk71wX6P5CwoIfM
 E2ykb/4TvBwo6d0pB/usaS0uVmIPuSgoH39qiCwl9HufgEb7xWF0ctaCqbAWPi0MSykz
 /0CtEtk5sZGfgmWGaxf3Eq0ehbDPbeLhwIs9wIJChU4WVTVfcdQf5nwHmUTPEracqAwG
 2OZw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780505556; x=1781110356; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F5dzxX09yelGOtFYV4cRqHFojuA6ZrP/mg1xX+0YWlc=;
 b=MAuJq0s62RQBu9G3j6spSbcAj2SZtiGhUvJrnFU6BP7ZjwSAaeagd/VYXHtG/mChiH
 CPbmqzgpX6ILTtpmMFG1nKVhD7eZqS5eciR5Em5VO9mjmWvB1dZdDZmUoDq695BUyzn6
 7c52aFQnKVWavazV1w3CEWQlEXd2ImTosm0UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780505556; x=1781110356;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F5dzxX09yelGOtFYV4cRqHFojuA6ZrP/mg1xX+0YWlc=;
 b=iAgBLUxQSH5EJFimuZF37hwC9W4UrCT4V14FoD9oU4vTaxxArPypgd8MsMlqsvJj04
 HAEUlGdlw7qQjURygHZ7Zcoi0Te4dX+44pqGPsBvOZ96CKjSMJvb5N9NDhXp+iUdA11R
 i5/T/0CA2mbmeymuYVIQ5Z+C+2UPcj2ofUC2Nl64XCxghHYB/0B3GGNHbpnGj/DSRRmN
 SeFTu88l+qPpYQwyVAQallnNwOLqirgatzH+FNiOhgg6FHDxwLpoE/CFRpFEbtb5cEFF
 14vTJPD/Y1uIun9eSUxveMtubeEEUnTpoasn4AntT4Imr9EprBgXLJKTKLoR070wyXL/
 29qg==
X-Gm-Message-State: AOJu0YxfY2DGuoghmYWzIzwP5zCrobLZI11vJ/b4pwd8b3rekMdvkP5M
 TcW1n5ouF5of4S4ypphCkoWSYAeXRxqL1x0Il5V+9cQHUlDaAihXu4Xs5U2KUz2WbyxcoWGOp3R
 qcvjb986YVemaAOPBYG7NXyJsUD6lHA/iehet5vSK
X-Gm-Gg: Acq92OG3RQJXrfPjc2IN/VOtF3w8Z0LqmKhf8X9L1YhPTKKQDENcpGy2sXYDes7TJYs
 flSxY1tCzLRjft3ZyiukIEI4VWuK+rKgEZfct86qZLBS5TYjVyW4BduDtPZAsfay8aT5NIzYmIg
 3oG+QQRrctTr0IQcMibFUIVQGLpa6srC2oWQGDqkAkXWWDKm6wXpAqBdeNjcGSILx/JC7onU9B3
 P3PKncMIwfym2O8b7pLoUQ65E0257euCNyOtNOCZxme5ir61GAgC6JokUkIwuLvcA7SGOKx+lib
 Ex9GOJeKa+ORPMbP
X-Received: by 2002:a17:90a:d650:b0:368:7c0f:ebf7 with SMTP id
 98e67ed59e1d1-36e30e19b44mr4284649a91.16.1780505555503; Wed, 03 Jun 2026
 09:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260520044554.15373-1-aristo.chen@canonical.com>
 <20260527150637.2850104-1-aristo.chen@canonical.com>
 <20260527150637.2850104-4-aristo.chen@canonical.com>
In-Reply-To: <20260527150637.2850104-4-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jun 2026 10:52:10 -0600
X-Gm-Features: AVHnY4KxRi0POjP4tm1QRZp6QtbqxU03wcfOlzkMOazLBYto4u4k7CDBqL17W3M
Message-ID: <CAFLszThQAca_Nau6jp0Egta0_FCxL17rnuO1mm0utjy_SPTWNA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] bootm: increase kernel_noload decompression
 headroom from 4x to 8x
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Benjamin ROBIN <dev@benjarobin.fr>, Ludwig Nussel <ludwig.nussel@siemens.com>
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

On 2026-05-27T15:04:32, Aristo Chen <aristo.chen@canonical.com> wrote:
> bootm: increase kernel_noload decompression headroom from 4x to 8x
>
> For a compressed kernel_noload image, bootm_load_os() allocates a buffer
> of ALIGN(image_len * 4, SZ_1M). The 4x factor is at the edge of what
> modern compressors (zstd, xz) achieve on real kernels, so a
> well-compressed vendor kernel can fail to boot at runtime with no
> intervening warning.
>
> Bump the headroom to 8x. The buffer is still bounded by the compressed
> image size, and the SZ_1M alignment keeps the overhead below 1 MiB on
> small kernels. Update the matching references in the kernel_noload
> sandbox tests so they stay in sync with the bound bootm_load_os()
> enforces.
>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> boot/bootm.c              |  6 +++---
>  test/py/tests/test_fit.py | 14 +++++++-------
>  2 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
