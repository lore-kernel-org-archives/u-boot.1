Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634BCC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 13:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B849788881;
	Wed, 24 Jul 2024 15:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZulMNFr4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1970D88913; Wed, 24 Jul 2024 15:44:46 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40A3F8881C
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 15:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2cb57e25387so4354481a91.3
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 06:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721828681; x=1722433481; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v/vLQZzhhPNqZo3wPRrIlQ9ASkY8poBFWnLOFhCNRNA=;
 b=ZulMNFr4C4UL7yLnZqz8PN3mDXX7FukM+7ed6v2/meqi7rzKDPDh2srXNkuqYTH8N2
 wHtyyWGp+YYKO7yiRfmVmOFySkX/qt1GpUfPIQkNlQus+FGdwN3A+Na54PiwJ/pcVa4T
 NR14uuZabt5CcllF9vGxtsBzUR0W6l9MnOYygSMbRnI32p0EGlnLUNdCe7a7x1XUfUn0
 6nmnYcrNK/1gWua11P7VNMdz2emOcKJOujqR/9LdIIRpgHCIkEBWrVRW3oAuJytV+eul
 IAGwVKaLewZ4I8FWo0wPfoaXFEzyPAQ+Y01bQ6v5mCW+zY7g3dPSmz0WFfABAf2Yp1Cg
 2/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721828681; x=1722433481;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v/vLQZzhhPNqZo3wPRrIlQ9ASkY8poBFWnLOFhCNRNA=;
 b=tUz/TyzIiZ900TpnONxgfnjNpOfI/dArgn96m+L37btdrHSOhsQVrGBKttzz/74lyC
 zdBsEXjBNflG/m4V3Zm9R49s0uGkT/8gh7J4RogBmHj24Gn6EXQY/IirowJL5CkNFoEn
 JW0CnLk/IEffbssZxYehM2hU99G8KORxqwyn+/NfsBYpDJH/oU/K0yASd+dY8XwL5izn
 M9BnKP9AUpwbjh5fugqnay+uEu0HvoJ1jUhgporzr5YX14rWhgY0lSwV5MZVTcLI4XnS
 O6lxoD4FVWWCC6Fw/K+fmWSNfTXcPOUV9FNw6jtcZfrrgbjv2yPLtx+woOgagSK7ZWEJ
 GT1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX9djfULGxjMSrVyFWkmXic0wP+lX5HVPt9DB0jFMjKdWvf1dqMGeng6yA6BmajRzOGZDYc4yZtHQNkKWBX5yIk1fT1Q==
X-Gm-Message-State: AOJu0YyA1OE6vuo6dWLeFCMQff02KaaPxqKPO+8gHqRRHpJqB/wSujZJ
 nUZXneWPPx19o1ZifEv9RzNfzsqiFT8ajHOR/EGLEAi6rhcPXCvR6wtEm85Ly6gd5sSnl0GFRxP
 zNMndEYwej1eihjK3zzKZNJ39VxEY2lAtW9rolw==
X-Google-Smtp-Source: AGHT+IEZXrG+AnYqK3u2rG3tbSc28efAfNJxchqINQVzZjEZEtsq1952lYsxQdbtTcoaakFe184CavmF1SVEiyu8Poc=
X-Received: by 2002:a17:90a:f109:b0:2bf:de8b:bef5 with SMTP id
 98e67ed59e1d1-2cdae316343mr3496231a91.12.1721828680551; Wed, 24 Jul 2024
 06:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240724132604.168177-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240724132604.168177-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 24 Jul 2024 16:44:03 +0300
Message-ID: <CAC_iWjJ6OPf=iXmfHmMMnV4jVCiJjddTD+Fc9gfziyO0wz-w1w@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: correct check in efi_load_option_dp_join()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Simon Glass <sjg@chromium.org>, Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
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

On Wed, 24 Jul 2024 at 16:26, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> After assigning to *dp we must check this value and not dp.
>
> Addresses-Coverity-ID: 501792 Control flow issues (DEADCODE)
> Fixes: 58bef195f94e ("cmd: eficonfig: add support for setting fdt")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/efi_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 348612c3dad..65d2116381a 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -133,7 +133,7 @@ efi_status_t efi_load_option_dp_join(struct efi_device_path **dp,
>
>                 *dp = efi_dp_concat(tmp_dp, fdt_dp, *dp_size);
>                 efi_free_pool(tmp_dp);
> -               if (!dp)
> +               if (!*dp)
>                         return EFI_OUT_OF_RESOURCES;
>                 *dp_size += efi_dp_size(fdt_dp) + sizeof(END);
>         }
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
