Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC19C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A125382B72;
	Tue,  3 Jun 2025 16:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="g/Rw8z7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B29CD82B19; Tue,  3 Jun 2025 16:25:37 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE12282AE1
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 16:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 553EPY5Z3523007;
 Tue, 3 Jun 2025 09:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748960734;
 bh=4iNDeVbpaf8R595Z4v5c5V5GY4SmsDwHlzMRwGz218I=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=g/Rw8z7K0N+eMLZPXYr2tysK+8JCcxeh+6QzMkklYHUwGnGO011+9zGKG12l2yJiY
 voCtTczFXZZtvBNNZYuwkOiXHIeGJGOCWr3IthjPccmMZK3DiCI/V9eeSlWkgQflkY
 l3RjvlQ+kPwCieiU5VpzQQCqpuLiCTmFYa9BD158=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 553EPYmr1372012
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 3 Jun 2025 09:25:34 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Jun 2025 09:25:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Jun 2025 09:25:33 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 553EPXOL475425;
 Tue, 3 Jun 2025 09:25:33 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH v7 05/10] mach-k3: sysfw-loader: update img_hdr for falcon
Date: Tue, 3 Jun 2025 19:54:45 +0530
Message-ID: <20250603142452.2707171-6-anshuld@ti.com>
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

The returned legacy_img_hdr is used by booti_setup to compute the load
address for the kernel image.

This change ensures the kernel load address is CONFIG_SYS_LOAD_ADDR in
falcon boot.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/r5/sysfw-loader.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/r5/sysfw-loader.c b/arch/arm/mach-k3/r5/sysfw-loader.c
index 188731e673d..19607606965 100644
--- a/arch/arm/mach-k3/r5/sysfw-loader.c
+++ b/arch/arm/mach-k3/r5/sysfw-loader.c
@@ -89,7 +89,11 @@ static void *sysfw_load_address;
 struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
 {
 	if (sysfw_loaded)
-		return (struct legacy_img_hdr *)(CONFIG_TEXT_BASE + offset);
+		if (IS_ENABLED(CONFIG_SPL_OS_BOOT))
+			return (struct legacy_img_hdr *)CONFIG_SYS_LOAD_ADDR;
+		else
+			return (struct legacy_img_hdr *)(CONFIG_TEXT_BASE +
+							 offset);
 	else if (sysfw_load_address)
 		return sysfw_load_address;
 	else
-- 
2.49.0

