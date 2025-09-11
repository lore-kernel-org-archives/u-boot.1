Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85FCCAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 13:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CFD2833C0;
	Thu, 11 Sep 2025 15:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="m4SmYJUN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EE6B833C6; Thu, 11 Sep 2025 15:14:22 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E3FF83327
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 15:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BDEHDS379750;
 Thu, 11 Sep 2025 08:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757596457;
 bh=uYPz93kchsiLfR2rInsbGwEhjVOjDJgpy7Od0n+vYZI=;
 h=From:To:CC:Subject:Date;
 b=m4SmYJUN5qnAtxecu0pzoX/fiCiIpViedCIfJh9BVfDqlhkTmxwisEzZhYG65CRkr
 8dSRuoN8j7xHTX5uc5HuqrmONL+XLZFPhPEdx3et4xHV7AeLDzYtKJgTQjyz8EtZo3
 PUS9F3iIIaCMqzRLAv8443g8WFvom6nV8JLzo69k=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BDEH0v1179095
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 11 Sep 2025 08:14:17 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 08:14:17 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 08:14:17 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BDEG6J1872911;
 Thu, 11 Sep 2025 08:14:16 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH RFT v1 00/17] Add support for secure falcon mode
Date: Thu, 11 Sep 2025 18:43:56 +0530
Message-ID: <20250911131414.3296697-1-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi all,

During the implementation of falcon mode for TI's K3 devices [1], I encountered
several limitations in regards to the current falcon mode support in U-Boot
especially in ensuring a secure boot flow.

Although the current implementation allows for loading of a signed fitImage as
the SPL payload, there are still a few edge cases that might allow bypassing the
verified boot path.

This series is my attempt in adding a secure variant to the existing falcon
boot mode. Overall the issues with current falcon mode can be boiled down to
the following:

1) No fallback:
    We currently fallback to regular boot flow if falcon mode fails,
    this might not be secure.

2) No arguments file:
    We currently load a kernel file (which could be a raw image or FIT)
    alongside an args file (usually the DT). The args file here doesn't have
    any verification mechanism, so should be skipped altogether as the FIT can
    contain the DT.

3) No access to env:
    In ext and fat fs boot, currently we also reads the environment to get the
    names of the kernel and the arg file. This should be disabled in secure
    falcon flow as the env might not be secure.

4) No raw image boot:
    Boot should fail when the kernel file is a raw kernel image, only FIT should
    be allowed.

The series has been tested on TI's AM62x EVM with SPI, MMC Raw and MMC FS with
the fitImage build following TI's linux SDK[2]. I'm looking for boot tests on
platforms with existing falcon support to ensure no regressions as well as
tests on NAND and NOR boot modes with/without secure falcon boot enabled.

Regards,
Anshul

[1]: https://lore.kernel.org/u-boot/20250603142452.2707171-1-anshuld@ti.com/
[2]: https://software-dl.ti.com/processor-sdk-linux/esd/AM62X/latest/exports/docs/linux/Foundational_Components/U-Boot/UG-Falcon-Mode.html#custom-fitimage-creation

Anshul Dalal (17):
  spl: Kconfig: add SPL_OS_BOOT_SECURE config symbol
  arm: Kconfig: add per device symbols for TI_SECURE
  spl: Kconfig: allow K3 devices to use falcon mode
  spl: fat: load kernel image before args in falcon
  spl: ext: load kernel image before args in falcon
  spl: mmc: load kernel image before args in falcon
  spl: ext,fat: cleanup use of CONFIG_SPL_LIBCOMMON_SUPPORT
  spl: mmc: split spl_mmc_do_fs_boot into regular/os_boot
  spl: ubi: refactor spl_ubi_load_image for falcon mode
  spl: spi: refactor spl_spi_load_image for falcon mode
  spl: nor: refactor spl_nor_load_image for falcon mode
  spl: nand: refactor spl_nand_load_image for falcon mode
  spl: falcon: disable fallback to U-Boot on failure
  spl: falcon: prevent loading args file in secure os boot
  env: Kconfig: disable external env in secure os boot
  Kconfig: disable raw image boot in secure falcon mode
  arm: spl: use fdt addr if arg is unset in falcon mode

 arch/arm/Kconfig           |   8 +++
 arch/arm/lib/spl.c         |   2 +
 boot/Kconfig               |   4 +-
 cmd/Kconfig                |   3 +-
 common/spl/Kconfig         |  29 +++++++---
 common/spl/spl_ext.c       |  63 ++++++++++++----------
 common/spl/spl_fat.c       |  60 ++++++++++++---------
 common/spl/spl_mmc.c       | 104 ++++++++++++++++++++++--------------
 common/spl/spl_nand.c      |  99 +++++++++++++++++++---------------
 common/spl/spl_nor.c       | 105 +++++++++++++++++++++----------------
 common/spl/spl_spi.c       |  38 +++++++++++---
 common/spl/spl_ubi.c       |  50 +++++++++++++-----
 env/Kconfig                |   1 +
 include/system-constants.h |   2 +-
 14 files changed, 358 insertions(+), 210 deletions(-)

-- 
2.51.0

