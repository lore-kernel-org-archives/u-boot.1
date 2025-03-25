Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51D0C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 10:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F5A6808AF;
	Tue, 25 Mar 2025 11:10:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 869CC810E8; Tue, 25 Mar 2025 11:10:17 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5205480107
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 11:10:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 52PA911K066633
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Tue, 25 Mar 2025 18:09:01 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 18:09:01 +0800
Date: Tue, 25 Mar 2025 18:08:59 +0800
From: Leo Liang <ycliang@andestech.com>
To: Yao Zi <ziyao@disroot.org>
CC: Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>, Bin Meng
 <bmeng.cn@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, "Palmer
 Dabbelt" <palmer@dabbelt.com>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 Green Wan <green.wan@sifive.com>, Minda Chen <minda.chen@starfivetech.com>,
 Simon Glass <sjg@chromium.org>, "Angelo
 Dureghello" <angelo@kernel-space.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 1/4] riscv: lib: Add a default implementation of
 board_fdt_blob_setup
Message-ID: <Z-KAu-8n7_mkA7vB@swlinux02>
References: <20250307131344.43762-1-ziyao@disroot.org>
 <20250307131344.43762-2-ziyao@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250307131344.43762-2-ziyao@disroot.org>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 52PA911K066633
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

Hi Yao,

On Fri, Mar 07, 2025 at 01:13:41PM +0000, Yao Zi wrote:
> It's common for S-Mode proper U-Boot to retrieve a FDT blob along with
> taking control from SBI firmware. Add a weak version of
> board_fdt_blob_setup to make use of it by default, avoiding copy-pasting
> similar functions among boards.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> ---
>  arch/riscv/lib/Makefile |  1 +
>  arch/riscv/lib/board.c  | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
>  create mode 100644 arch/riscv/lib/board.c
> 
> diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
> index 268116f3757..b33f9c646dd 100644
> --- a/arch/riscv/lib/Makefile
> +++ b/arch/riscv/lib/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_$(XPL_)SMP) += smp.o
>  obj-$(CONFIG_XPL_BUILD)	+= spl.o
>  obj-y   += fdt_fixup.o
>  obj-$(CONFIG_$(SPL)CMD_BDI) += bdinfo.o
> +obj-$(CONFIG_OF_BOARD) += board.o
>  
>  # For building EFI apps
>  CFLAGS_NON_EFI := -fstack-protector-strong
> diff --git a/arch/riscv/lib/board.c b/arch/riscv/lib/board.c
> new file mode 100644
> index 00000000000..1630355b2b1
> --- /dev/null
> +++ b/arch/riscv/lib/board.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * RISC-V-specific handling of firmware FDT
> + */
> +
> +#include <asm/global_data.h>
> +#include <linux/errno.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +__weak int board_fdt_blob_setup(void **fdtp)
> +{
> +	if (IS_ENABLED(CONFIG_XPL_BUILD) || !gd->arch.firmware_fdt_addr)
> +		return -EEXIST;

We don't need this check "CONFIG_XPL_BUILD", do we?
We do need this setup function for SPL and adding this would fail CI test.

> +
> +	*fdtp = (void *)gd->arch.firmware_fdt_addr;

We should add proper casting to suppress compile warning for 32 bit.

Best regards,
Leo
> +
> +	return 0;
> +}
