Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF66C36011
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 08:53:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FBEC81DE3;
	Mon, 31 Mar 2025 10:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NdH7hdRC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9215481DE3; Mon, 31 Mar 2025 10:53:08 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 863A18144A
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 10:53:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso39474785e9.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 01:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743411186; x=1744015986;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=EYnxSFs6u11NYl3ULi9kMyxmTJVxg8DMjr1lUiEXbic=;
 b=NdH7hdRCtr4OjSyW4b3ODGoUiqCSpAdKHJhiHfYDPfcvWtqkPzrbTa7z3us39DcIGM
 2lZ1AieQNqZHqoXceRIs3uJ6n3PuMdCommkcgy6rGowK8b7OZMmUzaTeFZbFAl9BFgod
 63mH7Ku01edNc/fnCxXpJAnjuOsbpy/tkxAkaR6crxqEVlNX3iabuC5XqDNQxeTx1Etv
 X05QSItU9BDYbSSErt7ck5xmRx17CLMjUd+e025m7gixRcHxHs5k1qnsehhaIKSKM1Mx
 pW5NZE76bqBVvCsfyQNzN9zQIuWAdsaLKw0dGOh7TCeP05gm3N8l0pCN+nrlsLNWbqb6
 hwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743411186; x=1744015986;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EYnxSFs6u11NYl3ULi9kMyxmTJVxg8DMjr1lUiEXbic=;
 b=Fpd+J2O0PgOrZxe8t+DFX4y/WeB6vQwwlTJ6cZt5AkpKuudmIzyuZPRZIE6qe5vdLF
 xR5WwN9SabWhtIqTi+atmXz22CmA07rd7oozsT1nRTbCXqQfcO8/GAajzWTVlh+IDM1u
 1uWyfz5NI2Qe3WjiVBH/F0XKuHUNUhOOBxuFQRLeMIlzkugtIkoqdoekZ7haK4ZjFho9
 hhl7UHnDx4lr9L5xCIbM9J4zvmij2Bzn9zoqiXcZBQkP87S73Vn9R1S4B8pMVh+WqTyO
 dvI+UIWYYpKBq2z584GCwG0bXz66AIc7bjKxopYD7ZIF+MEtrwvgyYBbpLJn0DR8HBGt
 Bg7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNcEjnNZ0Se5nzS20kD+Y9JZtXpZDZ9KBc19gCURLdtZNNcyTqVT+657X5crq1NsAARc1iwgA=@lists.denx.de
X-Gm-Message-State: AOJu0YzQD7OLuFscep21/6hUli17fvXlklrNvRRsIwomUtZ864C6o+P2
 pQVzO1tHIAK4ySqIAcBiVk3IlFY1g3rEHFKLauKcoi0SD6dDlWneU6DDqsMnyqE=
X-Gm-Gg: ASbGncs57I0HsoCci9i47+La+smk+L/Aw1TZmjErag/YDodFtw1xk//gZArIMzcfVA1
 OC33pzkm6p8Rp/Pd6bSwQaH2K292tKt1FzwgPkID3QmqgtX8e861BRwvUCjSXizYVdRsT/Ho0RG
 tfAmTD0rj2F6SZuxxiW5DV3ZGfhwvmPij/KFmDccg5DNlOWbuYAXttM9vAr4LwIKWDKodD6u0Go
 T7YjXXDTO9FspWfrBxeuDoTpXhgDZu7Xc8f1fqNkBf1biNDD1YLd+T0fsaJOpKq5dTC+AD5Ss7W
 fRK79As83eoJTHUDr/6BQGssjhVKt+snaCwemz6ayrG1sb8R+6JI/FneOpFTR8442JLI1UGCJLf
 7JKidPJNC3qRYOwJv5Q==
X-Google-Smtp-Source: AGHT+IEuKzkFTJx1mKEEtm0l35qEOgvpKXR6tOPvPVsXaiZ1SG/+dwU+HujbmG+AFg9b/8mtZPGNnA==
X-Received: by 2002:a05:600c:458b:b0:43c:e8a5:87a with SMTP id
 5b1f17b1804b1-43db624b447mr69557075e9.16.1743411185977; 
 Mon, 31 Mar 2025 01:53:05 -0700 (PDT)
Received: from localhost (lfbn-tou-1-752-68.w86-250.abo.wanadoo.fr.
 [86.250.199.68]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82a041d4sm162692195e9.0.2025.03.31.01.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 01:53:05 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Daniel Schultz <d.schultz@phytec.de>, w.egorov@phytec.de,
 trini@konsulko.com, u-boot@lists.denx.de
Cc: B.Hahn@phytec.de, upstream@lists.phytec.de, Daniel Schultz
 <d.schultz@phytec.de>
Subject: Re: [PATCH 3/3] configs: phycore_am62x_a53_defconfig: Enable gpio
In-Reply-To: <20250328055824.3849523-3-d.schultz@phytec.de>
References: <20250328055824.3849523-1-d.schultz@phytec.de>
 <20250328055824.3849523-3-d.schultz@phytec.de>
Date: Mon, 31 Mar 2025 10:53:04 +0200
Message-ID: <878qolponj.fsf@baylibre.com>
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

Hi Daniel,

Thank you for the patch.

On jeu., mars 27, 2025 at 22:58, Daniel Schultz <d.schultz@phytec.de> wrote:

> The AM62x uses the DA8XX (DaVinci) GPIO controller. Enable
> CONFIG_DA8XX_GPIO to support GPIO access from the Cortex-A53.
>
> Also enable the 'gpio' command to allow users to interact
> with GPIOs from the U-Boot shell.
>
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  configs/phycore_am62x_a53_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
> index c1a46bc40a9..3622e1a7cf2 100644
> --- a/configs/phycore_am62x_a53_defconfig
> +++ b/configs/phycore_am62x_a53_defconfig
> @@ -3,6 +3,7 @@ CONFIG_ARM_SMCCC=y
>  CONFIG_ARCH_K3=y
>  CONFIG_SYS_MALLOC_LEN=0x2000000
>  CONFIG_SYS_MALLOC_F_LEN=0x8000
> +CONFIG_SPL_GPIO=y
>  CONFIG_SPL_LIBCOMMON_SUPPORT=y
>  CONFIG_SPL_LIBGENERIC_SUPPORT=y
>  CONFIG_SOC_K3_AM625=y
> @@ -14,6 +15,7 @@ CONFIG_SF_DEFAULT_SPEED=25000000
>  CONFIG_ENV_SIZE=0x20000
>  CONFIG_ENV_OFFSET=0x680000
>  CONFIG_ENV_SECT_SIZE=0x20000
> +CONFIG_DM_GPIO=y
>  CONFIG_SPL_DM_SPI=y
>  CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am625-phyboard-lyra-rdk"
>  CONFIG_OF_LIBFDT_OVERLAY=y
> @@ -73,6 +75,7 @@ CONFIG_SPL_YMODEM_SUPPORT=y
>  CONFIG_CMD_BOOTEFI_SELFTEST=y
>  CONFIG_CMD_NVEDIT_EFI=y
>  CONFIG_CMD_DFU=y
> +CONFIG_CMD_GPIO=y
>  CONFIG_CMD_I2C=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_MTD=y
> @@ -112,6 +115,7 @@ CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
>  CONFIG_DMA_CHANNELS=y
>  CONFIG_TI_K3_NAVSS_UDMA=y
>  CONFIG_TI_SCI_PROTOCOL=y
> +CONFIG_DA8XX_GPIO=y
>  CONFIG_DM_I2C=y
>  CONFIG_SYS_I2C_OMAP24XX=y
>  CONFIG_DM_MAILBOX=y
> -- 
> 2.25.1
