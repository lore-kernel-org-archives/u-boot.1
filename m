Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E432BC83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 15:34:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62A6F846B8;
	Mon, 28 Aug 2023 17:34:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="AHwfHFmk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 102A886452; Mon, 28 Aug 2023 17:34:33 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DA7C80283
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 17:34:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31c93d2a24fso1299064f8f.2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 08:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1693236869; x=1693841669; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qByl5mDsQap2nwsUrUdfpkjJIOioq+4HKfjg9jjc7Y0=;
 b=AHwfHFmkqJ6niOug76w2zcCaDx+6Htr1/kdzHM2PyY9/KVaaKJZEyVSKrVK6ZsAVgC
 NRuMv/2LeJi3qJmhPlE0bL8QckObEfIKFLe5B1XMeEbb3MWajFxbesZ+JTIE3CGm7F9/
 T0L3dSBfr+reWYBvHymTV7ni8K93zmkq4B7B+kDG1sEeZQIBO9IW6W7+E9Fpx0OjTmA7
 pB/7ya5kKZUfdm/hpj7CA1sMYxkZptmYDNY+zetbKGCJYd9xK1wN7uhzblgaUm5b1pLR
 W2fCeTRiIQTGOgszJZbyiVmlIIpMAek9xfPd/uQl/BupbhT7CyIHrAUJBCmQA3JdcNNR
 sx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693236869; x=1693841669;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qByl5mDsQap2nwsUrUdfpkjJIOioq+4HKfjg9jjc7Y0=;
 b=QBAebBES9XNARUuewgvHgquZBw/AkN/iRl93KN3iprpaQgYxgFzY5SzvuIrqDY0Jsa
 nw+a2fDVutM750yovrB4Jy1TtnYQ9QU2aco/KHcsrP5/wGa38atm/CpDO+ch3IhL33MB
 y6oYPf9pRZ4ICuZt+2RX/JF9qyUoE31F8mIbXIiCZFpicQ5nua7sxTns4jY3VwIVyNG6
 kMTy4Ao8oN3+g0UD3ARdochKEpNyO+y8UxScXgckzNtFVozvkuq4LjWMahRPoO3iU9eM
 cIs2/oCibuuVuoKm6/Yhkwlzh0Tp/xYXVN+VfXUdsVEZvgiEiK/hnT0UwVNQPCkEbE/O
 y7sQ==
X-Gm-Message-State: AOJu0YxnpIUoti31KsDSYsU0SdnK7gKq2tKrNj6gKyT/WgFDwIDgc9XY
 uKjTyO7Jv62XWgqWIOxCF1G5fA==
X-Google-Smtp-Source: AGHT+IHPyCeppbpaAT84RJaS9M/YwnijSNNKzOvlgqBKU5/tLyd+bwJ3eZxSH8Z27jkHM86cf3GItg==
X-Received: by 2002:a5d:55c3:0:b0:319:72f8:7244 with SMTP id
 i3-20020a5d55c3000000b0031972f87244mr19359699wrw.45.1693236869284; 
 Mon, 28 Aug 2023 08:34:29 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 b3-20020adfde03000000b0031accc7228asm10816846wrm.34.2023.08.28.08.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 08:34:28 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@google.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V6 16/20] configs: am62x_evm_a53_defconfig: Disable
 semi-functional PSCI reset support
In-Reply-To: <20230825180305.69515-17-nm@ti.com>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-17-nm@ti.com>
Date: Mon, 28 Aug 2023 17:34:28 +0200
Message-ID: <87v8czuqnv.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On ven., ao=C3=BBt 25, 2023 at 13:03, Nishanth Menon <nm@ti.com> wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> At this point, system shutdown is not supported by the DM firmware
> that TF-A calls. As we can't de-select only this feature[1], declare
> complete PSCI reset support as non-functional so that we don't signal
> incomplete support to the OS via EFI runtime services. This makes
> power-off under Linux work again when booting via EFI.
>
> [1] https://uefi.org/specs/UEFI/2.9_A/08_Services_Runtime_Services.html?h=
ighlight=3Defiresetshutdown#resetsystem
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> New patch picked from Jan
> https://lore.kernel.org/all/c93b19ed-43fe-44a2-9726-371fb9d2f825@web.de/
> Changes:
> - modify am62x_evm as common change.
> - slight update to $subject and commit message
>
>  configs/am62x_evm_a53_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defc=
onfig
> index 112125673699..a2729c1d0e36 100644
> --- a/configs/am62x_evm_a53_defconfig
> +++ b/configs/am62x_evm_a53_defconfig
> @@ -25,6 +25,7 @@ CONFIG_SPL_FS_FAT=3Dy
>  CONFIG_SPL_LIBDISK_SUPPORT=3Dy
>  CONFIG_SPL_SPI_FLASH_SUPPORT=3Dy
>  CONFIG_SPL_SPI=3Dy
> +# CONFIG_PSCI_RESET is not set
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_SPL_LOAD_FIT=3Dy
>  CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x81000000
> --=20
> 2.40.0
