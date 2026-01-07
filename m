Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0ADCFD624
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 12:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C988783FB2;
	Wed,  7 Jan 2026 13:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hY4xl8g1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C933583CDC; Wed,  7 Jan 2026 03:29:47 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9BB483C4B
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 03:29:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-64b791b5584so2558630a12.0
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 18:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767752985; x=1768357785; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Eo2REbhtMh6da4XwOwj2eVJJ1YY5mlhoEt8gW6Hq4lI=;
 b=hY4xl8g17WcSZEop5Baiqm5XVWobwG4YnbbU6tg0XR8Sqt+HvFpLkpAIJOEh316QW6
 rldUjQb1oq/uYlG6kFRnxJHLFzX0xyrjjwiFNcEgtfqL0T4DXhJH8N/S1RCHwgh3Sn7Q
 blgcb6EYJQlgB9bSYFwlBg/MxrvNyvLxATV4nYNzYaI9JkOXk4GN8ShtxzrwOs3xLMKN
 iMeANZ3L2pPJRvyNlFdv6thVImSvu+AZuh6zc5G+t7ocpkVyJB6GXKjPaoFX7PPm82Ae
 EzNcmo6j16arRsyp+Z7NV3uvNoPYIjWo+h5xeHkzP6Ub1ple9kz3QuPslFA1KFR24zeO
 aZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767752985; x=1768357785;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eo2REbhtMh6da4XwOwj2eVJJ1YY5mlhoEt8gW6Hq4lI=;
 b=oiha1EzT3Kf0FkfylkZ2RX3G0/4pr+kJn/zyUmANJ/594y+DEhkoq7plTgJ+8GM79c
 TAEIXY10KNpwa/VVwR0ezU/naOgAZmlGRGvRSJNi9jE41KgbEQt3QpAcLY8U0bQkeFDw
 4qSJPErG9PePizZwnfMAbju9SjMZaR38tlA8Dfv8PK8FF+Bhemxm96lSlxNv3mnP/8Gx
 P3rXdgyLzr4sIal84VM1BWQ1T7uM/C1FOUN7MTmp/yIfeEfVAoe+nfxsdJJ1iFQoZ5EL
 eNFoE0oW+I7pNKCBWimIFB2ngQq2kuiOTliRn4exxRqy79/eUbJ/lDdnqt3vBw9Zs49K
 Fm5g==
X-Gm-Message-State: AOJu0YxQ++uwER9dl6/w8fZ+nzSQY7YxF/a3p2QSkZ1AL0ijpZcgh+Ca
 Va+dNgt43mDpnz9cMUJ/YQQI3Mekpc/d5V46XNcqV66axlt7ILydAPefGONHUhLCA2JVYW5rTNQ
 imLZOHXRtYV+VJcDaGBNviiq/zsA6Fg8=
X-Gm-Gg: AY/fxX6HQONTsd5jdNkzrGq/DEV0QuyRQWPm64sWqYxtZ1IsFn2JnIp0Ml+qsTepavD
 bRhItnENzPYKnaZ99AWeM6xIlRnMdGAf7sJBPfrN7coRBRCFryTwMm4QtAaz5RmAd/uYzEHV1H+
 CpU4N+Ajy4kiV5eLA7rHG22gGOG3nXUJ3KW5Ii+li35XcsReX1xuxnzjq2wDZJtGL/0V6ZrUD93
 ikeqDn9zoAlRmT4hDRNW00Gcnw5KdQM8X2ul/aMvPxeafxZ/zFy1PLoATS913srjUe3HgzF5JQv
 IHL0Vv4o8cz9SHRYukSjehwYHTBjpXhZ0jdSOKk98OS+YP5kbfO2QRDTqhez0v86Nea4rU9G2WK
 KdAuX9SOPDC9R9hRnwsaQp2yzvEKE8SrHBR8c
X-Google-Smtp-Source: AGHT+IHUi0LPLme5wTX7zv6RGBRjzAHybVRF0L5ls6/AV2y7ohyWdu+6XBSQquxzr3/kVErB7kSOkMaK2QV2ffya1D0=
X-Received: by 2002:aa7:d903:0:b0:641:78b7:d326 with SMTP id
 4fb4d7f45d1cf-65097e7125bmr717272a12.28.1767752984986; Tue, 06 Jan 2026
 18:29:44 -0800 (PST)
MIME-Version: 1.0
References: <20260107003131.3064800-1-simon.glass@canonical.com>
In-Reply-To: <20260107003131.3064800-1-simon.glass@canonical.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 7 Jan 2026 02:29:33 +0000
X-Gm-Features: AQt7F2pj1pHJXN6GHeGVoM-X9w3-HS-Og8w_1ZFH4-5ULVI1GcuyfuJNSQ9okO0
Message-ID: <CALeDE9OP8qZAtWykrBDu95qx=Sp0jP7BK2BE0H1d1pfz6_YJNw@mail.gmail.com>
Subject: Re: [PATCH 00/10] bootm: Clean up arch-specific, pre-OS clean-up
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <simon.glass@canonical.com>, Adriano Cordova <adrianox@gmail.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Greg Malysa <malysagreg@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ian Roberts <ian.roberts@timesys.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Leo <ycliang@andestech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymondmaoca@gmail.com>,
 Rick Chen <rick@andestech.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Weijie Gao <weijie.gao@mediatek.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 07 Jan 2026 13:39:07 +0100
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

Hi Simon,

> Each arch does something slightly different before booting the OS. Some
> archs even do different things depending on the CPU type.
>
> EFT_LOADER has its own special code, regardless of which arch is being
> booted.
>
> It is quite hard to know what actually happens in the final milliseconds
> before the OS boot.
>
> This series attempts to clean up U-Boot in this area.
>
> The basic approach is to create a new bootm_final() function which is
> called by all archs. It provides some flags for a couple of necessary
> variations but otherwise it is generic.
>
> RISC-V, x86 and ARM are converted over to use this new function. For
> consistency, EFI loader is converted as well.
>
> A noteable change is that EFI_LOADER now does bootstage processing
> before boot, if enabled, thus producing a report.

Why is the change needed, I don't see it explained in the patches or
here and what the implications might be.

> There is also a patch to drop EFI_GRUB_ARM32_WORKAROUND, as discussed
> recently on the mailing list.

That appears to be unrelated to this series, it should be a separate
standalone patch else it needs to be described here why it's a
dependency, and even then likely still posted separately as a
dependency of this series.

> Future work could take this a little further:
> - Drop board_quiesce_devices() and rely on driver model for that
> - Similarly with udc_disconnect(),
> - cleanup_before_linux() could use more details as to what it is
> supposed to do, to reduce the number of arch-specific variations

What do you mean by that statement.

> Note: This is the first 10 patches for an 18-part series from the
> Concept tree, as requested. The patches after that complete the cleanup
> on ARM and RISC-V.
>
>
> Simon Glass (10):
>   boot: Create a function for final pre-boot steps
>   efi: Make use of bootm_final()
>   bootm: Add a message when booting
>   bootstage: Add some missing dummy functions
>   bootm: Do bootstage processing in bootm_final()
>   x86: Call bootm_final()
>   riscv: Drop board_quiesce_devices()
>   riscv: Call bootm_final()
>   efi: Drop EFI_GRUB_ARM32_WORKAROUND
>   x86: Add cleanup_before_linux()
>
>  MAINTAINERS                           |  1 +
>  arch/riscv/include/asm/u-boot-riscv.h |  1 -
>  arch/riscv/lib/bootm.c                | 24 +------------------
>  arch/x86/cpu/cpu.c                    |  5 ++++
>  arch/x86/lib/bootm.c                  | 14 +----------
>  boot/Makefile                         |  2 +-
>  boot/bootm_final.c                    | 34 +++++++++++++++++++++++++++
>  configs/mt7623n_bpir2_defconfig       |  1 -
>  include/bootm.h                       | 17 ++++++++++++++
>  include/bootstage.h                   |  8 +++++++
>  lib/efi_loader/Kconfig                | 10 --------
>  lib/efi_loader/efi_boottime.c         | 30 +----------------------
>  test/boot/bootflow.c                  |  2 +-
>  13 files changed, 70 insertions(+), 79 deletions(-)
>  create mode 100644 boot/bootm_final.c
>
> --
> 2.43.0
>
> base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
> branch: bootma-us
