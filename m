Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEDDC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 16:01:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CEAB8168B;
	Wed, 12 Mar 2025 17:01:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEF19805D7; Wed, 12 Mar 2025 16:37:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F9F9800B6
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 16:37:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=muhammad.hazim.izzat.zamri@altera.com
X-CSE-ConnectionGUID: CuPVf/8UT7e2oLZX2kN1dw==
X-CSE-MsgGUID: i1EofR9+SOOyMZHmpul5Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42046500"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; d="scan'208";a="42046500"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2025 08:37:30 -0700
X-CSE-ConnectionGUID: 65PyDLfYRFC9PuAFvkgRDA==
X-CSE-MsgGUID: SThX7M3cRvKZJbJ7sdMdEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; d="scan'208";a="157844456"
Received: from apgcp0d540107.png.altera.com ([10.244.77.29])
 by orviesa001.jf.intel.com with ESMTP; 12 Mar 2025 08:37:27 -0700
From: muhammad.hazim.izzat.zamri@altera.com
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong <tien.fong.chee@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Tingting Meng <tingting.meng@altera.com>
Subject: [PATCH v1 1/2] drivers: fpga: Add FPGA configuration during bootm for
 Intel SOCFPGA
Date: Wed, 12 Mar 2025 23:37:16 +0800
Message-Id: <20250312153717.28514-2-muhammad.hazim.izzat.zamri@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250312153717.28514-1-muhammad.hazim.izzat.zamri@altera.com>
References: <20250312153717.28514-1-muhammad.hazim.izzat.zamri@altera.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 12 Mar 2025 17:01:06 +0100
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

From: Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>

Enabling the capability to automatically perform FPGA configuration
when booting Linux FIT image via bootm command. The FPGA
configuration bitstream shall be packed within the FIT image.

The FPGA data (full or partial) is checked by the SDM hardware,
for Intel SDM Mailbox based devices. Hence always return full
bitstream.

Second function is to enable the HPS to FPGA bridges when FPGA load
is completed successfully. This is to ensure the FPGA is accessible
by the HPS.

Signed-off-by: Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>
---
 drivers/fpga/altera.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/fpga/altera.c b/drivers/fpga/altera.c
index ae06f0123a..136ccfc2de 100644
--- a/drivers/fpga/altera.c
+++ b/drivers/fpga/altera.c
@@ -12,6 +12,10 @@
 /*
  *  Altera FPGA support
  */
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || \
+	IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)
+#include <asm/arch/misc.h>
+#endif
 #include <errno.h>
 #include <ACEX1K.h>
 #include <log.h>
@@ -47,6 +51,42 @@ static const struct altera_fpga {
 #endif
 };

+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || \
+	IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)
+int fpga_is_partial_data(int devnum, size_t img_len)
+{
+	/*
+	 * The FPGA data (full or partial) is checked by
+	 * the SDM hardware, for Intel SDM Mailbox based
+	 * devices. Hence always return full bitstream.
+	 *
+	 * For Cyclone V and Arria 10 family, the bitstream
+	 * type parameter is not handled by the driver.
+	 */
+	return 0;
+}
+
+int fpga_loadbitstream(int devnum, char *fpgadata, size_t size,
+		       bitstream_type bstype)
+{
+	int ret_val;
+
+	ret_val = fpga_load(devnum, (void *)fpgadata, size, bstype);
+
+	/*
+	 * Enable the HPS to FPGA bridges when FPGA load is completed
+	 * successfully. This is to ensure the FPGA is accessible
+	 * by the HPS.
+	 */
+	if (!ret_val) {
+		printf("Enable FPGA bridges\n");
+		do_bridge_reset(1, ~0);
+	}
+
+	return ret_val;
+}
+#endif
+
 static int altera_validate(Altera_desc *desc, const char *fn)
 {
 	if (!desc) {
--
2.25.1

