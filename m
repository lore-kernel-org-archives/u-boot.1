Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8646CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 16:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD9D786CF2;
	Mon, 16 Oct 2023 18:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pbXqE8Yr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C1C186940; Mon, 16 Oct 2023 18:06:27 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6767286DCA
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 18:06:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39GG6E3j079838;
 Mon, 16 Oct 2023 11:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697472374;
 bh=n6vPCKMHV5VyyP53QcjynSHWnGolBQiyGXU2Pb9WmT4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=pbXqE8YrVUn5w9D52uXaDWZ7yWolr1yStzQ9IrVE3x3UYlR/rEB33X3DPYpX4NRok
 PH3SLNHzrIIqJyOy6xwVTNTOROsLEm0Hwx+9ZbtT8KJ9Yd2Q9cmGWFMIruEDYF3y6P
 Uo6BqhFJPYdrThw0o8cbPuJcaIxa/HX0/7BUwqH8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39GG6E71122343
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 16 Oct 2023 11:06:14 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Oct 2023 11:06:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Oct 2023 11:06:13 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39GG6CNO112818;
 Mon, 16 Oct 2023 11:06:13 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <devarsht@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>
Subject: [RFC PATCH 1/5] arm: mach-k3: common: Reserve video memory from end
 of the RAM
Date: Mon, 16 Oct 2023 21:36:07 +0530
Message-ID: <20231016160611.1353458-2-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016160611.1353458-1-devarsht@ti.com>
References: <20231016160611.1353458-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Move the function to setup video memory before page table
reservation so that framebuffer memory gets reserved from
the end of RAM.

This is as per the new policy being discussed for passing
blobs where each of the reserved areas for bloblists
to be passed need to be reserved at the end of RAM.

This is to enable the next stage to directly skip
the pre-reserved area from previous stage without
having to making any gaps/holes to accomodate those
regions which was the case if previous stage
reserved region say somewhere in the middle and not at
the end of RAM.

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 arch/arm/mach-k3/common.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index cc755dd1bf..3978b9ccca 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -27,6 +27,7 @@
 #include <env.h>
 #include <elf.h>
 #include <soc.h>
+#include <video.h>
 
 #if IS_ENABLED(CONFIG_SYS_K3_SPL_ATF)
 enum {
@@ -522,6 +523,24 @@ void remove_fwl_configs(struct fwl_data *fwl_data, size_t fwl_data_size)
 	}
 }
 
+static int video_setup(void)
+{
+	if (CONFIG_IS_ENABLED(VIDEO)) {
+		ulong addr;
+		int ret;
+
+		addr = gd->relocaddr;
+		ret = video_reserve(&addr);
+		if (ret)
+			return ret;
+		debug("Reserving %luk for video at: %08lx\n",
+		      ((unsigned long)gd->relocaddr - addr) >> 10, addr);
+		gd->relocaddr = addr;
+	}
+
+	return 0;
+}
+
 void spl_enable_dcache(void)
 {
 #if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
@@ -537,6 +556,8 @@ void spl_enable_dcache(void)
 	if (ram_top >= 0x100000000)
 		ram_top = (phys_addr_t) 0x100000000;
 
+	gd->relocaddr = ram_top;
+	video_setup();
 	gd->arch.tlb_addr = ram_top - gd->arch.tlb_size;
 	gd->arch.tlb_addr &= ~(0x10000 - 1);
 	debug("TLB table from %08lx to %08lx\n", gd->arch.tlb_addr,
-- 
2.34.1

