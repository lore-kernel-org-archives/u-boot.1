Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37D6CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 12:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D21AB801A9;
	Fri, 19 Jun 2026 14:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jwDT6+vp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 646CC849D1; Fri, 19 Jun 2026 14:46:18 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54B948005D
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 14:46:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-696bf0e7c9cso2129144a12.1
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 05:46:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781873176; cv=none;
 d=google.com; s=arc-20240605;
 b=l0Srb2V1qTZ9y9hn0AcXLtrF8iX0Qt/s2dEeKU/3+4B6v3f9yjE76B87ALWMADfaR8
 SG7yyN1tnUbTvGUDdXWjjDpoHglRBLqNkdGprkgy2JWwmd6sPE6flwrteJVpNeBvlTbr
 L5s7IUdcEwJToQfWKQuoElj8tTuToQnEoMsF014Alu125fYIkDIYGiGlsJ0SN2N57QSN
 IVCYLTi04NM8+JjqR9N31e6e7bVgT83YV9ihLhmSS7KhAd8lve3Q/S28gQm6kDOBB2+C
 KNpxcQbg7M7reBLYuK3Wes5443y9VjIWvBjJJkvz1qH7n+rNE48oOyx7RLnN/HtpjipW
 zgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hLu+AOaJvU+QZaMAAa96CfbOkJOt6sSkN9q3+qP8N68=;
 fh=RfFqkv5HraktqGzXnud/hDh3OBnLEMp0b4peWnkt0DQ=;
 b=dzyQRo/d3Ab5YyboEGH7X7txXg7lQ/i0SDfkG1MgBPbkak8i3KDvP6Rd3sip8rAltq
 81s4nFWqXZXczdflF8iGOwApfbWKHyQVvCMQpTzaNdedfMf2uvO7hbyq6ESUWJxx8kCc
 hedRMnzi7n4BlJSNenaOECGrytPKqCh0z1eCwpZfQC7KsJj7P2k4NWC/l03BxGp1yFj9
 yS89bEMKcUocqlU645z0Et0yjgWPuAwObbj/9FVEnRiNqCfjHaRiI8sK/2E5nlQfYOww
 xqJO85Rv512ZDHQ4/tI3RsgYf1m8QTnGdYOGLY1koEOQTEbwPLYkHXXgRNHzV5xXtesx
 Ozdw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781873176; x=1782477976; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hLu+AOaJvU+QZaMAAa96CfbOkJOt6sSkN9q3+qP8N68=;
 b=jwDT6+vpS9iZrLb9cCK0Zc2fE/a1u3vOM5JeA81DFlM0VE/wZvALFQugTRrUk091Bf
 axR6+Rq1EwHvtMtv2BYRkAtKg2TMbFjevt47tZC/EPvwVlVDjGdHiK764Li4hW6z8T4G
 z3fRvNSgF7RMwlHPCh/arwDLxDUcwbl/4FUnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781873176; x=1782477976;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hLu+AOaJvU+QZaMAAa96CfbOkJOt6sSkN9q3+qP8N68=;
 b=TLogaLItBidetamU9BYNmkk51YRj59L6UcxFdacwpi+7LR3ASbxp8I2yEh776IUg6T
 GgnNeWDwZvD3iq6zsSVAbz4Vpr2LYG6Ltjn99HISD9WNMAAEVuJFTii6MS4GbhJ7aRDw
 NL7MYuppbUKB81yLxMjHzegjajl6E9e77F7VSEUUrz35EzkymHBW2zFwrque62Uyd2Qc
 DTZBhtC9qGXokyIrHKTal9Fyn5BbMPYZM9wEeOvmJ/NVSPsyAzeyNGFjdfbFm2HBEcKm
 Gy4yd93kfJBrZzbWpm2ce/wzyX1aMXIE/dGnSJg5chMsZBUVZnfFhZp8Pzz2LfFm7CdZ
 r8dg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8z1JnxZxvu/AK9ppWE9lb8K/LVMzhKZjpF15V0ViBpYXW2tVV7Bfd1B7C11vuprGjAM+itMHM=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4qC6qnirhWy7Eq6socZoIr8CYTJWshD7XAbh1r6hrrmMaze5G
 Db34n9NA8beyp7iqUvwIVbtd+LVG6ustAeqBn91IpAW0b6w45aybWSn0EG5jFWxRJbDNUzrdwXY
 L3mturdYtiRAwTu5gTYkp3YDMvH/VuLVMmiWEEOTu
X-Gm-Gg: AfdE7cnjBVv5CMOHfV49wdxadD0OOtAiEgrtqfg1VyUyWrBWS8ovoB64aaAe3St3r8P
 lTm7hW7j0NI0K3roZU6EjMLf3imXTIao24DTFdwN6QSqds6KiBoTnMfQlIoYXNkBGLhazJr/l7P
 YNbWQH+SOVV426DFUwmzmPcIGP1wPOPc9fLzLdu2WueJKLB3iUSae50kAYVtoWPC6nxNE1PgnrL
 d/kJiFkX+qp9T0e5MfYPgqFuoIRjePAx0zNNCbTCJVPAyM7F6hzDGILtyW2GvTk1smzkUo1yQ==
X-Received: by 2002:aa7:c541:0:b0:68f:9fd9:435a with SMTP id
 4fb4d7f45d1cf-6973bca5918mr1083026a12.17.1781873175733; Fri, 19 Jun 2026
 05:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260616191845.6182-1-ansuelsmth@gmail.com>
 <20260616191845.6182-3-ansuelsmth@gmail.com>
In-Reply-To: <20260616191845.6182-3-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 19 Jun 2026 13:46:02 +0100
X-Gm-Features: AVVi8CfGtWRJXlk4A_Qz-HZrRMRzQzNbruQ7ElwN0kC1O0a0q4r8B6iIZjqcpBE
Message-ID: <CAFLszTgNhwG_tx0x9HNCCftiUif2JN3U0iE4nQCvNnP1k-00uA@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] misc: fs_loader: reorganize and split to FS loader
 and FW UCLASS
To: ansuelsmth@gmail.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Martin Schwan <m.schwan@phytec.de>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Weijie Gao <weijie.gao@mediatek.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 Randolph Sapp <rs@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
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

Hi Christian,

On 2026-06-16T19:18:35, Christian Marangi <ansuelsmth@gmail.com> wrote:
> misc: fs_loader: reorganize and split to FS loader and FW UCLASS
>
> In preparation to the introduction of variant of the FS loader,
> reorganize and split the driver to generic fw_loader UCLASS and
> specific fs_loader function. Create a dedicated directory for the loader
> and move the internal structs and functions to a dedicated header file.
> While at it also drop some redundant check and rename some variables as we
> are updating the code for the UCLASS rework.
>
> This will permit to reuse all the property and logic of FS loader
> with container that are not exactly a readable filesystem.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>
> drivers/misc/Kconfig                      |   5 +
>  drivers/misc/Makefile                     |   2 +-
>  drivers/misc/fs_loader.c                  | 328 ------------------------------
>  drivers/misc/fw_loader/Makefile           |   4 +
>  drivers/misc/fw_loader/fs_loader.c        | 186 +++++++++++++++++
>  drivers/misc/fw_loader/fw_loader-uclass.c | 159 +++++++++++++++
>  drivers/misc/fw_loader/internal.h         |  73 +++++++
>  include/dm/uclass-id.h                    |   2 +-
>  include/fs_loader.h                       |  47 +----
>  include/fw_loader.h                       |  19 ++
>  10 files changed, 450 insertions(+), 375 deletions(-)

> diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
> @@ -69,7 +69,7 @@ enum uclass_id {
> -     UCLASS_FS_FIRMWARE_LOADER,              /* Generic loader */
> +     UCLASS_FIRMWARE_LOADER, /* Firmware loader */

This rename leaves doc/develop/driver-model/fs_firmware_loader.rst
stale - it still has two references to UCLASS_FS_FIRMWARE_LOADER
(around lines 90 and 148). Please update the rst file (or rename it)
in this patch.

> diff --git a/drivers/misc/fw_loader/fw_loader-uclass.c b/drivers/misc/fw_loader/fw_loader-uclass.c
> @@ -0,0 +1,159 @@
> +static int fw_loader_pre_probe(struct udevice *dev)
> +{
> +#if CONFIG_IS_ENABLED(DM)
> +     struct device_plat *plat = dev_get_uclass_plat(dev);
> +     ofnode fw_loader_node;
> +
> +     if (!IS_ENABLED(CONFIG_DM))
> +             return 0;

The outer #if CONFIG_IS_ENABLED(DM) already gates this body, so the
runtime if (!IS_ENABLED(CONFIG_DM)) is dead code - and it confuses the
meaning, since CONFIG_IS_ENABLED() is phase-aware while
IS_ENABLED(CONFIG_DM) is not. Please drop the inner check.

> diff --git a/drivers/misc/fw_loader/fw_loader-uclass.c b/drivers/misc/fw_loader/fw_loader-uclass.c
> @@ -0,0 +1,159 @@
> +#else
> +static int fw_loader_get_blk_dev_from_node(ofnode node)
> +{
> +     debug("fw_loader: No block device support\n");
> +     return -EINVAL;
> +}
> +#endif

This changes behaviour from the original driver. Previously the entire
phandlepart block was wrapped in #if CONFIG_IS_ENABLED(DM) &&
CONFIG_IS_ENABLED(BLK), so a board with BLK disabled would probe with
the phandle silently ignored. With this patch, the stub returns
-EINVAL and pre_probe propagates it, so probe fails. If intentional,
please call it out in the commit message; otherwise the stub should
return 0.

> diff --git a/drivers/misc/fw_loader/internal.h b/drivers/misc/fw_loader/internal.h
> @@ -0,0 +1,73 @@
> +struct device_plat {
> +     struct phandle_part phandlepart;
> +     char *mtdpart;
> +     char *ubivol;
> +};

Please rename struct device_plat to something like struct
fw_loader_plat - device_plat reads as a generic DM type and is
misleading even when internal to the uclass.

> diff --git a/drivers/misc/fw_loader/internal.h b/drivers/misc/fw_loader/internal.h
> @@ -0,0 +1,73 @@
> +#define fw_loader_get_ops(dev)       ((struct fw_loader_ops *)(dev)->driver->ops)

The fs_loader_ops table is static const, so this macro silently casts
the const away. Please return const struct fw_loader_ops * - the
callers in request_firmware_into_buf() only need read access.

> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> @@ -36,7 +36,7 @@ obj-$(CONFIG_FSL_DEVICE_DISABLE) += fsl_devdis.o
> -obj-$(CONFIG_$(PHASE_)FS_LOADER) += fs_loader.o
> +obj-$(CONFIG_FW_LOADER_UCLASS) += fw_loader/

FW_LOADER_UCLASS is not phase-aware, so once any phase selects
FS_LOADER the uclass object is linked into every phase that descends
here. Worth making FW_LOADER_UCLASS phase-scoped (SPL_/TPL_/VPL_) and
gating both the subdir and fw_loader-uclass.o on
CONFIG_$(PHASE_)FW_LOADER_UCLASS.

Regards,
Simon
