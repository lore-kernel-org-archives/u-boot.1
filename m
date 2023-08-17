Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDA4EB64DD
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 08:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAFAB86AA5;
	Thu, 17 Aug 2023 10:57:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Lyzg2Wwb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F06F886AA8; Thu, 17 Aug 2023 10:57:31 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 679B486AB1
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 10:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1692262645; x=1694854645;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RIWg0dbS6pnFFWPA1pz3o9pMd/pkDLG/GqatTj79Chk=;
 b=Lyzg2Wwb+v/AOAgPrLJshOPtOJYKci6eKH4QgUxy1pAJdiR1QbYiO+TdTm3JwPf0
 qnvvDOjeikpKor79SXFAtOhh878hDrTNLlCpQ9Q2ir6t6nFInW1LdJHh+Nwa/3F/
 G4ZPg1svV39LMDxW2+QC7w0e87l3UTloZrlmY0Naj0I=;
X-AuditID: ac14000a-917fe70000007ecb-b7-64dde0f50f8a
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 97.D2.32459.5F0EDD46;
 Thu, 17 Aug 2023 10:57:25 +0200 (CEST)
Received: from llp-tremmet2.fritz.box (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Aug
 2023 10:57:24 +0200
From: Teresa Remmet <t.remmet@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP i
 . MX U-Boot Team" <uboot-imx@nxp.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Yannic Moog
 <y.moog@phytec.de>, Daniel Schultz <d.schultz@phytec.de>, Wadim Egorov
 <w.egorov@phytec.de>
Subject: [PATCH v2 6/6] board: phytec: phycore_imx8mp: Add 4000MTS RAM timings
 based on PCB rev
Date: Thu, 17 Aug 2023 10:57:11 +0200
Message-ID: <20230817085711.45339-7-t.remmet@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817085711.45339-1-t.remmet@phytec.de>
References: <20230817085711.45339-1-t.remmet@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWyRpKBR/frg7spBp/nilk8vOpv0X7Kx+Lt
 3k52iymP17NbdL9Td2D1mDfrBIvHzll32T3O3tnB6NHf3cLqsfHdDqYA1igum5TUnMyy1CJ9
 uwSujA2/NrAXnJeuOPjiLXsD40PxLkZODgkBE4nZ5yaxdjFycQgJLGGSuNF9Acp5xijRN6OB
 HaSKTUBD4umK00wgtohAmcTD3k/MIDazwGJGidW/LUFsYYF4ifvvZrGC2CwCqhI/1k4Bq+EV
 MJf4sucpM8Q2eYn9B8+C2ZwCFhJN3TfA5gsB1Szq2cUIUS8ocXLmExaI+fISzVtnQ+2SkDj4
 4gUzRL28xK5LJxlhZk479xpqfqjEkU2rmSYwCs1CMmoWklGzkIxawMi8ilEoNzM5O7UoM1uv
 IKOyJDVZLyV1EyMo8EUYuHYw9s3xOMTIxMF4iFGCg1lJhLeH91aKEG9KYmVValF+fFFpTmrx
 IUZpDhYlcd77PUyJQgLpiSWp2ampBalFMFkmDk6pBsb4hbW9Tp3MiovtObuWN/o7P47KrKw8
 I6T5YJqwZIj1HYmLW7OTJnUfOTXj/zSzRAbPP6v875ZvjLDtcWN+P0fiSNbeiyGs3/LWMb3R
 ryj0+Li+Tahz0oT5ri7SaYWbbh0PknfuYDzUwxH0cN2hINacF5r6+WyrDcT99J/us7Bcau5X
 dfpCthJLcUaioRZzUXEiAGL7SZBqAgAA
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

Starting with PCB revision 3 we can safely make use of higher RAM
frequency again. Make use of the EEPROM detection to determine the
revision and use the updated RAM timings for new SoMs.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
--
Changes in v2:
- Fix wrong RAM Timing values as pointed out by Yannic
---
 board/phytec/phycore_imx8mp/spl.c | 61 +++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/board/phytec/phycore_imx8mp/spl.c b/board/phytec/phycore_imx8mp/spl.c
index 49406f2eafad..d38f6368fe36 100644
--- a/board/phytec/phycore_imx8mp/spl.c
+++ b/board/phytec/phycore_imx8mp/spl.c
@@ -46,6 +46,67 @@ void spl_dram_init(void)
 	if (!ret)
 		phytec_print_som_info(NULL);
 
+	ret = phytec_get_rev(NULL);
+	if (ret >= 3 && ret != PHYTEC_EEPROM_INVAL) {
+		dram_timing.ddrc_cfg[3].val = 0x1323;
+		dram_timing.ddrc_cfg[4].val = 0x1e84800;
+		dram_timing.ddrc_cfg[5].val = 0x7a0118;
+		dram_timing.ddrc_cfg[8].val = 0xc00307a3;
+		dram_timing.ddrc_cfg[9].val = 0xc50000;
+		dram_timing.ddrc_cfg[10].val = 0xf4003f;
+		dram_timing.ddrc_cfg[11].val = 0xf30000;
+		dram_timing.ddrc_cfg[14].val = 0x2028222a;
+		dram_timing.ddrc_cfg[15].val = 0x8083f;
+		dram_timing.ddrc_cfg[16].val = 0xe0e000;
+		dram_timing.ddrc_cfg[17].val = 0x12040a12;
+		dram_timing.ddrc_cfg[18].val = 0x2050f0f;
+		dram_timing.ddrc_cfg[19].val = 0x1010009;
+		dram_timing.ddrc_cfg[20].val = 0x502;
+		dram_timing.ddrc_cfg[21].val = 0x20800;
+		dram_timing.ddrc_cfg[22].val = 0xe100002;
+		dram_timing.ddrc_cfg[23].val = 0x120;
+		dram_timing.ddrc_cfg[24].val = 0xc80064;
+		dram_timing.ddrc_cfg[25].val = 0x3e8001e;
+		dram_timing.ddrc_cfg[26].val = 0x3207a12;
+		dram_timing.ddrc_cfg[28].val = 0x4a3820e;
+		dram_timing.ddrc_cfg[30].val = 0x230e;
+		dram_timing.ddrc_cfg[37].val = 0x799;
+		dram_timing.ddrc_cfg[38].val = 0x9141d1c;
+		dram_timing.ddrc_cfg[74].val = 0x302;
+		dram_timing.ddrc_cfg[83].val = 0x599;
+		dram_timing.ddrc_cfg[99].val = 0x302;
+		dram_timing.ddrc_cfg[108].val = 0x599;
+		dram_timing.ddrphy_cfg[66].val = 0x18;
+		dram_timing.ddrphy_cfg[75].val = 0x1e3;
+		dram_timing.ddrphy_cfg[77].val = 0x1e3;
+		dram_timing.ddrphy_cfg[79].val = 0x1e3;
+		dram_timing.ddrphy_cfg[145].val = 0x3e8;
+		dram_timing.fsp_msg[0].drate = 4000;
+		dram_timing.fsp_msg[0].fsp_cfg[1].val = 0xfa0;
+		dram_timing.fsp_msg[0].fsp_cfg[10].val = 0x3ff4;
+		dram_timing.fsp_msg[0].fsp_cfg[11].val = 0xf3;
+		dram_timing.fsp_msg[0].fsp_cfg[15].val = 0x3ff4;
+		dram_timing.fsp_msg[0].fsp_cfg[16].val = 0xf3;
+		dram_timing.fsp_msg[0].fsp_cfg[22].val = 0xf400;
+		dram_timing.fsp_msg[0].fsp_cfg[23].val = 0xf33f;
+		dram_timing.fsp_msg[0].fsp_cfg[28].val = 0xf400;
+		dram_timing.fsp_msg[0].fsp_cfg[29].val = 0xf33f;
+		dram_timing.fsp_msg[3].drate = 4000;
+		dram_timing.fsp_msg[3].fsp_cfg[1].val = 0xfa0;
+		dram_timing.fsp_msg[3].fsp_cfg[11].val = 0x3ff4;
+		dram_timing.fsp_msg[3].fsp_cfg[12].val = 0xf3;
+		dram_timing.fsp_msg[3].fsp_cfg[16].val = 0x3ff4;
+		dram_timing.fsp_msg[3].fsp_cfg[17].val = 0xf3;
+		dram_timing.fsp_msg[3].fsp_cfg[23].val = 0xf400;
+		dram_timing.fsp_msg[3].fsp_cfg[24].val = 0xf33f;
+		dram_timing.fsp_msg[3].fsp_cfg[29].val = 0xf400;
+		dram_timing.fsp_msg[3].fsp_cfg[30].val = 0xf33f;
+		dram_timing.ddrphy_pie[480].val = 0x465;
+		dram_timing.ddrphy_pie[481].val = 0xfa;
+		dram_timing.ddrphy_pie[482].val = 0x9c4;
+		dram_timing.fsp_table[0] = 4000;
+	}
+
 out:
 	ddr_init(&dram_timing);
 }
-- 
2.34.1

