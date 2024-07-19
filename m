Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA2CC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 08:59:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 347FF88ACF;
	Fri, 19 Jul 2024 10:59:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="b6v6l3HG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E9E088B19; Fri, 19 Jul 2024 10:59:29 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DDBA883BB
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 10:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46J8xCt4057279;
 Fri, 19 Jul 2024 03:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1721379552;
 bh=VDiXNwQGsKLChngHBy7vUZlrmpkdqhH+zi1Jql58z68=;
 h=From:To:CC:Subject:Date;
 b=b6v6l3HGCL3VPLYGqqlBjNgg/un7O3RlWpbY6K4k8zxJSw/4BeJf2Pkv6vure45Hg
 3xRhJZCPRJAZtodCzN7HGd+UjMv2nlvK1Fc0/XeCa2ZIUIbDAhBfnlJGgPlPkZzbMU
 geZLVXbHkDFwIz8ba3JYL+ixR9bTCp8yICTYCFRc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46J8xCig028057
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 19 Jul 2024 03:59:12 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Jul 2024 03:59:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Jul 2024 03:59:12 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46J8xCOW065050;
 Fri, 19 Jul 2024 03:59:12 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 46J8xBDN030592;
 Fri, 19 Jul 2024 03:59:11 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Nishanth Menon <nm@ti.com>, MD
 Danish Anwar <danishanwar@ti.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>, Andrew Davis
 <afd@ti.com>
Subject: [PATCH] remoteproc: uclass: Modify uc_pdata->name to use combination
 of device name and device's parent name
Date: Fri, 19 Jul 2024 14:29:08 +0530
Message-ID: <20240719085908.3564171-1-danishanwar@ti.com>
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

uc_pdata->name is populated from device tree property "remoteproc-name".
For those devcices that don't set "remoteproc-name", uc_pdata->name
falls back to dev->name.

If two devices have same name, this will result into uc_pdata->name not
being unique and rproc_init() will fail.

Fix this by using combination of dev->name and dev->parent->name instead
of using just the dev->name to populate uc_pdata->name.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
Cc: Andrew Davis <afd@ti.com>

Failure Example:
In k3-am64-main.dtsi, both pru0_0 [1] and pru1_0 [2] will have
dev->name as "pru@34000" although their parent name is different.

pru0_0 has dev->name as "pru@34000" and parent name as "icssg@30000000"
pru1_0 has dev->name as "pru@34000" and parent name as "icssg@30080000"

rproc_init() fails for pru1_0 as the the uc_pdata->name becomes same as the pru0_0.
More details on this issue can be found here [3]. It was suggested to use a
different combination if `dev->name` is not unique by Andrew Davis <afd@ti.com> [4]

Failure Logs:
	rproc_pre_probe: 'pru@34000': using fdt
	rproc_pre_probe: 'pru@34000': using fdt
	rproc_pre_probe: pru@34000 duplicate name 'pru@34000'
	_rproc_probe_dev: pru@34000: Failed to initialize - -22
	rproc_boot: rproc_init() failed: -22

To fix it, this commit uses combination of dev and dev's parent name.

After this commit,
pru0_0 uc->pdata->name = "pru@34000:icssg@30000000"
pru1_0 uc->pdata->name = "pru@34000:icssg@30080000"

Both the names are unique, thus rproc_init() succeeds.

[1] https://elixir.bootlin.com/u-boot/v2024.07-rc3/source/dts/upstream/src/arm64/ti/k3-am64-main.dtsi#L1276
[2] https://elixir.bootlin.com/u-boot/v2024.07-rc3/source/dts/upstream/src/arm64/ti/k3-am64-main.dtsi#L1417
[3] https://lore.kernel.org/all/5cda289f-1d14-41f6-84e3-ff1d1034be13@ti.com/
[4] https://lore.kernel.org/all/e48f5818-182c-47ab-b384-379659830d38@ti.com/

 drivers/remoteproc/rproc-uclass.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/rproc-uclass.c b/drivers/remoteproc/rproc-uclass.c
index 3ba2b40dca..e550292dda 100644
--- a/drivers/remoteproc/rproc-uclass.c
+++ b/drivers/remoteproc/rproc-uclass.c
@@ -158,9 +158,15 @@ static int rproc_pre_probe(struct udevice *dev)
 		uc_pdata->driver_plat_data = pdata->driver_plat_data;
 	}
 
-	/* Else try using device Name */
-	if (!uc_pdata->name)
-		uc_pdata->name = dev->name;
+	/* Else try using a combination of device Name and devices's parent's name */
+	if (!uc_pdata->name) {
+		int rproc_name_size = 256;
+		char *buf;
+
+		buf = malloc(rproc_name_size);
+		snprintf(buf, rproc_name_size, "%s-%s", dev->name, dev->parent->name);
+		uc_pdata->name = buf;
+	}
 	if (!uc_pdata->name) {
 		debug("Unnamed device!");
 		return -EINVAL;
-- 
2.34.1

