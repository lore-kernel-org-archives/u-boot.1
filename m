Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F49C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:26:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E49E682B3D;
	Tue,  3 Jun 2025 16:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hMcGxRSF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00B3382B3D; Tue,  3 Jun 2025 16:25:35 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 012C282AFC
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 16:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 553EPVH23536162;
 Tue, 3 Jun 2025 09:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748960731;
 bh=6Xcyd3DnRN127QEvLxGv131RZK1WBH1jJ0AzfNeF0zM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=hMcGxRSFssldNK4Ku+tsvrPAlDxhbMQKEUeMGkfCKqIkpYHgGLzWlxGMxXV7vdA0q
 8ZjtyDqvVUJmQ72WLIkwOVFvnapKORMfybfpFm/iPsrbrxap8LR2HpnEcNGjae28O0
 aUHxdSOajKPX9INr3OKnw1Q0oGVqMB2Sfuv0hdM8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 553EPVTI3585374
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 3 Jun 2025 09:25:31 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Jun 2025 09:25:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Jun 2025 09:25:30 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 553EPUYx475345;
 Tue, 3 Jun 2025 09:25:30 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH v7 03/10] mach-k3: fix reading size and addr from fdt on R5
Date: Tue, 3 Jun 2025 19:54:43 +0530
Message-ID: <20250603142452.2707171-4-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603142452.2707171-1-anshuld@ti.com>
References: <20250603142452.2707171-1-anshuld@ti.com>
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

fdtdec_get_addr_size uses architecture dependent datatypes which causes
the 32-bit R5 to fail when reading the 64-bit size and addr fields of
reg nodes from the fdt.

This changes it to a common api for both 64 and 32 bit platforms.
Now fdt fixups can be applied to the fdt from R5.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/common_fdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
index 867ed173142..4824650ac76 100644
--- a/arch/arm/mach-k3/common_fdt.c
+++ b/arch/arm/mach-k3/common_fdt.c
@@ -140,7 +140,9 @@ int fdt_fixup_reserved(void *blob, const char *name,
 			return -EINVAL;
 		if (!strncmp(node_name, name, strlen(name))) {
 			/* Read out old size first */
-			addr = fdtdec_get_addr_size(blob, subnode, "reg", &size);
+			addr = fdtdec_get_addr_size_fixed(
+				blob, subnode, "reg", 0, 8 / sizeof(fdt32_t),
+				8 / sizeof(fdt32_t), &size, false);
 			if (addr == FDT_ADDR_T_NONE)
 				return -EINVAL;
 			new_size = size;
-- 
2.49.0

