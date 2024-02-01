Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8049C47DB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:08:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09AC087C93;
	Thu,  1 Feb 2024 04:06:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uw8+yJp7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A782A87CC4; Thu,  1 Feb 2024 04:06:55 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 204C187CC2
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:06:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41136bSC078945;
 Wed, 31 Jan 2024 21:06:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706756797;
 bh=Ww3pCUWb2mUpthWQk8Bx26JtIcpDkIIMZIRbutyZ90A=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=uw8+yJp7RhKmryjV9Rljb+37zCnlXgFqjpSLdj5fBPobOiltCvyB8SkZjlwY2XHXy
 4C7+9cuINJa/PBvCwplQPfbN3d8ka7Bg7x1ygKc9jhEMRMf4XgPUd8h7x4Rv2b142I
 SQaUE5yU6gP1b8a2L910AVB/1jKYgxpIRia2BHU0=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41136bio008934
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 31 Jan 2024 21:06:37 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 21:06:37 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 21:06:37 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41136bNw043587;
 Wed, 31 Jan 2024 21:06:37 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Hari
 Nagalla <hnagalla@ti.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 UBoot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 08/13] firmware: ti_sci_static_data: add static DMA channel
 data
Date: Wed, 31 Jan 2024 21:06:44 -0600
Message-ID: <20240201030634.1120963-25-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201030634.1120963-16-bb@ti.com>
References: <20240201030634.1120963-16-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1210; i=bb@ti.com;
 h=from:subject; bh=4dC57aUXz0BchTONDrwiMHBFBvQkOAeKOvCaYjuP94g=;
 b=owNCWmg5MUFZJlNZ0GnTFQAAaP////d7P/9nO7/tvf8Vv/f/kzevfR8FfWf5+//729zG3/2wA
 Rsxo5AAAAPUANAAAGhoGgaAZGgNAAANqAAAAAGgPUepoNqPKZNlNpNHqHpPUQBoAAANA0yMgAA0
 ekaNNDIDCDQyDJpoA0MRpkGEAMmJowg00xAAGmIYMUNGjJoNAGQ0ZMQAaaYhoNBo00000AAaMjE
 yGI0DIAAyAMgBkZMIAADTQIEoA5t5NpNUu9QIitRWUJMjwuifLxr7CiQOkFOoot/GPcQ26Dt3AO
 hOU81uJIdNvOo8U5Rk9V4lRdYy2jcNY9Jh/To/aJmLch+y2dM63aQjCx4o1GEmABlFg+t1ujAFM
 BNOsI5v8mXawRT8cf68+WybIm4eu971Fra/qwznmAOGohF7+I1aSC7CmuVQOGhUCMQnEMFsSYlh
 FE8wGsmxFYL9nhVa/F60/lElKQ/BBz7pJJBSNICiYZ0NUyXCoXOVlpTojtgGvT6O/C0wMvCFHDJ
 bSI2YQxdc0qWU2xpnjpHQagseN3tEyce4MZHLHDXyk9RV8lETQJ+QJHzDD4AEcQsqZsdwCWe65c
 tSpxq3ZN/YpQnEP+wKmzc/NZkx8jafoK6YbGqUK1dYdhEpyMMNacIZoAGvoL7y/5yAAydZUZdoi
 1H8Zt0Zn+LuSKcKEhoNOmKg
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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
2.43.0

