Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E8DC52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 04:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9472988901;
	Tue, 13 Aug 2024 06:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723523145;
	bh=NuGxSIV1mHXFoU2eSLyelLaleqcjfcGaiJE9umpYDao=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=KPxsj3j1SxuweTdqAWvY91a0salkJpo5VhFzqmedbX0gAqAg8T6WiZk5d+XupwGl1
	 YZb+7L5B+LeLraDnVNSBTBNAIiG+H/zyF4eRBrtZzGdzdkxI+0CA52/MjI7tiRirqp
	 F+Q8qOVFf4vubLm7CKYs9dDfU1q5GEycn8MZYocLKJGfTQIcctZXKjbnSTipZ6hosW
	 C88flVpTfK4M7slANhzp4qbi93DRi+olzJfFEnDeYRbNcBr6ZYIyRLxetrM2C+KbBi
	 VP/jpppuKJJeqzrwvd3IeJ+H9QOcHWUPHj0tNtIdkd/2AqGSSvDA4uFoSCv4UbNSOo
	 7HWW1vBi7g2yA==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id F2A99886A7;
 Tue, 13 Aug 2024 06:25:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723523144;
 bh=NuGxSIV1mHXFoU2eSLyelLaleqcjfcGaiJE9umpYDao=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=ujL7NMRkNrKIBHld2lrL+lcEMtqo/cVzmr+Y8otaHAiCQqNl5kAluAQyE+1x+V3q7
 J5CP1judFctd+Zm9Q6Vx7IUKNFtaUYNpT8YtcFYG2fFhox1cWIWK9KUm8HpPAlWYhD
 uCXN70uFZt9hhP17wZLzcxXTiY7lud+wPlU3ByTELgosqyoE1/AzJb4m1yJoJHw3H7
 7lQgSG8Mr6TtE44uOemQ8ACvcTg9zxRnq4e+l8/7qRKXMIp69VVCYk7SvMp+NWlXzP
 kMwoTYI0VCMVYYJSSUVWI9JeXYr3mTg/WLqMqipTnMPPU0qhk7vj/gmy2V9gg5Du0d
 VO2TqSLsdq8QA==
Message-ID: <f6221c9c-8e19-ac58-e09c-5a04d45cabf9@denx.de>
Date: Tue, 13 Aug 2024 06:24:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 00/18] i2c: Chip away at some old code
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
References: <20240811145047.4189460-1-sjg@chromium.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240811145047.4189460-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Simon,

On 11.08.24 16:50, Simon Glass wrote:
> This series aims to remove some of the older contents of i2c.h so that
> we can move towards having just the dm API.
> 
> It does not remove any boards, but instead removes functionality.
> 
> Changes in v2:
> - Drop omap3_beagle.h change as that board was removed
> - Leave pg_wcom alone as its boards were converted
> - Drop patch "pg-wcom: Drop CFG_SYS_I2C_MAX_HOPS"
> 
> Simon Glass (18):
>    i2c: Remove board_i2c_init()
>    i2c: Remove IC2_xxx enum
>    i2c: Remove CFG_I2C_MULTI_BUS
>    mips: malta: Drop CMD_DATE
>    armv8: ls2085a: Drop CMD_DATE
>    mx28 / mx51: Drop CMD_DATE
>    MPC837XERDB: ethernut5: work_92105: Drop CMD_DATE
>    rtc: Drop CFG_SYS_RTC_BUS_NUM
>    date: Drop the legacy I2C code
>    fsl: mxc: Drop legacy I2c
>    i2c: Drop reference to SYS_I2C_INIT_BOARD
>    octeon: Drop OCTEON_I2C_FDT dead code
>    i2c: Remove I2C_SET_BUS()
>    i2c: Remove I2C_GET_BUS()
>    i2c: Drop CFG_SYS_MAX_I2C_BUS
>    i2c: Drop i2c_get_bus_num_fdt() and i2c_reset_port_fdt()
>    i2c: Remove CFG_SYS_I2C_MAX_HOPS
>    i2c: Remove CFG_SYS_I2C_DIRECT_BUS
> 
>   README                             |  27 +-----
>   arch/mips/mach-octeon/octeon_fdt.c |   7 --
>   cmd/date.c                         |  32 -------
>   cmd/i2c.c                          |  23 -----
>   configs/MPC837XERDB_defconfig      |   1 -
>   configs/ethernut5_defconfig        |   1 -
>   configs/ls2080aqds_nand_defconfig  |   1 -
>   configs/ls2080aqds_qspi_defconfig  |   1 -
>   configs/ls2080ardb_nand_defconfig  |   1 -
>   configs/malta64_defconfig          |   1 -
>   configs/malta64el_defconfig        |   1 -
>   configs/malta_defconfig            |   1 -
>   configs/maltael_defconfig          |   1 -
>   configs/mx28evk_defconfig          |   1 -
>   configs/mx51evk_defconfig          |   1 -
>   configs/work_92105_defconfig       |   1 -
>   doc/I2C_Edge_Conditions            |  10 +-
>   drivers/ddr/fsl/main.c             |   3 +-
>   drivers/i2c/i2c_core.c             | 141 -----------------------------
>   drivers/i2c/mxc_i2c.c              |   1 +
>   drivers/i2c/soft_i2c.c             |  11 ---
>   drivers/power/power_i2c.c          |   5 -
>   drivers/usb/host/ohci-lpc32xx.c    |   4 -
>   include/configs/ethernut5.h        |   3 -
>   include/configs/ls1028aqds.h       |   1 -
>   include/configs/ls1028ardb.h       |   2 -
>   include/configs/ls1046afrwy.h      |   1 -
>   include/configs/lx2160aqds.h       |   3 -
>   include/configs/lx2160ardb.h       |   3 -
>   include/configs/lx2162aqds.h       |   3 -
>   include/configs/m53menlo.h         |   2 -
>   include/configs/sniper.h           |  14 ---
>   include/configs/tqma6.h            |   3 -
>   include/configs/tqma6_wru4.h       |   1 -
>   include/i2c.h                      | 107 ----------------------
>   35 files changed, 7 insertions(+), 412 deletions(-)
> 

Many thanks for this work. Applied them locally base on origin/next
and started azure build:

https://dev.azure.com/hs0298/hs/_build/results?buildId=122&view=results

If all is fine, I sent pull request to Tom.

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
