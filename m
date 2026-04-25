Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0747FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 426AF840D8;
	Sat, 25 Apr 2026 18:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kx1k5Kcz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB472841D7; Sat, 25 Apr 2026 18:14:39 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 681F884011
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-83178c0f29cso1878334b3a.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 09:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777133676; x=1777738476; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U49ZkQ6FRchWdsufZttEzQaNg7G1c6l5daBuHHid7YY=;
 b=Kx1k5KczulEFvyGY9TcgJ229yNHjR5PFbruTkqDp0ZN6r5MqLdBqYxBX4KGls541YH
 FGIyat3oNz0M3NGb+KNBYo3BuBrePiuhkMzDBA2rDdb9Qnf9MZLLV2KaVj6NFijsE9Mg
 RQbNXhze85jZeZE7puW9CN/1FCo3kVflyPsVadiPcycAZAVejGTsB4xgSET12XimY2l+
 LZtQ/GAHo9UWyn3dkowVJNI4A5mHvozlvB/UDBV2v6C9/v0FUmQ3apy8iKPoXCRB/owO
 R0iXpP5VnEhCubUC+fHJbV9t+xlbVVawn3kIBQkj2KaDCNtABZMdRveV3BgGNMIzoQpA
 uMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777133676; x=1777738476;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U49ZkQ6FRchWdsufZttEzQaNg7G1c6l5daBuHHid7YY=;
 b=HKD3ZyYXXlyP6pLQjWlI5fgQVEi8yUBk5lr9RWDVe3iEIU92BObduKOj4rWSFwLx1t
 1BhV5R//7p+KCpJVSyfOPa+xkqcXZI9dFt8d8ViaP78BaAhzMGwYMPVqIk24ti4Lz0i2
 YDX1bcmLshitkRoOlqIBSw20drR5vvmWCG4u7lFHbEPdgwwATYL3LYDXEuy8qqfO8vEt
 L8nUej+XdG+abLfGMkolN6wdohZpMu2raOl283gV+EtZpUIGcnG+gW9UFRSBXXNsche0
 C0RjLMPLtfwvszcKy6L2Xet7eWQsykTq4D828eufcWVM7Ds47r4auTsOJqpH7++KaoLR
 Da8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GChxWbD+VnzD4uQUeoEbygr5WAf3Y7vdZ87pXuddq3sEPF3enjfrG8YKVxhWPz9o8UJ7adDo=@lists.denx.de
X-Gm-Message-State: AOJu0YzdpWyOTFIyACokeBHj6MMACpoN9eud63PccT/DmHDyKwU/E+KI
 RSt2uB+eQGd1pQ51wTMSdk//zH3NJiQ/IStMgHhid6PBT7kY6sG8JlwA
X-Gm-Gg: AeBDiev642sGLkAGfrdx5TEEWcYHaswU76QAPxhDuVJmedajC8Fm32/M3/LbcA9b+R+
 qsdsETrzA0OP+MaSllx8spM9pTwSAmdBuRlTe9qTZaxjUyZWBZ0nIesicFgNM9swztyeydldkvl
 AIKmWQSTG/kqQH9WCzo1MEUoIYWllPoBblkmSU26VplcjuutUY68I+hhjEMk1WZQzRYJpBBsQX7
 W20K0/BbynF3rXZYE1Z9w9c+TUwRcPR1XxpO3Q4rtG7baFknwHvQi/NHQPOR2/aV8Wg2xkg2Goq
 L8WBsEK/w01+2Fl7ip8NhuMyMsUkxjw8NM225NbakYiiscK+zfZ/5s6s+yS8py1R5+GE/+iWIbj
 ztiXXg6oVswX5xgxmKhb5fr2njFD8pEvcC8AtTEYs8EibxCWPegKKiM4xPRY2hcwn+1pz8w2ypm
 bDGXK1NGMA4R7evNj1Ma4Kq4jKCTjNKjaJyO5Ek3Bwg4D8e/Ifo/nTBiP+HjmGIFpQbgaiS1RrP
 S4=
X-Received: by 2002:a05:6a00:4fcc:b0:82f:5034:77a4 with SMTP id
 d2e1a72fcca58-82f8c8409b4mr38811514b3a.21.1777133675924; 
 Sat, 25 Apr 2026 09:14:35 -0700 (PDT)
Received: from google.com (61-230-36-6.dynamic-ip.hinet.net. [61.230.36.6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebe41cfsm29310745b3a.43.2026.04.25.09.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 09:14:35 -0700 (PDT)
Date: Sun, 26 Apr 2026 00:14:32 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: angelo@kernel-space.org, bmeng.cn@gmail.com, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: Re: [PATCH v5 8/8] board: qemu: m68k: Create virtio mmio instances
Message-ID: <aezoaCYWfvq52fw2@google.com>
References: <20260416093927.602613-1-daniel@thingy.jp>
 <20260416093927.602613-9-daniel@thingy.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416093927.602613-9-daniel@thingy.jp>
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

On Thu, Apr 16, 2026 at 06:39:27PM +0900, Daniel Palmer wrote:
> So that you can use virtio network, block etc create the virtio mmio
> instances. There are 128 of these even if they are not all used, a
> single mmio base value is passed via bootinfo.
> 
> Reviewed-by: Angelo Dureghello <angelo@kernel-space.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>

FWIW

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Tested-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> ---
>  arch/m68k/Kconfig                     | 14 +++++----
>  board/emulation/qemu-m68k/qemu-m68k.c | 45 +++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index 6ce8f577e3a1..20a112880c87 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -195,12 +195,14 @@ config TARGET_STMARK2
>          select M54418
>  
>  config TARGET_QEMU_M68K
> -    bool "Support QEMU m68k virt"
> -    select M68040
> -    imply CMD_DM
> -    help
> -      This target supports the QEMU m68k virtual machine (-M virt).
> -      It simulates a Motorola 68040 CPU with Goldfish peripherals.
> +	bool "Support QEMU m68k virt"
> +	select M68040
> +	select BOARD_EARLY_INIT_R
> +	select VIRTIO_MMIO
> +	imply CMD_DM
> +	help
> +	  This target supports the QEMU m68k virtual machine (-M virt).
> +	  It simulates a Motorola 68040 CPU with Goldfish peripherals.
>  
>  endchoice
>  
> diff --git a/board/emulation/qemu-m68k/qemu-m68k.c b/board/emulation/qemu-m68k/qemu-m68k.c
> index d3527aee1128..a19b23a28ce3 100644
> --- a/board/emulation/qemu-m68k/qemu-m68k.c
> +++ b/board/emulation/qemu-m68k/qemu-m68k.c
> @@ -14,9 +14,14 @@
>  #include <asm/bootinfo.h>
>  #include <asm/global_data.h>
>  #include <asm/io.h>
> +#include <dm.h>
> +#include <dm/device-internal.h>
> +#include <dm/lists.h>
>  #include <dm/platdata.h>
> +#include <dm/root.h>
>  #include <linux/errno.h>
>  #include <linux/sizes.h>
> +#include <virtio_mmio.h>
>  
>  DECLARE_GLOBAL_DATA_PTR;
>  
> @@ -25,6 +30,38 @@ static struct goldfish_rtc_plat rtc_plat;
>  static struct goldfish_timer_plat timer_plat;
>  static struct qemu_virt_ctrl_plat reset_plat;
>  
> +#define VIRTIO_MMIO_NUM	128
> +#define VIRTIO_MMIO_SZ	0x200
> +
> +static struct virtio_mmio_plat virtio_mmio_plat[VIRTIO_MMIO_NUM];
> +static char virtio_mmio_names[VIRTIO_MMIO_NUM][11];
> +static phys_addr_t virtio_mmio_base;
> +
> +static int create_virtio_mmios(void)
> +{
> +	struct driver *drv;
> +	int i, ret;
> +
> +	if (!virtio_mmio_base)
> +		return -ENODEV;
> +
> +	drv = lists_driver_lookup_name("virtio-mmio");
> +	if (!drv)
> +		return -ENOENT;
> +
> +	for (i = 0; i < VIRTIO_MMIO_NUM; i++) {
> +		virtio_mmio_plat[i].base = virtio_mmio_base + (VIRTIO_MMIO_SZ * i);
> +		sprintf(virtio_mmio_names[i], "virtio-%d", i);
> +
> +		ret = device_bind(dm_root(), drv, virtio_mmio_names[i],
> +				  &virtio_mmio_plat[i], ofnode_null(), NULL);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Theoretical limit derivation:
>   * Max Bootinfo Size (Standard Page) = 4096 bytes
> @@ -65,6 +102,9 @@ static void parse_bootinfo(void)
>  		case BI_VIRT_CTRL_BASE:
>  			reset_plat.reg = base;
>  			break;
> +		case BI_VIRT_VIRTIO_BASE:
> +			virtio_mmio_base = base;
> +			break;
>  		case BI_MEMCHUNK:
>  			gd->ram_size = record->data[1];
>  			break;
> @@ -80,6 +120,11 @@ int board_early_init_f(void)
>  	return 0;
>  }
>  
> +int board_early_init_r(void)
> +{
> +	return create_virtio_mmios();
> +}
> +
>  int checkboard(void)
>  {
>  	puts("Board: QEMU m68k virt\n");
> -- 
> 2.51.0
> 
