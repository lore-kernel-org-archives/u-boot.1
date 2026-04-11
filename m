Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B54CF3ED5C
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 20:28:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BE1384154;
	Sat, 11 Apr 2026 22:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="MlPtCDk6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 060E28416F; Sat, 11 Apr 2026 22:28:20 +0200 (CEST)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 095F484118
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 22:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1775939297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=acy90WBzBBJuVe2EbSnH/yoTHey0BoWflW9qc95271Y=;
 b=MlPtCDk61CVXWGPVTaurevWPLcTxozaO6SbwZNyVp0hCzlOU4r8qUvr7Tn1FV5ZwR3ltcm
 Rn+WXNprMNwG8kHsLbAqsPCVhG5h8UBTE4n05kyaIzHy/b7t2peKuKoaiWX0KeNmK0AaeW
 1HuxuVZ5Jf+yUgVieq5qqwDdV8j76pM=
Received: from [IPV6:2a07:7e81:7daa:0:62cf:84ff:feee:627] (<unknown>
 [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id dcb11655
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sat, 11 Apr 2026 20:28:17 +0000 (UTC)
Message-ID: <358e3185-1a42-4786-9c37-fe7ac41054e6@kernel-space.org>
Date: Sat, 11 Apr 2026 22:28:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] board: qemu: m68k: Create virtio mmio instances
To: Daniel Palmer <daniel@thingy.jp>, visitorckw@gmail.com, bmeng.cn@gmail.com
Cc: u-boot@lists.denx.de
References: <20260408220928.3328551-1-daniel@thingy.jp>
 <20260408220928.3328551-6-daniel@thingy.jp>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20260408220928.3328551-6-daniel@thingy.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

After applying this patch i got an error building

on a test build i am getting this error:

      m68k:  +   qemu-m68k
+  422 |                 sep = memchr(fixup_str, ':', fixup_len);
+      |                     ^
+  432 |                 sep = memchr(name, ':', fixup_len);
+m68k-linux-ld: cmd/virtio.o: in function `do_virtio':
+cmd/virtio.c:42:(.text.do_virtio+0xa6): undefined reference to `blk_common_cmd'
+m68k-linux-ld: final link failed: bad value
+make[1]: *** [Makefile:2105: u-boot] Error 1
+make: *** [Makefile:189: __sub-make] Error 2

Looks like a "select BLK" is missing.

Regards,
angelo

On 4/9/26 00:09, Daniel Palmer wrote:
> So that you can use virtio network, block etc create the virtio mmio
> instances. There are 128 of these even if they are not all used, a
> single mmio base value is passed via bootinfo.
> 
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> ---
>  arch/m68k/Kconfig                     | 14 ++++----
>  board/emulation/qemu-m68k/qemu-m68k.c | 47 +++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 6 deletions(-)
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
> index d3527aee1128..3617c61b5c1f 100644
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
> +static inline int create_virtio_mmios(void)
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
> @@ -80,6 +120,13 @@ int board_early_init_f(void)
>  	return 0;
>  }
>  
> +int board_early_init_r(void)
> +{
> +	create_virtio_mmios();
> +
> +	return 0;
> +}
> +
>  int checkboard(void)
>  {
>  	puts("Board: QEMU m68k virt\n");

-- Angelo

