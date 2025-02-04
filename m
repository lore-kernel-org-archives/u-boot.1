Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC3FC0218F
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 09:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3848A801DE;
	Tue,  4 Feb 2025 10:10:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w9P9q1y/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D13E801DE; Tue,  4 Feb 2025 10:10:03 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBD0B800CF
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 10:10:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e573136107bso5741813276.3
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 01:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738660200; x=1739265000; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oCop9dSTjpfyJMetOrOwZ5zAfNi05+4xmG4VVo3fDfY=;
 b=w9P9q1y/+oowx6X2oCpAsQaXVCM5pGQPQv/fDvPmBHhjp0I6WGbH1vi6VMbIkhHIjZ
 3bVvJ8zv1w+TjhWjqFa9c4kx0+uslXK07rwx/EIk7nCe8hrNi2Ix2U3UV3VavL6YPMsz
 v3Bxox6j/AZBo/ndBMNU9KUwlVtDTB6fXkQbD5qPgU8o09bfiGCXyJzfgxEwl/BRJjj4
 CoXYSl8aK/llvC/xKuF3+8gzSdVND6tIfFuNP/TJompNaYCX7G7pVE8Nkv152tKqHxZX
 VJfQS7uHSRDkAs627XvhlqPjWVy8D2rBdtIWja1jQ7Ji0cb3dmmYhinkMjhF53xKrzdA
 wSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738660200; x=1739265000;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oCop9dSTjpfyJMetOrOwZ5zAfNi05+4xmG4VVo3fDfY=;
 b=QgmZVQaIVQ7tu6++C5m7RTaioh5bHGeMLU7kYP3xboQbjc54DKaA247BcZ+fn5zgJg
 N90C3e+IxNabXbEUluFOzNCnYJuerQtUCf6OKEvlOONbkgYYNSffYBauwmBCowyC5Ao9
 BjLFe/85ho5EQHKD3F64tmdQSqhupqA/WniKCFtiqIl8CePc4GsTMi9poj/AmhxbP2VP
 cipqkLx29CVtTQRrg9feNYogl3rDvfHd37EGFQALP9wCXj8DxmKWdXSQd7PaGMSqirfw
 rXljGnxTZto8wW8fvO8S6xYkDsMXHFCOBl5p4/nk74P6hUisAfKyP7lW5GvuAaKr6o49
 rNhg==
X-Gm-Message-State: AOJu0YxNfKyG6jbM/vhV9RJxU2LFJzEg2U6N1mmN2E6v56umb+fJzdv1
 sy9E6zj0YnClrl1z+Z3pPsAroT8ZzwS/PvpnNN+56Ocbt3E+WI0CIctivdXd7A2L9dY3OrXDJXT
 9oKuPUkUftsbfsMQCS18JPZ8hzmDk7ZGH/c8Jew==
X-Gm-Gg: ASbGncsUWNcUGvpLnKnm0eq1xhpPLazgea4y5uAOkKR88TAtzHBrKS9XJzPzdaqs3pC
 0OuSlEh2B2+STFu5rNtWGJgcZGMYnOl+yPK2OEykk5YuFtJa7xJ7upEiOsf9hMsZooz/xc2iK
X-Google-Smtp-Source: AGHT+IFbS9q88/wY38ofHllLvQM9WwWeImcsJJcF66CrUXFSNTeJp8lW4iP8LBH3GWusgCzSmqjvVAa2qWCXpE2P3gY=
X-Received: by 2002:a05:6902:2b06:b0:e58:37fe:4a17 with SMTP id
 3f1490d57ef6-e58a4bd758cmr18985018276.46.1738660199755; Tue, 04 Feb 2025
 01:09:59 -0800 (PST)
MIME-Version: 1.0
References: <20250122170858.961359-1-adriano.cordova@canonical.com>
 <20250122170858.961359-5-adriano.cordova@canonical.com>
In-Reply-To: <20250122170858.961359-5-adriano.cordova@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 4 Feb 2025 11:09:24 +0200
X-Gm-Features: AWEUYZly8C9CIIoobPioScjuAyLGKI1GMgC-iXHEKve4rH2HdY5zoGN_BnNND2A
Message-ID: <CAC_iWjLG-fWngeeXEzLOWxavxqFGmsicsAAh=Jqje6jc8StMxQ@mail.gmail.com>
Subject: Re: [PATCH 04/21] efi_loader: efi_net: Add efi_net_do_start() to
 efi_net.c
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de, trini@konsulko.com, 
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
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

Ok ignore my comments on patch#2. This explains what that patch is trying to do.

I think doing the alternative of what you proposed in #2 is cleaner.
Can't we add an EFI event that triggers and updates whatever it needs
to on IP address changes?

Thanks
/Ilias

On Wed, 22 Jan 2025 at 19:09, Adriano Cordova <adrianox@gmail.com> wrote:
>
> This gets called each time a payload is to get executed by bootefi.
> For now this only updates the PXE IP address.
>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>  include/efi_loader.h       |  1 +
>  lib/efi_loader/efi_net.c   | 31 ++++++++++++++++++++++++-------
>  lib/efi_loader/efi_setup.c |  3 +++
>  3 files changed, 28 insertions(+), 7 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 626d2bbb1a..97152bbb6a 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -628,6 +628,7 @@ int efi_disk_create_partitions(efi_handle_t parent, struct blk_desc *desc,
>  efi_status_t efi_gop_register(void);
>  /* Called by bootefi to make the network interface available */
>  efi_status_t efi_net_register(void);
> +efi_status_t efi_net_do_start(void);
>  /* Called by efi_net_register to make the ip4 config2 protocol available */
>  efi_status_t efi_ipconfig_register(const efi_handle_t handle,
>                                    struct efi_ip4_config2_protocol *ip4config);
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index 918d43c70f..f0cf317d4f 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -876,6 +876,30 @@ static efi_status_t EFIAPI efi_pxe_base_code_set_packets(
>         return EFI_UNSUPPORTED;
>  }
>
> +/**
> + * efi_net_do_start() - start the efi network stack
> + *
> + * This gets called from do_bootefi_exec() each time a payload gets executed.
> + *
> + * Return:     status code
> + */
> +efi_status_t efi_net_do_start(void)
> +{
> +       efi_status_t r = EFI_SUCCESS;
> +
> +#ifdef CONFIG_EFI_HTTP_PROTOCOL
> +       /*
> +        * No harm on doing the following. If the PXE handle is present, the client could
> +        * find it and try to get its IP address from it. In here the PXE handle is present
> +        * but the PXE protocol is not yet implmenented, so we add this in the meantime.
> +        */
> +       efi_net_get_addr((struct efi_ipv4_address *)&netobj->pxe_mode.station_ip,
> +                        (struct efi_ipv4_address *)&netobj->pxe_mode.subnet_mask, NULL);
> +#endif
> +
> +       return r;
> +}
> +
>  /**
>   * efi_net_register() - register the simple network protocol
>   *
> @@ -1017,13 +1041,6 @@ efi_status_t efi_net_register(void)
>         r = efi_http_register(&netobj->header, &netobj->http_service_binding);
>         if (r != EFI_SUCCESS)
>                 goto failure_to_add_protocol;
> -       /*
> -        * No harm on doing the following. If the PXE handle is present, the client could
> -        * find it and try to get its IP address from it. In here the PXE handle is present
> -        * but the PXE protocol is not yet implmenented, so we add this in the meantime.
> -        */
> -       efi_net_get_addr((struct efi_ipv4_address *)&netobj->pxe_mode.station_ip,
> -                        (struct efi_ipv4_address *)&netobj->pxe_mode.subnet_mask, NULL);
>  #endif
>
>         return EFI_SUCCESS;
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index 164586742a..eeed82c073 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -218,6 +218,9 @@ static efi_status_t efi_start_obj_list(void)
>  {
>         efi_status_t ret = EFI_SUCCESS;
>
> +       if (IS_ENABLED(CONFIG_NETDEVICES))
> +               ret = efi_net_do_start();
> +
>         return ret;
>  }
>
> --
> 2.43.0
>
