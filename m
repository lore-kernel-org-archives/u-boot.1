Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E14C2BB3F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 17:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 572848720A;
	Wed, 15 Nov 2023 18:31:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ii0TKZNJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B126C8720A; Wed, 15 Nov 2023 18:31:22 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9822B87209
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 18:31:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-280b06206f7so1033541a91.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 09:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700069479; x=1700674279; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X0hg7pyW5k7KQZsUfpy2M1YcGfhaGwLmkcP5M/wS6fc=;
 b=Ii0TKZNJdU41RYvoqaf+2ebpJFc62OXtAAXe7EeFsM1m3/q3NwhFLZrvFY5vdXOqtc
 eRAItBuEINV3vfN+g1H9I2Y4KomrHhpS1Zmez+1+Ls0SkavDevFgdAA2nRdbRHXJ69EQ
 y/v9FTlgrXNqfWBE5hXZkPE8qfZw6KcJvKzsQgxDcSGMWVrVusInEROVUcCr7FPTb4iS
 adUupjJN0oyzB60e5uDfECyOZlcE5754BSR1lsoh6AaOUqXLUO6eUDu42o3+SYAlpqD1
 +lPexsv5Efwqkjm+CnOKoSP/BeQXbzP7NzlP+Hz+3TJrEzaNrmKvl1RWvCgoJh78RSN9
 gpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700069479; x=1700674279;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X0hg7pyW5k7KQZsUfpy2M1YcGfhaGwLmkcP5M/wS6fc=;
 b=a5gYTcQyU+pCB9RTFsBOaTVqQnmGrDBf77jvreaZaDSAwWq+p5SF1vutZhhEwFpdXW
 8yAO/M9yQvpzzQH9YXv2UTaDf3DFWMUh+hcfhaR5KngMDXa/zYIWerSl6rIy8xShFsT4
 ZwB9DRIjSSPrV6qserVKQg92MNJKh9v+ArkL0wva1Yn9zVTubGrmHfXQMuP23Nn+9Ayu
 dwIsBJJXhXVzP++IBvHpGBlK/ErtPUASuEwkgjBr0tMRkhyzOY7uMOSK107cSsqKg2xH
 Qz/63/XyFfcryXuV5GF3DxrBsOG9WffQCROb1/KnDMPvnUurHui8A+GEU1k/1csRu1xC
 IewQ==
X-Gm-Message-State: AOJu0YxBEVSrLBFDURsICGnDrqfe+P9Bl4Wbkp8LeUn6b7TpdMLf1HH0
 lrU3hH7V4Y9NqIkAzDs4yxo5m3jIUnJ0HfjTR7E=
X-Google-Smtp-Source: AGHT+IFTXo4/2Sqtxl7AhZ5rnQyvu4O1YJVWRzUG6HZ8NS2hbLmS9qs7/2aQbaHW0i5CAhTCM7zPV0GrKVKHM7cPCQk=
X-Received: by 2002:a17:90b:8d6:b0:283:5405:9e90 with SMTP id
 ds22-20020a17090b08d600b0028354059e90mr5853962pjb.3.1700069478786; Wed, 15
 Nov 2023 09:31:18 -0800 (PST)
MIME-Version: 1.0
References: <20231107221617.470-1-egyszeregy@freemail.hu>
In-Reply-To: <20231107221617.470-1-egyszeregy@freemail.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 15 Nov 2023 14:31:05 -0300
Message-ID: <CAOMZO5CkU7onGbWrMxHZGG66pqrnH+VZC1qJofm_kvJkkVHaeA@mail.gmail.com>
Subject: Re: [PATCH 1/1] pico-imx7d: add baseboard SD card boot detect
To: egyszeregy@freemail.hu
Cc: u-boot@lists.denx.de, otavio@ossystems.com.br, sbabic@denx.de
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

Hi Benjamin,

You should have indicated that this is v7.

The subject should be:

[PATCH v7] pico-imx7d: add baseboard SD card boot detect

No need for adding 1/1 for a single patch.

On Tue, Nov 7, 2023 at 7:16=E2=80=AFPM <egyszeregy@freemail.hu> wrote:
>
> From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>
> Technexion PICO-IMX7 SoM is supporting USDHC3 (eMMC or micro SD on SoM)
> and USDHC1 (SD on carrier board) to use on any carrier board like
> PICO-NYMPH. Based on the U-Boot version from Technexion it adds
> baseboard SD card boot detect to able to boot from selected USDHC1
> or USDHC3 boot devices.
>
>     - Add baseboard SD card boot detect from Technexion's U-Boot.
>     - Implement board_mmc_get_env_dev() for pico-imx7d SoM.
>     - Implement mmc_map_to_kernel_blk() for pico-imx7d SoM.
>     - Add board_late_mmc_env_init() to use from common freescale
>       functions to able to provide "mmcdev" and "mmcroot" variables
>       in environment of U-boot.
>     - Add "mmc1" alias to use for usdhc1 in imx7d-pico-pi-u-boot.dtsi.
>     - In default environment set "mmcautodetect=3Dyes" to use boot detect=
ion.

These comments above should be placed below the --- line.

> Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
> ---

Here you should place the changelog:

Changes since v6:
- bla bla bla

> +#if CONFIG_IS_ENABLED(FSL_ESDHC_IMX)
> +#if CONFIG_IS_ENABLED(ENV_IS_IN_MMC) || CONFIG_IS_ENABLED(ENV_IS_NOWHERE=
)
> +int board_mmc_get_env_dev(int devno)
> +{
> +       int dev_env =3D 0;
> +       (void)(devno);

Why? Just drop this ' (void)(devno);' line.

I tested it successfully, so:

Tested-by: Fabio Estevam <festevam@gmail.com>
