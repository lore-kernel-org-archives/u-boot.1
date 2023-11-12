Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B6BC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:07:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D496687263;
	Sun, 12 Nov 2023 21:03:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Akafpvln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 327D4874DE; Sun, 12 Nov 2023 21:03:46 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28CA187479
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d9caf5cc948so3847591276.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819423; x=1700424223; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I5PztMVhUIHkTXGsv9eQuQeLqOmsxAKX53Zn5Kc8CY4=;
 b=Akafpvln2UG/PWeqhU6Z7Ksfr8DzG5sein6YhSUd/kD0zjzfsvSX5uVxoKtNEhdAcb
 80lZREz6yMeSRooaMLsljzU9FGbSsq0hy1XnIAuRMhBHJ0mzQltJZAHMmMQKxrFgDhWI
 1VR2KtG8zyfp4weBG5m3iWD8rO7XfapPkffuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819423; x=1700424223;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I5PztMVhUIHkTXGsv9eQuQeLqOmsxAKX53Zn5Kc8CY4=;
 b=jQ/KHYfePbHviIh+p8tnxdDSTJ8S5z1dEeeyoSIdUar5OCBwsvzaic60GSN0CQfzgc
 YquVPTqoghdEZ3lKjKxivh/M3g2dRIaRqrmPj/ofcAJFkBrt+XlgDUdoGnwd42Muctsl
 tv8X01GHbE5miclQU0pX/JBx6eqDMF69DxwX1ZkKf5tLW2G8+GGcUEFPW63pdZOZkklD
 MqCEBLr3oKX7g0z7fVnYHGoY7TRvBPlaUFw3WK1h8KibTgW0atBm5DsH2EoNinriq8nn
 tlCAxFvOIkQA1lo2rokpF6GetCtrh3HTay1zzqaDAlTENmgwdqIfdILTZhjidolv+WLQ
 IJkw==
X-Gm-Message-State: AOJu0YwIcHJkVhrfbs4swwOOoWOqsHqe0RhBkrYV4MoRHq5+Ozw3CbvC
 sDgIUKryARisqGXXvBpgEpVTqWFZ8Cvm0Usw4y6HWw==
X-Google-Smtp-Source: AGHT+IEuetCwVdSAfFiqTNKyn4IJ+hkxfcFNKGhp69ZsOey14Fu+dkdRHOtIMfq05ffG21PA55S/hysE9M3h33QsQC0=
X-Received: by 2002:a05:690c:306:b0:569:e7cb:cd4e with SMTP id
 bg6-20020a05690c030600b00569e7cbcd4emr2036662ywb.48.1699819422729; Sun, 12
 Nov 2023 12:03:42 -0800 (PST)
MIME-Version: 1.0
References: <20231103183844.2308934-1-seanedmond@linux.microsoft.com>
 <20231103183844.2308934-4-seanedmond@linux.microsoft.com>
In-Reply-To: <20231103183844.2308934-4-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 13:01:09 -0700
Message-ID: <CAPnjgZ3KPq3ihrQAnb-Bpg5FxPq3cG3e-jBXv9Bw-gb8KcfRZA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] cmd: kaslrseed: Use common API to fixup FDT
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, dphadke@linux.microsoft.com, 
 ilias.apalodimas@linaro.org, trini@konsulko.com
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

Hi Sean,

On Fri, 3 Nov 2023 at 12:38, <seanedmond@linux.microsoft.com> wrote:
>
> From: Sean Edmond <seanedmond@microsoft.com>
>
> Use the newly introduced common API fdt_fixup_kaslr_seed() in the
> kaslrseed command.
>
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> ---
>  cmd/kaslrseed.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
> index 9acb8e16386..6f423702e7c 100644
> --- a/cmd/kaslrseed.c
> +++ b/cmd/kaslrseed.c
> @@ -19,7 +19,7 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const
>         size_t n = 0x8;
>         struct udevice *dev;
>         u64 *buf;
> -       int nodeoffset;
> +       ofnode root;
>         int ret = CMD_RET_SUCCESS;
>
>         if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> @@ -45,21 +45,15 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const
>                 return CMD_RET_FAILURE;
>         }
>
> -       ret = fdt_check_header(working_fdt);
> -       if (ret < 0) {
> -               printf("fdt_chosen: %s\n", fdt_strerror(ret));
> -               return CMD_RET_FAILURE;
> -       }
> -
> -       nodeoffset = fdt_find_or_add_subnode(working_fdt, 0, "chosen");
> -       if (nodeoffset < 0) {
> -               printf("Reading chosen node failed\n");
> -               return CMD_RET_FAILURE;
> +       ret = root_ofnode_from_fdt(working_fdt, &root);
> +       if (ret) {
> +               printf("ERROR: Unable to get root ofnode\n");
> +               goto CMD_RET_FAILURE;
>         }
>
> -       ret = fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, sizeof(buf));

It looks like this buf needs a cast to u8 *

> -       if (ret < 0) {
> -               printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
> +       ret = fdt_fixup_kaslr_seed(root, buf, sizeof(buf));
> +       if (ret) {
> +               printf("ERROR: failed to add kaslr-seed to fdt\n");
>                 return CMD_RET_FAILURE;
>         }
>
> --
> 2.42.0
>

Regards,
Simon
