Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99A9D41C2E
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 10:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C0CB89554;
	Wed, 13 Nov 2024 11:24:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bX2boLfa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69E1489554; Wed, 13 Nov 2024 11:24:52 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15ED9894AB
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 11:24:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7ee4c57b037so4942879a12.0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 02:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731493488; x=1732098288; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ocsO3RSAd8JJLrB5bKbO2I3L3RKKVV/p3yJgvcxw9pI=;
 b=bX2boLfaSF8l+4qoJZIqs/AU3ScjQdgOgffyAoLA7JS9LK61T4FiaR1Ek/pSLYXKTa
 Ulsh4LfF1Aoi6dU9284dWNzeVAxXjLKWFwSQjEVKtcg4FfOYk8k7cuIfyGFO7ff0THd7
 /meKpYJ21KY1vU53I0pkxVbP9P7cwJ5G6u2yv0uIxyoeEgJQa0GO11UqQiNr3eFhlGcb
 8SWJA1aAP8uX6Nflk1u/8scu2MCsoKkn/kYM06vt7mIw+shqogJewkOth8LWmfBczHBQ
 m0VV0dh8Lqri+CjfoY4TDSAT9phPvYf+wW6P5a6m1Nv5TrcVal01HWJEDi7tUIhiY4NQ
 pIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731493488; x=1732098288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ocsO3RSAd8JJLrB5bKbO2I3L3RKKVV/p3yJgvcxw9pI=;
 b=Ys1xGHpz53vBsjkHJpTsxHXVfeo3VShQBYqXsUwvRfTfLuHSjW0z9Hn2Jg2sFD1dgQ
 xQypr2lESvO630yQAt4NrhUAC6uHIWOt1dVx5m/FWaxugysedlYcl9Y534z1W4Q4xMzb
 AHLoBc8B+Ai2lxslkVDd2rIzre7ahVs6YI7endj1D++w4THcNMHlCVkiRi5g1+vy+6+C
 Nw1zEnl+H3RP5buJOsF4D3UdIPPDwmUfEt05T/3JaG8S/2KuEvvE5NXN1rq9vvG1esl0
 TbA3tmOUZ16L6SCS7f/Ql3AZVPykGhwRHGGz/pMlSq7hIFKX8yW/Jge+iUhnmaWEZAye
 Lbmg==
X-Gm-Message-State: AOJu0YxiQyK3nAzNmF3d5azSQxUVnyAXpWXsJi1o1YCQiwMNquVcgVFD
 XN8Mf4Cls2Xyt14KyQ0MXbfAuaKecB2F55uSZ6eNGTv5FnpbUI5jPk4RSGm4R3rV4n5fREUDPSt
 Vadt51nhWGZZONmwBxPGQAXhCmmbmiobjYIXAeQ==
X-Google-Smtp-Source: AGHT+IEDA3XCuKrnyFtaELe/xbdtgiAbX7aRKlk5GEXGArNpEFHsKS32MSJF8V3q9XWPNySjPzApzosQqqyxfGWCe6U=
X-Received: by 2002:a17:90b:2b50:b0:2e2:de27:db08 with SMTP id
 98e67ed59e1d1-2e9b1770bffmr23755270a91.23.1731493488520; Wed, 13 Nov 2024
 02:24:48 -0800 (PST)
MIME-Version: 1.0
References: <20241111210959.560738-1-adrianox@gmail.com>
 <20241111210959.560738-4-adrianox@gmail.com>
In-Reply-To: <20241111210959.560738-4-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 Nov 2024 12:24:12 +0200
Message-ID: <CAC_iWjJGyh6ujqKtbBa6YLAC84XVqtmHSXO4yJ3hTZ_tS-8X6g@mail.gmail.com>
Subject: Re: [PATCH v3 03/15] efi_loader: device_path: add definition of
 DEVICE_PATH_SUB_TYPE_MSG_IPV4
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
> Add definition for DEVICE_PATH_SUB_TYPE_MSG_IPV4 device path
> subtype.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>
> Changes in v3:
> - Removed alignment in struct efi_ipv4_address
>
>  include/efi_api.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/include/efi_api.h b/include/efi_api.h
> index f07d074f93..99ee749522 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -616,6 +616,7 @@ struct efi_device_path_acpi_path {
>  #  define DEVICE_PATH_SUB_TYPE_MSG_SCSI                0x02
>  #  define DEVICE_PATH_SUB_TYPE_MSG_USB         0x05
>  #  define DEVICE_PATH_SUB_TYPE_MSG_MAC_ADDR    0x0b
> +#  define DEVICE_PATH_SUB_TYPE_MSG_IPV4                0x0c
>  #  define DEVICE_PATH_SUB_TYPE_MSG_UART                0x0e
>  #  define DEVICE_PATH_SUB_TYPE_MSG_USB_CLASS   0x0f
>  #  define DEVICE_PATH_SUB_TYPE_MSG_USB_WWI     0x10
> @@ -691,6 +692,22 @@ struct efi_device_path_uri {
>         u8 uri[];
>  } __packed;
>
> +struct efi_ipv4_address {
> +       u8 ip_addr[4];
> +};
> +
> +struct efi_device_path_ipv4 {
> +       struct efi_device_path dp;
> +       struct efi_ipv4_address local_ip_address;
> +       struct efi_ipv4_address remote_ip_address;
> +       u16 local_port;
> +       u16 remote_port;
> +       u16 protocol;
> +       u8 static_ip_address;
> +       struct efi_ipv4_address gateway_ip_address;
> +       struct efi_ipv4_address subnet_mask;
> +} __packed;
> +
>  #define DEVICE_PATH_TYPE_MEDIA_DEVICE          0x04
>  #  define DEVICE_PATH_SUB_TYPE_HARD_DRIVE_PATH 0x01
>  #  define DEVICE_PATH_SUB_TYPE_CDROM_PATH      0x02
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
