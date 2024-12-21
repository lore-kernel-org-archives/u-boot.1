Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62D6E77184
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 08:44:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2A2B80423;
	Sat, 21 Dec 2024 09:44:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p+VBxWJn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DA1680433; Sat, 21 Dec 2024 09:44:44 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B24F7803E0
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 09:44:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e5372a2fbddso2391842276.3
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 00:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734770680; x=1735375480; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HGClVCzZXjRrB+YTxB0MuF7IpTzWQSCCs8MBRRDcqHc=;
 b=p+VBxWJnBi6upeAsgGLKvPWIaZF2PfdQaqYhMjaQdTGVAf+5BPCaQFMcy41GgD3V+R
 BvpOOu71y+Q/kALxVQooro1JRBIOAlqCg/vNiId8gm5eqtez89lNe8W8WrViRYgCKPSu
 0yqu5xD3zsA2O5m5HjJxLBQh8vDs7SypJZBeqpYS0HRUtVqWwsKYJfbORMru8fDW7HaV
 CudfaaNCYnOO1FOuu3SrxNaIi4XSQDc8e8+YGXfcQ8p/IvQeg6KXSxv/ueDCwA7Kh8MX
 PprAOZOfMiexzSAmH2BC41dFZpmBICktrz5FxhCeeBYu5LD86+gEslzrYWXFS2K6BOSI
 rX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734770680; x=1735375480;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HGClVCzZXjRrB+YTxB0MuF7IpTzWQSCCs8MBRRDcqHc=;
 b=iv/1N2KHGZ1JBDS4G73M9Mc0SNIXF2ttyNsJvR1zjlgAX2SgZH7JEDMJwaWep/RtYW
 722tghnmoVjYePPUiA47lyi33hXkHtfx3apwDo+2EwfTOApyrmeQgZf+FUnhLchJCYlD
 SswmSmy9Ddt/+Lv8MwXt4ch1HOHtvKMAo0MmJFS7CW8P2nAEhYGoXk3HGmRo9TLgy2LU
 p8MSgv7XM3UX/qFrMf/3kM9XQq8vtgpb1+89tOCmsBZkqnlFCyHlay1Wy8X6VCp7yRvY
 MHnh6xXqiNq/jWz9HXU+fdLlIU0FxDcZBkfhVvyXkexZnUeDJU6hOyoey8sIwgTtGMRJ
 lyEA==
X-Gm-Message-State: AOJu0Yxu32YA619oUuSFqZxymI7WH7RCy2oCAmqZHhjoup41FVuJFjCT
 W7V2/MO3DdMa0KMJS7UzkBSaU938mFpzjCQZHSj7XEjCjq+tltUOopZU7NXfHBy20p/lNflisux
 uZGeNPSw+Lg8cOwGNqLhZlYwcJalCTDpgYR7Z/Q==
X-Gm-Gg: ASbGncudltRlRayd52g1jEW+iXh1YFrhlZljW1Eskwjb7oJ1l9b0bf5sN5LZk3NrxMC
 p0nDVKHVJyD6u8cJpC22BpjWMTdXq/0a8RJDwbQ==
X-Google-Smtp-Source: AGHT+IEW6g1Df9ePEvt9nWnUSp1AUGhDnHhtawPrNpZYVOBKUOdptLNnYU6XCqyE2YVpyd+3lZU9H0SDCFuUAdbgW6E=
X-Received: by 2002:a25:200b:0:b0:e46:42d4:22c2 with SMTP id
 3f1490d57ef6-e538c1f1f15mr3276485276.7.1734770679316; Sat, 21 Dec 2024
 00:44:39 -0800 (PST)
MIME-Version: 1.0
References: <20241219023832.1098689-1-sjg@chromium.org>
 <20241219023832.1098689-4-sjg@chromium.org>
In-Reply-To: <20241219023832.1098689-4-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 21 Dec 2024 10:44:03 +0200
Message-ID: <CAC_iWjJSXWDBjYNaCr-yBAD6NbK2Pph0t+ZmkP_BFJHq3S9Kug@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] efi_loader: Update efi_run_image() to accept image
 and device path
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Adriano Cordova <adrianox@gmail.com>, Moritz Fischer <moritzf@google.com>, 
 Patrick Wildt <pwildt@google.com>
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

On Thu, 19 Dec 2024 at 04:39, Simon Glass <sjg@chromium.org> wrote:
>
> Provide these globals as parameters to this function, on the way to
> making it possible to start an image without relying on the globals.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Adjust argument ordering for efi_run_image()
>
>  lib/efi_loader/efi_bootbin.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index 051d86ef993..b42ff3cb4e0 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -157,9 +157,13 @@ void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
>   *
>   * @source_buffer:     memory address of the UEFI image
>   * @source_size:       size of the UEFI image
> + * @device:            EFI device-path
> + * @image:             EFI image-path
>   * Return:             status code
>   */
> -static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
> +static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size,
> +                                 struct efi_device_path *device,
> +                                 struct efi_device_path *image)
>  {
>         efi_handle_t mem_handle = NULL, handle;
>         struct efi_device_path *file_path = NULL;
> @@ -167,7 +171,7 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
>         efi_status_t ret;
>         u16 *load_options;
>
> -       if (!bootefi_device_path || !bootefi_image_path) {
> +       if (!device || !image) {
>                 log_debug("Not loaded from disk\n");
>                 /*
>                  * Special case for efi payload not loaded from disk,
> @@ -188,9 +192,8 @@ static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
>                         goto out;
>                 msg_path = file_path;
>         } else {
> -               file_path = efi_dp_concat(bootefi_device_path,
> -                                         bootefi_image_path, 0);
> -               msg_path = bootefi_image_path;
> +               file_path = efi_dp_concat(device, image, 0);
> +               msg_path = image;
>                 log_debug("Loaded from disk\n");
>         }
>
> @@ -227,7 +230,7 @@ out:
>  /**
>   * efi_binary_run() - run loaded UEFI image
>   *
> - * @image:     memory address of the UEFI image
> + * @image_ptr: memory address of the UEFI image
>   * @size:      size of the UEFI image
>   * @fdt:       device-tree
>   *
> @@ -236,7 +239,7 @@ out:
>   *
>   * Return:     status code
>   */
> -efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> +efi_status_t efi_binary_run(void *image_ptr, size_t size, void *fdt)
>  {
>         efi_status_t ret;
>
> @@ -252,5 +255,6 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
>         if (ret != EFI_SUCCESS)
>                 return ret;
>
> -       return efi_run_image(image, size);
> +       return efi_run_image(image_ptr, size, bootefi_device_path,
> +                            bootefi_image_path);
>  }

https://lore.kernel.org/u-boot/CAC_iWj+5-uoXq9BanaOSxedVgbBYNFQ2AZVqka+J7iwMv=eC5w@mail.gmail.com/

I thought you said the _ptr was dropped.

Anyway
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

We can drop it later or in v3 if one is needed


Thanks
/Ilias
> --
> 2.34.1
>
