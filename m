Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA085C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B85D8713D;
	Sat, 18 Nov 2023 18:11:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZXN/ynuR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 434D686FED; Sat, 18 Nov 2023 18:11:35 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 512F086D11
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:11:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5c9169300caso6127847b3.2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700327489; x=1700932289; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xqC2v5WHF+QnG4TItPwb/wS1HB/6JE7k+uolNQnJAck=;
 b=ZXN/ynuRz62Y5Y52GLnDbl5oZ8GaR+hI+Lksm6f8aNPyiHbqdmPVuXi+qZvCW5qbTy
 wD12WP2l/TkyPnU228tOWsmDAuuNBtlfQO1FgXfZcn4bqt9UPeg3+CsPwR02Kog6gi+E
 zGV7QOFoxIxUCLkg2a38vdRRWlVoUIhdATtI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700327489; x=1700932289;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xqC2v5WHF+QnG4TItPwb/wS1HB/6JE7k+uolNQnJAck=;
 b=F5mKa4Q5njUjyGZ6WN0EPKzzcz62L8LaKoKi9+54a06p1yDw8NeXHPlLfu2cl17JCa
 CYQG0e29Imu0hapWwLHMOlwy73w/e00/8553Guy18u7wFuYOWdqwNIP7Iu47UtIUjDzt
 TE+ZTUP9TkOgOJ/SM2GspcNirAIPVNfrgZC7TsdQH5QTxB3IWf9w3t+HFafumy/+95SF
 iqH1gBvRf3APiKWhalr4OGU/P16CgNykQxDmC1FJFXGA1XuJcLePS5lKRnASa5U+wHop
 xjpkSLu1KrJWPPO3cBKdbU6Hp+xbslLR8T2Nba0sMFzJdI+rzPCsltqpnstGYjDo6UtE
 27rA==
X-Gm-Message-State: AOJu0YxCekmAIrMroiLvyPmWjzLlIM/+G2yoJTWTYvIqm98/vsu0bHdO
 /XOJN8kMyvOYzkTUpuV+s8b1/uzXtA+6tPE8pDw9xg==
X-Google-Smtp-Source: AGHT+IFmGmNELC9ub8iOg/0uIUuQyKA7+NWHS0POROas+HoYI2SBz6VeTId2RIdyo5UpCXWlPiRPARjiQlCGTNowYCk=
X-Received: by 2002:a0d:c8c6:0:b0:583:c917:7ff0 with SMTP id
 k189-20020a0dc8c6000000b00583c9177ff0mr2434105ywd.51.1700327488792; Sat, 18
 Nov 2023 09:11:28 -0800 (PST)
MIME-Version: 1.0
References: <20231117212039.1210784-1-i@shantur.com>
 <20231117212039.1210784-4-i@shantur.com>
In-Reply-To: <20231117212039.1210784-4-i@shantur.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:10:08 -0700
Message-ID: <CAPnjgZ1HHhFdgDUWfN7shw11Vo_-xVDmz55jk6Whfv9p03ZMtQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] bootflow: bootmeth_efi: Handle fdt not available.
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, xypron.glpk@gmx.de
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

Hi Shantur,

On Fri, 17 Nov 2023 at 14:22, Shantur Rathore <i@shantur.com> wrote:
>
> While booting with efi, if fdt isn't available externally,
> just use the built-in one.
>
> Signed-off-by: Shantur Rathore <i@shantur.com>
> ---
>  boot/bootmeth_efi.c | 10 +++++++++-
>  include/bootflow.h  |  1 +
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> index 5917458dc5..5e67afed88 100644
> --- a/boot/bootmeth_efi.c
> +++ b/boot/bootmeth_efi.c
> @@ -313,6 +313,7 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
>                  */
>         } else {
>                 log_debug("No device tree available\n");
> +               bflow->flags |= BOOTFLOWF_USE_BUILTIN_FDT;
>         }
>
>         return 0;
> @@ -382,6 +383,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
>                 bflow->fdt_addr = fdt_addr;
>         } else {
>                 log_debug("No device tree available\n");
> +               bflow->flags |= BOOTFLOWF_USE_BUILTIN_FDT;
>         }
>
>         bflow->state = BOOTFLOWST_READY;
> @@ -443,7 +445,13 @@ static int distro_efi_boot(struct udevice *dev, struct bootflow *bflow)
>          * At some point we can add a real interface to bootefi so we can call
>          * this directly. For now, go through the CLI, like distro boot.
>          */
> -       snprintf(cmd, sizeof(cmd), "bootefi %lx %lx", kernel, fdt);
> +       if (bflow->flags & BOOTFLOWF_USE_BUILTIN_FDT) {
> +               log_debug("Booting with built-in fdt\n");
> +               snprintf(cmd, sizeof(cmd), "bootefi %lx", kernel);
> +       } else {
> +               snprintf(cmd, sizeof(cmd), "bootefi %lx %lx", kernel, fdt);
> +       }
> +

There is some code (not shown) in this function:

   /*
    * use the provided device tree if available, else fall back to
    * the control FDT
    */
   if (bflow->fdt_fname)

I believe that should use your flag as well. So instead of using
fdt_fname to indicate whether there is an fdt, we should use your new
flag.

>         if (run_command(cmd, 0))
>                 return log_msg_ret("run", -EINVAL);
>
> diff --git a/include/bootflow.h b/include/bootflow.h
> index fede8f22a2..3890cd4bc2 100644
> --- a/include/bootflow.h
> +++ b/include/bootflow.h
> @@ -49,6 +49,7 @@ enum bootflow_state_t {
>  enum bootflow_flags_t {
>         BOOTFLOWF_USE_PRIOR_FDT = 1 << 0,
>         BOOTFLOWF_STATIC_BUF    = 1 << 1,
> +       BOOTFLOWF_USE_BUILTIN_FDT       = 1 << 2,

Please update the comment for the enum to fully explain what it does

>  };
>
>  /**
> --
> 2.40.1
>

Regards,
Simon
