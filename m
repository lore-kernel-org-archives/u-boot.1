Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1565ED41C15
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 08:16:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 560FE88E2B;
	Wed, 13 Nov 2024 09:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QjlyKeFE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E624388EC6; Wed, 13 Nov 2024 09:16:36 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9371B88B16
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 09:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e2a97c2681so5133856a91.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 00:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731485793; x=1732090593; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C/AOzTgyzsh4uZyzaIpcYX63u8X0uAVaBxdaUEI/qOU=;
 b=QjlyKeFERX2p1lHZBGPjDcFUktWmEEoeDxlVhQrkL8nItzlSXLESw03loJjmjsTnej
 Ou4h79bUqUR8fq61/KfA9gTjRwp/qYAcWEvEvoc1mXocfCgY+jfrNN8GwyDhQqA64NOS
 emFWdDjWtqStd6NdgBXI2uzNPAOrabQvU8RLotnR1cKvmqovwzdcBhBJdk7i+WeH/hVg
 bpT5R0tiX/KfhLX+DbMjM1h7oOiD53LPjZ+snqRs97Fe475XE/LyyyHsUVgQl4gV2kZ8
 kZegvuWaNd03zJWrURkk9q0/iyLBrGbOldkpq5z7ic4PZUVKOERSxgFQSVvFC59ib+m2
 1ZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731485793; x=1732090593;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C/AOzTgyzsh4uZyzaIpcYX63u8X0uAVaBxdaUEI/qOU=;
 b=C7ehVp4qE4emQB3sQvPhmPQcRi8AwNgaDms7n9n+Nl7qYyvJDgfnA0Jiu3NW/GUVFa
 fd2Z0YyOMAKuMIv6guv9jctyGhvopbGmfmaIYB6ozD1iqiBOjTXW+man4P9TP1zj9tuN
 fcXL8FYlpEMaMhKUasQ7WF9uYncqxuHE2dJdNU6+Un9VIfZZ8H9NYeE+h6kdh2U005NI
 qqh3qechtC7HskNybaV8oQH3iS+6hueJOe6YF2U47povEIkomstR3xBttS3iWPyXfhDX
 6ZRkWVj973Rt6dxK2CCW/ppRKqEkI+dwFkMqoLZSiBrHbC0FbYvaveadJWu1lh0vtbG3
 04SQ==
X-Gm-Message-State: AOJu0YwzOq1EHkgM2RIFCKV+t9CJU65hn1I+0oodCWaJNvPRSfhk2K9B
 7+ozo9MfpbaPeK9JyMmN0im2pvgCL49HOie3AVj4Iv9azSWTMN3casbN0RFRzPUk89NrFdfjdUQ
 R2WVlNQRlaIh8RkQuWdwsl5yHqdmVhEUAyMQrpA==
X-Google-Smtp-Source: AGHT+IEgGK4gxUAzJg+MvU8BbyFeylnXUyZnoTBNm6VmA3vyU4Qh6BOFMG+dB7PZK86KJo7Rp/OzjDZp/ps3bztABCI=
X-Received: by 2002:a17:90b:3b43:b0:2e0:b5c8:9ca2 with SMTP id
 98e67ed59e1d1-2e9e4ada73emr7546231a91.9.1731485793080; Wed, 13 Nov 2024
 00:16:33 -0800 (PST)
MIME-Version: 1.0
References: <20241111210959.560738-1-adrianox@gmail.com>
 <20241111210959.560738-9-adrianox@gmail.com>
In-Reply-To: <20241111210959.560738-9-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 Nov 2024 10:15:57 +0200
Message-ID: <CAC_iWjJMtqGfON-feNhbWSPHZz9BEzZqbriV6byDmyEbkkazdw@mail.gmail.com>
Subject: Re: [PATCH v3 08/15] efi_loader: device_path: add support for HTTP
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

On Mon, 11 Nov 2024 at 23:10, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Add efi_dp_from_http to form a device path from HTTP. The
> device path is the concatenation of the device path returned
> by efi_dp_from_ipv4 together with an URI node and an END node.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>
> Changes in v3:
> - Moved argument checks in efi_dp_from_http to the beginning of the function
>
>  include/efi_loader.h             |  1 +
>  lib/efi_loader/efi_device_path.c | 55 ++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
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
> index 82a45da1fa..158f08b9e5 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -1012,6 +1012,61 @@ struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
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
> +       if ((server && strlen("http://") + strlen(server) + 1  > 128)

sizeof (tmp) instead of 128

> +           (!server && IS_ENABLED(CONFIG_NET_LWIP)))
> +               return NULL;
> +
> +       efi_net_get_addr(&ip, &mask, NULL);
> +
> +       dp1 = efi_dp_from_ipv4(&ip, &mask, NULL);
> +
> +       strcpy(tmp, "http://");

I've sent this a while back which is close to merging [0]. I am ok
with merging http support first, but if it's not too much of a pain
can you rebase on top of that and add https:// as well?

> +
> +#if IS_ENABLED(CONFIG_NET_LWIP)
> +       if (server) {
> +               memcpy(tmp + strlen("http://"), server, strlen(server) + 1);
> +       }
> +#else
> +       if (server) {
> +               memcpy(tmp + strlen("http://"), server, strlen(server) + 1);
> +       } else {
> +               ip_to_string(net_server_ip, tmp + strlen("http://"));
> +       }
> +#endif
> +

I think it's easier to read if you rewrite this as
if (server)
    memcpy(tmp + strlen("http://"), server, strlen(server) + 1);
else
     if (!IS_ENABLED(CONFIG_NET_LWIP)
         ip_to_string(net_server_ip, tmp + strlen("http://"));

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

[0] https://lore.kernel.org/u-boot/20241110083017.367565-1-ilias.apalodimas@linaro.org/

Thanks
/Ilias
