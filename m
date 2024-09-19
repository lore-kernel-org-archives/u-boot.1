Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A505DCE8D49
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:56:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CBC18906D;
	Thu, 19 Sep 2024 05:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="c3g79uko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99C758906D; Thu, 19 Sep 2024 05:55:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3286788FDF
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 05:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726718150; x=1758254150;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mNf2mKSir1+6ky601fKQeeUwxOhpr/VjajGeeMgh+Xo=;
 b=c3g79ukoDKHrfnpvNEKxbXDad5ftOYjNueWWaH0XtfP9u45yC5W6NzQw
 kRECuSsgLTU3aigCJUoQzwD1yXT7TSq7UR53ncD7nMPAjUhsOkMsLx7/U
 +AwoRSUqJpV6VzlSsBDwtwCuPbC47PVY8+/bPN6p6ChhZV27kBciYTlmS
 JetUaJGQyoD6vgV6fB0K6Fjmo+lm5QdR4gAStQt485EzzuWqnrBNMJZ1m
 GL4LrA6voFbW8dIOfOxt+/tdVyDSk80IxUilEOROhDSWo1UX6VXgAlnw3
 g+tf7Q7l/JF8ISv1x57z5ezfEOQNvyVfR+6PpNHJ0yIT/95xkK7JbbACs A==;
X-CSE-ConnectionGUID: tJo3GFK7TjKiD1VSveyLDw==
X-CSE-MsgGUID: vr1xCCXbRNOnGUWcEsENuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="43177990"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="43177990"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 20:55:49 -0700
X-CSE-ConnectionGUID: rstzr6+VQYi4NNyHfnRZkg==
X-CSE-MsgGUID: e94iU2/dRm2gOx8yvV/Nfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="70253737"
Received: from pglc00481.png.intel.com ([10.221.239.164])
 by orviesa007.jf.intel.com with ESMTP; 18 Sep 2024 20:55:44 -0700
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
Subject: [PATCH 05/19] drivers: mtd: nand: cadence: Add support for read
 status command
Date: Thu, 19 Sep 2024 11:54:58 +0800
Message-Id: <20240919035512.13854-6-dinesh.maniyam@intel.com>
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

This patch will add support for read status command
in Cadence NAND driver. This status bit is important to check
whether the flash is write-protected.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 drivers/mtd/nand/raw/cadence_nand.c | 46 ++++++++++++++++++++++++++++-
 include/cadence-nand.h              |  2 ++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/cadence_nand.c b/drivers/mtd/nand/raw/cadence_nand.c
index f9f28c392b..670f5ca184 100644
--- a/drivers/mtd/nand/raw/cadence_nand.c
+++ b/drivers/mtd/nand/raw/cadence_nand.c
@@ -343,6 +343,7 @@ static int cadence_nand_generic_cmd_send(struct cadence_nand_info *cadence,
 
 	/* Issue command. */
 	writel_relaxed(reg, cadence->reg + CMD_REG0);
+	cadence->buf_index = 0;
 
 	return 0;
 }
@@ -1902,9 +1903,42 @@ static void cadence_nand_select_chip(struct mtd_info *mtd, int chipnr)
 	}
 }
 
+static int cadence_nand_status(struct mtd_info *mtd, unsigned int command)
+{
+	struct cadence_nand_info *cadence = mtd_to_cadence(mtd);
+	int ret = 0;
+
+	ret = cadence_nand_cmd_opcode(cadence, command);
+	if (ret)
+		return ret;
+
+	ret = cadence_nand_cmd_data(cadence, 1, GCMD_DIR_READ);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static void cadence_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
 				 int offset_in_page, int page)
 {
+	struct cadence_nand_info *cadence = mtd_to_cadence(mtd);
+	int ret = 0;
+
+	cadence->cmd = command;
+	switch (command) {
+	case NAND_CMD_STATUS:
+		ret = cadence_nand_status(mtd, command);
+		break;
+	/*
+	 * ecc will override other command for read, write and erase
+	 */
+	default:
+		break;
+	}
+
+	if (ret != 0)
+		printf("ERROR:%s:command:0x%x\n", __func__, cadence->cmd);
 }
 
 static int cadence_nand_dev_ready(struct mtd_info *mtd)
@@ -1921,7 +1955,17 @@ static int cadence_nand_dev_ready(struct mtd_info *mtd)
 
 static u8 cadence_nand_read_byte(struct mtd_info *mtd)
 {
-	return 0;
+	struct cadence_nand_info *cadence = mtd_to_cadence(mtd);
+	u32 size = 1;
+	u8 val;
+
+	if (cadence->buf_index == 0)
+		cadence_nand_read_buf(mtd, &cadence->buf[0], size);
+
+	val = *(&cadence->buf[0] + cadence->buf_index);
+	cadence->buf_index++;
+
+	return val;
 }
 
 static void cadence_nand_write_byte(struct mtd_info *mtd, u8 byte)
diff --git a/include/cadence-nand.h b/include/cadence-nand.h
index 101f60ce0e..5b9d6e0382 100644
--- a/include/cadence-nand.h
+++ b/include/cadence-nand.h
@@ -453,6 +453,8 @@ struct cadence_nand_info {
 	u8 *buf;
 	u32 buf_size;
 	u8 *stat;
+	u8 cmd;
+	u32 buf_index;
 
 	u8 curr_corr_str_idx;
 
-- 
2.26.2

