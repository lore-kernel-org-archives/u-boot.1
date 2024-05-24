Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E18C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 09:39:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE2FE881D3;
	Fri, 24 May 2024 11:39:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ptf+KPZc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C61578823C; Fri, 24 May 2024 11:39:20 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CF35881C3
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 11:39:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-657a07878easo2869400a12.0
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 02:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716543557; x=1717148357; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hDR+heX0jzf+tSCaACG9M46iihcSyR2hZY4IsLpvqKc=;
 b=ptf+KPZcxNA51Z4mzB/TjOsA5ISUIgtCAA7ssigknleW7J0ZBrbrN9Q2K1GZhhByms
 3k0uJKSGUt4MlCuoFwXgW4YIa6XJWnWC7nB+pzabipNMsfOFPb4wwkFxwGP4MhV1tHLk
 n+uMSK1Q+sLFSQLjoC9yNnR9XmoOFDV2S7oBYmxrXSB+d7Fb2CWwNkhwP+o0EFU3EyxC
 Rwl0GyGbDJjawcNp1YGPLEzJ5/cE7x+HVVhuTusXkfHVk6JO7ZGkpzAAHqKHRAYLFR2W
 XY9oS5jl7XYIeSdkfpAb71uT2qYkfXouenOhDtosza4W4tk2ZE43XtjY4ULQdCG1PQlD
 Xr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716543557; x=1717148357;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hDR+heX0jzf+tSCaACG9M46iihcSyR2hZY4IsLpvqKc=;
 b=CN9m0+sGY7FvYEfhel3x2uAVRtsRpem6lLzXSobxY7P0Ze8u0flDluHQLzdyo/rkir
 9no8VC8+FpYbHfdPGSEzL29kB4rAv5bH5v8MnhRdTpX/hAmsYLR/gaLlNRbVDEx5uaqg
 YeppFWydeK4KwffJ4IA6/UgxBY3YPQvgwVtjipFM47zMA8O6KrTiAxuUmGaamu4kmaZV
 8OOAb877tfeULCbXrEuZlq9pZI6rRo6z+caAlIPuK0HDEe5fPw56jkrOEJlARKhx3aim
 3IrJuqkydvdEYWlDvYp0dWlV+eQpy8pSZ+vgkC3GEbkJM4yKIpq7Zr3uW0ajzujf7uPD
 21dg==
X-Gm-Message-State: AOJu0YyAouvkq/oGIw+bgOzNeBchR8Wn0ZU/TCnlhl8FA9+GUD/roMrH
 AsdVLlBfZZ6QxPKKYRaQmXmNqby/Wl/7q9IU/hyjfTElVAvlr8BkGXyjZB/53PByeKJqnWhqGSl
 5SaRIst+IqY/DBzotNAlJpfDFXr7Mx6A40xnLiw==
X-Google-Smtp-Source: AGHT+IFEaMVQFUxoyHACpV8/H09REitS5J55oL4pP823r0fu+nMtc1oIyCEtucRLuH9WLtAtfaFqXgXYfcQ6mY3sSp0=
X-Received: by 2002:a17:90b:1916:b0:2bf:5f75:9c2b with SMTP id
 98e67ed59e1d1-2bf5f759d74mr1821605a91.32.1716543557018; Fri, 24 May 2024
 02:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1716393035.git.jerome.forissier@linaro.org>
 <8c97a1e0a572fde6a764c2d20bd0fc1376e1cf90.1716393035.git.jerome.forissier@linaro.org>
In-Reply-To: <8c97a1e0a572fde6a764c2d20bd0fc1376e1cf90.1716393035.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 24 May 2024 12:38:40 +0300
Message-ID: <CAC_iWjJaaG3_sQLbzJAz6-wnVYy4ifgDxwGBrbXgEv8GXOw-Rg@mail.gmail.com>
Subject: Re: [PATCH 08/15] net-lwip: import net command from cmd/net.c
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tom Rini <trini@konsulko.com>
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

On Wed, 22 May 2024 at 19:04, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Add support for "net list" and "net stats" to net-lwip/ by copying the
> code from cmd/net.c.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  cmd/net-lwip.c     | 98 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/net-lwip.h | 50 +++++++++++++++++++++++
>  2 files changed, 148 insertions(+)
>
> diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
> index 2926399bd0..20d0d61176 100644
> --- a/cmd/net-lwip.c
> +++ b/cmd/net-lwip.c
> @@ -2,6 +2,10 @@
>  /* Copyright (C) 2024 Linaro Ltd. */
>
>  #include <command.h>
> +#include <dm/device.h>
> +#include <dm/uclass.h>
> +#include <linux/compat.h>
> +#include <linux/ethtool.h>
>  #include <net-lwip.h>
>
>  #if defined(CONFIG_CMD_DHCP_LWIP)
> @@ -43,3 +47,97 @@ U_BOOT_CMD(
>         "[loadAddress] URL"
>  );
>  #endif
> +
> +static int do_net_list(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> +{
> +       const struct udevice *current = eth_get_dev();
> +       unsigned char env_enetaddr[ARP_HLEN];
> +       const struct udevice *dev;
> +       struct uclass *uc;
> +
> +       uclass_id_foreach_dev(UCLASS_ETH, dev, uc) {
> +               eth_env_get_enetaddr_by_index("eth", dev_seq(dev), env_enetaddr);
> +               printf("eth%d : %s %pM %s\n", dev_seq(dev), dev->name, env_enetaddr,
> +                      current == dev ? "active" : "");
> +       }
> +       return CMD_RET_SUCCESS;
> +}
> +

Some of these functions seem to be a c/p from cmd/net.c
Carve the common ones out in cmd/net-common.c and reuse them please

[...]

Cheers
/Ilias
