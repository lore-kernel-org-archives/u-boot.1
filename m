Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCDDE77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 13:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE8A780316;
	Wed, 18 Dec 2024 14:14:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wnkvicID";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BA51802BF; Wed, 18 Dec 2024 14:13:59 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A51D680283
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 14:13:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BIDDrum163231
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 07:13:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734527634;
 bh=aEWe/lI+yV2auAhmZJ0Txntp0v6NvjAVeVmbioqbXQ0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=wnkvicIDaIu/KdSgGy1HLJPLFIcgOZr9kWF/tt5+cs8B4E+hycg6e53xWAZt536JZ
 NxKvuSOK2HHzVOdXAXssHD6ksZZaHvunQNwnNR6fvZOAH/I696VsWZXLJXMGaRNbTs
 uClTtTXkIIVop8X0TVQwnTLKwfijUSLhGMe1D6kg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BIDDrnm063207
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 18 Dec 2024 07:13:53 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Dec 2024 07:13:53 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Dec 2024 07:13:53 -0600
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [172.24.227.142])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BIDDjRZ035276;
 Wed, 18 Dec 2024 07:13:50 -0600
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <vaishnav.a@ti.com>, <s-k6@ti.com>
Subject: [PATCH v2 1/4] mailbox: k3-sec-proxy: Add DM to DMSC communication
 thread for J722S
Date: Wed, 18 Dec 2024 18:43:38 +0530
Message-ID: <20241218131341.2073823-2-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218131341.2073823-1-p-mantena@ti.com>
References: <20241218131341.2073823-1-p-mantena@ti.com>
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

J722S R5 SPL uses sec-proxy threads 28 and 29 for communication with
TIFS. Mark these as valid threads in the driver.

https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j722s/sec_proxy.html

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 drivers/mailbox/k3-sec-proxy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/k3-sec-proxy.c b/drivers/mailbox/k3-sec-proxy.c
index 5eafe46fd4d..6f5ad37919f 100644
--- a/drivers/mailbox/k3-sec-proxy.c
+++ b/drivers/mailbox/k3-sec-proxy.c
@@ -408,7 +408,7 @@ static int k3_sec_proxy_remove(struct udevice *dev)
 	return 0;
 }
 
-static const u32 am6x_valid_threads[] = { 0, 1, 4, 5, 6, 7, 8, 9, 11, 12, 13, 20, 21, 22, 23 };
+static const u32 am6x_valid_threads[] = { 0, 1, 4, 5, 6, 7, 8, 9, 11, 12, 13, 20, 21, 22, 23, 28, 29 };
 
 static const struct k3_sec_proxy_desc am654_desc = {
 	.thread_count = 90,
-- 
2.34.1

