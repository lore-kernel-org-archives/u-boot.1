Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46864C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 10:57:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BD3988749;
	Tue, 21 May 2024 12:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c2DHDaOz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C7AE88749; Tue, 21 May 2024 12:57:21 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7366E88753
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 12:57:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44LAvBTS011515;
 Tue, 21 May 2024 05:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716289031;
 bh=czQJ1UvAoqDclV7Ii8KOPk2f+mNm1cgiBSVnw9LoAGw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=c2DHDaOznBFAATzqSJ9UROSwlQ+ZKNe9NFIhqgm9yNSUZyabNoi1LONtnsW20nc8W
 K7sZg/ImkuKZu2DVBoDc6DsHR0awYOog9ZWKca/1Lctqd9Ze/NzYNdmEzck9pcQ9cY
 RVZFNRoQ6kTD2vRJ5l9u3YwdsFparjkk/qRuHlnY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44LAvB38013219
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 21 May 2024 05:57:11 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 21
 May 2024 05:57:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 21 May 2024 05:57:11 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44LAurAh047424;
 Tue, 21 May 2024 05:57:06 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <vigneshr@ti.com>, <nm@ti.com>, <trini@konsulko.com>
CC: <joe.hershberger@ni.com>, <m-chawdhry@ti.com>, <afd@ti.com>,
 <devarsht@ti.com>, <sjg@chromium.org>, <emanuele.ghidoli@toradex.com>,
 <matthias.schiffer@ew.tq-group.com>, <a-bhatia1@ti.com>,
 <vitor.soares@toradex.com>, <danishanwar@ti.com>,
 <andriy.shevchenko@linux.intel.com>, <bmeng.cn@gmail.com>,
 <mkorpershoek@baylibre.com>, <s-vadapalli@ti.com>,
 <u-boot@lists.denx.de>, <joao.goncalves@toradex.com>, <hnagalla@ti.com>
Subject: [PATCH 2/4] drivers: remoteproc: ti_k3 : enable secure booting with
 firmware images
Date: Tue, 21 May 2024 16:26:46 +0530
Message-ID: <20240521105648.3780072-3-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521105648.3780072-1-u-kumar1@ti.com>
References: <20240521105648.3780072-1-u-kumar1@ti.com>
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

From: Manorit Chawdhry <m-chawdhry@ti.com>

Remoteproc firmware images aren't authenticated in the current boot flow.
Authenticates remoteproc firmware images to complete the root of trust
in secure booting.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 drivers/remoteproc/ti_k3_dsp_rproc.c | 4 ++++
 drivers/remoteproc/ti_k3_r5f_rproc.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/remoteproc/ti_k3_dsp_rproc.c b/drivers/remoteproc/ti_k3_dsp_rproc.c
index 57fe1037da..7617bbb986 100644
--- a/drivers/remoteproc/ti_k3_dsp_rproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_rproc.c
@@ -21,6 +21,7 @@
 #include <linux/sizes.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include "ti_sci_proc.h"
+#include <mach/security.h>
 
 #define KEYSTONE_RPROC_LOCAL_ADDRESS_MASK	(SZ_16M - 1)
 
@@ -127,6 +128,7 @@ static int k3_dsp_load(struct udevice *dev, ulong addr, ulong size)
 	struct k3_dsp_privdata *dsp = dev_get_priv(dev);
 	struct k3_dsp_boot_data *data = dsp->data;
 	u32 boot_vector;
+	void *image_addr = (void *)addr;
 	int ret;
 
 	if (dsp->in_use) {
@@ -148,6 +150,8 @@ static int k3_dsp_load(struct udevice *dev, ulong addr, ulong size)
 		goto proc_release;
 	}
 
+	ti_secure_image_post_process(&image_addr, &size);
+
 	ret = rproc_elf_load_image(dev, addr, size);
 	if (ret < 0) {
 		dev_err(dev, "Loading elf failed %d\n", ret);
diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
index b55b1dc10d..b9c6549e18 100644
--- a/drivers/remoteproc/ti_k3_r5f_rproc.c
+++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include "ti_sci_proc.h"
+#include <mach/security.h>
 
 /*
  * R5F's view of this address can either be for ATCM or BTCM with the other
@@ -301,6 +302,7 @@ static int k3_r5f_load(struct udevice *dev, ulong addr, ulong size)
 	u64 boot_vector;
 	u32 ctrl, sts, cfg = 0;
 	bool mem_auto_init;
+	void *image_addr = (void *)addr;
 	int ret;
 
 	dev_dbg(dev, "%s addr = 0x%lx, size = 0x%lx\n", __func__, addr, size);
@@ -328,6 +330,8 @@ static int k3_r5f_load(struct udevice *dev, ulong addr, ulong size)
 
 	k3_r5f_init_tcm_memories(core, mem_auto_init);
 
+	ti_secure_image_post_process(&image_addr, &size);
+
 	ret = rproc_elf_load_image(dev, addr, size);
 	if (ret < 0) {
 		dev_err(dev, "Loading elf failedi %d\n", ret);
-- 
2.34.1

