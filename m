Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B80C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 08:05:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D01780C93;
	Mon, 16 Jun 2025 10:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ODjV9ENA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09A2C81E18; Mon, 16 Jun 2025 10:05:16 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1B168007D
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 10:05:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55G85B7b3766641;
 Mon, 16 Jun 2025 03:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750061112;
 bh=9uObKwloUc9EINVGzX/XlS5N0YqNjribFJw0SgGvZeA=;
 h=From:To:CC:Subject:Date;
 b=ODjV9ENA2+bvnILL2r1Z3jJF0vb3YCvIua1NcinrKfH94L+DDgWD2ESDAJL7CFXb+
 sQVK+HLgGSo1flGyBC5FSG4BeaCS1YeWeuZJTd6ckc6aDEM1zpjDLc5eLto3seL5Qx
 6mCsfEHVGl/xsN+K/88pOtEY9wbZ8taZgouLUgo4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55G85B4b769757
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 16 Jun 2025 03:05:11 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 16
 Jun 2025 03:05:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 16 Jun 2025 03:05:11 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55G85A8p3705224;
 Mon, 16 Jun 2025 03:05:11 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>
Subject: [PATCH v1] arm: Kconfig: enable LTO for ARCH_K3
Date: Mon, 16 Jun 2025 13:34:30 +0530
Message-ID: <20250616080431.3548976-1-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
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

CONFIG_LTO enables Link Time Optimizations that helps in reducing binary
size. The config has been validated on all K3 platforms so can be safely
enabled.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6ff3f2750ea..ab7ed0b8e77 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -820,6 +820,7 @@ config ARCH_K3
 	select FIT
 	select REGEX
 	select FIT_SIGNATURE if ARM64
+	select LTO
 	imply TI_SECURE_DEVICE
 
 config ARCH_OMAP2PLUS
-- 
2.49.0

