Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98342D5E38F
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 09:20:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04973889EF;
	Sun, 10 Nov 2024 10:20:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v1gonw0C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D1AA88B9E; Sun, 10 Nov 2024 10:20:23 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02E8A889D2
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 10:20:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7d4f85766f0so2608413a12.2
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 01:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731230419; x=1731835219; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HrWrVWXRyRxSgzxrrqIi6EcmYcGMbElOpfJay70aG8I=;
 b=v1gonw0CFx+M9NNZXLJ8mFMikLtr9gMhCW23V9eJID4AWDzaQu+ZiacU6AeU9frGuk
 CIpRfcIOh2aphuyazHlm3l42v7sEn1XFNoSm7+NpktnP4JoUml49grYnA0umUCxZA6ge
 SzgdulkvmxwRQk0mjQyvhhT0CnRGuALwaDay+TS9SdMeXxqWqrp7FbX1+ChI2dYAd3kF
 JhO703PRUdejG3o2AtL/XasO2DFShqhS635v7qE3Gmd9vZkWHz6m4NrZHptV/nB2T72u
 bxIW6t0t1vFLg43gE2AciOeG1DFg7hFS36vhcBmv0nVK5DhkYGqCpM0uFvusP/3ET153
 ChQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731230419; x=1731835219;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HrWrVWXRyRxSgzxrrqIi6EcmYcGMbElOpfJay70aG8I=;
 b=f98fo1aUQfRaOcy9u2hngE/9YTXcj8T3pE0u5pFq6CsBW7kmsqwVXMCRnUAV461BVO
 JGMv9btLFSI6xrUn8KFhabU1zjg/T0J5oPyzNYv/tG13b5J/DunEQyIef6qpf4C2exdw
 19k7IwWjBuLpE8y9KIWmb4gpShJbNxLOkud6Y4TW31bY5/ZzVr3bEvvUEb//qxBYxzgf
 0nMV2f3XlgMEkzCEShR2a/BwgoTXI4ADFaO+dfNZWXmDahxjJ1J+KU5tVgRn8kf+0dw0
 4NiZKIpc0gCXnfhoab2JGlRNUa3h9D/aG4y1+cd90DEkZdZkQ2xuo4aOkht6QVYbnWem
 nzmg==
X-Gm-Message-State: AOJu0Yz9/XiJx7XXtyL2RTJYwZs13yMQReZeMWpFrRACphRb3X6dTM4+
 MUIw7exhlg8giMgjfIZt6WovuAC8dKruhwl/R2LfBUEsV9Ck4VSc9Me0hiUpvxBNFD3nFmZI5zk
 xD2YFO9H1YQQhRseOyon7LO2D0hg/hSRGXRiM1g==
X-Google-Smtp-Source: AGHT+IHD7ZDWzwivWfaWFkXQfhLeefv10CoD+Qf6wOUBEGxVFU8suOCh59Cj2Vx/qZjdA3sVvPu+ogRXtQ2KeM9cfK4=
X-Received: by 2002:a17:902:f541:b0:20c:805a:524 with SMTP id
 d9443c01a7336-2118359b305mr125565485ad.39.1731230419421; Sun, 10 Nov 2024
 01:20:19 -0800 (PST)
MIME-Version: 1.0
References: <20241108133850.431075-1-adrianox@gmail.com>
 <20241108133850.431075-9-adrianox@gmail.com>
In-Reply-To: <20241108133850.431075-9-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 10 Nov 2024 11:19:43 +0200
Message-ID: <CAC_iWjK4XMr4gKe=0fNpYj19nWcnaghJ43Fi8xHF_z7YF3_Y1g@mail.gmail.com>
Subject: Re: [PATCH v2 08/15] efi_loader: device_path: add support for HTTP
 device path
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de
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

On Fri, 8 Nov 2024 at 15:40, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Add efi_dp_from_http to form a device path from HTTP. The
> device path is the concatenation of the device path returned
> by efi_dp_from_ipv4 together with an URI node and an END node.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>  include/efi_loader.h             |  1 +
>  lib/efi_loader/efi_device_path.c | 51 ++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 44d29e7967..ab79364857 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -872,6 +872,7 @@ struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int part);
>  struct efi_device_path *efi_dp_from_file(const struct efi_device_path *dp,
>                                          const char *path);
>  struct efi_device_path *efi_dp_from_eth(void);
> +struct efi_device_path *efi_dp_from_http(const char *server);
>  struct efi_device_path *efi_dp_from_mem(uint32_t mem_type,
>                                         uint64_t start_address,
>                                         uint64_t end_address);
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> index 3e02341224..dc79a61196 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -1012,6 +1012,57 @@ struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
>         return dp2;
>  }
>
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
> +       efi_net_get_addr(&ip, &mask, NULL);
> +
> +       dp1 = efi_dp_from_ipv4(&ip, &mask, NULL);
> +
> +       strcpy(tmp, "http://");
> +
> +       if (server) {
> +               memcpy(tmp + strlen("http://"), server, strlen(server) + 1);

We need some sanity checking here, since the server name is a user
input and might overflow tmp

> +       } else {
> +#ifdef CONFIG_NET_LWIP

#iif IS_ENABLED is preferred here
> +               // The lwip stack does not set env variables for server
> +               efi_free_pool(dp1);
> +               return NULL;

Can you move this checking on top? You can avoid alloc/free buffers is
LWIP is enabled and we domnt have a server

> +#else
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

Thanks
/Ilias
