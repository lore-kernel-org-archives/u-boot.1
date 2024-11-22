Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE7CD75E2D
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 12:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F0A889814;
	Fri, 22 Nov 2024 13:02:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gStt4GrV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62FE389816; Fri, 22 Nov 2024 13:02:29 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DA1889812
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 13:02:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7fbbe0fb0b8so1264090a12.0
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 04:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732276945; x=1732881745; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bPFQeoX6q2lqqiw88w348Jux3ZsEm3fSn75bRtam+DM=;
 b=gStt4GrVqVFNKZkRfUdjvKfJSIW6TQ5R9owlloFwVdOatOrHk9Viwo0WH/o0vdR0PS
 M9te9oz0OiJySnUS1tcE/re0pWaWzdyAo8jMZ+ajjZhYM91xIgrINTFl/2yZWMau8NYr
 alkgN4cY2ixpIw/Vz5uUIjNaRa8ElIdmL4J3xYHKuo9uBb0mwNR921CnWnMyKaypN91v
 16FB6TkxUeSl3rMFZEo4k9uQjmi6fYI00zHCCVPHVXaq506YVoXmQfmb7aOjE9hRh89u
 qQRrX/YamuFmm9mDxhd5oKuu/W8mW5EJfYz2I7eS+AjjeJa315rcCEtMHjEiQyuBc9OY
 PHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732276945; x=1732881745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bPFQeoX6q2lqqiw88w348Jux3ZsEm3fSn75bRtam+DM=;
 b=sQu65ydjpNV3iw/G208W4VRRCX4ZIEA63fyjCuK1mZWvPZcgOSnYAJd9Peslbl99Iv
 C+x87z2zBdFISdxJYwHzN0z2/klh0xH/pFeRWjz+kdijRvjVEB+KA+vtSZ8wTJ5QzGGP
 vSlnFFvM7CPfvuxqqfQvl3FK0ZCytEmFokxhJFWgNRjE3n1Ea8y/ob07gdFg5uQWBftE
 ojAEIkxNXQ78eAzJqER+hw1l51IPMWu5jaleR8Ah2Gy3mJxy7AeQGIEyaMD+EhLD3Mdh
 9eT8FHRvqiy7DwznBUK5BV5PY1SUr0Me8+K05HO8xmRa6EdGVJ86HoXW6sCH0a5Y+Olw
 hhSg==
X-Gm-Message-State: AOJu0Yw8NOc+QlKHbjXpaqCfrlRjnd8qC8dFV1hPJz7RZExiq/u34UBw
 pfd6rOln02VQWyD9TetYCOXOxK+9YdDaqG2DNO3Dvm5W0JZ6tt63qyvzWhYFXOGoIpoiiUUVkeI
 0o+4MVhdDh4ylovHkMA+67jSaJ9qB0vg0N73BiA==
X-Gm-Gg: ASbGncs+R4Ump9gX08Nkn1zs2btp7NlvYb59L3Ii1+IxI++e5EMpAFnmJ6SDtURbXCR
 8NkCiEUEQRTR4COZuhbSFCK3xEQ7pUg==
X-Google-Smtp-Source: AGHT+IGxJ4EhUA6ODScixCFIZk8EpreXYqeaCBo8LlPuqM4Kf7RFAUCf+Ww5Q57KutFVZFmf8020rIWMC9rVfED6Jfc=
X-Received: by 2002:a17:90b:3ec5:b0:2ea:59c6:d6ed with SMTP id
 98e67ed59e1d1-2eb0e86a325mr2893861a91.30.1732276941551; Fri, 22 Nov 2024
 04:02:21 -0800 (PST)
MIME-Version: 1.0
References: <20241118210908.51196-1-adrianox@gmail.com>
 <20241118210908.51196-5-adrianox@gmail.com>
In-Reply-To: <20241118210908.51196-5-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 Nov 2024 14:01:45 +0200
Message-ID: <CAC_iWj+hbV9OdwEdkwwPvHsrhuTHxs0_015Cs=wmmm1EQjNUtQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/14] efi_loader: add IPv4() to device path to text
 protocol
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

On Mon, 18 Nov 2024 at 23:09, Adriano Cordova <adrianox@gmail.com> wrote:
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
> +
> +               break;
> +       }
>         case DEVICE_PATH_SUB_TYPE_MSG_USB_CLASS: {
>                 struct efi_device_path_usb_class *ucdp =
>                         (struct efi_device_path_usb_class *)dp;
> --
> 2.43.0
>


Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org> #sprintf
might overflow but that's w ider problem of all our device path
functions
