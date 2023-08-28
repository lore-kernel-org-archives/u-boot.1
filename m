Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3C6C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 17:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23E2A86513;
	Mon, 28 Aug 2023 19:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c897UnsX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8447E86507; Mon, 28 Aug 2023 19:55:05 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2119B86430
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 19:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-52a5c0d949eso2661262a12.0
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693245300; x=1693850100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WgD3YUV/0pb5deM8kwQPDwgQvHKqBnu9KsbvuRDapbU=;
 b=c897UnsXEfee8beQaj6peZw++6yIq1x5/lIigflI3wcY6XshIchqkpOeoQwaUdaLoP
 iEZhC2+nkiX8GtsiuW0qoK7CkEyaHBD0hHqQ8xwTKwny6djL6mg+Ax+SYDzDe8u0TWBh
 8SWdwUZ6/QSEdy6F5xgoZihigFF40XVjgNmOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693245300; x=1693850100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WgD3YUV/0pb5deM8kwQPDwgQvHKqBnu9KsbvuRDapbU=;
 b=CzPGL7euwS8+lmLM354Q2/OTAy7+yuYpJcRgn60Yj0s6Y8ie1sypC5f+TD2/Y44ElQ
 EDiXDyAZ1x7KjMUcGj87Qvc2bGZc8zlP24oKb6HZzM4LgfVXBrLlT6Tqyq/fHL3TaEnY
 CJWWNQ3NE+Zgy42nO8mXyd5EoU1EHveT743oVHeKNwVUgbA46vaBfbaDrgenv/+mD7v5
 Q+7xjAmme3G61NIR+a6aUEza518Xu+5LzecRwHzCUoLrgu0wPjzcm8Qq2AUqXoZIncKU
 jC/shd/fbbr7SVo41Kv2/MQtEaXVSOSbyeagG6abqxK+SguSLYyPyZSW05Nlp+0dKNQP
 Frpg==
X-Gm-Message-State: AOJu0YwQryGXiUOTPYSKLDxh3me4eQG/fUCwxx7lmmm69gfA50dNgC2+
 rVP+tDDlfnA+8ejnNd30hQj6b6O1w1ObaYN3Xxi1640zHmJHOYX22Bk=
X-Google-Smtp-Source: AGHT+IE4Rzp5OL2rhB6w8MKo5abK+j0ew9yCN74kfVJCjw3aR/8sInS43SRKOcBlQ1zUGHQPIXrZYNpBY35uNsWjSo4=
X-Received: by 2002:aa7:d843:0:b0:523:95e:c2c0 with SMTP id
 f3-20020aa7d843000000b00523095ec2c0mr17144011eds.42.1693245300625; Mon, 28
 Aug 2023 10:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230828094628epcas2p39068c0277081701446115fec7584ab54@epcas2p3.samsung.com>
 <20230828094617.2060025-1-chanho61.park@samsung.com>
In-Reply-To: <20230828094617.2060025-1-chanho61.park@samsung.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Aug 2023 11:54:47 -0600
Message-ID: <CAPnjgZ1YYHTe_7VZDyCe9OhrmhhdtnOn5szeXfrJma6=Ot39ZA@mail.gmail.com>
Subject: Re: [PATCH] spl: bootstage: move bootstage_stash before jumping to
 image
To: Chanho Park <chanho61.park@samsung.com>
Cc: Nikhil M Jain <n-jain1@ti.com>, Marek Vasut <marex@denx.de>,
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

Hi Chanho,

On Mon, 28 Aug 2023 at 03:46, Chanho Park <chanho61.park@samsung.com> wrote:
>
> For IH_OS_OPENSBI and IH_OS_LINUX, there is no chance to stash
> bootstare record because it will not return after jumping to the image.
> Hence, this patch moves the location of bootstage_stash before jumping
> to image.
>

Please fix your implementation instead. You must jump to the OS at the
end of this function and not before.

In fact I have a patch to move bootstage later in this function!

> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>  common/spl/spl.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 0062f3f45d9a..364d439f65e2 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -850,6 +850,14 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>                                ret);
>         }
>
> +       bootstage_mark_name(get_bootstage_id(false), "end phase");
> +#ifdef CONFIG_BOOTSTAGE_STASH
> +       ret = bootstage_stash((void *)CONFIG_BOOTSTAGE_STASH_ADDR,
> +                             CONFIG_BOOTSTAGE_STASH_SIZE);
> +       if (ret)
> +               debug("Failed to stash bootstage: err=%d\n", ret);
> +#endif
> +
>         switch (spl_image.os) {
>         case IH_OS_U_BOOT:
>                 debug("Jumping to %s...\n", spl_phase_name(spl_next_phase()));
> @@ -890,13 +898,6 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>         debug("SPL malloc() used 0x%lx bytes (%ld KB)\n", gd->malloc_ptr,
>               gd->malloc_ptr / 1024);
>  #endif
> -       bootstage_mark_name(get_bootstage_id(false), "end phase");
> -#ifdef CONFIG_BOOTSTAGE_STASH
> -       ret = bootstage_stash((void *)CONFIG_BOOTSTAGE_STASH_ADDR,
> -                             CONFIG_BOOTSTAGE_STASH_SIZE);
> -       if (ret)
> -               debug("Failed to stash bootstage: err=%d\n", ret);
> -#endif
>
>         if (IS_ENABLED(CONFIG_SPL_VIDEO_REMOVE)) {
>                 struct udevice *dev;
> --
> 2.39.2
>

Regards,
Simon
