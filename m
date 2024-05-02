Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21598C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 03:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A77288C6A;
	Thu,  2 May 2024 05:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eSjYjKIS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AC8288C10; Thu,  2 May 2024 05:32:51 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1F9A88C71
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 05:32:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5723edf0ae5so7741522a12.0
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 20:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714620767; x=1715225567; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0pL/p8kpLAW4M1MeSwS20PhbWcUneqim8aIjLtMx/Wg=;
 b=eSjYjKIScfg/eAwXHAp8NpHQQJZttWhFat5dfMjzAka4YEfUpVYcKrzOIfCzOPCoQm
 zscCzaE/O5v3W16iPjq2Bk7ye3hM/1cH+CMRFmUqXP3kQ9ERB6byUmUsLydOjIbi248m
 3D7PIPpZbpYKgiePXGw89DNcjU5c/GsZ/ftd49H99Be3zZzIwZzLuCamvv8OvrRsIyYq
 Ifs91edvvy7YL+rJJ7f/Ga1xVKK8s92N/9kA3lL5KNwSWVjMWWdbvgThf+geKDTFbQB2
 isC2kP19uu1TrsuMBUMxkarbjKD7U6xVwc1lKpCmGShquEKSJcSDaOe5NzUPYykqm6ya
 FWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714620767; x=1715225567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0pL/p8kpLAW4M1MeSwS20PhbWcUneqim8aIjLtMx/Wg=;
 b=C47Lze1z+Dn3NE4cKDKKyzXaEH7EPxYuPen1N7WfDXJsRbldTlkPVwSexMSOQYBSYJ
 FZBZMpas5BdBSum64wCdmvCxLnrdRPQufrhV8tFueyzujtNMel94av2EvwSvf7/CUY6I
 ZB6SL7MFOandTUzZSNctIWCM6o7WK9Y9Kdq32B+NlbeYYoDKko0LUFMz6XqxpJF5fhXy
 vOA4sjzwfRAKvB58PaRiZZzRIK84UTKzRYbX3XkgZLZ4mEAAM4t41/Dwo7p1/wezStL6
 cdhC4j9RDfS4oGi76uRSdJq1bJs3ciNLy9k1fq5u3lBbFmjIdQtasL7PHOVY5n3qdOce
 akEw==
X-Gm-Message-State: AOJu0Ywsq/zeQG2jv06aQTTzCx11+HDc7Hu+WNxUqku6ZLbhk7jmcbyP
 fvM1eijJCBAW1dB4vmIFjrWK6GUXLIdBwrq4U//Gzc6P37E0Zz1dD5F5AHxa3nz2DOYG8oJ2/7B
 GHHbLvGNVToBV13AjVGR2Bb+g/P0=
X-Google-Smtp-Source: AGHT+IFlFt2ueE+3pMXMUp8YBMZLM7eyKELAmDHytM0cjp9MMEssfHp9oR8FBDe7ofgByESoiVgU4DGb0kOMz8wZdjA=
X-Received: by 2002:a50:aad9:0:b0:572:a745:521e with SMTP id
 r25-20020a50aad9000000b00572a745521emr3138685edc.14.1714620766933; Wed, 01
 May 2024 20:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-11-trini@konsulko.com>
In-Reply-To: <20240502013138.2383421-11-trini@konsulko.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 1 May 2024 20:32:28 -0700
Message-ID: <CAJaLiFybpFKDSZSaW4jcN4tkaCQOxcXiN3Fw1W5Vr1+xwpikqQ@mail.gmail.com>
Subject: Re: [PATCH 11/81] ata: Remove <common.h> and add needed includes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Samuel Holland <samuel@sholland.org>, 
 Sam Edwards <CFSworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>, 
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Johan Jonker <jbx6244@gmail.com>, 
 Bin Meng <bmeng@tinylab.org>, Michal Simek <michal.simek@amd.com>
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

On Wed, May 1, 2024 at 6:31=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Sam Edwards <CFSworks@gmail.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Johan Jonker <jbx6244@gmail.com>
> Cc: Bin Meng <bmeng@tinylab.org>
> Cc: Tony Dinh <mibodhi@gmail.com>
> Cc: Michal Simek <michal.simek@amd.com>

Reviewed-by: Tony Dinh <mibodhi@gmail.com>

> ---
>  drivers/ata/ahci-pci.c     | 1 -
>  drivers/ata/ahci-uclass.c  | 1 -
>  drivers/ata/ahci.c         | 2 +-
>  drivers/ata/ahci_mvebu.c   | 1 -
>  drivers/ata/ahci_sunxi.c   | 1 -
>  drivers/ata/dwc_ahci.c     | 1 -
>  drivers/ata/dwc_ahsata.c   | 1 -
>  drivers/ata/fsl_sata.c     | 1 -
>  drivers/ata/libata.c       | 2 +-
>  drivers/ata/mtk_ahci.c     | 1 -
>  drivers/ata/sata.c         | 1 -
>  drivers/ata/sata_bootdev.c | 1 -
>  drivers/ata/sata_ceva.c    | 1 -
>  drivers/ata/sata_mv.c      | 2 +-
>  drivers/ata/sata_sil.c     | 1 -
>  15 files changed, 3 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/ata/ahci-pci.c b/drivers/ata/ahci-pci.c
> index 5356b9d83d34..f2102aaa6353 100644
> --- a/drivers/ata/ahci-pci.c
> +++ b/drivers/ata/ahci-pci.c
> @@ -3,7 +3,6 @@
>   * Copyright (C) 2017, Bin Meng <bmeng.cn@gmail.com>
>   */
>
> -#include <common.h>
>  #include <ahci.h>
>  #include <scsi.h>
>  #include <dm.h>
> diff --git a/drivers/ata/ahci-uclass.c b/drivers/ata/ahci-uclass.c
> index d398b50b9a1e..7affb3f1ec79 100644
> --- a/drivers/ata/ahci-uclass.c
> +++ b/drivers/ata/ahci-uclass.c
> @@ -6,7 +6,6 @@
>
>  #define LOG_CATEGORY UCLASS_AHCI
>
> -#include <common.h>
>  #include <ahci.h>
>  #include <dm.h>
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 04ddc3394648..ac869296d525 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -8,10 +8,10 @@
>   *
>   * This driver provides a SCSI interface to SATA.
>   */
> -#include <common.h>
>  #include <blk.h>
>  #include <cpu_func.h>
>  #include <log.h>
> +#include <time.h>
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
>
> diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
> index f05150d61ddf..f6e2d6bee45b 100644
> --- a/drivers/ata/ahci_mvebu.c
> +++ b/drivers/ata/ahci_mvebu.c
> @@ -3,7 +3,6 @@
>   * Copyright (C) 2016 Stefan Roese <sr@denx.de>
>   */
>
> -#include <common.h>
>  #include <ahci.h>
>  #include <dm.h>
>  #include <log.h>
> diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
> index 9064774e6614..6cf5cee055e7 100644
> --- a/drivers/ata/ahci_sunxi.c
> +++ b/drivers/ata/ahci_sunxi.c
> @@ -1,4 +1,3 @@
> -#include <common.h>
>  #include <ahci.h>
>  #include <dm.h>
>  #include <log.h>
> diff --git a/drivers/ata/dwc_ahci.c b/drivers/ata/dwc_ahci.c
> index 15fd3e365b2b..b480cde4465b 100644
> --- a/drivers/ata/dwc_ahci.c
> +++ b/drivers/ata/dwc_ahci.c
> @@ -8,7 +8,6 @@
>   * Author: Mugunthan V N <mugunthanvnm@ti.com>
>   */
>
> -#include <common.h>
>  #include <dm.h>
>  #include <ahci.h>
>  #include <scsi.h>
> diff --git a/drivers/ata/dwc_ahsata.c b/drivers/ata/dwc_ahsata.c
> index b4d4e39c9b3b..a29d641343ed 100644
> --- a/drivers/ata/dwc_ahsata.c
> +++ b/drivers/ata/dwc_ahsata.c
> @@ -4,7 +4,6 @@
>   * Terry Lv <r65388@freescale.com>
>   */
>
> -#include <common.h>
>  #include <ahci.h>
>  #include <blk.h>
>  #include <cpu_func.h>
> diff --git a/drivers/ata/fsl_sata.c b/drivers/ata/fsl_sata.c
> index 969bc191f8e8..4990148388b6 100644
> --- a/drivers/ata/fsl_sata.c
> +++ b/drivers/ata/fsl_sata.c
> @@ -5,7 +5,6 @@
>   * Author: Dave Liu <daveliu@freescale.com>
>   */
>
> -#include <common.h>
>  #include <ahci.h>
>  #include <blk.h>
>  #include <command.h>
> diff --git a/drivers/ata/libata.c b/drivers/ata/libata.c
> index 47e2c5c1cc40..ef659cb1728a 100644
> --- a/drivers/ata/libata.c
> +++ b/drivers/ata/libata.c
> @@ -5,9 +5,9 @@
>   *             port from the libata of linux kernel
>   */
>
> -#include <common.h>
>  #include <compiler.h>
>  #include <libata.h>
> +#include <stdio.h>
>
>  u64 ata_id_n_sectors(u16 *id)
>  {
> diff --git a/drivers/ata/mtk_ahci.c b/drivers/ata/mtk_ahci.c
> index 2c5227df306b..53aabee0a5e6 100644
> --- a/drivers/ata/mtk_ahci.c
> +++ b/drivers/ata/mtk_ahci.c
> @@ -8,7 +8,6 @@
>   * Author: Frank Wunderlich <frank-w@public-files.de>
>   */
>
> -#include <common.h>
>  #include <ahci.h>
>  #include <asm/global_data.h>
>  #include <asm/io.h>
> diff --git a/drivers/ata/sata.c b/drivers/ata/sata.c
> index 784d9bbeacb4..84437d3d346b 100644
> --- a/drivers/ata/sata.c
> +++ b/drivers/ata/sata.c
> @@ -9,7 +9,6 @@
>   *             Dave Liu <daveliu@freescale.com>
>   */
>
> -#include <common.h>
>  #include <ahci.h>
>  #include <blk.h>
>  #include <dm.h>
> diff --git a/drivers/ata/sata_bootdev.c b/drivers/ata/sata_bootdev.c
> index f638493ce04f..a5ca6f6fd5bb 100644
> --- a/drivers/ata/sata_bootdev.c
> +++ b/drivers/ata/sata_bootdev.c
> @@ -5,7 +5,6 @@
>   * Copyright 2023 Tony Dinh <mibodhi@gmail.com>
>   */
>
> -#include <common.h>
>  #include <ahci.h>
>  #include <bootdev.h>
>  #include <dm.h>
> diff --git a/drivers/ata/sata_ceva.c b/drivers/ata/sata_ceva.c
> index 7769d4f99efd..a81b3165992a 100644
> --- a/drivers/ata/sata_ceva.c
> +++ b/drivers/ata/sata_ceva.c
> @@ -3,7 +3,6 @@
>   * (C) Copyright 2015 - 2016 Xilinx, Inc.
>   * Michal Simek <michal.simek@amd.com>
>   */
> -#include <common.h>
>  #include <dm.h>
>  #include <ahci.h>
>  #include <generic-phy.h>
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 94d7369351a3..ac78760a33eb 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -31,7 +31,6 @@
>   * No port multiplier support
>   */
>
> -#include <common.h>
>  #include <ahci.h>
>  #include <blk.h>
>  #include <bootdev.h>
> @@ -46,6 +45,7 @@
>  #include <libata.h>
>  #include <malloc.h>
>  #include <sata.h>
> +#include <time.h>
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
>  #include <linux/errno.h>
> diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
> index 43a91a79120a..5b80f6249d76 100644
> --- a/drivers/ata/sata_sil.c
> +++ b/drivers/ata/sata_sil.c
> @@ -5,7 +5,6 @@
>   * Author: Tang Yuantian <b29983@freescale.com>
>   */
>
> -#include <common.h>
>  #include <blk.h>
>  #include <cpu_func.h>
>  #include <dm.h>
> --
> 2.34.1
>
