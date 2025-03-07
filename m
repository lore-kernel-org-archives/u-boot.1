Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7A0C282D0
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 07:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 550AE81428;
	Fri,  7 Mar 2025 08:56:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="u3t34Xq6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABDAC80F4C; Fri,  7 Mar 2025 08:56:26 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22A5981298
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 08:56:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5277uMUL309410
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 7 Mar 2025 01:56:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741334182;
 bh=Qn8V4GRGrvxfIzJh6M/Eb1kRtQnBt/HSu79/SmWO+cw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=u3t34Xq69XhSQie20NPX9VloLye+X0TttxfSSLz9dfwmeKhpnAZhnEo5VFvGOzrIQ
 K+F4c75YrkhZlIfCY139cAPJN4Fg4QRTPvKb6kB+o2k3vgPXapZYpBHr4Qj0MQCjFl
 Xf9JS8n9wBel64EbehXpC85k/w79JwCrYOC3XEhk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5277uMqU048172;
 Fri, 7 Mar 2025 01:56:22 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Mar 2025 01:56:22 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Mar 2025 01:56:21 -0600
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.86])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5277uL2o015062;
 Fri, 7 Mar 2025 01:56:21 -0600
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
Subject: [PATCH 03/10] mach-k3: fix reading size and addr from fdt on R5
Date: Fri, 7 Mar 2025 13:25:31 +0530
Message-ID: <20250307075541.2571104-4-anshuld@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307075541.2571104-1-anshuld@ti.com>
References: <20250307075541.2571104-1-anshuld@ti.com>
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

