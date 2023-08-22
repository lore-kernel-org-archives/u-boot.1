Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF85EE49AE
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:57:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14D4486443;
	Tue, 22 Aug 2023 20:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AHmhaOcu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E151864D7; Tue, 22 Aug 2023 20:57:55 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55A02864B7
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d77b9d574f8so117243276.2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692730671; x=1693335471;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=avgWV7HD6o0HIjKFXdTdLNtsebO3f8kTDKeBXJR/UBE=;
 b=AHmhaOcuMVadYC71vkh8jCCIwOMzNeGC2mnJNYEiC3POrj4naFqtgEK1cT9MmZVJV7
 EC2n/AHlWSmFpgr8NIEbBiOjsm0HCkckOnwIjHJKoliyPDCt882S3Cww7xlzzGwYJ5Xl
 3hzOm1Hgx+KXxZUtDyYTWx+1na2jURZOpXDxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692730671; x=1693335471;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=avgWV7HD6o0HIjKFXdTdLNtsebO3f8kTDKeBXJR/UBE=;
 b=M7sKXtL+ZUBHay8TwSzhfm+UbH8f5ianxA3FZpFyXTrM4SnDFFShdt7HpivSd1vEKA
 C4bN5ez2A0mHRTiQaNto2Gqs/+7FgExQUNwmzJYj0Ad1Xkaws4zu71M/An5ZsF8L/mPv
 fenENHXQsxjv3TGyxd9OEqj8sJkjBAfFqKwlq+qpKhO6XKgF+8V5cYNHWe/VlMrsagrM
 dWO/EP1Gg3vgeGcV5WyGcSP4ANJbXfYZnQrhaRupt29d43b9xVzPKIYIVcl2EP77ozOY
 uThbqkM2TdX0ldaF7IEwnnqCUJO7YNqip64WLw98haiTxnj09YlWi/ud/vkpiGs9vsx9
 qPyA==
X-Gm-Message-State: AOJu0Yxn3NHYWyF+7tnkAcdYk5cSdYTOEC2vHUoIjy1tVzYU+bGPfdbB
 hA/IdQZWZoSQyrK9L2GOSHVOPI9CEwadwzmbmPh8kg==
X-Google-Smtp-Source: AGHT+IGmvc7IyJZM9E5b8IFfFxIXtZoVqDU9H3lqW7GyFhKh788KZzEaICzm6Yec2xIck6GlMchA6YpGO20n+nriB7Y=
X-Received: by 2002:a25:ac82:0:b0:d0f:65db:dc0e with SMTP id
 x2-20020a25ac82000000b00d0f65dbdc0emr10637653ybi.39.1692730670831; Tue, 22
 Aug 2023 11:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230822102113.129996-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230822102113.129996-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Aug 2023 12:56:33 -0600
Message-ID: <CAPnjgZ3LA=mqrwyLie2=GoMgTrOUykRLoimbk4A7Mq=tyK3i-w@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd: setexpr: fix printf_str()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Roland Gaudig <roland.gaudig@weidmueller.com>, u-boot@lists.denx.de
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

On Tue, 22 Aug 2023 at 04:21, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> If vsnprintf() returns a negative number, (i >= remaining) will
> possibly be true:
>
> 'i' is of type signed int and 'remaining' is of the unsigned type size_t.
> The C language will convert i to an unsigned type before the comparison.
>
> This can result in the wrong error type being indicated.
>
> Checking for negative i should be done first.
>
> Fixes: f4f8d8bb1abc ("cmd: setexpr: add format string handling")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/printf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
