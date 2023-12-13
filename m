Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC80C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 19:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E9568784C;
	Wed, 13 Dec 2023 20:52:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SSj0K3hC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D16587846; Wed, 13 Dec 2023 20:52:22 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F31C8783B
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 20:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-dbcb4747d84so2479928276.2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 11:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702497136; x=1703101936; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wr8y3gbFtXx9JzCKRNEUGIz7LPSYTkWgGrL5Ong2Cww=;
 b=SSj0K3hCAwAqILqeh/O+ostfyzWfPnZduwY4TNbKAda3mH7jV01OYV19oypRfKhw83
 gVXqBk8ftcdCoDW3lhLumNd8W1S7z0watTe6qTJXOlYkujBT4YtsQ+NXa/+BtZuWNbZB
 2EFfCRqGmZICHfFJ+y7J8ctQlwWPx9dMAtHUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702497136; x=1703101936;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wr8y3gbFtXx9JzCKRNEUGIz7LPSYTkWgGrL5Ong2Cww=;
 b=X33O47XS1SIgFoy6IpitpYVTTTR2+KI/jLi1TOcdZyPvlxhlZmKj6kaKd0KQIKAyze
 QAZMUW+u46CTs/IKxeW0t/buRPUVTSKIcb+wDVMPzg0YGUAf1WvvrUzJoGm35GtAkCte
 ignAAbFFa+9jJ4QTJG1OPG3QevWJA+2Z1MTBvRSI0lRWOHS18OXus5dQOuSXRMJKoLNt
 ia4oGXSR7tN+xlTSvk08OGePoqiTUorkRyPpqNs0bMld3kqIgl4PdKh8iGBQH/efXt/M
 6QpB1z57mw/ccFb6xKrslvxLFooH3hdbJbza4e6KXlhbIvIjQTnF9N+pwG0F+w618Tw3
 6TBw==
X-Gm-Message-State: AOJu0YwZSEAhIH6yeiztSDVaVSFJUWbqPyYxBSZ0bC1B063+tHrilUcM
 P2ZmZwQOgpzho++kd5HZPRWoNoqVODEbTLZzcn0RAh5fprPS5hOW/x4=
X-Google-Smtp-Source: AGHT+IGYTO165n8qD/MTvFK29yWDG7DCNA14AEcfSrEDvV1xP7ZJ8VdRUDSWGPUAboIaDAmZEElSapYc3WpXc+0eUQ4=
X-Received: by 2002:a25:4106:0:b0:dbc:b2e8:db2a with SMTP id
 o6-20020a254106000000b00dbcb2e8db2amr3167333yba.37.1702497135953; Wed, 13 Dec
 2023 11:52:15 -0800 (PST)
MIME-Version: 1.0
References: <20231211110317.697011-1-matthias.schiffer@ew.tq-group.com>
In-Reply-To: <20231211110317.697011-1-matthias.schiffer@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:51:39 -0700
Message-ID: <CAPnjgZ1iF6k8Dv+nk7p7Jq-+jqfOGXYUtFTyMSThN28bM=e3zQ@mail.gmail.com>
Subject: Re: [PATCH] boot: add support for fdt_fixup command in environment
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, 11 Dec 2023 at 04:04, Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> The "fdt" command is convenient for making small changes to the OS FDT,
> especially during development. This is easy when the kernel and FDT are
> loaded separately, but can be cumbersome for FIT images, requiring to
> unpack the image, manually apply overlays, etc.
>
> Add an option to execute a command "fdt_fixup" from the environment at
> the beginning of image_setup_libfdt() (after overlays are applied, and
> before the other fixups).
>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  boot/Kconfig     |  9 +++++++++
>  boot/image-fdt.c | 19 +++++++++++++++++--
>  2 files changed, 26 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

How about a test?


>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index ef71883a502..7eea935f490 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1502,6 +1502,15 @@ if OF_LIBFDT
>
>  menu "Devicetree fixup"
>
> +config OF_ENV_SETUP
> +       bool "Run a command from environment to set up device tree before=
 boot"
> +       depends on CMD_FDT
> +       help
> +         This causes U-Boot to run a command from the environment variab=
le
> +         fdt_fixup before booting into the operating system, which can u=
se the
> +         fdt command to modify the device tree. The device tree is then =
passed
> +         to the OS.
> +
>  config OF_BOARD_SETUP
>         bool "Set up board-specific details in device tree before boot"
>         help
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index f10200f6474..78b5c639381 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -9,6 +9,7 @@
>   */
>
>  #include <common.h>
> +#include <command.h>
>  #include <fdt_support.h>
>  #include <fdtdec.h>
>  #include <env.h>
> @@ -608,8 +609,22 @@ int image_setup_libfdt(struct bootm_headers *images,=
 void *blob,
>  {
>         ulong *initrd_start =3D &images->initrd_start;
>         ulong *initrd_end =3D &images->initrd_end;
> -       int ret =3D -EPERM;
> -       int fdt_ret;
> +       int ret, fdt_ret;
> +
> +       if (IS_ENABLED(CONFIG_OF_ENV_SETUP)) {
> +               const char *fdt_fixup;
> +
> +               fdt_fixup =3D env_get("fdt_fixup");
> +               if (fdt_fixup) {
> +                       set_working_fdt_addr(map_to_sysmem(blob));

Is that not already done?

> +                       ret =3D run_command_list(fdt_fixup, -1, 0);
> +                       if (ret)
> +                               printf("WARNING: fdt_fixup command return=
ed %d\n",
> +                                      ret);
> +               }

Would it make sense to put this code near the end of the function,
after other fixups have been done?

> +       }
> +
> +       ret =3D -EPERM;
>
>         if (fdt_root(blob) < 0) {
>                 printf("ERROR: root node setup failed\n");
> --
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> https://www.tq-group.com/
>

Regards,
Simon
