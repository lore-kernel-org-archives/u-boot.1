Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A058E7E0CD
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 11:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2240E83BDD;
	Mon,  9 Feb 2026 12:25:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9DD983C30; Mon,  9 Feb 2026 12:25:24 +0100 (CET)
Received: from Atcsqr.andestech.com (unknown [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 599068341A
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 12:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 619BP8nZ049148;
 Mon, 9 Feb 2026 19:25:08 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Feb
 2026 19:25:08 +0800
Date: Mon, 9 Feb 2026 19:25:05 +0800
From: Leo Liang <ycliang@andestech.com>
To: Uros Stajic <uros.stajic@htecgroup.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu <cfu@mips.com>
Subject: Re: [PATCH v5 2/8] board: boston-riscv: Add initial support for
 P8700 Boston board
Message-ID: <aYnEEbd8JBY91dCI@swlinux02>
References: <20251224154449.946780-1-uros.stajic@htecgroup.com>
 <20251224154449.946780-3-uros.stajic@htecgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251224154449.946780-3-uros.stajic@htecgroup.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 619BP8nZ049148
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

On Wed, Dec 24, 2025 at 03:45:47PM +0000, Uros Stajic wrote:
> From: Chao-ying Fu <cfu@mips.com>
> 
> Implement initial board-level support for the P8700 Boston SoC.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
> ---
>  arch/riscv/Kconfig                      |  11 +
>  arch/riscv/dts/Makefile                 |   1 +
>  arch/riscv/dts/boston-p8700.dts         | 264 ++++++++++++++++++++++++
>  board/mips/boston-riscv/Kconfig         |  43 ++++
>  board/mips/boston-riscv/MAINTAINERS     |   9 +
>  board/mips/boston-riscv/Makefile        |   8 +
>  board/mips/boston-riscv/boston-lcd.h    |  20 ++
>  board/mips/boston-riscv/boston-regs.h   |  38 ++++
>  board/mips/boston-riscv/boston-riscv.c  |  30 +++
>  board/mips/boston-riscv/checkboard.c    |  43 ++++
>  board/mips/boston-riscv/config.mk       |  15 ++
>  board/mips/boston-riscv/lowlevel_init.S |  18 ++
>  board/mips/boston-riscv/reset.c         |  15 ++
>  configs/boston-p8700_defconfig          |  98 +++++++++
>  drivers/clk/Kconfig                     |   2 +-
>  include/configs/boston-riscv.h          |   9 +
>  16 files changed, 623 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/dts/boston-p8700.dts
>  create mode 100644 board/mips/boston-riscv/Kconfig
>  create mode 100644 board/mips/boston-riscv/MAINTAINERS
>  create mode 100644 board/mips/boston-riscv/Makefile
>  create mode 100644 board/mips/boston-riscv/boston-lcd.h
>  create mode 100644 board/mips/boston-riscv/boston-regs.h
>  create mode 100644 board/mips/boston-riscv/boston-riscv.c
>  create mode 100644 board/mips/boston-riscv/checkboard.c
>  create mode 100644 board/mips/boston-riscv/config.mk
>  create mode 100644 board/mips/boston-riscv/lowlevel_init.S
>  create mode 100644 board/mips/boston-riscv/reset.c
>  create mode 100644 configs/boston-p8700_defconfig
>  create mode 100644 include/configs/boston-riscv.h

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
