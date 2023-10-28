Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC52C27C47
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 17:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 085A286E37;
	Sat, 28 Oct 2023 19:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OLl0SMIK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDEC786FB0; Sat, 28 Oct 2023 19:36:14 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAE6A86DD2
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 19:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 392C7B8167D;
 Sat, 28 Oct 2023 17:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7780FC433C7;
 Sat, 28 Oct 2023 17:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698514570;
 bh=aACz+Xu9VoUgk8o/s04Uur3uSRgAweaBzmrIPYMisv4=;
 h=From:To:Cc:Subject:Date:From;
 b=OLl0SMIK/jF2zTu9UDUi8MNorL4zFIJjvbISgDB3aOEH9rp+Ty80sYhOUTCaIVash
 2DSjgZpgV/Ilg2vbBxNOP23P3IuZBfa1AJ1hXCNzfELitXrwdDPIYqeJCvodKmK+J0
 tkkWlvadVSxpuHK4GFeraxJdN9FI9RuFs3iRwL0+6CMivy4E4ICnTFrPNUZpFIpg9J
 H/BYVEHlpIP0KxZczTDHdopxNtSHAVqkjS3HQvSCSQ5VRktxl8k2uIXgavOZYw6wcn
 N5XzynUFCHvvIqNbgeWDntL0cvHrCoqVscuRzuw41NouEf8z5Z3tpCoKkRZ4IrxSxd
 65mxd9RIdtB0A==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	trini@konsulko.com
Cc: s-vadapalli@ti.com, r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com,
 marcel.ziswiler@toradex.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 0/3] arm: dts: k3-am6: Fix Ethernet/DMA
Date: Sat, 28 Oct 2023 20:36:00 +0300
Message-Id: <20231028173603.24338-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Hi,

Since commit [1], Ethernet is broken on TI AM62 and AM64 platforms.

The commit [1] is not the culprit. It just unearths the problem by fixing
the error check in k3-udma.c. This issue was silently being ignored earlier
due to wrong error check. [NULL instead of FDT_ADDR_T_NONE].

Fix the issue by adding the necessary register spaces for the u-boot K3-UDMA
driver for AM62 and AM64 platforms.

These properties will eventually make it into the SoC DTSi files [2] after
which these can be dropped from k3-*-u-boot.dtsi files.

[1] - 5fecea171de3dd ("treewide: use dev_read_addr_*_ptr() where appropriate")
[2] - https://lore.kernel.org/linux-arm-kernel/20230810174356.3322583-1-vigneshr@ti.com/

cheers,
-roger

Changelog:
v2:
- move 'bootph-all' to the end of the nodes
- add changes to existing main_bcdma and main_pktdma nodes
- drop duplicate main_pktdma node in k3-am642-sk-u-boot.dtsi
- Add Tested-by and Reviewed-by tags

Roger Quadros (1):
  arm: dts: k3-am625-verdin-wifi-dev-u-boot.dtsi: Fix DMA/Ethernet

Siddharth Vadapalli (2):
  arm: dts: k3-am625-sk-u-boot.dtsi: Update main_bcdma and main_pktdma
    nodes
  arm: dts: k3-am642: Update main_bcdma and main_pktdma nodes

 arch/arm/dts/k3-am625-sk-u-boot.dtsi          | 23 ++++++++++++++++
 .../dts/k3-am625-verdin-wifi-dev-u-boot.dtsi  | 27 +++++++++++++++++++
 arch/arm/dts/k3-am642-evm-u-boot.dtsi         | 23 ++++++++++++++++
 arch/arm/dts/k3-am642-sk-u-boot.dtsi          | 24 ++++++++++++++---
 4 files changed, 93 insertions(+), 4 deletions(-)


base-commit: 4bb6f61220f7f4c79ccf98f4281733e6ea6c50f0
prerequisite-patch-id: 3125319138da332af1e7650e3ae0d78dab0ff312
-- 
2.34.1

