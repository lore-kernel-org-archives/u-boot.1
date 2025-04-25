Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62DEC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 14:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 409E9828F8;
	Fri, 25 Apr 2025 16:57:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DuaABKE3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94CFE828A2; Fri, 25 Apr 2025 16:57:09 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8944B82115
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 16:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53PEv5Bm2199885
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 09:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745593026;
 bh=Y6OEXPHeNq9YwcKH5vbYqeMUH2MV+IW9Ggh6z6wGGDs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=DuaABKE3b6e83be521Y5/gJ1GHVSDZx0cBIEEK1wBdh1pQFYe+ZNeuo0rTzBaKHMo
 2zqS6Mbvk96xJDIGrdvx8L6MJnTO+AlL0E9puAjYYNdHaYjN57FmfUVolWMvHOvyOZ
 JSb0f4cUeDg7Vron2gJvVD7waNc6jWhBmBIts7TM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53PEv5f0023241
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Apr 2025 09:57:05 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 09:57:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 09:57:05 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53PEv4So056592;
 Fri, 25 Apr 2025 09:57:04 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <khasim@ti.com>, <vigneshr@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <m-chawdhry@ti.com>,
 <n-francis@ti.com>, <b-liu@ti.com>
Subject: [PATCH v5 2/9] mach-k3: fix reading size and addr from fdt on R5
Date: Fri, 25 Apr 2025 20:26:33 +0530
Message-ID: <20250425145644.2228186-3-anshuld@ti.com>
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
index 361b0c0b31b..c227743f9f8 100644
--- a/arch/arm/mach-k3/common_fdt.c
+++ b/arch/arm/mach-k3/common_fdt.c
@@ -137,7 +137,9 @@ int fdt_fixup_reserved(void *blob, const char *name,
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

