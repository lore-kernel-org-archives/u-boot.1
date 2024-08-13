Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A20C52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 10:45:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B1158855C;
	Tue, 13 Aug 2024 12:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723545926;
	bh=ji2fPny+n7QlKCOcsl4oBeJS949WtZqU/5YGvoxCnyw=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=NT6YuoHTi9mjoBN7LH0y1qEk8XO+RknqY3cdB/KLQxrZ6Lqo2zr4AGrA6BTqvSTfj
	 E8n+iinMuyRs7YoYkX+AIbWVuUjTKEoFe3X8MUqmxCw0ggoKNaZgFd38PyRj3Kt1hG
	 wX2aPY/aHI111nV4kxs+t00x26wt84iCgPptI12a42olGptR6fSctTOVPf0yl2ywKy
	 /+Qchta1BnKCnwT0JkbA1ja9+OPHNUmlbZGq1OwP9vC36IuDB0tmSt+/8TFSLTdVCB
	 wuFNIesmRdg7XotKQzBigeiaX7BTmgXbgb00KF5ZtY7vasfBwIVpwXcdMmVY9Tk/Yc
	 jlohLdp0edERw==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 251928800C;
 Tue, 13 Aug 2024 12:45:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723545925;
 bh=ji2fPny+n7QlKCOcsl4oBeJS949WtZqU/5YGvoxCnyw=;
 h=Date:To:Cc:Reply-To:From:Subject:From;
 b=k6y0KBtbBjmdGChtFP0xuaYHVwa8C2x70RC1P3tsTVArzLczdT6BKEaCV1hgpOdwe
 KWZ4Q1iISPIId4XXaoBJ/hkkL9pPeq0pfNCZEj5XyvD+yOmgjYpal0QPCTfL+dSCKm
 cb/qePln/952PYLihr5SgVeCoL8c7w/DT50hPwmocFhgxMSb0I6EXeTGpdB2Y1+IPx
 vheVX9wkEB5ueUlIFHZxSy3QKWGEa5QB5Y1WThFNnwGDPkx0v/g/tmPS/HiB5DKaom
 G93QpsZSOOmeVNicSwzMrlQSFmRNzgIFLfFW2PhJx+ZaA6o8iP4wsPnURnzWdTnH7q
 2RM6am9bmsuwQ==
Message-ID: <87aad96a-93d9-2309-ec1c-fa372cb87b09@denx.de>
Date: Tue, 13 Aug 2024 12:44:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>
From: Heiko Schocher <hs@denx.de>
Subject: Please pull u-boot-i2c next
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

Hello Tom,

please pull from u-boot-i2c next

The following changes since commit f4f845b859266790b97421f0740efce36bc9b8d2:

   Merge patch series "Universal Payload initial series" (2024-08-09 16:03:21 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2c-dm-updates-for-v2024-10-next

for you to fetch changes up to 710b9c89f2c2f19436f6c21d092af1a2b24a26a6:

   i2c: Remove CFG_SYS_I2C_DIRECT_BUS (2024-08-13 06:23:15 +0200)

----------------------------------------------------------------
i2c DM updates for v2024.10 next

- Add series from Simon, which removes old content in i2c.h
   so that we can move towards having just the dm API.

   It does not remove any boards, but instead removes functionality.

----------------------------------------------------------------
Simon Glass (18):
       i2c: Remove board_i2c_init()
       i2c: Remove IC2_xxx enum
       i2c: Remove CFG_I2C_MULTI_BUS
       mips: malta: Drop CMD_DATE
       armv8: ls2085a: Drop CMD_DATE
       mx28 / mx51: Drop CMD_DATE
       MPC837XERDB: ethernut5: work_92105: Drop CMD_DATE
       rtc: Drop CFG_SYS_RTC_BUS_NUM
       date: Drop the legacy I2C code
       fsl: mxc: Drop legacy I2c
       i2c: Drop reference to SYS_I2C_INIT_BOARD
       octeon: Drop OCTEON_I2C_FDT dead code
       i2c: Remove I2C_SET_BUS()
       i2c: Remove I2C_GET_BUS()
       i2c: Drop CFG_SYS_MAX_I2C_BUS
       i2c: Drop i2c_get_bus_num_fdt() and i2c_reset_port_fdt()
       i2c: Remove CFG_SYS_I2C_MAX_HOPS
       i2c: Remove CFG_SYS_I2C_DIRECT_BUS

  README                             |  27 +--------------------------
  arch/mips/mach-octeon/octeon_fdt.c |   7 -------
  cmd/date.c                         |  32 --------------------------------
  cmd/i2c.c                          |  23 -----------------------
  configs/MPC837XERDB_defconfig      |   1 -
  configs/ethernut5_defconfig        |   1 -
  configs/ls2080aqds_nand_defconfig  |   1 -
  configs/ls2080aqds_qspi_defconfig  |   1 -
  configs/ls2080ardb_nand_defconfig  |   1 -
  configs/malta64_defconfig          |   1 -
  configs/malta64el_defconfig        |   1 -
  configs/malta_defconfig            |   1 -
  configs/maltael_defconfig          |   1 -
  configs/mx28evk_defconfig          |   1 -
  configs/mx51evk_defconfig          |   1 -
  configs/work_92105_defconfig       |   1 -
  doc/I2C_Edge_Conditions            |  10 ++++------
  drivers/ddr/fsl/main.c             |   3 +--
  drivers/i2c/i2c_core.c             | 141 
---------------------------------------------------------------------------------------------------------------------------------------------
  drivers/i2c/mxc_i2c.c              |   1 +
  drivers/i2c/soft_i2c.c             |  11 -----------
  drivers/power/power_i2c.c          |   5 -----
  drivers/usb/host/ohci-lpc32xx.c    |   4 ----
  include/configs/ethernut5.h        |   3 ---
  include/configs/ls1028aqds.h       |   1 -
  include/configs/ls1028ardb.h       |   2 --
  include/configs/ls1046afrwy.h      |   1 -
  include/configs/lx2160aqds.h       |   3 ---
  include/configs/lx2160ardb.h       |   3 ---
  include/configs/lx2162aqds.h       |   3 ---
  include/configs/m53menlo.h         |   2 --
  include/configs/sniper.h           |  14 --------------
  include/configs/tqma6.h            |   3 ---
  include/configs/tqma6_wru4.h       |   1 -
  include/i2c.h                      | 107 
-----------------------------------------------------------------------------------------------------------
  35 files changed, 7 insertions(+), 412 deletions(-)

Azure build:
https://dev.azure.com/hs0298/hs/_build/results?buildId=122&view=results

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
