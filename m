Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD37ECE579
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 12:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C3DD88D99;
	Mon,  9 Sep 2024 14:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40E2388DCF; Mon,  9 Sep 2024 14:17:35 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C84388A9D
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 14:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 489CHGmH074610
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 9 Sep 2024 20:17:16 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 20:17:17 +0800
Date: Mon, 9 Sep 2024 20:17:15 +0800
From: Leo Liang <ycliang@andestech.com>
To: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
CC: <rick@andestech.com>, <trini@konsulko.com>, <ryan_chen@aspeedtech.com>,
 <joel@jms.id.au>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 4/8] riscv: Add AST2700 SoC initial platform support
Message-ID: <Zt7nSz9oUJiPiFrx@swlinux02>
References: <20240819101704.1612317-1-chiawei_wang@aspeedtech.com>
 <20240819101704.1612317-5-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240819101704.1612317-5-chiawei_wang@aspeedtech.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 489CHGmH074610
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

On Mon, Aug 19, 2024 at 06:17:00PM +0800, Chia-Wei Wang wrote:
> AST2700 SoCs integrates a Ibex 32-bits RISC-V core as the boot MCU
> for the first stage bootloader execution, namely SPL.
> 
> This patch implements the preliminary base to successfully run SPL
> on this RV32-based MCU to the console banner message.
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  arch/riscv/Kconfig                        |   5 +
>  arch/riscv/cpu/ast2700/Kconfig            |   6 +
>  arch/riscv/cpu/ast2700/Makefile           |   1 +
>  arch/riscv/cpu/ast2700/cpu.c              |  23 ++++
>  arch/riscv/dts/Makefile                   |   1 +
>  arch/riscv/dts/ast2700-ibex.dts           |  22 ++++
>  arch/riscv/dts/ast2700-u-boot.dtsi        |  40 ++++++
>  arch/riscv/dts/ast2700.dtsi               |  76 ++++++++++++
>  arch/riscv/include/asm/arch-ast2700/scu.h | 145 ++++++++++++++++++++++
>  arch/riscv/include/asm/arch-ast2700/sli.h |  82 ++++++++++++
>  board/aspeed/ibex_ast2700/Kconfig         |  21 ++++
>  board/aspeed/ibex_ast2700/MAINTAINERS     |   7 ++
>  board/aspeed/ibex_ast2700/Makefile        |   2 +
>  board/aspeed/ibex_ast2700/ibex_ast2700.c  |  85 +++++++++++++
>  board/aspeed/ibex_ast2700/sli.c           |  72 +++++++++++
>  configs/ibex-ast2700_defconfig            |  92 ++++++++++++++
>  include/configs/ibex_ast2700.h            |  12 ++
>  17 files changed, 692 insertions(+)
>  create mode 100644 arch/riscv/cpu/ast2700/Kconfig
>  create mode 100644 arch/riscv/cpu/ast2700/Makefile
>  create mode 100644 arch/riscv/cpu/ast2700/cpu.c
>  create mode 100644 arch/riscv/dts/ast2700-ibex.dts
>  create mode 100644 arch/riscv/dts/ast2700-u-boot.dtsi
>  create mode 100644 arch/riscv/dts/ast2700.dtsi
>  create mode 100644 arch/riscv/include/asm/arch-ast2700/scu.h
>  create mode 100644 arch/riscv/include/asm/arch-ast2700/sli.h
>  create mode 100644 board/aspeed/ibex_ast2700/Kconfig
>  create mode 100644 board/aspeed/ibex_ast2700/MAINTAINERS
>  create mode 100644 board/aspeed/ibex_ast2700/Makefile
>  create mode 100644 board/aspeed/ibex_ast2700/ibex_ast2700.c
>  create mode 100644 board/aspeed/ibex_ast2700/sli.c
>  create mode 100644 configs/ibex-ast2700_defconfig
>  create mode 100644 include/configs/ibex_ast2700.h

Hi Chia-Wei,

Could you also provide proper document under ${u-boot}/doc/board regarding 
how to build and run U-boot-SPL on AST2700?

Other than that, LGTM.

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>

Best regards,
Leo
