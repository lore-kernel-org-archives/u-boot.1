Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A955FC5472E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 11:14:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8DD988297;
	Mon, 26 Aug 2024 13:14:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g7qiCkCY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1DEA8831F; Mon, 26 Aug 2024 13:14:12 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4CE9881A5
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 13:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-202318c4f45so41778545ad.0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 04:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724670849; x=1725275649; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TDlK6dfRqXkaaL5ZvVhmFiwz4sCWa4pVt6DCyNP133Y=;
 b=g7qiCkCYPMmBw4CIU8SiUKBC8lFKG5bukrdg169D/vAaGuQr9aO9hbpIoIJvkqUdh3
 T/5lb/AIqmj0Nwq8jABkmZwN+l7mVT83QuRcnpxhj96PLMlx10tDgO79VhJZm5QgB1qU
 O4H0/A1ygcTk6JUtkkvnn4SNUbx5GrPdWdY2wPvocWdn2Vmmg6pvLho+J7ul7G3cC6c3
 sTvpgh8Lck/rlHTIDs92alhpcpA5K3mpJMPgtCnCX/N02PWdtGeIFt3o0z6D7YKFMNwb
 boFsI1OtpPL4Rw7aqNH3QVHxPnCn/Tv6GxCFjX4abiQNGAttnOPVGiS4aihsK7bHivf3
 lSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724670849; x=1725275649;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TDlK6dfRqXkaaL5ZvVhmFiwz4sCWa4pVt6DCyNP133Y=;
 b=Tx6v6JbhI64PABhBWUrYBYcMAM8TUv2aNM4+N0nSXRb5WcYbZUqJ+EqF0aTPJfC0X5
 E8CSgFQBzqjERq2/JJat00T9UaCFY6U085MoZbTOMmqbu6Vw1zt0YRRGuwFm1WOmQlJG
 qAatxVkBonSo1XPPjNw4HUTp67Kqb3uWbdIMW2kfa39LdO2EM86LDL4C3SFMNrV0JjoX
 PTpSRl0w9xm9rXWZRRndE9wPbIo4h3OdCcfw5tB3EKyhfdhVrg8TJH2q39W2q/9iyDdA
 yVeUngzkDKnMakIQsfJOJYA8KZAR7ThY4vhPOlpJevod+yK4Ynj6bAkpI4pixrtFlTIh
 QXUg==
X-Gm-Message-State: AOJu0YyJnHgk/E3sXFC6up0f3Ox+GyKtV1w8ET5ifkunbPU1t5EBR6kt
 TMKVcH6zBc8YayYgDQMk6xtUT9FHsiSDlSXlAHvLKQRvfbfAiUe7i4kbESqykficA9jQh8S8jIp
 N6SKXUFvSbJ6a7iuiEsl7iv4piv9TOle1f8dEwzAZMHTCxDkOWtg=
X-Google-Smtp-Source: AGHT+IFyLdpKbX6/PonYQDrPkFkklEFCYjKeJX6A0PbE/94qB0BefecswMz62w6Jx3KLK0cVzsO1qwaZltQN8Uj38L4=
X-Received: by 2002:a17:902:e74c:b0:1fd:9e6e:7c1f with SMTP id
 d9443c01a7336-2039e54677emr123435515ad.56.1724670848864; Mon, 26 Aug 2024
 04:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240815202424.766778-1-sjg@chromium.org>
 <20240815202424.766778-10-sjg@chromium.org>
In-Reply-To: <20240815202424.766778-10-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 Aug 2024 14:13:32 +0300
Message-ID: <CAC_iWjKLaD+qTEAmsepC4a-1r33acbQ10asunOhRVFjjHMY3=A@mail.gmail.com>
Subject: Re: [PATCH v4 09/14] bootstd: Add debugging for efi bootmeth
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
> Add a little debugging so we can see what is happening.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  boot/bootmeth_efi.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index 39232eb2e25..99887a89f02 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -163,8 +163,10 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
>         int ret, seq;
>
>         /* We require a partition table */
> -       if (!bflow->part)
> +       if (!bflow->part) {
> +               log_debug("no partitions\n");
>                 return -ENOENT;
> +       }
>
>         strcpy(fname, EFI_DIRNAME);
>         strcat(fname, BOOTEFI_NAME);
> @@ -172,8 +174,10 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
>         if (bflow->blk)
>                  desc = dev_get_uclass_plat(bflow->blk);
>         ret = bootmeth_try_file(bflow, desc, NULL, fname);
> -       if (ret)
> +       if (ret) {
> +               log_debug("no file\n");
>                 return log_msg_ret("try", ret);
> +       }
>
>         /* Since we can access the file, let's call it ready */
>         bflow->state = BOOTFLOWST_READY;
> @@ -308,6 +312,8 @@ static int distro_efi_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>  {
>         int ret;
>
> +       log_debug("dev='%s', part=%d\n", bflow->dev->name, bflow->part);
> +
>         /*
>          * bootmeth_efi doesn't allocate any buffer neither for blk nor net device
>          * set flag to avoid freeing static buffer.
> @@ -333,6 +339,7 @@ static int distro_efi_boot(struct udevice *dev, struct bootflow *bflow)
>         ulong kernel, fdt;
>         int ret;
>
> +       log_debug("boot\n");
>         kernel = env_get_hex("kernel_addr_r", 0);
>         if (!bootmeth_uses_network(bflow)) {
>                 ret = efiload_read_file(bflow, kernel);
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
