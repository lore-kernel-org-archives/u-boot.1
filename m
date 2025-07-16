Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F315C83F1B
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 07:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C11D8313F;
	Wed, 16 Jul 2025 09:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mAo1/MJ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FF698317B; Wed, 16 Jul 2025 09:05:01 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07F81805D7
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 09:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56G74SxA2792189;
 Wed, 16 Jul 2025 02:04:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752649468;
 bh=XMdzHboCikLHZ5WJorjylcDMG0erGKeOR47+4kH7Gj8=;
 h=From:To:CC:Subject:Date;
 b=mAo1/MJ8q06PUufTHmoMy48IYn9zst2YOhF89sbfqTEGTcKWSeGm/03MTaLa16XW0
 bt1ncwx5enS3tYTd2OsK6IqM7hgQCaVMbPzUOClUaJS+3QLaYLKpWh35JhBHOJVNRI
 V+R2omQugej1CYsxndQX0X5gACqmZWGTO350SbrI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56G74SOH3356819
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 16 Jul 2025 02:04:28 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 16
 Jul 2025 02:04:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 16 Jul 2025 02:04:27 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [172.24.227.142])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56G74NMP3910756;
 Wed, 16 Jul 2025 02:04:24 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <michal.simek@amd.com>
CC: <u-boot@lists.denx.de>, <venkatesh.abbarapu@amd.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <n-francis@ti.com>, <vaishnav.a@ti.com>, <s-k6@ti.com>
Subject: [PATCH] Revert "spi: cadence_qspi: Fix odd byte write issue in STIG
 mode"
Date: Wed, 16 Jul 2025 12:34:07 +0530
Message-ID: <20250716070407.2082524-1-p-mantena@ti.com>
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

The buffer that is being used to write into the flash needs
to be handled properly with padding of 0xFF. The place that
this is done can be at a more generic place like spi-nor core.

This reverts commit cd9123507003e07b13e61d72e14e493bb338e827.

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 drivers/spi/cadence_qspi_apb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 6f89d3add5d..4696c09f754 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -558,9 +558,6 @@ int cadence_qspi_apb_command_write(struct cadence_spi_priv *priv,
 	void *reg_base = priv->regbase;
 	u8 opcode;
 
-	if (priv->dtr)
-		txlen += txlen & 1;
-
 	if (priv->dtr)
 		opcode = op->cmd.opcode >> 8;
 	else
-- 
2.34.1

