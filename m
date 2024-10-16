Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87232D2069A
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 05:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B75488001;
	Wed, 16 Oct 2024 07:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729056983;
	bh=c2XtzurvdWJ4h0KIhD9SSxb1H2xiBystayvX1CuBbWE=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=ehOdF8MiEdjC/0J7ltN6uXJVOf5reNVs43W4Q/9zw1lrOSdSBlMvnPrx58UjUNSF2
	 +BmpwX5wRK7icc+/4r+BU+ixv10+jpuS0QNz/0yAgo7zrYV6o+lCsHVMhByJ1WnKF4
	 g795Ev7V28wQV1T7heUSkcjZQi1q/HA8du4687NYq459ek9/qMc/+mPlZbsHhJe0vj
	 csWRKXNkshqR5gaJpDWxrPSI/3wBK+E0y0oVMSBuJytCNxgcFrpQcFdc0OkPqJVKkx
	 K3pLISEXqZkXdbo+TJwCclwormENwxxhOJ9Re1ShZNz3mc0a8uMZGW2cKAjoiDnQVg
	 VV5gqUTWah6Vg==
Received: from [192.168.1.107] (87-97-107-160.pool.digikabel.hu
 [87.97.107.160])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 15DE386BF1;
 Wed, 16 Oct 2024 07:36:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729056981;
 bh=c2XtzurvdWJ4h0KIhD9SSxb1H2xiBystayvX1CuBbWE=;
 h=Date:To:Cc:Reply-To:From:Subject:From;
 b=jvWKIg20VvkQWvrkmLIW9EtcGFSIuW+kLKTBkn0R8oMVwPmG5uV5V44pGq2UqIE0R
 LZpiQlmWIUVhEGpaukUvlqnIWSvCRcJbQ6PxvUPidiwQbrly2K3gblG7BrorBPXjqP
 ZV2gGWyDHctdWhNIb8Bwpska/7Fu/u21KjETwqWhK21Gbxx5/wCbhXFG7Bl9CWjXAB
 tcWb6Nk563HUuPp/BvYfcc9GoyyHPbHnzMBg6k5lTYrL1qojyrq/TNkRDpAg8qUihM
 RZJKtKmYVAn1KkWMaVbS6Bs9cRo1nWKANcutlihWFsFdQ7pFv/DkktUD1mANDQ2lTZ
 FWhQlNLIveiNQ==
Message-ID: <67ebc675-d681-3b63-b642-f32f5e6a6b38@denx.de>
Date: Wed, 16 Oct 2024 07:34:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Peng Fan <peng.fan@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Leto, Enrico" <enrico.leto@siemens.com>
From: Heiko Schocher <hs@denx.de>
Subject: imx8qxp: deneb board fails with current HEAD
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

Hello Peng,

I just rebased my current work on siemens deneb board with current
master:

* d5cab0d6ad - (HEAD -> master, origin/master, origin/WIP/15Oct2024, origin/HEAD) Revert "Makefile: 
Drop SPL_FIT_GENERATOR / SPL_FIT_SOURCE support" changes (vor 3 Stunden) <Tom Rini>

And see:
"""
U-Boot SPL 2024.10-01044-g91b1263d96d9 (Oct 16 2024 - 07:10:25 +0200)
Normal Boot
Trying to boot from MMC1
__imx8_clk_enable(Invalid clk ID #0)
fsl_esdhc usdhc@5b010000: Failed to enable clks: -22
__imx8_clk_enable(Invalid clk ID #0)
fsl_esdhc usdhc@5b010000: Failed to enable clks: -22
spl: could not initialize mmc. error: -22
SPL: failed to boot from all boot devices
### ERROR ### Please RESET the board ###
"""

Looking around the changes I found your commit:


commit 76332fae769acbba49751827ce126b0cb1014b48
Author: Peng Fan <peng.fan@nxp.com>
Date:   Tue Oct 1 21:07:53 2024 +0800

     mmc: fsl_esdhc_imx: Enable AHB/IPG clk with clk bulk API

     With partition reset supported for i.MX8QM/QXP/95 and etc, when linux
     mmc runtime suspended, the mmc clks are gated off. While at same time
     system controller reset Cortex-A cores because of various reasons(
     WDOG timeout and etc), with SPL run again, only enable PER clk is not
     enough, also need to enable AHB/IPG clk, here use clk bulk API to enable
     all the clocks.

     Signed-off-by: Peng Fan <peng.fan@nxp.com>


reverting it, and board boots fine again!

May you have an idea? I try to look deeper soon.

(A fast look as I wondered about clk id 0):

./include/dt-bindings/clock/imx8qxp-clock.h
#define IMX8QXP_CLK_DUMMY                                       0

and ./arch/arm/dts/fsl-imx8dx.dtsi
512         usdhc2: usdhc@5b020000 {
513                 compatible = "fsl,imx8qm-usdhc", "fsl,imx6sl-usdhc";
[...]
517                 clocks = <&clk IMX8QXP_SDHC1_IPG_CLK>,
518                         <&clk IMX8QXP_SDHC1_CLK>,
519                         <&clk IMX8QXP_CLK_DUMMY>;
520                 clock-names = "ipg", "per", "ahb";

So this explains ID 0 ... and with drivers/clk/imx/clk-imx8qxp.c
242 int __imx8_clk_enable(struct clk *clk, bool enable)
243 {
[...]
250         switch (clk->id) {
251         case IMX8QXP_I2C0_CLK:

no entry for IMX8QXP_CLK_DUMMY ...

So I wonder how this can work ...

Thanks!

bye,
Heiko
[1]
U-Boot SPL 2024.10-01045-g0a08358303ba (Oct 16 2024 - 07:18:23 +0200)
Normal Boot
Trying to boot from MMC1
Primary set selected
Load image from MMC/SD 0x47800


U-Boot 2024.10-01045-g0a08358303ba (Oct 16 2024 - 07:18:23 +0200) ##v01.06

CPU:   NXP i.MX8QXP RevC A35 at 1200 MHz at 31C
Model: Siemens CXG3
Board: Capricorn
Build: SCFW 042ba867, SECO-FW c9de51c0, ATF 2ba2c83
Boot:  MMC0
Reset cause: POR
DRAM:  2 GiB
HW Version: v04.03
Core:  94 devices, 23 uclasses, devicetree: separate
WDT:   Started scu-wdt without servicing  (60s timeout)
MMC:   FSL_SDHC: 0
Loading Environment from MMC... *** Warning - bad CRC, using default environment

Reading from MMC(0)... In:    serial@5a080000
Out:   serial@5a080000
Err:   serial@5a080000
ERROR: PCA9552 probe failed
I2C LED init failed
Net:   eth1: ethernet@5b050000 [PRIME]
Autobooting in 3 seconds, press "<Esc><Esc>" to stop
U-Boot#
U-Boot#

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
