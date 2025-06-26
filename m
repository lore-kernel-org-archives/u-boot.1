Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822E2C7EE33
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 12:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBADD82B34;
	Thu, 26 Jun 2025 14:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jZyDtyXb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1645782063; Thu, 26 Jun 2025 14:05:49 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0549B82B34
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 14:05:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55QC5Swd2450031;
 Thu, 26 Jun 2025 07:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750939528;
 bh=ZBa2h6L/wSuARHjTRxNL+XATGfLt1p4RqdCx3wtxIpA=;
 h=From:To:CC:Subject:Date;
 b=jZyDtyXbtZteTdeuOygRhAE13BbAVQ6IhGOEVyUBnRiZN4dOgX1gGmZ9E+GiETlaa
 NMz3nA2GDSyrmNDVpSUMY6kselFNunyCQ0zjoc0kxKhy4HOLU3TcHiPM1E8TRQbdIc
 yKSuunzsIYcb0kKK9PL6eLdo2TbJ6QtYt/BD7bpU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55QC5SUE2222934
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 26 Jun 2025 07:05:28 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 26
 Jun 2025 07:05:28 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 26 Jun 2025 07:05:28 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55QC5RSG967355;
 Thu, 26 Jun 2025 07:05:27 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <nm@ti.com>, <bb@ti.com>
Subject: [RFC PATCH v1 0/4] Add support for secure boot in falcon mode
Date: Thu, 26 Jun 2025 17:34:38 +0530
Message-ID: <20250626120443.1405409-1-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
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

With my ongoing work in supporting falcon mode on TI's AM62 platforms[1], I
have encountered several limitations of falcon boot flow from a security PoV.
Currently falcon mode requires an args binary (usually a DTB) and the kernel
image to boot.

This conflicts with secure boot which requires a signed fitImage to be loaded
with the kernel and dtb packaged in a single FIT container among other issues.
This patch series adds a new SPL_SECURE_OS_BOOT config symbols which disables
loading the args file as well as fallback to U-Boot if enabled.

The changes have currently only been verified on MMC FS boot but I can expand
support to other boot media if this is the right direction for achieving secure
falcon boot.

Happy booting,
Anshul
---
[1]: https://lore.kernel.org/u-boot/20250603142452.2707171-1-anshuld@ti.com/
---
Anshul Dalal (4):
  spl: Kconfig: add SPL_SECURE_OS_BOOT config symbol
  spl: Kconfig: allow disabling fallback during os boot
  spl: Kconfig: disallow loading args in falcon mode
  cmd: Kconfig: disable loading raw images in secure os boot

 cmd/Kconfig          |  3 +-
 common/spl/Kconfig   | 27 ++++++++++++++
 common/spl/spl_ext.c |  5 +++
 common/spl/spl_fat.c |  5 +++
 common/spl/spl_mmc.c | 87 ++++++++++++++++++++++++++++----------------
 5 files changed, 94 insertions(+), 33 deletions(-)

-- 
2.49.0

