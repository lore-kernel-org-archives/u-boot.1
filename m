Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4539D29DDA
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 06:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 492B4836A3;
	Tue, 13 Jan 2026 07:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IoQwGyAQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FDBF836D3; Tue, 13 Jan 2026 07:37:17 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 737E683678
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 07:37:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c6d13986f8so4907390a34.0
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 22:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768286234; x=1768891034; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7zZR5/MNEpaBJI3wYiPVN9YzU+y0UCS8Y9K1Q5rCOfY=;
 b=IoQwGyAQ0Pdpc8J+1uzmqwGztFqG59nUytWVOYnFqk2YFh9EZ3SZxFAzX6STqn81/y
 ycCidrtfkMctOOngCU9kywlBhYO+njFaH3VZvU3Gc2seXB23FpOH93JfMig/1CI1KZLu
 V4sfEqJJRudH2EMpP04lZ6r2j1wa+6C7xye/gGwlfdEt2lP7M9uJ5Zjc/02tqZO9Wndr
 qJU38cnG0HJ6OJE7mDLA0TAZdiT0oTdsSBivmorup2wSOjZ0iBl7rG2OxeBHZAljkgQf
 fXb2MXKkZ4AgY2/p+vHyudG1PdekI/ceGvMijNFPUJTABvG4tFVXFxmV/+8d6n6PMY3C
 v0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768286234; x=1768891034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7zZR5/MNEpaBJI3wYiPVN9YzU+y0UCS8Y9K1Q5rCOfY=;
 b=jzGaa5KUshlqkXXXHCaV1Xv7qR2ggprBp1VpkqxXvoHOb3qtKHsFcQyfWAaajUPHRn
 ynv9zNVlAKdC/lPSJTzoB1vaGlvjPPEu4Z25UV3H1cfUqm+mTUa8v956NHnZm0SOnc+6
 jy3dRJvpY3UOSfpl4vbhK7bd3BO5wnhiBBeRgqDj20Gs42/s3iHVGa27kRLmVlB0cCiE
 S09glt+WIryR68bN7odefK6Um/RGvpQHevXwoY0LNYPxwE9+gOYmOH3r8dMfRF5o/q4W
 R6If/H6v1EiBDr387FLcL5GtuCJ3RZar6xob7PRE0s+AGps4/vbae6grQgt9hGzcQ3UD
 1VjQ==
X-Gm-Message-State: AOJu0YzV/i3gZpIfYSgbOYnAyfO9WJ9tA9onmEIXuqotMN6hR5UpDp0a
 OaHe4kyh2sm39h29otKjo7NMgulvTy7p09pJIkPlKSzlxwNn6VS7UaKFheH8g4JkFXy18LXPQ90
 U6pE1l9Uzyu5tJyULLxCBYps5JtthmF+wa60wb2iUoQ==
X-Gm-Gg: AY/fxX5KIN6wzt4FJBPRMUxhHUVGo1Vt/x56U6pi2k9pPsv9UOVQNHSCSUjLqQRfXJC
 j04OMAp6JGPOxTMfAYxKfklTXtBw+s1/uZBV3cPlQnlKvPcZmvoO9S6nYVYmNPVqt84f93lTd5G
 hCzQy5P4srwF0gvOS8vFfjy60RiVsMI8ZUUNn5T8LK9SMVplHTsqrzLv7VLJL6gqIq5ymdiDSgO
 h74uwkB50cgSBDgt1ue1Joan3xi6iHrK8kO0dFYs4fByKzi1atOibfB+GpKidjl0ZOGtXU=
X-Received: by 2002:a9d:714f:0:b0:7ca:f4cd:db57 with SMTP id
 46e09a7af769-7cfbe4af589mr741830a34.17.1768286234060; Mon, 12 Jan 2026
 22:37:14 -0800 (PST)
MIME-Version: 1.0
References: <20251223123910.4639-1-briansune@gmail.com>
In-Reply-To: <20251223123910.4639-1-briansune@gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 13 Jan 2026 14:37:03 +0800
X-Gm-Features: AZwV_Qh-e6UOoEmcQiRwCIPsJ1f7TcadVBqdbnu61rvEg06FKA1-jcpj0AFk3ko
Message-ID: <CAN7C2SDx4KG=yKD1YhK7AXOYHDM9XDQhkpHzVPvgAcUdFFYRsg@mail.gmail.com>
Subject: Re: [PATCH v2] Replace TARGET namespace and cleanup properly
To: u-boot@lists.denx.de, Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
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

Hi T.F.,

Any issue on the new board patches?
Please review and push to the mainstream if possible.

Thanks,
Brian

On Tue, Dec 23, 2025 at 8:39=E2=80=AFPM Brian Sune <briansune@gmail.com> wr=
ote:
>
> TARGET namespace is for machines / boards / what-have-you that
> building U-Boot for. Simply replace from TARGET to ARCH
> make things more clear and proper for ALL SoCFPGA.
>
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>  Kconfig                                       |   4 +-
>  arch/arm/Kconfig                              |  30 +++---
>  arch/arm/dts/socfpga_agilex-u-boot.dtsi       |   2 +-
>  arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi |   4 +-
>  arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi    |   6 +-
>  arch/arm/mach-socfpga/Kconfig                 | 102 +++++++++---------
>  arch/arm/mach-socfpga/Makefile                |  32 +++---
>  arch/arm/mach-socfpga/board.c                 |   6 +-
>  arch/arm/mach-socfpga/clock_manager.c         |   8 +-
>  arch/arm/mach-socfpga/config.mk               |   4 +-
>  .../include/mach/base_addr_soc64.h            |  10 +-
>  .../mach-socfpga/include/mach/clock_manager.h |  14 +--
>  arch/arm/mach-socfpga/include/mach/firewall.h |   2 +-
>  .../mach-socfpga/include/mach/fpga_manager.h  |   4 +-
>  .../mach-socfpga/include/mach/handoff_soc64.h |  24 ++---
>  arch/arm/mach-socfpga/include/mach/misc.h     |  10 +-
>  .../mach-socfpga/include/mach/reset_manager.h |   6 +-
>  .../include/mach/reset_manager_soc64.h        |   2 +-
>  arch/arm/mach-socfpga/include/mach/sdram.h    |   4 +-
>  .../include/mach/system_manager.h             |   6 +-
>  .../include/mach/system_manager_soc64.h       |   8 +-
>  arch/arm/mach-socfpga/misc.c                  |  18 ++--
>  arch/arm/mach-socfpga/misc_soc64.c            |   2 +-
>  arch/arm/mach-socfpga/mmu-arm64_s10.c         |   2 +-
>  arch/arm/mach-socfpga/reset_manager_s10.c     |   2 +-
>  arch/arm/mach-socfpga/system_manager_soc64.c  |   4 +-
>  arch/arm/mach-socfpga/wrap_handoff_soc64.c    |   4 +-
>  common/Kconfig                                |   2 +-
>  common/spl/Kconfig                            |   4 +-
>  drivers/clk/altera/Makefile                   |  12 +--
>  drivers/ddr/altera/Kconfig                    |   6 +-
>  drivers/ddr/altera/Makefile                   |  14 +--
>  drivers/ddr/altera/sdram_soc64.c              |  14 +--
>  drivers/ddr/altera/sdram_soc64.h              |   4 +-
>  drivers/fpga/Kconfig                          |   2 +-
>  drivers/fpga/Makefile                         |   4 +-
>  drivers/fpga/altera.c                         |   8 +-
>  drivers/mmc/socfpga_dw_mmc.c                  |   8 +-
>  drivers/mtd/nand/raw/Kconfig                  |   2 +-
>  drivers/net/Kconfig                           |   2 +-
>  drivers/power/domain/Kconfig                  |   2 +-
>  drivers/reset/reset-socfpga.c                 |   2 +-
>  drivers/sysreset/Kconfig                      |   4 +-
>  env/Kconfig                                   |   2 +-
>  include/configs/socfpga_common.h              |   4 +-
>  include/configs/socfpga_soc64_common.h        |  10 +-
>  scripts/Makefile.xpl                          |   6 +-
>  47 files changed, 216 insertions(+), 216 deletions(-)


same~
