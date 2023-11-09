Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DE5C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 01:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C71788714F;
	Thu,  9 Nov 2023 02:16:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oE+giNoG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71E53870A4; Thu,  9 Nov 2023 02:16:04 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0F9E871A0
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 02:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507bd644a96so438970e87.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 17:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699492548; x=1700097348; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ANmvkQXfk5myZi8eWxyZzGh1w6L4TzUZviF0QYGmsHE=;
 b=oE+giNoGNXJG16ivEKtk3ZRODQNy32HoOvJfbTBtmAa2EKUsx5iY6xzcjjnpqrX3Np
 XBBDbQrMGjC/s4H5w26GSBLmUx6ORpo+snGeEhP/cVgw/gMYHfHs4fJuYIR4QuSFxc4W
 wFH/VrJgBLt2OZO90CsTAkm/KDHipOLtmsUCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699492548; x=1700097348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ANmvkQXfk5myZi8eWxyZzGh1w6L4TzUZviF0QYGmsHE=;
 b=mWacu+CqeZagHqrlpUxyPmSQFRonXadMghtqLXppdIdpA5+s4zd7vUucotSwKS5Nh5
 HoHIm4uphK+VRWBZhLvrrSUE1oBOK5JsgUUknjQtgy4rgtIH8x6p+gWgJ+euwdm5HUbs
 /NvgPCJDKbhoo80Jq64CP5qZMoN86i4A0GI/6UMXOe8ZMHv1ufvDiE3vJ25Ax+pjKmEM
 C3BNIwumH2QzOFq/aLkzbuq7zYZ01D98P8rkfB/8rBmw9sLmJgmVgDYHaV8pQUvpYQ8R
 3i39OZw60GgDAj639TtBUqW/dj54ss5rt+rTnq7wS6ujOXnZEoxG/m0LrSfdSuNUrk/z
 rV5g==
X-Gm-Message-State: AOJu0YzjCzJrZs/8ec5ms6+ADmG3qU3eAlNjyHMcuq3HCWrsAiGO4w7d
 BjH47CTEeAkuDN/kOug+BZi8pSgyn5MeD+dZ7D1oAA==
X-Google-Smtp-Source: AGHT+IH31JLiIST6kSiFfMX82Ee88EvwSmCY2yhYlUPG/GBNBHDhjZ4Ms0TgOhbYrk9Hl6TNjS/g3ZHoOpca0X7K+WI=
X-Received: by 2002:a19:5216:0:b0:509:4d95:e896 with SMTP id
 m22-20020a195216000000b005094d95e896mr177323lfb.66.1699492547800; Wed, 08 Nov
 2023 17:15:47 -0800 (PST)
MIME-Version: 1.0
References: <20231108164858.3497420-1-seanga2@gmail.com>
 <20231108164858.3497420-3-seanga2@gmail.com>
In-Reply-To: <20231108164858.3497420-3-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Nov 2023 18:15:27 -0700
Message-ID: <CAPnjgZ2YpM1m1JOo3c+O-imaVQfNmCF4Twn1e+a4f7HP5UtD2Q@mail.gmail.com>
Subject: Re: [PATCH v7 02/26] arm: Disable SPL_FS_FAT when it isn't used
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, 
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Stefan Roese <sr@denx.de>,
 Michal Simek <michal.simek@amd.com>
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

On Wed, 8 Nov 2023 at 09:49, Sean Anderson <seanga2@gmail.com> wrote:
>
> Several boards enable SPL_FS_FAT and SPL_LIBDISK_SUPPORT when they can't be
> used (as there is no block device support enabled). Disable these configs.
> The list of boards was generated with the following command:
>
>     $ tools/qconfig.py -f SPL SPL_FS_FAT ~SPL_MMC ~SPL_BLK_FS ~SPL_SATA \
>                           ~SPL_USB_STORAGE ~ENV_IS_IN_FAT ~EFI
>
> LIBDISK was left enabled for the am* boards, since it seems to result in
> actual size reduction, indicating that partitions are being used for
> something.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v7:
> - Disable FS_FAT for the zynq(mp) boards as well, as suggested by Michal
>
> Changes in v6:
> - New
>
>  configs/am335x_evm_spiboot_defconfig      | 2 +-
>  configs/am65x_evm_r5_usbdfu_defconfig     | 1 -
>  configs/xilinx_zynqmp_mini_qspi_defconfig | 3 ++-
>  configs/zynq_cse_nand_defconfig           | 2 ++
>  configs/zynq_cse_nor_defconfig            | 2 ++
>  configs/zynq_cse_qspi_defconfig           | 2 ++
>  6 files changed, 9 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
