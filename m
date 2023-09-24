Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB99CE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:41:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86D7B86B6D;
	Sun, 24 Sep 2023 22:40:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kczz8kp5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04D2C86ACE; Sun, 24 Sep 2023 22:40:28 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2CF386ADC
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-533d9925094so2188989a12.2
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588025; x=1696192825; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g5z24s7I35lpsV+ulFpjXqw2T1AqoZ+br5Du4196O3U=;
 b=kczz8kp5Zkj/lAI2aoXeZPui+OzmqRCoHUewBszCMukC/avkXq/OGkI8NoWqqqsH7h
 KMlTaJPk+wUdY1BKHL3SmatBXUFZ1RFAAKMEmoEqU7zbMMv2BL2Dz4tz0WxL/M8AN26z
 JzQcQXiq/DWBd37H3opTL0QruCX7O0su20PqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588025; x=1696192825;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g5z24s7I35lpsV+ulFpjXqw2T1AqoZ+br5Du4196O3U=;
 b=PHRWFs4mhbsVquTnwoV4J1vLrGT4gokkdnMmS+YfSC/ciEfpmqMfpWs71ED/u7psDR
 pvxo0q5s6WZlS3OSzR70TNbOZ912huYSYSnMcIsIUQN/kSvqjW8iGzQrfbcAI0phJ5T9
 gzjLtQbMU7STUe1YDFcqlet4mvj+gSLmBLJidhNNzv/ftzp6biZIQU8f9erkGUrDsXDO
 ldUirhQkydBeC912SOY7Y+qyItOF+UgNlL74aNTMfM/IqvlmRM62tU9Eg7ua+BvLRlnK
 iLQ38GML8VaiUoAJNiRVGeYuv2gGMe9dCP7qIqNyN6xTqBxj8P5lp0Owz0I5ERRR+9CO
 ABzA==
X-Gm-Message-State: AOJu0YzltbmnFaWp24VoH2fNbfZMrD/7/OW/apwMmTluFypalYqqBkWJ
 l6a5ag26J2TcXkNeNhAjEqa6lkv5EDp92psq+X9QlQ==
X-Google-Smtp-Source: AGHT+IGkYS8d3iyBps5HIQJPUsNKwyg/BhdWIuEzBeIMna+NS4tIhzty3U8/VfSE2aMHjYdaeaTsYl5EwlSbl7DAH5Q=
X-Received: by 2002:aa7:d705:0:b0:530:a61f:ed1 with SMTP id
 t5-20020aa7d705000000b00530a61f0ed1mr3573337edq.42.1695588025262; Sun, 24 Sep
 2023 13:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230906052242.21568-1-mibodhi@gmail.com>
In-Reply-To: <20230906052242.21568-1-mibodhi@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 24 Sep 2023 14:40:06 -0600
Message-ID: <CAPnjgZ29nYzhr32q1SyxQZNgaq344TmqH5v2z+exLgjL77M61w@mail.gmail.com>
Subject: Re: [PATCH] arm: mvebu: sata_mv: Add bootstd hook to enable
 sata_bootdev
To: Tony Dinh <mibodhi@gmail.com>
Cc: Stefan Roese <sr@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>,
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

Hi Tony,

On Tue, 5 Sept 2023 at 23:23, Tony Dinh <mibodhi@gmail.com> wrote:
>
> Add hook in sata_mv probe to enable bootstd bootdev.
>
> Note: bootdev_setup_for_sibling_blk() invocation is a noop if bootsd is
> not enabled for ahci sata yet.
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
>
>  drivers/ata/sata_mv.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

But please see below

> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 18c7a66db1..55a5365b5a 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -34,6 +34,7 @@
>  #include <common.h>
>  #include <ahci.h>
>  #include <blk.h>
> +#include <bootdev.h>
>  #include <cpu_func.h>
>  #include <dm.h>
>  #include <log.h>
> @@ -1104,6 +1105,12 @@ static int sata_mv_probe(struct udevice *dev)
>                         /* TODO: undo create */
>                         continue;
>
> +               ret = bootdev_setup_for_sibling_blk(blk, "sata_bootdev");
> +               if (ret) {
> +                       printf("%s: Failed to create bootdev\n", __func__);
> +                       continue;
> +               }
> +
>                 /* If we got here, the current SATA port was probed
>                  * successfully, so set the probe status to successful.
>                  */
> @@ -1116,7 +1123,6 @@ static int sata_mv_probe(struct udevice *dev)
>  static int sata_mv_scan(struct udevice *dev)
>  {
>         /* Nothing to do here */
> -

You should leave this - the style is to put a newline before the final
return in a function.

>         return 0;
>  }
>
> --
> 2.39.2
>

Regards,
Simon
