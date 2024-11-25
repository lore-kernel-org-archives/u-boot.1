Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFA9D3B7FF
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 10:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07F7189046;
	Mon, 25 Nov 2024 11:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lRtkLrua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23E6289046; Mon, 25 Nov 2024 11:40:49 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4A288929F
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 11:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2fc968b3545so44137901fa.2
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 02:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732531246; x=1733136046; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yjuQXJcer1LAwz0YaUVsmvMaMwUHOUxgglTwv0Nr0oA=;
 b=lRtkLruaTQ4wbcQeTWlow4Zg/URK7YpEWh0GkmokzOpFqS5xm8lFp2buqlU8rARowG
 X6nMCLGCc+w1cA1qzjm9zj5kSHnx75N/KBTA+iSG7PIp+jr60hXZAKdf1mbUkyR91XDH
 U4vv/BHlAeW0idR+PY81ZjvcosCQ8FD8GnMK8MWepHn8ajQU/BPD6VQ4IeQVdSR7nen3
 epV+5HXuD13abpMHCEUy8fyqGnjSg6G2P/PT6fn3Q4n6FgIXTK7aa+SQcyTUXcBqLK56
 X29lE8h/Lqb2IODfsQ2xyCFAPbMf39eWgVej5eG7kGYgMg0w7fmHXKgyJeIXyL1FrSV7
 6Emg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732531246; x=1733136046;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yjuQXJcer1LAwz0YaUVsmvMaMwUHOUxgglTwv0Nr0oA=;
 b=bjr/lkeyJE7qsvLtGmh/KJOOZtt5WUzbpnDztBdI2DuBgBaBOPbyTod6YGo3IFZtQ+
 JvdzMjx02kKWZ+7kYKlgd70oeziR1C/+GrK43uaUHmWdcCY1ztlgIQO9/RNYxuzGkKdA
 rv2BeEz4ps2qrsYe04sc12kGhfTkIhx/mMYZv0busiD+p7JcaxV8OnilnX7xyyoivwVy
 iG8ohm4OaKzNGg13Oyd5gwytQ+BQGd1OSazJwWSVJXhkMnZIyyKbFILoE09BnUxr1Y3R
 ssWXgzvlFvI56sL6J0ji7TbjrFuynPueavfcgGn+74AJAV9JgwaeKSOtWNPN9F3FMdiL
 zUyA==
X-Gm-Message-State: AOJu0Yxutan8TtRHXM+d6e9pozHC8PR5HuPzT9dTtXyLvGwcvX/zD7X6
 Lb+QzmqT8c3bs7NA7rGRfpxHMYMXEd2pl9+mcZn5QBexXJ+nVAGgWkDGym/pdPssridrUEu6PWR
 Z0VW1pWS8sRmbbS5ZWhPM1Fi6s8M=
X-Gm-Gg: ASbGncv6OMTjND92vk1det0JZl9zlziw5nTku0WLEU1cQgvC0F6jh/rl0CQvDrADTEU
 B6Piw2a4MIka+k3BnZh0PQQktrAeFtI7+E8t9dgFlhn4dFI6X04bsMN+o2ynhLqPVbw==
X-Google-Smtp-Source: AGHT+IFpjI5rihChvBsJ6Ob3+bc3jaA6e+AADl9b8limRcJoIDd+mfyH6xw3qCSABNsd/oJhwFsiZXra/CS5Szxy1EM=
X-Received: by 2002:a2e:a551:0:b0:2f6:6074:db71 with SMTP id
 38308e7fff4ca-2ffa712ce91mr57338241fa.17.1732531245722; Mon, 25 Nov 2024
 02:40:45 -0800 (PST)
MIME-Version: 1.0
References: <20241125093908.50903-1-ldevulder@suse.com>
 <20241125093908.50903-2-ldevulder@suse.com>
In-Reply-To: <20241125093908.50903-2-ldevulder@suse.com>
From: E Shattow <lucent@gmail.com>
Date: Mon, 25 Nov 2024 02:40:34 -0800
Message-ID: <CANV2PTPnutTi6nZ2Nq3UvuZbPr4pedB1vo6ZWtQj4+Cif3diYw@mail.gmail.com>
Subject: Re: [PATCH 1/1] configs: visionfive2: enable CONFIG_DISTRO_DEFAULTS
To: Loic Devulder <ldevulder@suse.com>
Cc: u-boot@lists.denx.de
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

Hi Loic,

On Mon, Nov 25, 2024 at 1:48=E2=80=AFAM Loic Devulder <ldevulder@suse.com> =
wrote:
>
> Supported boot device types are MMC, USB, SF and DHCP.
>
> Signed-off-by: Loic Devulder <ldevulder@suse.com>
> ---
>  configs/starfive_visionfive2_defconfig |  1 +
>  include/configs/starfive-visionfive2.h | 29 ++++++++++++++++++++------
>  2 files changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_vi=
sionfive2_defconfig
> index 20f89ae6796..e817e63858b 100644
> --- a/configs/starfive_visionfive2_defconfig     "
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -41,6 +41,7 @@ CONFIG_SD_BOOT=3Dy
>  CONFIG_OF_BOARD_SETUP=3Dy
>  CONFIG_USE_BOOTARGS=3Dy
>  CONFIG_BOOTARGS=3D"console=3DttyS0,115200 debug rootwait earlycon=3Dsbi"
> +CONFIG_DISTRO_DEFAULTS=3Dy
>  CONFIG_USE_PREBOOT=3Dy
>  CONFIG_PREBOOT=3D"nvme scan; usb start; setenv fdt_addr ${fdtcontroladdr=
}; fdt addr ${fdtcontroladdr};"
>  CONFIG_SYS_CBSIZE=3D256
> diff --git a/include/configs/starfive-visionfive2.h b/include/configs/sta=
rfive-visionfive2.h
> index 049b0a06301..7f187307ffe 100644
> --- a/include/configs/starfive-visionfive2.h
> +++ b/include/configs/starfive-visionfive2.h
> @@ -15,14 +15,29 @@
>
>  #define __io
>
> +#ifdef CONFIG_DISTRO_DEFAULTS
> +#define BOOT_TARGET_DEVICES(func) \
> +       func(MMC, mmc, 1) \
> +       func(MMC, mmc, 0) \
> +       func(USB, usb, 0) \
> +       func(SF, sf, 0) \
> +       func(DHCP, dhcp, na)
> +
> +#include <config_distro_bootcmd.h>
> +#include <env/distro/sf.h>
> +#else
> +#define BOOTENV
> +#define BOOTENV_SF
> +#endif
> +
>  #define TYPE_GUID_SPL          "2E54B353-1271-4842-806F-E436D6AF6985"
> -#define TYPE_GUID_UBOOT        "BC13C2FF-59E6-4262-A352-B275FD6F7172"
> +#define TYPE_GUID_UBOOT                "BC13C2FF-59E6-4262-A352-B275FD6F=
7172"
>  #define TYPE_GUID_SYSTEM       "EBD0A0A2-B9E5-4433-87C0-68B6B72699C7"
>
> -#define PARTS_DEFAULT                                                  \
> -               "name=3Dspl,start=3D2M,size=3D2M,type=3D${type_guid_gpt_l=
oader1};" \
> -               "name=3Duboot,size=3D4MB,type=3D${type_guid_gpt_loader2};=
"            \
> -               "name=3Dsystem,size=3D-,bootable,type=3D${type_guid_gpt_s=
ystem};"
> +#define PARTS_DEFAULT \
> +       "name=3Dspl,start=3D2M,size=3D2M,type=3D${type_guid_gpt_loader1};=
" \
> +       "name=3Duboot,size=3D4MB,type=3D${type_guid_gpt_loader2};" \
> +       "name=3Dsystem,size=3D-,bootable,type=3D${type_guid_gpt_system};"
>
>  #define CFG_EXTRA_ENV_SETTINGS \
>         "kernel_addr_r=3D0x40200000\0" \
> @@ -37,6 +52,8 @@
>         "type_guid_gpt_loader2=3D" TYPE_GUID_UBOOT "\0" \
>         "type_guid_gpt_system=3D" TYPE_GUID_SYSTEM "\0" \
>         "partitions=3D" PARTS_DEFAULT "\0" \
> -       "fdtfile=3D" CONFIG_DEFAULT_FDT_FILE "\0"
> +       "fdtfile=3D" CONFIG_DEFAULT_FDT_FILE "\0" \
> +       BOOTENV \
> +       BOOTENV_SF
>
>  #endif /* _STARFIVE_VISIONFIVE2_H */
> --
> 2.47.0
>

NAK.

This was removed March 2024 already. See "board: starfive vf2: switch
to standard boot and fix DTS"

https://lore.kernel.org/u-boot/20240221120014.149193-1-namcao@linutronix.de=
/

Please divert your attention to review and test Hal's patch series:
"Support OF_UPSTREAM for StarFive JH7110"

https://lore.kernel.org/u-boot/20241125003205.75327-1-hal.feng@starfivetech=
.com/

Thanks,

-E
