Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC23CCD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 17:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5058984B5D;
	Thu,  7 May 2026 19:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dPXcLKM3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C9AF84B9D; Thu,  7 May 2026 19:13:18 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3867F84B58
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 19:13:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-82748257f5fso1431911b3a.1
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 10:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778173995; x=1778778795; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EstZPJgHb8RCeftJb81EkfDJ2DN4hyepE0DYIG5j0Kk=;
 b=dPXcLKM3LOFpOz/WHhhp6kfMPUJlAr+8tdeyVXxPvc8+X1YWt17UOnDHKb4vX2KLHq
 SpHeMiIDvk6TvOR5i8Vtjjk7E/4qqUwspOTHcS2oOMi6g0rH/A7Ykb/bQIEMpYbfdvSz
 /1TOht+YMIei84I8Itc5Zv4YZmpKrDXicTTtHXdjFMEGmPC4a8LDiLABUUGO3GA6Makr
 J6vnFvU5B8hXwX/QMjzXQEqrCkPd1xzuHsHJCIpmZ4HV4ZUp1VVv7ooJOc/ZXsyGI27f
 /4g3ww7NT7jXfz3b96/DzSenN2QqH/bCbBALTwG0uR42hI2UTgG1uw+AwrGw/RaEW3X7
 aFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778173995; x=1778778795;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EstZPJgHb8RCeftJb81EkfDJ2DN4hyepE0DYIG5j0Kk=;
 b=XCRt6beqEZQBj6KmDP0PMlxWqaqExaEeE9h0eqPGJBJTBvWU6l9ao+bAwb31Xurcc9
 k+a+xwxSMtVCcigr0TcpEq77w2UR8E3MCYncvfyQ7saHDkVoEuHxF5kPnV2XZioTrOtW
 2b/c8dq5oOui+UV29/9boaxPGAL3F9uT7O+oypBTLY63kF55VBk8BP0UbWTAId0Qrr96
 zCFEJVBq55j2/qDrrS8e3UOqfc1yCoD+4QoCfhzgbgMdlWXBTOviBTsDP/fmw9Axki0u
 dFj8LdIOvB4kYmQK5xUXlsVIJEoIfvzKXaUKgb3dCmLo+NL9LHrQAS78ccgSwqAhbpsW
 XEgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8YRRNa1cDUKlaU1qo1NLSXGwIj3dv/hbg4Hcc9ZcruqHS2q52De+bSjGmD8q3hEyqzVCrxuCo=@lists.denx.de
X-Gm-Message-State: AOJu0YwypBPIpOrKK0/LTpdsrvWKkOshq44AixGpuVQ+A9trYTJz8h2O
 YQa7b27C8/bQ2EcheDhwRZBnOhASTakoFuTFELLL676TkLsB7ZsQq1lv
X-Gm-Gg: AeBDiesQCyyq/evvFogxfXgDjtMRcQysFhWII7glS/5ZBTqrr02E3EmTjG6qPiryY2C
 6t5ENAiRaqBatmcS7Tuna9WV13LQRSd2RAcwafosbVPaPwj4w4H2G6tIhO6S5WdrrtFDvOD5EAC
 VNwgU2+IbSZ0QEEHhE0G74QvEqrgN9HgFfb7jMtsAZkCB9LkYQj4+SlRbgZkfeMsK+jpbtGBCZk
 eDYm3STws5eQ7Frli2wD+NXIQNI/DpYmpSIZVsCMY9sLzEIWY/RZAH2lDJ4d48mnrdP4HCOR+wL
 php1gFaLXjifRIxn2NxUE38Yi3mlEKFdDQ/2ZNyAzHO0bx8lYvlUR/7o92EIqBoM5QJzubvIgGI
 J35PS9TOBaWEV88cNYINwkGOAJbFDl566KQ9m+IWbXt58krymRZId1J7+87m/I8kegxD35TG5+x
 5RhMkDNBCTpcEtmpibb/8LdMVQUZL0HYYtn8n+jsPU4i1WGmc=
X-Received: by 2002:a05:6a00:b8f:b0:837:6bb9:acc1 with SMTP id
 d2e1a72fcca58-83bb6cd842cmr2982460b3a.13.1778173994503; 
 Thu, 07 May 2026 10:13:14 -0700 (PDT)
Received: from google.com ([2402:7500:a16:6bef:465e:34ce:3a75:d3a0])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8396563f127sm9616771b3a.5.2026.05.07.10.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 10:13:13 -0700 (PDT)
Date: Fri, 8 May 2026 01:13:09 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: trini@konsulko.com, angelo@kernel-space.org, bmeng.cn@gmail.com,
 sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH v6 8/8] board: qemu: m68k: Create virtio mmio instances
Message-ID: <afzIJQRmvH8ppToK@google.com>
References: <20260505074948.2603870-1-daniel@thingy.jp>
 <20260505074948.2603870-9-daniel@thingy.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505074948.2603870-9-daniel@thingy.jp>
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

On Tue, May 05, 2026 at 04:49:41PM +0900, Daniel Palmer wrote:
> So that you can use virtio network, block etc create the virtio mmio
> instances. There are 128 of these even if they are not all used, a
> single mmio base value is passed via bootinfo.
> 
> Reviewed-by: Angelo Dureghello <angelo@kernel-space.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
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
> index 00e89bd0a625..8bebf0ea3e13 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -196,12 +196,14 @@ config TARGET_STMARK2
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
> 2.53.0
> 
