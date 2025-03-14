Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201F1C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 14:45:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AABCC81D67;
	Fri, 14 Mar 2025 15:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dsPR/5aC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4003D81D8C; Fri, 14 Mar 2025 15:45:23 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F5CB81D65
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 15:45:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5e4d50ed90aso2798940a12.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 07:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741963520; x=1742568320; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6lflbdpwsVA59lYqkzRKa+K+hBiACA9b/inaB4BS0IQ=;
 b=dsPR/5aC+petlUP7+NL374WOVF+ziX3pgePTLs3rtGM0DWBIw5S/m6/SwHuYBcQjWT
 ARtvyaWB0vge20//nXYm1SBwdyfBA1orz9a+wb109v43LCldiA/jcKKJ9fjUCwFGhVv3
 LY6hz67buX5auM/tjOa8wFiqF+hkDMnFLXANM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741963520; x=1742568320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6lflbdpwsVA59lYqkzRKa+K+hBiACA9b/inaB4BS0IQ=;
 b=PbOCcnAvnAuT0i1GgObkkdS9UlGetlCTLXgNnDrwvrc9cDgltP0qjXopHNnd8K2qyP
 AyAVVzHdGV1HUtYKNGZ1wgepzlzmzmhEjYkU+LQtfEzO73keWA4URuxPlF/lQQkoRoGR
 WpJsrhQC+bEX+Ks4+dASccnFHOjxSslxuX88thqrMzYUCNQqJTeka4o2Db0mlOsJzNmq
 gcZqobapfeuWTAxxKV/cjWUGkRIxS00F9jI22Xp2i/NT7hBsiSMr+C2d0aWDXO4ZCjMq
 MRcpRj0g04eMomJ735ari2A1YLkbAJ24u9d6gm/RN5T5Ai/LKV1+4m2SHD63SlAQb3vO
 yQtQ==
X-Gm-Message-State: AOJu0YzGSPc/axXFgeq5K1Dq8Pwl5R+Zc2yz9awbu+1Jr1GcNNMA2AfJ
 gx0jmwZIMKdZW4hAiNmBDzALOIfFASwwZa2njEVGoM/7CXLF7JqiVVjwYLBu//oq8Sr6xPAxdK/
 uuWcOW07yHO/eh4qkFir9n8JrpPUweqseKSBJ
X-Gm-Gg: ASbGncu5+4HOeGCpMqkPxbm0k3f8J1lIfJobvv8OpqgnhHhQK0blnDb2PO5k9if2MDb
 68t0MsVdO0SmYTQFMbc2RmuFdB3EAy46ZdjLX4ib4Lt5VAI6Y2h+RKO5HNW8BzPZHx1YVhE6aul
 3/nSSmq1Nkvtnz5i6YW9HRYweIPb1u
X-Google-Smtp-Source: AGHT+IGHJLadjy3c/tNqpBV+VLiziSqQhKig0SYowv57+0w/a+XPyUlSMkcST+PYShDCPjs5SDGffS9uapWcNsOhSOg=
X-Received: by 2002:a17:907:2ce3:b0:ac3:1364:2d15 with SMTP id
 a640c23a62f3a-ac3302cfad4mr321499666b.24.1741963520467; Fri, 14 Mar 2025
 07:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250314114758.29078-1-nareshkumar.ravulapalli@altera.com>
 <20250314114758.29078-2-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250314114758.29078-2-nareshkumar.ravulapalli@altera.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Mar 2025 14:45:07 +0000
X-Gm-Features: AQ5f1Jr2kqQ0fteDoG0MnrQH3VFlR513bowFrD3HT0ykxtsshMkVlQlcttb8Dh0
Message-ID: <CAFLszTgqfRY9W7jOq-GEH_D3VEad=wfyw5C5qij+Q-rovb8NEw@mail.gmail.com>
Subject: Re: [PATCH 1/1] drivers: fpga: Add partial reconfiguration console
 commands
To: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>
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

On Fri, 14 Mar 2025 at 11:48, Naresh Kumar Ravulapalli
<nareshkumar.ravulapalli@altera.com> wrote:
>
> Partial Reconfiguration (pr) command is added to U-Boot console. The
> pr command will use the Freeze Controller which can freeze and
> unfreeze the specified partial reconfiguration region. The pr command
> supports multiple regions for partial reconfiguration by specifying
> the region ID.
>
> Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
> ---
>  drivers/fpga/Kconfig    |   9 ++
>  drivers/fpga/Makefile   |   1 +
>  drivers/fpga/intel_pr.c | 191 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 201 insertions(+)
>  create mode 100644 drivers/fpga/intel_pr.c

Please can you put commands in cmd/ and add doc/ and test/ for them?

Also, we should have a generic FPGA API for this sort of thing.

>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 62cb77b098..bf34d11a9d 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -66,6 +66,15 @@ config FPGA_LATTICE
>           This is used for the lattice FPGAs. Please check the source code as
>           there is no documentation for this at present.
>
> +config FPGA_INTEL_PR
> +       bool "Enable Intel FPGA Partial Reconfiguration driver"
> +       depends on FPGA_ALTERA
> +       help
> +         Say Y here to enable the Intel FPGA Partial Reconfiguration driver
> +
> +         This provides basic functionality for partial reconfiguration which
> +         include the freeze controller support.
> +
>  config FPGA_XILINX
>         bool "Enable Xilinx FPGA drivers"
>         select FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 610c168fc3..70a8f88836 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -25,4 +25,5 @@ obj-$(CONFIG_FPGA_STRATIX_V) += stratixv.o
>  obj-$(CONFIG_FPGA_SOCFPGA) += socfpga.o
>  obj-$(CONFIG_TARGET_SOCFPGA_GEN5) += socfpga_gen5.o
>  obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += socfpga_arria10.o
> +obj-$(CONFIG_FPGA_INTEL_PR) += intel_pr.o
>  endif
> diff --git a/drivers/fpga/intel_pr.c b/drivers/fpga/intel_pr.c
> new file mode 100644
> index 0000000000..ecca2c9eeb
> --- /dev/null
> +++ b/drivers/fpga/intel_pr.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Intel Corporation
> + */
> +
> +#include <command.h>
> +#include <errno.h>
> +#include <wait_bit.h>
> +#include <asm/global_data.h>
> +#include <asm/io.h>
> +#include <linux/bitops.h>
> +#include <linux/libfdt.h>
> +#include <fdtdec.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#define FREEZE_CSR_STATUS_OFFSET               0
> +#define FREEZE_CSR_CTRL_OFFSET                 4
> +#define FREEZE_CSR_ILLEGAL_REQ_OFFSET          8
> +#define FREEZE_CSR_REG_VERSION                 12
> +
> +#define FREEZE_TIMEOUT                         20000
> +
> +#define FREEZE_CSR_STATUS_FREEZE_REQ_DONE      BIT(0)
> +#define FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE    BIT(1)
> +
> +#define FREEZE_CSR_CTRL_FREEZE_REQ             BIT(0)
> +#define FREEZE_CSR_CTRL_RESET_REQ              BIT(1)
> +#define FREEZE_CSR_CTRL_UNFREEZE_REQ           BIT(2)
> +
> +static int intel_get_freeze_br_addr(fdt_addr_t *addr, unsigned int region)
> +{
> +       int offset;
> +       char freeze_br[12];
> +       struct fdt_resource r;
> +       int ret;
> +
> +       snprintf(freeze_br, sizeof(freeze_br), "freeze_br%d", region);
> +
> +       const char *alias = fdt_get_alias(gd->fdt_blob, freeze_br);
> +
> +       if (!alias)     {
> +               printf("alias %s not found in dts\n", freeze_br);
> +               return -ENODEV;
> +       }
> +
> +       offset = fdt_path_offset(gd->fdt_blob, alias);
> +       if (offset < 0) {
> +               printf("%s not found in dts\n", alias);
> +               return -ENODEV;
> +       }
> +
> +       ret = fdt_get_resource(gd->fdt_blob, offset, "reg", 0, &r);
> +       if (ret) {
> +               printf("%s has no 'reg' property!\n", freeze_br);
> +               return ret;
> +       }
> +
> +       *addr = r.start;
> +
> +       return ret;
> +}
> +
> +static int intel_freeze_br_req_ack(fdt_addr_t addr, u32 req_ack)
> +{
> +       u32 status, illegal, ctrl;
> +       int ret = -ETIMEDOUT;
> +       unsigned long start = get_timer(0);
> +
> +       while (1) {
> +               illegal = readl(addr + FREEZE_CSR_ILLEGAL_REQ_OFFSET);
> +               if (illegal) {
> +                       printf("illegal request 0x%08x detected in freeze bridge\n", illegal);
> +
> +                       writel(illegal, addr + FREEZE_CSR_ILLEGAL_REQ_OFFSET);
> +
> +                       illegal = readl(addr + FREEZE_CSR_ILLEGAL_REQ_OFFSET);
> +                       if (illegal)
> +                               printf("illegal request 0x%08x detected in freeze bridge are not cleared\n",
> +                                      illegal);
> +
> +                       ret = -EINVAL;
> +                       break;
> +               }
> +
> +               status = readl(addr + FREEZE_CSR_STATUS_OFFSET);
> +               status &= req_ack;
> +               if (status) {
> +                       ctrl = readl(addr + FREEZE_CSR_CTRL_OFFSET);
> +                       printf("%s request %x acknowledged %x %x\n",
> +                              __func__, req_ack, status, ctrl);
> +
> +                       ret = 0;
> +                       break;
> +               }
> +
> +               if (get_timer(start) > FREEZE_TIMEOUT)
> +                       break;
> +
> +               udelay(1);
> +               schedule();
> +       }
> +
> +       return ret;
> +}
> +
> +static int intel_freeze_br_do_freeze(unsigned int region)
> +{
> +       u32 status;
> +       int ret;
> +       fdt_addr_t addr;
> +
> +       ret = intel_get_freeze_br_addr(&addr, region);
> +       if (ret)
> +               return ret;
> +
> +       status = readl(addr + FREEZE_CSR_STATUS_OFFSET);
> +
> +       if (status & FREEZE_CSR_STATUS_FREEZE_REQ_DONE)
> +               return 0;
> +       else if (!(status & FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE))
> +               return -EINVAL;
> +
> +       writel(FREEZE_CSR_CTRL_FREEZE_REQ, addr + FREEZE_CSR_CTRL_OFFSET);
> +
> +       ret = intel_freeze_br_req_ack(addr, FREEZE_CSR_STATUS_FREEZE_REQ_DONE);
> +       if (ret)
> +               writel(0, addr + FREEZE_CSR_CTRL_OFFSET);
> +       else
> +               writel(FREEZE_CSR_CTRL_RESET_REQ, addr + FREEZE_CSR_CTRL_OFFSET);
> +
> +       return ret;
> +}
> +
> +static int intel_freeze_br_do_unfreeze(unsigned int region)
> +{
> +       u32 status;
> +       int ret;
> +       fdt_addr_t addr;
> +
> +       ret = intel_get_freeze_br_addr(&addr, region);
> +       if (ret)
> +               return ret;
> +
> +       writel(0, addr + FREEZE_CSR_CTRL_OFFSET);
> +
> +       status = readl(addr + FREEZE_CSR_STATUS_OFFSET);
> +
> +       if (status & FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE)
> +               return 0;
> +       else if (!(status & FREEZE_CSR_STATUS_FREEZE_REQ_DONE))
> +               return -EINVAL;
> +
> +       writel(FREEZE_CSR_CTRL_UNFREEZE_REQ, addr + FREEZE_CSR_CTRL_OFFSET);
> +
> +       ret = intel_freeze_br_req_ack(addr, FREEZE_CSR_STATUS_UNFREEZE_REQ_DONE);
> +
> +       writel(0, addr + FREEZE_CSR_CTRL_OFFSET);
> +
> +       return ret;
> +}
> +
> +static int do_pr(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
> +{
> +       const char *cmd;
> +       char *region;
> +       unsigned int region_num = 0;
> +
> +       if (argc != 2 && argc != 3)
> +               return CMD_RET_USAGE;
> +
> +       cmd = argv[1];
> +       if (argc == 3)
> +               region_num = simple_strtoul(argv[2], &region, 0);
> +
> +       if (strcmp(cmd, "start") == 0)
> +               return intel_freeze_br_do_freeze(region_num);
> +       else if (strcmp(cmd, "end") == 0)
> +               return intel_freeze_br_do_unfreeze(region_num);
> +
> +       return CMD_RET_USAGE;
> +}
> +
> +U_BOOT_CMD(
> +       pr, 3, 1, do_pr,
> +       "SoCFPGA partial reconfiguration (pr) control",
> +       "start [region ID]\n"
> +       "       - start the pr by freezing the region\n"
> +       "end [region ID]\n"
> +       "       - end the pr by unfreezing the PR region\n"
> +);
> --
> 2.35.3
>

Regards,
Simon
