Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C407EE7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 18:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EC4B80730;
	Mon, 23 Dec 2024 19:27:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iE5V++H5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CEAB80730; Mon, 23 Dec 2024 19:27:44 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CC7E8056A
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 19:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d41848901bso8435111a12.0
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 10:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734978461; x=1735583261; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fVuW2BNwp5x+6qX9bH2bJpRw8enHgCFqz8nrP8HoGJ8=;
 b=iE5V++H5PvK4mCV3Jntf/h8DD5zAUzI8FKbkZek1WGOMJ3ql5G0SfCFx5SAxksVAUN
 O1gn8ZngNzGsyE023xjoZuFry64dfKIaUKdFvV0jhXJRa2SRFQafaWGfJ8IqOBNoiNmG
 E0VaJMGQCXDYFrwB4k7DC4yx6TZsrbE7z4zx6Q9oc171+UFtdslkGp3lS/IORCsqa1Iw
 UdYOT2WIRNy4g5fMv7T0SHDVDXQqF090weaEO08petrsBg9WvA/vTLkL38xqsPd1OzNj
 yLTPMLOmsswDtQpJaG14lX/l36bLLyR6cfHtMcksxL+RG+QBcgczIwk1aCxis1bc5tU0
 HtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734978461; x=1735583261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fVuW2BNwp5x+6qX9bH2bJpRw8enHgCFqz8nrP8HoGJ8=;
 b=S6nANF4kdGnvxQNzQqf4QXCZSzu5gWGXXOJe3kkjxwcYBF+6sAlQ4/JSGduq8T4KAZ
 wYH2lEIdvnmDR3fFGQHGvpvCPcjzcbi3A8iBuI/PsnuzntAoZFp6jNuXHErWkP3mG5oT
 WWwyKQBElq722uFJAmo2YhrV6GkMFH518LaZ6g3ZCP9fNdfXIhDGARblYdgQedxcpRFE
 n6RpjbhHfUvbfrfvaEDZizPXP7ABbHnu6Cpjyev4v1+J5I2NWkEqw1wX1SJw3rkUuhPy
 bjivYEBN+DgU8823w+KALMdgEQ6R8St85supmbF15+/mxrvM1PwNcx1kKOJG5WVn4lA9
 Cuug==
X-Gm-Message-State: AOJu0YyxDAF8FQvXkG+duhJigGGAVVtRe1AlXa2XrrYy9rj67KiuaM35
 g70XfiJONmAyHoZaA9JeJWCWoWqw8egPT1uejofMdPbZgFwBUtJp/AIG4+cXWKGZUkSivfkS05B
 Lo45au70ViNt+63iFHDEIMWFCBgY=
X-Gm-Gg: ASbGncu4TzwrHK/tVM00ZmzsADtRt1IhDf+T9Ml2sGpqUjvO0HEMYjYMIet9dP9NClz
 pInkEorS6kclPShvJHO28DSo6b+B3Fl1/HaQ0A75qSGgq8U/+/Kw=
X-Google-Smtp-Source: AGHT+IEO/zzHCzGC8Em+GBqqfBbTgmj3+vmz/gX0KQ1tZwrncVDuRh6WZ7rqNAQt+38L2YQeMkKBEySSsMQ9B5Y3fWY=
X-Received: by 2002:a05:6402:4010:b0:5d3:f617:a003 with SMTP id
 4fb4d7f45d1cf-5d802388f09mr16984122a12.4.1734978461245; Mon, 23 Dec 2024
 10:27:41 -0800 (PST)
MIME-Version: 1.0
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20241220222612.1757884-6-trini@konsulko.com>
In-Reply-To: <20241220222612.1757884-6-trini@konsulko.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 23 Dec 2024 18:27:30 +0000
Message-ID: <CALeDE9Os08g7z=socUCXC_tTuc5h0m5YQ7nqi2N0ALcD2_Ji9Q@mail.gmail.com>
Subject: Re: [PATCH 5/6] mtd: Correct dependency of BLK
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heiko Schocher <hs@denx.de>,
 Kyungmin Park <kmpark@infradead.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Fri, 20 Dec 2024 at 22:36, Tom Rini <trini@konsulko.com> wrote:

> In the case of MTD_BLOCK and UBI_BLOCK they should be select'ing BLK as
> they provide block device functionality and not depending on some other
> block device already being enabled too (as is the typical case).
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
>
 Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

> ---
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Kyungmin Park <kmpark@infradead.org>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  drivers/mtd/Kconfig     | 2 +-
>  drivers/mtd/ubi/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
> index 678bbde89e68..df178665f9bc 100644
> --- a/drivers/mtd/Kconfig
> +++ b/drivers/mtd/Kconfig
> @@ -34,7 +34,7 @@ config MTD_CONCAT
>
>  config MTD_BLOCK
>         bool "Enable block device access to MTD devices"
> -       depends on BLK
> +       select BLK
>         help
>           Enable support for block device access to MTD devices
>           using blk_ops abstraction.
> diff --git a/drivers/mtd/ubi/Kconfig b/drivers/mtd/ubi/Kconfig
> index c027d898a640..ba77c0347365 100644
> --- a/drivers/mtd/ubi/Kconfig
> +++ b/drivers/mtd/ubi/Kconfig
> @@ -116,7 +116,7 @@ config MTD_UBI_FM_DEBUG
>
>  config UBI_BLOCK
>         bool "Enable UBI block device support"
> -       depends on BLK
> +       select BLK
>         help
>           Enable UBI block device support using blk_ops abstraction.
>
> --
> 2.43.0
>
>
