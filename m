Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30A4C369BD
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 00:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BFF282F87;
	Thu, 17 Apr 2025 02:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0363A82FCA; Thu, 17 Apr 2025 02:06:42 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D5EE282DB4
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 02:06:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A2C81764;
 Wed, 16 Apr 2025 17:06:36 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C9D13F66E;
 Wed, 16 Apr 2025 17:06:37 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	u-boot@lists.denx.de
Cc: Yixun Lan <dlan@gentoo.org>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev
Subject: [PATCH v2 3/3] sunxi: x96_mate: Add "fake" FEL key definition
Date: Thu, 17 Apr 2025 01:05:39 +0100
Message-ID: <20250417000539.3709-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250417000539.3709-1-andre.przywara@arm.com>
References: <20250417000539.3709-1-andre.przywara@arm.com>
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

The X96 Mate TV box features a hidden button behind the earphone jack,
which can be reached with a non-conductive tools like a toothpick. On
the vendor firmware, holding this button during reset or power on
triggers the BootROM FEL mode, though it's not an hardware FEL button,
but a feature of Allwinner's "boot0" firmware.

Mimic this behaviour by specifying the GPIO name (PH9) for our "fake"
FEL button feature in the board's defconfig file, which actually enters
FEL mode much faster than the vendor firmware.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 configs/x96_mate_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/x96_mate_defconfig b/configs/x96_mate_defconfig
index bd9b611d6f5..b54d0bb5608 100644
--- a/configs/x96_mate_defconfig
+++ b/configs/x96_mate_defconfig
@@ -11,6 +11,7 @@ CONFIG_DRAM_SUNXI_TPR11=0xffffdddd
 CONFIG_DRAM_SUNXI_TPR12=0xfedf7557
 CONFIG_MACH_SUN50I_H616=y
 CONFIG_SUNXI_DRAM_H616_DDR3_1333=y
+CONFIG_SUNXI_FAKE_FEL_PIN="PH9"
 CONFIG_R_I2C_ENABLE=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
-- 
2.46.3

