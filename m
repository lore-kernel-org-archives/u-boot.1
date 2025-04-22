Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46474C369CB
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 09:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6119E81E72;
	Tue, 22 Apr 2025 11:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sjG2gZff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 827D680C93; Tue, 22 Apr 2025 11:54:43 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CF4C819FC
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 11:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53M9sdQ51174285
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Apr 2025 04:54:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745315679;
 bh=+tbGd1lyEhtqpr3z6CK77mYLORxtbGkwxHeZJhq4at0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=sjG2gZffufmEGoCV4xUzHLgUk2BIpZ4kY+5q8u2G2kPpMzZYNJKESx9dcMvvgqYe6
 hlBMGVcwiNvTBkZ66v+8UbjWKudmdgzq11QhpesghVjdM6JhzfqiPU87I7GtKEM95C
 pCrh1C7pA4l2bp6kTRUWrF99qZcXYHQCvU6J5Gm4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53M9sd2X056676
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Apr 2025 04:54:39 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Apr 2025 04:54:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Apr 2025 04:54:39 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53M9sVGV088247;
 Tue, 22 Apr 2025 04:54:37 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>,
 <jm@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 2/4] arm: dts: k3-binman: Add template for packing HSM firmware
Date: Tue, 22 Apr 2025 15:24:28 +0530
Message-ID: <20250422095430.363792-3-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422095430.363792-1-b-padhi@ti.com>
References: <20250422095430.363792-1-b-padhi@ti.com>
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

The HSM M4 core needs to be booted at R5 SPL stage so that it can be
used for further Authentication and security services. Therefore, the
firmware for the HSM core needs to be packed in tispl.bin fit image so
that it can be used by R5 SPL to boot the HSM core.

Add a template for packing the HSM firmware in tispl.bin. The size of
HSM firmware is padded upto 256 KB. The HSM binaries are unloaded at a
temporary DDR address.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm/dts/k3-binman.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 5163161b94d..c2b8388b06e 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -297,6 +297,17 @@
 					};
 				};
 
+#ifdef CONFIG_K3_HSM_FW
+				hsm {
+					description = "HSM binary";
+					type = "standalone";
+					compression = "none";
+					os = "hsm";
+					load = <0x82000000>;
+					entry = <0x82000000>;
+				};
+#endif
+
 				dm {
 					description = "DM binary";
 					type = "firmware";
-- 
2.34.1

