Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77AFCA101F
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 12:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3356083542;
	Fri, 12 Sep 2025 14:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fwT2b/Cf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40CB7834E5; Fri, 12 Sep 2025 14:16:45 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBDD983281
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 14:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58CCGdMB600691;
 Fri, 12 Sep 2025 07:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757679399;
 bh=+Xa2xeghfzXR31Yp+6nJerznIVTHYBJ5OmMYgocPaEg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=fwT2b/CfiSj2quBKH19LlwOAAD+N3QIS3xrhq60Ui3PD9pOJE1z3g89tbXU8oie2F
 405c//IbGQuEwGLicaX8TtmKMp13Dmk4LFn1dWVUVVydcLlQ1CL37q3QGf1tMc6bxz
 rjE4gmj+ind7tiYM5zzKSL1K4VEFvH1OvHnTb2PM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58CCGdKn1288032
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 12 Sep 2025 07:16:39 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 07:16:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 07:16:38 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58CCGbwC3886353;
 Fri, 12 Sep 2025 07:16:38 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>,
 <devarsht@ti.com>, <ilias.apalodimas@linaro.org>
Subject: [PATCH -next v7 09/10] mach-k3: add reserved memory fixups for next
 boot stage
Date: Fri, 12 Sep 2025 17:46:16 +0530
Message-ID: <20250912121618.1074054-10-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912121618.1074054-1-anshuld@ti.com>
References: <20250912121618.1074054-1-anshuld@ti.com>
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

The boot flow in K3 platforms requires the subsequent boot stages to be
aware of the memory reserved for previous boot binaries. In the regular
boot sequence of:

R5 SPL -> ATF -> OP-TEE -> A-core SPL -> U-Boot -> Kernel,

Both A-core SPL and U-Boot should be made aware of the memory reserved
for ATF and OP-TEE from their device-tree. Currently this information is
absent.

Therefore this patch adds the reserved-memory regions as part of
spl_perform_arch_fixups for the next stage's DT. This is called during
both R5 and A-core SPL which fixes up the DT for their respective next
stages: A-core SPL and U-Boot proper.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
Tested-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/mach-k3/common.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 0a73b1fa296..581a7246630 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -321,6 +321,17 @@ static __maybe_unused void k3_dma_remove(void)
 		pr_warn("DMA Device not found (err=%d)\n", rc);
 }
 
+void spl_perform_arch_fixups(struct spl_image_info *spl_image)
+{
+	void *fdt = spl_image_fdt_addr(spl_image);
+
+	if (!fdt)
+		return;
+
+	fdt_fixup_reserved(fdt, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
+	fdt_fixup_reserved(fdt, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
+}
+
 void spl_board_prepare_for_boot(void)
 {
 #if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
-- 
2.51.0

