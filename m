Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE26F8A152
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:29:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A79FD84105;
	Thu, 16 Apr 2026 11:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T9943EQi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F36D58421D; Thu, 16 Apr 2026 11:29:39 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B57378407E
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c795a47186bso233466a12.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 02:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776331776; x=1776936576; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CIp+Kn9w5MtV5CJ9H1KpETbWSZSi8sZCZi9bZWN3JNE=;
 b=T9943EQi50d2mjgXhI0tsaLt1w5r2w2CB8OXqRsr3vM1eSx/DHX96d+C0EtzTlS+jg
 djtWJTd0snvtrTXYuZ6veLwd4OqMz2Tb/eNEbscnfaQU0ugq08arzB6sQqtcvOXmgJCa
 pXC/yvNheyOQzE9Lrzjoa/O4yJPOjAc5WaQf7BVXARhv4gLRn57ZJYRw2AY9CKUTFd/U
 xSVKAaCXh2o/YOmQ2wjWZFBHbIpNUL15VkAhZ+Ue3BBOS39wERHIsLP9Vtsx+9M/6tYB
 7f3pVWPCCJZ7qt1Ro3MDKB24pUGVE6tAxg7pBRqFS2cB9DNBPWc71M2jh2KxMulM7l0t
 LP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331776; x=1776936576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CIp+Kn9w5MtV5CJ9H1KpETbWSZSi8sZCZi9bZWN3JNE=;
 b=ooBEl3lbAFvFj1Q3BqK7ln51Emigbu/SkuivzPm/R/MggZDhzxwd1KLPF2Awb/e52B
 wlyV1hqEU3NYDIcdgn+pPLoalcdpqOVb5K0tOCTTTshqUtm4aVm/bRKeP1V4drIKWydF
 anZZEFTIbEiI1eHW7XyDoyhHMv5Sse37kYqcpIh9dF+PVO1taE8OoVn6K/+3RZG/pOHJ
 QyU6bgV0KiS517lUmjd6rIvsj9CIC5mHvZEg+Mjf+EYAn9hV3H+adBBfcQrI8K4Edgp9
 l2UYZ+ld9nc/QUbGU1PUQrvgYvLUocaZH6D68/0JdHURmD0pTSuaOQDp+d0WLeao4Xm1
 4bsw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+IrFmHo4gvz6sSLkRfAZ/8KukbkKU4A35CWWp6pIYlX41yPbkc4BZRWCE/H5LDn2Xpu9dPiSc=@lists.denx.de
X-Gm-Message-State: AOJu0YynqpxRqIQeCbDcyY7bk6e8RBmcHJOuWExntrm7ZYpDP8amLZOH
 8iECYDGtrdbyldd/hcpvp9Fd74KuAVPqz8CxpJ2lcbZa1YtYq6CdUXRP
X-Gm-Gg: AeBDietaNKd9bqKzDfJpAQVPB/cMP8NP+/OGhIOWB5AlRVt+ZfvZQfhb4i5PcLjGDZP
 iZiThpSnbYanseWL+/fTwjGvrmof+If+NerIgZfZkDbMtrqzU//9YV3LoH/xni57WKSJBAEt6e6
 WRiCE1N3JBpnybC6n+qkkNmsRGkoiDOsS+jwEM0cEk16IHmqSpKybIaWHygGGFUAoYIxaAF4v9Y
 4vBo7uDKwVoq0Inxr1jOFz/UjKidp/oKFh3uyeGwdFrSBJV5UAzl9qI+sBVKObUgp4iOvRJvde/
 NXm15/wMPmHYLlLpNDQhjxplvwnzDYI7yQbNSspzivK2sa0utDhnaMYIutAReVQ3syEVOdkeG2b
 qVfMAFk5oFaae3/zoU6Quq27RBeQF8xpn1IF9DVactjLpFJn5na8ipNn4Ocu02XVfdvFye25uAu
 1ME4RklSvj0Pyv97vJrEKssIeebot9sbqXpLBJobwTuQ==
X-Received: by 2002:a05:6a21:6e8f:b0:398:8caa:bc93 with SMTP id
 adf61e73a8af0-3a078aa6698mr1045219637.15.1776331776123; 
 Thu, 16 Apr 2026 02:29:36 -0700 (PDT)
Received: from google.com ([2401:fa00:95:201:6c74:6a92:c2eb:e814])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7957eeaabesm3850234a12.10.2026.04.16.02.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:29:35 -0700 (PDT)
Date: Thu, 16 Apr 2026 17:29:32 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: angelo@kernel-space.org, bmeng.cn@gmail.com, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4 6/6] board: qemu: m68k: Create virtio mmio instances
Message-ID: <aeCr_D8wp4c7Kq44@google.com>
References: <20260413092240.3719260-1-daniel@thingy.jp>
 <20260413092240.3719260-7-daniel@thingy.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413092240.3719260-7-daniel@thingy.jp>
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

On Mon, Apr 13, 2026 at 06:22:40PM +0900, Daniel Palmer wrote:
> So that you can use virtio network, block etc create the virtio mmio
> instances. There are 128 of these even if they are not all used, a
> single mmio base value is passed via bootinfo.
> 
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>

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
