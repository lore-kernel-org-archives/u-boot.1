Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A053BC48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 21:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A2D787FA3;
	Mon, 26 Feb 2024 22:19:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="p6eb5ypx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2098B87A80; Mon, 26 Feb 2024 22:19:46 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9348887F48
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 22:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41QLJUHA079085;
 Mon, 26 Feb 2024 15:19:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708982370;
 bh=qDDph8ATjUFU+2ztwUo1HQz1mqpGwwITu3xnF75q32E=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=p6eb5ypxrag9gbWDtvzM78GzgykJm0aJi04so3EIdyJ6z7QzWQocWZuBKKaLmPPPA
 ES4AvYNKdQZO1X5Pxp2SFQmsA1f2z3UPgmPO8ZCwhKaeIInrjrdUUUFNU3mxN5AYfE
 TJGj59iPpPtrdD1rVvRMi/O8YNe+qorSJqEwblK4=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41QLJUMb017112
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Feb 2024 15:19:30 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Feb 2024 15:19:29 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Feb 2024 15:19:29 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41QLJUPp058312;
 Mon, 26 Feb 2024 15:19:30 -0600
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 26 Feb 2024 15:19:14 -0600
Subject: [PATCH v3 08/13] firmware: ti_sci_static_data: add static DMA
 channel data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240205-am62px-wip-rebasing-v3-8-04cbb42eaa6f@ti.com>
References: <20240205-am62px-wip-rebasing-v3-0-04cbb42eaa6f@ti.com>
In-Reply-To: <20240205-am62px-wip-rebasing-v3-0-04cbb42eaa6f@ti.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon
 <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew Davis
 <afd@ti.com>, Igor Opaniuk <igor.opaniuk@foundries.io>, Hari Nagalla
 <hnagalla@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>, Vaishnav Achath
 <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1212; i=bb@ti.com;
 h=from:subject:message-id; bh=n9bfcMO2ZAdVexNCLyZ4moQ+STIFpkz4hboYWZQXTZM=;
 b=owNCWmg5MUFZJlNZNztG7wAAZ////7//32VtvPf1f/feHm+fvr/j3/X+bfpx9/9dq/9v6W2wA
 RssDtRo0ADIAAAAaAAPUAAPUA0ANA0A0BoAaaNGgADRp6gaPUA0ekaekaHinlEBiNNDRpoBk0Bo
 AaaZGhpkBoaDJo0BoaMg00GNCaGjEAA0000AaGmIaAAMgNAyTDRGTE0AGgBoDTQDIyGmg0aeoAA
 00MmgaADRkyNAANAGIGIMgaAaBoNASJPOXQAEDdsBRHXtR7qRLICgycnvc+5vjySAsuexPsw02M
 xIxSWA/oaCbg07Q33utaynSUto3Wu8eAwWoblbLmPUyIblOPhBM0/ttk+n+Q8YOhWWmA4AYH9z6
 VlRswbtZzk2ji4scADFGuEtTlpVTguT4u7I+rL00qxv2AJEym81kZMMuMA8bt5YmdY2Ac7153DH
 z48WbECk98qaQLNWppHFqyYyFplPHeygymgs+VYHVgc29pHXr2Co+Zb+4kkjQaHmDN8mSZ4nREo
 IE5Uhs0DVbgbUJon0qBSuPaYRHwSdVnwDadC/iIkPcU/KQ6LxBJYQnWd7Awh1S4XPF9FFSNQ5Cu
 Q9TixWmsDjcOpX+kpeAW6gwqUBGq9xjDKM+EGCQLu5ScFYT9Gb+oLsSPzbzCxyTqdtSLBwuMkoA
 1elFsZcamhz3t/i7kinChIG52jd4A==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

From: Hari Nagalla <hnagalla@ti.com>

Include the static DMA channel data for ti_sci

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/firmware/ti_sci_static_data.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/ti_sci_static_data.h b/drivers/firmware/ti_sci_static_data.h
index 567ce8911a7da..135ec01bda460 100644
--- a/drivers/firmware/ti_sci_static_data.h
+++ b/drivers/firmware/ti_sci_static_data.h
@@ -84,7 +84,8 @@ static struct ti_sci_resource_static_data rm_static_data[] = {
 };
 #endif /* CONFIG_SOC_K3_J721S2 */
 
-#if IS_ENABLED(CONFIG_SOC_K3_AM625) || IS_ENABLED(CONFIG_SOC_K3_AM62A7)
+#if IS_ENABLED(CONFIG_SOC_K3_AM625) || IS_ENABLED(CONFIG_SOC_K3_AM62A7) || \
+	IS_ENABLED(CONFIG_SOC_K3_AM62P5)
 static struct ti_sci_resource_static_data rm_static_data[] = {
 	/* BC channels */
 	{
@@ -95,7 +96,7 @@ static struct ti_sci_resource_static_data rm_static_data[] = {
 	},
 	{ },
 };
-#endif /* CONFIG_SOC_K3_AM625 || CONFIG_SOC_K3_AM62A7 */
+#endif /* CONFIG_SOC_K3_AM625 || CONFIG_SOC_K3_AM62A7 || CONFIG_SOC_K3_AM62P5 */
 
 #else
 static struct ti_sci_resource_static_data rm_static_data[] = {

-- 
2.43.2

