Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43A2C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:31:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B340384CD1;
	Thu,  2 Jul 2026 10:31:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kswSF0zx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 933ED846A4; Thu,  2 Jul 2026 10:31:20 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B93B846A4
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:31:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-37dedd62b90so362480a91.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 01:31:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782981076; cv=none;
 d=google.com; s=arc-20260327;
 b=HKcU7TANonrX4y6n7x4WMCrqp6hIONvPvmkRDbtFF56nYOTly1DqCARZyqWXKkCJjW
 857zOz1RmJPB7GybWjfGdMnH9Unr82EJYmp6gPtHqbATwIntZ2zHL4JQb3sXcAPaYX8z
 NEQ1CAqY2qV5+8jthGyMt7747RjyUfDeS+1LaMrpvgx8KMN/YoZWl0AkPB9VNiZU9/QO
 Gr57vOAK5+fvmaMdUzyfpUqFjFx9ZO6Amzzdcj8SzOtf8fXR/oH7lUoBR/NhbbLFfig1
 pzZ0kdZTH4XTqOaz4aYfB1kUGPMnL6Hje0bPtlIyut+FPJRxJ18jr0ObpqAqPTXLcBLj
 F0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=D6cpvteB4FckLvPRoDtg2Jczm0vMGV8g/hZUUGmSjCE=;
 fh=MhAo4QPuXEC/Rh971JORz4rq3nvFSJ8p5JStjvc7R4U=;
 b=g6MzFCZ1+4xsKYaG92WafxBgrJVlMLE7D3xkboacBuRCfvdKmLjv6SVAxR4lPe2CnK
 amnhDu+hifh9sbGCmUWYIYRFobgrmDSU75sIVm4ci99HNi+pBlEtu9l9E4B6iLV22WkA
 KVVlXGP0V4Bw54MWFbfrEen/BnAmD3DjhA2RcRM7+oOaRTz3UrTGBEcQNcQTeS+x5aty
 hOsdqvnvw6eP0T32guyArceVMJJ+zsjvHBHMiWK7xWvMgIXhcgClFNWPo3qDYIWVpHFB
 PgACmhZezvOGV5Xov4PDeFIA9qKp9pChCU9DSBzZYqAh/Ej5hutOWu5cJR2iB3UlInA0
 ak8A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782981076; x=1783585876; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D6cpvteB4FckLvPRoDtg2Jczm0vMGV8g/hZUUGmSjCE=;
 b=kswSF0zxOmKe8kjHXXIoJJ5so08xVpYbI3ROOpTEl4QMCemcwkRNCXCnfZkb5Ws5gI
 31GxXSZRxuaRpRbI+UoLcaFNk1vo1B8OfRPKyWwdXf1QS85bceGfoF7xKhMSvoM00U3k
 6/tCdybkwZKCtHqKgRVjTu6SZtndI0yxY4qsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782981076; x=1783585876;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D6cpvteB4FckLvPRoDtg2Jczm0vMGV8g/hZUUGmSjCE=;
 b=gmt9Wg8UkbELM+JpyckEC8YmH/duYkaUodYFig4/voZMxjT+tsCyZruTxqBUdTRCRY
 uSgd66f85rr+wyfVJUWq1/JiAvUwFvg6mXY3V4pw3Aw5r3UUG6Jw3DhGhtThk0CdfgEO
 ZDTsPIcDP3o55wflMVNHYOjMcOd/TMxniQrvcerwDbrXqYrmMNwiaJt+L1R2X+Pe5+Yd
 1WuTkCzLh6wsQS4g9BSWOZvjo2vz1WLFXBkglJ92FUUbX0ce+Qy7UNjannbVXmfflz2M
 2tP6v0L0SL6dYdeoFP2aPixb8BlS9Qg/MsnYsHzAek5trUAhISgUiHwkNDsTNbOfkEm3
 Vapg==
X-Gm-Message-State: AOJu0YwOjR1EB/4gq7+exUDzeRS0/xCw9pLaj459PHTmzuZOPJyZOLH7
 sJjLE/QvSOX1PK8SCE8X1r+TuN03PbZsqYT3GcA1EUV9Or7IOw2KYyBL66bp/rAd8/8tVwE4d31
 rLyZKGU+/dkzt34D4u5pwqEpri8DNboXztdSVQ+D4
X-Gm-Gg: AfdE7ck0rMCCVt28kvAFM6Sei7kajlcRH7FuA6+anqompMxJblxDrfUGcU2kaBSDKh1
 ttHC0+G5UHIIklAqI7dqSuLpQcfb9p++9YHkPWvr+cVMm7wxEo9E1nxAJK1u4Sx28KpWDKlO+an
 d9Gl+D5wuOiPVELlDBxnRLl/c3vP3hIeE/Z0rwVcYghT2ZU1n5E7PNLmGzGGTnDKnrXAocTDdyU
 TcYE0Ims7fByJcjhzABb95rtIcLnKLOEr/x/GZFrVExOCElJ8BGy1b8Adf4ZcbV+lJbGPaZ+w==
X-Received: by 2002:a17:90b:2b4e:b0:369:7491:7b24 with SMTP id
 98e67ed59e1d1-3806754f705mr8490583a91.6.1782981075891; Thu, 02 Jul 2026
 01:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260701171535.906272-1-rv@rasmusvillemoes.dk>
 <20260701171535.906272-5-rv@rasmusvillemoes.dk>
In-Reply-To: <20260701171535.906272-5-rv@rasmusvillemoes.dk>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 09:30:04 +0100
X-Gm-Features: AVVi8CfqaqbmaFW9r02TvOlpU1xEOedK70t2vP8cGoCswhpbatqrlmx_-EKeC_E
Message-ID: <CAFLszTiFNEFicCCdSSj8R-HHnw_gAzLHMHMcPYdmAE1LBQPe_w@mail.gmail.com>
Subject: Re: [PATCH 4/8] string: remove unused strswab() function
To: rv@rasmusvillemoes.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>
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

On 2026-07-01T17:15:27, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
> string: remove unused strswab() function
>
> The last use of this function with rather peculiar semantics[*] vanished
> in 2021 with 0a527fda782 ("Fix IDE commands issued, fix endian issues,
> fix non MMIO"). It has no tests, and should a need for something
> similar ever appear, it is better done with some proper
> utf16le/utf16be/utf16 abstractions rather than cluttering code with
> '#ifdef __LITTLE_ENDIAN'.
>
> [*] The byte-swapping itself is weird enough. But why is an input string
> of odd length ok, while the empty string is not allowed?
>
> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
>
> include/linux/string.h |  4 ----
>  lib/string.c           | 28 ----------------------------
>  2 files changed, 32 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
