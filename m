Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CC7C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 13:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AC98885A3;
	Mon, 10 Jun 2024 15:34:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="cwSVKptT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D13D8852C; Mon, 10 Jun 2024 15:34:17 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B81A8855C
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:34:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1718026451; x=1720618451;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZxYb4nqJ/JGEjoQ+A18NrA/NKwpqV0iQnJJpAXa+lYw=;
 b=cwSVKptTcG8N3CCwbB7bhBHYmTrxLSZVm/iSb7+DgpZ/ds4Msksyz/lV8RVxQ3vQ
 pzfa/78d99GgYdxCBNnx7FAGvvvlIRBpWQGUIP8/1NcM6/jeKKWPwJKmyIrKBDOh
 4g2LCG1IfQiXaLjYhEkaxovfYjCEO+icKCh/G9nZ5rc=;
X-AuditID: ac14000a-03251700000021bc-f6-666700d30e99
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 4C.7D.08636.3D007666;
 Mon, 10 Jun 2024 15:34:11 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 10 Jun
 2024 15:34:11 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.phytec.de>, <upstream@lists.phytec.de>,
 <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <d.schultz@phytec.de>, <nmorrisson@phytec.com>
Subject: [PATCH 13/13] board: phytec: phycore-am62x: Use memory nodes in
 higher boot stages
Date: Mon, 10 Jun 2024 15:33:52 +0200
Message-ID: <20240610133352.2473414-14-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240610133352.2473414-1-w.egorov@phytec.de>
References: <20240610133352.2473414-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWyRpKBR/cyQ3qaQX+PvMWHxs1sFlMnbWa3
 eLu3k93iXd9+Jovud+oOrB6vDqxi9zh7ZwejR393C6vHn4vvWANYorhsUlJzMstSi/TtErgy
 jk+5wlzwlL/i6J3QBsapvF2MnBwSAiYS36a8Z+1i5OIQEljCJPF3/md2COcxo8SePcuZQKrY
 BNQl7mz4xgpiiwgESfRe+sQIYjMLeEhs/bsBLC4sEC1x6dFiFhCbRUBV4un3eUC9HBy8AlYS
 t1eHQCyTl5h56Ts7iM0JFP6xZi9Yq5CApcSiT2vAWnkFBCVOznzCAjFeXqJ562xmCFtC4uCL
 F8wQ9fISLy4tZ4GZOe3ca2YIO1Ri65ftTBMYhWYhGTULyahZSEYtYGRexSiUm5mcnVqUma1X
 kFFZkpqsl5K6iREU7iIMXDsY++Z4HGJk4mA8xCjBwawkwiuUkZwmxJuSWFmVWpQfX1Sak1p8
 iFGag0VJnHd1R3CqkEB6YklqdmpqQWoRTJaJg1OqgbHay+/WXBfnrsgf2T6zb+qUtbvcTYjd
 2b9mUsPKV07zsyIPf2VWDRSXc/jyx26yz+sefwOze0UGN39cyVFesle8Ms3E4d19tcLN9k8n
 snPZrRaJmq10IIpR+nfe7a1XbkwqqPOf75j6h+WXZnfu91335B/Pm/+58c2au07nd3Foa/zn
 lVMt6FBiKc5INNRiLipOBADGkirMZQIAAA==
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

There is no need to reread the EEPROM multiple times in different stages
to detect the RAM size. We can do this once at an early stage and let
higher stages decode memory nodes using fdtdec.
Make sure to pass fixup memory nodes before passing to u-boot stage.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_am62x/phycore-am62x.c | 30 +++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/board/phytec/phycore_am62x/phycore-am62x.c b/board/phytec/phycore_am62x/phycore-am62x.c
index 35e1bb96b8d..9f6bc736cbb 100644
--- a/board/phytec/phycore_am62x/phycore-am62x.c
+++ b/board/phytec/phycore_am62x/phycore-am62x.c
@@ -47,7 +47,12 @@ static u8 phytec_get_am62_ddr_size_default(void)
 
 int dram_init(void)
 {
-	u8 ram_size = phytec_get_am62_ddr_size_default();
+	u8 ram_size;
+
+	if (!IS_ENABLED(CONFIG_CPU_V7R))
+		return fdtdec_setup_mem_size_base();
+
+	ram_size = phytec_get_am62_ddr_size_default();
 
 	/*
 	 * HACK: ddrss driver support 2GB RAM by default
@@ -92,6 +97,9 @@ int dram_init_banksize(void)
 {
 	u8 ram_size;
 
+	if (!IS_ENABLED(CONFIG_CPU_V7R))
+		return fdtdec_setup_memory_banksize();
+
 	ram_size = phytec_get_am62_ddr_size_default();
 	switch (ram_size) {
 	case EEPROM_RAM_SIZE_1GB:
@@ -174,6 +182,26 @@ int do_board_detect(void)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+void spl_perform_fixups(struct spl_image_info *spl_image)
+{
+	u64 start[CONFIG_NR_DRAM_BANKS];
+	u64 size[CONFIG_NR_DRAM_BANKS];
+	int bank;
+	int ret;
+
+	dram_init();
+	dram_init_banksize();
+
+	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
+		start[bank] = gd->bd->bi_dram[bank].start;
+		size[bank] = gd->bd->bi_dram[bank].size;
+	}
+
+	ret = fdt_fixup_memory_banks(spl_image->fdt_addr, start, size, CONFIG_NR_DRAM_BANKS);
+}
+#endif
+
 #define CTRLMMR_USB0_PHY_CTRL   0x43004008
 #define CTRLMMR_USB1_PHY_CTRL   0x43004018
 #define CORE_VOLTAGE            0x80000000
-- 
2.34.1

