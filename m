Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DEED4921D
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 14:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48D18893E7;
	Mon, 18 Nov 2024 15:37:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AsmPsnL6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 313E589461; Mon, 18 Nov 2024 15:37:44 +0100 (CET)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DE648914D
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 15:37:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7fb632bfc0eso1256230a12.0
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 06:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731940660; x=1732545460; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h48x10Ay0crz3jfkmUhOA60M4yojiRrlXNJ5cgJHgSs=;
 b=AsmPsnL6840KknnphCO+LzSen9LXuG/B7Yvulnxnf1yf+tAnccZPHNAq05gqoi4vLU
 CwRmSKyA6hxtxb9O9jEbR9xQCm/n60L5zyoE9+FNWkA3KJ9inKOYJ4snHaEGIBfukoXP
 CWK53zLsZ8VmHgE3+K17dy4SYv5RZ/5e+4OYt29XsSyQV+ryK1o26lOgxfOwV5BJD1M0
 nGsgG+MHvM/8PKwzqeBNTKcNPQs02uaQMVul69VzooWqoZ40qZ+7jeZfDRNLTDjl/mW0
 LBVo0HhKm+sSAo72yEHc66l2s+RPnTGGR4Z0tUQcB/ehbZPupLVRelJPJsOfU7qY+Jvc
 iYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731940660; x=1732545460;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h48x10Ay0crz3jfkmUhOA60M4yojiRrlXNJ5cgJHgSs=;
 b=K2owIdFVKreFd4r3xx77Q2tLI9FdZyQrBG3Bzz8ybPZmw84Wzy0tdAgnMl7//Lp6b6
 54EKLvT3619+Rbd2dBS/BFSleMOwESFsoJJuIGhhUA0kBfmtpNqQ2H0xBY+/qf8YGyxI
 91d7faJCR5XHMu3JsLN2Ds2fnuCgZOQgHxoZ/Du5EZUN4Ywcsoo+O2tecNhjwPfdYW56
 G3vmNZRjzMY+LRg4wdVCCyXgELIo0r8r4TBNF9We4nY/2XwBB9JZBS9YN/A0xRaz35b5
 cprQU6tmX6uHOxJK+JffIAAItk45FZWUeTGW5hQp9tayXOWfNR7MyHxHS+pH8sdHlN+N
 HHDQ==
X-Gm-Message-State: AOJu0YwmYeqQutLrKkXbdFK/V3gUoZSSCekbbfXOaSRcncTSMqC1Kej+
 dg4fjZDNJYCKKUnSFzwZAeYNSmtcSNL67UsVHGSbC3jVZhFcNVW/bF7kdwqeEIVe/KZVnbUN+EA
 zdWZlzGFptpi5/53M1v1RAGZ89h+pX5PNsRrlCA==
X-Google-Smtp-Source: AGHT+IEiHqj5nkIA5d6OB5CJMtAre1smeUH0tR3e6YYVd3+riBBeQ5QaTFAE2C3ZQNJmLHLCe50Oo8p98HhXBAVR70s=
X-Received: by 2002:a05:6a21:7883:b0:1db:e3f6:55f with SMTP id
 adf61e73a8af0-1dc90b37df2mr17458580637.18.1731940660143; Mon, 18 Nov 2024
 06:37:40 -0800 (PST)
MIME-Version: 1.0
References: <20241118143125.2258888-1-jerome.forissier@linaro.org>
In-Reply-To: <20241118143125.2258888-1-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 18 Nov 2024 16:37:03 +0200
Message-ID: <CAC_iWj+m0pGkaL3sOqEDQD_m3PG=VkPb0KDJixDGUyUrQABPRw@mail.gmail.com>
Subject: Re: [PATCH] net: lwip: fix get_udev_ipv4_info()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
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

On Mon, 18 Nov 2024 at 16:31, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> The local variables ipstr, maskstr and gwstr in static function
> get_udev_ipv4_info() cannot be pointers to read-only data, since
> they may be written to in case the device index is > 0. Therefore
> make them char arrays allocated on the stack.
>
> Reported-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reported-by: Adriano Cordova <adrianox@gmail.com>
> Link: https://lists.denx.de/pipermail/u-boot/2024-November/572066.html
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  net/lwip/net-lwip.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
> index 470217781a4..b863047f598 100644
> --- a/net/lwip/net-lwip.c
> +++ b/net/lwip/net-lwip.c
> @@ -91,9 +91,9 @@ struct netif *net_lwip_get_netif(void)
>  static int get_udev_ipv4_info(struct udevice *dev, ip4_addr_t *ip,
>                               ip4_addr_t *mask, ip4_addr_t *gw)
>  {
> -       char *ipstr = "ipaddr\0\0";
> -       char *maskstr = "netmask\0\0";
> -       char *gwstr = "gatewayip\0\0";
> +       char ipstr[] = "ipaddr\0\0";
> +       char maskstr[] = "netmask\0\0";
> +       char gwstr[] = "gatewayip\0\0";
>         int idx = dev_seq(dev);
>         char *env;
>
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
