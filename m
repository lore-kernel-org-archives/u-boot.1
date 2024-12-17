Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3801CE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8721A801CE;
	Tue, 17 Dec 2024 09:54:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FmjHNJiF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18427801CF; Tue, 17 Dec 2024 09:54:48 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE9CC801A0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 09:54:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BH8sg003605071
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Dec 2024 02:54:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734425682;
 bh=Cj5Hxe5B4Vj4JQgaAirqRBea8DsSmp8psAIr+x7oFKE=;
 h=From:Date:Subject:To:CC;
 b=FmjHNJiFCf8EuPokXnSSo6TaHlCBNSC5Y5d2+8DRoCr3gi9tTU1t8XzND3qBKQWZy
 2xIpigJ49QXhmIFU1ZKoZ7IseBvDXHCW6zY/o8Pj3Nmlmu7MCRnx5527UUemmJ20Ks
 8uoMRoWC5NARArVdD/BE68PYm7ivmXky4fBczl2w=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BH8sgm2039219
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 17 Dec 2024 02:54:42 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Dec 2024 02:54:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Dec 2024 02:54:41 -0600
Received: from [127.0.1.1] (uda0497581-hp.dhcp.ti.com [172.24.227.160])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BH8sdvp125542;
 Tue, 17 Dec 2024 02:54:39 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 17 Dec 2024 14:24:37 +0530
Subject: [PATCH] drivers: firmware: ti_sci: Add DM_FLAG_PRE_RELOC to driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241217-b4-upstream-dm-pre-reloc-v1-1-ccd29165bbb6@ti.com>
X-B4-Tracking: v=1; b=H4sIAEw8YWcC/x2MSQqAMAwAvyI5G7CLIn5FPFQbNeBGqiJI/27xO
 AwzLwQSpgBN9oLQzYH3LYHKMxhmt02E7BODLrRVWlXYW7yOcAq5Ff2KhxAKLfuAZW2UsV47Ywt
 IeTIjP/+67WL8AHe9igpqAAAA
X-Change-ID: 20241216-b4-upstream-dm-pre-reloc-583134d2a340
To: Tom Rini <trini@konsulko.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, <u-boot@lists.denx.de>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734425679; l=1456;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=4cdbWd/SkQAmeNMRV/eb5rPWGmEIJSn+YfkA6DF6f50=;
 b=HbpL/oNzxappOyWT6zRJqPM92sKGiJXXNc9w7HjEXjJX0hQw2pVF0KZbbnxQhhOwuXLpdc1+W
 Z2Crdcr0XIHD6bZFzt/G9AeAP4Fo/qOEXiW1bn5o/UKoRK3+bbV6cD0
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Currently the driver relies on bootph flag to probe it during PRE_RELOC
stage but with the upcoming cleanup of v6.13, we don't have the bootph
property in the parent nodes anymore and ti_sci driver being one of the
parent nodes required during SPL stage would end up hampering the probe
model [0].

Add DM_FLAG_PRE_RELOC to ti_sci driver for mitigating this issue.

[0]: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/21

Suggested-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Test logs with current DT: https://gist.github.com/manorit2001/b28bebd8229818412ff74e40d4a53f71
Test logs with 6.13-rc3 DT: https://gist.github.com/manorit2001/b91691b59581d445c301e2608ce5931a
---
 drivers/firmware/ti_sci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 719cfa771b4198159a305a08a044c7a8aaf7a14f..190a1e3f5fc3713464b0cbf3ae8c35e3f185a353 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3077,6 +3077,7 @@ U_BOOT_DRIVER(ti_sci) = {
 	.of_match = ti_sci_ids,
 	.probe = ti_sci_probe,
 	.priv_auto	= sizeof(struct ti_sci_info),
+	.flags = DM_FLAG_PRE_RELOC,
 };
 
 #if IS_ENABLED(CONFIG_K3_DM_FW)

---
base-commit: 9bc62c980d418f0a67632ab29cd3501072cdb6f0
change-id: 20241216-b4-upstream-dm-pre-reloc-583134d2a340

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

