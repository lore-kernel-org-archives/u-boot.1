Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8726AC48BC1
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 16:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12BCF87E4F;
	Wed, 14 Feb 2024 17:30:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SyV/IJ3Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49E3E87ECE; Wed, 14 Feb 2024 17:30:26 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 173AE87E4F
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 17:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41EGUCI9103518;
 Wed, 14 Feb 2024 10:30:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707928212;
 bh=wHoRk1rfyT7yVa71EwoUY79HWviVdeYvA+u/Z9gauMs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=SyV/IJ3Qa2FXK15sRqNl8hoVd0Rb4dPV7kW9gXGXyR7S41YwZXWZZt/zUZVDUX9RP
 M1rowmhQUAwIMf7wY/J0UiiWozReIrOcnwX63/5XnEHSKKIKn/BsvI8qDK/4x/53X+
 bcnJ2CrzKExM0NG3AsqWlVItEaaZebo14wnxv1+8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41EGUCdR079740
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 14 Feb 2024 10:30:12 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Feb 2024 10:30:12 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Feb 2024 10:30:12 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41EGU9rx014388;
 Wed, 14 Feb 2024 10:30:11 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 6/6] arm: mach-k3: Move DRAM address of ATF for AM62/AM62a
Date: Wed, 14 Feb 2024 10:30:09 -0600
Message-ID: <20240214163009.983034-7-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240214163009.983034-1-afd@ti.com>
References: <20240214163009.983034-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

The current address of TF-A in DRAM is just below the 512MB address line.
This means if the DRAM in a system is 512MB then TF-A is right at the
end of memory which is often reused, for instance U-Boot relocates itself
here. If a system has less than 512MB then that system wouldn't work at
all as TF-A would fail to load.

To avoid the issues above, move TF-A to the start of DRAM, which doesn't
change from system to system.

As TF-A is position independent, this has no dependency on TF-A. We
also fixup DT as needed when TF-A address is moved, so this change also
has no dependency on Linux and is fully forward/backward compatible.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-k3/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 55bb874d9aa..33f20f61f83 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -123,7 +123,7 @@ config SYS_K3_SPL_ATF
 
 config K3_ATF_LOAD_ADDR
 	hex "Load address of ATF image"
-	default 0x9e780000 if (SOC_K3_AM625 || SOC_K3_AM62A7)
+	default 0x80000000 if (SOC_K3_AM625 || SOC_K3_AM62A7)
 	default 0x70000000
 	help
 	  The load address for the ATF image. This value is used to build the
-- 
2.39.2

