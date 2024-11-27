Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552EFD6ACCA
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 13:07:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20F77897F2;
	Wed, 27 Nov 2024 14:07:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JZFP69z5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA500897E7; Wed, 27 Nov 2024 14:07:45 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE694897E0
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 14:07:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa539d2b4b2so150954066b.1
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 05:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732712863; x=1733317663; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hbT9AjFC4wL9QcWgx9914KnxWwOdumUXGPoSgz+mL6g=;
 b=JZFP69z5xu3xHcY52cAgeTU2FvnG3CHgnh9v38Q2XVQJVWIhcxKO3245cl9xC8db2c
 bRbFzPr66zEyZVlnSeRFvajHwiVdCetNFsX3JBiuPegZTw5vW+uEYjIeJFsNObjZx0Ek
 cEvbYPGJQNqFNbDCPUGcbJLB2/q+pidlQBqIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732712863; x=1733317663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hbT9AjFC4wL9QcWgx9914KnxWwOdumUXGPoSgz+mL6g=;
 b=Qd9GOl6d2tma30VCzmPGWRQclpVgXIjeUBBDPF/GkaGGaKoCoUHUCuvT3Zrao4Gc5B
 g1PZEolvQh9donNjlZDvTkTJc9/EI4ztZy94TXUvYhuQzo62/M5kn208LV7y8rAP574L
 lE+u3RZXYXsgM+dcv+q/YI1YZqbML8vNQnjiUw15O26PPMA746PhPn6fYx1zhg6LYgeQ
 BM9cliv3oEN2p0nsBlzFk/ji2aY8lNORJjEnxgwbUPLDBtmUM2/CCuGxEtuk0FLSHf/S
 xX3ea10cf1CDJwAjcn+nc3O+J3K2QcL28wQ9GWtLTuc/CLaJN88CRyx/zl3bkcn163aN
 Bdfw==
X-Gm-Message-State: AOJu0Yw3LhnmfLu5SAIogVEmF5YwyGK2jxbZ1S0G+jQrvcsgmlJ5PUKJ
 IzV8ODUUEo16GQHKfz+0f7syL0Ww6/Gpdn6RHK3hltt/SzEj3CHphRAP6aFrDeazo9+UTOwc7au
 v2BK3uFleHdmpIHwCb/40L6SPApezmnf89RFY
X-Gm-Gg: ASbGncv8IQHh68/ISfZs5WW0CbYev30ubODQ6ODQvEEUdgOBoKDcW3LjVb44+2WeC1l
 8lPMXuHBN/yoPr99EdW5GTKh1Bz2YcMk=
X-Google-Smtp-Source: AGHT+IE1u8vlQg5sg6D0tOIi4ECp/bBiTKVvzaPaKUcbxHBXWl0EFyzlq11Kh8Ctvn0Ag0Vu1D+mxU2g5ZaAd0z6tn8=
X-Received: by 2002:a17:907:7213:b0:a9e:e1a5:755f with SMTP id
 a640c23a62f3a-aa564869b53mr671861466b.1.1732712863222; Wed, 27 Nov 2024
 05:07:43 -0800 (PST)
MIME-Version: 1.0
References: <20241127102924.7652-1-pzimmermann@dh-electronics.com>
 <20241127102924.7652-2-pzimmermann@dh-electronics.com>
In-Reply-To: <20241127102924.7652-2-pzimmermann@dh-electronics.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Nov 2024 06:07:29 -0700
Message-ID: <CAFLszTiV_4T8uF_zZC7hmo6Z4ggxHPJS51+1aVHQxm9EK+Txxw@mail.gmail.com>
Subject: Re: [PATCH 1/2] config_distro_bootcmd: make possible to substitute
 'part list' in distro_bootcmd
To: Pascal Zimmermann <pzimmermann@dh-electronics.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Pascal,

On Wed, 27 Nov 2024 at 03:30, Pascal Zimmermann
<pzimmermann@dh-electronics.com> wrote:
>
> Make it possible to substitute the 'part list' command inside
> 'scan_dev_for_boot_part' with a custom board specific implementation.
>
> For this the new define 'SCAN_DEV_FOR_BOOT_PARTS' is introduced.
>
> Signed-off-by: Pascal Zimmermann <pzimmermann@dh-electronics.com>
> ---
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: u-boot@lists.denx.de
> ---
>  include/config_distro_bootcmd.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Have you looked at converting the board to standard boot?

>
> diff --git a/include/config_distro_bootcmd.h b/include/config_distro_bootcmd.h
> index 0a4e4b8ff8..df0dc8cfde 100644
> --- a/include/config_distro_bootcmd.h
> +++ b/include/config_distro_bootcmd.h
> @@ -194,6 +194,11 @@
>  #define SCAN_DEV_FOR_EFI
>  #endif
>
> +#ifndef SCAN_DEV_FOR_BOOT_PARTS
> +#define SCAN_DEV_FOR_BOOT_PARTS \
> +       "part list ${devtype} ${devnum} -bootable devplist; "
> +#endif
> +
>  #ifdef CONFIG_SATA
>  #define BOOTENV_SHARED_SATA    BOOTENV_SHARED_BLKDEV(sata)
>  #define BOOTENV_DEV_SATA       BOOTENV_DEV_BLKDEV
> @@ -538,7 +543,7 @@
>                 "\0"                                                      \
>         \
>         "scan_dev_for_boot_part="                                         \
> -               "part list ${devtype} ${devnum} -bootable devplist; "     \
> +               SCAN_DEV_FOR_BOOT_PARTS                                   \
>                 "env exists devplist || setenv devplist 1; "              \
>                 "for distro_bootpart in ${devplist}; do "                 \
>                         "if fstype ${devtype} "                           \
> --
> 2.30.2
>

Regards,
Simon
