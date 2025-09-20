Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4E1CAC592
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 00:37:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CEA882A9E;
	Sat, 20 Sep 2025 02:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xLodRhOb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2003A8309A; Sat, 20 Sep 2025 02:37:54 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 744B2809A5
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 02:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2697899a202so19688705ad.0
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 17:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758328670; x=1758933470; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4oF0rtN7JPekM/qOuEoTawAo2MH011HDbXEC6e94M+U=;
 b=xLodRhObGGdxpiZbjiY3b+0piHVylp3RY/I0mT3NaREiTZGJ1hY8rgf9UrudL450e+
 Q5paQWwmCijBPWtO9pyLJA9POBUzSo3XEhn7YNUhDcfIZxLWd0dyFiS8y0UcO3rGzyH8
 9MI2I1UAi7FWY31FBA8Po8s3T5MD0E6yVnrKTalI5YPwn7I7KMqz6FgaP8xgrbh+VITD
 lLGLfOXn4F6C9hRZ1l2Q3Mt2EYHGHPjtejk1OCW0GB7as9HDk+93kcps5XnjQkctodWj
 oibilLceiHN1juVXwX2ppBB1W/xHjtAwRvREi+p9rVFCh4bEphb8hxHLkOsE2niSc2Pl
 j9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758328670; x=1758933470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4oF0rtN7JPekM/qOuEoTawAo2MH011HDbXEC6e94M+U=;
 b=O+jWw8bDmCWHTFrd0mBgu8VU+tzBRcXI4MBg7lvylPFaKQZn6TQCq4IAi+uK+6o+zs
 H9FixfjGi5KzwZTJq1/wK48RW5UGN+plg1Drqt8o3g1bTh7TbN6jQJoz1Q37mEQDcprp
 MLQIYXIxxU8PN5BLxhE1Z1o23judSqXr4gqYoljmTmRyMP23SF2gNL/pkL09YTxeKpAS
 rExBze/LSoFUhvqmbRzxfCgPdvbYDAKrBLSQf/E4cf44lgsCrd24wnXZUR4XSZbg4MDU
 f3XZkS9WvhtR9RYbMDBarVncqFvXbo6zID54CMVytUOXcV0ANhxO5FbbTMnpoFns/JUu
 /Rsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAc3kTkKCXNxz6y2ZJQ2z4neI80l/+Mt8nbIIrzX8P6XkFfgpFS57fUfU54QrL5KcCuHYT9tg=@lists.denx.de
X-Gm-Message-State: AOJu0YwDV61Nj4PIm38hS5KjGj2bfo5pIeUHiFiaa++Q833gkzEdB21M
 mvgTFcSWrPfFbOF1ngNLsHa8TeRMXJjcwus4265ZWeUKz32ClSgzzysxx7DEi5tPxqnGpHBGi4s
 wu4JvJLt5VgexV3Rz4SoNbERJkX7CezlJpiZ8Dt0YXw==
X-Gm-Gg: ASbGnctk+DaSjQBmaGHa5h6yaGtCEpTpSNDQ4CPRfmB2qp/Ur5qLj3+aACxbAZzOMzD
 S4pDiTLvkyOdv0SGyZvVlbUq9pyjEEK5SR1V75Ab4bSXafv1/AuQIv5zqjGhwGv1HC/GKRQU8po
 PQhrhL1ypT40Yb53VgmmBf2M6HYAv+jU9fQ2wnvYr3ptTUYMUHbFMJHG0k0tLYIUul1SAa/RO5K
 40kREn0+w==
X-Google-Smtp-Source: AGHT+IFizpy4aMUpNvoB+h02x4je9PG55DHbdSu9FKXArDHBnVnQXP1dkOgz87AHrjXijqGzWHFXsnFWMGQ2WQnyBXM=
X-Received: by 2002:a17:903:2983:b0:242:5f6c:6b4e with SMTP id
 d9443c01a7336-269b785e4f1mr75736965ad.7.1758328669908; Fri, 19 Sep 2025
 17:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250919222424.95815-1-chalianis1@gmail.com>
In-Reply-To: <20250919222424.95815-1-chalianis1@gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 19 Sep 2025 20:37:38 -0400
X-Gm-Features: AS18NWCrEnM6kiYIm1kBIXW9x0Jqsdi8LQrwuhr5junweCsDNp7JFJz8v6RQJv8
Message-ID: <CAEfUkUJmMh3dHJRhRxJZHe6b44b+59K6+H1UoruEZqXQDiL9iQ@mail.gmail.com>
Subject: Re: [PATCH] arm: mach-qemu: add support for qemu booted from TF-A.
To: chalianis1@gmail.com
Cc: trini@konsulko.com, patrick.rudolph@9elements.com, u-boot@lists.denx.de
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

Hi,

On Fri, 19 Sept 2025 at 18:24, <chalianis1@gmail.com> wrote:
>
> From: Chali Anis <chalianis1@gmail.com>
>
> add the ability to be booted from Arm Trusted Firmware for qemu aarch64,
> to do so we need to skip NOR flash partition setup.
> U-boot launched as BL33 from TF-A is supported and Tested on arm64 with
> qemu-system-aarch64 and the qemu ARM64 support ARCH_SUPPORT_TFABOOT.
>
Actually the patch is trying to skip part of the initialization when
U-Boot is running as BL33, so the statement like "add the ability to
be booted...", "U-boot launched as BL33 from TF-A is supported" won't
help as U-Boot is working as BL33 already.

> Signed-off-by: Chali Anis <chalianis1@gmail.com>
> ---
>  arch/arm/mach-qemu/Kconfig             | 1 +
>  board/emulation/common/qemu_mtdparts.c | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/arch/arm/mach-qemu/Kconfig b/arch/arm/mach-qemu/Kconfig
> index 9c06c6a3a5ce..316dde5145c0 100644
> --- a/arch/arm/mach-qemu/Kconfig
> +++ b/arch/arm/mach-qemu/Kconfig
> @@ -18,6 +18,7 @@ config TARGET_QEMU_ARM_64BIT
>         bool "ARMv8, 64bit"
>         select ARM64
>         select BOARD_LATE_INIT
> +       select ARCH_SUPPORT_TFABOOT
>
>  config TARGET_QEMU_ARM_SBSA
>         bool "SBSA Reference"
> diff --git a/board/emulation/common/qemu_mtdparts.c b/board/emulation/common/qemu_mtdparts.c
> index c1501276789c..c3863d3b0479 100644
> --- a/board/emulation/common/qemu_mtdparts.c
> +++ b/board/emulation/common/qemu_mtdparts.c
> @@ -59,6 +59,7 @@ void board_mtdparts_default(const char **mtdids, const char **mtdparts)
>                         debug("mtd device = %s\n", dev->name);
>                 }
>
> +#ifndef CONFIG_TFABOOT
>                 mtd = get_mtd_device_nm("nor0");
>                 if (!IS_ERR_OR_NULL(mtd)) {
>                         mtd_partition = CONFIG_MTDPARTS_NOR0;
> @@ -72,6 +73,7 @@ void board_mtdparts_default(const char **mtdids, const char **mtdparts)
>                         board_get_mtdparts("nor1", mtd_partition, ids, parts);
>                         put_mtd_device(mtd);
>                 }
> +#endif
>

Skipping the default NOR mtdparts when TFABOOT is selected looks fine.
However, qemu_dfu.c still sets dfu_alt_info based on those NOR
partitions (used by DFU/EFI capsule flows).

This actually brings one concern related to capsule update: currently
the QEMU ARM64 board depends on mtdparts to make EFI capsule update
work.
It raises a question: do we actually want to support capsule update
when U-Boot is running as BL33?
If yes, then the current patch breaks capsule update and more work is needed.
If no, we should make it explicit (e.g. prevent
EFI_CAPSULE_FIRMWARE_MANAGEMENT from being selected together with
TFABOOT).

BTW, can you please add a rev number in the subject line? E.g. [PATCH
v2], [PATCH v3]... See the patterns from other patches.

Regards,
Raymond

>         }
>
>         mtd_initialized = true;
> --
> 2.34.1
>
