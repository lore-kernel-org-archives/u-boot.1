Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F268CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 10:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 915C583F85;
	Fri, 10 Oct 2025 12:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X6PPegJ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53B0183FA8; Fri, 10 Oct 2025 12:35:34 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FB0F83F69
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 12:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-637dbabdb32so3638566a12.2
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 03:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760092532; x=1760697332; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4KFL7DboHUzOxeN6sDdAdBZZZGP4ynWFriZA+nQ+Lk8=;
 b=X6PPegJ5qeB5feJaBPapV8Y8wN713tw4/DJrkzIfLc0jeowTO0T2ip98Zh4T+g1jOY
 DIIiAYVrzuKKFYIp+aIEhJaX0KwOwiVodwZul5tE0g4sumb2fc+OnVycWqihxQevqWuT
 UXv3XdhGtVsFFXYK4NM1ojoSCH0ZVNudGJoU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760092532; x=1760697332;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4KFL7DboHUzOxeN6sDdAdBZZZGP4ynWFriZA+nQ+Lk8=;
 b=j+jRFn+uPqGXJSC9UXSHID6xmYmhAbZqureIGsJ2ikR569fgnuEtEMAPxZTiwEcDGO
 5ZFmVRrcGKneEXcDGCszmlxs+BcMjba7uHBn8zDVMENaWu+ONM92qcjWiCDUjkQWkY21
 xUnSqmRj0ceUItKDKQ9zRL9EejrF6dUOPREakt23GtCdyO++yesmIrFBcNo8IBJn+kkr
 +Q2c7wZMwTe1H/B8fIDvNed/kSLU3PoDgqDVt97S+F84VMnoj80MVkczNh0ES2RJbyIP
 VEFhkh7a6U0EFWOQCYTq1yIl08Eal1YjDaQzmhc5bDl+X71OsyV4WooUiIJattxIEjpO
 zlVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDknCf3XMhUhDOLSUU0SdeyKAEGsUTqc9lVkw+9gFZWOM8Y7PcyQf+y+Mr9CjVu7sffsskLWE=@lists.denx.de
X-Gm-Message-State: AOJu0YxiGqvPmr4W9/0/CM/elHg9PoL2R2WdmL+X5Lu67oAetbbTq4wf
 27H/DX+qFVfpvlyTBAyCIuBUxEpESZsB1vsBHQXzCv/TqPa+NST3uTY4BiNfGLPRdsoAFOSJmmA
 vIdB7OmEEbBPHKsKT7hRP55x5AA9CK8SzdN5qqMvS
X-Gm-Gg: ASbGncs/psuPtbzt35yAQqgxN2R7/wtRcjNibZYH24vyJt0AOW1PuSSoJ6NhSFGfrpJ
 hNKHpK2h+PcUcwRI1nI/f5QE/A2AqVqQTNTOv3CG35oucSIrkLPv3iQOIV50mpsHfzvMyycZHLd
 P33SGhcDJle5+jT+KQlgweEFvNJyrhG7e225E7be9+dYwBI651aOBCipbEH9MuQiFxe/PkIoQTZ
 QjPbJAB4LXXroX8Ujejm79AnQ6oEXBK
X-Google-Smtp-Source: AGHT+IHcDjrWezDVfMgFl/k2Qkf1Ki2gkbZjj9LhXMe4ORDt1giGMqS/ZUPevDuCQWGEPtEg/ptz8hByYIrtzf2R5y0=
X-Received: by 2002:a05:6402:1ed2:b0:639:d9de:3c59 with SMTP id
 4fb4d7f45d1cf-639d9de3ddamr9047142a12.5.1760092531735; Fri, 10 Oct 2025
 03:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20251010053056.32495-1-mibodhi@gmail.com>
In-Reply-To: <20251010053056.32495-1-mibodhi@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Oct 2025 11:35:17 +0100
X-Gm-Features: AS18NWA3jAODmEnrwvNLkkV-HCjznkcpGaKEPwHCWymgkzsZw5uhA9l8mxIr4v8
Message-ID: <CAFLszTj5OAohhe6WtANXg+1h9VKUWASj7EUDzvPLdvXDXPi=+A@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Allow PXE boot to be disabled
To: Tony Dinh <mibodhi@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, 
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>, 
 Peter Robinson <pbrobinson@gmail.com>
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

Hi Tony,

On Fri, 10 Oct 2025 at 06:31, Tony Dinh <mibodhi@gmail.com> wrote:
>
> Make it possible to disable CMD_PXE.
> Remove unnecessary PXE_UTILS selection in BOOTMETH_EXTLINUX config.
> In extlinux_boot(), invoke pxe utils only when
> CONFIG_BOOTMETH_EXTLINUX_PXE is enabled.
>
> This patch results in about 9K reduction in image size when
> PXE boot is disabled.
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
>
>  boot/Kconfig             |  3 +--
>  boot/bootmeth_extlinux.c | 18 ++++++++++--------
>  2 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 2993cd7f9ba..403ce4c3d46 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -421,10 +421,10 @@ config BOOT_DEFAULTS_CMDS
>         select CMD_PART if PARTITIONS
>         select CMD_DHCP if CMD_NET
>         select CMD_PING if CMD_NET
> -       select CMD_PXE if CMD_NET
>         select CMD_BOOTI if ARM64
>         select CMD_BOOTZ if ARM && !ARM64
>         imply CMD_MII if NET
> +       imply CMD_PXE if CMD_NET
>
>  config BOOT_DEFAULTS
>         bool  # Common defaults for standard boot and distroboot
> @@ -575,7 +575,6 @@ config BOOTMETH_CROS
>
>  config BOOTMETH_EXTLINUX
>         bool "Bootdev support for extlinux boot"
> -       select PXE_UTILS
>         default y
>         help
>           Enables support for extlinux boot using bootdevs. This makes the
> diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
> index 921d721a27b..ceac41a1370 100644
> --- a/boot/bootmeth_extlinux.c
> +++ b/boot/bootmeth_extlinux.c
> @@ -188,14 +188,16 @@ static int extlinux_boot(struct udevice *dev, struct bootflow *bflow)
>
>         plat = dev_get_plat(dev);
>
> -       ret = pxe_setup_ctx(&ctx, &cmdtp, extlinux_getfile, &info, true,
> -                           bflow->fname, false, plat->use_fallback);
> -       if (ret)
> -               return log_msg_ret("ctx", -EINVAL);
> -
> -       ret = pxe_process(&ctx, addr, false);
> -       if (ret)
> -               return log_msg_ret("bread", -EINVAL);
> +       if (IS_ENABLED(CONFIG_BOOTMETH_EXTLINUX_PXE)) {
> +               ret = pxe_setup_ctx(&ctx, &cmdtp, extlinux_getfile, &info, true,
> +                                   bflow->fname, false, plat->use_fallback);
> +               if (ret)
> +                       return log_msg_ret("ctx", -EINVAL);
> +
> +               ret = pxe_process(&ctx, addr, false);
> +               if (ret)
> +                       return log_msg_ret("bread", -EINVAL);
> +       }

But if you disable that, what use is the extlinux bootmeth?

>
>         return 0;
>  }
> --
> 2.47.3
>
> base-commit: 7e1456a5f62fae19012beda3750aab1e21284fbf
> branch: master

Regards,
Simon
