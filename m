Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE0ECCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 16:04:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F9D3832AD;
	Tue, 30 Sep 2025 18:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="2j3I+FJb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 530EE82998; Tue, 30 Sep 2025 17:42:16 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD6B6800B1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 17:42:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=36105edbf=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1759246934; x=1790782934;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hFIqxBcyJvC2Wbl9bQoRfOZgPrQl7NqNiMBVbMMYjs0=;
 b=2j3I+FJbTVAJanx1+qTl0lWvd1ZCa22qDMJKvqIH6E8W8n8gcSPGc+eg
 4WprLGJAi2IKfsBX8M0Ic/KyNU5kvuLSz+Stb7Y8Bn9c+3m1rkFEZz/D8
 38Z3eu1PPmQg89w41QEpEr9OyVQRSrvP1PQyy8590yum99xio7HJr7V+N
 RrgkNWgpBIbbzUOf/E3ozm3geSIsHoTUu8x73Z4NwwK3vpuFDcmM0OON4
 yMYKuaiL3U8q6xdcl7MC7NlhRUpLBIbrI2cv1tzIFo5DGG7xQlfs/1bh7
 msXtsl4UQabd+3BZHKrBAc5AT7KqDVKm1Rhlx/04C6dycLkA8EF9mYmJ+ g==;
X-CSE-ConnectionGUID: 1N1rS4BJQjCegOO/eYEJuA==
X-CSE-MsgGUID: Zwce9WfRRfOFAKq1tPrgug==
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="278546629"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 30 Sep 2025 08:42:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 30 Sep 2025 08:41:48 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 30 Sep 2025 08:41:46 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Cyril Jean
 <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, <jamie.gibbons@microchip.com>
Subject: [PATCH] board: mpfs_icicle: fix pointer assignment in
 board_fdt_blob_setup()
Date: Tue, 30 Sep 2025 16:45:34 +0100
Message-ID: <20250930154534.3914214-1-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 30 Sep 2025 18:04:55 +0200
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

Correct the assignment in board_fdt_blob_setup() to use *fdtp instead of
fdtp, ensuring the caller receives the correct FDT address. This
resolves an issue where the device tree pointer was not properly set due
to assigning to the local parameter rather than the dereferenced
pointer.

Fixes: 63a8506580b6 ("board: mpfs_icicle: implement board_fdt_blob_setup()/board_fit_config_name_match()")
Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 board/microchip/mpfs_icicle/mpfs_icicle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/microchip/mpfs_icicle/mpfs_icicle.c b/board/microchip/mpfs_icicle/mpfs_icicle.c
index 30c0d2fff8f..6e5dc66b463 100644
--- a/board/microchip/mpfs_icicle/mpfs_icicle.c
+++ b/board/microchip/mpfs_icicle/mpfs_icicle.c
@@ -74,7 +74,7 @@ int board_fit_config_name_match(const char *name)
 
 int board_fdt_blob_setup(void **fdtp)
 {
-	fdtp = (void *)_end;
+	*fdtp = (void *)_end;
 
 	/*
 	 * The devicetree provided by the previous stage is very minimal due to
@@ -85,7 +85,7 @@ int board_fdt_blob_setup(void **fdtp)
 	 */
 	if (IS_ENABLED(CONFIG_OF_BOARD) && !IS_ENABLED(CONFIG_MULTI_DTB_FIT)) {
 		if (gd->arch.firmware_fdt_addr)
-			fdtp = (void *)(uintptr_t)gd->arch.firmware_fdt_addr;
+			*fdtp = (void *)(uintptr_t)gd->arch.firmware_fdt_addr;
 	}
 
 	return 0;
-- 
2.43.0

