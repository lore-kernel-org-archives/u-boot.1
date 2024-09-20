Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0340ACF58E0
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3C03893F8;
	Fri, 20 Sep 2024 09:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BQq7Lsjd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24FE98941A; Fri, 20 Sep 2024 09:25:57 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24E13893F8
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6c51d1df755so12970436d6.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817152; x=1727421952; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6M5d/pLcZx0ERz4WcjECfM4uS1DyU/bfCbdzA3kLT40=;
 b=BQq7LsjdBsksPlE2DWMZ1pYeenkLoEQqnmTkGsa/glS9wq1WU9xGkt84Z04yoVmvYl
 ZDq5DAft2ywk8YdDjugaxwnSshFoCBuM/BRZBMUTubSiRcmfJTwJnaEok0tfaNNFHFDp
 t8qWZfQ7EQlmLD6oyon6sBP5yE+Y2a/MFBAEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817152; x=1727421952;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6M5d/pLcZx0ERz4WcjECfM4uS1DyU/bfCbdzA3kLT40=;
 b=tYxCuCLrmFwY3Thc7pith5dLcGYW52Lrn1rFA4iibWLQvAh6/RZiPWkkSKhhe7LzZe
 USmC/YgZpklX/GsmLtMhZCml/NrOzy+s4B4dhZfapod5EVuUOEskhrlT+R8wg0LKFFFH
 JMjnHzKRtS9QrhcyRQE33KccR9As3PZj050AOiSDECtDo3QpvGQwNzi6XRSaRtbDWN7o
 DaCaZHLjI2wApjZv/HWLslrI66G1xm7YKSn8z/0O3WhQNwECoAtCZoWRtrDS7qelMyLu
 0br6644RC7d8t8GnLl+lzDzWl5Ae6STpCjNX2hIkjxuLpd/8vHZtbDAhpvo66IhJjB2N
 p5FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe4zKphxKbI/6LdF/au1FtqyT5BBYqjvXxEq4p6yl04MAh6iqu9WvLqHEJrHeo8VY897BispU=@lists.denx.de
X-Gm-Message-State: AOJu0YwFzOR5DqQpaGG5o+Qoiu/D3wkKRv/6dp0C1rrBMYgRHUcoMXKo
 QSfAqkWmT0wWGiLES5WphiWHvq/nVYv9lOn42UyyPJxnYcO6jsF9iDYv6tVg+YXM1BCkjL9cV0S
 sAXiiOMugXeWVrYVfh8K/xs9bDlpScAfUjXyd
X-Google-Smtp-Source: AGHT+IFo2TnoRYhAPbzieOcREKrfA6OHcVBYkoxGgXZxezwzk6WMR9Wb2c90m/51rK+906EEaax2pB48HC6GqC67tus=
X-Received: by 2002:a05:6214:2f0d:b0:6c5:317a:a664 with SMTP id
 6a1803df08f44-6c7bd46c895mr29351776d6.3.1726817151640; Fri, 20 Sep 2024
 00:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240804150955.3521296-1-jonas@kwiboo.se>
 <b96a6544-05a9-46a0-8be0-379835a9c175@cherry.de>
 <5e9cd0ac-bc0b-4c82-aa3e-93339d43b1f1@kwiboo.se>
 <5131e98c-3a6a-49da-ab03-2e61038f9de7@cherry.de>
In-Reply-To: <5131e98c-3a6a-49da-ab03-2e61038f9de7@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 09:25:40 +0200
Message-ID: <CAFLszTh=VG09edfCndXi1jX03D1Rt7SLMQG68CD5koCTph6yDQ@mail.gmail.com>
Subject: Re: [PATCH] serial: ns16550: Try get serial clock rate from DT before
 CLK
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Mon, 5 Aug 2024 at 12:05, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Jonas,
>
> On 8/5/24 11:02 AM, Jonas Karlman wrote:
> > Hi Quentin,
> >
> > On 2024-08-05 09:19, Quentin Schulz wrote:
> >> Hi Jonas,
> >>
> >> On 8/4/24 5:09 PM, Jonas Karlman wrote:
> >>> Initializing a clock driver to read a known static clock rate can take
> >>> some time at U-Boot proper pre-reloc phase.
> >>>
> >>> Change to first try and read clock rate from DT to speed up boot time,
> >>> fall back to getting the clock rate from clock driver.
> >>>
> >>> This help reduce boot time by around:
> >>> - ~35ms on a Radxa ROCK Pi 4 (RK3399)
> >>> - ~15ms on a Radxa ZERO 3W (RK3566)
> >>> Time that is wasted getting a static rate known at compile time.
> >>>
> >>
> >> I guess this also makes some board perform worse as well, the ones
> >> without a clock-frequency set?
> >
> > I do not expect that this change will add anything to existing boot
> > time, however in some circumstances it may reduce the boot time.
> >
> > Before this change the rate was retrieved using first successful of:
> >
> > 1. clk_get_rate()
> > 2. clock-frequency prop from DT
> > 3. CFG_SYS_NS16550_CLK
> >
> > This patch swap 1. and 2. so driver first will try to use any rate that
> > may have been defined in DT, thus possible skip a probe of the clock.
> >
> > Boot time is only saved/reduced if the serial driver was the only device
> > that needed something from clock device in current phase.
> >
> > As long as the DT contain correct rate in clock-frequency prop or no
> > such prop this patch is not expected to change anything.
> >
>
> Well yes, that's what I meant. If there's a board without DT or without
> clock-frequency in the DT, then this board's boot would be slowed down.
>
> The ns16550 being used for many many different SoCs, I don't think we
> can necessarily assume everyone is using DM.
>
> All of this is merely me highlighting this fact, not arguing whether
> this patch should be merged or not :)

Reviewed-by: Simon Glass <sjg@chromium.org>
