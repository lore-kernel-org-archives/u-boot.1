Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DC9CCA470
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 20:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F21383C39;
	Mon,  6 Oct 2025 22:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AKKOYQMp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A166C83C46; Mon,  6 Oct 2025 22:38:27 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 239DF83C11
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 22:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b3e9d633b78so764593866b.1
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 13:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759783104; x=1760387904; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LjYHjiYZPKuad8fxThGO8YWK5bfex0TaaRrJmOb17ok=;
 b=AKKOYQMps2xDIUQGZPTvK78NO9w9bB2I8bxF5xg/O+MP8kQM2u3ragF8x8NFEC/dZq
 MfOY2RBdIA/IoRAvQcVZJRlbvw2yE23KtJkMvCDsYeJZP6YDksJ6Baph5tUtqFbrHkm4
 rqHajoEIcbN5EcoIeFneTiOedd4CDzf93KHWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759783104; x=1760387904;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LjYHjiYZPKuad8fxThGO8YWK5bfex0TaaRrJmOb17ok=;
 b=wyA9aobsvJkhllSJQ5HXz7lx014Bx6K27yL9NRabP2yx/M3YBAxYsoU9xlQrPczx2a
 KC6VzBNt3Eih5PsNMEq8M6n3QkWXAZoSV+EwB4bB07mPPIUEvugoP8AygffqL4Zgi+e/
 HGj5Bktbx6NweLvPd03kTmctCeeeJyElsW9mo/s99fTdZIbVAGveLo7aNzgE6/f2bjBp
 a7CP4V5L3yZzi1wxRWXCJFfAnxpmQgQG4X2sgMQy9/GYucf/YPKFIUZVhhB8VM3ORF84
 +3TzkGCfU2MBCI77jgiiHR12aV6Y7bYrN+ecjhqMPVqmqyl9N/sn0SA6exEOFpafT8YP
 Z1JA==
X-Gm-Message-State: AOJu0YzIFryDmhYJWW2a3X28fwf8zrciOELBHXbBaH/lj7RojuhhvH0q
 P3JoACQPsIHynn1W6JovPmLC5/pTUR97rsUgMwa0AHPsEdN01fwPmiUDJOmZW4TdeL9MJcdzKoK
 RovNh6COz5goSmxFMcc2wUqua12agyAiz0PlwnvBE
X-Gm-Gg: ASbGncuF6pgdKMU/flOGMZc+dy2TImOiGbXiMrI66Eqw2Rk92HbXDdreRA1ak7bjkaF
 LkhXq4Idma6tN3my4FQ9lqCvnkt9/Crk934gGrFdO/UWpraQMB0GlzEVjb1ds5If5ly2+lTFgFt
 v408W4vrxXS+/xgxzWwK0H5LfFX0zZQFYi5swpRHqFNowk0nTbLi8gsdXk6C4/Q56au+bUtzWex
 RlnKhUHR7Zm9+xqpU1vQbVgEV5mup23o9RpxdJo3Co=
X-Google-Smtp-Source: AGHT+IFeXPoIOtr9L6Q0sQ7AA2DhKC7NyjN8wzdPVBxbY4YKCgmvSZ0B9fuvS2afRTRf42/5L66rPxgfqzvHsH+oKzU=
X-Received: by 2002:a17:907:8991:b0:b33:821f:156e with SMTP id
 a640c23a62f3a-b4f4116a352mr125275266b.12.1759783104620; Mon, 06 Oct 2025
 13:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20251006164506.380308-1-kory.maincent@bootlin.com>
In-Reply-To: <20251006164506.380308-1-kory.maincent@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Oct 2025 14:38:10 -0600
X-Gm-Features: AS18NWAi1RrHxGXHrR9qkYGw4te81y2WsAZuFxYeKVFVjD_Z9g2M6PopQLqwoS8
Message-ID: <CAFLszTg+2-xRo1N3zzqY3BEUUqM989xifttbar_+mOE_X12PYg@mail.gmail.com>
Subject: Re: [PATCH] test: Do not build expo and cedit test if no SDL
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: u-boot@lists.denx.de, thomas.petazzoni@bootlin.com, 
 Tom Rini <trini@konsulko.com>
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

Hi Kory,

On Mon, 6 Oct 2025 at 10:45, Kory Maincent <kory.maincent@bootlin.com> wrote:
>
> expo and cedit tests depend on the host having the SDL library.
> Build these tests only if VIDEO_SANDBOX_SDL config is enabled.
>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  test/boot/Makefile | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

We should be careful that a future CI change doesn't cause these tests
to stop running.


- Simon
