Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7511CC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 12:25:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDF8187C26;
	Tue, 30 Jan 2024 13:25:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="P9RsP6BH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 452A787B05; Tue, 30 Jan 2024 13:25:18 +0100 (CET)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2841187C26
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 13:25:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hOo8FVbtHrpZVwnJAg+p1IedLHI+Xv+CFa1yCqfBmoM=; b=P9RsP6BHBaHXjBWj0C5HYL9CDx
 D3VhB5TXyQG7C0OJSa20ARgl35OImbkiopuhPpqNAk3o/wj7zlwgPSF8L3OM1Za+UodxPgQVTPJMj
 rEpxySipPCPoMhXxq700QQXCLilZQVjmuTXlkTJBzQS8344MMZKlVdF29fb6G/TVHWmzWra2YgVQW
 XOjbyroAl+TTh1CKpkTxF6iNTCWzeQoDV+WGDZWsHKLlbMoUQbAEvtjquHWrmBYvwxCg1XSr5y9Se
 jsxLZ+vj6fQMlpK124h9H/K6w1LDoKZvjs9riMx2mUfDqFFMb67fikRRI4+mYknYFdtKpe/TbZ1GG
 GB5ErBXQ==;
Received: from [89.212.21.243] (port=54746 helo=[192.168.69.116])
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1rUnAx-00A2KJ-2K;
 Tue, 30 Jan 2024 13:25:15 +0100
Message-ID: <99d704dc-8133-45e1-a346-ab1d05d5fb7b@norik.com>
Date: Tue, 30 Jan 2024 13:25:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] board: phytec: phycore-imx93: Add
 phyBOARD-Segin-i.MX93 support
Content-Language: en-US
To: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov
 <w.egorov@phytec.de>, Yannic Moog <Y.Moog@phytec.de>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <20240125164503.32097-1-othacehe@gnu.org>
 <9f20708a-eefb-4a27-a413-8a9f5a472788@norik.com> <878r472m2n.fsf@gmail.com>
From: Primoz Fiser <primoz.fiser@norik.com>
Organization: Norik systems d.o.o.
In-Reply-To: <878r472m2n.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Hi Mathieu,

On 30. 01. 24 10:43, Mathieu Othacehe wrote:
> 
> Hello,
> 
>> Please remove findfdt script.
>>
>> Not needed when you set fdt_file to CONFIG_DEFAULT_FDT_FILE above.
> 
> The reason I used findfdt is that CONFIG_DEFAULT_FDT_FILE is a string
> so, we end up with:
> 
> --8<---------------cut here---------------start------------->8---
> fdt_file="oftree"
> --8<---------------cut here---------------end--------------->8---
> 
> which gives:
> 
> --8<---------------cut here---------------start------------->8---
> u-boot=> run loadfdt
> Failed to load '"oftree"'
> --8<---------------cut here---------------end--------------->8---
> 
> whereas, if I set:
> 
> --8<---------------cut here---------------start------------->8---
> u-boot=> setenv fdt_file oftree
> u-boot=> run loadfdt           
> 24579 bytes read in 5 ms (4.7 MiB/s)
> --8<---------------cut here---------------end--------------->8---
> 
> I then see three options: introduce an unstrigify macro, hardcode
> fdt_file=oftree in the env file, or use the findfdt hack.

On my side there is no problem, see my output here:

U-Boot 2024.04-rc1-00004-g686cb1ca1391-dirty (Jan 30 2024 - 10:58:24 +0100)

CPU:   i.MX93 rev1.1
Model: PHYTEC phyBOARD-Segin-i.MX93
DRAM:  1 GiB
Core:  184 devices, 22 uclasses, devicetree: separate
WDT:   Started wdog@42490000 with servicing every 1000ms (40s timeout)
MMC:   FSL_SDHC: 0, FSL_SDHC: 1
Loading Environment from MMC... OK
In:    serial@44380000
Out:   serial@44380000
Err:   serial@44380000
Net:   eth0: ethernet@42890000
Hit any key to stop autoboot:  0
u-boot=>
u-boot=> env default -a
## Resetting to default environment
u-boot=> saveenv; saveenv
Saving Environment to MMC... Writing to redundant MMC(1)... OK
Saving Environment to MMC... Writing to MMC(1)... OK
u-boot=> printenv fdt_file
fdt_file="oftree"
u-boot=> run loadfdt
48532 bytes read in 5 ms (9.3 MiB/s)
u-boot=> boot
switch to partitions #0, OK
mmc1 is current device
32688640 bytes read in 411 ms (75.8 MiB/s)
Booting from mmc ...
83 bytes read in 1 ms (81.1 KiB/s)
48532 bytes read in 4 ms (11.6 MiB/s)
Working FDT set to 83000000
3615 bytes read in 3 ms (1.1 MiB/s)
1209 bytes read in 2 ms (589.8 KiB/s)
## Flattened Device Tree blob at 83000000
   Booting using the fdt blob at 0x83000000
Working FDT set to 83000000
   Loading Device Tree to 00000000bcf0a000, end 00000000bcf19fff ... OK
Working FDT set to bcf0a000

Starting kernel ...



Here is my diff compared to your v3:

--- a/board/phytec/phycore_imx93/phycore_imx93.env
+++ b/board/phytec/phycore_imx93/phycore_imx93.env
@@ -5,7 +5,7 @@ console=ttyLP0
 fdt_addr=0x83000000
 fdto_addr=0x830c0000
 bootenv_addr=0x83500000
-fdt_file=undefined
+fdt_file=CONFIG_DEFAULT_FDT_FILE
 ipaddr=192.168.3.11
 serverip=192.168.3.10
 netmask=255.255.255.0
@@ -22,11 +22,7 @@ mmcautodetect=yes
 mmcargs=setenv bootargs ${mcore_clk} console=${console},${baudrate}
earlycon
        root=/dev/mmcblk${mmcdev}p${mmcroot} ${raucargs} rootwait rw
 loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
-findfdt=if test $fdt_file = undefined; then
-            setenv fdt_file CONFIG_DEFAULT_FDT_FILE ;
-        fi;
-        echo fdt_file=${fdt_file};
-loadfdt=run findfdt;fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr}
${fdt_file}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}
 mmc_load_overlay=fatload mmc ${mmcdev}:${mmcpart} ${fdto_addr} ${overlay}
 mmc_apply_overlays=



So this should work. We have the same in the downstream u-boot-imx.

Also, in-tree, phycore_am62x.env has the same:

fdtfile=CONFIG_DEFAULT_FDT_FILE
loadfdt=load mmc ${mmcdev}:${mmcpart} ${fdtaddr} ${fdtfile}

Can you re-check, please?

Maybe check your include/generated/environment.h?

> 
> I'm not sure which one is the better?
> 
> I will fix all the other remarks in the v4.

OK, thanks.

I spotted additional remark that was not fixed in v3:

In file doc/board/phytec/imx93-phyboard-segin.rst, can you please change
title from:

phyCORE-i.MX 93 on a phyBOARD-Segin
===================================

to:

phyBOARD-Segin-i.MX93
=====================

and this text from:

U-Boot for the phyCORE-i.MX 93 on a phyBOARD-Segin.

to:

U-Boot for the phyBOARD-Segin-i.MX93.


Last but not least, please remove:

#define EEPROM_ADDR            0x50

from board/phytec/phycore_imx93/spl.c

As support for PHYTEC_EEPROM will come later and that define will be
part of that series.

Thanks and best regards,
Primoz

> 
> Thanks,
> 
> Mathieu



