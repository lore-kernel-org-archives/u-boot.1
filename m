Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8F2C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 02:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 096CB8862C;
	Mon, 29 Apr 2024 04:01:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="aRVL8HuI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99AD288356; Sun, 28 Apr 2024 18:13:33 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A655881DE
 for <u-boot@lists.denx.de>; Sun, 28 Apr 2024 18:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=emil.renner.berthing@canonical.com
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 16E423F6E6
 for <u-boot@lists.denx.de>; Sun, 28 Apr 2024 16:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714320809;
 bh=glbrxUIpV36uRn9ewd5SptAU6J7PXhm+hrraO5uvk0A=;
 h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=aRVL8HuIU+x/nNHJxYQ97wa8xcvlOXo8qLReXDIcHFfVDyh5vG6SuonCZ5r/45/6P
 YlHMEOme4xLlDYAMKL8gtacOLAtUT+4ItQLZIlM+QqYf5udlpMyEncilnak+81QXBW
 jU4bCuRp8iT7viP3XGvQpiUiQVI2mvOdcZWUalvzmfkhZozNykiCF9tLT2RxldHywj
 K11JVNWt33kcry7d8BO0lzGoHTyckZLjgz+xifJWfdWt3C0fd2c24rJjz6kDUVQk0+
 aVorqKHWbnyywTSBkiT0/GLZChR01pIRbfRFEucRgrNAiOoseYCHGkHWBkTAVWn+Tw
 4UIfXtNYsyDcQ==
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6a097848a56so42779746d6.0
 for <u-boot@lists.denx.de>; Sun, 28 Apr 2024 09:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714320808; x=1714925608;
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=glbrxUIpV36uRn9ewd5SptAU6J7PXhm+hrraO5uvk0A=;
 b=IcpcXtl9HnxzorVO7sz+0qotan15hwue4qFE9hOJ3VUzcM0Svpa4yIVK5XazmcKtqU
 /xKrCYbhFmUngDOJ+RJNQpVho506imdJ16MdcWp3SzNslIKiU5RhrWgS8oUHCxLJ/osZ
 n5pOslG1MLe1gmAo5Y974WxmVjtX6V53PEx6Yh8rhHdDInHCopcX4rTX7UPqiLZlApmK
 wJq9JqlJBmt0kHaH56j9Mf/hzUl9ttB6LtOi5A73yjqdKonbm5ZxLvTekjRwCyWcSuAr
 oIJKPYg+NBiqanxXgGDfukKMhV9IBZXj0dC0KrpSZkV2OiLNJqlfsviZMIhbd0/RADZF
 ckPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1UQxn2sST3T44NyVayXYK0b7VPlhHZ+vJvv2Hw4c5Sf0r0Ho5w8DQwhd72oIfPF+lYd227ThbuXiaOZO6wSuPNgxi4g==
X-Gm-Message-State: AOJu0YwcoS/4Izm+MMshJCc1WdLxWesCJ3OfayeVWl1JwbA2yjqozF5A
 f3c+kl6AWa249hRHuLzyphRd5TgmRhwS+BkZ4Mx61qXVlF2rIMVrDcTnRTEgH6ZInOGdiP1yM1Q
 G6KAafngoHiOG6RyxCeFl8JaU2EjxLhVMfrW93Zjy3jx7+pXj2cwYJSXPVk99zKDNtsAhhq33WB
 b8plIUy+KqjYAYGIDqT5iGT5N4cpo9sCLRl4x899l8Ow==
X-Received: by 2002:a05:6214:518c:b0:6a0:af6f:5373 with SMTP id
 kl12-20020a056214518c00b006a0af6f5373mr8991428qvb.37.1714320807926; 
 Sun, 28 Apr 2024 09:13:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8ShSiMt06LBPQMuU+BZq1t67Xw53ikkblOHtiJw1njy+CIoWx2Mdc5Cdbamu0MPyyCyCOTtj9PFxaE077edg=
X-Received: by 2002:a05:6214:518c:b0:6a0:af6f:5373 with SMTP id
 kl12-20020a056214518c00b006a0af6f5373mr8991404qvb.37.1714320807584; Sun, 28
 Apr 2024 09:13:27 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 28 Apr 2024 09:13:27 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240415115035.46199-3-heinrich.schuchardt@canonical.com>
References: <20240415115035.46199-1-heinrich.schuchardt@canonical.com>
 <20240415115035.46199-3-heinrich.schuchardt@canonical.com>
Mime-Version: 1.0
Date: Sun, 28 Apr 2024 09:13:26 -0700
Message-ID: <CAJM55Z9gVQom+jKzcLZ4jVKLS3MbGNpx1hx6dEWjgpY7Xmy5aA@mail.gmail.com>
Subject: Re: [PATCH 2/4] board: add support for Milk-V Mars CM
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Minda Chen <minda.chen@starfivetech.com>, Hal Feng <hal.feng@starfivetech.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Shengyu Qu <wiagn233@outlook.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 29 Apr 2024 04:01:08 +0200
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

Heinrich Schuchardt wrote:
> We already support the VisionFive 2 and the Milk-V Mars board by
> patching the VisionFive 2 device tree. With this patch the same
> is done for the Milk-V Mars CM.

Hi Heinrich.

Thanks for the patch. As far as I can tell the Milk-V documentation[1] is
pretty consistent in calling the version without eMMC "Milk-V Mars CM Lite"
and the version with eMMC just "Milk-V Mars CM". So I'd prefer the model,
compatible and filenames suggested below.

[1]: https://milkv.io/docs/mars/compute-module/introduction#design-philosophy

> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  board/starfive/visionfive2/spl.c              | 27 ++++++++++++++++++-
>  .../visionfive2/starfive_visionfive2.c        | 11 +++++++-
>  2 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
> index 45848db6d8b..bb0f28d7aad 100644
> --- a/board/starfive/visionfive2/spl.c
> +++ b/board/starfive/visionfive2/spl.c
> @@ -129,6 +129,29 @@ void spl_fdt_fixup_mars(void *fdt)
>  	}
>  }
>
> +void spl_fdt_fixup_marc(void *fdt)
> +{
> +	const char *compat;
> +	const char *model;
> +
> +	spl_fdt_fixup_mars(fdt);
> +
> +	if (!get_mmc_size_from_eeprom()) {
> +		int offset;
> +
> +		model = "Milk-V Mars CM SDCard";

"Milk-V Mars CM Lite"

> +		compat = "milkv,mars-cm-sdcard\0starfive,jh7110";

"milkv,mars-cm-lite\0starfive,jh7110"

> +
> +		offset = fdt_path_offset(fdt, "/soc/pinctrl/mmc0-pins/mmc0-pins-rest");
> +		fdt_setprop_u32(fdt, offset, "pinmux", 0xff130016);
> +	} else {
> +		model = "Milk-V Mars CM eMMC";

"Milk-V Mars CM"

> +		compat = "milkv,mars-cm-emmc\0starfive,jh7110";

"milkv,mars-cm\0starfive,jh7110"

> +	}
> +	fdt_setprop(fdt, fdt_path_offset(fdt, "/"), "compatible", compat, sizeof(compat));
> +	fdt_setprop_string(fdt, fdt_path_offset(fdt, "/"), "model", model);
> +}
> +
>  void spl_fdt_fixup_version_a(void *fdt)
>  {
>  	static const char compat[] = "starfive,visionfive-2-v1.2a\0starfive,jh7110";
> @@ -236,7 +259,9 @@ void spl_perform_fixups(struct spl_image_info *spl_image)
>  		pr_err("Can't read EEPROM\n");
>  		return;
>  	}
> -	if (!strncmp(product_id, "MARS", 4)) {
> +	if (!strncmp(product_id, "MARC", 4)) {
> +		spl_fdt_fixup_marc(spl_image->fdt_addr);
> +	} else if (!strncmp(product_id, "MARS", 4)) {
>  		spl_fdt_fixup_mars(spl_image->fdt_addr);
>  	} else if (!strncmp(product_id, "VF7110", 6)) {
>  		version = get_pcb_revision_from_eeprom();
> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
> index a86bca533b2..be6ca85b030 100644
> --- a/board/starfive/visionfive2/starfive_visionfive2.c
> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> @@ -17,6 +17,10 @@
>  DECLARE_GLOBAL_DATA_PTR;
>  #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
>  #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
> +#define FDTFILE_MILK_V_MARC_SD \
> +	"starfive/jh7110-milkv-mars-cm-sdcard.dtb"

"starfive/jh7110-milkv-mars-cm-lite.dtb"

> +#define FDTFILE_MILK_V_MARC_MMC \
> +	"starfive/jh7110-milkv-mars-cm-emmc.dtb"

"starfive/jh7110-milkv-mars-cm.dtb"

>  #define FDTFILE_MILK_V_MARS \
>  	"starfive/jh7110-milkv-mars.dtb"
>  #define FDTFILE_VISIONFIVE2_1_2A \
> @@ -61,7 +65,12 @@ static void set_fdtfile(void)
>  		log_err("Can't read EEPROM\n");
>  		return;
>  	}
> -	if (!strncmp(product_id, "MARS", 4)) {
> +	if (!strncmp(product_id, "MARC", 4)) {
> +		if (get_mmc_size_from_eeprom())
> +			fdtfile = FDTFILE_MILK_V_MARC_MMC;
> +		else
> +			fdtfile = FDTFILE_MILK_V_MARC_SD;
> +	} else if (!strncmp(product_id, "MARS", 4)) {
>  		fdtfile = FDTFILE_MILK_V_MARS;
>  	} else if (!strncmp(product_id, "VF7110", 6)) {
>  		version = get_pcb_revision_from_eeprom();
> --
> 2.43.0
>
>
