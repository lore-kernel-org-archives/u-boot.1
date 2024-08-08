Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE274C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 08:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA6EC886E7;
	Thu,  8 Aug 2024 10:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723106612;
	bh=xLeHKezVYbfRejFhdBo/C7ffdW8MBEJZZdu8eglwtxU=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=cYjyvgLv8U4yA3QtN/og+CVzLTgA98Ngq5NTnNcT4Zp18fyaRiFEGn5qhMOEM8lIn
	 FQ1jDykeyqHIFtPKdlihGFqfPPB6X/197G/iUyG/iBQWq6UAtN+a+EeBxq472tSKrI
	 4Zh231z3JYz44a9TVmvWRc2+jbJZ+r7d0fBpjkCvjNXb/sZHEiQvFv5Jvru36N0TqK
	 kfdLOjr6xLl0YvwiqNFM0xrwvYz8e52NrGBqU8kiBYbkrsiAJNm6/2H9pR69Ia/L12
	 kjGeJOOp6NDwcIZFCGe66PkEsDZrj5Sv7A4ybAJcQmMAeB2KjrhcY1qQxG23hNoHXX
	 nBPSWxbL1maHw==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E72AA880DE;
 Thu,  8 Aug 2024 10:43:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723106610;
 bh=xLeHKezVYbfRejFhdBo/C7ffdW8MBEJZZdu8eglwtxU=;
 h=Date:To:Cc:Reply-To:From:Subject:From;
 b=eHC/sdYbtR8dRHRnjQUIRvkV0jNT1hIzcngKkGBB+25d064aeiWAEZEiyM4CkHf9w
 mkjbgHsETUsOcbv+UcKXtzKLtSNJrmURzeb6bOyFdldJv2FL0HoyQdfZN4ewKfbm1P
 CebPdmbsQaJLSKjpR5Z/eEqbQr0CKoEeCYsIV9L+cFGXvhvVH5tYTwHdGf2gtXoKQL
 0GFvSi8pVp66iD4uFSC2MyZwXWJ9nh3iPhKEmc64EVLMUS20imq4RzggLD31G5W33J
 QWKO0xvr7jaVSk7LOwDLst2TliMl++9Uv3Jm4Jep1XC6IOeFinv+1n41j5Yycbvqeg
 HQrIMLAs+5Fog==
Message-ID: <8d333c2b-2aef-bd73-4489-f79fa6be84ed@denx.de>
Date: Thu, 8 Aug 2024 10:42:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>, David Virag <virag.david003@gmail.com>,
 Fedor Ross <fedor.ross@ifm.com>, Michal Simek <michal.simek@amd.com>
From: Heiko Schocher <hs@denx.de>
Subject: Please pull u-boot-i2c
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

please pull from u-boot-i2c:

The following changes since commit b7d5ce05b1b52136af09cf34541c6a91079a4b86:

   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sunxi (2024-08-06 
09:36:46 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2cfixes-for-v2024-10-rc3

for you to fetch changes up to 3d299c355912e05ba534574ac557ad0c9edd7d99:

   board: vining_2000: convert to DM_I2C (2024-08-08 05:45:11 +0200)

----------------------------------------------------------------
i2c updates for v2024.10-rc3

- i2c: samsung: Support platforms other than EXYNOS4 and EXYNOS5
   from David

- imx_lpi2c: cleanups and support read transfers longer than 256 bytes
   from Fedor

- pca954x: Remove pointer to GD
   from Michal

- DM_I2C conversion for some remaining boards
   from Anatolij

- i2c: mux: Fix error path in i2c-arb-gpio
   from Michal

----------------------------------------------------------------
Anatolij Gustschin (11):
       board: shc: convert to DM_I2C
       board: chiliboard: convert to DM_I2C
       board: cm-t43: convert to DM_I2C
       board: igep003x: convert to DM_I2C
       board: sl50: convert to DM_I2C
       board: rut: convert to DM_I2C
       board: novena: convert to DM_I2C
       board: sniper: convert to DM_I2C
       board: vf610twr: convert to DM_I2C
       board: cm_fx6: convert to DM_I2C
       board: vining_2000: convert to DM_I2C

David Virag (2):
       i2c: samsung: Drop s3c24x0 specific code.
       i2c: samsung: Support platforms other than EXYNOS4 and EXYNOS5

Fedor Ross (3):
       i2c: imx_lpi2c: Fix a typo in bus_i2c_receive
       i2c: imx_lpi2c: Replace hard-coded bus speed value with bus->speed_hz
       i2c: imx_lpi2c: Support read transfers longer than 256 bytes

Michal Simek (2):
       i2c: pca954x: Remove pointer to GD
       i2c: mux: Fix error path in i2c-arb-gpio

  arch/arm/mach-omap2/omap3/Kconfig          |   1 +
  board/bosch/shc/board.c                    |  22 +++++++++++-----------
  board/compulab/cm_fx6/cm_fx6.c             |   3 ++-
  board/compulab/cm_t43/cm_t43.c             |   2 --
  board/compulab/common/Makefile             |   8 +++++++-
  board/compulab/common/eeprom.c             |  14 +++++---------
  board/compulab/common/eeprom.h             |   2 +-
  board/kosagi/novena/novena.c               |  10 +++++-----
  board/kosagi/novena/video.c                | 140 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------
  board/softing/vining_2000/vining_2000.c    |  25 -------------------------
  configs/am335x_igep003x_defconfig          |   2 +-
  configs/am335x_shc_defconfig               |   4 +++-
  configs/am335x_shc_ict_defconfig           |   4 +++-
  configs/am335x_shc_netboot_defconfig       |   4 +++-
  configs/am335x_shc_sdboot_defconfig        |   4 +++-
  configs/am335x_sl50_defconfig              |   2 +-
  configs/chiliboard_defconfig               |   2 +-
  configs/cm_fx6_defconfig                   |   2 +-
  configs/cm_t43_defconfig                   |   3 ++-
  configs/novena_defconfig                   |   2 +-
  configs/rut_defconfig                      |   2 +-
  configs/sniper_defconfig                   |   6 ++++--
  configs/vf610twr_defconfig                 |   2 +-
  configs/vf610twr_nand_defconfig            |   2 +-
  configs/vining_2000_defconfig              |   2 +-
  drivers/i2c/Kconfig                        |   2 +-
  drivers/i2c/exynos_hs_i2c.c                |  25 +++++++++++++++++++++----
  drivers/i2c/imx_lpi2c.c                    |  87 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------
  drivers/i2c/muxes/i2c-arb-gpio-challenge.c |  11 ++++-------
  drivers/i2c/muxes/pca954x.c                |   3 ---
  drivers/i2c/s3c24x0_i2c.c                  |  32 ++++++++++++++++++++++++--------
  drivers/i2c/s3c24x0_i2c.h                  |   2 ++
  32 files changed, 242 insertions(+), 190 deletions(-)

after sorting out some small problems

azure build is now fine:
https://dev.azure.com/hs0298/hs/_build/results?buildId=116&view=results

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
