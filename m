Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A06AF34C5F
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 14:57:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B13DE83DC9;
	Mon, 13 Apr 2026 16:57:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OyWbv9Xu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 489798407D; Mon, 13 Apr 2026 16:57:14 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 210E4839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 16:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82f351ca23cso570288b3a.2
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 07:57:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776092230; cv=none;
 d=google.com; s=arc-20240605;
 b=BWCe3GLTC06Bj4/LlCmZZYxRge2zvvkYatHcv/7ZooaHEqY0GVxDMbEY+UxOrtYAfN
 Oc42tzoEcaCv5jDVeSDofQprbjjBCgd6CI2zz7TDK2LNedsJ7ibYLm49ak/xEDCZIKjz
 fSZLv6MYXIG2Oas9CTqbMXJOuUmNQ1PBA7tkXJdjgr/zEEywMrbRZ96j4lvTclGHdWiv
 FGP9bDANW2DABJs659Em0q9nfJ8ixjvir8dpcnSmeC9dUXvRC6YuaQMKpQEGLj4we9i0
 QDU6DvYUXzfymZfPpaXfVpAbiEoD3R0OOZR9Ht3psKym4eRvV/NKwNPUwT/WfFGnuiKA
 fqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=V7+YvyKXGIOFikLuuMc+s6VBGn0tbW96ODkEQ8ar0aY=;
 fh=dF+eCHOIT6SIbAzI5tBwPFZclvSQgQQ7Zo1JXO6SSnQ=;
 b=OENuvEYmYsVPifBKqZPiU9/R93JV22uw696IQc0dgJty2srUNegnY+hSX6U9C3QvPp
 XxsnYLzOEbGo8BjrdZ1rbRGu7cM6Zc2BlVR7S9Z9unS3n96EKYxkuZiIIcTQxtEHKkjT
 HjZ1UNk9SKaYX/4xbOvOg6jqlUibVFXz6omx4aG37/ly7vF1yIfQAzMub9gHIkJ0qEPS
 N08PvUZfOoUSxPFctNYYeoUr3qyVOL0Drkfs87SDyLC7qJ/6XK8tAatdS5r+QoKZkqGl
 1jMo2CObuMsnsPUfuPsnt0RAsSr2zRQ6sHJnYDMo6su4BehAFFeia+0QESrZbwxYU8bL
 /KOQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776092230; x=1776697030; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V7+YvyKXGIOFikLuuMc+s6VBGn0tbW96ODkEQ8ar0aY=;
 b=OyWbv9XupDjTym+LILpVni5FsSqkq6q66mH3pp0Aj9/m1XIj3076jFlrycpCxSJXdN
 eYgbmXsVuz//xxYOybnvaKBV2t2LV3pbvE+nF9d3LBXFEYrryHhuXNVbN5AOe7eBKxPQ
 kUz94RTpv5Pv2kQqWjc7yvVkSwmxuC/vyVZag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776092230; x=1776697030;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V7+YvyKXGIOFikLuuMc+s6VBGn0tbW96ODkEQ8ar0aY=;
 b=FvI2tw03Vea9otR0HGlBag+EETOlluI5RQyQaMBw9a//UD03ttCTw1Ax6WbVl+wgPP
 Ecj1Lyytm/6/cWTAF93oUaKBCCDhgzvZ15aF9V62c21+PZxut8fGk6yuq+aD5B2urkBk
 6b/AWsqy2sGNcZAC/TlDF0jomiFMlnLp+tUXWY1XmQx0oyWGFJSw0+w5YQMhlcAH238k
 HnnPrky7Aa5JIcxXZbNqGWbZCv0Sobugq8IKrK8Jdv40wzLq2ZtYLGlcmyfP9w9idF4p
 VM919QHM7PsitJhurMOFYBG7jkjy4rV84p1B4Xvf9GphH5eD/Xujt9CjTIvU08NNTChH
 tFnw==
X-Gm-Message-State: AOJu0YxWwFfAf6KkQm81q2SoXOEVC8l/g9SkO8CtTywOuCLneUg3ARxI
 N+IQ1YmkB5h5vHZ1xKAjHYespDISm3VJy5tg4g/iAFA1TtQBgqBZjBeAgG3YcpwqGixCplmnUKn
 geFhEjc8M8pmCfwHb7se4f5vegFubKaUjVi6/AsSo7wY5d07Hjrs=
X-Gm-Gg: AeBDievbSBIUCgGIflgH+KRRoOG9A0UQUyii3b7vOEIyHF7DZw+QmWxEDqmlolCIyeG
 HB2HOtGgI82M8DnRsW6OnJG+9abnEoepkeVi00yS7C2hARCnbMbYnOBM8S0eT+DfC1njcAblPvG
 /r9rbgnZenT9Hfnfc7fAmj+1O2MJ5unDanCtaN9u+lF52zo+6h50RtYdKUU/1e07UeNC+H1Xf9q
 eUbiV2JMSK9mWIHPFq6L3Y9mRrg0x4hqRZuU7Qipzp9Tn6RBbPwbb8qdqN9+as1nax7YtVQYql5
 36JqBw==
X-Received: by 2002:a05:6a00:1946:b0:82c:e1a0:3453 with SMTP id
 d2e1a72fcca58-82f0c3568e4mr13475537b3a.26.1776092230567; Mon, 13 Apr 2026
 07:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260412195947.1982729-1-ravi@prevas.dk>
 <20260412195947.1982729-2-ravi@prevas.dk>
In-Reply-To: <20260412195947.1982729-2-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Apr 2026 08:56:51 -0600
X-Gm-Features: AQROBzCsra2KaF5eTfgceXJDWeqfDSEKNrTPPdThXfcwVnmsP6Di9xBjrbbLLDE
Message-ID: <CAFLszTg=oAKTtGUCgFnXzf65xdWwGYgMdzd7qOvRFBU+JDnBeA@mail.gmail.com>
Subject: Re: [PATCH 1/8] string: fix prototype of memdup()
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
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

On 2026-04-12T19:59:41, Rasmus Villemoes <ravi@prevas.dk> wrote:
> string: fix prototype of memdup()
>
> It doesn't make sense to restrict memdup() to only return char*
> pointers, especially when it is already defined to accept void*. This
> makes it uglier to use to e.g. duplicate a struct.
>
> Make it return void*, just as kmemdup() does in the kernel (and which
> our kmemdup() in fact also does).
>
> While in here, make a small optimization: memcpy() is defined to
> return the destination register, so we write this in a way that the
> compiler may do a tail call.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> include/linux/string.h | 2 +-
>  lib/string.c           | 8 +++-----
>  2 files changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
