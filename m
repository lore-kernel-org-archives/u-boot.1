Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B8EC36014
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 21:59:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F299B82849;
	Thu,  3 Apr 2025 23:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BUx6/XDV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01CE482836; Thu,  3 Apr 2025 23:59:32 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FD5E8215D
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 23:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 533LxRxR3796637
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Apr 2025 16:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1743717567;
 bh=xqNqKLcvCf8NvhjcFVmpSHBavs7j0c18vU+7DiP/fXA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=BUx6/XDVWJmovhdr+Tn9BixdpBihB0Q1o35ecrGSDDVsgeHePCPCnaBI7zzBjs2N3
 7yWzmgd0vCmDl2NnoAvOy8iGhq/NQhZC02fXI9fxFW122Go4J2apBICtMBoc0GhJbZ
 ADuRioUIzvLgjyBAt8ZZ22XN3+owUxUeh4KmwpuM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 533LxReQ086305
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 3 Apr 2025 16:59:27 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Apr 2025 16:59:27 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Apr 2025 16:59:27 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 533LxQol115302;
 Thu, 3 Apr 2025 16:59:26 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
Subject: [PATCH v3 02/10] mach-k3: fix reading size and addr from fdt on R5
Date: Fri, 4 Apr 2025 03:28:59 +0530
Message-ID: <20250403215910.1292922-3-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403215910.1292922-1-anshuld@ti.com>
References: <20250403215910.1292922-1-anshuld@ti.com>
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
2.49.0

