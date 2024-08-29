Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B915C83F27
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:06:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95FAC88C3C;
	Thu, 29 Aug 2024 16:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZaK7yGfm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E338A88C29; Thu, 29 Aug 2024 16:05:20 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A17D888C2A
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2021537a8e6so5132615ad.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724940317; x=1725545117; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bnQZ7pZyVW/CE9Qe5ysqTZE8+esDSe+LGhFPz2hvVzk=;
 b=ZaK7yGfmbh1UlypGXm3EU8oussXxg3E8/IDYWb9x7T5LN4akSTVUkBR37A/G40UK17
 Ee58yvNGsf5bM00y2lChwJ9MFPFtFTF2ZLPDhcRIIW+WtV3TXpt9WMSybVbb5g37ReN6
 Q4CJQscqsgm91YfknOD5TxbmoSjSrUWIFhKhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724940317; x=1725545117;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bnQZ7pZyVW/CE9Qe5ysqTZE8+esDSe+LGhFPz2hvVzk=;
 b=a6spiiDmcGx2eD/v4e3A0FJVhTjtZHjYKkI8d5jj683XcRwEyJ/X5N1Fpac4GZoJRE
 2LiKm47ezOirDq6SSUXjGKScW3VBMexKKmaGN88v0efO2osgxT5K7KvX204LjcM+JKx/
 KcBgsGpukO2M0Mfo/IoOrQEDjnR470f//mG8YQ6QV/Jt8EMT8G69oBoSysnpWo2vqKeT
 F1VfAd/8o6nEB6ujMyYILbaLwMNJinkr6k4/L50OIQZOvEBGLnynMnsG5BA0KznnTfBT
 D2Og/yJQ/PXK895gcOIpMCImP3vTJhGR+UBv2dOiujd6tW4Lm2MmPy79fHT9CAK5MXO9
 +TRQ==
X-Gm-Message-State: AOJu0YyBHkeydLAOt3SEIMEdrpVGQ4kg3wDvJOo09h9XfPFJhwrPOQMw
 B4r3xbJlCJvm5aAcaKyg2yZYUYKHI3sqNBAZvXtgSP6NrfusjX1VeaVO3LsyC0QAXg1Z2WvKbUa
 NdvF2krm/llgEaTMfcXDqG8QsBL4XskzpFm6/
X-Google-Smtp-Source: AGHT+IFMppliLfuB462GYzXVKxj5j9xXbFkJOendgj0YTn2TWDI+L56kkDXR6GYfWoO4b4/VrWi/fwQzuaJIL35jJGI=
X-Received: by 2002:a17:903:2287:b0:203:a134:78ce with SMTP id
 d9443c01a7336-2050c352d06mr33232015ad.14.1724940316400; Thu, 29 Aug 2024
 07:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <64779fa9e2c5988a347fe7b9ee55fdf03b464fba.1724419624.git.jerome.forissier@linaro.org>
In-Reply-To: <64779fa9e2c5988a347fe7b9ee55fdf03b464fba.1724419624.git.jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 08:05:04 -0600
Message-ID: <CAFLszTju=hPXe5S+Kik=nbNY4sb79eVc9H6wEEnWUnQVYr40Fg@mail.gmail.com>
Subject: Re: [PATCH v9 18/37] net: eth-uclass: add function eth_start_udev()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Anton Antonov <Anton.Antonov@arm.com>, Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Fabio Estevam <festevam@denx.de>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Michal Simek <michal.simek@amd.com>
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

Hi Jerome,

On Fri, 23 Aug 2024 at 07:49, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Add a function to start a given network device, and update eth_init()
> to use it.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
>  drivers/mtd/altera_qspi.c |  4 ++--
>  include/net-common.h      |  1 +
>  net/eth-uclass.c          | 38 +++++++++++++++++++++++++-------------
>  3 files changed, 28 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mtd/altera_qspi.c b/drivers/mtd/altera_qspi.c
> index c26615821c8..e5c8df750b7 100644
> --- a/drivers/mtd/altera_qspi.c
> +++ b/drivers/mtd/altera_qspi.c
> @@ -96,7 +96,7 @@ int flash_erase(flash_info_t *info, int s_first, int s_last)
>         ret = mtd_erase(mtd, &instr);
>         flash_set_verbose(0);
>         if (ret)
> -               return ERR_PROTECTED;
> +               return FL_ERR_PROTECTED;

Could you put these in another patch?

>
>         puts(" done\n");
>         return 0;
> @@ -114,7 +114,7 @@ int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
>
>         ret = mtd_write(mtd, to, cnt, &retlen, src);
>         if (ret)
> -               return ERR_PROTECTED;
> +               return FL_ERR_PROTECTED;
>
>         return 0;
>  }
> diff --git a/include/net-common.h b/include/net-common.h
> index 26674ec7e90..43bc6b9a0d5 100644
> --- a/include/net-common.h
> +++ b/include/net-common.h
> @@ -192,6 +192,7 @@ int eth_env_set_enetaddr_by_index(const char *base_name, int index,
>  int usb_ether_init(void);
>
>  int eth_init(void);                    /* Initialize the device */
> +int eth_start_udev(struct udevice *dev);

Please add a proper function comment to all exported functions.

>  int eth_send(void *packet, int length);           /* Send a packet */
>  #if defined(CONFIG_API) || defined(CONFIG_EFI_LOADER)
>  int eth_receive(void *packet, int length); /* Receive a packet*/
> diff --git a/net/eth-uclass.c b/net/eth-uclass.c
> index e34d7af0229..6dd9b9bb98e 100644
> --- a/net/eth-uclass.c
> +++ b/net/eth-uclass.c
> @@ -284,6 +284,27 @@ static int on_ethaddr(const char *name, const char *value, enum env_op op,
>  }
>  U_BOOT_ENV_CALLBACK(ethaddr, on_ethaddr);
>
> +int eth_start_udev(struct udevice *dev)
> +{
> +       struct eth_device_priv *priv = dev_get_uclass_priv(dev);
> +       int ret;
> +
> +       if (priv->running)
> +               return 0;
> +
> +       if (!device_active(dev))
> +               return -EINVAL;
> +
> +       ret = eth_get_ops(dev)->start(dev);
> +       if (ret >= 0) {

It is better to have the error path jump out, so:

if (ret < 0)
   return ret;

> +               priv->state = ETH_STATE_ACTIVE;
> +               priv->running = true;
> +               ret = 0;
> +       }
> +
> +       return ret;

return 0

> +}
> +
>  int eth_init(void)
>  {
>         struct udevice *current = NULL;
> @@ -328,20 +349,11 @@ int eth_init(void)
>                 if (current) {
>                         debug("Trying %s\n", current->name);
>
> -                       if (device_active(current)) {
> -                               ret = eth_get_ops(current)->start(current);
> -                               if (ret >= 0) {
> -                                       struct eth_device_priv *priv =
> -                                               dev_get_uclass_priv(current);
> -
> -                                       priv->state = ETH_STATE_ACTIVE;
> -                                       priv->running = true;
> -                                       ret = 0;
> -                                       goto end;
> -                               }
> -                       } else {
> +                       ret = eth_start_udev(current);
> +                       if (ret < 0)
>                                 ret = eth_errno;
> -                       }
> +                       else
> +                               goto end;

Can that be just a 'break' ?

>
>                         debug("FAIL\n");
>                 } else {
> --
> 2.40.1
>

Regards,
Simon
