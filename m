Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C009EC8721
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 12:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CA1D86410;
	Thu,  7 Sep 2023 14:23:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lI0G8jw0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFA50869BB; Thu,  7 Sep 2023 14:23:52 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E89FB8620C
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 14:23:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d7bbaa8efa7so852974276.3
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 05:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694089428; x=1694694228; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yfNKHgWSXESjcClC786kKZfGtGxuVp1uuV2yHVQjw5A=;
 b=lI0G8jw03ZbHeWfuc+LN22q+pN825YQI+zDvSkikaSNnidp9AVjw6sC8W5x0MabfyW
 VjC6HLzaglqSAVymaIbj741UzG5pI7oZRZ3tps/4Y1TUG/bQ5rSr5bQIoPFWWAsR+1jp
 2KPclbLmlSLu9C/0DLK33pt4w4KUu62aQ/g90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694089428; x=1694694228;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yfNKHgWSXESjcClC786kKZfGtGxuVp1uuV2yHVQjw5A=;
 b=I8lSmSM3ViDDtbauUwj5lQ4sIRpraZKRLX5gVz8HJaJMfVDTChNZ+/RJ5Hg2joUpBj
 wEG9FlTqQUuzxfOS2gjIMVgByQLMoD6UWS7iQJh7TtLvgv19w4MuIcGe8JYJ1Hn7laX6
 piF4vYNJsYIAXQRXqa32fWIuyYZix4HNCJR38NNkwkwYKvPjUnuegtDkASE5+ufIKucj
 8GTdVKeQN97/Mzd6qFgHn3DtH7D/d2QkvEGTGQ1ywV8pA6pGuQm1o4CiP5YNdgG5akVa
 fMNAKwI+TEgzb4yQFWx0vbtHSbq68YdAiAQsCe/UG6Ee6sd0lAif2vhgUO/mNKI+7S45
 5jBA==
X-Gm-Message-State: AOJu0Yzf3k9RZhxwRCquGugDmHqUVBvM1/2HXQPmeHk9YVPxqUliDDrh
 D6TrZEoi+knUUtWQ0AFdqlNuwA5nUtlmAtH02WO/Mg==
X-Google-Smtp-Source: AGHT+IEFgEG6MS95N8JbzkuYCpQFtksbZUQOezC1slOzX65+NwKzQQfUYTqsTMz+wZ3KdbvQaoE9cLuDHY579wkbdNw=
X-Received: by 2002:a25:26c9:0:b0:d11:c89:4256 with SMTP id
 m192-20020a2526c9000000b00d110c894256mr20176635ybm.31.1694089428516; Thu, 07
 Sep 2023 05:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230903204000.96999-1-kettenis@openbsd.org>
In-Reply-To: <20230903204000.96999-1-kettenis@openbsd.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Sep 2023 06:23:10 -0600
Message-ID: <CAPnjgZ2D6Fq5WnSxjxD2fzCZkZB0yDAk7mOda7bTuUf-KZLmhA@mail.gmail.com>
Subject: Re: [PATCH v2] bootstd: Make efi_mgr bootmeth work for non-sandbox
 setups
To: Mark Kettenis <kettenis@openbsd.org>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de
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

Hi Mark,

On Sun, 3 Sept 2023 at 14:40, Mark Kettenis <kettenis@openbsd.org> wrote:
>
> Enable the bootflow based on this bootmeth if the BootOrder EFI
> variable is set.
>
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> ---
>
> ChangeLog:
>
> v2: - Initialize EFI subsystem to populate EFI variables
>
>
>  boot/bootmeth_efi_mgr.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> index e9d973429f..e6c42d41fb 100644
> --- a/boot/bootmeth_efi_mgr.c
> +++ b/boot/bootmeth_efi_mgr.c
> @@ -14,6 +14,8 @@
>  #include <bootmeth.h>
>  #include <command.h>
>  #include <dm.h>
> +#include <efi_loader.h>
> +#include <efi_variable.h>
>
>  /**
>   * struct efi_mgr_priv - private info for the efi-mgr driver
> @@ -46,13 +48,26 @@ static int efi_mgr_check(struct udevice *dev, struct bootflow_iter *iter)
>  static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>  {
>         struct efi_mgr_priv *priv = dev_get_priv(dev);
> +       efi_status_t ret;
> +       efi_uintn_t size;
> +       u16 *bootorder;
>
>         if (priv->fake_dev) {
>                 bflow->state = BOOTFLOWST_READY;
>                 return 0;
>         }
>
> -       /* To be implemented */
> +       ret = efi_init_obj_list();

Doesn't this start up the whole EFI system? Is there a cheaper way to
see if the variable subsystem exists, or can work?

> +       if (ret)
> +               return log_msg_ret("init", ret);
> +
> +       /* Enable this method if the "BootOrder" UEFI exists. */
> +       bootorder = efi_get_var(u"BootOrder", &efi_global_variable_guid,
> +                               &size);
> +       if (bootorder) {
> +               bflow->state = BOOTFLOWST_READY;
> +               return 0;
> +       }
>
>         return -EINVAL;
>  }
> --
> 2.42.0
>

Regards,
Simon
