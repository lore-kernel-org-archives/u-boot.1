Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93483CEBF9C
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 12:00:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C29208909F;
	Fri, 27 Sep 2024 14:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BYqdIU7/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69B0C890A8; Fri, 27 Sep 2024 14:00:32 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1A3C89088
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 14:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7c6b4222fe3so1406057a12.3
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 05:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727438428; x=1728043228; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HzN8KlybJQ0vuUEWokpEM7GlrfTWnXP3cOHDlP7FQpM=;
 b=BYqdIU7/qafRo6RwLahlNyakzyQsTH+X/N1RGoYF8x/Ce46yFnF3g4EUAXqc7H+maA
 yWudobfl0+9pxBTQr6z2ad8DJKzv1UuFkRPG5rkBevuTtpBDc4mtwVrwa7mPPfPw7SOW
 xM2IRyQ0H93wPsd55IA1E/TKBSwDDabYFD3by2eKNzgAsJwwuv7XFgw+xnPkZ3YSmlsC
 7FgPFl4D/zj5OQ1nWRzKtGJQE+Z4yBqpEqrthihl929rqKnTgtfFHawEfaGNOmcZ5TjI
 gdMQBC9ylF564LUE+YZSeLyZiDGdLStygTy9Es89PvjOyGSHNJcjIMG99AddMyxpolWA
 4vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727438428; x=1728043228;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HzN8KlybJQ0vuUEWokpEM7GlrfTWnXP3cOHDlP7FQpM=;
 b=iYRypiEGyEd1oz961kHQRZgXxx86n+2hE9irvKOaaygJkJHB4d4G7ivv+4vgAdjwdV
 vExXLW2gzfST+Fd98d/39eduZf+ustnKuHsWnUfX6KFC8QBxluyjjCRW20z0nKDSwwtC
 r9imQ6JZTa8Y9XCJY+0OEs8BzZs54hR/SFAPP6xLQr0PzmGbQ6GcMJSSx0jCC/7kDJqS
 YzBB3wzao631z+BMcUy5F0a1iAkzy4FmJua+AFx3C+ChTQrfVwIeUPp1SrFhG2AssvVw
 3ubaFeluMbPrKectF4u9eBTaT7Tx13RpiB85Tmty6WIjS+5RN1Cws4gVQD2ITfCAdJTa
 bO3g==
X-Gm-Message-State: AOJu0Yy+Q9x2GfeauT/ZWkjiIQ7DgXlgDT0WRaeIRJu1Zuv2XsIMATI/
 qaHw1l/5BOcrVH7NjTPtrw9Wwi2m5KXR1rMMf9M1RTIXd1271VSNlcx8lh+tH3h+tQTT8aOQ651
 03uEKWMhkYdx3nHG75xjDPQ4ykmd7mBK8zves5w==
X-Google-Smtp-Source: AGHT+IE2d12tQVCSRbjwc7Qenv4T00tQd88dteJLtJsuglq4x68ezPctyL/zXmazMZFoWJn2Q2tapeJ9h+Hy6oHD5ZA=
X-Received: by 2002:a17:90a:55ce:b0:2e0:a926:19b1 with SMTP id
 98e67ed59e1d1-2e0b8ee65a8mr3250851a91.38.1727438426593; Fri, 27 Sep 2024
 05:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-6-sjg@chromium.org>
In-Reply-To: <20240926215950.1265143-6-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 27 Sep 2024 14:59:50 +0300
Message-ID: <CAC_iWj+Rq4rt6otGAHWd48CG_tf=LBCfs3740rPUNYhLTaAVVQ@mail.gmail.com>
Subject: Re: [PATCH v6 05/12] efi_loader: Show the vendor in helloworld
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi Simon


On Fri, 27 Sept 2024 at 01:01, Simon Glass <sjg@chromium.org> wrote:
>
> Show the vendor name so it is clear which firmware is being used, e.g.
> whether U-Boot is providing the boot services.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

I already sent my r-b for this. [0]. I am not sure Heinrich remarks were covered

> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Reword commit message
> - Use 'Firmware vendor' instead of just 'Vendor'
>
>  lib/efi_loader/helloworld.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/efi_loader/helloworld.c b/lib/efi_loader/helloworld.c
> index 586177de0c8..c4d2afcb40a 100644
> --- a/lib/efi_loader/helloworld.c
> +++ b/lib/efi_loader/helloworld.c
> @@ -237,6 +237,9 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
>                         (con_out, u"Missing device path for device handle\r\n");
>                 goto out;
>         }
> +       con_out->output_string(con_out, u"Firmware vendor: ");
> +       con_out->output_string(con_out, systab->fw_vendor);
> +       con_out->output_string(con_out, u"\n");
>         con_out->output_string(con_out, u"Boot device: ");
>         ret = print_device_path(device_path, device_path_to_text);
>         if (ret != EFI_SUCCESS)
> --
> 2.43.0
>

[0] https://lore.kernel.org/u-boot/CAC_iWj+DtHbghAqJWiwm8ZVCXf3mCOOm13YpLSQGGBPcpgnWiQ@mail.gmail.com/
