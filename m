Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DF4C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 21:21:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2588687F9D;
	Mon, 26 Feb 2024 22:19:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="k3K5pwJc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D856587F75; Mon, 26 Feb 2024 22:19:45 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0507A87F42
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 22:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41QLJUGT069691;
 Mon, 26 Feb 2024 15:19:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708982370;
 bh=5j5hGCMb0sY5ODTE9Sh1/y6IyoOB/CEGzcv222y12h8=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=k3K5pwJcCkavY0hFgl97C3AesECIvDmnuwcw6XrTaFPVh6w1llRvoOPM+RCRgjI2p
 tZaUJjCCmA1GKXCh8rM3qI/TAMKOFYABdbHVgjLi3uPCLDP65DXmzyxkDL9xqTa829
 jyAfdRkcs53Ri8tOdqoQA92SrGgZcBRSCvV03csU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41QLJUUZ017092
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Feb 2024 15:19:30 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Feb 2024 15:19:29 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Feb 2024 15:19:29 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41QLJTZP058303;
 Mon, 26 Feb 2024 15:19:29 -0600
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 26 Feb 2024 15:19:08 -0600
Subject: [PATCH v3 02/13] power: domain: ti: use IS_ENABLED macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240205-am62px-wip-rebasing-v3-2-04cbb42eaa6f@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=bb@ti.com;
 h=from:subject:message-id; bh=pcQD7IsIcyEVM7Ab6cJzKgISEoGUaiGlvQtsH1mgdFg=;
 b=owNCWmg5MUFZJlNZQr9GQgAAbX////ff+y88/VP/PY/m95fe99bv1O/s/0fx/iv7z3f1/96wA
 RmYIeoAAAyDQAAMmgMgaAAAAaGgAGjQaGgaBoAADR6mh6gGnqDQfqJjTT1EOgaBkAGTTQAADQ0y
 NMg2oAGCAMgGmmTQyMQGI0yAMTQ0NNAHpMQAA9EMchoaNpNGg02oAGI0GgBoDRpkyAAaNAaYIaZ
 BhDEDCANBpoAZPUGgAZDQAQILigg1UA9nkcHbCRq7DgDUJMfZESd0qsAkTBgg1g2D4x4ZHIpBGu
 FEZeZvm4eppeB6+dgEX0cVJkggWm1QTzVJJmviGfnB1mZyogwX1AiG43SEprXawvqEY5pFitS7H
 yx5UiW467vpG3IuZg81yWQxPm1SMy0wOCpsvAYK7plzABsQjs1gSn9RSHCDaQwIeB9rFRlRAgHu
 GyjkkhVgLJ4Wo4qcMe0YdgVZa701+z2+AsRf2Yz1Qit7DUJIpgdYdAKrVhS/R5BfF7Ekc4V9Evv
 RyCFH+IFR9ZVjqe8a3MEsBEmMRX44OcJo6nMlppQh4vJPwe32LHEXgNRaXAPnrf5vApSDdjOjLG
 1BAhpcrPCKsWYXkJsRkIwTbcmfV/hQCasqcD3cqL5KOt0ujBib+J2vMyVDpge4UIWAwk6fYouNj
 1FKX/F3JFOFCQQr9GQg
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

Cleanup this list and standardize on using the IS_ENABLED macro for the
power domain data list.

Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/power/domain/ti-power-domain.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/power/domain/ti-power-domain.c b/drivers/power/domain/ti-power-domain.c
index b34c982f4f5fa..dc5d74539edcf 100644
--- a/drivers/power/domain/ti-power-domain.c
+++ b/drivers/power/domain/ti-power-domain.c
@@ -81,19 +81,20 @@ static const struct soc_attr ti_k3_soc_pd_data[] = {
 		.family = "J7200",
 		.data = &j7200_pd_platdata,
 	},
-#elif CONFIG_SOC_K3_J721S2
+#endif
+#if IS_ENABLED(CONFIG_SOC_K3_J721S2)
 	{
 		.family = "J721S2",
 		.data = &j721s2_pd_platdata,
 	},
 #endif
-#ifdef CONFIG_SOC_K3_AM625
+#if IS_ENABLED(CONFIG_SOC_K3_AM625)
 	{
 		.family = "AM62X",
 		.data = &am62x_pd_platdata,
 	},
 #endif
-#ifdef CONFIG_SOC_K3_AM62A7
+#if IS_ENABLED(CONFIG_SOC_K3_AM62A7)
 	{
 		.family = "AM62AX",
 		.data = &am62ax_pd_platdata,

-- 
2.43.2

