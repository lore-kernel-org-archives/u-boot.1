Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83CCD5E14B
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 10:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D33F88EBA;
	Fri,  8 Nov 2024 11:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FVFGKKhs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FE068902D; Fri,  8 Nov 2024 11:05:58 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B03D88B0C
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 11:05:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37d4ac91d97so1701265f8f.2
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 02:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731060356; x=1731665156;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=MPuxFq8G86F7ZxNsbKsWivHGDnFjqFoOZEWGV2yLJM0=;
 b=FVFGKKhsGIWcCWKUzAxzm6eY1BcypS9DrBRdYpnwNEbQNqIBgcYbEeBdaMiYHtW79s
 4+TI5AGUo7zPmiAA4Fp2xJ6oIZYH3OOrsq0hzt/SOjbHxbDSNkW9GMPQJ6/s5skYLOVT
 dEp02kfCiCGsBMMnCHkQ2buxlyzTGPd5r/20ZUkZc1flF67+N0tYeBt71N81K0PNy+WS
 La9iKZIQr+6Lo/BDHZrIq/qfSc3jzEyCTmBYtggXw1NXHi/qlttylHWJlbMMw+k95XfO
 u5omi/0Tg9lDr1EsqQ2afoozEXLrlq81bWoUwHucgUskmqQGt2U84m77sOjcWNJMpHoq
 DwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731060356; x=1731665156;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MPuxFq8G86F7ZxNsbKsWivHGDnFjqFoOZEWGV2yLJM0=;
 b=TTAMct/MI8ymNcB8sQXCYLgWi6uZwV6HLgai6ox19gNznxGfpkalwse00bnVveDl3K
 lDK3UVp0CGCXYiAOP0V6oRe9D04n1q9PdxBqlAmNwTwMi1FPLzsj+oCOAg0PlY8w2+YH
 VuDsKrBAY4B8eUSPxbfF7tx+XNxQp4ckL+eicFnctRWuHsD5L/jDNVzBxsb8xzJh37hY
 fMblsQ96wp07r8FDPHFocFxGGogEGV7oAWnMetXdxY57QguQ+dYCWsXwCZIeO6a3/Wj/
 dzVzBTDaKQ5nsoDx50gOpfx5HnrE719h25Up+SGV6dQJxtb/iC8LkN/euxDoY8XI5ija
 7U0Q==
X-Gm-Message-State: AOJu0YyH0FHz7kW+gdE+gi45/Nhcz6jF3KzF0Nk1w9tlQfFPnbZ6pJwd
 3xY/q4Xo+fKAGSGklPsWLYKHMjVgK4CyM4cvOeod7CYJbGbfwfE/rsS1hvvjqBB840jIDg9nZ6t
 d
X-Google-Smtp-Source: AGHT+IGNnPl5Tmu1YJYr6nRRLnkObvWpHZIwsm4ck1eS3tsGXjw2aLz42dJpARgc+JCP/TuTQwYvig==
X-Received: by 2002:a05:6000:2d11:b0:381:f443:21c0 with SMTP id
 ffacd0b85a97d-381f44325f1mr425429f8f.57.1731060355548; 
 Fri, 08 Nov 2024 02:05:55 -0800 (PST)
Received: from localhost ([2a01:cb19:8f40:f900:f167:cb53:a707:1347])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6c0414sm91976965e9.23.2024.11.08.02.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 02:05:55 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, Guillaume La Roque
 <glaroque@baylibre.com>
Subject: Re: [PATCH 3/6] configs: khadas-vim3{l}: fix userdata size
In-Reply-To: <20241017-adnroidv2-v1-3-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
 <20241017-adnroidv2-v1-3-781c939902c9@baylibre.com>
Date: Fri, 08 Nov 2024 11:05:51 +0100
Message-ID: <87msia3urk.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Neil,

On jeu., oct. 17, 2024 at 18:10, Guillaume La Roque <glaroque@baylibre.com> wrote:

> After increase boot and recovery partition userdata was not resize.
> so on VIM3 16GB and VIM3L `fastboot oem format` or `gpt write mmc 2
> $partitions` fail because end of last partition is outside of eMMC
> size.
>
> Remove 64MB on userdata partitions to fix it.
>
> Fixes: ce138d9742bf ("configs: khadas-vim3{l}: Increase boot/recovery
> partition size")
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---

Do you think you can pick up just this patch ([3/6])?

Since it's a fixing a regression that I introduced I'd like this to
picked up without depending on the rest of the series.

Thanks!
Mattijs

>  include/configs/khadas-vim3_android.h  | 4 ++--
>  include/configs/khadas-vim3l_android.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>

[...]
