Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FB0C19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 07:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76B7A808A2;
	Fri,  7 Mar 2025 08:56:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UYFaTf+t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5C0B81335; Fri,  7 Mar 2025 08:56:31 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE21A81433
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 08:56:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5277uSke3903673
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Mar 2025 01:56:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741334188;
 bh=7IHxULhC0YG/oYWglh/9dlseZiS9s2oWpFYjpwf9nPc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=UYFaTf+ty2P+BNGbE0q7+hALqt4KnjDch00bXgkea1hoUgC+skdphm7XjEsRKlKb6
 mpTQg2snvSYfGKaFuxiRl47ZaoDEkk0V4cXKS4CSoT4p6qvgHYBqghmfjB9a1/U38/
 wXRuLFaKrF/S0o3vZBWG7OExzMjb/4r1VcD71YAc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5277uSpT105404
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Mar 2025 01:56:28 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Mar 2025 01:56:27 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Mar 2025 01:56:27 -0600
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.86])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5277uRIG086109;
 Fri, 7 Mar 2025 01:56:27 -0600
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
Subject: [PATCH 07/10] mach-k3: sysfw-loader: update img_hdr for falcon
Date: Fri, 7 Mar 2025 13:25:35 +0530
Message-ID: <20250307075541.2571104-8-anshuld@ti.com>
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

