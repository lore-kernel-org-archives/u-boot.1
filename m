Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2C5ECE57A
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 12:23:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1481288DE2;
	Mon,  9 Sep 2024 14:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7183688DE4; Mon,  9 Sep 2024 14:23:12 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 897AC88A9D
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 14:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 489CMrQs076994
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 9 Sep 2024 20:22:53 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 20:22:55 +0800
Date: Mon, 9 Sep 2024 20:22:53 +0800
From: Leo Liang <ycliang@andestech.com>
To: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
CC: <rick@andestech.com>, <trini@konsulko.com>, <ryan_chen@aspeedtech.com>,
 <joel@jms.id.au>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 7/8] ram: ast2700: Add DRAM controller initialization
Message-ID: <Zt7onaB3StI_jdge@swlinux02>
References: <20240819101704.1612317-1-chiawei_wang@aspeedtech.com>
 <20240819101704.1612317-8-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240819101704.1612317-8-chiawei_wang@aspeedtech.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 489CMrQs076994
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

On Mon, Aug 19, 2024 at 06:17:03PM +0800, Chia-Wei Wang wrote:
> Add driver for AST2700 to initialize DRAM in SPL.
> 
> This patch also refactors the Kconfig dependency of
> Aspeed DRAM drivers as some of them are shared among
> the file structures of RV and ARM ISAs.
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  This patch has many checkpatch.pl warning due to the two
>  vendor-provided sources for DDR PHY initialization.
> 
>  Most of the warnings are about the camel case coding style
>  and line length checks.
> 
>  If possible, we wish to keep it as is for better vendor
>  support in case debugging is needed.
> 
>  arch/riscv/include/asm/arch-ast2700/sdram.h   |  137 +
>  drivers/ram/Makefile                          |    2 +-
>  drivers/ram/aspeed/Kconfig                    |   27 +-
>  drivers/ram/aspeed/Makefile                   |    1 +
>  ..._ddrphy_phyinit_ddr4-3200-nodimm-train2D.c | 2700 +++++++
>  ..._ddrphy_phyinit_ddr5-3200-nodimm-train2D.c | 6930 +++++++++++++++++
>  drivers/ram/aspeed/sdram_ast2700.c            | 1036 +++
>  7 files changed, 10828 insertions(+), 5 deletions(-)
>  create mode 100644 arch/riscv/include/asm/arch-ast2700/sdram.h
>  create mode 100644 drivers/ram/aspeed/dwc_ddrphy_phyinit_ddr4-3200-nodimm-train2D.c
>  create mode 100644 drivers/ram/aspeed/dwc_ddrphy_phyinit_ddr5-3200-nodimm-train2D.c
>  create mode 100644 drivers/ram/aspeed/sdram_ast2700.c

Acked-by: Leo Yu-Chi Liang <ycliang@andestech.com>
