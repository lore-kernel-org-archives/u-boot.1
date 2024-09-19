Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66657CE8D46
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:57:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D88D88FDE;
	Thu, 19 Sep 2024 05:56:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Whg/1R4o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF98988FDE; Thu, 19 Sep 2024 05:56:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6B3789098
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 05:56:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726718185; x=1758254185;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yVQXJsnkM5zS4nUXI2ITa4cAARnl7JncryK1GSbUcMg=;
 b=Whg/1R4oPyi0FKKrJzunWHrEx6P2MS9mfX075btJQKlv08YwL9+sVJpH
 EJqKNa4h7m4Pznl9/inGUbeT+A7i7EfSTw+362bFyLaAp6HCnDlaTjiNd
 Dq+uAVeiDnx0re32OzBFHxd4eZKFtBmwp0WX81sa0Jz7d2ZMMdg6D0Rpl
 L+ILr0y/X3EQ2SUO60lTyIiunpKf33dYPJq902R8RjY5aNQ/WPxeVJv32
 KZQugckbcCX6JQfncnGN8lPyAafRkiQFO5sKMQ39hI6Yn4NoVRpS0pIXO
 d8joXOWQWZk/mz3cqkxViZIexviNtDiWDZ07xOdx6sRXJJ8QDEDjAekzs A==;
X-CSE-ConnectionGUID: ej8g7KjJTYia0Bgx4ZW5Iw==
X-CSE-MsgGUID: Aiy1g5ALRCGcT6+NI4Z0dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="43178057"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="43178057"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 20:56:23 -0700
X-CSE-ConnectionGUID: 6q7wQIrsRza8l7Fjbnwv7A==
X-CSE-MsgGUID: q4TwKxWoSLyus9fBduALYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70253848"
Received: from pglc00481.png.intel.com ([10.221.239.164])
 by orviesa007.jf.intel.com with ESMTP; 18 Sep 2024 20:56:17 -0700
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
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [PATCH 11/19] drivers: mtd: nand: cadence: Poll for desc complete
 status
Date: Thu, 19 Sep 2024 11:55:04 +0800
Message-Id: <20240919035512.13854-12-dinesh.maniyam@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240919035512.13854-1-dinesh.maniyam@intel.com>
References: <20240919035512.13854-1-dinesh.maniyam@intel.com>
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

The patch is to poll for thread complete status to ensure the
descriptor processing is complete. If complete then can ensure
controller already update the descriptor status.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 drivers/mtd/nand/raw/cadence_nand.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/nand/raw/cadence_nand.c b/drivers/mtd/nand/raw/cadence_nand.c
index 429a5e8017..33e8b79520 100644
--- a/drivers/mtd/nand/raw/cadence_nand.c
+++ b/drivers/mtd/nand/raw/cadence_nand.c
@@ -514,6 +514,7 @@ cadence_nand_cdma_send_and_wait(struct cadence_nand_info *cadence,
 {
 	struct cadence_nand_irq_status irq_mask, irq_status = {0};
 	int status;
+	u32 val;
 
 	irq_mask.trd_status = BIT(thread);
 	irq_mask.trd_error = BIT(thread);
@@ -525,6 +526,14 @@ cadence_nand_cdma_send_and_wait(struct cadence_nand_info *cadence,
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
2.26.2

