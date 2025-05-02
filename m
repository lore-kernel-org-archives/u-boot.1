Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7988C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:56:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 374EB82AB9;
	Fri,  2 May 2025 16:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cy8yrp9x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D24D82AB9; Fri,  2 May 2025 16:49:54 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEFA582CBB
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac28e66c0e1so228060066b.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197391; x=1746802191; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2LKqrVmupKygB+eJyIOmcORb9yIaOQ+SZofdDH8hX4Q=;
 b=Cy8yrp9xe82+ngjdhmC5My73/KuunnimJINaCp3pVsXPsAbY2iUL8fEM9ltxjgsBUY
 hwgPwMrfWFV8ewwPI67mqUslrUHi5MiFKMe+0SyMya1r1A//1ZLfI20iH92uxScni5um
 DtpWIvt8gj5y1IqDdacCVsBv3cZGKGWhp4a3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197391; x=1746802191;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2LKqrVmupKygB+eJyIOmcORb9yIaOQ+SZofdDH8hX4Q=;
 b=HF1aLP/DWJeALLhuQGP7RUqZb1yMfBsQak/EISZQlHRQxytmU2x53GcZqRA5Y1AuGj
 D3Gx61ymZyJrhZq2SkZ0UsV9xvP2XaKI8nSNngvnojuKQsjVAFPZPsw60WQedKBq6Wha
 x9aZQED7z4yKk70GnSHqnn3lTgODzvWrwNmXvV2rHhRMeBrzXjZGYQ5b4+/huBqNSPfb
 IZc6fAMneDl9IB0a8IcKDFpR/hDLMmy7+6iVgi4sRddJj/yBW54XLJ/3NntKX+z2j724
 G+kIeAVLNZn4KeCQBkWiVaUtf+lQSG2AMkfvCJbtFWXzmQDG2xI8mprz/16BMT7bHWas
 kyOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxrjDzkqYy6tNGDXWFDBgSqjOBnWe+pcUAAFX8oRTBKVfWS6xZcbBr26nstQa/m5j2OU06OxQ=@lists.denx.de
X-Gm-Message-State: AOJu0YziKsxxEsl0l665NrJP+uWrHf8FrUtghmUZw5pA8yUKRfilIPar
 H4ucbxQopRNyZ/tFb//OoKrqf4hrTF2Ogz0ostwgR/eVIRIcV/o2pBOxYvzdfptm7a3n62xyOE6
 vnmgb6Y/Lc56HyzJWX5/ohj4gfzM4WMvrdqGX
X-Gm-Gg: ASbGncsTutaalkv0DwHJksi9kPAwYK1aUaeBwTj7a8Wi3ntHp3HQDAQd5mC79Qh7EnY
 MAg4I8P5gvsJwppAoXfMkVEuVUzSlCzIIiUTmnfPFb305vC3L3zdPLe2+KMbfDNf7GwQ7VasaQh
 QAdSFtL+fdf3HFIXuklIf1wYIBhBBNoX5tZA==
X-Google-Smtp-Source: AGHT+IEkNPwcCEDnIKZ31ypeBqzYDfg7I72+j1LD3iVjuh4v8XGYBcoMziRpASINyxrbHbmtrp3F0cTBCAGUBMWF7hc=
X-Received: by 2002:a17:906:478a:b0:ac3:8537:904e with SMTP id
 a640c23a62f3a-ad17af78ffbmr308006366b.49.1746197391327; Fri, 02 May 2025
 07:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250421162555.1200687-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 2 May 2025 08:49:39 -0600
X-Gm-Features: ATxdqUEIn8_5ubJIewoVb8xyde3v71eXoHXCGuKRiuchskkdSieBVAsZ-GHThh0
Message-ID: <CAFLszTiVuNqAzQ=hi5_Uq6Jo2EUJkDtE6_gDaU=LY8hAXiL8ww@mail.gmail.com>
Subject: Re: [RFC 1/8] boot: EFI boot manager does not depend on BootOrder
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
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

On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The EFI boot manager bootmeth does not require variable BootOrder to be
> preexisting. It creates this variable.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  boot/bootmeth_efi_mgr.c | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)
>
> diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> index 42b8863815e..1669cbed5bd 100644
> --- a/boot/bootmeth_efi_mgr.c
> +++ b/boot/bootmeth_efi_mgr.c
> @@ -47,30 +47,15 @@ static int efi_mgr_check(struct udevice *dev, struct bootflow_iter *iter)
>
>  static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>  {
> -       struct efi_mgr_priv *priv = dev_get_priv(dev);
> -       efi_status_t ret;
> -       efi_uintn_t size;
> -       u16 *bootorder;
> -
> -       if (priv->fake_dev) {
> -               bflow->state = BOOTFLOWST_READY;
> -               return 0;
> -       }
> +       int ret
>
>         ret = efi_init_obj_list();
>         if (ret)
>                 return log_msg_ret("init", ret);
>
> -       /* Enable this method if the "BootOrder" UEFI exists. */
> -       bootorder = efi_get_var(u"BootOrder", &efi_global_variable_guid,
> -                               &size);
> -       if (bootorder) {
> -               free(bootorder);
> -               bflow->state = BOOTFLOWST_READY;
> -               return 0;
> -       }
> +       bflow->state = BOOTFLOWST_READY;
>
> -       return -EINVAL;
> +       return 0;
>  }
>
>  static int efi_mgr_read_file(struct udevice *dev, struct bootflow *bflow,
> --
> 2.48.1
>

How do we know if the board is using EFI bootmgr? My understanding was
that this was a way to find out?

Regards,
Simon
