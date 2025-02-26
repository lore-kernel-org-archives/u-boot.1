Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C41AC18E7C
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 16:20:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3421F81115;
	Wed, 26 Feb 2025 17:19:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DPUGroCX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDAFD8004F; Wed, 26 Feb 2025 17:19:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B0D681115
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:19:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740586783; x=1772122783;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x0h6R9DxK8EblEwstv6OEaO/RR7SDye7bqDIW0oNs6A=;
 b=DPUGroCXJ6wjRBHW9WRbTUcCAouUph1e0BeWHiBWQOhwAl8eIigyL7H8
 T+q/8i5GLRQeqDXmbVn5nuSfjEPjh4J9HzKrrMU6dY6Y+M2LRBk7dO7DD
 863K41r8j4bDHZUiecYYm3hMbOTdYnvXuRKM6lqHXq/tbYcUJ+/7qKyjG
 3/JJuGpLBBY/4oXoPkjRlw46+CgNNPH87fB6HdGZ+u7+0WpSRuP7i4EFY
 LYYjqKAW5/fnFdzsoce8HtJsF0bNSVe2DivBfxKQe6zN+9emp+90p1+z4
 toaYJwbfKx/lRO8y0Qt/Lm4Mki8Y7VqBFgPEJpT3QPBfhwTQTB4MNvlJz g==;
X-CSE-ConnectionGUID: u1i2w5T6QeaUoV/TuKEL3Q==
X-CSE-MsgGUID: 1f36XmoRQ8+nNY5JFsNVDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41640135"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="41640135"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 08:19:42 -0800
X-CSE-ConnectionGUID: w6F7RSbYQi+iwgYx69TQGQ==
X-CSE-MsgGUID: wD1Yh2Q5RU+yrQ2RWqfILg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="116602783"
Received: from apgcp0c530105.png.altera.com ([10.244.76.183])
 by orviesa010.jf.intel.com with ESMTP; 26 Feb 2025 08:19:37 -0800
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
Subject: [resend v3 10/19] drivers: mtd: nand: cadence: Poll for desc complete
 status
Date: Thu, 27 Feb 2025 00:18:24 +0800
Message-Id: <20250226161833.53689-11-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20250226161833.53689-1-dinesh.maniyam@intel.com>
References: <20250226161833.53689-1-dinesh.maniyam@intel.com>
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
index a717987be6..e571e5a686 100644
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

