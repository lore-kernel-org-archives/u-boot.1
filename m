Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD8DC83F3A
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 19:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BE8586795;
	Thu, 31 Aug 2023 21:03:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HKOVeUoy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22EB086784; Thu, 31 Aug 2023 21:03:08 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8B498676C
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 21:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d7d15e6884dso875654276.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 12:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693508581; x=1694113381; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1iBw05I9LP53oCaBFkNjFImlIYSPEJAAPBbqhTyzpXA=;
 b=HKOVeUoyVkJimyPKeUQloKjZAz6mEav+rauFuPJVG4f3TYmf82rFcVxW2vBLKp8uY0
 5C3abH5dLaYkgy5TjXm7jT0NXn3SPrRZP+uq2kmFFgzokJxB0DEPEOQHomhOpGe8Vpc8
 gGG/D1PK80ZIYzqxmYpfKzxhCYosjKpOSi+N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693508581; x=1694113381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1iBw05I9LP53oCaBFkNjFImlIYSPEJAAPBbqhTyzpXA=;
 b=FYUV85mqz3WtYrnBhw9+WSiLnGRbHXlKGgc591ppr0wkqEcbPWK4ChuWm4r7LrnkRF
 3W6kIym/UB5l6f2g1FCbMSdRR9JfrqdK3nKTiJX0bmIG7olNaHhmW5iXj/Dnaq1gJyEe
 fbfSB3oZXWL9e0rgl2WSj5xwCCk3ptSRNyZdXCFzTPgorM47M9oxQH12+37yEOsHvSiy
 fl66K85C8s+UdDF2Hoa2GzH/mjoXe4Q7UnBnia+9cSUU3Zch5gyeniUIE0Rlat+xyqko
 DsSYUkx60z3T1AXOmKdRBuMJoGG0TJPp1ENyTO18WrpUlk1RcH91ErUb1+WYvo4/QBkX
 w8sA==
X-Gm-Message-State: AOJu0Yw2f2rbZDYoR7CcXrCtFD8HWUrAlHaXYurpsuesIxr9pOWoTQ+1
 SRariKRU/Ot96X5Maw9okDlBBQBjTdxgHvDpm3ilnAIqYzYQl5vqcbM=
X-Google-Smtp-Source: AGHT+IHrU5T0bmU/R7IQyGm0j9cTH3+L+Cgbivc5WC7QW2ntBHJh50xmGIZnfsWOyou0EsCOs/wM/fulkvl5gL0L0q0=
X-Received: by 2002:a25:d84c:0:b0:d0e:99be:5da2 with SMTP id
 p73-20020a25d84c000000b00d0e99be5da2mr644166ybg.65.1693508581410; Thu, 31 Aug
 2023 12:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230829203710.84201-1-seanedmond@linux.microsoft.com>
 <20230829203710.84201-4-seanedmond@linux.microsoft.com>
In-Reply-To: <20230829203710.84201-4-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Aug 2023 13:02:02 -0600
Message-ID: <CAPnjgZ1EK5pe+z2V1LNN0xs254v_4ciKRQPN2H=eZPAEY6g9ag@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] cmd: kaslrseed: Use common API to fixup FDT
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, dphadke@linux.microsoft.com, macromorgan@hotmail.com
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

On Tue, 29 Aug 2023 at 14:37, <seanedmond@linux.microsoft.com> wrote:
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
> index 8a1d8120cd..c65607619b 100644
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
> +       ret = fdt_fixup_kaslr_seed(root, buf, sizeof(buf));
> +       if (ret) {
> +               printf("ERROR: failed to add kaslr-seed to fdt\n");
>                 return CMD_RET_FAILURE;
>         }

Reviewed-by: Simon Glass <sjg@chromium.org>

So this command is intended to be used in a script? I am just trying
to understand why we have the fixup code as well as this.

Regards,
Simon
