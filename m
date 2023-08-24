Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12029C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 08:39:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68247860CA;
	Thu, 24 Aug 2023 10:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="WaIDDlC7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCB0D8620C; Thu, 24 Aug 2023 10:39:12 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAC83807C4
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 10:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-400e8ca7e38so7229665e9.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692866349; x=1693471149; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SZquD8pH4+QpbwMpra+8hSzjkXC8Vm/+miBOh/y+Tyw=;
 b=WaIDDlC73puE6OH17MP0uBZ2jjAP+dkFxqzJ8DhKrVKvYJwXHp35snNReev685csAo
 rH3GGtca0yqRPMzJzBGNv5+aF0xr7LN/AUdxEqOIQFcCjtIgzLpqKpIVdIBNgt9bo7U/
 t1EJrE7pVgv1iqfT40KHglimh69oJM3gwq3HFm8dosDEBIk6xmQ4BOcMr7yCKtGfTEPk
 eMgoB5/yYkR2ov+wEoOq2rmDv1QMDkYnbi645oL20AEP5I97RxxOT/sDtuWPoAbGgwzO
 jJ2HFSmZG5WM5nXjHf/2iIUu3ybRb+izV1NQC/lxTFCLtwzSZRMI0DoC3yCtX3OKn/Ld
 3vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692866349; x=1693471149;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SZquD8pH4+QpbwMpra+8hSzjkXC8Vm/+miBOh/y+Tyw=;
 b=jyjnQfguYpuW2lzivDFB+rkO7AC5EGDNPcxAnfiIMP/SZlLjdQKWMOecLVP4gLdXaH
 3HHK5KCKJuJUazsrAQKOOs/gsmr8DY4WM8Ov3LDJjGsNB99zjhdBfo/Jn2ZZsByzJURw
 G6gqLEOhDuFPgXX7HyC+J3Izff7FYaDEdoLLILQ56OdkAaRUHpaBrjBca0SB9cEcNp7g
 t70jZ9nCzR8x5IlFXij1GpO17QYb9kTBdnTi9mwmpFd/TDb8YMQ7bi5zk11FSVu+WvqZ
 pbb1deNrSKnu2IJrGOmGX15/QtHqsUq92tpWvHfdDJjS0h8+OU3gF3XLjkC2dR5qWTk9
 Vrcw==
X-Gm-Message-State: AOJu0YwcEPCuRtw1VG6KwQXGitXfEjOj8QzN1WDgE60iGNcPvBUiL39X
 VezTl7Ed6b/Nl4e2FV14ZaV1Ow==
X-Google-Smtp-Source: AGHT+IGuSCxj4cFdpRMi43SdOWoDgT3T7jNIAC8YRZULUUCHZ4YVGyXPp8P0lJStIlRFK1NOFWy2BQ==
X-Received: by 2002:a7b:cd14:0:b0:3fc:1a6:7764 with SMTP id
 f20-20020a7bcd14000000b003fc01a67764mr11249351wmj.16.1692866349286; 
 Thu, 24 Aug 2023 01:39:09 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 hn1-20020a05600ca38100b003fbe4cecc3bsm1934956wmb.16.2023.08.24.01.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 01:39:08 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@google.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V5 13/17] arm: mach-k3: am625: Add support for UDA FS
In-Reply-To: <20230824031101.3460411-14-nm@ti.com>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-14-nm@ti.com>
Date: Thu, 24 Aug 2023 10:39:07 +0200
Message-ID: <874jkorg0k.fsf@baylibre.com>
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

On mer., ao=C3=BBt 23, 2023 at 22:10, Nishanth Menon <nm@ti.com> wrote:

> While boot partition support with EMMC boot is useful, it is
> constrained by the size of boot hardware partition itself.
>
> In the case of K3 devices, tispl images can contain OP-TEE images that
> can substantially vary in size and the u-boot image itself can vary over
> time as we enable various features.
>
> So use the CSD information in the case of EMMC_BOOT configuration being
> enabled to pick boot partition or UDA FS mode operation to pick.
>
> If EMMC_BOOT is disabled, then depend on filesystem configuration to
> pick data from UDA.
>
> While at this, drop the extraneous whitespace.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Changes since V4:
> - Did'nt pickup Mattijs' reviewed-by - no more iffdeffery - so might be
> good to relook.
>
> V4: https://lore.kernel.org/r/20230822184135.2328409-4-nm@ti.com
>
>  arch/arm/mach-k3/am625_init.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
> index 499cb57267b9..8fa36f7b913e 100644
> --- a/arch/arm/mach-k3/am625_init.c
> +++ b/arch/arm/mach-k3/am625_init.c
> @@ -220,9 +220,15 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boo=
t_device)
>  	u32 bootmode_cfg =3D (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK)=
 >>
>  			    MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
>=20=20
> -
>  	switch (bootmode) {
>  	case BOOT_DEVICE_EMMC:
> +		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT)) {
> +			if (spl_mmc_emmc_boot_partition(mmc))
> +				return MMCSD_MODE_EMMCBOOT;
> +			return MMCSD_MODE_FS;
> +		}
> +		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
> +			return MMCSD_MODE_FS;
>  		return MMCSD_MODE_EMMCBOOT;
>  	case BOOT_DEVICE_MMC:
>  		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
> --=20
> 2.40.0
