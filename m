Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C363FC00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 07:05:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5249687128;
	Tue, 24 Oct 2023 09:05:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Evv4i9tj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF9488711F; Tue, 24 Oct 2023 09:05:15 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A277C87120
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 09:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c5210a1515so64114151fa.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 00:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698131111; x=1698735911;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9vvERfCuXPlDXu2dUvdAlNm8Az0AGvwpFt3aWrDt2cY=;
 b=Evv4i9tjdZ5FI1V32lEBmF2GAY2E8OhnrTQgAqG+jYeabCmMNd37pso/5HTCwwsIQf
 mtP+fQak+NOM2VDa1H/3J6o/oz5gPkQ43hrjRKWAdmdjOSCCC4YJ5JibLVz4T0bH1y22
 /ObduLR5MeaLflXwR3GKYUAmNM64gulCU/xU+77bFrxHTXT0ShndeLTIzfqKQ9p7OMOF
 pObP89G/+/MgtdTFP8d83vmLnKdPdyv9ekav7niV6BDshASVvrCPj3PUCXtI76c4XPzf
 VhHfiZ/HYH5f84n0Z2BWZOe1u/fMOJB36bz4X3XeoavpA0xBS1mk3DUHmce2kGXF3vRm
 bcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698131111; x=1698735911;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9vvERfCuXPlDXu2dUvdAlNm8Az0AGvwpFt3aWrDt2cY=;
 b=jZPzuEWzswiAWa14P0cWXPz8LRT60A5oHDUsmW6LiX2ZbvtHy8MRi6AOkYVP8R9a5x
 YpiTUQofXw8kt4ByoX9vG4Vs4oSs9zWPn192wA0C/1zFDhQfZJlHUgz2DXd5QlvyCMks
 Lk7PL+s2eYZDyqgvlUI+OS306da46MA3f6FTuRDaa3prsbV3fd/Iaz3or+Vz7HUMlQqu
 RoCHyh1NMVdztz9d5UIMhVeFs6I8hxhwIYH7oLmruSRBJz3HHoNQFtjNTVHl5ec8YUsL
 +6ewJvRjfEPu3P6JwOklUhq+gn/SwpMyQZxIkneyBZoHtXBsg3Fg7OULrtSCYccSDTy3
 w3bw==
X-Gm-Message-State: AOJu0YwCsCEw7txHhzLm4HSEgGlCG//8gXV1DQJqxyEXktmmT51ID4ae
 i75i1700UOJpPt2r9+Vi/czGhg==
X-Google-Smtp-Source: AGHT+IEc5B6S+JSHIQnZeesEGsLvoVMYAhizlCIaQjC1TkcHNwKctui0SH8Lk5hN5JjaVY7gjyGCNQ==
X-Received: by 2002:ac2:4c16:0:b0:507:cb61:2054 with SMTP id
 t22-20020ac24c16000000b00507cb612054mr8291613lfq.49.1698131110691; 
 Tue, 24 Oct 2023 00:05:10 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e2:8300:dbea:ecb8:b89e:dd0f])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a05600c210100b004068de50c64sm11025728wml.46.2023.10.24.00.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 00:05:10 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot-amlogic@groups.io, neil.armstrong@linaro.org, Christian Hewitt
 <christianshewitt@gmail.com>, Vyacheslav Bocharov <adeep@lexina.in>,
 Beniamino Galvani <b.galvani@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, Neil Armstrong
 <neil.armstrong@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/4] ARM: meson: Add boot over DFU RAM as an USB boot step
In-Reply-To: <20231023-usb-dfu-boot-v1-0-df9d121c67c1@linaro.org>
References: <20231023-usb-dfu-boot-v1-0-df9d121c67c1@linaro.org>
Date: Tue, 24 Oct 2023 09:05:05 +0200
Message-ID: <874jigsdpa.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Neil,

Thank you for the series.

On lun., oct. 23, 2023 at 14:41, "Neil Armstrong" <neil.armstrong@linaro.org> wrote:

> Add boot over DFU RAM as an alternate to running script at
> a fixed address like done today.
>
> The main culprit is that it's not possible to do that
> on G12A/SM1 platforms due to changes in the USB boot protocol.
>
> With this, U-Boot will present a DFU device with a ram slot where
> the Host could write a fitImage or legacy U-Boot image, then with the
> detach command boot will continue trying to boot the uploaded image.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

I did a simple boot to aosp/main test on vim3 and also used fastboot to
flash the bootloader.

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on vim3

> ---
> Neil Armstrong (4):
>       ARM: meson: enable FIT with LEGACY_IMAGE_FORMAT on all configs
>       configs: meson64: declare addr out of EXTRA_ENV_SETTINGS
>       configs: meson64: add alternate USB DFU boot target
>       ARM: meson: enable USB DFU + RAM on Amlogic boards with USB Gadget
>
>  configs/ad401_defconfig                   |  2 ++
>  configs/bananapi-cm4-cm4io_defconfig      |  6 ++++
>  configs/bananapi-m2-pro_defconfig         |  6 ++++
>  configs/bananapi-m2s_defconfig            |  6 ++++
>  configs/bananapi-m5_defconfig             |  6 ++++
>  configs/beelink-gsking-x_defconfig        |  6 ++++
>  configs/beelink-gt1-ultimate_defconfig    |  6 ++++
>  configs/beelink-gtking_defconfig          |  6 ++++
>  configs/beelink-gtkingpro_defconfig       |  6 ++++
>  configs/jethub_j100_defconfig             |  6 ++++
>  configs/jethub_j80_defconfig              |  6 ++++
>  configs/khadas-vim2_defconfig             |  6 ++++
>  configs/khadas-vim3_android_ab_defconfig  |  4 +++
>  configs/khadas-vim3_android_defconfig     |  4 +++
>  configs/khadas-vim3_defconfig             |  6 ++++
>  configs/khadas-vim3l_android_ab_defconfig |  4 +++
>  configs/khadas-vim3l_android_defconfig    |  4 +++
>  configs/khadas-vim3l_defconfig            |  6 ++++
>  configs/khadas-vim_defconfig              |  6 ++++
>  configs/libretech-ac_defconfig            |  6 ++++
>  configs/libretech-cc_defconfig            |  6 ++++
>  configs/libretech-cc_v2_defconfig         |  6 ++++
>  configs/libretech-s905d-pc_defconfig      |  6 ++++
>  configs/libretech-s912-pc_defconfig       |  6 ++++
>  configs/nanopi-k2_defconfig               |  4 +++
>  configs/odroid-c2_defconfig               |  4 +++
>  configs/odroid-c4_defconfig               |  6 ++++
>  configs/odroid-go-ultra_defconfig         |  6 ++++
>  configs/odroid-hc4_defconfig              |  6 ++++
>  configs/odroid-n2_defconfig               |  6 ++++
>  configs/odroid-n2l_defconfig              |  6 ++++
>  configs/p200_defconfig                    |  4 +++
>  configs/p201_defconfig                    |  4 +++
>  configs/p212_defconfig                    |  4 +++
>  configs/radxa-zero2_defconfig             |  6 ++++
>  configs/radxa-zero_defconfig              |  6 ++++
>  configs/s400_defconfig                    |  6 ++++
>  configs/sei510_defconfig                  |  6 ++++
>  configs/sei610_defconfig                  |  6 ++++
>  configs/u200_defconfig                    |  6 ++++
>  configs/videostrong-kii-pro_defconfig     |  4 +++
>  configs/wetek-core2_defconfig             |  6 ++++
>  configs/wetek-hub_defconfig               |  4 +++
>  configs/wetek-play2_defconfig             |  4 +++
>  include/configs/meson64.h                 | 49 ++++++++++++++++++++++++++-----
>  45 files changed, 278 insertions(+), 7 deletions(-)
> ---
> base-commit: 9a0cf3993f71043ba08c315572c54622de42d447
> change-id: 20231023-usb-dfu-boot-f47849f9fb34
>
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#1789): https://groups.io/g/u-boot-amlogic/message/1789
> Mute This Topic: https://groups.io/mt/102134207/1991006
> Group Owner: u-boot-amlogic+owner@groups.io
> Unsubscribe: https://groups.io/g/u-boot-amlogic/leave/9114030/1991006/1716920881/xyzzy [mkorpershoek@baylibre.com]
> -=-=-=-=-=-=-=-=-=-=-=-
