Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868FFC5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 11:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED563889C9;
	Mon, 26 Aug 2024 13:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YBCoczGD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 442AE88A08; Mon, 26 Aug 2024 13:20:39 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ED0D88770
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 13:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-201e52ca0caso28483735ad.3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 04:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724671235; x=1725276035; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ePWkAoW2iVLwU47lpQHDFCFZE+oIJL7H7ukBpLFlzHs=;
 b=YBCoczGD6/01QBVDBk7Uq30/h1BXnA5607/SpgNGLlnxVuziOfLYZpoohwpX6DSiXi
 IFWcjoLNu2tsmSpDJTeXj0jsQqPd5gkjpXn2oBbd4QDHe/pooUNxYwDytNy8iiMs3+3J
 hru9BXXxLq7y3HEya329yllujj/9hRWbr1o/zf+B6VTcX7LEJGLOT+6786Hg9d7yUAMx
 SVxnT78u279viuco/UvTjn2WNtfAQwkT4Uyq9r6Y+oeOK7zkmZUcttdSNJSqOOKTsEHN
 o7rau+F0vk4rzNJKPvgLwDmYI3AzbVkUz+rEYyPVJwfLjLUGs9rDJt6wznCYB2n2rIW7
 PJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724671235; x=1725276035;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ePWkAoW2iVLwU47lpQHDFCFZE+oIJL7H7ukBpLFlzHs=;
 b=E36sP+TjFkiA+/ZZ35OD92aij1K+36S3Wayfftp9jWc4ThxlCwYYy/RpEP91X8I804
 c51xyqjMqblee02/pvsB5GE8hfMT7o0rWAe1pgcRwDQOSkvc8U4Knx27vRUgdJPRrn/J
 j7doFL5RiN1gmRsXjh9df8N+M5L/atjt9FY+F4saRu7d4Qk7A6jqj/RQPq1fJiiWUpz/
 uCxg0eNDaVGZhTpzUkFyyq3lhYbedKcoa3GiMDy+EchaY2v0Oxhowra8HH51BhQsNa+G
 6qbzSacnQwxNMpmKjAZ1YfMsnKlHR4PNoxbfPnm6A+gxBaC6dAwIsf2Cif12W4nOk4mv
 a6Bg==
X-Gm-Message-State: AOJu0Yyq9AhD1NtP7O5D+EijXoHBBvpOw4A9/WJxjNIPRrIo9pOG0iON
 vb2unqkZrPjCaCciXndKX3FObPaJYQMYKYKUE7aVa+YoiOd9t3fWQYvK+yy671PI1Zietxrihk/
 IhMm1SSVhGHbcOAjcRvJWfpio/JeSZ8fXoKL3Zw==
X-Google-Smtp-Source: AGHT+IEY3ak5S1b5majtxGO5IEfyiNfClIeQYhEJW2AnWw6P4ew+8w6s+JvLWa7ayNhzFkbDGRNMzE2+TlGFUsKWi00=
X-Received: by 2002:a17:903:32cf:b0:202:1176:5e39 with SMTP id
 d9443c01a7336-2039e4fbd72mr84455245ad.56.1724671234732; Mon, 26 Aug 2024
 04:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240815202424.766778-1-sjg@chromium.org>
 <20240815202424.766778-13-sjg@chromium.org>
In-Reply-To: <20240815202424.766778-13-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 Aug 2024 14:19:58 +0300
Message-ID: <CAC_iWjK3Tcx+qiDmLeVvzKyg9O2Ju12ODG0M+8XzcpH-md2+MA@mail.gmail.com>
Subject: Re: [PATCH v4 12/14] efi_loader: Avoid using sandbox virtio devices
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

On Thu, 15 Aug 2024 at 23:24, Simon Glass <sjg@chromium.org> wrote:
>
> While sandbox supports virtio it cannot support actually using the block
> devices to read files, since there is nothing on the other end of the
> 'virtqueue'.
>
> A recent change makes EFI probe all block devices, whether used or not.
> This is apparently required by EFI, although it violates U-Boot's
> lazy-init principle.

I think the early scanning is due to CONFIG_EFI_CAPSULE_ON_DISK_EARLY.
I also think we can get rid of this option, but I'll have to dig a bit
deeper

In any case, I am fine with the workaround
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> We cannot just drop the virtio devices as they are used in sandbox tests.
>
> So for now just add a special case to work around this.
>
> The eventual fix is likely adding an implementation of
> virtio_sandbox_notify() to actually do the block read. That is tracked
> in [1].
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: d5391bf02b9 ("efi_loader: ensure all block devices are probed")
> [1] https://source.denx.de/u-boot/u-boot/-/issues/37
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Add a Fixes tag
> - Mention the issue created for this problem
>
>  lib/efi_loader/efi_disk.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index 93a9a5ac025..2e1d37848fc 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -838,8 +838,20 @@ efi_status_t efi_disk_get_device_name(const efi_handle_t handle, char *buf, int
>  efi_status_t efi_disks_register(void)
>  {
>         struct udevice *dev;
> +       struct uclass *uc;
>
> -       uclass_foreach_dev_probe(UCLASS_BLK, dev) {
> +       uclass_id_foreach_dev(UCLASS_BLK, dev, uc) {
> +               /*
> +                * The virtio block-device hangs on sandbox when accessed since
> +                * there is nothing listening to the mailbox
> +                */
> +               if (IS_ENABLED(CONFIG_SANDBOX)) {
> +                       struct blk_desc *desc = dev_get_uclass_plat(dev);
> +
> +                       if (desc->uclass_id == UCLASS_VIRTIO)
> +                               continue;
> +               }
> +               device_probe(dev);
>         }
>
>         return EFI_SUCCESS;
> --
> 2.34.1
>
