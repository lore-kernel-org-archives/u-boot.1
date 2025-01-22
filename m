Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F8FC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 13:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 546BD807D6;
	Wed, 22 Jan 2025 14:22:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Z7le5evh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39978801FB; Wed, 22 Jan 2025 03:21:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E737B8001F
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 03:21:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737512482; x=1769048482;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jYbHR07V7ceSfq9d2Kv3m6nMA02V5KCK/6gC7YYhTjk=;
 b=Z7le5evhB0weOrQ7CIF5+Q+eagePq/p7OP81GVjyS3myzVpqghe7QC1v
 2KOLGuGho8bBhArISQOdMKCWKGMtRSQuVm6hwMQLwzK27tsfrRsmjm0oc
 lpTuWZVfEzAefo615G2m/lz6OT1lEl7htGej5m97Iw2wsf1AiMRimWeAs
 4DZwHi40W9D3Q7KEVkMC4xMjgXx1zHReePvZfN8yGeWGrFpRf6t9RHKJQ
 eByzUDhqaD7YwfnkV0Pgbr3ep+okwyjvAYhArxvQjP/Tns4mfipAM/hAp
 138EiBh6tzFFdywvX6moh6J7qwM8EIi/aNLlt9IdHZjeMLlrAOGJXpW+R w==;
X-CSE-ConnectionGUID: q69VxAdSSx2mc5CPPVZ+rQ==
X-CSE-MsgGUID: dE1XfT/bTR+7ISjzWalOIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="41627528"
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; d="scan'208";a="41627528"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 18:21:20 -0800
X-CSE-ConnectionGUID: Oh/xHRXlTumhQXAXyd0qYQ==
X-CSE-MsgGUID: qcXfdGe+SDiotQnZ1dS7rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; d="scan'208";a="137818314"
Received: from apgcp0d540114.png.altera.com ([10.244.77.36])
 by orviesa002.jf.intel.com with ESMTP; 21 Jan 2025 18:21:17 -0800
From: alif.zakuan.yuslaimi@intel.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>, Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v1] arch: arm: mach-socfpga: Mailbox buffer and SDM doorbell
 improvement
Date: Wed, 22 Jan 2025 10:21:02 +0800
Message-Id: <20250122022102.31186-1-alif.zakuan.yuslaimi@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Jan 2025 14:22:36 +0100
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

The current write and notify SDM to read mechanism has a flaw where
SDM is not notified enough to be able to read all the data in the buffer.

This is caused by SDM doorbell will only be sent out once the command
buffer overflow check is satisfied. If the command buffer does not reach
overflow status, no SDM doorbell will be sent out, which may cause a
timeout as the mailbox driver will be waiting for the SDM to read the
buffer to empty even though SDM is not notified to do so.

The solution is to remove the command buffer overflow check
and set the SDM doorbell to always trigger at the end of the command
buffer.

This will ensure that the SDM is able to read all of the data.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/mailbox_s10.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-socfpga/mailbox_s10.c b/arch/arm/mach-socfpga/mailbox_s10.c
index 2b4f26040fe..b69bd3e47ec 100644
--- a/arch/arm/mach-socfpga/mailbox_s10.c
+++ b/arch/arm/mach-socfpga/mailbox_s10.c
@@ -88,6 +88,8 @@ static __always_inline int mbox_write_cmd_buffer(u32 *cin, u32 data,
 			MBOX_WRITE_CMD_BUF(data, (*cin)++);
 			*cin %= MBOX_CMD_BUFFER_SIZE;
 			MBOX_WRITEL(*cin, MBOX_CIN);
+			if (is_cmdbuf_overflow)
+				*is_cmdbuf_overflow = 0;
 			break;
 		}
 		timeout--;
@@ -96,10 +98,6 @@ static __always_inline int mbox_write_cmd_buffer(u32 *cin, u32 data,
 	if (!timeout)
 		return -ETIMEDOUT;
 
-	/* Wait for the SDM to drain the FIFO command buffer */
-	if (is_cmdbuf_overflow && *is_cmdbuf_overflow)
-		return mbox_wait_for_cmdbuf_empty(*cin);
-
 	return 0;
 }
 
@@ -125,13 +123,11 @@ static __always_inline int mbox_fill_cmd_circular_buff(u32 header, u32 len,
 			return ret;
 	}
 
-	/* If SDM doorbell is not triggered after the last data is
-	 * written into mailbox FIFO command buffer, trigger the
-	 * SDM doorbell again to ensure SDM able to read the remaining
-	 * data.
+	/*
+	 * Always trigger the SDM doorbell at the end to ensure SDM able to read
+	 * the remaining data.
 	 */
-	if (!is_cmdbuf_overflow)
-		MBOX_WRITEL(1, MBOX_DOORBELL_TO_SDM);
+	MBOX_WRITEL(1, MBOX_DOORBELL_TO_SDM);
 
 	return 0;
 }
-- 
2.25.1

