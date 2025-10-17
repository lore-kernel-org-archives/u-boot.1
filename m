Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42483CCD1A4
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 13:17:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69F01838AE;
	Fri, 17 Oct 2025 15:16:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vR9NrM/K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F408838C7; Fri, 17 Oct 2025 15:16:10 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8496A838AE
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 15:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59HDG3TI2368726;
 Fri, 17 Oct 2025 08:16:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760706963;
 bh=bOeadQkXKPJ3FbdGHkEWRNFKY0BtH2zurWretIqUq7Q=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=vR9NrM/KJozYoWuoncfy9IXyszGtuQgih6v3xQFor5Es2NjLLhDXnCn0OVRzT9z4Z
 BEMU8i9cZFcyTR4RUCSk5Y1DNDVolaelg96iMKYxCQFPxAfPFP6Tb5Kk1E+2NOX4F/
 rbhvaPCQE0riTpGRO4YhC4vZqVGGrgIk2QSiIt/s=
Received: from DLEE214.ent.ti.com (dlee214.ent.ti.com [157.170.170.117])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59HDG3Gx2022014
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 17 Oct 2025 08:16:03 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Oct
 2025 08:16:03 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Oct 2025 08:16:03 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59HDG18r1343527;
 Fri, 17 Oct 2025 08:16:02 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>,
 <devarsht@ti.com>, <ilias.apalodimas@linaro.org>, <xypron.glpk@gmx.de>
Subject: [PATCH v11 11/11] arm: mach-k3: reserve space for page table entries
Date: Fri, 17 Oct 2025 18:45:33 +0530
Message-ID: <20251017131540.3636067-12-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017131540.3636067-1-anshuld@ti.com>
References: <20251017131540.3636067-1-anshuld@ti.com>
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

With the memory map configuration being done dynamically, reserve extra
space during U-Boot relocation to ensure we have enough for the fixups.

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/arm64/arm64-mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-k3/arm64/arm64-mmu.c b/arch/arm/mach-k3/arm64/arm64-mmu.c
index 479451452a2..f999af143fb 100644
--- a/arch/arm/mach-k3/arm64/arm64-mmu.c
+++ b/arch/arm/mach-k3/arm64/arm64-mmu.c
@@ -41,3 +41,8 @@ struct mm_region k3_mem_map[K3_MEM_MAP_LEN] = {
 };
 
 struct mm_region *mem_map = k3_mem_map;
+
+u64 get_page_table_size(void)
+{
+	return SZ_128K;
+}
-- 
2.51.0

