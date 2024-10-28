Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478FBD13570
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 10:25:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC39A8901F;
	Mon, 28 Oct 2024 11:24:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E871589058; Mon, 28 Oct 2024 11:24:53 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE3A788F4B
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 11:24:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 49SAOZYC073805
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 28 Oct 2024 18:24:35 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 18:24:36 +0800
Date: Mon, 28 Oct 2024 18:24:33 +0800
From: Leo Liang <ycliang@andestech.com>
To: Mayuresh Chitale <mchitale@ventanamicro.com>
CC: <u-boot@lists.denx.de>, Rick Chen <rick@andestech.com>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v2 1/2] riscv: Add support for defining instructions
Message-ID: <Zx9mYVyT_I371nTt@swlinux02>
References: <20240823094127.207866-1-mchitale@ventanamicro.com>
 <20240823094127.207866-2-mchitale@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240823094127.207866-2-mchitale@ventanamicro.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 49SAOZYC073805
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

Hi Mayuresh,

On Fri, Aug 23, 2024 at 09:41:25AM +0000, Mayuresh Chitale wrote:
> Add insn-def.h which is similar to that in linux and contains the macros
> to generate any instruction of type 'I' using the assembler's .insn
> directive.
> 
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> ---
>  arch/riscv/include/asm/insn-def.h | 42 +++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 arch/riscv/include/asm/insn-def.h
> 
> diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
> new file mode 100644
> index 0000000000..99ad5b8f6a
> --- /dev/null
> +++ b/arch/riscv/include/asm/insn-def.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2024 Ventana Micro Systems Ltd.
> + *
> + * Ported from linux insn-def.h.
> + */
> +
> +#ifndef _ASM_RISCV_BARRIER_H
> +#define _ASM_RISCV_BARRIER_H
> +
> +#define INSN_I_SIMM12_SHIFT		20
> +#define INSN_I_RS1_SHIFT		15
> +#define INSN_I_FUNC3_SHIFT		12
> +#define INSN_I_RD_SHIFT			 7
> +#define INSN_I_OPCODE_SHIFT		 0
> +
> +#define RV_OPCODE(v)		__ASM_STR(v)
> +#define RV_FUNC3(v)		__ASM_STR(v)
> +#define RV_FUNC7(v)		__ASM_STR(v)
> +#define RV_SIMM12(v)		__ASM_STR(v)
> +#define RV_RD(v)		__ASM_STR(v)
> +#define RV_RS1(v)		__ASM_STR(v)
> +#define RV_RS2(v)		__ASM_STR(v)
> +#define __RV_REG(v)		__ASM_STR(x ## v)
> +#define RV___RD(v)		__RV_REG(v)
> +#define RV___RS1(v)		__RV_REG(v)
> +#define RV___RS2(v)		__RV_REG(v)
> +
> +#define RV_OPCODE_MISC_MEM	RV_OPCODE(15)
> +#define RV_OPCODE_SYSTEM	RV_OPCODE(115)
> +
> +#define RV_OPCODE_MISC_MEM	RV_OPCODE(15)
> +#define RV_OPCODE_SYSTEM	RV_OPCODE(115)
These two lines are duplicated but I could fix this when merging the patch.

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> +
> +#define __INSN_I(opcode, func3, rd, rs1, simm12)	\
> +	".insn	i " opcode ", " func3 ", " rd ", " rs1 ", " simm12 "\n"
> +
> +#define INSN_I(opcode, func3, rd, rs1, simm12)			\
> +	__INSN_I(RV_##opcode, RV_##func3, RV_##rd,		\
> +		 RV_##rs1, RV_##simm12)
> +
> +#endif /* _ASM_RISCV_BARRIER_H */
