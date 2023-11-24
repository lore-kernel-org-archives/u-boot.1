Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0571C61D97
	for <u-boot@archiver.kernel.org>; Fri, 24 Nov 2023 06:31:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C666886F95;
	Fri, 24 Nov 2023 07:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wtX6fvK4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D95386FBD; Fri, 24 Nov 2023 07:31:24 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6430C86F87
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 07:31:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AO6VKk1065007
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 00:31:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700807480;
 bh=uNlM69jb8gguZkzRAXfVUU9kORHD1nmYnNEkUSRnBJs=;
 h=From:To:CC:Subject:Date;
 b=wtX6fvK4eSypEnqiNXAeT2emYNRpGt23+T6i+/vFPkABhAY7qFmiiRkqkKzrRIcra
 7EilGfIoo0gDDZMEH5t4ubeCIPkbxpotcGS+0vuEOL/0cNKl6NaDX1VgPWMVbVpkC+
 46eTz/GF0KWueLY8dmJjNcsdT3b03M1hbwgPzvjQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AO6VK3T008713
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 00:31:20 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 Nov 2023 00:31:19 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 Nov 2023 00:31:19 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AO6VHau036459;
 Fri, 24 Nov 2023 00:31:18 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <u-boot@lists.denx.de>, <hnagalla@ti.com>, <a-nandan@ti.com>
CC: <vigneshr@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH] remoteproc: k3-dsp: Avoid reloading of firmware
Date: Fri, 24 Nov 2023 12:01:11 +0530
Message-ID: <20231124063111.1744600-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
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

DSP core is going into abnormal state when load callback is called
after starting of DSP core.
Reload of firmware needs core to be stopped first, followed by
load.
So avoid loading of firmware, when core is started.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 drivers/remoteproc/ti_k3_dsp_rproc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/remoteproc/ti_k3_dsp_rproc.c b/drivers/remoteproc/ti_k3_dsp_rproc.c
index 576de4bb26..daf6eae90a 100644
--- a/drivers/remoteproc/ti_k3_dsp_rproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_rproc.c
@@ -63,6 +63,7 @@ struct k3_dsp_privdata {
 	struct k3_dsp_boot_data *data;
 	struct k3_dsp_mem *mem;
 	int num_mems;
+	bool in_use;
 };
 
 /*
@@ -128,6 +129,13 @@ static int k3_dsp_load(struct udevice *dev, ulong addr, ulong size)
 	u32 boot_vector;
 	int ret;
 
+	if (dsp->in_use) {
+		dev_err(dev,
+			"Invalid op: Trying to load/start on already running core %d\n",
+			dsp->tsp.proc_id);
+		return -EINVAL;
+	}
+
 	dev_dbg(dev, "%s addr = 0x%lx, size = 0x%lx\n", __func__, addr, size);
 	ret = ti_sci_proc_request(&dsp->tsp);
 	if (ret)
@@ -195,6 +203,7 @@ static int k3_dsp_start(struct udevice *dev)
 			ti_sci_proc_power_domain_off(&dsp->tsp);
 	}
 
+	dsp->in_use = true;
 proc_release:
 	ti_sci_proc_release(&dsp->tsp);
 
@@ -207,6 +216,7 @@ static int k3_dsp_stop(struct udevice *dev)
 
 	dev_dbg(dev, "%s\n", __func__);
 
+	dsp->in_use = false;
 	ti_sci_proc_request(&dsp->tsp);
 	reset_assert(&dsp->dsp_rst);
 	ti_sci_proc_power_domain_off(&dsp->tsp);
-- 
2.34.1

