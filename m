Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFE6C47DB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09EB687CC4;
	Thu,  1 Feb 2024 04:06:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MHW0sIwG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE51687CD4; Thu,  1 Feb 2024 04:06:53 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31AEB87CA3
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41136bwg082251;
 Wed, 31 Jan 2024 21:06:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706756797;
 bh=Kde3WHe6oPdIRXAXGDMMnAst8hx+yr95CjMi7eEM7p0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=MHW0sIwGuUiDG0pzgiZgmap6ycsEYCtwzK8mr7FmDLtBJ4jOzS+MHTqwq6/EI9kuB
 v4w8FGN63cHTAHKiO07V+NDm3y0SRkiJJc4dj1Quu4palsy8Rm+J0MzmK+rAZGIRkc
 BToqlt8PXepO3JKareFLB3oHhBRpanUHEOguI/fk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41136bhD124151
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 31 Jan 2024 21:06:37 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 21:06:37 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 21:06:37 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41136bbu098191;
 Wed, 31 Jan 2024 21:06:37 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Hari
 Nagalla <hnagalla@ti.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 UBoot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 02/13] power: domain: ti: use IS_ENABLED macro
Date: Wed, 31 Jan 2024 21:06:38 -0600
Message-ID: <20240201030634.1120963-19-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201030634.1120963-16-bb@ti.com>
References: <20240201030634.1120963-16-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=bb@ti.com;
 h=from:subject; bh=rl4Gp6rUa7izVRvlpMe4KSdr3zO25ZpriW9O1ozOnhw=;
 b=owNCWmg5MUFZJlNZkKqmnQAAZv////br0n+1j6DOnb/83937T/j75m1/7t//9/wf+7/ZvOewA
 RswHammhkNAMgA0Gho0ABiNNGjQGgDQGhoANGgDQBoyGQaHqaeoaGmmmQ0aZMCbKHQNNA0bUADR
 oAaANGTTQMgaABiZAaZBiPQjIGCADQ0ZD1A0GIG1AaaNGTIgyYJpoaBo000A00Bk000yMQANGmQ
 AGRkZGTAQAxGIABowTJpoAAAGjRgIEShqwHboakGJEEoutYT7fzmIUigm2AbqnbiKqNxwNFwW/b
 D/Hng1i4NRzOvPFIIAN6yivKTu6h47jOo47qkZ1xjug8lpERLELMLjc7jHAy7djwL0SxS4Dw9iN
 tAAi7z16FboRU0YFBT7gCu/nTvw3ZZt4CskpQR+vwWlr16/EB2fPuf4vaRWTaTIo4YauRbyEcGp
 KpWDQqGUvkQSHCUd3USZaPyrPhnRrlWd9wq5wcQKU0eLV9q7sC4wQwah6T1TYytWEWwTBJLMVJC
 LKFkrNKCPLr1nj+1ICiffXLM2QT/AVyxWrx/tMN2+qgFuMGmFcsUZ+yTEYN1DhU0RMiNCiYTOJs
 jxYRU1PNIWaRCKnQClreuBDTUBrTn9ouMBEMaCqrGAAuIBULmbG0lPTclxzrA23P8jzIIUv8ndl
 dABuzaQmIYE/xdyRThQkJCqpp0=
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

Cleanup this list and standardize on using the IS_ENABLED macro for the
power domain data list.

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
2.43.0

