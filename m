Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B75C10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 10:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F35988489;
	Thu,  9 May 2024 12:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cWfGYKV1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 253B488487; Thu,  9 May 2024 12:12:07 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 880F3880AD
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 12:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.lan (unknown [149.11.192.251])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 86CEB3F103; 
 Thu,  9 May 2024 10:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1715249522;
 bh=r/ayiNCQGGFzCJ/wTEjLxlSMRQ6Ig9gSoCp4oFOQyaQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=cWfGYKV1siAeMuk7GXwFCx6sAl/YvPGefJY4h8VvHcU5GbbhG5Hfd7VewFmpfY/2z
 ZH/GQJiHbCiWNr4IjGewogPnBZpIz+6p5gg0j44eAZwtLItoF2Jn5Tjw70+hDyY6qy
 QHVh131huLaM9fFhEVpDZMUOEPcUPc/3WrOsr1Ie2JmdFYCQ0kGUADPmo9AGpt4Oxj
 O459tjyvA3cocq7DPdtxQCNNV71e7jn6xP7DVoXBn9cAfEXR8dCnhYE3gIKwNTX+2w
 p9zZ69oXta4lZ6cmhu41jxUgK8oaOnsZbX/4qaXA6ducSNbUHmi9d5vKf1rx1Ve1yt
 Z2B0afEefEQfQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Michal Simek <michal.simek@amd.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Mason Huo <mason.huo@starfivetech.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 0/5] board: starfive: add Milk-V Mars CM support
Date: Thu,  9 May 2024 12:11:48 +0200
Message-ID: <20240509101155.18666-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

With this series the Milk-V Mars CM board can be booted.

NVMe, SD-card, Ethernet, UART are working but not USB.

The first series Milk-V Mars CM Lite board (the version without eMMC)
uses incorrect series numbers indicating eMMC presence. For these
CONFIG_STARFIVE_NO_EMMC=y must be set to indicate that eMMC is not
present.

Thanks to E. Shattow for all the helpful discussions.
He figured out what needed to be patched in the device-tree.

v3:
	Add mac vendor sub-command
	Documentation fixes
v2:
	fix typos in get_mmc_size_from_eeprom() description
	rename spl_fdt_fixup_marc() to spl_fdt_fixup_mars_cm()
	rename device-trees for Mars CM and Mars CM Lite
	change model and compatible properties
	refer to tio as tool for booting via UART
	describe how to update serial number

Heinrich Schuchardt (5):
  board: starfive: function to read eMMC size
  board: add support for Milk-V Mars CM
  doc: Milk-V Mars CM and Milk-V Mars CM Lite
  configs: visionfive2: enable SPL_YMODEM_SUPPORT
  starfive: add mac vendor sub-command

 arch/riscv/include/asm/arch-jh7110/eeprom.h   |   7 +
 board/starfive/visionfive2/Kconfig            |   9 +
 board/starfive/visionfive2/spl.c              |  28 ++-
 .../visionfive2/starfive_visionfive2.c        |  11 +-
 .../visionfive2/visionfive2-i2c-eeprom.c      |  43 +++-
 configs/starfive_visionfive2_defconfig        |   1 +
 doc/board/starfive/index.rst                  |   1 +
 doc/board/starfive/milk-v_mars_cm.rst         | 193 ++++++++++++++++++
 8 files changed, 290 insertions(+), 3 deletions(-)
 create mode 100644 doc/board/starfive/milk-v_mars_cm.rst

-- 
2.43.0

