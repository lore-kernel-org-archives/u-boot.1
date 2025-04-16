Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E6CC369BA
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 07:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A02C382CD5;
	Wed, 16 Apr 2025 09:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rNtIn+MC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6019681E14; Wed, 16 Apr 2025 09:31:20 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B9A582CAC
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 09:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53G7VGU2261710
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 02:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744788676;
 bh=AmpM4CnpxuIMyG7lbIBBXUQOC2yUhMbtHgktcrkiUJw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=rNtIn+MCxAaaU2t1SjXakKNhatifTXcXY7MpWQBXVqS2m85V3z3TPADZhv20VO2wT
 H6pb2BfN3IwmJkg+hCG9C+1bdRFmkj1Z1WrFz1X8N0NHKr2Pebr6kXvoUEmCsHq0qW
 XpUd/ZjakI8dKo7iTpBt2eTrF4mC9AzW84sn46mc=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53G7VGWu120751
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 02:31:16 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 02:31:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 02:31:15 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53G7VFxg051440;
 Wed, 16 Apr 2025 02:31:15 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <nm@ti.com>, <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>
Subject: [PATCH v1 1/4] spl: Kconfig: k3: set SPL_TEXT_BASE to 0x82200000
Date: Wed, 16 Apr 2025 13:00:54 +0530
Message-ID: <20250416073058.1441001-2-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416073058.1441001-1-anshuld@ti.com>
References: <20250416073058.1441001-1-anshuld@ti.com>
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

In falcon boot, the kernel should be loaded to the same address as main
domain SPL, which necessitates the address to be 2MiB aligned[1].

Therefore this patch updates the SPL_TEXT_BASE to a 2MiB aligned
address.

[1]:
"The Image must be placed text_offset bytes from a 2MB aligned
baseaddress anywhere in usable system RAM and called there."
- Documentation/arch/arm64/booting.rst (linux kernel)

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 35161d02d19..6336b0635b1 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -270,7 +270,7 @@ config SPL_TEXT_BASE
 	default 0x40200000 if OMAP34XX
 	default 0x402F4000 if AM43XX
 	default 0x402F0400 if AM33XX
-	default 0x80080000 if ARCH_K3 && ARM64
+	default 0x82200000 if ARCH_K3 && ARM64
 	default 0x43c00000 if ARCH_K3 && !ARM64
 	default 0x00908000 if ARCH_MX6
 	default 0x00912000 if ARCH_MX7
-- 
2.49.0

