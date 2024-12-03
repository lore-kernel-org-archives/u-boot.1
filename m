Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDBAE64A8A
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 13:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 074AB88875;
	Tue,  3 Dec 2024 14:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z4TxXTIM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 664FC8964B; Tue,  3 Dec 2024 14:17:24 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F150885F7
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 14:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6ef60e500d7so36049847b3.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 05:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733231841; x=1733836641; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vS8+TUDkFDIwF+lbZ0k+xRCBj6HIal7KvPXad/qxdLA=;
 b=Z4TxXTIM7WtdYPZIHZy9KuCAQXUJQQgg2nJtDGL0/UsYWQZp24YQKAXiFmTOjHU62V
 z7dVHxdkrIohvQdGuC093eE03wuFqXLGvXzP0yl0x2Qn4UUUwzYeDWFi+c7F9PJ8l5UZ
 AX8FMa1lmBywVJ0sKKYrw35hIj+iP9kcaAIYtVKqQUt+Yo+AAWXCZbAK8uiTyxgMDBpL
 nRxnsQlTQVbJtQAvx0VY8GftxicCGmDQ+jCR87k8USdP+hcPWdkqGwrC9pJU71YhKb6Q
 p2/PnFrtdrDFETP0w4r2w6nDZ/CGg89VjIWnCIOtoS7Qyhqgq9dpllHk6Fh/dPZLFh3z
 TLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733231841; x=1733836641;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vS8+TUDkFDIwF+lbZ0k+xRCBj6HIal7KvPXad/qxdLA=;
 b=Kx7YfoIF0yfxyPIXjlOT8DxTRbHNMI4wNzl7sOuqH9gvXWOI7HGvyq4I3HArtmrCaY
 l2guyUBTaYSJ6XBF1274/F8cTQSoSxp/F+4p8cVoqBwpei6dRuNfvSMdzkKjEAlNkSHH
 4s2T/QMSJHs9+3rCcEh41Ju2xNU1cokvqcLCk9cmuBlX626aKzSvLeGo+RpMRqaB1H31
 UKMM3PV5ZUrLPY4RtRzIKLjUSBDAFUkJ8sVY3VIYtQhmq5oC6D7R1qCWVOt344m4yGlL
 TJ5WDBfn50BQUs52IzGNciv2HsnrNszWOGGzNyzhYaLNeLkkvMX5gIaXGYA+N8WYFVj1
 j/Uw==
X-Gm-Message-State: AOJu0YzU34icGmXYAPUmnP/NQIW0NeNPmQQHD69I+9wSkLZem1wnWc2Y
 HqNcxMOzhAjPKUgP7wm8g58zssNYQN4BBMj68n2NT2UiJ4VURGPDBBb9B8F/o5Q0HHEJO+WM9Dh
 hT4kQlonYzv1BFl/mLngqoW6OT0jTDABvdj5TpG/EToWi3gCWntI=
X-Gm-Gg: ASbGncs38mdzJY9CDL6Tv4BINmIQD5UwHeCfCEfo+kyNKcn8ZNOkmlaXv8O/I4uI78V
 luSLYqgQioe6TaIgFSxAwzfFWEK9OUV4=
X-Google-Smtp-Source: AGHT+IHenYJmcsVthm0ADmwmCQ+Qsc/6qB+ImtRfWJSx80/8RRX71Z1WBSbFJzTtGIsJC6bHP4nY0sUB6QRYNYMa770=
X-Received: by 2002:a05:690c:6886:b0:6ef:4fba:8151 with SMTP id
 00721157ae682-6efacf5b7b0mr28366117b3.19.1733231840911; Tue, 03 Dec 2024
 05:17:20 -0800 (PST)
MIME-Version: 1.0
References: <20241128144416.604126-1-adrianox@gmail.com>
 <20241128144416.604126-8-adrianox@gmail.com>
In-Reply-To: <20241128144416.604126-8-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 3 Dec 2024 15:16:45 +0200
Message-ID: <CAC_iWjJAKSRGaD0P_S+F40h=Lm-pR10-pRLb_watBz0v9xapqw@mail.gmail.com>
Subject: Re: [PATCH v6 07/14] efi_loader: device_path: add support for HTTP
 device path
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Thu, 28 Nov 2024 at 16:44, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Add efi_dp_from_http to form a device path from HTTP. The
> device path is the concatenation of the device path returned
> by efi_dp_from_ipv4 together with an URI node and an END node.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/efi_loader.h             |  1 +
>  lib/efi_loader/efi_device_path.c | 64 ++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 612bc42816..96b204dfc3 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -872,6 +872,7 @@ struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int part);
>  struct efi_device_path *efi_dp_from_file(const struct efi_device_path *dp,
>                                          const char *path);
>  struct efi_device_path *efi_dp_from_eth(void);
> +struct efi_device_path *efi_dp_from_http(const char *server);
>  struct efi_device_path *efi_dp_from_mem(uint32_t mem_type,
>                                         uint64_t start_address,
>                                         size_t size);
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> index 6fcbc91e0b..a6d4300686 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -1021,6 +1021,70 @@ static struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
>         return dp2;
>  }
>
> +/**
> + * efi_dp_from_http() - set device path from http
> + *
> + * Set the device path to an IPv4 path as provided by efi_dp_from_ipv4
> + * concatenated with a device path of subtype DEVICE_PATH_SUB_TYPE_MSG_URI,
> + * and an END node.
> + *
> + * @server:    URI of remote server
> + * Return:     pointer to HTTP device path, NULL on error
> + */
> +struct efi_device_path *efi_dp_from_http(const char *server)
> +{
> +       struct efi_device_path *dp1, *dp2;
> +       struct efi_device_path_uri *uridp;
> +       efi_uintn_t uridp_len;
> +       char *pos;
> +       char tmp[128];
> +       struct efi_ipv4_address ip;
> +       struct efi_ipv4_address mask;
> +
> +       if ((server && strlen("http://") + strlen(server) + 1  > sizeof(tmp)) ||
> +           (!server && IS_ENABLED(CONFIG_NET_LWIP)))
> +               return NULL;
> +
> +       efi_net_get_addr(&ip, &mask, NULL);
> +
> +       dp1 = efi_dp_from_ipv4(&ip, &mask, NULL);
> +       if (!dp1)
> +               return NULL;
> +
> +       strcpy(tmp, "http://");
> +
> +       if (server) {
> +               strlcat(tmp, server, sizeof(tmp));
> +#if !IS_ENABLED(CONFIG_NET_LWIP)
> +       }
> +       else {
> +               ip_to_string(net_server_ip, tmp + strlen("http://"));
> +#endif
> +       }
> +
> +       uridp_len = sizeof(struct efi_device_path) + strlen(tmp) + 1;
> +       uridp = efi_alloc(uridp_len + sizeof(END));
> +       if (!uridp) {
> +               log_err("Out of memory\n");
> +               return NULL;
> +       }
> +       uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> +       uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
> +       uridp->dp.length = uridp_len;
> +       debug("device path: setting uri device path to %s\n", tmp);
> +       memcpy(uridp->uri, tmp, strlen(tmp) + 1);
> +
> +       pos = (char *)uridp + uridp_len;
> +       memcpy(pos, &END, sizeof(END));
> +
> +       dp2 = efi_dp_concat(dp1, (const struct efi_device_path *)uridp, 0);
> +
> +       efi_free_pool(uridp);
> +       efi_free_pool(dp1);
> +
> +       return dp2;
> +}
> +
>  /* Construct a device-path for memory-mapped image */
>  struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
>                                         uint64_t start_address,
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
