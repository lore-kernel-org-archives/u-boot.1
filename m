Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47329CD4F4C
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 06:41:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1A4888C73;
	Mon,  9 Sep 2024 08:41:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09FDD88CE8; Mon,  9 Sep 2024 08:41:04 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E697C88C70
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 08:41:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 4896eNOK099774
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 9 Sep 2024 14:40:23 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 14:40:24 +0800
Date: Mon, 9 Sep 2024 14:40:21 +0800
From: Leo Liang <ycliang@andestech.com>
To: Kongyang Liu <seashell11234455@gmail.com>
CC: <u-boot@lists.denx.de>, Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng
 <bmeng@tinylab.org>, Dan Carpenter <dan.carpenter@linaro.org>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@microchip.com>, Randolph
 <randolph@andestech.com>, Rick Chen <rick@andestech.com>, Samuel Holland
 <samuel@sholland.org>, Tom Rini <trini@konsulko.com>, Yu Chien Peter Lin
 <peterlin@andestech.com>
Subject: Re: [PATCH v2 1/2] riscv: spacemit: bananapi_f3: initial support added
Message-ID: <Zt6YVTOmkKUI-RE1@swlinux02>
References: <20240718043329.1500-1-seashell11234455@gmail.com>
 <20240718043329.1500-2-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240718043329.1500-2-seashell11234455@gmail.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4896eNOK099774
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

On Thu, Jul 18, 2024 at 12:33:22PM +0800, Kongyang Liu wrote:
> Add basic support for SpacemiT's Banana Pi F3 board
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> ---
> 
> Changes in v2:
> - Change license to GPL-2.0-or-later
> - Add memory node for dts
> - Add ft_board_setup function for kernel memory init
> - Use default prompt
> 
>  arch/riscv/Kconfig                     |   5 +
>  arch/riscv/cpu/k1/Kconfig              |  18 ++
>  arch/riscv/cpu/k1/Makefile             |   6 +
>  arch/riscv/cpu/k1/cpu.c                |   9 +
>  arch/riscv/cpu/k1/dram.c               |  54 ++++
>  arch/riscv/dts/Makefile                |   1 +
>  arch/riscv/dts/k1-bananapi-f3.dts      |  25 ++
>  arch/riscv/dts/k1.dtsi                 | 375 +++++++++++++++++++++++++
>  board/spacemit/bananapi_f3/Kconfig     |  25 ++
>  board/spacemit/bananapi_f3/MAINTAINERS |   6 +
>  board/spacemit/bananapi_f3/Makefile    |   5 +
>  board/spacemit/bananapi_f3/board.c     |   9 +
>  configs/bananapi_f3_defconfig          |  20 ++
>  include/configs/bananapi_f3.h          |  15 +
>  14 files changed, 573 insertions(+)
>  create mode 100644 arch/riscv/cpu/k1/Kconfig
>  create mode 100644 arch/riscv/cpu/k1/Makefile
>  create mode 100644 arch/riscv/cpu/k1/cpu.c
>  create mode 100644 arch/riscv/cpu/k1/dram.c
>  create mode 100644 arch/riscv/dts/k1-bananapi-f3.dts
>  create mode 100644 arch/riscv/dts/k1.dtsi
>  create mode 100644 board/spacemit/bananapi_f3/Kconfig
>  create mode 100644 board/spacemit/bananapi_f3/MAINTAINERS
>  create mode 100644 board/spacemit/bananapi_f3/Makefile
>  create mode 100644 board/spacemit/bananapi_f3/board.c
>  create mode 100644 configs/bananapi_f3_defconfig
>  create mode 100644 include/configs/bananapi_f3.h

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
