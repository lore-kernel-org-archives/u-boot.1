Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A1AC54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 16:25:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA32788139;
	Wed, 27 Mar 2024 17:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wib5jYvu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A60F88134; Wed, 27 Mar 2024 17:24:15 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AB268812F
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 17:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AF936615F2;
 Wed, 27 Mar 2024 16:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91290C433C7;
 Wed, 27 Mar 2024 16:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711556649;
 bh=e4VW+W2K4zILdk8I3Tg1aPePw+MeDj8H8x6xDE/Sirw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Wib5jYvuGiLLcXsNKPKGp7vBtJmaN6xF+mYwBJ3Mej5JDlhmmpr99QDxAgHuYh4Nu
 f3kTS/Zfwq16bwefGbDUNpa5Fo3s6afMnnrB+lwi2fVxKok/kyhHpv2YWyXAnwgVkJ
 m3yXaLeoPy47lj9oyaeXpy3DTtgKB0t0T6IWMHhCZ+sCqeG6Nb60KEdPLwJjmaAWed
 rdVdD8kHeCVMH5DfnXtKM/F14fYwaXpBdMGlkKDOT8VLu7w/kx5HSJnmVn+JEasCWM
 OrhfQoeVjAPIQ6lUB1XzfPR3vE06nRt1kCtlXKDPWiLlW+fpfuRoaU0osSni6R6i5f
 C5mU0gIDwSemQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v3 08/18] arm: mvebu: spl: Do not build
 mvebu-reset in SPL
Date: Wed, 27 Mar 2024 17:23:45 +0100
Message-ID: <20240327162355.24584-9-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240327162355.24584-1-kabel@kernel.org>
References: <20240327162355.24584-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Commit 35e29e89a386 ("arm: mvebu: Implement simple mvebu-reset driver
for enabling/disabling PCIe ports") made it so that the mvebu reset
driver for enabling/disabling PCIe ports is build if CONFIG_DM_RESET is
enabled. This is because PCI_MVEBU depends on DM_RESET.

But the driver should not be built for SPL. Indeed the PCI_MVEBU driver
is not supported in SPL now, and so the mvebu-reset driver is not needed.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 arch/arm/mach-mvebu/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 0584ed2be5..ef790d97fe 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -22,13 +22,14 @@ else # CONFIG_ARCH_KIRKWOOD
 obj-y	= cpu.o
 obj-y	+= dram.o
 obj-y	+= lowlevel.o
-obj-$(CONFIG_DM_RESET) += system-controller.o
 ifndef CONFIG_SPL_BUILD
 obj-$(CONFIG_ARMADA_375) += ../../../drivers/ddr/marvell/axp/xor.o
 obj-$(CONFIG_ARMADA_38X) += ../../../drivers/ddr/marvell/a38x/xor.o
 obj-$(CONFIG_ARMADA_XP) += ../../../drivers/ddr/marvell/axp/xor.o
 obj-$(CONFIG_ARMADA_MSYS) += ../../../drivers/ddr/marvell/axp/xor.o
 
+obj-$(CONFIG_DM_RESET) += system-controller.o
+
 ifdef CONFIG_ARMADA_38X
 obj-$(CONFIG_MVEBU_EFUSE) += efuse.o
 endif
-- 
2.43.2

