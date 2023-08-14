Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADD6C04A94
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:45:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C52586A35;
	Tue, 15 Aug 2023 00:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V3pCshvh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C891C86A19; Tue, 15 Aug 2023 00:43:53 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38B878662F
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-56cb1e602e7so3473140eaf.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692053027; x=1692657827;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nziY+SND9ju4CVT2nzmczDbH+rlGWoGsuV/r6hb7JtM=;
 b=V3pCshvh50gyAsNFY9HOpuuXSLo+8DJ1MavJdf7LJj4D2uBWz++p0h0xnQAfwD8u/s
 JCq+OsTEl/SWYJHeJNRU1UjDB7qbgcmjgeyFWy2PCsVWIsM6u394xTpr1d8F8VJ9SMSU
 Us5vaCexqNQNMktILY1RxbUjhlipNgOYlVWvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692053027; x=1692657827;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nziY+SND9ju4CVT2nzmczDbH+rlGWoGsuV/r6hb7JtM=;
 b=Qz5RXKuvz1MPZdsPGb47Y2vBDa1DWlZ8PUWeB1mY8iHInT/+KiHBWeOjBUE6ZiOgsk
 mS1AdbQ4YRbAlErHa0oFF5XJPVt99d1Jt1L9OP+ZyVC4jxbziMSoqjbo3RC4vMqDCeei
 YEWr4/7iYCXE1lpyVQ3cyP6Exq+gOLQeW7SAC9L7B7KVBgDpYPgAPkTm8cZNJ/gDMAMQ
 rV9wKGCEr6e/HiYfOtoriRO28BXVVzhd/SEL5l5wWp2fePndeku8eOPwWSXIQhO9JivH
 o0GrJ14u0PRSMBaTxIMFTQUgjlGu7R8glapnBec2PRManYt87igOdtmmSP1rO0Y/MXZy
 q4Lw==
X-Gm-Message-State: AOJu0YxH8QfylWY45x8UQlNcmC5LZJNKYQR378muhxd5glBQC1gj0U6G
 0z5n8QuqLMW6sR+2bpxCUFeZ3rRNRE8pm0myXP2tXg==
X-Google-Smtp-Source: AGHT+IH4DZ4bA4MZdJ73EcXA+RarFm+sYyVl0NpszvXHKy2lRd0vMb2znr9W0mBujcW9+NvEb2kypv/h35pDcQrxWTw=
X-Received: by 2002:a05:6358:931b:b0:137:82e6:166e with SMTP id
 x27-20020a056358931b00b0013782e6166emr8786217rwa.18.1692053026618; Mon, 14
 Aug 2023 15:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230813235000.591239-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230813235000.591239-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Aug 2023 16:42:56 -0600
Message-ID: <CAPnjgZ0WWwoRaKif5o=E2KkbYHafs1t4R2dUwGhP1aQ2=hEpAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] blk: Add bounce buffer support to read/write
 operations
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Suchanek <msuchanek@suse.de>, 
 Tobias Waldekranz <tobias@waldekranz.com>
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

Hi Marek,

On Sun, 13 Aug 2023 at 17:50, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Some devices have limited DMA capabilities and require that the
> buffers passed to them fit specific properties. Add new optional
> callback which can be used at driver level to indicate whether a
> buffer alignment is suitable for the device DMA or not, and
> trigger use of generic bounce buffer implementation to help use
> of unsuitable buffers at the expense of performance degradation.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Michal Suchanek <msuchanek@suse.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  drivers/block/blk-uclass.c | 62 ++++++++++++++++++++++++++++++++++++--
>  include/blk.h              | 19 ++++++++++++
>  2 files changed, 79 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
> index 6aac92d9962..885513893f6 100644
> --- a/drivers/block/blk-uclass.c
> +++ b/drivers/block/blk-uclass.c
> @@ -446,6 +446,26 @@ int blk_get_device(int uclass_id, int devnum, struct udevice **devp)
>         return device_probe(*devp);
>  }
>
> +struct blk_bounce_buffer {
> +       struct udevice          *dev;
> +       struct bounce_buffer    state;
> +};
> +
> +static int blk_buffer_aligned(struct bounce_buffer *state)
> +{
> +#if IS_ENABLED(CONFIG_BOUNCE_BUFFER)

I think it is worth adding an accessor in the header file to allow you
to convert this #if to if

> +       struct blk_bounce_buffer *bbstate =
> +               container_of(state, struct blk_bounce_buffer, state);
> +       struct udevice *dev = bbstate->dev;
> +       const struct blk_ops *ops = blk_get_ops(dev);
> +
> +       if (ops->buffer_aligned)
> +               return ops->buffer_aligned(dev, state);
> +#endif /* CONFIG_BOUNCE_BUFFER */
> +
> +       return 1;       /* Default, any buffer is OK */
> +}
> +
>  long blk_read(struct udevice *dev, lbaint_t start, lbaint_t blkcnt, void *buf)
>  {
>         struct blk_desc *desc = dev_get_uclass_plat(dev);
> @@ -458,7 +478,25 @@ long blk_read(struct udevice *dev, lbaint_t start, lbaint_t blkcnt, void *buf)
>         if (blkcache_read(desc->uclass_id, desc->devnum,
>                           start, blkcnt, desc->blksz, buf))
>                 return blkcnt;
> -       blks_read = ops->read(dev, start, blkcnt, buf);
> +
> +       if (IS_ENABLED(CONFIG_BOUNCE_BUFFER)) {
> +               struct blk_bounce_buffer bbstate = { .dev = dev };
> +               int ret;
> +
> +               ret = bounce_buffer_start_extalign(&bbstate.state, buf,
> +                                                  blkcnt * desc->blksz,
> +                                                  GEN_BB_WRITE, desc->blksz,
> +                                                  blk_buffer_aligned);
> +               if (ret)
> +                       return ret;
> +
> +               blks_read = ops->read(dev, start, blkcnt, bbstate.state.bounce_buffer);
> +
> +               bounce_buffer_stop(&bbstate.state);
> +       } else {
> +               blks_read = ops->read(dev, start, blkcnt, buf);
> +       }
> +
>         if (blks_read == blkcnt)
>                 blkcache_fill(desc->uclass_id, desc->devnum, start, blkcnt,
>                               desc->blksz, buf);
> @@ -471,13 +509,33 @@ long blk_write(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
>  {
>         struct blk_desc *desc = dev_get_uclass_plat(dev);
>         const struct blk_ops *ops = blk_get_ops(dev);
> +       long blks_written;
>
>         if (!ops->write)
>                 return -ENOSYS;
>
>         blkcache_invalidate(desc->uclass_id, desc->devnum);
>
> -       return ops->write(dev, start, blkcnt, buf);
> +       if (IS_ENABLED(CONFIG_BOUNCE_BUFFER)) {
> +               struct blk_bounce_buffer bbstate = { .dev = dev };
> +               int ret;
> +
> +               ret = bounce_buffer_start_extalign(&bbstate.state, (void *)buf,
> +                                                  blkcnt * desc->blksz,
> +                                                  GEN_BB_READ, desc->blksz,
> +                                                  blk_buffer_aligned);
> +               if (ret)
> +                       return ret;
> +
> +               blks_written = ops->write(dev, start, blkcnt,
> +                                         bbstate.state.bounce_buffer);
> +
> +               bounce_buffer_stop(&bbstate.state);
> +       } else {
> +               blks_written = ops->write(dev, start, blkcnt, buf);
> +       }
> +
> +       return blks_written;
>  }
>
>  long blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt)
> diff --git a/include/blk.h b/include/blk.h
> index 8986e953e5a..b819f97c2f1 100644
> --- a/include/blk.h
> +++ b/include/blk.h
> @@ -7,6 +7,7 @@
>  #ifndef BLK_H
>  #define BLK_H
>
> +#include <bouncebuf.h>
>  #include <dm/uclass-id.h>
>  #include <efi.h>
>
> @@ -260,6 +261,24 @@ struct blk_ops {
>          * @return 0 if OK, -ve on error
>          */
>         int (*select_hwpart)(struct udevice *dev, int hwpart);
> +
> +#if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
> +       /**
> +        * buffer_aligned() - test memory alignment of block operation buffer
> +        *
> +        * Some devices have limited DMA capabilities and require that the
> +        * buffers passed to them fit specific properties. This optional
> +        * callback can be used to indicate whether a buffer alignment is
> +        * suitable for the device DMA or not, and trigger use of generic
> +        * bounce buffer implementation to help use of unsuitable buffers
> +        * at the expense of performance degradation.
> +        *
> +        * @dev:        Block device associated with the request
> +        * @state:      Bounce buffer state
> +        * @return 1 if OK, 0 if unaligned

We typically return 0 for OK, so that we can use -ve values for
errors. Perhaps flip this to check_aligned() that returns either 0 or
-EINVAL ? I'm just worried that it will be confusing since it is
different from nearly every other DM API.

> +        */
> +       int (*buffer_aligned)(struct udevice *dev, struct bounce_buffer *state);
> +#endif /* CONFIG_BOUNCE_BUFFER */
>  };
>
>  /*
> --
> 2.40.1
>

Regards,
Simon
