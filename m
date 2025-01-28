Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5292BC0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 12:57:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C491A81DB4;
	Tue, 28 Jan 2025 13:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738069034;
	bh=lwP+rNhHnktOJGWfoPXZgx9RkKVjzy7IzuLTJRF7adQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xwftcb/Py3vmlmOua3Jc/EAY2jrZxVxt58N2ZJN4qDLxGaiJNrs20ajGSSzrmj4/Q
	 Oqc4ZwMnyt8HHkL2TNH9RV+s2OQdb0l4nqlj4Uv9Zhtquyfs0umw216MEt55bQnnXS
	 bb2EmD8aeu2vpqgYv0McGiXiq5tYt7Xa/ZepDOxQ4zgwJB3uObLKkXqyhbfy2BPLjs
	 Nk5r+21VeZ0cy7EUzqWtPc5ZuTQsm6QTq7lMrHIGHoFvy8rC7o5iPNrl3HjB2JJ3t2
	 Rn8jbEC2LJcZmoXSCUacjK5p+i5f26lnC3TnnguAdDuVzlESNjSO8D1T6XmATW4ffE
	 XcXQEFsCmZ8OQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74A2881DCD; Tue, 28 Jan 2025 13:57:13 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 410E381951
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 13:57:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Yj50N51pTz9tBc;
 Tue, 28 Jan 2025 13:57:08 +0100 (CET)
Message-ID: <2635bb5b-f63c-44cc-87bf-d82ff8d520ec@denx.de>
Date: Tue, 28 Jan 2025 13:57:07 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/3] Initial support for PXA1908 and
 samsung-coreprimevelte
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Tom Rini <trini@konsulko.com>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht,
 u-boot@lists.denx.de
References: <20250124-coreprimevelte-v3-0-870dd251b1d1@skole.hr>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250124-coreprimevelte-v3-0-870dd251b1d1@skole.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 24.01.25 16:47, Duje Mihanović wrote:
> Hello,
> 
> This series adds initial support for Marvell's PXA1908 ARM64 SoC and
> Samsung's Galaxy Core Prime VE LTE, a smartphone based on said SoC.
> 
> On this board, U-Boot is used as a secondary bootloader to work around
> certain quirks of the factory S-Boot.
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> ---
> Changes in v3:
> - Rebase on WIP/24Jan2025 and fix board_fdt_blob_setup() compile error it introduces
> - Link to v2: https://lore.kernel.org/r/20241231-coreprimevelte-v2-0-6a5445d92d11@skole.hr
> 
> Changes in v2:
> - Drop arm,armv8 compatible from CPU nodes to match upstream
> - Add intel,xscale-uart compatible to NS16550 and use it in serial nodes to match upstream
> - Add include guards to include/configs/pxa1908.h
> - Disable CONFIG_DISPLAY_CPUINFO and CONFIG_CPU
> - Rebase on v2025.01-rc5
> - Link to v1: https://lore.kernel.org/r/20241227-coreprimevelte-v1-0-ac8243eee4e6@skole.hr
> 
> ---
> Duje Mihanović (3):
>        serial: ns16550: Add Intel XScale support
>        arm: mmp: add initial support for PXA1908 SoC
>        board: samsung: add initial support for coreprimevelte board
> 
>   MAINTAINERS                                     |   8 ++
>   arch/arm/Kconfig                                |  11 +++
>   arch/arm/Makefile                               |   1 +
>   arch/arm/dts/Makefile                           |   2 +
>   arch/arm/dts/pxa1908-samsung-coreprimevelte.dts |  74 +++++++++++++++++
>   arch/arm/dts/pxa1908.dtsi                       | 106 ++++++++++++++++++++++++
>   arch/arm/mach-mmp/Kconfig                       |  12 +++
>   arch/arm/mach-mmp/Makefile                      |   1 +
>   arch/arm/mach-mmp/board.c                       |  84 +++++++++++++++++++
>   arch/arm/mach-mmp/mmu.c                         |  30 +++++++
>   board/samsung/coreprimevelte/Kconfig            |  12 +++
>   board/samsung/coreprimevelte/MAINTAINERS        |   6 ++
>   configs/coreprimevelte_defconfig                |  18 ++++
>   drivers/serial/ns16550.c                        |   1 +
>   include/configs/pxa1908.h                       |  18 ++++
>   15 files changed, 384 insertions(+)

Applied to u-boot-marvell/master

Thanks,
Stefan

