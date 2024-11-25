Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FFCE668A2
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 10:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41F7289A09;
	Mon, 25 Nov 2024 11:49:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="m42f38HW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D6C989A2E; Mon, 25 Nov 2024 11:49:57 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC388899F1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 11:49:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4APAnqYG013974;
 Mon, 25 Nov 2024 04:49:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732531792;
 bh=9GeaBKitiyuBQNpO3xrDL5xAof+eLzfkkuQa+mXfAVE=;
 h=From:To:CC:Subject:Date;
 b=m42f38HWG9/ZN0J8Mzx5fJCBN2lGi7xmkP4ck/P0+Z0Xu8IyMzBIx1zbFBzjjbIx4
 MEVssoNxaOoTHQdCDMmFzP2XGoDGiHUih1x1U7WtjNtE3AxqvHNmuFeyf1p36q5LLJ
 ij4eEpyAoyeYRDB4RsGONzyfgQHdpk6Q0tiH/PWY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4APAnqnX050330
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 25 Nov 2024 04:49:52 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Nov 2024 04:49:52 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Nov 2024 04:49:52 -0600
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [172.24.227.142])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4APAnnP4025297;
 Mon, 25 Nov 2024 04:49:50 -0600
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <vigneshr@ti.com>
CC: <u-kumar1@ti.com>, <j-humphreys@ti.com>, <n-francis@ti.com>,
 <vaishnav.a@ti.com>
Subject: [PATCH] mtd: spi-nor-core: Fixup SNOR_F_IO_MODE_EN_VOLATILE for MT35X
Date: Mon, 25 Nov 2024 16:19:47 +0530
Message-ID: <20241125104947.1324824-1-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

From: Vaishnav Achath <vaishnav.a@ti.com>

MT35XU512ABA has only BFPT and 4-Byte Address Instruction Table
in  SFDP. commit bebdc237507c ("mtd: spi-nor: Parse SFDP SCCR Map")
added checks in spi_nor_octal_dtr_enable() to bail out if the 22nd DWORD
in SCCR does not indicate DTR Octal Mode Enable, since MT35XU512ABA device
supports octal DTR mode, add this property in SFDP fixup.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---

Test results : https://gist.github.com/PrasanthBabuMantena/678cbd7a230a4e2d19e22d20dfeb1235

 drivers/mtd/spi/spi-nor-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index ec841fb13bd..6364d91fac0 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4109,6 +4109,12 @@ static void mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor,
 	params->rdsr_dummy = 8;
 	params->rdsr_addr_nbytes = 0;
 
+	/*
+	 * SCCR Map 22nd DWORD does not indicate DTR Octal Mode Enable
+	 * for MT35XU512ABA but is actually supported by device.
+	 */
+	nor->flags |= SNOR_F_IO_MODE_EN_VOLATILE;
+
 	/*
 	 * The BFPT quad enable field is set to a reserved value so the quad
 	 * enable function is ignored by spi_nor_parse_bfpt(). Make sure we
-- 
2.34.1

