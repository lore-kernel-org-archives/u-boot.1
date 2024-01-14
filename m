Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7027AC47077
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 14:41:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 859F187707;
	Sun, 14 Jan 2024 15:41:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gF4icYTA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC08587873; Sun, 14 Jan 2024 15:41:54 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A01B186E05
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 15:41:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2cc9fa5e8e1so92641991fa.3
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 06:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705243312; x=1705848112; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ksSZ5cyaRiil68fDDkeXi34OS46o72Q4E3J9TkupU5Q=;
 b=gF4icYTA+vhFkgbaC15whoZw7s/KQedpjAtFm7NXyXfPU4shdfZfvvL0c1BIbxcodg
 +B15HDOceBBU3E4pQR8NqBB5DcgyH8AO/nrnId/F+20c/2DLb6dvqVFXupAQmh11Kxq9
 8rChgdsxOiCWlYbI2US+U+2jV/huIZ9yJso0GAoL1gIT6RgWqfNT5K3hJi2MOypZs/QF
 369JgrYDLhtBsqdL8Nim0wl+sDwgzWOuZ0F2mf0f47oBG70XCSVCLa3hPkuOaMylhqHK
 30BBChd2JT0Wpwwu5NdCJUv/tqoV9tsnpvMbK8vQzsDvH6L2odzmA6SJPI9ksA2hXJ6B
 U2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705243312; x=1705848112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ksSZ5cyaRiil68fDDkeXi34OS46o72Q4E3J9TkupU5Q=;
 b=IZJraifJtRalXGvTimPDdsx0jpUvDLZ6DJPNd1S9DC5x89QjzSkBUE9bCyt8OiOj6h
 gVxN4d5+bpULHxgwUi33dMIoqltFKjN24VxiN7GBQNVpsVz0e06Ijj6v8+md/t93D55o
 YmKW1pHwqGuG4SPWPEIC1RPMV7Vlotiq1V5mr9uSPbTibZGgXLbSJ9UORXCIpQxJT8jE
 Cc+eLvGQNdA3GG2INy40uM26jFk3s8cI2AODRdKEBd+32P1fyQbLeHWoglvYhV6IdbHN
 CEnPuhJlBi7Q5NwHS5eAbzdZHFtOOR+4Va7n6FxmX8dxfQyyc9/Wzp2ju34KjPe4E54K
 kTPg==
X-Gm-Message-State: AOJu0YyH/gzd/VcTlP9JPNcL7kkZdkmBRj7b6iD7+ywr48HHb7ERKP70
 HnBtrOT46YL9vETDeIO2eeWNcewXo31mCzyJGhsSyeGz
X-Google-Smtp-Source: AGHT+IERCkEqwwjxabNX0E/rbSEo34jhvuGbE0pBq1c8BBIsH2i2jB1v5BMUQAsES4SLJ3WFGIFVm5TT25pPRe3GhaA=
X-Received: by 2002:a2e:ab1a:0:b0:2cd:9fbc:d3d3 with SMTP id
 ce26-20020a2eab1a000000b002cd9fbcd3d3mr1967780ljb.69.1705243311558; Sun, 14
 Jan 2024 06:41:51 -0800 (PST)
MIME-Version: 1.0
References: <20240114101701.23070-1-clamor95@gmail.com>
 <20240114101701.23070-2-clamor95@gmail.com>
In-Reply-To: <20240114101701.23070-2-clamor95@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 14 Jan 2024 14:41:40 +0000
Message-ID: <CALeDE9N6kn9Q-Uafx9-3_3xPUhLj1QN=h6DemYturrBUM5nwmQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] cmd: bootmenu: rename U-Boot console to Exit
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de
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

On Sun, 14 Jan 2024 at 10:23, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> It seems that the U-Boot console entry of the bootmenu has lost
> its original meaning. Now, even if it is chosen, the probability
> that you will enter the actual U-Boot console is quite low.
> Boot env, bootflow, bootcommand script may appear, but not the
> actual console. Hense, let's remove ambiguity and name this

Hence

> entry by what it actually does: 'Exit' the bootmenu.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  cmd/bootmenu.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/cmd/bootmenu.c b/cmd/bootmenu.c
> index 987b16889f..69fca710a8 100644
> --- a/cmd/bootmenu.c
> +++ b/cmd/bootmenu.c
> @@ -119,7 +119,7 @@ static char *bootmenu_choice_entry(void *data)
>                                 iter = iter->next;
>                         return iter->key;
>                 case BKEY_QUIT:
> -                       /* Quit by choosing the last entry - U-Boot console */
> +                       /* Quit by choosing the last entry - Exit */

I think just put "Set the last entry to Exit"

>                         iter = menu->first;
>                         while (iter->next)
>                                 iter = iter->next;
> @@ -361,15 +361,15 @@ static struct bootmenu_data *bootmenu_create(int delay)
>         }
>  #endif
>
> -       /* Add U-Boot console entry at the end */
> +       /* Add Exit entry at the end */
>         if (i <= MAX_COUNT - 1) {
>                 entry = malloc(sizeof(struct bootmenu_entry));
>                 if (!entry)
>                         goto cleanup;
>
> -               /* Add Quit entry if entering U-Boot console is disabled */
> +               /* Add Quit entry if exiting to U-Boot console is disabled */

s/Quit/Exit/

>                 if (!IS_ENABLED(CONFIG_BOOTMENU_DISABLE_UBOOT_CONSOLE))
> -                       entry->title = strdup("U-Boot console");
> +                       entry->title = strdup("Exit");
>                 else
>                         entry->title = strdup("Quit");
>
> @@ -532,7 +532,7 @@ static enum bootmenu_ret bootmenu_show(int delay)
>                 title = strdup(iter->title);
>                 command = strdup(iter->command);
>
> -               /* last entry is U-Boot console or Quit */
> +               /* last entry is Exit or Quit */

"Last entry is Exit" as I don't see Quit referred to.

>                 if (iter->num == iter->menu->count - 1) {
>                         ret = BOOTMENU_RET_QUIT;
>                         goto cleanup;
> --
> 2.40.1
>
