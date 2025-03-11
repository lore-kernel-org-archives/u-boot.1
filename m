Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F741C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 09:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0527081703;
	Tue, 11 Mar 2025 10:58:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="S/nbHHeb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B67B6807D7; Tue, 11 Mar 2025 10:58:15 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0FA3807D7
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 10:58:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52B9wBOI1157700
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Mar 2025 04:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741687091;
 bh=Qn8V4GRGrvxfIzJh6M/Eb1kRtQnBt/HSu79/SmWO+cw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=S/nbHHebaMt2C48zt9Y3/wVqEb61iSjiodcdVaSWWRFTr4r5niBDYVxVe6Ydrgf0P
 dnRaKChv93kfVJVbEPOW7AN8jyfOwQdqkOKQ2THtEmp1qTQqIr9Ofwd054TgcIJA70
 eXV44f+3KLdIo9r6ppCCwS2n5f+4rNIkFy9el8sQ=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52B9wBMJ022568
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 11 Mar 2025 04:58:11 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Mar 2025 04:58:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Mar 2025 04:58:11 -0500
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.225])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52B9wAYa040677;
 Tue, 11 Mar 2025 04:58:11 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
Subject: [PATCH v2 2/8] mach-k3: fix reading size and addr from fdt on R5
Date: Tue, 11 Mar 2025 15:27:51 +0530
Message-ID: <20250311095758.3383047-3-anshuld@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311095758.3383047-1-anshuld@ti.com>
References: <20250311095758.3383047-1-anshuld@ti.com>
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
index 4a016711566..02a3e2c7748 100644
--- a/arch/arm/mach-k3/common_fdt.c
+++ b/arch/arm/mach-k3/common_fdt.c
@@ -139,7 +139,9 @@ int fdt_fixup_reserved(void *blob, const char *name,
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
2.43.0

