Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBCFC369CB
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 09:54:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B7DC817C4;
	Tue, 22 Apr 2025 11:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZIKj0Aom";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B57C5809A5; Tue, 22 Apr 2025 11:54:40 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B89E9810E8
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 11:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53M9sbRU1906129
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Apr 2025 04:54:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745315677;
 bh=206lHiNZCYNXpJqvKEl/BpTtMVpdMVYDFLfjQT5RlKg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ZIKj0Aom9i5Y1V0AmC+/4Urz0D16ZuCdqHrJOx3SGadjCK8B5Dqvd7oojg0gtvOtR
 jPnPBoW97wWOwu13cPXTzvgo/kbXFxMpD2/Pr5xpu4r8/XWwGdpbXecP381kMafoT0
 rlLjpaIgnGoBvdowKo6TUhF/tpoJuAbBgziSN7xU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53M9sbTX080189
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Apr 2025 04:54:37 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Apr 2025 04:54:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Apr 2025 04:54:37 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53M9sVGU088247;
 Tue, 22 Apr 2025 04:54:34 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>,
 <jm@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 1/4] arm: mach-k3: Add config option for booting HSM core
Date: Tue, 22 Apr 2025 15:24:27 +0530
Message-ID: <20250422095430.363792-2-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422095430.363792-1-b-padhi@ti.com>
References: <20250422095430.363792-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Some K3 SoCs like J721S2, and J784S4 have a HSM (High Security Module)
M4F core in the Wakeup Voltage Domain which could be used to run secure
services like Authentication. Add a config option which indicates that
the SoC has a HSM core and the firmware for the core is available.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm/mach-k3/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 1b8c0b1eb96..b787d2da244 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -181,6 +181,14 @@ config K3_REMOTEPROC_PRU
 	imply REMOTEPROC_TI_PRU
 	default y if (SOC_K3_AM642 || SOC_K3_AM654)
 
+config K3_HSM_FW
+	bool "Load and Boot HSM core"
+	default n
+	help
+	  Enabling this will indicate that the system has a HSM (High Security
+	  Module) M4 Core and the firmware for the core is present. When
+	  enabled, HSM core will be booted at R5 SPL execution time.
+
 if CPU_V7R
 source "arch/arm/mach-k3/r5/Kconfig"
 endif
-- 
2.34.1

