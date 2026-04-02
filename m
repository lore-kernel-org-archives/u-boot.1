Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD75CC6B3E
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 15:04:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 333DE84101;
	Thu,  2 Apr 2026 17:03:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 992A383D8A; Thu,  2 Apr 2026 05:51:58 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C202880212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 05:51:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chunguang.li_2@nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8D0C51A08BA;
 Thu,  2 Apr 2026 05:51:56 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 570651A0751;
 Thu,  2 Apr 2026 05:51:56 +0200 (CEST)
Received: from bjse.cn-bjs01.nxp.com (bjse.cn-bjs01.nxp.com [10.193.20.96])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 488631800091;
 Thu,  2 Apr 2026 11:51:54 +0800 (+08)
From: chunguang.li_2@nxp.com
To: trini@konsulko.com,
	meenakshi.aggarwal@nxp.com,
	andy.tang@nxp.com
Cc: chunguang.li_2@nxp.com, ioana.ciornei@nxp.com,
 florinlaurentiu.chiculita@nxp.com, u-boot@lists.denx.de,
 mingkai.hu@nxp.com, Zhiqiang.Hou@nxp.com, pramod.kumar_1@nxp.com,
 camelia.groza@nxp.com, priyanka.jain@nxp.com, wasim.khan@nxp.com
Subject: [PATCH v2 4/4] lx2160ardb: add env variables to assist boot
Date: Thu,  2 Apr 2026 11:51:32 +0800
Message-ID: <20260402035132.1706521-4-chunguang.li_2@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402035132.1706521-1-chunguang.li_2@nxp.com>
References: <20260402035132.1706521-1-chunguang.li_2@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Apr 2026 17:03:20 +0200
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

From: Chunguang Li <chunguang.li_2@nxp.com>

Update the console baudrate to 115200 as default.
Also add env variables to assist boot process.

Signed-off-by: Chunguang Li <chunguang.li_2@nxp.com>
---
v2:
 - Fix formatting.
 - Update description.

 include/configs/lx2160a_common.h | 2 +-
 include/configs/lx2160ardb.h     | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/configs/lx2160a_common.h b/include/configs/lx2160a_common.h
index 5620b903836..3fd9e3fc8d7 100644
--- a/include/configs/lx2160a_common.h
+++ b/include/configs/lx2160a_common.h
@@ -149,7 +149,7 @@
 	"kernelhdr_addr_sd=0x3000\0"            \
 	"kernel_size_sd=0x14000\0"              \
 	"kernelhdr_size_sd=0x20\0"              \
-	"console=ttyAMA0,38400n8\0"		\
+	"console=ttyAMA0,115200\0"		\
 	BOOTENV					\
 	"mcmemsize=0x70000000\0"		\
 	XSPI_MC_INIT_CMD				\
diff --git a/include/configs/lx2160ardb.h b/include/configs/lx2160ardb.h
index 9d065d02bc5..b583bcc96fb 100644
--- a/include/configs/lx2160ardb.h
+++ b/include/configs/lx2160ardb.h
@@ -32,6 +32,11 @@
 
 /* Initial environment variables */
 #define CFG_EXTRA_ENV_SETTINGS		\
+	"board=lx2160ardb\0"		\
+	"fdtfile=fsl-lx2160a-rdb.dtb\0"			\
+	"image=Image\0"				\
+	"extra_bootargs=pci=pcie_bus_perf\0"	\
+	"console_dbg=earlycon=pl011,mmio32,0x21c0000\0"		\
 	EXTRA_ENV_SETTINGS			\
 	"boot_scripts=lx2160ardb_boot.scr\0"	\
 	"boot_script_hdr=hdr_lx2160ardb_bs.out\0"	\
-- 
2.34.1

