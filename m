Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154C2D58D40
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 13:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A9AB899B1;
	Mon, 25 Nov 2024 14:03:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HxZKEk6I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82C58899DF; Mon, 25 Nov 2024 14:03:32 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DD9B899AB
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 14:03:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7ea8de14848so3123457a12.2
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 05:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732539808; x=1733144608; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GrhTNJo4Htnuas3cuANBv+RvWSWnN7shuXU3H9hRzoA=;
 b=HxZKEk6I3kqsMKgL+Q0NYBvI84iH7NZ9kOXjh+0uPqQHlCKKA1XUYfYjrVZsA2Io4G
 0XoZ2PHSet/Av+SUPjw3URzGQzh7L5JBhxYPlV1Ozt/GqVksiodVzjKoykiaJ7fqhEgB
 MMzP3y9DSC6T5eNv9m3jv20OuKM29hRb1ZA4HDbijbk2gCPUPZJMLNytHzbxEWJ6xs1R
 AN/rvcaktCc8MkGWs8rmVzxG1XWkzZcCKYcFMulbrSCWiVbJTKRX+iV6MzhWDki2+q00
 a3RkpaPQp6xU6fhB4wlmlJb3IREtucfuoJwHEP7dhC3cIStMds5f3EGRl5HMjCYvnEir
 xu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732539808; x=1733144608;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GrhTNJo4Htnuas3cuANBv+RvWSWnN7shuXU3H9hRzoA=;
 b=sC6uzlAqs4shihzVqnGWbIdl1aU+m1BerTo4Fqj4ULFzn2pzKLfjk4RaLl+RkArBYO
 HdzkhHgQnCVkibmxfSly60VYbkFlHhQCfszkd4P0MoVVJ6JIfrxv8c36J/t9FVtbVNWS
 fULIEkx2sgwkScwl0LL2nRQJByTZnFGldhBGiZsuY2xuGJC5sZlqCYKx4RvT0trCj8nB
 /qnj/bfLy2ou8UDP1dj6CFYp+Bv6YIxbpghwdzWwGDA6otTqZDAuUlSKSd1Ok9uYCfjA
 VA8QDzaX5coBycz/93mcuw8spoyhuhooKEog6Hb/1WCBvL08CwQdwHmRQVXI24akDFUt
 pUEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxwdVtvJbtDWvskVymgPD0eyY2cu2a6VrD1wmN/cP3wpOQ4fdg1XMSg+Og9LN9FjVk23iNrKA=@lists.denx.de
X-Gm-Message-State: AOJu0YyzNTR7sGKrtIX2GxtsiBl116qXcUmY/jv4/GeW0yVkpkXWTAQT
 Bqc/MJsUD7chHIToMBVjsFfYnT5LMjHkUcPmsvh9raQc/KRYJ93NtWnCwAalSDUH60/Fezkgr97
 lZsd1YpEmmK+PxMgRGIeHG+xa1O/tfqj9UpbzDA==
X-Gm-Gg: ASbGncsFW8Pa90yB1WpYsunIT4/gCCTxyJ0nIOWvoiSNsQkvSmxEBGFuHh+zdr+M+cZ
 AgUEw+SKmfcwjCqE9g1u+2fC6ud9U1g==
X-Google-Smtp-Source: AGHT+IH+PVTUnI7Bfj7USljApvFbHWc1gTsI3nrWiSaY0hu0GJleVwKkGmYYK+P40PBPTavfB+nbJCyn5WiMxPp60jg=
X-Received: by 2002:a05:6a21:9101:b0:1dc:154a:81fa with SMTP id
 adf61e73a8af0-1e09e4b1757mr18616393637.26.1732539808390; Mon, 25 Nov 2024
 05:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-6-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241123214554.305285-6-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 25 Nov 2024 15:02:52 +0200
Message-ID: <CAC_iWjJWKXAyiWomuUV_K72=4tFG0=eOQ3_syW6Oe5xhwfi_RQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] cmd: bootmenu: add parameter -e for UEFI boot
 options
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Michal Simek <michal.simek@amd.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, 
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
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

On Sat, 23 Nov 2024 at 23:46, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The bootmenu command can display
>
> * menu entries defined by environment variables
> * menu entries defined by UEFI boot options
>
> Not in all cases showing the UEFI boot options is desired.
> Provide a new parameter '-e' to select the display of UEFI boot options.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  cmd/bootmenu.c             | 39 +++++++++++++++++++++++++++++---------
>  doc/usage/cmd/bootmenu.rst | 13 ++++++++++---
>  2 files changed, 40 insertions(+), 12 deletions(-)
>
> diff --git a/cmd/bootmenu.c b/cmd/bootmenu.c
> index ffa63a4628d..90f4f3d583c 100644
> --- a/cmd/bootmenu.c
> +++ b/cmd/bootmenu.c
> @@ -330,7 +330,13 @@ static int prepare_uefi_bootorder_entry(struct bootmenu_data *menu,
>  }
>  #endif
>
> -static struct bootmenu_data *bootmenu_create(int delay)
> +/**
> + * bootmenu_create() - create boot menu entries
> + *
> + * @uefi:      consider UEFI boot options
> + * @delay:     autostart delay in seconds
> + */
> +static struct bootmenu_data *bootmenu_create(int uefi, int delay)
>  {
>         int ret;
>         unsigned short int i = 0;
> @@ -357,7 +363,7 @@ static struct bootmenu_data *bootmenu_create(int delay)
>                 goto cleanup;
>
>  #if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR)) && (IS_ENABLED(CONFIG_CMD_EFICONFIG))
> -       if (i < MAX_COUNT - 1) {
> +       if (uefi && i < MAX_COUNT - 1) {
>                 efi_status_t efi_ret;
>
>                 /*
> @@ -481,7 +487,13 @@ static void handle_uefi_bootnext(void)
>                 run_command("bootefi bootmgr", 0);
>  }
>
> -static enum bootmenu_ret bootmenu_show(int delay)
> +/**
> + * bootmenu_show - display boot menu
> + *
> + * @uefi:      generated entries for UEFI boot options
> + * @delay:     autoboot delay in seconds
> + */
> +static enum bootmenu_ret bootmenu_show(int uefi, int delay)
>  {
>         int cmd_ret;
>         int init = 0;
> @@ -495,7 +507,7 @@ static enum bootmenu_ret bootmenu_show(int delay)
>         efi_status_t efi_ret = EFI_SUCCESS;
>         char *option, *sep;
>
> -       if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR))
> +       if (IS_ENABLED(CONFIG_CMD_BOOTEFI_BOOTMGR) && uefi)
>                 handle_uefi_bootnext();
>
>         /* If delay is 0 do not create menu, just run first entry */
> @@ -514,7 +526,7 @@ static enum bootmenu_ret bootmenu_show(int delay)
>                 return (cmd_ret == CMD_RET_SUCCESS ? BOOTMENU_RET_SUCCESS : BOOTMENU_RET_FAIL);
>         }
>
> -       bootmenu = bootmenu_create(delay);
> +       bootmenu = bootmenu_create(uefi, delay);
>         if (!bootmenu)
>                 return BOOTMENU_RET_FAIL;
>
> @@ -609,7 +621,7 @@ int menu_show(int bootdelay)
>         int ret;
>
>         while (1) {
> -               ret = bootmenu_show(bootdelay);
> +               ret = bootmenu_show(1, bootdelay);
>                 bootdelay = -1;
>                 if (ret == BOOTMENU_RET_UPDATED)
>                         continue;
> @@ -635,11 +647,19 @@ int do_bootmenu(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  {
>         char *delay_str = NULL;
>         int delay = 10;
> +       int uefi = 0;
>
>  #if defined(CONFIG_BOOTDELAY) && (CONFIG_BOOTDELAY >= 0)
>         delay = CONFIG_BOOTDELAY;
>  #endif
>
> +       if (argc >= 2) {
> +               if (!strcmp("-e", argv[1])) {
> +                       uefi = 1;
> +                       --argc;
> +                       ++argv;
> +               }
> +       }
>         if (argc >= 2)
>                 delay_str = argv[1];
>
> @@ -649,13 +669,14 @@ int do_bootmenu(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>         if (delay_str)
>                 delay = (int)simple_strtol(delay_str, NULL, 10);
>
> -       bootmenu_show(delay);
> +       bootmenu_show(uefi, delay);
>         return 0;
>  }
>
>  U_BOOT_CMD(
>         bootmenu, 2, 1, do_bootmenu,
>         "ANSI terminal bootmenu",
> -       "[delay]\n"
> -       "    - show ANSI terminal bootmenu with autoboot delay"
> +       "[-e] [delay]\n"
> +       "-e    - show UEFI entries\n"
> +       "delay - show ANSI terminal bootmenu with autoboot delay"
>  );
> diff --git a/doc/usage/cmd/bootmenu.rst b/doc/usage/cmd/bootmenu.rst
> index 294cc02b17a..cd5597bc646 100644
> --- a/doc/usage/cmd/bootmenu.rst
> +++ b/doc/usage/cmd/bootmenu.rst
> @@ -11,7 +11,7 @@ Synopsis
>  --------
>  ::
>
> -    bootmenu [delay]
> +    bootmenu [-e] [delay]
>
>  Description
>  -----------
> @@ -28,6 +28,14 @@ The "bootmenu" command interprets ANSI escape sequences, so
>  an ANSI terminal is required for proper menu rendering and item
>  selection.
>
> +-e
> +    show menu entries based on UEFI boot options
> +
> +delay
> +    is the autoboot delay in seconds, after which the first
> +    menu entry will be selected automatically
> +
> +
>  The assembling of the menu is done via a set of environment variables
>  "bootmenu_<num>" and "bootmenu_delay", i.e.::
>
> @@ -35,8 +43,7 @@ The assembling of the menu is done via a set of environment variables
>      bootmenu_<num>="<title>=<commands>"
>
>  <delay>
> -    is the autoboot delay in seconds, after which the first
> -    menu entry will be selected automatically
> +    autostart delay in seconds
>
>  <num>
>      is the boot menu entry number, starting from zero
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
