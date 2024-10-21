Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FB6D0E6EE
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 10:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1362988E8A;
	Mon, 21 Oct 2024 12:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XxUtZ8/1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C00F788EE4; Mon, 21 Oct 2024 12:50:02 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63BC088E8A
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 12:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20c6f492d2dso49564285ad.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 03:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729507799; x=1730112599; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v8k5PIKBIeCo5QAeNWfkAiqSNI66xPvOn+fpTNETgUw=;
 b=XxUtZ8/1JEdifd1L0WQwi3eulxpobysctqhfcUo2ojJqDs/bDwYuEvp6zMyVh+0cFe
 tmzP1VAY0GLFpd50XNHI4TDNHL3oVpTUvs5jHqmUVENTC3ZMrgJrmllZMEuHQxf+jsn7
 nsJSBjjp2tSclBPQuRTgnK9VN2sfzX5q4O5YPa1YFf/YrXLT+a8EHW08LJ+I5xz9NXBp
 zMA/VlAhZYs6aNAdR5HNF0tNTQ0mgil3ZDa5hyjUCglN1HWN/7KSqkFDcczApdIPE9/n
 YMDJ3bPp+uXisImZucx6gu66+QhQHkdsI4VzpwA3muXW6YSNHHI0r9jFX1s3OH5klmso
 fqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729507799; x=1730112599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v8k5PIKBIeCo5QAeNWfkAiqSNI66xPvOn+fpTNETgUw=;
 b=AhAUL/PZ91TRdj07RsVt3/uyF2NDpSQ/YBoPtoW8j7Kg2wKAMNh4f50FLkMTG4G8QX
 PcjDXFa+uW/jZ7TRYKKhYmuEp8eRA7h2CEFvFnTHbt7d5eGxTxenTl+waCZOzWCx0yur
 tt5kTR9fevidfBCYjujNXC0rS0xDVs3DwGuBmwOeloNsMOIlOv5gUMgfhpld3hwxx9dQ
 XD6MxdIjhBV0IRnz8iKNkXTLKcblm+m/wdQ2WVdyVFJ2Jwg5OD4+jJhJPCmvV/k9xcIZ
 uYt5+LTUdnb6wAzeGi3KU0GkPUNjn8fys+hbO+LKx7DiS+h9sSHRIAC/uH65I7JHq01x
 j73A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgwXggZtawjMkQP+rxK4oGnadMuZu3Hf7ReVNRGmuGewc7WG93q1offCdLid0DmvR2MtJndhw=@lists.denx.de
X-Gm-Message-State: AOJu0YwSef1GZYufG2t+jN+yjxC0/GohZZXJLZL7773J02KFaIK+8R1V
 x3gnu3HB/4Nc1fnPeqcXSrkPhzo31773VhsKphT1S8CYrfsuw5F1fHBHul5AzD3v6gKR9dPjfMj
 AezOG5rFtVrzIzLq65U1s4QH1QVaoDAnxvBwILA==
X-Google-Smtp-Source: AGHT+IGECR+Pw5S12+DsfK7z5U+Oeag859dcXAzbCx1ug7w2mMouxOxLmInkljQEzquKFanTqarSh2ReI7eQwZbNmWQ=
X-Received: by 2002:a17:90a:b701:b0:2e2:8bce:3d16 with SMTP id
 98e67ed59e1d1-2e56172acf8mr13499431a91.19.1729507798889; Mon, 21 Oct 2024
 03:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20241018013015.127620-1-heinrich.schuchardt@canonical.com>
 <20241018013015.127620-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241018013015.127620-4-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 21 Oct 2024 13:49:22 +0300
Message-ID: <CAC_iWjL-tBww8AV9vjGez0YpbC9g_bRcYoS1aPbMWFJm0Ep+pA@mail.gmail.com>
Subject: Re: [PATCH 3/3] block: make blk_create_device() static
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@denx.de>, 
 Alexey Romanov <avromanov@salutedevices.com>, Johan Jonker <jbx6244@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
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

On Fri, 18 Oct 2024 at 04:30, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> There are no users of the blk_create_device() function outside the uclass.
> Let's make it static. This will ensure that new block drivers will use
> blk_create_devicef().
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/block/blk-uclass.c | 19 ++++++++++++++++---
>  include/blk.h              | 17 -----------------
>  2 files changed, 16 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
> index 312e038445c..f3ac8db9464 100644
> --- a/drivers/block/blk-uclass.c
> +++ b/drivers/block/blk-uclass.c
> @@ -695,9 +695,22 @@ static int blk_claim_devnum(enum uclass_id uclass_id, int devnum)
>         return -ENOENT;
>  }
>
> -int blk_create_device(struct udevice *parent, const char *drv_name,
> -                     const char *name, int uclass_id, int devnum, int blksz,
> -                     lbaint_t lba, struct udevice **devp)
> +/**
> + * blk_create_device() - Create a new block device
> + *
> + * @parent:    Parent of the new device
> + * @drv_name:  Driver name to use for the block device
> + * @name:      Name for the device
> + * @uclass_id: Interface type (enum uclass_id_t)
> + * @devnum:    Device number, specific to the interface type, or -1 to
> + *             allocate the next available number
> + * @blksz:     Block size of the device in bytes (typically 512)
> + * @lba:       Total number of blocks of the device
> + * @devp:      the new device (which has not been probed)
> + */
> +static int blk_create_device(struct udevice *parent, const char *drv_name,
> +                            const char *name, int uclass_id, int devnum,
> +                            int blksz, lbaint_t lba, struct udevice **devp)
>  {
>         struct blk_desc *desc;
>         struct udevice *dev;
> diff --git a/include/blk.h b/include/blk.h
> index 1fc9a5b8471..261c7dd6616 100644
> --- a/include/blk.h
> +++ b/include/blk.h
> @@ -376,23 +376,6 @@ int blk_first_device(int uclass_id, struct udevice **devp);
>   */
>  int blk_next_device(struct udevice **devp);
>
> -/**
> - * blk_create_device() - Create a new block device
> - *
> - * @parent:    Parent of the new device
> - * @drv_name:  Driver name to use for the block device
> - * @name:      Name for the device
> - * @uclass_id: Interface type (enum uclass_id_t)
> - * @devnum:    Device number, specific to the interface type, or -1 to
> - *             allocate the next available number
> - * @blksz:     Block size of the device in bytes (typically 512)
> - * @lba:       Total number of blocks of the device
> - * @devp:      the new device (which has not been probed)
> - */
> -int blk_create_device(struct udevice *parent, const char *drv_name,
> -                     const char *name, int uclass_id, int devnum, int blksz,
> -                     lbaint_t lba, struct udevice **devp);
> -
>  /**
>   * blk_create_devicef() - Create a new named block device
>   *
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
