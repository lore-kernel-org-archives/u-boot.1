Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D09C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 14:25:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89BF984C40;
	Mon, 13 Jul 2026 16:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dSj4I/nm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2682A84C06; Mon, 13 Jul 2026 16:25:15 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0069384C40
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 16:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-84847482584so2149960b3a.0
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 07:25:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783952711; cv=none;
 d=google.com; s=arc-20260327;
 b=OOQ+RjiQxmvZNofbAe+HCqnwyhG9DqzWXXT6gBc5osAB9H+i3AeuEKnNFJRFiFY9dk
 HBDPrlisC4v5GuzZXu6UJpU75R3PaPJr7jUCZTE/LlxRqtj4Mfq2QqIZ9UK515cGLO/X
 67AEnL7bqhHk3M1iHpRfGVK7x/QdKCMc+Ogdn++n3elMkJb0jBBFPK2LuQ1rb6yBFxuP
 p/e/gPSQlXUdFUjPLWi1K6YSHPZi13ptk9WpXZE7qAaXT7QVuLdwICt/rIm99PLNeH8B
 Wdx0cio41UhMSr8Nq0PobjfniixpUlZPH/x4obwd1GksRvwmyOvyPd+HDecmGFjVsMcO
 rQHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yAoO+OqlSVuIE309IJyUWBVGU0O/0KMudcGzBF9njow=;
 fh=64/PWCbL5YO6h/UuPtAzCycyVp4BM+MtGQHujwHBilg=;
 b=AGQkqtoGaxtngOyE2mCuzHnqZ5XLnR1eKkcY361sGigoK8/s/xcvb2k8P0IYzvRUcd
 a0zFOYiyp4Hg4paP/ll/ROsaoenOAGxt6ECXe6CIKIq7SLeiyURgA/MvKGdPWA0NcurU
 4tbbZWGg+X4yzpJCktpdVcqPxEplbS/oqO/ExkbRzXTAoM7aUwbhwGmObACbeKH9hl2e
 bjFl8Do+dh7nCS7Y1lo5aovc7b9Z5aohG7BkzzxRXJ33/CXmr9OXzKdCzns18sWibqLe
 jlLT0KmLZc6Yg8MYxnePxN4fOOT78L3GktrLm3q1qNRF2Ul/PvYdAML29h1/zvfUbRkF
 SsDg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783952711; x=1784557511; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yAoO+OqlSVuIE309IJyUWBVGU0O/0KMudcGzBF9njow=;
 b=dSj4I/nm/0YYzUQnSuNrDzr9/Lsd9StUOJwYRqzjRiLlW8+fDRuMy4PNuV61JBV/yJ
 PHHpdqpFLc+kTO9M68nErpP2T+GoopX6v+qYQrKmRBS8qjzWaiKtIo5qNl0HFcjNd1WL
 VKzXMnv8E5gaV9eh9Ddo7eawNf/GxLYPxPKOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783952711; x=1784557511;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yAoO+OqlSVuIE309IJyUWBVGU0O/0KMudcGzBF9njow=;
 b=ky2nt0yhtrTFLwg3TvOpJNTYfLOkk+H7cZuq/QIxry4QGPeAe2Me/IH8CBBtjxDMLX
 3ndSmRzxnPQLU5YWDNcqsZ7dPvCeKifpNVkL4jojTPg+mYeTtPyjNfZEW1NfHWnyRo79
 64S2s9p9XPVJP0p7QUlo3VFV3LQXB8VCqJVvIV/hTjf053iN+DkaU/CkBGvMphnTztWm
 +6TjGMgDXC088szF3+gt0YHvMca8UjZmqiXxuJDWibcwcI3/2DH6CxNSb73COP27wf5t
 YHNf7uym+Qd+PkD8e8bBjusr8fYCrrEI+KOBey9A3dnZWHAg8pInI/9J+IZqsr7mLcu0
 Z/cg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rri5IGLyQVISiOfjqvuf1IitnqEFgqchHBYMasyi2hFFVAupFnJU8MEEni0UGJwVX7pdvEiiFk=@lists.denx.de
X-Gm-Message-State: AOJu0YwSW/YmJy3Oob38oG/3L8Rr/l1aYxcrdjziBELM1K+PRfYTWYe/
 mWf7GfHRjS54DDjJj9K8cNiFeoWxgyGfkjuGwEn7NrprGD+A9HKmVBFa1jSWtoGZUEUXvxYLiIU
 ll/LuUV7gp+1g59TYsZqWyPOUxMqsIklmYBZZ6nj8
X-Gm-Gg: AfdE7ckGz8VY218VG1bh4dlbxgQzK4GpYrr5f0TVfBqy0cARAgaZHZprmi2YR8y+Nh9
 SL1FB0c7ZYxvb0HXY/v3wRe7aST+MMDuob1JfTpOyC5vEF8sgs3UxdMsCmyZgM51sZHkSOvK5jB
 iiCIf3AqUqzFwB158L3CFcUuAL82NGvDubwcKHl4dJk2MSycT2RQfWViybTDtABqUtvat8CWs+M
 wZloRvFi9uuQXJ2cnJhOZKdLd6W/I4xJTqUMw7gRzBJpcQqVj3mXCZpvEwNBCZzVxb8tFw=
X-Received: by 2002:a05:6a00:2e23:b0:848:2ef5:50d9 with SMTP id
 d2e1a72fcca58-8488ad08e69mr7736498b3a.33.1783952711363; Mon, 13 Jul 2026
 07:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-7-jonas@kwiboo.se>
In-Reply-To: <20260708220540.3368825-7-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 08:24:41 -0600
X-Gm-Features: AVVi8CdTXaJ_6s-pjm6UMJxdbQik8Vtmm1Qrf5_qh9_tu2vWJl_4WcwXzkOcWBw
Message-ID: <CAFLszTjxty82LThDuqmAyN7XasOPVT+KBSYdZ_KGd8GC0537Tw@mail.gmail.com>
Subject: Re: [PATCH 06/11] Kconfig: Add missing depends on xPL to xPL_ symbols
To: jonas@kwiboo.se
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

Hi Jonas,

On 2026-07-08T22:05:26, Jonas Karlman <jonas@kwiboo.se> wrote:
> Kconfig: Add missing depends on xPL to xPL_ symbols
>
> xPL_<name> symbols should typically depend on the associated xPL symbol.
>
> Add missing depends on xPL to xPL_<name> symbols to avoid the xPL_<name>
> symbols being available when the associated xPL symbol is disabled.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
> common/Kconfig | 2 ++
>  lib/Kconfig    | 7 ++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)

> diff --git a/lib/Kconfig b/lib/Kconfig
> @@ -972,23 +973,27 @@ config SPL_LZO
>  config TPL_GZIP
> -     bool "Enable gzip decompression support for SPL build"
> +     bool "Enable gzip decompression support for TPL build"
> +     depends on TPL

The prompt fix is separate from adding the dependencies, so please can
you mention it in the commit message? Otherwise it looks like a stray
hunk.

> diff --git a/lib/Kconfig b/lib/Kconfig
> @@ -960,6 +960,7 @@ config TPL_LZMA
>  config VPL_LZMA
>       bool "Enable LZMA decompression support for VPL build"
> +     depends on VPL

BTW SPL_LZMA_SIZE_OPTIMIZATION (between SPL_LZMA and TPL_LZMA) has no
dependency at all, so it shows up in menuconfig even without SPL. It
fits the pattern this patch fixes and could get 'depends on SPL_LZMA'
while you are here. What do you think?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
