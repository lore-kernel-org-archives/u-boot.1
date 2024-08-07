Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F284C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 09:08:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A70B88A9E;
	Wed,  7 Aug 2024 11:08:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cKaEFv08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE06A88AD4; Wed,  7 Aug 2024 11:08:41 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 085FB88A77
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 11:08:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47798We8123451;
 Wed, 7 Aug 2024 04:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723021712;
 bh=pAnbN/Z6AKsAN0JfgCOpy3pO3zfti8c7EgIb3CUP1R8=;
 h=From:To:CC:Subject:Date;
 b=cKaEFv08GhYDXMqJGvg7GPtVjY/mJhrWULUYAdD+9IOq0H/O/9SZvM4IcNlf13yTX
 fgIKXp93qn/90qM6/48cA2kz2u6fCuEdOVjOfGiDDHCLMJZXM/rdc8Y5LAZ2lPzPdw
 wcjAfsEuwJpxXHll2LbJPa+3mY24sOHEENVHx8KI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47798WFC124105
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 7 Aug 2024 04:08:32 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 04:08:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 04:08:32 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47798WhY119493;
 Wed, 7 Aug 2024 04:08:32 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 47798VQM004225;
 Wed, 7 Aug 2024 04:08:31 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Nishanth Menon <nm@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Ravi Gunasekaran <r-gunasekaran@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2] remoteproc: uclass: Modify uc_pdata->name to use
 combination of device name and device's parent name
Date: Wed, 7 Aug 2024 14:38:29 +0530
Message-ID: <20240807090829.530865-1-danishanwar@ti.com>
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
pru0_0 uc->pdata->name = "pru@34000-icssg@30000000"
pru1_0 uc->pdata->name = "pru@34000-icssg@30080000"

Both the names are unique, thus rproc_init() succeeds.

Changes since v1:
*) Instead of hardcoding rproc_name_size to 256, changed it to be equal to
   strlen(dev->name) + strlen(dev->parent->name) + 2 as suggested by
   Roger Quadros <rogerq@kernel.org>
 *) Added check for malloc failure as suggested by Roger Quadros <rogerq@kernel.org>

[v1] https://lore.kernel.org/all/20240719085908.3564171-1-danishanwar@ti.com/
[1] https://elixir.bootlin.com/u-boot/v2024.07-rc3/source/dts/upstream/src/arm64/ti/k3-am64-main.dtsi#L1276
[2] https://elixir.bootlin.com/u-boot/v2024.07-rc3/source/dts/upstream/src/arm64/ti/k3-am64-main.dtsi#L1417
[3] https://lore.kernel.org/all/5cda289f-1d14-41f6-84e3-ff1d1034be13@ti.com/
[4] https://lore.kernel.org/all/e48f5818-182c-47ab-b384-379659830d38@ti.com/

 drivers/remoteproc/rproc-uclass.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/rproc-uclass.c b/drivers/remoteproc/rproc-uclass.c
index e64354dd52..3233ff8041 100644
--- a/drivers/remoteproc/rproc-uclass.c
+++ b/drivers/remoteproc/rproc-uclass.c
@@ -158,9 +158,19 @@ static int rproc_pre_probe(struct udevice *dev)
 		uc_pdata->driver_plat_data = pdata->driver_plat_data;
 	}
 
-	/* Else try using device Name */
-	if (!uc_pdata->name)
-		uc_pdata->name = dev->name;
+	/* Else try using a combination of device Name and devices's parent's name */
+	if (!uc_pdata->name) {
+		/* 2 in the rproc_name_size indicates 1 for null and one for '-' */
+		int rproc_name_size = strlen(dev->name) + strlen(dev->parent->name) + 2;
+		char *buf;
+
+		buf = malloc(rproc_name_size);
+		if (!buf)
+			return -ENOMEM;
+
+		snprintf(buf, rproc_name_size, "%s-%s", dev->name, dev->parent->name);
+		uc_pdata->name = buf;
+	}
 	if (!uc_pdata->name) {
 		debug("Unnamed device!");
 		return -EINVAL;

base-commit: 6f4c31c2b658358628b5b0fa801f55c7477c7585
-- 
2.34.1

