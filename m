Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4067BE77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 09:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21251892A0;
	Thu,  5 Dec 2024 10:24:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PJHqQ1+o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98480892A0; Thu,  5 Dec 2024 10:24:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35DF189282
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 10:24:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733390667; x=1764926667;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jjnoqrIX6D0/8/v3hVgDf+gxx7CUs0wt7XK0lAMCG8k=;
 b=PJHqQ1+ojj0QBm2m2pOUvyUNoMPIiu3gGpTZXWZMOdFF/cEt0MDYATIL
 qgSR8KQKF4YHp8fTmAuyB5Ikw8rVNg//6fyzq+R1flkm2J/5WPOm3vJDZ
 N3NgwkSSDmflRm9G8eewBGuQ1W5aHujvQYNhhL/J6FXB2pf7W3FoGojCU
 CAzMIZq7PqwxPmTkjJqeqgICPOgmHNfCrrBsx7LN4qabyvaKjXdpLUe9Y
 sJEWM0lo/UCKTIdPVHPDaj9KWrDrmLnH8lj7+8z80TdEvwSeJRo1f4Czy
 Hwosi9LaHxCKIzV8epg8uH/8MKhQjCa4fzRjuoOCPS68opvIZLBth7wXy g==;
X-CSE-ConnectionGUID: 8cNO4EpwQfuHwu2LIxzPhg==
X-CSE-MsgGUID: dT2G+g7uT0eI/vLLCxX0OA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33610321"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33610321"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2024 01:24:26 -0800
X-CSE-ConnectionGUID: fwYOdYBLRNmVdIpTaVKuYA==
X-CSE-MsgGUID: CoocjhJGRCSYmzcJG5O9CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94121927"
Received: from apgcp0d551111.png.altera.com ([10.244.77.49])
 by orviesa006.jf.intel.com with ESMTP; 05 Dec 2024 01:24:22 -0800
From: dinesh.maniyam@intel.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Alexander Dahl <ada@thorsis.com>,
 William Zhang <william.zhang@broadcom.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [resend v2 11/19] drivers: mtd: nand: cadence: Poll for desc complete
 status
Date: Thu,  5 Dec 2024 17:23:07 +0800
Message-Id: <20241205092315.25060-12-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20241205092315.25060-1-dinesh.maniyam@intel.com>
References: <20241205092315.25060-1-dinesh.maniyam@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Dinesh Maniyam <dinesh.maniyam@intel.com>

Poll for thread complete status to ensure the
descriptor processing is complete. If complete then can ensure
controller already update the descriptor status.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>

---
v2:
- remove the "this patch is to" commit phrases
---
---
 drivers/mtd/nand/raw/cadence_nand.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/nand/raw/cadence_nand.c b/drivers/mtd/nand/raw/cadence_nand.c
index ed93296ba8..c1bfa46daf 100644
--- a/drivers/mtd/nand/raw/cadence_nand.c
+++ b/drivers/mtd/nand/raw/cadence_nand.c
@@ -520,6 +520,7 @@ cadence_nand_cdma_send_and_wait(struct cadence_nand_info *cadence,
 {
 	struct cadence_nand_irq_status irq_mask, irq_status = {0};
 	int status;
+	u32 val;
 
 	irq_mask.trd_status = BIT(thread);
 	irq_mask.trd_error = BIT(thread);
@@ -531,6 +532,14 @@ cadence_nand_cdma_send_and_wait(struct cadence_nand_info *cadence,
 	if (status)
 		return status;
 
+	/* Make sure the descriptor processing is complete */
+	status = readl_poll_timeout(cadence->reg + TRD_COMP_INT_STATUS, val,
+				    (val & BIT(thread)), TIMEOUT_US);
+	if (status) {
+		pr_err("cmd thread completion timeout!\n");
+		return status;
+	}
+
 	cadence_nand_wait_for_irq(cadence, &irq_mask, &irq_status);
 
 	if (irq_status.status == 0 && irq_status.trd_status == 0 &&
-- 
2.19.0

