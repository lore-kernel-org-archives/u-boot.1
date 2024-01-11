Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E01DC47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 13:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FF668785F;
	Thu, 11 Jan 2024 14:21:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YKBAzJmg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2D5A877C8; Thu, 11 Jan 2024 14:21:39 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D60AE8761C
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 14:21:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 84216CE1E6A;
 Thu, 11 Jan 2024 13:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6AEC4160E;
 Thu, 11 Jan 2024 13:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704979177;
 bh=8ja47tWr/dp+w5cEyzPr1B4nKJ1DavwjdD9R1nF4CXQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YKBAzJmga8r+8qUcMHvDc+Ge+1YAiL2H6dWFmCMPHfdkk0l5wptfymPfTZZTO6+/0
 4RxWX6ijBHy3guCwjQ/jFgr2w8IKmKR0LmMc0kaMpAczjo4FiS1ZaGB5AdQk4z9Bqv
 80jxXmtr/1/bnc4zYP0tm1Lf9XiN+D9B3T+KtMybQ+27QKRh67MMfapZihmsIBdTGI
 J5triRZVGAI6ftSHmNQwF9p5Xtv3hGC/Kxg11l1SDsZQEs6wnOrcDK0ecJc5VMYKJO
 kgQlfBzSNqs7acqf4+2tbhTtFhpd1VaXfiB6tIdLquwgrJysir+LIfSfjU1FjhDvu7
 azPvc/MdMhfqg==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com, dario.binacchi@amarulasolutions.com,
 michael@amarulasolutions.com
Cc: vigneshr@ti.com, nm@ti.com, praneeth@ti.com, afd@ti.com, srk@ti.com,
 u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 4/4] arm: mach-k3: am642: Define NAND boot device
Date: Thu, 11 Jan 2024 15:19:20 +0200
Message-Id: <20240111131920.73691-5-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111131920.73691-1-rogerq@kernel.org>
References: <20240111131920.73691-1-rogerq@kernel.org>
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

Notes:
    v2: No change

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

