Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79472C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 15:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2A9C8715F;
	Wed,  8 Nov 2023 16:10:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=enrico.leto@siemens.com header.b="BrGSPw9u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 420EA874C9; Wed,  8 Nov 2023 15:53:28 +0100 (CET)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3306E87165
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 15:53:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 20231108145325f6143506df265d549c for <u-boot@lists.denx.de>;
 Wed, 08 Nov 2023 15:53:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=enrico.leto@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=+B8N/mp9JUz+JpmCVpdV2DA2zXrERrFg69sDTPpuI2E=;
 b=BrGSPw9ubdbPHJD6EaaNbPRbDFDdM3Ug2WCNeSejJLST+C7JXP5gbffp0QGkzKrifeQY3S
 NhQLZhjVvHTk6cNhcWaCB/NjR7VnBaSQxDuWIL9h8Zc0lmhvhiX2NDTCEZgaiHiBpq/EFkc6
 d586f4Aq9Rz1Xzq+pZa7vJ/0k/EOU=;
From: Enrico Leto <enrico.leto@siemens.com>
To: u-boot@lists.denx.de
Cc: Enrico Leto <enrico.leto@siemens.com>
Subject: [PATCH 0/6] siemens,am335x: clean up the draco board family
Date: Wed,  8 Nov 2023 15:53:16 +0100
Message-Id: <20231108145322.302927-1-enrico.leto@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320603:519-21489:flowmailer
X-Mailman-Approved-At: Wed, 08 Nov 2023 16:10:16 +0100
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

The boards were not maintained upstream since the development phase.

Restore SPL and remove unused settings. We need i2c to read the DDR
settings from EEPROM, get u-boot from NAND, the console output and the
watchdog.

Restore u-boot up to the user prompt. The complete functionality will
be restored in future patches.

Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
---
Enrico Leto (6):
  siemens,am335x: clean-up draco targets
  configs: draco: remove spi flash support
  configs: thuban, rastaban: remove emmc
  configs: draco: remove unused resources from spl
  configs: draco: disable misc init
  configs: draco: restore clock driver

 arch/arm/mach-omap2/am33xx/Kconfig            |   9 --
 board/siemens/draco/Kconfig                   |  22 +--
 board/siemens/draco/MAINTAINERS               |  15 +--
 ...tamin_defconfig => draco-etamin_defconfig} |  13 +-
 ...ban_defconfig => draco-rastaban_defconfig} |  19 +--
 ...huban_defconfig => draco-thuban_defconfig} |  19 +--
 configs/draco_defconfig                       | 127 ------------------
 include/configs/{etamin.h => draco-etamin.h}  |   0
 .../configs/{rastaban.h => draco-rastaban.h}  |   0
 include/configs/{thuban.h => draco-thuban.h}  |   0
 include/configs/draco.h                       |  41 ------
 11 files changed, 20 insertions(+), 245 deletions(-)
 rename configs/{etamin_defconfig => draco-etamin_defconfig} (92%)
 rename configs/{rastaban_defconfig => draco-rastaban_defconfig} (90%)
 rename configs/{thuban_defconfig => draco-thuban_defconfig} (89%)
 delete mode 100644 configs/draco_defconfig
 rename include/configs/{etamin.h => draco-etamin.h} (100%)
 rename include/configs/{rastaban.h => draco-rastaban.h} (100%)
 rename include/configs/{thuban.h => draco-thuban.h} (100%)
 delete mode 100644 include/configs/draco.h

-- 
2.30.2

