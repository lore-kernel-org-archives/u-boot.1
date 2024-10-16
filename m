Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DEAD1AD55
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 13:32:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB77588B99;
	Wed, 16 Oct 2024 15:32:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tFEeANDu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D0AC88D54; Wed, 16 Oct 2024 15:32:47 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCFF188B99
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 15:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7e6ed072cdaso4274965a12.0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 06:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729085563; x=1729690363; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K5bLIRpAet22h9MteD53rhXgi9tJfA+zBj08HQWxYFk=;
 b=tFEeANDufwEsGlo+QNt46K60RP3OYJwbu9cpbM4ngPWuTtHWxXbjs88boTljLEpfYT
 nO2H2bzzcnM+2jKucxACmf8atESe/S4yCNQzD2zBfTjk5IxChPMhGeZy0Mfgv/dKugrS
 Dk5cUpUkoUtYjb5VGFvzaMGXSN5EFHH1ps2SL/9pPhTAXAV/2aXIFo3B18xsKN6qA4HJ
 QNGMJ1FAd+Ehg27ucIkcPfqfPziQA/ed1HufMHDVIZeuT99ePNsfiOdIv7b4JjOq4PFg
 PXkWBlSJc6NtYgCk2RvmIfkpzDUSgXVbuNUGRDAjaIjUeqXDHC66GJF3Bx2NTWRQqrqj
 HFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729085563; x=1729690363;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K5bLIRpAet22h9MteD53rhXgi9tJfA+zBj08HQWxYFk=;
 b=nUTSSaNQhLULO/mRfW6cEdUyZmY6FS2YUo5hygNt12YyNKKQlBf3YbsWjHZi1VZ03D
 OKEuwppYSVKZ5smPPog3rk2VlkJPej89tyIanXRr3dfdR7OOQQGie31/C1oU6lAEZQ0z
 F0nrMy2Ow2iwYK9eU8T9CWSgFIpckTg2YiFds5E7wVYgz27uENvViuJsYO2005QGOVqG
 FA4nGFaxSTmnP6iN9bGbtLBRM3RFeLN4+6QRJJ2Q79NadEfaBoi4/N/4u8HyZEQHx87H
 P059sku3amkTVwWhDQ6kdDIaLP+SKb24/A9EjakNjv6KENJ5l86rmYQrZsZDVthZnWNU
 cSPw==
X-Gm-Message-State: AOJu0YyB6E3bWuHwsyEclIZAlSKxd7HyqZF/CsPtl9TB1KjNqDTH2CcV
 HNwnI5F0XDBUgv4zk0EtzXfmkBARnT4DpUri8WAcscJ4mF9Tkmcgi9GCk62mE0d1toEAR28c/OG
 ww/cJFrG2hLBtnDZIjiZYXqrADBrr6Af15f/ZkA==
X-Google-Smtp-Source: AGHT+IETS0aTQrTYpLoLsmNkj0Cj7I/aGXd0Ktva/XG13tGPMwMMPXM2r5YC9JQmSCGPqNWC5YBc/B4GJ6PgTebX0Ys=
X-Received: by 2002:a17:90b:3751:b0:2e2:de27:db08 with SMTP id
 98e67ed59e1d1-2e3152e9b91mr18968638a91.23.1729085563238; Wed, 16 Oct 2024
 06:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1729070678.git.jerome.forissier@linaro.org>
 <c3e956e94127fb826afbfd8218257626a156e371.1729070678.git.jerome.forissier@linaro.org>
In-Reply-To: <c3e956e94127fb826afbfd8218257626a156e371.1729070678.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 16 Oct 2024 16:32:07 +0300
Message-ID: <CAC_iWjJ=zjecYhdXJc4pCAeC5zxct4Mq0333nn9-XfT6G3yv6w@mail.gmail.com>
Subject: Re: [PATCH v13 07/21] net: eth-uclass: add function eth_start_udev()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>, 
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Fabio Estevam <festevam@denx.de>,
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

On Wed, 16 Oct 2024 at 13:04, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Add a function to start a given network device, and update eth_init()
> to use it.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  include/net-common.h |  1 +
>  net/eth-uclass.c     | 38 +++++++++++++++++++++++++-------------
>  2 files changed, 26 insertions(+), 13 deletions(-)
>
> diff --git a/include/net-common.h b/include/net-common.h
> index 543f528a4a4..6bc76658d9d 100644
> --- a/include/net-common.h
> +++ b/include/net-common.h
> @@ -192,6 +192,7 @@ int eth_env_set_enetaddr_by_index(const char *base_name, int index,
>  int usb_ether_init(void);
>
>  int eth_init(void);                    /* Initialize the device */
> +int eth_start_udev(struct udevice *dev); /* ->start() if not already running */
>  int eth_send(void *packet, int length);           /* Send a packet */
>  #if defined(CONFIG_API) || defined(CONFIG_EFI_LOADER)
>  int eth_receive(void *packet, int length); /* Receive a packet*/
> diff --git a/net/eth-uclass.c b/net/eth-uclass.c
> index e34d7af0229..5555f82f23e 100644
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
> +       if (ret < 0)
> +               return ret;
> +
> +       priv->state = ETH_STATE_ACTIVE;
> +       priv->running = true;
> +
> +       return 0;
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
> +                               break;
>
>                         debug("FAIL\n");
>                 } else {
> --
> 2.40.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
