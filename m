Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB86FD41C10
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 07:44:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31A8488599;
	Wed, 13 Nov 2024 08:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uCVZIb8C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA236885F4; Wed, 13 Nov 2024 08:44:08 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9437588486
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 08:44:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2e2dc61bc41so4822154a91.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 23:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731483845; x=1732088645; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eYIRMie3C8lfxZeYYQBLXCcgsDnzxp2iRK9j4uwFj4Y=;
 b=uCVZIb8CpnpaTyBCK5aONmJ4+4Hg4KN6tS30rUmyXjoZPaMRaC8S/KPYLjBP6JPDcj
 Q5Sh3oUJifoQIGTi9eU0XxuGDlT4eB/+T6e5/Aiydq3M0IiqB3iaODrTtCY5OU1LIkq3
 8G37XQKjpM2cE1MBvuNNwrFBHLOSB07sbf1zt9Ra3A9PCc9yRmHFurKFvrsz/EBbIk/T
 cLGdK7Os5GR/IVc6Y/Zs8/0BAVN9HFIBQHdBDsI93dVJKdRTxzHDujIngkoVsnyTTvxl
 zw+YURalDEgeQuUBI89VnGCPDQec84dwcXfMBwCki3aOhRY7llzSE20U/bhbI4IsNdFP
 mKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731483845; x=1732088645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eYIRMie3C8lfxZeYYQBLXCcgsDnzxp2iRK9j4uwFj4Y=;
 b=maw93wgOZj329v//qUzTBCDKMQYskokF1sd2X4Uvpq+vvZ2wdZJrJgbbdvgZbjmmBP
 aJHGKbyuMM40kW9xEaoaGLTNV6mDihvEC+4yIRYlVbdT8hMlr4mJXp/7brnKHD6Jgggy
 VrUgXJGB0PHb59J4r1tCTmSnvbcb/4PqLH2BP+yrObNy8C2JfHhmPfonOnwwT3N5izRc
 JOb5EUAjIv5iaZKnupAj25CHRcn+pJyKdnPG8JMPDtaRR1lSI/CRT+57H7SD9O9XsdIP
 geW5IZkZKAF77B/5z2mGC34r0pmEYQDIcv6tzulQqsubkYAYwUTsK8ltiu4e+iW5QlK8
 5sLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3Fs6b6kLuE5enYlEriCxru867TgNxmYju1Xo01fctesSqX1qMAarM/pC0eat71uQP4O7dcwg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6ky6JHfMu2JSiJsGGZLuu5CEFQVbVxG4UXa4upBkuFcKI/rbF
 cheXkL6LOP2+jhqt3kZyvmTKQjpkXmCr3tk2RxTv/wPQMxgLyxl9SnYLTp37izMNc9ozLi7cO/W
 h2yWkGL8dueWjoSjxWnGo7UeBsvIL7k7rWZEcJA==
X-Google-Smtp-Source: AGHT+IGAjuHhfQiT18a0VTJ88qsmy/Av/8FDHLjz/6i864RfparuDHBf/7gR6cpmDt+LPU91MyMSMCquFmWXYIp2kFY=
X-Received: by 2002:a17:90b:2792:b0:2e2:e660:96d5 with SMTP id
 98e67ed59e1d1-2e9b177bc9dmr25067541a91.24.1731483845020; Tue, 12 Nov 2024
 23:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20241113053023.1870736-1-caleb.connolly@linaro.org>
In-Reply-To: <20241113053023.1870736-1-caleb.connolly@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 Nov 2024 09:43:28 +0200
Message-ID: <CAC_iWj+c9syFxtA0dCANy9cYW9Wvm3yxyCAo_a4Myd_X2Yh-3A@mail.gmail.com>
Subject: Re: [PATCH] mmc: don't print 'MMC:' if there are no MMC devices
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
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

On Wed, 13 Nov 2024 at 07:30, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> It may be the case that MMC support is enabled even though the board
> we're booting on doesn't have any MMC devices. Move the print over to
> the print_mmc_devices() function where we can only print it if we
> actually have MMC devices.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  common/board_r.c         | 1 -
>  drivers/mmc/mmc-uclass.c | 4 +++-
>  drivers/mmc/mmc_legacy.c | 5 +++++
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/common/board_r.c b/common/board_r.c
> index 62228a723e12..232a8fd19f03 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -384,9 +384,8 @@ static int initr_onenand(void)
>
>  #ifdef CONFIG_MMC
>  static int initr_mmc(void)
>  {
> -       puts("MMC:   ");
>         mmc_initialize(gd->bd);
>         return 0;
>  }
>  #endif
> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
> index c8db4f811c2f..56fe29249c36 100644
> --- a/drivers/mmc/mmc-uclass.c
> +++ b/drivers/mmc/mmc-uclass.c
> @@ -384,9 +384,11 @@ void print_mmc_devices(char separator)
>              dev;
>              uclass_next_device(&dev), first = false) {
>                 struct mmc *m = mmc_get_mmc_dev(dev);
>
> -               if (!first) {
> +               if (first) {
> +                       printf("MMC:  ");
> +               } else {
>                         printf("%c", separator);
>                         if (separator != '\n')
>                                 puts(" ");
>                 }
> diff --git a/drivers/mmc/mmc_legacy.c b/drivers/mmc/mmc_legacy.c
> index 8f8ba34be717..f4a049a4a4d4 100644
> --- a/drivers/mmc/mmc_legacy.c
> +++ b/drivers/mmc/mmc_legacy.c
> @@ -98,8 +98,9 @@ void print_mmc_devices(char separator)
>  {
>         struct mmc *m;
>         struct list_head *entry;
>         char *mmc_type;
> +       bool first = true;
>
>         list_for_each(entry, &mmc_devices) {
>                 m = list_entry(entry, struct mmc, link);
>
> @@ -107,8 +108,12 @@ void print_mmc_devices(char separator)
>                         mmc_type = IS_SD(m) ? "SD" : "eMMC";
>                 else
>                         mmc_type = NULL;
>
> +               if (first) {
> +                       printf("MMC:  ");
> +                       first = false;
> +               }
>                 printf("%s: %d", m->cfg->name, m->block_dev.devnum);
>                 if (mmc_type)
>                         printf(" (%s)", mmc_type);
>
> --
> 2.47.0
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
