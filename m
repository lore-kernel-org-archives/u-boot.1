Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF091CA0EFA
	for <u-boot@archiver.kernel.org>; Sat, 23 Aug 2025 08:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A00B82BA7;
	Sat, 23 Aug 2025 10:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tUyUd7UF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EF3581D5D; Sat, 23 Aug 2025 10:06:33 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4DC981D5D
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 10:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57N86S1G880613;
 Sat, 23 Aug 2025 03:06:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755936388;
 bh=7Ou64el8nNsnaAJ1DT+a96A/Ro1451+R+vldXNdf5LU=;
 h=From:To:CC:Subject:Date;
 b=tUyUd7UFEnDwq1u6ts9831lH0XnmEms0QG/qyzParFBoOx8CD2pa2NGnWYoYDr2lA
 /pMq6Iymog/0gvMafKG+jmrBKNKkf/kwKZ5TMwyk6EsceTmLENETrbo3Q1QwbkWOtI
 IhGXw9Aww71JFXOHoWeev+wgBnd5lQ3FyNBzsvPo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57N86SVW3506226
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Sat, 23 Aug 2025 03:06:28 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 23
 Aug 2025 03:06:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sat, 23 Aug 2025 03:06:28 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.198])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57N86P51845397;
 Sat, 23 Aug 2025 03:06:26 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Jared McArthur <j-mcarthur@ti.com>
Subject: [PATCH] arm: mach-k3: increase max resasg_entries
Date: Sat, 23 Aug 2025 13:36:15 +0530
Message-ID: <20250823080615.1899597-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
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

Increase max resasg_entries to accommodate max size of
largest device J784S4[0].

[0]: https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j784s4/resasg_types.html

Reported-by: Jared McArthur <j-mcarthur@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm/mach-k3/schema.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/schema.yaml b/arch/arm/mach-k3/schema.yaml
index c8dd2e79e7d..8c4691f24ed 100644
--- a/arch/arm/mach-k3/schema.yaml
+++ b/arch/arm/mach-k3/schema.yaml
@@ -344,7 +344,7 @@ properties:
             resasg_entries:
                 type: array
                 minItems: 0
-                maxItems: 468
+                maxItems: 586
                 items:
                     type: object
                     properties:
@@ -420,7 +420,7 @@ properties:
             resasg_entries:
                 type: array
                 minItems: 0
-                maxItems: 468
+                maxItems: 586
                 items:
                     type: object
                     properties:
-- 
2.34.1

