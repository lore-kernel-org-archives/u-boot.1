Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D69ED69113
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A44C789020;
	Thu, 28 Nov 2024 16:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Fpgp+kWy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3C3F88DFE; Thu, 28 Nov 2024 16:11:07 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7155D89020
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6e9f8dec3daso7515417b3.0
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732806664; x=1733411464; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9zG+ZCBnz3gC825FAPRGn5S9V7Fa7fPi9CAG/MM4bZ4=;
 b=Fpgp+kWybXU1tpcovA7H1n47xzbEa7qifoK0DYU+S+AFY1kZN4j14LaQ7jon+FZV5k
 ybEwrynq9oEccmun6xxCQom8JxTu6p7QCn8B3n32ZV/f0cgpVNUtomqC3ALsqMj2QZ7M
 gWUXOQx4d5H6MJuLPTLHouxEjVsqtSnNtDBpS9bTw8jc5LTVozf2rkZPjgDtlK1eqlEC
 Z4q1v9ZIzqR6iPmjG20AP7noRAvaOP9kLFwCENTKCPgP245rjnPEGfGThSk5gJDd5NA/
 6Y3buVw/BxJ/5YJ5KmnYNS+1MFNlwXuRNioCPfGLQyacaeIyEoLNzGipkJuOHM+q4WPy
 hp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732806664; x=1733411464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9zG+ZCBnz3gC825FAPRGn5S9V7Fa7fPi9CAG/MM4bZ4=;
 b=FbKZ/tKaMVlH3g9WAA3uXg3JPyDPEOMHSgnCq/9iZuHBw5yfOGJA8VRF1Ylq6SdYAr
 TuJMz4urrDXdUf2s4pmAivmrMPGO17whx7g4At+km1HnNngEx3FCUOm2aKpZk4djb8Iz
 lHzXEKtEjwR89Pxq0pog0lLEBl4U8CHSNYehv3qIeKpDkD5npRk4trwScPCicY2iBf+F
 OVyXN/QWJofinmYKwTFjsvEWHo5j6T0KtoVj3t+sru4nwZ8aewQ+b6JCYfCADTp3nDgc
 HM3zOyVYE+kQROl/DvTLPgkMR72IxeplaA592apYEmeU7H+t7YGnn9OaL/Td9HfRAura
 9NLg==
X-Gm-Message-State: AOJu0Yzf8uQCEi8BFOXz8CX/NhYznZ2Q8mIw36BO+CrTKamgqqbVZPam
 wQgVro34ZcdfL92rTUz4Zpf7OQrCI7WbQ3m4Gmipj/UgkHkwejt9hbF4ZUTflQg3PwQblnYqicd
 vG+/mcEvP475VkZUBBtfUoR2EWOPdhCmOnpe9yw==
X-Gm-Gg: ASbGnctIUzw+t89WuSCRKWrT1yqZk5UC+nuGPyCMudwy/rACknsdBk66Bl9CmI57APt
 +TTQ6PI5W4j5yS2ujrFckYJKDbkp3dw==
X-Google-Smtp-Source: AGHT+IFWGHEQ0zZLWqf5fU/Oi3UnjRKyWrNA4d40M7DHUA4ESzm5Z2U6zJhE/CWkrS74xgCGi4OKskjlOEkgnsuiMj0=
X-Received: by 2002:a05:690c:67c7:b0:6dc:7877:1ea3 with SMTP id
 00721157ae682-6ef371fdbdfmr83316507b3.17.1732806664289; Thu, 28 Nov 2024
 07:11:04 -0800 (PST)
MIME-Version: 1.0
References: <20241128143704.590211-1-adrianox@gmail.com>
In-Reply-To: <20241128143704.590211-1-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 28 Nov 2024 17:10:28 +0200
Message-ID: <CAC_iWjJAw96K_t3R-fywHvYh__r6dsyeiVvDfdg8TxdS+As8fA@mail.gmail.com>
Subject: Re: [PATCH] lwip: wget: Fix incorrect rebase of 5907c81 on top of
 5907c81
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de, trini@konsulko.com
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

Hi Adriano,

On Thu, 28 Nov 2024 at 16:37, Adriano Cordova <adrianox@gmail.com> wrote:
>
>   Commit 5907c81 ("net: lwip: Enable https:// support for wget") was not
>   correctly rebased on top of the changes introduced by Commit 6cc4d04
>   ("net/lwip: wget: put server_name and port into wget_ctx") in next.
>   This commit re-applies a  couple of lines from 6cc4d04.
>
>   Fixes: Commit 5907c81 ("net: lwip: Enable https:// support for wget")

Does it fix anything in -next? Fixes tags are used on actual fixes

Other than that
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>  net/lwip/wget.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index af48d741a4..8b3e5cf29b 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -288,7 +288,6 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
>
>  static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>  {
> -       char server_name[SERVER_NAME_SIZE];
>  #if defined CONFIG_WGET_HTTPS
>         altcp_allocator_t tls_allocator;
>  #endif
> @@ -297,7 +296,6 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>         struct netif *netif;
>         struct wget_ctx ctx;
>         char *path;
> -       u16 port;
>         bool is_https;
>
>         ctx.daddr = dst_addr;
> @@ -307,7 +305,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>         ctx.prevsize = 0;
>         ctx.start_time = 0;
>
> -       if (parse_url(uri, server_name, &port, &path, &is_https))
> +       if (parse_url(uri, ctx.server_name, &ctx.port, &path, &is_https))
>                 return CMD_RET_USAGE;
>
>         netif = net_lwip_new_netif(udev);
> --
> 2.43.0
>
