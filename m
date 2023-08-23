Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542EEEE49AE
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 07:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8EE085DEA;
	Wed, 23 Aug 2023 09:54:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="W8I6lMNW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7909B863B2; Wed, 23 Aug 2023 09:54:19 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96706846C0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 09:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fef3c3277bso23352495e9.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 00:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692777257; x=1693382057; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TyaKjGK/p0CeN/4hnDvyasKZojGwCqVvR+UDntFeYdU=;
 b=W8I6lMNW6RtsnGEmR4LtAM9VBIG0LiF8ds2bhcAJQHu2+7E0vnXHJEC0Zino/pgSgy
 F5Orr/ohYZSwO1HowJqf+cyIAZH5Kn2Xg8PR7yAYIyq53XxtExzbpSSny4dNKLJzm+b/
 AmKu+4YNYNkukpO91SdjinbZ+VPa/MeHiboQRPf/wa04Us2pD+Nb0sHfDxBK57ikJob2
 JlrPD3JiYKnZwdDpUUYiUWyQKyJxUiJJ+KRlJd4tb+7jN4Wws0UoB8SugdMPBE4OHNbn
 jR2fdTsbF0Ml0K6av+RzGWq1YqhDSXCuae7/xEQTuAI1WJ2o1RO/yhiifVkf19l450fa
 Wp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692777257; x=1693382057;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TyaKjGK/p0CeN/4hnDvyasKZojGwCqVvR+UDntFeYdU=;
 b=jbcGbpND2my+lsO4hBCwhVrru7QMoz9C4vzGoZbH24mZ2V+LeM7YCQ6Y8QjcLmsmI7
 YED1vCitbMf2WjJVL88Tnp1cEjqKWK2zA8trno5KSk3myNAq87gP7fenQnmzk62II+kK
 33yJiXUw+PnLgr/XzskpWp/HwH9BDRC/rCspvWjVWReYMdNGIGyKV2HvhQb9EVMhCWHG
 mPv44rRHrQoVTjKtxegys3XoaGHn8J+JhNHEiS4s7q+lec34qDC1nAYo5aCqERsy1xjp
 KDQ96GzrivSN+bGu012a71fkX/CyzUOwDZbpQLbXLp6F8Dc2nu/DL3ikBCU7cz4qCS9i
 maxg==
X-Gm-Message-State: AOJu0YzPnsKar+2we5CkVhQDZx0DmgsMWCvWMpXInSRxg/pWv4N7Qxmq
 of5RMgs2L3erKGHftWQBtqfgyBE+Liln0pIuwsE=
X-Google-Smtp-Source: AGHT+IFB2sn0A3h4KNHq1WWmGEjQg9tDUxRYnO5xnDu59Sdr8kebIlUibduDE4hRsidCB9DEDFUrNA==
X-Received: by 2002:a05:600c:c5:b0:3fe:1db2:5179 with SMTP id
 u5-20020a05600c00c500b003fe1db25179mr8800090wmm.19.1692777256906; 
 Wed, 23 Aug 2023 00:54:16 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a7bc001000000b003fee567235bsm13753187wmb.1.2023.08.23.00.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 00:54:16 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V4 3/8] arm: mach-k3: am625: Add support for UDA FS
In-Reply-To: <20230822184135.2328409-4-nm@ti.com>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-4-nm@ti.com>
Date: Wed, 23 Aug 2023 09:54:15 +0200
Message-ID: <87ttsqfb2w.fsf@baylibre.com>
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

On mar., ao=C3=BBt 22, 2023 at 13:41, Nishanth Menon <nm@ti.com> wrote:

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
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> New patch
>  arch/arm/mach-k3/am625_init.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
> index 0e5d44269ebf..ad61030a56fa 100644
> --- a/arch/arm/mach-k3/am625_init.c
> +++ b/arch/arm/mach-k3/am625_init.c
> @@ -228,7 +228,13 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boo=
t_device)
>=20=20
>  	switch (bootmode) {
>  	case BOOT_DEVICE_EMMC:
> +#if CONFIG_IS_ENABLED(SUPPORT_EMMC_BOOT)
> +		return (spl_mmc_emmc_boot_partition(mmc) ? MMCSD_MODE_EMMCBOOT : MMCSD=
_MODE_FS);
> +#elif defined(CONFIG_SPL_FS_FAT) || defined(CONFIG_SPL_FS_EXT4)
> +		return MMCSD_MODE_FS;
> +#else
>  		return MMCSD_MODE_EMMCBOOT;
> +#endif
>  	case BOOT_DEVICE_MMC:
>  		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
>  			return MMCSD_MODE_RAW;
> --=20
> 2.40.0
