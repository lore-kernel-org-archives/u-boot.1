Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84ECC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 10:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57B36889F1;
	Fri,  9 Aug 2024 12:54:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ncwo4gxz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA50B889F1; Fri,  9 Aug 2024 12:54:10 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EB6A887EB
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 12:54:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-710ced3642dso1140684b3a.2
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 03:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723200846; x=1723805646; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TGS/RaCHAgU0yeTL8SNQIRCmlp7DNNNwEF0X405ZNEg=;
 b=ncwo4gxz7hYmxMwH8WU0N/l8ylpPuO2HYwzHfUf1ayQ8akt/ny3VXXU6UU/9li9iO2
 NgINCbLopvcMfjbZ96A6mYExt4uCA65kM+OjzVMt9s3Kr2kW7lhjY75Du5V1CYA3acvK
 pxCrjngheFbapIGgzLnR4+SVG/aGnh43zkg0rpkzj2Ay6IKVtUJOWBjHDii929vNerOv
 uBDkrVAUtchXJhozMebGj+KOsSz/kN/fYeeSuEkEC1ju5dpPVZnm/wMxZSH5FDLLbxvF
 cPyyxcIqZjNV4LJIpfyGqpBAmUudtrssWDD4npcDfyk7UuxU8C89ppltf2nfNJ94Nocd
 Rn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723200846; x=1723805646;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TGS/RaCHAgU0yeTL8SNQIRCmlp7DNNNwEF0X405ZNEg=;
 b=REEa6vX2aDVhLn0PnUNFY4h10ci+R2trgRNsir7TdHa4TP+b5x7FyT25A9kNRm1Oa0
 oTWvM/HJ2JeWArciS3R5ckkEm2rjhYaldvmmagmh+lqOmWNGu46KPgzzb2+3vfeBLflP
 wFniJn09AdZ+JOT2KiqB3+AfddcG/wqFoHDUUJ69wO3C6CSWlIOE1HXOVj1WO5ZqVHjk
 +hBscrBOG43/w0pZHRxUbEP6yczhZAh4ke0QDejxFY5nD9CSsvpR0uVcvRVjifZMdLUx
 af/LIUAYCY3WpyIHjrOPGJfyEpaFYdct4RuOSdOMBIYIjjfcfKv17sgCf52iAw4ZDHXD
 JyiQ==
X-Gm-Message-State: AOJu0YxdlkYdx8/NmoAwKwpm7EBcsU7Mo6/wovHVN0rftCZMMZsuQ/J0
 QQo0h9xu4hfRpvKtqEJ1CKiUH93ebGnYtDsFePDJVdbndqT8cgFyaQ55utgeoKG7c7TagyJTPZX
 fYtdKaypeMGK601+PIkbhkSKLss8x4+tYCC7Cxg==
X-Google-Smtp-Source: AGHT+IHANQfJJzfqEiiIOtp0BbaGPqit4nCFxwCAH0SjQ9s5ibOIm/NbHe9pdadyRLXEF+9v7metb2w0PI7ajNbeBQQ=
X-Received: by 2002:a05:6a21:6f83:b0:1c4:87b2:e069 with SMTP id
 adf61e73a8af0-1c89ff44437mr1390535637.36.1723200845879; Fri, 09 Aug 2024
 03:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1723050310.git.jerome.forissier@linaro.org>
 <b02ec5e623fd4c80201c92630780ed7e4f557191.1723050310.git.jerome.forissier@linaro.org>
In-Reply-To: <b02ec5e623fd4c80201c92630780ed7e4f557191.1723050310.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 9 Aug 2024 13:53:29 +0300
Message-ID: <CAC_iWjL-GbO=FFbAyn-OFm5te63zGwwBMAsGv7orGC+oBObb_w@mail.gmail.com>
Subject: Re: [PATCH v8 03/23] net: wget: allow EFI boot
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, Simon Glass <sjg@chromium.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, Marek Vasut <marex@denx.de>
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

On Wed, 7 Aug 2024 at 20:12, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> wget followed by bootefi currently fails as follows:
>
>  U-Boot> wget 200000 192.168.0.30:helloworld.efi
>  Waiting for Ethernet connection... done.
>  HTTP/1.0 200 OK
>  Packets received 13, Transfer Successful
>  Bytes transferred = 12720 (31b0 hex)
>  U-Boot> bootefi 200000
>  No UEFI binary known at 200000
>  U-Boot>
>
> Fix the problem by adding the missing efi_set_bootdev() call.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  net/wget.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/wget.c b/net/wget.c
> index 0e4dc5159d0..cf7681a4e79 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -8,6 +8,7 @@
>  #include <command.h>
>  #include <display_options.h>
>  #include <env.h>
> +#include <efi_loader.h>
>  #include <image.h>
>  #include <lmb.h>
>  #include <mapmem.h>
> @@ -429,6 +430,9 @@ static void wget_handler(uchar *pkt, u16 dport,
>         case WGET_TRANSFERRED:
>                 printf("Packets received %d, Transfer Successful\n", packets);
>                 net_set_state(wget_loop_state);
> +               efi_set_bootdev("Net", "", image_url,
> +                               map_sysmem(image_load_addr, 0),
> +                               net_boot_file_size);

Don't you need an unmap_sysmem() once this completes?

Thanks
/Ilias
>                 break;
>         }
>  }
> --
> 2.40.1
>
