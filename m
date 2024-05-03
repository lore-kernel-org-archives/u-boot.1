Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530C5C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 21:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85FDE87FF7;
	Fri,  3 May 2024 23:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T23yaS1O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6345688047; Fri,  3 May 2024 23:42:12 +0200 (CEST)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 417D787F65
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 23:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4df2a816455so81265e0c.3
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 14:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714772529; x=1715377329; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7vBf4q3yaPqAoHaeo5JHsJd100EkQZ692izbNXf/MPk=;
 b=T23yaS1O1p2DqtePF93BlGEei0sZO4ueIrmMkVzRvnlE1IOGVi1W6/TCyorS3AXsix
 rtCnnlN8FLBGyWFBdj32PIhvZvEP2fJG320FILKn+yELqzwulN7VtSjs3VJrhi3hymfH
 MpHq2/HMfYrWk53QwEev3qDxnhOP5zOFsLDzngvzqH/HIP52DcQLn3xpf93agvOHViPo
 CT8MZzwtC6+hHmhlqVt3/DqYLqCN3XxAq3hHyoZsiibGxkmk8rYJR5Uj7VA2O3zrXXvH
 rD1N8zuNowKZG8CXhcILrlWi1BUdsHIXr9y6Ng73TrVrXiv/7SVH/ZIemmMiM0VjtrA1
 hsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714772529; x=1715377329;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7vBf4q3yaPqAoHaeo5JHsJd100EkQZ692izbNXf/MPk=;
 b=qDQBRc0hyTv7T9Fanfom13h9tz/Bm765Kg7CsaRmOpJQdDdTQ9xeKnB3WQWkl+kkp/
 vO1sCg37Ei1GHIgCgbRjo1kHDo2fLIcF74OprdKN8iVbcD210+f04N4LUfj4Zufkik3V
 MBMp9qztvALH6cHv4Lfc/CemoGI2H/3q4hJvzdNjsd4vx1iLKgbUkrIZ1gAe2DK2oDrl
 IS9ZBAoTJ05q2gAyP4PRjfB4EXU5qiJTATSloyHCYIOrZvjDWDxCqDV025Q6R7Ji/qp+
 zw2OKfajx2/17jgZemoHNJvcPSflGMZbAzDwa5+n7McV6GUWNlbM5HFszffPTszFABzR
 O1Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVHnsDbaM/eYilbpD4zg+K7f60Zvoyw8yBo6ftFxfc0v13x9BSQoEPGhSRYerJDJObfRZxiDZM+dKuWaaknSD19KfCFg==
X-Gm-Message-State: AOJu0YwEh5obaaUEuDMX3wP9Am+97O/dmXuequvnazB6w6m+oHa9zQZq
 2Uvh2793f/4UOFFZRrhEwqo/Mj9W5ByvLfMBVBDcU3dMx+dEw/xBwStS0TgJ21Fu/5y0HvUFMMj
 20vMl10Nt0SYL96QpmPtoglIQmeY=
X-Google-Smtp-Source: AGHT+IF3egAGjahzK6e0hs6Jjk4QxJcM0bqmUykjfT1lPKIhOqjoCIJlF//RZesS9JZBsinmaQFj/5GaFWUgUSwj1U0=
X-Received: by 2002:a05:6122:3d12:b0:4da:e6ee:5533 with SMTP id
 ga18-20020a0561223d1200b004dae6ee5533mr4397521vkb.16.1714772528985; Fri, 03
 May 2024 14:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240503090011.37849-1-heinrich.schuchardt@canonical.com>
 <20240503090011.37849-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240503090011.37849-2-heinrich.schuchardt@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Fri, 3 May 2024 14:41:58 -0700
Message-ID: <CANV2PTP5Y4xr_khvgRzu-36UFOdQk6AxudzsEfNMqb2jAcAzFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] board: starfive: function to read eMMC size
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Aurelien Jarno <aurelien@aurel32.net>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>, Shiji Yang <yangshiji66@outlook.com>,
 Shengyu Qu <wiagn233@outlook.com>, Michal Simek <michal.simek@amd.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, Mason Huo <mason.huo@starfivetech.com>,
 u-boot@lists.denx.de
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

On Fri, May 3, 2024 at 2:01=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The EEPROM provides information about the size of the eMMC.
> Provide a new function get_mmc_size_from_eeprom() to read it.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         fix typos in get_mmc_size_from_eeprom() description
> ---
>  arch/riscv/include/asm/arch-jh7110/eeprom.h    |  7 +++++++
>  board/starfive/visionfive2/Kconfig             |  9 +++++++++
>  .../visionfive2/visionfive2-i2c-eeprom.c       | 18 ++++++++++++++++++
>  3 files changed, 34 insertions(+)
>
> diff --git a/arch/riscv/include/asm/arch-jh7110/eeprom.h b/arch/riscv/inc=
lude/asm/arch-jh7110/eeprom.h
> index 62d184aeb57..45ad2a5f7bc 100644
> --- a/arch/riscv/include/asm/arch-jh7110/eeprom.h
> +++ b/arch/riscv/include/asm/arch-jh7110/eeprom.h
> @@ -12,6 +12,13 @@
>  u8 get_pcb_revision_from_eeprom(void);
>  u32 get_ddr_size_from_eeprom(void);
>
> +/**
> + * get_mmc_size_from_eeprom() - read eMMC size from EEPROM
> + *
> + * @return: size in GiB or 0 on error.
> + */
> +u32 get_mmc_size_from_eeprom(void);
> +
>  /**
>   * get_product_id_from_eeprom - get product ID string
>   *
> diff --git a/board/starfive/visionfive2/Kconfig b/board/starfive/visionfi=
ve2/Kconfig
> index 2186a939646..d7e8a7a7d78 100644
> --- a/board/starfive/visionfive2/Kconfig
> +++ b/board/starfive/visionfive2/Kconfig
> @@ -50,4 +50,13 @@ config BOARD_SPECIFIC_OPTIONS # dummy
>         imply PHY_LIB
>         imply PHY_MSCC
>
> +config STARFIVE_NO_EMMC
> +       bool "Report eMMC size as zero"
> +       help
> +         The serial number string in the EEPROM is meant to report the
> +         size of onboard eMMC. Unfortunately some Milk-V Mars CM Lite
> +         modules without eMMC show a non-zero size here.
> +
> +         Set to 'Y' if you have a Mars CM Lite module.
> +
>  endif
> diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/=
starfive/visionfive2/visionfive2-i2c-eeprom.c
> index 5095a0e9fdb..9648a270494 100644
> --- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> +++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> @@ -548,6 +548,24 @@ u32 get_ddr_size_from_eeprom(void)
>         return hextoul(&pbuf.eeprom.atom1.data.pstr[14], NULL);
>  }
>
> +u32 get_mmc_size_from_eeprom(void)
> +{
> +       u32 size;
> +
> +       if (IS_ENABLED(CONFIG_STARFIVE_NO_EMMC))
> +               return 0;
> +
> +       if (read_eeprom())
> +               return 0;
> +
> +       size =3D dectoul(&pbuf.eeprom.atom1.data.pstr[19], NULL);
> +
> +       if (pbuf.eeprom.atom1.data.pstr[21] =3D=3D 'T')
> +               size <<=3D 10;
> +
> +       return size;
> +}
> +
>  U_BOOT_LONGHELP(mac,
>         "\n"
>         "    - display EEPROM content\n"
> --
> 2.43.0
>

Reviewed-by: E. Shattow <lucent@gmail.com>
