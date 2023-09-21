Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B1EE71094
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 17:04:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BCA586BE5;
	Thu, 21 Sep 2023 19:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WBzmlFfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51F2786B7A; Thu, 21 Sep 2023 19:04:03 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D25A186BD5
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 19:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38LH3vOq082241;
 Thu, 21 Sep 2023 12:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695315837;
 bh=KejzwxNgEhTaNAiS1kN9toLDLE0iCN9sbXxre/tqClo=;
 h=From:To:CC:Subject:Date;
 b=WBzmlFfuRGOLXL8p7tialu9rucOlN3nTSNWkCut6ZfgTSaxtp3xBibj7UKU2jYCQf
 GspLVUSC2SIEKFz+iJ8Ear3BsUpTlCh5tfDQImXEz+SALKsbGwQJlTlOAsfKC2cVoF
 /IWmr9I9kadku/HvPtov2VpCi0NHC2adhxzpzigc=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38LH3vSP028455
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Sep 2023 12:03:57 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Sep 2023 12:03:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Sep 2023 12:03:57 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38LH3red048162;
 Thu, 21 Sep 2023 12:03:54 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <seanga2@gmail.com>
CC: <u-boot@lists.denx.de>, <lukma@denx.de>, <bb@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Keerthy <j-keerthy@ti.com>
Subject: [PATCH] clk: ti: clk-sci: Notify AVS driver based upon clock rate
Date: Thu, 21 Sep 2023 22:33:43 +0530
Message-ID: <20230921170343.3214027-1-u-kumar1@ti.com>
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

AVS driver needs to be notified before or after clock change,
depending upon new rate is greater or less than current clock rate.

Fixes: 1e0aa873bc7cd ("clk: clk-ti-sci: Notify AVS driver upon setting clock rate")

Cc: Keerthy <j-keerthy@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Boot logs
https://gist.github.com/uditkumarti/5a05f9b18b8e5bc347ef98c901cc13d4

Separate patch for clk-sci driver to handle AVS,
as per review feedback in
https://lore.kernel.org/all/20230920120256.2901860-1-u-kumar1@ti.com/

 drivers/clk/ti/clk-sci.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/ti/clk-sci.c b/drivers/clk/ti/clk-sci.c
index 74df5a397b..8fc3254c99 100644
--- a/drivers/clk/ti/clk-sci.c
+++ b/drivers/clk/ti/clk-sci.c
@@ -91,12 +91,12 @@ static ulong ti_sci_clk_set_rate(struct clk *clk, ulong rate)
 	const struct ti_sci_handle *sci = data->sci;
 	const struct ti_sci_clk_ops *cops = &sci->ops.clk_ops;
 	int ret;
+	int freq_scale_up = rate >= ti_sci_clk_get_rate(clk) ? 1 : 0;
 
 	debug("%s(clk=%p, rate=%lu)\n", __func__, clk, rate);
 
-#ifdef CONFIG_K3_AVS0
-	k3_avs_notify_freq(clk->id, clk->data, rate);
-#endif
+	if (IS_ENABLED(CONFIG_K3_AVS0) && freq_scale_up)
+		k3_avs_notify_freq(clk->id, clk->data, rate);
 
 	ret = cops->set_freq(sci, clk->id, clk->data, 0, rate, ULONG_MAX);
 	if (ret) {
@@ -104,6 +104,9 @@ static ulong ti_sci_clk_set_rate(struct clk *clk, ulong rate)
 		return ret;
 	}
 
+	if (IS_ENABLED(CONFIG_K3_AVS0) && !freq_scale_up)
+		k3_avs_notify_freq(clk->id, clk->data, rate);
+
 	return rate;
 }
 
-- 
2.34.1

