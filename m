Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C961C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 17:48:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD7EC8779C;
	Wed, 29 Nov 2023 18:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c3WrbDqb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 877798778C; Wed, 29 Nov 2023 18:47:49 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97AC78772E
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:47:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a08e4352992so4280066b.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701280065; x=1701884865; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kKuFjGBujDwyqxpWgWPbelTkEhd4b1BkNVLkBFENxjI=;
 b=c3WrbDqbCMvTtEDFJc1UF2YOpvKk+nuPZIv48TCdzfdKNwnQpeEB1JDOt5LNX5GogG
 Fl88f0m5XjI0/CCjdja0Ngg7Ym95HHBZjgahsD1pn6TeYRcAq+5OGRvSp//iNhecRIFW
 boEmxmdxDnkzWcVs9rnzAMoV7J44SLZ+FoDgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701280065; x=1701884865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kKuFjGBujDwyqxpWgWPbelTkEhd4b1BkNVLkBFENxjI=;
 b=M4CCLA5r1vh+rNIaB1O7xd7X/Y0LNbnu4jpPwUUByFp3i9Vne7o7fteFsvjFxL9Ivs
 1P06KLIID+4HyiSugOUJUvychOUUUUbAuFfzO80sbSt3WZAM4IHAmf3wExO7twDJLkYl
 lIIR/A2BXsTFoQgIo7CE4GfNAW8+9Bd4kXSL7pCwhkSA7vvTRAFb7kMe3iHZAINXBix1
 Qn3AOzN3kujRi1Re+iYvFHYrCGVwfQ3/4pn3DNFCQtY4aerv8QCOt6ZM2hypbzHUUDoQ
 w2fWyMnk05sqVuLnFhSMOkKfgUifoFXIQZ041qF42hRxxs2yk4OCNfuo+ipP2lGCNrUG
 2bHg==
X-Gm-Message-State: AOJu0Ywj2wfAXi52TA8vn8KgddR5rJ28P1xFKr+TY8Lrddz7/whIISYo
 IqkCDKU/kFNTn9S2tOE8ghXXHcYQtDwz4gNklts3ZQ==
X-Google-Smtp-Source: AGHT+IGE+dXLSnkr/g01eCyPdAS6z8Z4kmMZHnxcjvte3itVajFW4KgO8REFMJKm68S1SOLalxjuK0zGTPAZoR8bH0A=
X-Received: by 2002:a17:906:1da:b0:9be:466c:1824 with SMTP id
 26-20020a17090601da00b009be466c1824mr13965779ejj.11.1701280064981; Wed, 29
 Nov 2023 09:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20231117020207.948636-1-seanedmond@linux.microsoft.com>
 <20231117020207.948636-4-seanedmond@linux.microsoft.com>
In-Reply-To: <20231117020207.948636-4-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 10:47:30 -0700
Message-ID: <CAPnjgZ0tj-MU9kaD-Q1E53dvH4mZ-PE9g51J59m=PPywEViebA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] cmd: kaslrseed: Use common API to fixup FDT
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

On Thu, 16 Nov 2023 at 19:02, <seanedmond@linux.microsoft.com> wrote:
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

Reviewed-by: Simon Glass <sjg@chromium.org>

As a follow-up, you could add a test for this command


> diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
> index 9acb8e16386..23ed7c066aa 100644
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
> -       if (ret < 0) {
> -               printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
> +       ret = fdt_fixup_kaslr_seed(root, (u8 *)buf, sizeof(buf));
> +       if (ret) {
> +               printf("ERROR: failed to add kaslr-seed to fdt\n");
>                 return CMD_RET_FAILURE;
>         }
>
> --
> 2.42.0
>
