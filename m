Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E578CE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAAD4874B9;
	Mon,  2 Oct 2023 03:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FeSyEmsx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D258B87485; Mon,  2 Oct 2023 03:22:56 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC56E87280
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9ae2cc4d17eso2229023566b.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209765; x=1696814565; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wl1k4VWTO4vkZJfqiO7ZAyz379tWSJ+a9pGIPpXK4YI=;
 b=FeSyEmsxlb8SAjDD/NS4FsdrwfUTWVJa1YvKPJ1u2gIezYwo612RUcpS46d5RqNeUz
 hbNWqhLqHYEeA4ljDTqCPYRuUZzWG+XHldqQz7YNKOV7BxWSMmPcvsxjuSzr4bpqH1kT
 2zAT2/tl4gaGNVWiqaIqmSngUlzy7dmquSuTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209765; x=1696814565;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wl1k4VWTO4vkZJfqiO7ZAyz379tWSJ+a9pGIPpXK4YI=;
 b=j4pRfH96grsNtZ+7RiGVK+dZtUdpIGecbP4y4HNFGOsfaot6D2SRHBlHFd+KOkBw1b
 2NWGgCcfz1/OskkVFLrvPK358dY5xY3fMWvfMxO3JP5WcdRugkgi9TfniimYVmJ0xHcX
 9FO/v+NEiFsG6p1yWXUXQ9YUVAQI1HHXpQTBcqqyM/EfvCgYZ6plnzXPygcs/jAfFBRQ
 5oPWl1wgjhK9AdU4Qrw8AMthjrjjZEfV3I8MUB2AfnbUFl/yzSVwpdOiQvfEhjaB24n1
 Ca51zKB/S0IhY6GoKdBshwW5Q8QIXanEaeEbBRS3kGy7mp1R8+nzPvyHMDI7ghM4CPHs
 2L3g==
X-Gm-Message-State: AOJu0YxOlWG4k87rM/1YgcH6aUy6BGhEX5zpKtvqD60eNMVx2eQdV/s8
 6LvVvokvXXfot3O4dFgS6KCiYl2rfpjhlJWu9wUUEnXV6b4zvF6uvVo=
X-Google-Smtp-Source: AGHT+IE88UX/0F6nLUbj+r0dPSbY7RW9Win0Ch2nFElteqnrp9g4aXjVPiroySVcNCYWf2yOUTcPSbx1sBUGtJgGx84=
X-Received: by 2002:a17:906:210a:b0:9ae:7681:f62a with SMTP id
 10-20020a170906210a00b009ae7681f62amr8130916ejt.44.1696209765215; Sun, 01 Oct
 2023 18:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230926084346.2237483-1-bmeng@tinylab.org>
 <20230926084346.2237483-11-bmeng@tinylab.org>
In-Reply-To: <20230926084346.2237483-11-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:01 -0600
Message-ID: <CAPnjgZ082BzO4AGXvYqkaZPC_BkF1zc_AAW1zV9k31GnZhwpJQ@mail.gmail.com>
Subject: Re: [PATCH 10/15] cmd: blk_common: Use macros for the return values
To: Bin Meng <bmeng@tinylab.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Tobias Waldekranz <tobias@waldekranz.com>
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

Hi Bin,

On Tue, 26 Sept 2023 at 02:54, Bin Meng <bmeng@tinylab.org> wrote:
>
> Avoid using magic number 0/1 for the command result.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
>  cmd/blk_common.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/cmd/blk_common.c b/cmd/blk_common.c
> index 9f9d4327a9..ad9b16dc09 100644
> --- a/cmd/blk_common.c
> +++ b/cmd/blk_common.c
> @@ -25,18 +25,18 @@ int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
>         case 2:
>                 if (strncmp(argv[1], "inf", 3) == 0) {
>                         blk_list_devices(uclass_id);
> -                       return 0;
> +                       return CMD_RET_SUCCESS;

I really don't like this...0 is success.

>                 } else if (strncmp(argv[1], "dev", 3) == 0) {
>                         if (blk_print_device_num(uclass_id, *cur_devnump)) {
>                                 printf("\nno %s devices available\n", if_name);
>                                 return CMD_RET_FAILURE;
>                         }
> -                       return 0;
> +                       return CMD_RET_SUCCESS;
>                 } else if (strncmp(argv[1], "part", 4) == 0) {
>                         if (blk_list_part(uclass_id))
>                                 printf("\nno %s partition table available\n",
>                                        if_name);
> -                       return 0;
> +                       return CMD_RET_SUCCESS;
>                 }
>                 return CMD_RET_USAGE;
>         case 3:
> @@ -49,7 +49,7 @@ int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
>                         } else {
>                                 return CMD_RET_FAILURE;
>                         }
> -                       return 0;
> +                       return CMD_RET_SUCCESS;
>                 } else if (strncmp(argv[1], "part", 4) == 0) {
>                         int dev = (int)dectoul(argv[2], NULL);
>
> @@ -58,7 +58,7 @@ int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
>                                        if_name, dev);
>                                 return CMD_RET_FAILURE;
>                         }
> -                       return 0;
> +                       return CMD_RET_SUCCESS;
>                 }
>                 return CMD_RET_USAGE;
>
> @@ -80,7 +80,7 @@ int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
>
>                         printf("%ld blocks read: %s\n", n,
>                                n == cnt ? "OK" : "ERROR");
> -                       return n == cnt ? 0 : 1;
> +                       return n == cnt ? CMD_RET_SUCCESS : CMD_RET_FAILURE;

CMD_RET_FAILURE is OK, but I would prefer not to use CMD_RET_SUCCESS.
It is 0 and always will be.

It encourages people to do things like:

if (ret == CMD_RET_SUCCESS)

instead of

if (!ret)

It would eventually creep into everything, including our clean error handling.

>                 } else if (strcmp(argv[1], "write") == 0) {
>                         phys_addr_t paddr = hextoul(argv[2], NULL);
>                         lbaint_t blk = hextoul(argv[3], NULL);
> @@ -98,7 +98,7 @@ int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
>
>                         printf("%ld blocks written: %s\n", n,
>                                n == cnt ? "OK" : "ERROR");
> -                       return n == cnt ? 0 : 1;
> +                       return n == cnt ? CMD_RET_SUCCESS : CMD_RET_FAILURE;
>                 } else {
>                         return CMD_RET_USAGE;
>                 }
> --
> 2.25.1
>

Regards,
Simon
