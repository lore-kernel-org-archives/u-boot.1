Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7582D41C31
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 10:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5250789544;
	Wed, 13 Nov 2024 11:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fK53snFQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8500F89554; Wed, 13 Nov 2024 11:38:38 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BE0D8953C
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 11:38:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7e9e38dd5f1so5095495a12.0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 02:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731494315; x=1732099115; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0y3DP4eB9cretbmHvtonRFnfeakZrTQzs0Lh0NAeRuU=;
 b=fK53snFQcEFKP9xdiO7Pll9t5sYLcsR626ABa43IvG/Koq9oEkcDZu9wtX6mn9h6Wa
 l+zkXTCaM/gvwgwP5uArQSH2t/vqFVswjXe3oh2b+1dPVxzusASZAaUgR02FL9dqksD0
 wSLP5GGhiHQmM5nnpYmvfx+FYAveA3xxHtoGGBYr8Ih4DkveQpeXa5tb5bJbZNvW0va1
 LmPe35Nb4NdV/cWlPxyF7WDCYVr2gyjZKce4+UX1HeSytbP6IU+eIzvVASUeGxrLfdZK
 /zwriYaz1PJMwY7q5QCw1JICAPcDkws9X9gk56ESBMzY20Np01MlJ5xrfvIoETcqIt3B
 5OQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731494315; x=1732099115;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0y3DP4eB9cretbmHvtonRFnfeakZrTQzs0Lh0NAeRuU=;
 b=BS/e/K1FYF2IaAssu2GstCd3WkY3EDz6EERRvJ5MiN+ykhlVv9JO45+ACfGVdo2NKc
 kC9bYdUgX945U3ZpR92kPz1tjcOAjAQAmFom5p3NvBUk6le4h0Y7GnBvMhz4qmSCKjVm
 OSKhgxEuSiTvkgajKrI9FuUP5JsPqQ8qr5pntdVumLZdxqM9Ghc25Ju5ELgHh4cklXrh
 gLmAl70o8fnz31zjyvXGbxGzDYmiYtAx6rA2S4BlusVtubgTSqLlL0niamxx12SG0Ugt
 LJCDlr0cmFUyDQ3oXgCNKyKe5SuPaoCn2YM+N1jemJqd7Gz0SsuVlCe9XVrB2RWo7ery
 e5aA==
X-Gm-Message-State: AOJu0YxF76OcWuYUAQDYZI52TR5sQQT73zbD1VEtG+JRUhHgL+19WOoG
 XHQpohpVi9kz0FY8IGfru40Ju4Vjeu3cfqmCnCzh2SW3autDg/4OpeystqQtaKekYqigRxT9ohk
 QgpgVfVV/KsGQ8dSqhWcK9a+9rJNQn78NcqBDuLJztuBFaWep
X-Google-Smtp-Source: AGHT+IHAF1VCJxjC7vMjNQ6QD4NmOPqy41TDeH252Kv3GRMGLwxthuReb8KDZpnSzLOr34E4C+kv60O/ZlJU3Id+OUQ=
X-Received: by 2002:a17:90b:51d2:b0:2e2:daab:cc69 with SMTP id
 98e67ed59e1d1-2e9b171f11emr25954386a91.12.1731494314656; Wed, 13 Nov 2024
 02:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20241111210959.560738-1-adrianox@gmail.com>
 <20241111210959.560738-6-adrianox@gmail.com>
In-Reply-To: <20241111210959.560738-6-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 Nov 2024 12:37:58 +0200
Message-ID: <CAC_iWjKAM2=HGjoccwQ7QzTABV4dxVypeSZkzSqEraDzVxxipA@mail.gmail.com>
Subject: Re: [PATCH v3 05/15] efi_loader: add IPv4() to device path to text
 protocol
To: Adriano Cordova <adrianox@gmail.com>, xypron.glpk@gmx.de, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org
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

Hi Heinrich,

On Mon, 11 Nov 2024 at 23:10, Adriano Cordova <adrianox@gmail.com> wrote:
>
> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> Implement Ipv4() node support in the device path to text protocol.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>
> (no changes since v2)
>
>  lib/efi_loader/efi_device_path_to_text.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/lib/efi_loader/efi_device_path_to_text.c b/lib/efi_loader/efi_device_path_to_text.c
> index 0c7b30a26e..481a9712d9 100644
> --- a/lib/efi_loader/efi_device_path_to_text.c
> +++ b/lib/efi_loader/efi_device_path_to_text.c
> @@ -8,6 +8,7 @@
>  #include <blk.h>
>  #include <efi_loader.h>
>  #include <malloc.h>
> +#include <net.h>
>
>  #define MAC_OUTPUT_LEN 22
>  #define UNKNOWN_OUTPUT_LEN 23
> @@ -170,6 +171,28 @@ static char *dp_msging(char *s, struct efi_device_path *dp)
>
>                 break;
>         }
> +       case DEVICE_PATH_SUB_TYPE_MSG_IPV4: {
> +               struct efi_device_path_ipv4 *idp =
> +                       (struct efi_device_path_ipv4 *)dp;
> +
> +               s += sprintf(s, "IPv4(%pI4,", &idp->remote_ip_address);
> +               switch (idp->protocol) {
> +               case IPPROTO_TCP:
> +                       s += sprintf(s, "TCP,");
> +               case IPPROTO_UDP:
> +                       s += sprintf(s, "UDP,");
> +               default:
> +                       s += sprintf(s, "0x%x,", idp->protocol);
> +               }
> +               s += sprintf(s, idp->static_ip_address ? "Static" : "DHCP");
> +               s += sprintf(s, ",%pI4", &idp->local_ip_address);
> +               if (idp->dp.length == sizeof(struct efi_device_path_ipv4))
> +                       s += sprintf(s, ",%pI4,%pI4", &idp->gateway_ip_address,
> +                                    &idp->subnet_mask);
> +               s += sprintf(s, ")");

How confident are we that the produced device path won't overflow?
IIRC we only have 512 of space there and sprintf isn't the best tool
to catch overflows.

Thanks
/Ilias
> +
> +               break;
> +       }
>         case DEVICE_PATH_SUB_TYPE_MSG_USB_CLASS: {
>                 struct efi_device_path_usb_class *ucdp =
>                         (struct efi_device_path_usb_class *)dp;
> --
> 2.43.0
>
