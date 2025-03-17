Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4FAC282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 06:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4753A810F4;
	Mon, 17 Mar 2025 07:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dUqkP+AV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 045C781100; Mon, 17 Mar 2025 07:45:24 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7B8880F4C
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 07:45:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52H6jIFf2713546
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Mar 2025 01:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742193918;
 bh=FfAbxy1ALg0EB5cq7bGQqDvQFwbRwoKAsbds8B1jSYg=;
 h=From:To:CC:Subject:Date;
 b=dUqkP+AVrfwSvU7FAuauBrEJIv5CSc1jyi16Tmm98yRTZBrvJXNG9fQZZkZL6kS8l
 BLVf+aF4/p4f7UdkLF3jv64LLR1Cpf1W52OwfS7PRdumIXdiL5gRWSpQPhHJw3dIhN
 hmdHdkyyyELY2U/UNDrZPysrK6XMhVxxP6btoeUY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52H6jI83049888
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Mar 2025 01:45:18 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Mar 2025 01:45:18 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Mar 2025 01:45:17 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [172.24.227.142])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52H6jEpw063994;
 Mon, 17 Mar 2025 01:45:15 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <vaishnav.a@ti.com>
Subject: [PATCH] common: spl: Enable Instruction cache after relocation in
 board_init_r
Date: Mon, 17 Mar 2025 12:15:07 +0530
Message-ID: <20250317064507.1702120-1-p-mantena@ti.com>
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

ICACHE is enabled in board_init_f which executes only before relocation.
Instruction cache invalidation is needed after relocation as well in the
common spl, which is taken care in the u-boot init_sequence, but missing
for the spl. So, enable it at the start of board_init_r for spl, which
invalidates icache needed after instruction relocation.

Fixes: 52a86e69e20 ("arm: k3: Enable instruction cache for main domain SPL")
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/mach-k3/common.c | 1 +
 common/spl/spl.c          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index fa8cd93d664..e4eb33512e7 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -266,6 +266,7 @@ static __maybe_unused void k3_dma_remove(void)
 void spl_board_prepare_for_boot(void)
 {
 #if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
+	icache_disable();
 	dcache_disable();
 #endif
 #if IS_ENABLED(CONFIG_SPL_DMA) && IS_ENABLED(CONFIG_SPL_DM_DEVICE_REMOVE)
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 76fd56dfe4b..1db9a258e35 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -696,6 +696,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	debug(">>" PHASE_PROMPT "board_init_r()\n");
 
 	spl_set_bd();
+	enable_caches();
 
 	if (IS_ENABLED(CONFIG_SPL_SYS_MALLOC)) {
 		mem_malloc_init(SPL_SYS_MALLOC_START, SPL_SYS_MALLOC_SIZE);
-- 
2.34.1

