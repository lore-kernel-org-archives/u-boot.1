Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC09CFB448
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 15:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C90A88DC1;
	Mon,  7 Oct 2024 17:24:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S9mHlDi0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2367A88DC1; Mon,  7 Oct 2024 17:24:11 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 172E588D5B
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 17:24:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cb3ba0a9a2so33353056d6.2
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 08:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728314648; x=1728919448; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hKv7ChyXqDDM+s4Ho0myXr4jiSC45YBHw1PGtXT6NMI=;
 b=S9mHlDi0hSdqnjdUk6vVFlPm8Z8YHRsF9uQsGrU2OEFeuHu8gY9uJt4fm7f/jAK03r
 zKtZa1mlzmHFG6b8F54gLi0+7rZ0DS2VZdFA4AEUMASxNaobr4eVf4KIjv+LMga2gBIY
 blnJoa6KXI7Ns8fNxwWRIunUdHbR1nVrdOngE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728314648; x=1728919448;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hKv7ChyXqDDM+s4Ho0myXr4jiSC45YBHw1PGtXT6NMI=;
 b=beLv4pQuMAhPfVGwsaMy69Nfl/nmtx2i2lcm/asa6qA35mFvRPrTtfPXf0IjhF8RMC
 foWRmaqskmdr5zbapTdzbqjKKVMRH9ZX6d4pfv9eB0ISWQJ3PYuWZkdqSctNoYcLlH0R
 g0omJ7y+qkpJZQmmlxPli8/+nUTl2FRoIRT8VKc/7MblV7mZ9DQnxU71HVOeYwVoG3F0
 vQpH9PylgLmNqsjvVDvmh3Nq0TS//T3pwxU9EWaQAE/GR6o7vtdt1nqrQgOLZ65WKHKv
 t/AK8bXHCg1zaEGKRzC+bxXX2loYqVd+/BFNO+0oxTuO4KljrqpZTz8XEBcyOaUHz3f7
 R/KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZvowH0qecoFGDaOd1BiVlAMj3KahLdtFshJpPng0dJyBbsGd3KN00Ei4QcW5vwD/jMFIGXgo=@lists.denx.de
X-Gm-Message-State: AOJu0Ywre+pQHcnltMNEXAGUSaUc2S6fmmwpunvLs5Jw8TvLsdkKEP8M
 ZrorB+kF+fLClrDTnTolssrgx+YwKoS/Q1lHRDRhRRxE15FvdTI7sTvGjlSJxYgBP9znurLHmUD
 3nO9bGHKoZBX3ztLl+ZS0O6Q1lqnLeS3+brc5
X-Google-Smtp-Source: AGHT+IG5tZ6tX8eXCN5ik0GprWQ5EwSLxhexY1W0oPV/l5i8AGi84JHs776QOuvhy9TUYJZJlXcQ/uTDVX+4q7SFtfk=
X-Received: by 2002:a05:6214:2e43:b0:6cb:8266:2e04 with SMTP id
 6a1803df08f44-6cb9a01aca0mr183931906d6.0.1728314647710; Mon, 07 Oct 2024
 08:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20241004084124.416695-1-pbrobinson@gmail.com>
In-Reply-To: <20241004084124.416695-1-pbrobinson@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Oct 2024 09:23:57 -0600
Message-ID: <CAFLszTibTZcOj8kLA-Cqd1fLnJVXh=5V3EfLq_JQ_COxbFENxA@mail.gmail.com>
Subject: Re: [PATCH] board: rpi: Pass CMA through from firmware DT
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Matthias Brugger <mbrugger@suse.com>, u-boot@lists.denx.de
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

On Fri, 4 Oct 2024 at 02:41, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> For a lot of usecases, such as display, camera, media
> the Raspberry Pi needs a lot more CMA than distros
> configure as default so we should pass this parameter
> through so things work as expected. Fix a spelling
> mistake while we're at it.
>
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  board/raspberrypi/rpi/rpi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index ab5ea85cf9f..d4dbd96bc96 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -540,7 +540,7 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
>         if (fdt == fw_fdt)
>                 return;
>
> -       /* The firmware provides a more precie model; so copy that */
> +       /* The firmware provides a more precise model; so copy that */
>         copy_property(fdt, fw_fdt, "/", "model");
>
>         /* memory reserve as suggested by the firmware */
> @@ -561,6 +561,9 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
>
>         /* address of the PHY device as provided by the firmware  */
>         copy_property(fdt, fw_fdt, "ethernet0/mdio@e14/ethernet-phy@1", "reg");
> +
> +       /* copy the CMA memory setting from the firmware DT to linux */
> +       copy_property(fdt, fw_fdt, "cma", "size");
>  }
>
>  int ft_board_setup(void *blob, struct bd_info *bd)
> --
> 2.46.2
>
