Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F5BC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 14:57:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED48F82887;
	Fri, 25 Apr 2025 16:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gArbM8M4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FB1A828A2; Fri, 25 Apr 2025 16:57:08 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8B36826AD
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 16:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53PEv49D2199805
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 09:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745593024;
 bh=UfaKJz8tO4M71JItb/5J52Dn9LUiYx/OApPNKclKgO0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=gArbM8M4cuf6IVUOhIT4s5ze6EBBXaWyloNnOArnuto1XJYAq1OdlE5ypahR+L65p
 QeuDpDfWfP78z1oCFd9m3XxDqENZEluklX9iBuLdWzH6gGwoCEq3TH/OQlTOrU4ttr
 VrfEzJK/v1VHZnTlk805VFy8DH0+pNM6oirn275o=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53PEv4IP031058
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Apr 2025 09:57:04 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 09:57:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 09:57:03 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53PEv3I0056545;
 Fri, 25 Apr 2025 09:57:03 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <khasim@ti.com>, <vigneshr@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <m-chawdhry@ti.com>,
 <n-francis@ti.com>, <b-liu@ti.com>
Subject: [PATCH v5 1/9] spl: Kconfig: allow K3 devices to use falcon mode
Date: Fri, 25 Apr 2025 20:26:32 +0530
Message-ID: <20250425145644.2228186-2-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425145644.2228186-1-anshuld@ti.com>
References: <20250425145644.2228186-1-anshuld@ti.com>
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

Falcon mode was disabled for TI_SECURE_DEVICE at commit e95b9b4437bc
("ti_armv7_common: Disable Falcon Mode on HS devices") for older 32-bit
HS devices and can be enabled on K3 devices.

For secure boot, the kernel with x509 headers can be packaged in a fit
container (fitImage) signed with TIFS keys for authentication.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index c08045f9c8d..68e900e9b91 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1165,7 +1165,7 @@ config SPL_ONENAND_SUPPORT
 
 config SPL_OS_BOOT
 	bool "Activate Falcon Mode"
-	depends on !TI_SECURE_DEVICE
+	depends on !TI_SECURE_DEVICE || ARCH_K3
 	help
 	  Enable booting directly to an OS from SPL.
 	  for more info read doc/README.falcon
-- 
2.49.0

