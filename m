Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CB5C10F1A
	for <u-boot@archiver.kernel.org>; Sun, 12 May 2024 04:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7360387EA8;
	Sun, 12 May 2024 06:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="u/ikIAP8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 780B387E15; Sun, 12 May 2024 06:26:03 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF65E87DD3
 for <u-boot@lists.denx.de>; Sun, 12 May 2024 06:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.lan (unknown [149.11.192.251])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 95A9D3F10D; 
 Sun, 12 May 2024 04:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1715487954;
 bh=3fRt6LDjjrslrb97wGeZl0DQi14+ktCLBzPgbPUIoUQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=u/ikIAP8y2Bp5uumnZfBlA3lktMXHeRQehwxZ7GPKc5FnTXjsrt5VVNpPmtbj5vHB
 EmmaSBdW2dED/MFh37JXVcxig7Gi2ujYTMqd8LknSSY1FfkHtcYBnNn3YYDPT9EWkR
 /iRqBHnlhRtaxKB9O6mGPUq1Dwm7SV/mtAeh0jJn+7XLHqKjAsPtQTrO5pyKqWnpaf
 0rb6dnXUKlLR31R5QhVDUo3Ejw99DMctG67JmOKKA4NHP9Vqm1DK5ZzLiR/YYDvVJC
 JtIu17sZ6tLEe9vocnAx+Wa+s4/EaFoXrjy/Fn51InY1l/dgV3kqV/y5Y7IUTeijrK
 czgtIpXHX8idA==
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
Subject: [PATCH v4 0/5] board: starfive: add Milk-V Mars CM support
Date: Sun, 12 May 2024 06:25:21 +0200
Message-ID: <20240512042528.7766-1-heinrich.schuchardt@canonical.com>
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

v5:
	in mac command use strncpy when copying vendor string
v4:
	Documentation fixes
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

