Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82443CCD193
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 10:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A664C835FE;
	Wed, 15 Oct 2025 12:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EBdIMgam";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18F7780107; Wed, 15 Oct 2025 12:47:15 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28D94834D4
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 12:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59FAlBVB1824285;
 Wed, 15 Oct 2025 05:47:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760525231;
 bh=lQ16JfD5MVNyaVEUXc/oryxx6+AhqiptPePsJtxRXnw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=EBdIMgamEFk01JmNY+mlpjumm/X3WtijSaqgqU9HBtGY4clcO5wDemrqDXXQrfgtx
 geTvSl066I3QPwojp/lCbZsA0tIHM0M96hiBaYaB/b6HD/d1hQ1GpchrKTyM5P7RJf
 E890Ewo1AF2WHQS28M/Kqs9XKThE3gCcumnbCFkE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59FAlBTB349491
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 15 Oct 2025 05:47:11 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 15
 Oct 2025 05:47:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 05:47:11 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59FAlAi81778514;
 Wed, 15 Oct 2025 05:47:10 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH v2 3/5] arm: mach-k3: enable support for falcon mode
Date: Wed, 15 Oct 2025 16:16:45 +0530
Message-ID: <20251015104702.3726411-4-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015104702.3726411-1-anshuld@ti.com>
References: <20251015104702.3726411-1-anshuld@ti.com>
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

With CONFIG_SPL_OS_BOOT enabled, U-Boot checks for the return value of
spl_start_uboot to select between falcon or the regular boot flow. Where
a return value of 0 means 'boot to linux'.

This patch overrides the weak definition form common/spl/spl.c to allow
K3 devices to use falcon mode with SPL_OS_BOOT enabled.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/common.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 5483ac9906c..c1a4aa1cf9d 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -303,6 +303,14 @@ static __maybe_unused void k3_dma_remove(void)
 		pr_warn("DMA Device not found (err=%d)\n", rc);
 }
 
+#ifdef CONFIG_SPL_OS_BOOT
+int spl_start_uboot(void)
+{
+	/* Always boot to linux on Cortex A SPL with CONFIG_SPL_OS_BOOT set */
+	return 0;
+}
+#endif
+
 void spl_board_prepare_for_boot(void)
 {
 #if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
-- 
2.51.0

