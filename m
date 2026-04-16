Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A42F8D775
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 19:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BE2E83EEF;
	Thu, 16 Apr 2026 21:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ArtuQ7XJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 186548421D; Thu, 16 Apr 2026 21:37:40 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 241D480086
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 21:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b9d6c8871c7so1296059666b.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 12:37:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776368257; cv=none;
 d=google.com; s=arc-20240605;
 b=Y7YFqL0cwFsYSsRAPSBSgFJ0e2l/4m2vTDHSQWhamAEh83Y0plchouNEq/ayMchTII
 K6Z0uZ876dNU9xqCCoOM/0N5OsBYvnrvi5EJKQPCWtIJSj5jZMJNO5LcRWwDv4rOvHdW
 iFd+7a26l/7wsamkNTxiiHP5IztNSmll7fVyB2RH+UaPJC66PnSNcJ16QcOE3eZauwyd
 puWb4flSW0FHmL5TcBfPXx5gOvXWOHXonQmXy/F2VBV2QRzwVPiX7D5vNMxnrKW3LM0k
 Cc1vTCmNXjxkF71F64J+JSz0iT9gNyVVXCLQcw94a1ZQEq/rGZnusNhJm1Ba7p/eFeGR
 UbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yfSEIeddzgSE0XQ2JozNGBZ9XPOSjVZ+tP7fRnAXNFo=;
 fh=fczxKqGjClYp6kaJlQAeWDTDwoxxX+FUSGPSbQ5yvh8=;
 b=HPGHybUtjl+31ChZCQ4T8gz7DlMi76Ny1JLoxrV2XLFL4ZNE8xnsmuBI+l1nt7EkB/
 KXKfL2fPobK0Ap5WxstkgDlakTqb/97wcg8P2gtSUFQOSYuUu9D6KHPAyfiUu41KtxA8
 aylA+FxJQVHhfJRAjaHDEhh9LJ9+CvM5D2t4BFMimt9mVtCN3sWrCYXhqoiCknjx/SUD
 43mISMZIgB7yS8hFsyvj33HHBUFlBwxDArIPCRKNpDdgqObKdsaQv3pOCS+00ynXaHPN
 ke0niagZ0C0Mf6rGyp3+dYTeZYIkq7OU6GNuI3KBJhdx3eYeJQweAHc70tJEAlN5Tlio
 5bOQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776368257; x=1776973057; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yfSEIeddzgSE0XQ2JozNGBZ9XPOSjVZ+tP7fRnAXNFo=;
 b=ArtuQ7XJRff68ODN14xMN/K7KDp33SIdZvk7RttQgG5I5zHxCt9Rf8mPrM1AtwyZF3
 wCUcD7ihIlfllLTpTc89sp686QOxHQiJSyaJ+3Ed85oEvEurG4cvxJOH4CwVtrtqPPuX
 BRM8tHc4nGHIsLPwEDiGJCE785mjhBsXB5Ud0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776368257; x=1776973057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yfSEIeddzgSE0XQ2JozNGBZ9XPOSjVZ+tP7fRnAXNFo=;
 b=PF8uSktNHvx5i/vINZc5B0O2n3Z48pPhjPCLFuV1NaIz9YzHWpIhwteE1P6TXRVLCT
 RysBs9CmdCLywYQfhueQ/UuHGy1BKbrSaOufg8q8AKZALFob8aOHCPFUznJz3TizwDVq
 S+3TCjDjHmH654UWakSiXjQvm5Y+54jd+lyH6f1lcsW1Es0s6jALseeiO3Q6nrMlMs8t
 uQuUrQDppRh1Oq7sawBpk5x1WC8AEOKudBMEAjQTUujlJXwUXq6KZ/41tKnGykQq+3k+
 FYh6Rk+00LcZu4pyKIg93zQCtQTT10J1Jwkz4dUaU48OBpbODJ5M7QjPCpKIvTfUDEsE
 G3aw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qOStRza45xV7+BaiVHXu5nMIXvaaFrm23fKc8WxGcmvmgU0nQKQjE1Tcl9Lp/29z+GbYR5Z0=@lists.denx.de
X-Gm-Message-State: AOJu0YzxqG/nuYC0sNvLh1/Uo9yIpLYu8jlAduv9IMmKIffT3XTDw65y
 hDCUIYOcZFMrLn0MnJQm/IZrcs0Qn18kyYPpLS1xSXuhxgmHWb5R2RSPwjpOynZgcayy9+lo6XC
 sao7FDagXy69Gqu8/NJMM8BliC3RphEgIpXjHDz4Z
X-Gm-Gg: AeBDieuD5nXjG9lyJWhdSGH/4H4NwS9MEU/oRoTVQH+rWB95dTvDorzO8bX2CYbclJx
 DeRR5U6Krj+2i+0wHoapgTE3Q2ZsSUiqHh4ZBQvNDaI1QUocT48buACeYcSQv/f7gpqdou8mCu2
 NujEtrSjGhehev4NxXVPw55EcJ0zl9jV7iZs0kn9K2QT9hkQfLrNXwJRrfx0u1aATSBjHkE72RM
 CV/keB9i+T97IVDCvOqeR9keu+f/l312asqz25Qp1+g4vOgyJg8Eq3APvuH33ruTAh9O85qaQsK
 XXque65+PPgdPxRBfEz0
X-Received: by 2002:a17:906:b3a5:b0:b9d:8697:73b8 with SMTP id
 a640c23a62f3a-ba3db09213bmr34064666b.22.1776368257530; Thu, 16 Apr 2026
 12:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776302805.git.daniel@makrotopia.org>
 <5330ee823542d589e83cf7d2d21ee60ea51d6730.1776302806.git.daniel@makrotopia.org>
In-Reply-To: <5330ee823542d589e83cf7d2d21ee60ea51d6730.1776302806.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 07:37:24 +1200
X-Gm-Features: AQROBzCaWOk5CoZwva5Yy-TbuM878-UycYwwu_EdD6DcqXLZ8BMZWCzADgptc-s
Message-ID: <CAFLszTgfT=4TLAt4qH42=THs59SzbHfAn5EmZbXaQThkXj4HQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] boot: fit: support generating DM verity cmdline
 parameters
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin Schwan <m.schwan@phytec.de>,
 Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>, 
 Benjamin ROBIN <dev@benjarobin.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 David Lechner <dlechner@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Shiji Yang <yangshiji66@outlook.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Francois Berder <fberder@outlook.fr>,
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

Hi Daniel,

On 2026-04-16T01:46:15, Daniel Golle <daniel@makrotopia.org> wrote:
> boot: fit: support generating DM verity cmdline parameters
>
> Add fit_verity_build_cmdline(): when a FILESYSTEM loadable carries a
> dm-verity subnode, construct the dm-mod.create= kernel cmdline parameter
> from the verity metadata (block-size, data-blocks, algo, root-hash,
> salt) and append it to bootargs.
>
> Also add dm-mod.waitfor=/dev/fit0[,/dev/fitN] for each dm-verity device
> so the kernel waits for the underlying FIT block device to appear before
> setting up device-mapper targets. This is needed when the block driver
> probes late, e.g. because it depends on NVMEM calibration data.
>
> The dm-verity target references /dev/fitN where N is the loadable's
> index in the configuration -- matching the order Linux's FIT block
> driver assigns block devices.  hash-start-block is read directly from
> the FIT dm-verity node; mkimage ensures its value equals num-data-blocks
> by invoking veritysetup with --no-superblock.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> boot/Kconfig       |  20 ++++
>  boot/bootm.c       |  13 +++
>  boot/image-board.c |   5 +
>  boot/image-fit.c   | 337 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/image.h    |  80 ++++++++++++-
>  5 files changed, 454 insertions(+), 1 deletion(-)

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -2642,3 +2683,299 @@ out:
> +     /* Mandatory u32 properties */
> +     val = fdt_getprop(fit, verity_node, FIT_VERITY_DBS_PROP, NULL);
> +     if (!val)
> +             return -EINVAL;
> +     data_block_size = fdt32_to_cpu(*val);

This reads an fdt32_t into a signed int

data_block_size and hash_block_size are never negative, so could you
use uint instead?

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -2642,3 +2683,299 @@ out:
> +             printf("FIT: broken dm-verity metadata in '%s'\n",
> +                    uname);

This file defines LOG_CATEGORY as LOGC_BOOT and includes log.h - how
about log_err() instead of printf() ?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
