Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58644D3943C
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 15:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 649C984020;
	Thu,  2 Apr 2026 17:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2749083CF5; Thu,  2 Apr 2026 05:51:50 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A58880212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 05:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chunguang.li_2@nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B9B121A08D8;
 Thu,  2 Apr 2026 05:51:47 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 831701A08BA;
 Thu,  2 Apr 2026 05:51:47 +0200 (CEST)
Received: from bjse.cn-bjs01.nxp.com (bjse.cn-bjs01.nxp.com [10.193.20.96])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C0A4E1800092;
 Thu,  2 Apr 2026 11:51:45 +0800 (+08)
From: chunguang.li_2@nxp.com
To: trini@konsulko.com,
	meenakshi.aggarwal@nxp.com,
	andy.tang@nxp.com
Cc: chunguang.li_2@nxp.com, ioana.ciornei@nxp.com,
 florinlaurentiu.chiculita@nxp.com, u-boot@lists.denx.de,
 mingkai.hu@nxp.com, Zhiqiang.Hou@nxp.com, pramod.kumar_1@nxp.com,
 camelia.groza@nxp.com, priyanka.jain@nxp.com, wasim.khan@nxp.com
Subject: [PATCH v2 1/4] ls1028ardb: add env variables to assist boot
Date: Thu,  2 Apr 2026 11:51:29 +0800
Message-ID: <20260402035132.1706521-1-chunguang.li_2@nxp.com>
X-Mailer: git-send-email 2.43.0
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

Signed-off-by: Chunguang Li <chunguang.li_2@nxp.com>
---
v2:
 - Fix formatting

 include/configs/ls1028ardb.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/configs/ls1028ardb.h b/include/configs/ls1028ardb.h
index 005667d20b6..965fd5246f8 100644
--- a/include/configs/ls1028ardb.h
+++ b/include/configs/ls1028ardb.h
@@ -54,6 +54,9 @@
 	"board=ls1028ardb\0"			\
 	"hwconfig=fsl_ddr:bank_intlv=auto\0"	\
 	"fdtfile=fsl-ls1028a-rdb.dtb\0"         \
+	"image=Image\0"					\
+	"extra_bootargs=iommu.passthrough=1 arm-smmu.disable_bypass=0\0"	\
+	"othbootargs=video=1920x1080-32@60 cma=640M\0"    \
 	"ramdisk_addr=0x800000\0"		\
 	"ramdisk_size=0x2000000\0"		\
 	"bootm_size=0x10000000\0"		\
@@ -77,6 +80,7 @@
 	"kernelhdr_addr_sd=0x3000\0"		\
 	"kernelhdr_size_sd=0x20\0"		\
 	"console=ttyS0,115200\0"                \
+	"console_dbg=earlycon=uart8250,mmio,0x21c0500\0"		\
 	BOOTENV					\
 	"boot_scripts=ls1028ardb_boot.scr\0"    \
 	"boot_script_hdr=hdr_ls1028ardb_bs.out\0"	\
-- 
2.34.1

