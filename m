Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08363C47073
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 12:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC408878DB;
	Tue,  9 Jan 2024 13:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xrhc58BZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D706878CD; Tue,  9 Jan 2024 13:26:28 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AF95878DA
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 13:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 3CAECCE182E;
 Tue,  9 Jan 2024 12:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7F3C433F1;
 Tue,  9 Jan 2024 12:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704803182;
 bh=Z4cJUx4MdKKu1lx2zVinzN4WOWVLbBOEn1r01CLIvZI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Xrhc58BZtHeG0hWO1kEHpjp5/uKy+9lK8QFE1i8uODUb1ffaoWxs/k9CJBBNBvV4C
 qx5H0qPBgXk1lAJXAKKbKh28pteD2VFGUufMZGOAeGlvfEP1V5qYNNLy9hB264dVjb
 tV4AVLt8pze25GcrUoBeiEWBGMjsqPYKeUK5Kfr0ZVrHjmLAba/PmCBZ+KTumUTc2i
 aw9MPlVMFoAQgl3lV+4WIKOWEQU5c+UawiHIlr7+kofCVSWKokSqbp4NMQXlzE3zOg
 83dk5jMzS/VQW38fMYqoug6aPvQzDD8bNthc1MxquvUi705BtpkbK/Jc9CvYqjGwb4
 1Z/gpDEbSoAUA==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com
Cc: nm@ti.com, afd@ti.com, vigneshr@ti.com, praneeth@ti.com, srk@ti.com,
 r-gunasekaran@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 3/4] arm: mach-k3: am642: Define NAND boot device
Date: Tue,  9 Jan 2024 14:26:04 +0200
Message-Id: <20240109122605.51951-4-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240109122605.51951-1-rogerq@kernel.org>
References: <20240109122605.51951-1-rogerq@kernel.org>
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

AM642 SoC supports booting from GPMC NAND device.
Define boot device for it.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm/mach-k3/am642_init.c            | 3 +++
 arch/arm/mach-k3/include/mach/am64_spl.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-k3/am642_init.c b/arch/arm/mach-k3/am642_init.c
index 6085379f1d..ddf47ef0a9 100644
--- a/arch/arm/mach-k3/am642_init.c
+++ b/arch/arm/mach-k3/am642_init.c
@@ -348,6 +348,9 @@ static u32 __get_primary_bootmedia(u32 main_devstat)
 	case BOOT_DEVICE_EMMC:
 		return BOOT_DEVICE_MMC1;
 
+	case BOOT_DEVICE_NAND:
+		return BOOT_DEVICE_NAND;
+
 	case BOOT_DEVICE_MMC:
 		if ((bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_PORT_MASK) >>
 		     MAIN_DEVSTAT_PRIMARY_MMC_PORT_SHIFT)
diff --git a/arch/arm/mach-k3/include/mach/am64_spl.h b/arch/arm/mach-k3/include/mach/am64_spl.h
index b4f396b2c0..a0a517019c 100644
--- a/arch/arm/mach-k3/include/mach/am64_spl.h
+++ b/arch/arm/mach-k3/include/mach/am64_spl.h
@@ -22,6 +22,7 @@
 
 #define BOOT_DEVICE_USB			0x2A
 #define BOOT_DEVICE_DFU			0x0A
+#define BOOT_DEVICE_NAND		0x0B
 #define BOOT_DEVICE_GPMC_NOR		0x0C
 #define BOOT_DEVICE_PCIE		0x0D
 #define BOOT_DEVICE_XSPI		0x0E
-- 
2.34.1

