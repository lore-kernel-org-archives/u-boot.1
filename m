Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DA6CCFA16
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 18:52:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E12A58903E;
	Mon, 30 Sep 2024 20:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HsFcq6II";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84C1789066; Mon, 30 Sep 2024 20:52:16 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E20887D1A
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 20:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7a9af813f6cso439979385a.3
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 11:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727722333; x=1728327133; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZKJ/mbE3d7buPU6hJtojuMajq6kWlRlCYpTN5D/3FfE=;
 b=HsFcq6II3mb2JxS8oUMSJNm1ysePhcV8XtP5IPPW1350d6RMEG4jmILAQ6HxQSHLyF
 898ISd9ZoKMFtkHvg8lALYj+gKKALP7tST1UCEfN/frXvi6tE9Iy5P+gAx/Tr7hmOYr6
 iAp4udESub9jlXX3bJF5D3UVwXKR6FEThvIlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727722333; x=1728327133;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZKJ/mbE3d7buPU6hJtojuMajq6kWlRlCYpTN5D/3FfE=;
 b=eiOQvnVA3w4K6CxRpxwXnIClnH9zxiyCfWKDE3ymdCDqj/QmMmDVC+eMMz14BJAWNR
 gT7lWbP/R/ipbF97iHvfL6R5d3TxSa2h3LeYE+aWVklJY4ofXiXVRaKaAZ3n12Yiuors
 VS1pTAQ3t1FBaMvhou5BIWHf1RugHUwOQrRgSFi52nO9qYn8TJjBmRd/7jxlXoIpNIUv
 tt/hxlWt1agPu4dfTnd5d8E5Z49+sWNUSFQEQSvEiSBNLWnuww3GKligkNup5WgZSXHG
 c1K1LdBw7mqlR1dKB0EtnIwg7nPWWqFGMIq2BCwdYY/BSL5Tg/uIu/BstNoREYAq3FIr
 ylSQ==
X-Gm-Message-State: AOJu0YwMbaUUUyvNM//ocLKLy1RDicpK36/5r2KsqivhHRV/oLygkG9h
 fbUE35BbfTGTATq6eYJJxq1NqR/5m+dlNn3kgsqYuRzJBqcFrZoHMVlT6lOr/YZ/XFsh7cnmF5W
 0RzYlaTkHpDyFPeOMnrfkBMYJJg3b4BDHq1FB
X-Google-Smtp-Source: AGHT+IG7oCYbOVq7L1m/DF85VXxcxANF00nTG3XYnI2P/PMhfTSVe+xeNbY2Pwi/O0Mj4JWuz2UgtpGCHPt5cLD78Ik=
X-Received: by 2002:a05:6214:33c5:b0:6cb:4def:4ce4 with SMTP id
 6a1803df08f44-6cb4def4dd3mr137677936d6.32.1727722333180; Mon, 30 Sep 2024
 11:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240929125342.2758708-1-alice.guo@oss.nxp.com>
In-Reply-To: <20240929125342.2758708-1-alice.guo@oss.nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 30 Sep 2024 12:52:02 -0600
Message-ID: <CAFLszTjy1JY4Rhvd4f=nq1+9Fzwn0oo6V=mRLq5Bj8L6_LL5UQ@mail.gmail.com>
Subject: Re: [PATCH v1] mailbox: support timeout when sending
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com, ye.li@nxp.com, 
 Alice Guo <alice.guo@nxp.com>
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

Hi,

On Sun, 29 Sept 2024 at 06:54, <alice.guo@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Add timeout support for mbox_send.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> ---
>  drivers/mailbox/mailbox-uclass.c | 19 ++++++++++++++++++-
>  include/mailbox.h                |  2 ++
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/mailbox-uclass.c b/drivers/mailbox/mailbox-uclass.c
> index 4bf4987ce0..0ca8b3770f 100644
> --- a/drivers/mailbox/mailbox-uclass.c
> +++ b/drivers/mailbox/mailbox-uclass.c
> @@ -117,10 +117,27 @@ int mbox_free(struct mbox_chan *chan)
>  int mbox_send(struct mbox_chan *chan, const void *data)
>  {
>         struct mbox_ops *ops = mbox_dev_ops(chan->dev);
> +       ulong start_time, timeout_us;
> +       int ret;
>
>         debug("%s(chan=%p, data=%p)\n", __func__, chan, data);
>
> -       return ops->send(chan, data);
> +       start_time = timer_get_us();
> +       timeout_us = chan->tx_timeout_us;
> +       /*
> +        * Account for partial us ticks, but if timeout_us is 0, ensure we
> +        * still don't wait at all.
> +        */
> +       if (timeout_us)
> +               timeout_us++;
> +
> +       for (;;) {
> +               ret = ops->send(chan, data);
> +               if (ret != -EBUSY)
> +                       return ret;
> +               if ((timer_get_us() - start_time) >= timeout_us)

get_timer_us_long(start_time) >= timeout_us

would be better here as it is designed to do the maths for you!

> +                       return -ETIMEDOUT;
> +       }
>  }
>
>  int mbox_recv(struct mbox_chan *chan, void *data, ulong timeout_us)
> diff --git a/include/mailbox.h b/include/mailbox.h
> index e70266fb61..3cc64f20b7 100644
> --- a/include/mailbox.h
> +++ b/include/mailbox.h
> @@ -46,6 +46,7 @@ struct udevice;
>   *
>   * @dev: The device which implements the mailbox.
>   * @id: The mailbox channel ID within the provider.
> + * @tx_timeout_us: The tx timeout in us.
>   * @con_priv: Hook for controller driver to attach private data
>   *
>   * Currently, the mailbox API assumes that a single integer ID is enough to
> @@ -61,6 +62,7 @@ struct mbox_chan {
>         struct udevice *dev;
>         /* Written by of_xlate.*/
>         unsigned long id;
> +       unsigned long tx_timeout_us;

ulong

>         void *con_priv;
>  };
>
> --
> 2.34.1
>

Please also update test/dm/mailbox.c so this new feature is tested in
CI. You can use timer_test_add_offset() in a test to add to the
current (faked) time.

Regards,
Simon
