Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E58C4829B
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 16:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF2F187C6D;
	Sun, 11 Feb 2024 17:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="US3S/onP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8053987C75; Sun, 11 Feb 2024 17:11:38 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A037987C4D
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 17:11:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55f279dca99so3514908a12.3
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 08:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707667896; x=1708272696; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4On5UnkPtGk2u3Fmff7Mo8S6nUyUMj4Fp62StXaipf4=;
 b=US3S/onPCHqhTx0Q19VASrGM5dD4nre/0zhjUZmxfpLAvtF6R+Q1L5FElneT8XWyxt
 M1ft9yAAocgQUW4tCrpalFD+an+8Efz8EvjsQXKQvIWbXJPgawLURj4MQmqZzZ0qdq9S
 3pWW8T951twji0Tk9py5dUSlqdMe+qFJAf3iGrYPU6yMxDkhYA/dQ72+DNj+gjJHySYG
 z8LPAvHpD+gjUulf/tL4dPU6JldflSD10A/aqGUtwpsLXKEdaLDmMRR0EdKomGmHfiib
 Zp9lYOZf7kTwCnCYWRiSZVafU/JJCpVo4COawKRXWx12sg6Moneg/Yu2FVvE6//anP1+
 uv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707667896; x=1708272696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4On5UnkPtGk2u3Fmff7Mo8S6nUyUMj4Fp62StXaipf4=;
 b=dNKaSX7Izoi0VCLgsB4dQo8bK8HvvljPS5isLdH2wAUNOOdwKqN9MVp7wRisILJBnL
 JkHLuZjhURL2P4F9wrpwxtNDBS/o+J83fclKpD3tPGaNg+dmAIs//BZDyIhqssvDnLzC
 iHPqa4Hh6PieOl46AG3GJa7YNypzkVqD5egJRNP1z0JHTr8Zo4S3uNrqFQHqCxSqatH0
 Oof8s4+HQRLM+U8NtqlwdfSfbVxTe4AYr8xRJp75ZOnTs9MvEbEljykdtTpDH0IfCMOm
 U8+e8cWXg632p3O9kWWvgoN/els7HPlXcBaBCR4XBZCTW+iEDdn93V4Yfe2MEjI6ezCh
 aVpg==
X-Gm-Message-State: AOJu0YwtRtsDN64d9PwBwG18H6duEz/AOiI+xRkchzaK7Gmbgxuqf8H4
 VO9fYq69iNUVY/vSi6HjUZjLwd/enACEYoKbAI6t6cpb/Zchy/oYZlxoTGmDcAOVnErq94ehAST
 tTlWaTg/e7RTNy2+QaUY68PbUyO4=
X-Google-Smtp-Source: AGHT+IEfE0Xue+PdBAADoouk8TS52JL8zZ1EH4zVykspoMho3jgrZBonXFqDjEGv6VwgXFln3i9qQnK9X3NYycFAjqc=
X-Received: by 2002:aa7:d90f:0:b0:561:aed9:37e8 with SMTP id
 a15-20020aa7d90f000000b00561aed937e8mr327856edr.3.1707667895777; Sun, 11 Feb
 2024 08:11:35 -0800 (PST)
MIME-Version: 1.0
References: <20240211154514.925977-1-andrej.skvortzov@gmail.com>
In-Reply-To: <20240211154514.925977-1-andrej.skvortzov@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 11 Feb 2024 16:11:24 +0000
Message-ID: <CALeDE9NxT2f_Y=v12EaHraDOHNVMhjPNLJpbLPVLgeZmsxiBMg@mail.gmail.com>
Subject: Re: [PATCH] sunxi: defconfig: Add pstore support for pinephone
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Samuel Dionne-Riel <samuel@dionne-riel.com>, 
 Andre Przywara <andre.przywara@arm.com>
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

On Sun, 11 Feb 2024 at 16:02, Andrey Skvortsov
<andrej.skvortzov@gmail.com> wrote:
>
> In general any DRAM address, that isn't overwritten during a boot is
> suitable for pstore.

What's this functionality providing? The details below give the
technical reasons for the memory address but I'm not sure what
enabling pstore provides to PinePhone users.

> Range from 0x40000000 - 0x50000000 is heavily used by u-boot for
> internal use and to load kernel, fdt, fdto, scripts, pxefile and ramdisk
> later in the boot process. Ramdisk start address is 0x4FF00000,
> initramfs for kernel with some hacking features and debug info enabled
> can take more than 100Mb and final address will be around 0x58000000.
> Address 0x61000000 will most likely not overlap with that.
>
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> ---
>  configs/pinephone_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
> index 9d39204a43..7b80cc3131 100644
> --- a/configs/pinephone_defconfig
> +++ b/configs/pinephone_defconfig
> @@ -10,6 +10,8 @@ CONFIG_DRAM_ZQ=3881949
>  CONFIG_MMC_SUNXI_SLOT_EXTRA=2
>  CONFIG_PINEPHONE_DT_SELECTION=y
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_CMD_PSTORE=y
> +CONFIG_CMD_PSTORE_MEM_ADDR=0x61000000
>  CONFIG_OF_LIST="sun50i-a64-pinephone-1.1 sun50i-a64-pinephone-1.2"
>  CONFIG_LED_STATUS=y
>  CONFIG_LED_STATUS_GPIO=y
> --
> 2.43.0
>
