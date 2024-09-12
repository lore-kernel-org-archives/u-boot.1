Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29936EE57F6
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9148E88E03;
	Thu, 12 Sep 2024 03:02:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OFliqI9q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7302E88E7D; Thu, 12 Sep 2024 03:02:09 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1B0088E6B
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7d4fa972cbeso345707a12.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102925; x=1726707725; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tw2VNCHvRmEe1FztZEqp3ZpbCUozzuqM46T4vPYPd24=;
 b=OFliqI9qyMcJHDa2G2flke4t7ATsV0f4TxQsJwjTPDtfR3rkDJ9V2sZwhgJp0GxrNz
 ddG0etpz2TZuDU7cPbJOjok3X9wNW6JacR1ZGGH69O32s2FQI3J13FsBxtL3aAz89Z3B
 2egUM+unjOxa9LqXemUkK33p72GR4dcLANgG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102925; x=1726707725;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tw2VNCHvRmEe1FztZEqp3ZpbCUozzuqM46T4vPYPd24=;
 b=AXgtyUmCMYzo1wcpO//OKKLx4XjnPwwuYox/1au5/6sITC4FMep/iyfIFVBrrVfNGK
 0s35dYM+WDq32ngHKl52EFdz0Qjb1bhb8tAU9z7c8aqCLdgQGcE7qXkR2wZ6lxF8dH4R
 Jc8wsajWkyWioQojNNmrp4cyZHqVywqAiuoCX5T7YgecIGdIROAjqX5YBronE537fy9n
 DanzzatW+yht7cTHYNH4Uy5SLMcLaPwHAFSeeuGynFrHN9y0Qh2lWDYEnjKK1UnHMFgX
 1jmpxR/x4E+pQMWAajHCMagGh8sc18oL5zPeJHKARW9OcNQJLVr39OCKh9oxGfOxaj4Y
 s37A==
X-Gm-Message-State: AOJu0YwmdJJxDE55T+OQdmmw7P+rU7VgGzyv8B/9xTosDJSZ68mMub0P
 +QHhIaJVw4LWTKzI7zAva9j7prfaT3Bes/XjY9MsWmSXFP3d9WBJXC8ZkWy1N+44cjhF8gd5NHB
 Oy2zSErAGRl9vVU21ZlkI7GhXj1ILME1+bxf5veqm+VtsYSI=
X-Google-Smtp-Source: AGHT+IH+m5LS+C0lqmu+Fg1sJunCcsjy8cg9UBaIW4HEumFk+zFmibHqhcoboMbykOKrp7jhiFVWqAKaBuFqA3ZE/Bc=
X-Received: by 2002:a05:6a20:b2a8:b0:1cf:3677:1c4a with SMTP id
 adf61e73a8af0-1cf75eb94cfmr1157095637.16.1726102924873; Wed, 11 Sep 2024
 18:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAEwRq=qZSs9va2ztMQ2t_kfqHFAiMydyUHY13U_-AfKdSuhL-w@mail.gmail.com>
In-Reply-To: <CAEwRq=qZSs9va2ztMQ2t_kfqHFAiMydyUHY13U_-AfKdSuhL-w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:01:44 -0600
Message-ID: <CAFLszTjSoLW769CAefgu9wzm5VBVZnvyPp87f2zi9ecUtPB4mg@mail.gmail.com>
Subject: Re: persistent environment
To: Vincent Legoll <vincent.legoll@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi Vincent,

On Sun, 8 Sept 2024 at 22:38, Vincent Legoll <vincent.legoll@gmail.com> wrote:
>
> Hello,
>
> I'm struggling to setup u-boot to be able to save the environment.
>
> The board is Pine64 QuartzPro64.
>
> ATF is collabora's:
> https://gitlab.collabora.com/hardware-enablement/rockchip-3588/trusted-firmware-a.git
> collabora-enablement-tfa/master
> 44418fce30938ee483fbfc79cc32fde33753d1aa
>
> rkbin is
> https://github.com/rockchip-linux/rkbin.git
> master
> a2a0b89b6c8c612dca5ed9ed8a68db8a07f68bc0
>
> U-boot is:
> https://source.denx.de/u-boot/u-boot.git
> master
> 1630ff26cc960439b5949b80cfc604a2c8aa47dd
>
> export BL31=../trusted-firmware-a/build/rk3588/release/bl31/bl31.elf
> export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2736MHz_eyescan_v1.11.bin
> make quartzpro64-rk3588_defconfig
> make CROSS_COMPILE=aarch64-linux-gnu-
>
> SD card is GPT partitionned:
> Device           Start     End Sectors  Size Type
> /dev/mmcblk1p1      64   16383   16320    8M Linux filesystem
> /dev/mmcblk1p2   16384   32767   16384    8M Linux filesystem
> /dev/mmcblk1p3   32768   65535   32768   16M Linux filesystem
> /dev/mmcblk1p4   65536 1114111 1048576  512M EFI System
> /dev/mmcblk1p5 1114112 8388607 7274496  3.5G Linux filesystem
>
> I put on:
> * mmcblk1p1: idbloader.img
> * mmcblk1p2: u-boot.itb
>
> environment should be on : mmcblk1p3
>
> I tried to use:
> CONFIG_ENV_IS_IN_MMC=y
> CONFIG_SYS_MMC_ENV_DEV=1
> CONFIG_SYS_MMC_ENV_PART=3
> CONFIG_ENV_SIZE=0x1f000
> CONFIG_ENV_OFFSET=0x3f8000
>
> I tried to add:
> * USE_ENV_MMC_PARTITION
>
> I tried to change ENV_OFFSET to 0x0
>
> I'm getting:
>
> Loading Environment from MMC... MMC partition switch failed
> *** Warning - MMC partition switch failed, using default environment
> [...]
> => env info
> env_valid = valid
> env_ready = true
> env_use_default = true
> => env erase
> Erasing Environment on MMC... MMC partition switch failed
> MMC partition switch failed
> Failed (1)
> => env select MMC
> Select Environment on MMC: OK
> => env select MMC 1:3
> Select Environment on MMC: OK
> => env erase
> Erasing Environment on MMC... MMC partition switch failed
> MMC partition switch failed
> Failed (1)
>
> I've attached the config and a more complete serial console log.
>
> I'm probably doing something wrong, but I can't see it.
>
> I'd like some hints about how to get further.
> Thanks

Looking at env_erase()
It calls drv->erase() which for mmc is:
.erase = ENV_ERASE_PTR(env_mmc_erase)

I see this:

if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT)) {
   copy = 1;

   if (IS_ENABLED(ENV_MMC_HWPART_REDUND)) {
      ret = mmc_set_env_part(mmc, copy + 1);
      if (ret)
         goto fini;
   }

which suggests that perhaps it is failing there as mmc_set_env_part()
has that error message "MMC partition switch failed". Do you want a
redundant environment?

Regards,
Simon
