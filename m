Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BE6C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 17:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50DE5828BC;
	Fri, 25 Apr 2025 19:02:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="o/miwVp+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95E17828F8; Fri, 25 Apr 2025 19:02:11 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20E76828B3
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 19:02:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53PH277D2842186
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 12:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745600527;
 bh=G4jXybzhNwPTZi4xsQ/RozWX+wO1UUFbKoNtEco/c8s=;
 h=From:Date:Subject:To:CC;
 b=o/miwVp+jjlRgxSkHZuE/NMv9JR7o7BKmgu0B7GoS8Kf6tYhEDqKgT3/KZqm6lYSO
 5QsHu2K97Prjhlzvh83dEBSTiCgtyVPv5NAiWJeTf6bYD01cmqnzN5/ObLgjv8GHbO
 BfYgDfftEsmGqJqRPLz/8VIkZaq4IMTtwr6zpEic=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53PH27m0013736
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Apr 2025 12:02:07 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 12:02:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 12:02:06 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53PH26He077158;
 Fri, 25 Apr 2025 12:02:06 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Fri, 25 Apr 2025 12:02:06 -0500
Subject: [PATCH] arm: mach-k3: use CFG_MAX_MEM_SIZE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250425-effective-memory-v1-1-8531fbfe81cd@ti.com>
X-B4-Tracking: v=1; b=H4sIAA3AC2gC/x3MSwqAIBRG4a3EHSeUGD22Eg0kf+sO1NCIQtp70
 vAbnJMpITISTVWmiIsTB1/Q1hWtu/YbBJtiko3sGiU7AWuxnnxBOLgQHzGYwYxQSvdSU8mOCMv
 3v5yX9/0A2y6c2GIAAAA=
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
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

Rather than hard coding the maximum memory size, lets just define the
CFG_MAX_MEM_SIZE so get_effective_memsize() will return the correct
value without modification.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/common.c | 4 ----
 arch/arm/mach-k3/common.h | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index fa8cd93d66485..fc230f180d0e6 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -228,10 +228,6 @@ void spl_enable_cache(void)
 	gd->arch.tlb_size = PGTABLE_SIZE;
 
 	gd->ram_top += get_effective_memsize();
-	/* keep ram_top in the 32-bit address space */
-	if (gd->ram_top >= 0x100000000)
-		gd->ram_top = (phys_addr_t)0x100000000;
-
 	gd->relocaddr = gd->ram_top;
 
 	ret = spl_reserve_video_from_ram_top();
diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index 2ec60c7879ad8..02c74731feab8 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -10,6 +10,9 @@
 #include <asm/hardware.h>
 #include <mach/security.h>
 
+/* keep ram_top in the 32-bit address space */
+#define CFG_MAX_MEM_MAPPED		0x100000000
+
 #define K3_FIREWALL_BACKGROUND_BIT (8)
 
 struct fwl_data {

---
base-commit: 9d3f1ebaf8751f0287b5d02158cc706435f8fb19
change-id: 20250425-effective-memory-8d8d9e44a72a

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

