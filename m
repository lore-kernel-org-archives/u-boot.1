Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A6DC369CB
	for <u-boot@archiver.kernel.org>; Sat, 26 Apr 2025 12:10:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3A2181E0F;
	Sat, 26 Apr 2025 14:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4D4581E14; Sat, 26 Apr 2025 14:10:22 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 95194810EB
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 14:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24E08106F;
 Sat, 26 Apr 2025 05:10:14 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D85953F66E;
 Sat, 26 Apr 2025 05:10:18 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 linux-sunxi@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] sunxi: enable MMU_PGPROT proper page table protection
Date: Sat, 26 Apr 2025 13:09:13 +0100
Message-ID: <20250426120913.23314-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
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

Select the new MMU_PGPROT Kconfig symbol for all Allwinner board builds,
to use a write-protected .rodata, non-executable .data and .rodata
sections, and non-writable .text sections.

This might trigger runtime exceptions in misbehaving drivers, which
should then be fixed.
Please report on the list or on IRC if bisecting ends at this patch.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Hi,

I am planning on merging this ASAP, to get some exposure and use the time
until the release for wider testing. If worst comes to the worst, we can
revert it still before July.

Cheers,
Andre

 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 99750072e55..f22d347d5ad 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1192,6 +1192,7 @@ config ARCH_SUNXI
 	select DM_KEYBOARD
 	select DM_SERIAL
 	select DM_PMIC
+	select MMU_PGPROT if ARM64
 	select OF_BOARD_SETUP
 	select OF_CONTROL
 	select PINCTRL
-- 
2.46.3

