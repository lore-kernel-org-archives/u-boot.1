Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B46C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 10:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5325987465;
	Thu, 16 Nov 2023 11:23:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="D91w49ex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F32D487477; Thu, 16 Nov 2023 11:23:00 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F112F87438
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 11:22:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4ACDF3FBFC; 
 Thu, 16 Nov 2023 10:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700130178;
 bh=h5Cfm08sxNlKylmtmRgJhP02r6Hlr714xLthBk7rmZs=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=D91w49exVn2fqH5WEDU3PKem82aukDlUurw51sgloWDGrOlfXzPJixPjOO0x1cezI
 DuLqq5LH5GHEM4MOHu+eGaqp6DmSE9pVZgdOGMY9gMnCeELw/p4dxIqewr5kIpUO45
 1uL3DKwsHL4rrbeUGDUNpGJyFgdCUj7t84H+iqbNBLmvR8bqrXq6+s/XiJ2AzzWIM7
 4ye+telmmjhPPAMBlY2GaFfpiiVSTxlbMDqUQ4w6LRc4DoLnHySvXqC3kfeE13TDi3
 dtY8ow6pjQr/HaztMm7QHOsToexZ/5Ezz8DmRLWuyjeK2rNPTl3rdTYDeXukRWQ9HS
 xVpJRLNk2x0HQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Lukas Auer <lukas.auer@aisec.fraunhofer.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] risc-v: qemu: imply NVME_PCI
Date: Thu, 16 Nov 2023 11:22:51 +0100
Message-Id: <20231116102251.53365-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

CONFIG_NVME=y without CONFIG_NVME_PCI=y does not provide working NVMe
support. Instead of implying CONFIG_NVME we must imply CONFIG_NVME_PCI
which will select CONFIG_NVME.

Fixes: e64db0d92e32 ("riscv: qemu: Enable e1000 and nvme support")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/emulation/qemu-riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/emulation/qemu-riscv/Kconfig b/board/emulation/qemu-riscv/Kconfig
index 933b035991..32511b4e4e 100644
--- a/board/emulation/qemu-riscv/Kconfig
+++ b/board/emulation/qemu-riscv/Kconfig
@@ -56,8 +56,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply SCSI_AHCI
 	imply AHCI_PCI
 	imply E1000
-	imply NVME
 	imply PCI
+	imply NVME_PCI
 	imply PCIE_ECAM_GENERIC
 	imply DM_RNG
 	imply SCSI
-- 
2.40.1

