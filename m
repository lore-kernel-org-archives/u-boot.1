Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69F6C4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 23:13:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C86C686EB9;
	Mon,  6 Nov 2023 00:13:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="agdiOV1z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26C9786EB9; Mon,  6 Nov 2023 00:13:53 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC32E86EB5
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 00:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20231105231341epoutp015fdd9f1c743e6ef2fe2339f3d02acd36~U3RBUCDpY2724227242epoutp01s
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 23:13:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20231105231341epoutp015fdd9f1c743e6ef2fe2339f3d02acd36~U3RBUCDpY2724227242epoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1699226021;
 bh=G9ct3tzwAAcA9kE+uNUibjv1POZ7xXJjhyciimOL18g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=agdiOV1zv5fEcnpnfd7dhjS2kjYoEGwMD1c7UFlDT2+27+m/i8llfA5XUUyGr9utz
 ZZFTkRI27TC9sGbuIZnGdGxZE9s4xxo9v/JMilQ68pv7QzeZ7pZiX2QtRod2XGa8rF
 6P53km9CNZRDIcS/jL7YRvSoMRx+PgMR7SXIfeYE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20231105231341epcas2p4f64cbf727272c1adc90facfe8067091c~U3RBC4jDY0348703487epcas2p4z;
 Sun,  5 Nov 2023 23:13:41 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.90]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4SNqzT0GN4z4x9Q8; Sun,  5 Nov
 2023 23:13:41 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C4.B8.18994.4A128456; Mon,  6 Nov 2023 08:13:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20231105231340epcas2p119f8245b5f344caa3d8120a829f82759~U3RAeleH02024120241epcas2p18;
 Sun,  5 Nov 2023 23:13:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231105231340epsmtrp25b19571f7c2e5a1b325535ae4fb51cf8~U3RAddCFr1858218582epsmtrp2K;
 Sun,  5 Nov 2023 23:13:40 +0000 (GMT)
X-AuditID: b6c32a4d-743ff70000004a32-ba-654821a45d15
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 50.8E.08755.4A128456; Mon,  6 Nov 2023 08:13:40 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20231105231340epsmtip2719495cc4baa47eaa0707987ebd1b797~U3RAQF05m1198511985epsmtip2P;
 Sun,  5 Nov 2023 23:13:40 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, Stefan
 Roese <sr@denx.de>, Yanhong Wang <yanhong.wang@starfivetech.com>, Xingyu Wu
 <xingyu.wu@starfivetech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 1/4] clk: starfive: jh7110: Add watchdog clocks
Date: Mon,  6 Nov 2023 08:13:15 +0900
Message-Id: <20231105231318.992857-2-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231105231318.992857-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdljTXHeJokeqwZy1NhaX92tbvH1xltHi
 5LoPTBZv93ayWyyccZbJ4kfXI0aLx4deMzmwe+w5PYvZY96sEyweZ+/sYPTo27KK0eP2Wd4A
 1qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygK5QU
 yhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ
 2Rk/+mYwFhznqGjoe8LcwDiTvYuRk0NCwESi/WQHUxcjF4eQwB5Giaftj5hAEkICnxglNsyJ
 gUh8Y5R4NHUBG0zHzPaT7BCJvYwSd2+8ZoVwpjFJbHgzF2wum4CuxJbnrxhBbBGBU4wS6y4p
 g9jMAtoSnZ+nANVwcAgL2Es83yQJEmYRUJV48H0ZC0iYFyj8caoriCkhIC+x+IEESAWngINE
 7+5tYCfwCghKnJz5hAVioLxE89bZzCAXSAg8Ypf4sO0PC8SdLhK3V/1hgrCFJV4d3wL1sZTE
 53d72SDml0vsWJYE0dvCKNHctocZosZe4sfNKawgNcwCmhLrd+lDlCtLHLkFtZZPouPwX3aI
 MK9ER5sQRKO6xIHt06EOkJXonvOZFcL2kFg4ew00nCYzSkw+uZ1xAqPCLCTfzELyzSyExQsY
 mVcxSqUWFOempyYbFRjq5qWWw2M4OT93EyM4VWr57mB8vf6v3iFGJg7GQ4wSHMxKIryO3i6p
 QrwpiZVVqUX58UWlOanFhxhNgaE9kVlKNDkfmKzzSuINTSwNTMzMDM2NTA3MlcR577XOTRES
 SE8sSc1OTS1ILYLpY+LglGpg6vu4e87P+4YNzicX/zBTvW7wYiEvX+L51VIXcv+dWPvCf6/W
 0QWqon86+lelR+ntaNQJKEh603ttiROH7dz0GKcYpiqmi5VV73/Gr1TcWb/k18QLAQvLQ/nM
 3m2zEH7Po7ll2T7XjUu1TppHPtu10H6rt2Kqu5n0uotHDE22tLJu0I5b+eL74wUz7Su7RCIf
 v7w6zaKCTXpiTPNSXd3tvZHrGO66rem7obhd7O0rxuqVdkGnRF8I+ypv3N/zQEY6WHQnt8iJ
 ogft5zu3hn4ptV3U8qKVZ5pqqdOFpuzDTr57n5p8OX/5ivr1Pf0figX4j5o/frAiqODQsSPf
 aw9tTvk/3V9id+36zS77489kNSixFGckGmoxFxUnAgCLa52kHgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsWy7bCSvO4SRY9Ug6nT1C0u79e2ePviLKPF
 yXUfmCze7u1kt1g44yyTxY+uR4wWjw+9ZnJg99hzehazx7xZJ1g8zt7ZwejRt2UVo8fts7wB
 rFFcNimpOZllqUX6dglcGT/6ZjAWHOeoaOh7wtzAOJO9i5GTQ0LARGJm+0kgm4tDSGA3o8TR
 wy+hErISz97tgLKFJe63HGGFKJrEJLH7y1U2kASbgK7EluevGEESIgIXGCUm7JjFCJJgFtCW
 6Pw8Baibg0NYwF7i+SZJkDCLgKrEg+/LWEDCvEDhj1NdQUwJAXmJxQ8kQCo4BRwkendvA5su
 BFTx4+shZhCbV0BQ4uTMJywQw+UlmrfOZp7AKDALSWoWktQCRqZVjJKpBcW56bnFhgWGeanl
 esWJucWleel6yfm5mxjBAa2luYNx+6oPeocYmTgYDzFKcDArifA6erukCvGmJFZWpRblxxeV
 5qQWH2KU5mBREucVf9GbIiSQnliSmp2aWpBaBJNl4uCUamCaFG8teH9ycNrW2t/KVuVPb3du
 NjHYKzRn45ZarpdqPLcc194pdJul0y8ePLEgPouzK/9/3P6TCnV9fYceJH3ZnfxuuVdu/LfJ
 /N09vZFZkn+3zJjMzTFbtTx6ycr1U6007895GVyjq3jsV0rXtE6Gow92tfz4PLVVJ2dihfv+
 oJ4+xqs+fd7G84X7NrNseTKldvlbSdFNOc6ny9h0xYVXFSx9HLYxzblddeuOxtRHuw9I+3/2
 1mTncLCaH7xq3taaKuHwaXcX8ISksBz5o30UaGnrtL9iF4K1i1fW7BSuWpTSEDOd+9GLV2Ed
 Dim7K179Slqj33HpquW5Z/p/9sxcyhHJraNUGPSEb0HuDCWW4oxEQy3mouJEAPWBGpjXAgAA
X-CMS-MailID: 20231105231340epcas2p119f8245b5f344caa3d8120a829f82759
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231105231340epcas2p119f8245b5f344caa3d8120a829f82759
References: <20231105231318.992857-1-chanho61.park@samsung.com>
 <CGME20231105231340epcas2p119f8245b5f344caa3d8120a829f82759@epcas2p1.samsung.com>
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

Add JH7110_SYSCLK_WDT_APB and JH7110_SYSCLK_WDT_CORE clocks for JH7110
watchdog device.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/clk/starfive/clk-jh7110.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/starfive/clk-jh7110.c b/drivers/clk/starfive/clk-jh7110.c
index a835541e48e9..a38694809a00 100644
--- a/drivers/clk/starfive/clk-jh7110.c
+++ b/drivers/clk/starfive/clk-jh7110.c
@@ -434,6 +434,15 @@ static int jh7110_syscrg_init(struct udevice *dev)
 	       starfive_clk_gate(priv->reg,
 				 "i2c5_apb", "apb0",
 				 OFFSET(JH7110_SYSCLK_I2C5_APB)));
+	/* Watchdog clocks */
+	clk_dm(JH7110_SYS_ID_TRANS(JH7110_SYSCLK_WDT_APB),
+	       starfive_clk_gate(priv->reg,
+				 "wdt_apb", "apb0",
+				 OFFSET(JH7110_SYSCLK_WDT_APB)));
+	clk_dm(JH7110_SYS_ID_TRANS(JH7110_SYSCLK_WDT_CORE),
+	       starfive_clk_gate(priv->reg,
+				 "wdt_core", "oscillator",
+				 OFFSET(JH7110_SYSCLK_WDT_CORE)));
 
 	/* enable noc_bus_stg_axi clock */
 	if (!clk_get_by_id(JH7110_SYSCLK_NOC_BUS_STG_AXI, &pclk))
-- 
2.39.2

