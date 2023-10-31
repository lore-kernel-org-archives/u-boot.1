Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53081C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 13:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDE0787CCC;
	Tue, 31 Oct 2023 14:28:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mztR4C0K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF8E387AB8; Tue, 31 Oct 2023 14:28:21 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA1AB87B53
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 14:28:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-yadav@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39VDSEJ0094047;
 Tue, 31 Oct 2023 08:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698758894;
 bh=Ms54gVJghUeN9zRmaXtJHfw9/lIHaMP+Wtqz/vExRxQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=mztR4C0KQalbCQ7tAiToscxRqLt+K8rnPBIpwOLJo6M3yJ279avIzFM4vrMUcDkhW
 +w3kCmn7Qi0pFJUKCl4yF1HtgMNWwMmAsjOvK2upGbr96xC5MnbEjqc6uoCrAzzyGo
 wVtdSO9iRuNR76fE2a2cnB9wTJSalG+p0pYCdj6g=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39VDSD5g007460
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 31 Oct 2023 08:28:13 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 31
 Oct 2023 08:28:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 31 Oct 2023 08:28:14 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39VDSCoH030401;
 Tue, 31 Oct 2023 08:28:13 -0500
From: Nitin Yadav <n-yadav@ti.com>
To: <nm@ti.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 2/6] ram: k3-ddrss: k3-ddrss: Fix updating ddr size with ecc
 off
Date: Tue, 31 Oct 2023 18:58:05 +0530
Message-ID: <20231031132809.1524341-3-n-yadav@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031132809.1524341-1-n-yadav@ti.com>
References: <20231031132809.1524341-1-n-yadav@ti.com>
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

When DDR ECC is off (ecc_reserved_space = 0) k3_ddrss_ddr_fdt_fixup()
doesn't update the DDR size in the memory node of DT. Fix this by
dropping check for ecc_reserved_space to be non zero.

This allows R5 SPL to fixup A53 SPL DT with right DDR size as discovered
during DDR init or based on R5 SPL DT input.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Nitin Yadav <n-yadav@ti.com>
---
 drivers/ram/k3-ddrss/k3-ddrss.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index b54557f02c..28129d52a6 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -664,9 +664,6 @@ int k3_ddrss_ddr_fdt_fixup(struct udevice *dev, void *blob, struct bd_info *bd)
 	u64 size[CONFIG_NR_DRAM_BANKS];
 	int bank;
 
-	if (ddrss->ecc_reserved_space == 0)
-		return 0;
-
 	for (bank = CONFIG_NR_DRAM_BANKS - 1; bank >= 0; bank--) {
 		if (ddrss->ecc_reserved_space > bd->bi_dram[bank].size) {
 			ddrss->ecc_reserved_space -= bd->bi_dram[bank].size;
-- 
2.25.1

