Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099CFC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 17:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B44D87A0A;
	Tue,  9 Jan 2024 18:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UnP7pq6H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC7D187A30; Tue,  9 Jan 2024 18:32:50 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AB0987942
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 18:32:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 409HWewL028311;
 Tue, 9 Jan 2024 11:32:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704821560;
 bh=9KHVgaEiK/7AMGhkz2PEdyTsivFAQkTb1GtdE98Ea2c=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=UnP7pq6HhhJsu9rSDF4Ef6ClmtRCeVvFDkEQCDe8IncZRW07HauzejGIV0+amO7MA
 Y7OdHESXk4xSeEny51RAoJj8U5+35JQgfLsdZl25/L2PELrcptsw42Dnx/6SMxodBd
 Dnl4laZYI+BWD392wcUyB0xvYuggxrJdsvPAgwi4=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 409HWeXV002942
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Jan 2024 11:32:40 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jan 2024 11:32:40 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jan 2024 11:32:40 -0600
Received: from [10.249.40.136] ([10.249.40.136])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 409HWd0k068623;
 Tue, 9 Jan 2024 11:32:39 -0600
Message-ID: <8a2970aa-7c4b-41f4-9eeb-c43e2c5da285@ti.com>
Date: Tue, 9 Jan 2024 11:32:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Suspend to RAM support for K3 J7200
Content-Language: en-US
To: Thomas Richard <thomas.richard@bootlin.com>, <u-boot@lists.denx.de>
CC: <thomas.petazzoni@bootlin.com>, <nm@ti.com>, <u-kumar1@ti.com>,
 <gregory.clement@bootlin.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Gowtham Tammana <g-tammana@ti.com>, "Manorit Chawdhry" <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, "Simon
 Glass" <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20240108165628.3935756-1-thomas.richard@bootlin.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240108165628.3935756-1-thomas.richard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 1/8/24 10:56 AM, Thomas Richard wrote:
> This series is the U-Boot part of the work to add the suspend to RAM
> support for the K3 J7200 EVM board.
> 
> During the boot R5 SPL makes a copy of DM-Firmware and TF-A in memory.
> Resume detection is done by reading a magic value in a pmic register
> (set by DM-Firmware).
> 
> If a resume is detected, R5 SPL run the exit retention sequence of the
> DDR. Then it load TF-A and DM-Firmware using the copies done during the boot
> (fit image processing is skipped).
> Before to start TF-A, R5 SPL writes a magic value in scratchpad ram. This
> will be used by TF-A to detect that the board is resuming.
> 
> The copy of TF-A/DM-Firmware, the SPL stack and malloc are located in a
> reserved memory region (for the kernel point of view) to avoid any
> memory corruption.
> 
> This version is mostly to test the firewall protection with the suspend
> to ram.

Seems to show the opposite, if you are able to access and load TF-A
back to its spot after resume from un-trusted SPL then the firewall
did not survive suspend to RAM. That is a huge security gap if TIFS
is forgetting to put back the firewalls on resume.. What is the
point of firewalls on these systems if I can just knock them all
out by doing a simple suspend/resume cycle?

> Some comments (for the v2) were not fixed in this version.

Why not?

> This series has been tested with the series [1] to enable the firewall.
> At the end of the resume sequence, TF-A is well protected by the
> firewall, but OP-TEE remains unprotected.
> 

Then why post this? If it is just to get some eyes on it, then label
it as an "RFC" so our silence isn't considered acceptance, otherwise we
have to manually NAK these each time.

Andrew

> [1] https://lore.kernel.org/all/20231229-binman-firewalling-v7-0-47ed4af303fe@ti.com/
> 
> 
> Changes in v3:
> - At resume, R5 SPL doesn't restore TF-A anymore.
>    TF-A is started like during a cold boot. R5 SPL will notify that the board is
>    resuming using a magic value written in the scratchpad ram.
>    TF-A will restore itself.
> - Link to v2:
>    https://lore.kernel.org/u-boot/20231107161802.855154-1-thomas.richard@bootlin.com/
> 
> Changes in v2:
> - Set exit retention code for DDR behind CONFIG_K3_J721E_DDRSS
> - Check if TF-A is running in DRAM, if yes no need to restore it
> - Remove BL31_START macro, and get TF-A start address from the fit image
> - Remove the test_enter_suspend command
> - Link to v1:
>    https://lore.kernel.org/u-boot/20231016141135.325698-1-thomas.richard@bootlin.com/
> 
> Gowtham Tammana (1):
>    DO NOT MERGE: arm: dts: k3-j7200-r5-common: Add pmic node for esm
> 
> Gregory CLEMENT (2):
>    configs: j7200_evm_r5: Used reserved memory in DDR for stack
>    configs: j7200_evm_r5: Move address used for allocation in the
>      reserved space
> 
> Thomas Richard (5):
>    board: ti: j721e: Add resume detection for J7200
>    ram: k3-ddrss: Add exit retention support
>    board: ti: j721e: Add the missing part of exit retention for k3-ddrss
>      (J7200)
>    board: ti: j721e: During resume spl notify tf-a that the board is
>      resuming
>    arm: mach-k3: j7200: Skip fit processing when resuming
> 
>   .../arm/dts/k3-j7200-r5-common-proc-board.dts |  17 +-
>   arch/arm/mach-k3/common.c                     |  65 +++-
>   .../arm/mach-k3/include/mach/j721e_hardware.h |   1 +
>   arch/arm/mach-k3/include/mach/j721e_spl.h     |  30 ++
>   arch/arm/mach-k3/sysfw-loader.c               |  16 +-
>   board/ti/j721e/evm.c                          |  77 +++++
>   configs/j7200_evm_r5_defconfig                |   4 +-
>   drivers/ram/k3-ddrss/k3-ddrss.c               | 307 ++++++++++++++++++
>   8 files changed, 507 insertions(+), 10 deletions(-)
> 
