Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8133DC28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 09:59:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AF958191C;
	Tue, 11 Mar 2025 10:58:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="zC1khIBP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44F8C817D8; Tue, 11 Mar 2025 10:58:21 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DFC381760
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 10:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52B9wH201257166
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Mar 2025 04:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741687097;
 bh=7IHxULhC0YG/oYWglh/9dlseZiS9s2oWpFYjpwf9nPc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=zC1khIBP0wVcNfZUBg8jO6F+sjBs0gXeo0d35eXcBfvKSGj6y+cX+VYq77niunYzf
 TlHawjYDlHV2tjpuMI7CchObcX0BNKz6d3PIlii0ggnG1pQ6MfOt3Yt4D0d8q1J5ic
 sdGlyhTXZdZ2H+c8Q64qwm8lV5aZmwL2ERMokx2s=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52B9wHNx002243
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 11 Mar 2025 04:58:17 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Mar 2025 04:58:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Mar 2025 04:58:17 -0500
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.225])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52B9wGbH108523;
 Tue, 11 Mar 2025 04:58:17 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
Subject: [PATCH v2 6/8] mach-k3: sysfw-loader: update img_hdr for falcon
Date: Tue, 11 Mar 2025 15:27:55 +0530
Message-ID: <20250311095758.3383047-7-anshuld@ti.com>
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
2.43.0

