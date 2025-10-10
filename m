Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260B1CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 13:46:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0F9B844B1;
	Fri, 10 Oct 2025 15:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="J3G9l2y2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73EF2845B4; Fri, 10 Oct 2025 15:44:58 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0188E84595
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 15:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59ADinVQ698313;
 Fri, 10 Oct 2025 08:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760103889;
 bh=LhxoT3vy/YnaunorY/1/LmiXdiFYOYw3AJyDed7puyU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=J3G9l2y2VM5xms2yHJtmNvX1ez6J21xmqRwHi87P7xmc68apvRV+rY/5sgQLHrTFT
 NnTLhLG4stR0FEHNmpPm+VybUnIqvuNUTV/554De91OL3j0UO/6jblTApO7qbU7+Yu
 DuVbLpoFPCqbq3Y+0npU2Zv7zdv5hVZ5wkmuoNIc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59ADine32237644
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 10 Oct 2025 08:44:49 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 10
 Oct 2025 08:44:48 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Oct 2025 08:44:48 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59ADilYX1722193;
 Fri, 10 Oct 2025 08:44:48 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>,
 <devarsht@ti.com>, <ilias.apalodimas@linaro.org>, <xypron.glpk@gmx.de>
Subject: [PATCH v10 09/11] mach-k3: add reserved memory fixups for next boot
 stage
Date: Fri, 10 Oct 2025 19:14:15 +0530
Message-ID: <20251010134424.3835757-10-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010134424.3835757-1-anshuld@ti.com>
References: <20251010134424.3835757-1-anshuld@ti.com>
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

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
Tested-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/mach-k3/common.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 30ad98a68a2..f734f10b605 100644
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

