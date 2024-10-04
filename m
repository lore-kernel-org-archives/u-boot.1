Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4505FCFA749
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 06:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7C1888A7D;
	Fri,  4 Oct 2024 08:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eui2dttX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98B0F88FE1; Fri,  4 Oct 2024 08:05:30 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D349889E2
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 08:05:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7e6d04f74faso1478920a12.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 23:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728021926; x=1728626726; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IFgviyANJQAxAGRPzL4eMX1scsx+q6DDfJ7B09GbGEk=;
 b=eui2dttXJeXgkfJlU17iB4CpvnUfSA2sbufbqcq3zrvRjMCyFwZRiQP3e4gXC3H+uN
 3E9ZN45DRLT9jU8HZLT8k+3QpAoTnFUnUj8aTukjKd7wMMvW4wPCuDWi5mjv00lgzwV3
 rvXQM3Em/V5KrBP71HZ9Hc5uD4nRBTNBG4ueIUoRYqAEfvUvLsEOQs8SjY8eBeQ4Zs7f
 UlNYtdVcI0+y5b8bZcpogratLFROYGkiQrCJMKrct9IVc4e/Zg2jKgM7lSXxe4tOdbbw
 ch16DWyf1cJEC5YAOCQSg7wYcntPS7XMYY/y7oSgszsELNCEDC7FB3euV8YDDx3YC4PW
 kKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728021926; x=1728626726;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IFgviyANJQAxAGRPzL4eMX1scsx+q6DDfJ7B09GbGEk=;
 b=BWcsSHKFcockPIyfEvvSCF5nVIUSt/8H97wJ2HZw+mFNKeM/tKKRI2PMVH6hXvOcFs
 gscmLmtM0sGzv1iYFEDI6PlfyhR3K+BMldtOe1eG55BVz7eBwrp4MFFcBuv4XLIvBixG
 fY+fvOLpQcARgp12SuY4dPinbl/9Ko44L1ZypVRVsHcvxKWI4ahQho8fWVYt/Yfm/tC1
 S+s+jq92Z8aqXuJY/bmyekvNPqmTZUpTEjnXqvV6S7i3HIRkYiytMc0lityp8/iuS3l6
 v17eIHdCecb55mFEzw/awujwBP/SjrWkeapJcikrcLDWhBaq2Y5QForyCZV88w2MJQ/l
 Mwkw==
X-Gm-Message-State: AOJu0YwrzbzEqUKEoExjRcNITgnfWG7B20ZLrbSePbK8D7/l0FIKuZZT
 1eXZiMrLv3yF60MeC3g2s12TaVI+76VO2skA+TuDgUyX+dk7/t69OJkdh8VyKb2JeuBJwkloYYa
 xTPKSYVKss7/lhwD0okpgP8UR/J/qTHKzYyUcNA==
X-Google-Smtp-Source: AGHT+IGgufudAWDR+N/xlQ5jxjnhr1DhgIDfx2X3y+prZy2trP023hcicuFAzyepjsG4WbBr3z3AJylSPs+Wo8G0tss=
X-Received: by 2002:a05:6a21:888c:b0:1d6:cbc2:135 with SMTP id
 adf61e73a8af0-1d6d3b0dc39mr7004529637.24.1728021926604; Thu, 03 Oct 2024
 23:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <d8af90bf9124a6c04f1ed2d291a99e1e7f909bac.1727968902.git.jerome.forissier@linaro.org>
In-Reply-To: <d8af90bf9124a6c04f1ed2d291a99e1e7f909bac.1727968902.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 4 Oct 2024 09:04:49 +0300
Message-ID: <CAC_iWj+9zC_PdVT1nk-fV45Kh_YvMFaWH85QC-2Yja+vjLGkQw@mail.gmail.com>
Subject: Re: [PATCH v11 11/29] net: eth-uclass: add function eth_start_udev()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>, 
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Fabio Estevam <festevam@denx.de>, Michal Simek <michal.simek@amd.com>
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

On Thu, 3 Oct 2024 at 18:24, Jerome Forissier
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
