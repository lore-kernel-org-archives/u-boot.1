Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99DFC47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 12:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB1D987885;
	Thu, 11 Jan 2024 13:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LbaqlaEB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4AD487A77; Thu, 11 Jan 2024 13:15:53 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DB8786406
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 13:15:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5807BCE1FB5;
 Thu, 11 Jan 2024 12:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165DAC433F1;
 Thu, 11 Jan 2024 12:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704975346;
 bh=qdt6ULksvDOW01uUQNUXsePF3Manpf8PbugML2vTFU8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=LbaqlaEBGrCswQ5UvYTySYSz/9BOMUP/5cSno2oJX9u2TCTqqpE9Lfi1vN/nn07xR
 423TSPX2vtp1/sww1uMQRZf+gpG6VK+GYjtPXl9U7PqpQUxuKEvlS5MceS28x1U3VG
 EZcMDXmRXGj4DrAsusyOxNU15Nd+LroVLduPbeGjoBa3o2kaOlllpZ3+Dks2zrVuU/
 HQPr+Zq3WipBPi2+vsFmUO3Wpa/rxmVfelLoUZFNvKUZTTD5bdbTGmovks8Ea7MDuJ
 pUEo8juEGkvMBrCnOWJqQp+51Fi64rJKyuo68efFVpGKaYjvSLNhRRv6Yl6jf4b4zY
 NDvrAx9WEhflw==
Message-ID: <1ed784d2-cdd9-40f5-8569-232906fd1c82@kernel.org>
Date: Thu, 11 Jan 2024 14:15:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] arm: mach-k3: am64: Add NAND configuration
To: Nishanth Menon <nm@ti.com>
Cc: trini@konsulko.com, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com, afd@ti.com, vigneshr@ti.com,
 praneeth@ti.com, srk@ti.com, r-gunasekaran@ti.com, u-boot@lists.denx.de
References: <20240109122605.51951-1-rogerq@kernel.org>
 <20240109191722.wkd2px7mveylz6ue@cautious>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240109191722.wkd2px7mveylz6ue@cautious>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 09/01/2024 21:17, Nishanth Menon wrote:
> On 14:26-20240109, Roger Quadros wrote:
>> Hi,
>>
>> AM64-EVM [1] supports NAND via expansion card.
>>
>> This series fixes the GPMC memory and NAND drivers
>> and provides NAND configuration for AM642 platform.
>>
>> The extension card support and NAND DT overlay is
>> still missing so NAND is not yet functional just with
>> this series.
>>
>> It was tested with NAND overlay [2] manually applied to base
>> AM64-EVM DT.
>>
>> CI test results are available at
>> https://github.com/u-boot/u-boot/pull/460
>>
>> [1] https://www.ti.com/tool/TMDS64EVM
>> [2] https://lore.kernel.org/all/20230923080046.5373-2-rogerq@kernel.org/
>>
>> Roger Quadros (4):
>>   memory: ti-gpmc: Fix build
>>   mtd: rawnand: omap_gpmc: Use DT provided IO address
>>   arm: mach-k3: am642: Define NAND boot device
>>   configs: am64x_evm_a53_defconfig: Enable NAND
>>
>>  arch/arm/mach-k3/am642_init.c            |  3 +++
>>  arch/arm/mach-k3/include/mach/am64_spl.h |  1 +
>>  configs/am64x_evm_a53_defconfig          | 32 ++++++++++++++++++++++++
>>  drivers/memory/ti-gpmc.c                 |  2 +-
>>  drivers/mtd/nand/raw/omap_gpmc.c         | 19 ++++++++++----
>>  5 files changed, 51 insertions(+), 6 deletions(-)
> 
> Please update am64x documentation as well. People will need to know
> how to actually build, flash and use it.

As NAND is not yet functional till we implement the extension card
support and add the NAND overlay. I'll limit this series to platform
& driver fixes and leave the defconfig and documentation
out for now.

> 
>>
>>
>> base-commit: c2c598e87cfe56f5991730762c00733c5aa9a994
>> prerequisite-patch-id: e0465f3e924302d1c4bd47f2129b4eb3bd9faead
>> -- 
>> 2.34.1
>>
> 

-- 
cheers,
-roger
