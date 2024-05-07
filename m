Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB954C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 15:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AA1C8879B;
	Tue,  7 May 2024 17:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="T+6kRBsx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED92F8879B; Tue,  7 May 2024 17:18:09 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CED5F88662
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 17:18:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1715095086; x=1717687086;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CPxHbTB2PWMoiw2v1zUBzll/Jy3U42rVt9WnQTGtnW0=;
 b=T+6kRBsxKMEDlgNleEiJMj0m5V8VOFVVKF/dVFwpkzkxrbLjz1Iyz+FxSow6pj+w
 RANzF2sICATTgx1hBlENsoa1WQ6CfdVaAme/2Y4YIZDgGRjlzv25x7MmWE9zthZ9
 JMs5TDfqUzEMaIs305UM/Qjnc+5t+3zwiwqHW729WYM=;
X-AuditID: ac14000a-fbefe7000000290d-9e-663a462e5231
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 77.49.10509.E264A366;
 Tue,  7 May 2024 17:18:06 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 7 May 2024
 17:18:05 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <nm@ti.com>, <bb@ti.com>, <y.moog@phytec.de>,
 <t.remmet@phytec.de>, <d.schultz@phytec.de>, <festevam@gmail.com>,
 <mkorpershoek@baylibre.com>, <joao.goncalves@toradex.com>, <n-jain1@ti.com>,
 <michael@amarulasolutions.com>, <d-gole@ti.com>, <sjg@chromium.org>,
 <clamor95@gmail.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <jma@phytec.com>
Subject: [PATCH 2/5] board: phytec: Fix function definitions in AM6x SOM
 detection
Date: Tue, 7 May 2024 17:17:54 +0200
Message-ID: <20240507151757.1202825-3-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507151757.1202825-1-w.egorov@phytec.de>
References: <20240507151757.1202825-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWyRpKBR1fPzSrNYPs3QYv3pyayW8x9c4DV
 4kB/L6NFy1oPi4dX/S2edTYxW1y+f5PV4tKDVItTja0sFi+OzWW36P//nMnizY+zTBbftmxj
 tJg6aTO7xdu9newW3e/UHQQ81n68z+rx/kYru8fshossHjtn3WX3eHVgFbvH2Ts7GD36u1tY
 Pf5cfMfqcfzGdiaPTa88AriiuGxSUnMyy1KL9O0SuDIari1hL5goWTHtyUyWBsaVol2MHBwS
 AiYSTSejuxi5OIQEljBJXDu/mwXCecQocej4McYuRk4ONgF1iTsbvrGC2CICZhKL1p5nAyli
 FnjHJLH+8BQ2kISwQJDEpo0r2EFsFgEViQ+3foPFeQUsJe5Ov8MMYksIyEvMvPQdrIZTwEpi
 yoo3YAuEgGqeH//MDFEvKHFy5hMWEJsZqL5562xmCFtC4uCLF8wQ9fISLy4tZ4GZOe3ca6j5
 oRJHNq1mmsAoNAvJqFlIRs1CMmoBI/MqRqHczOTs1KLMbL2CjMqS1GS9lNRNjKCoFGHg2sHY
 N8fjECMTB+MhRgkOZiUR3qPt5mlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVd3BKcKCaQnlqRm
 p6YWpBbBZJk4OKUaGBUcjzvf3rA3YcNq8ZSzSwN2pDUvrZ70xdVUTZK7pjpKYNtCPxlR8b6X
 rOGq8Qp/yvU3h8cVZ3GvFV0byLjh083UjyL7Fi1p+3Bc7v02pbeCWhUb/3DJyrvn/TDsaHLM
 +n3gYOR/Q6NAD707bhXByw6HaJu+nx8Rx8RmVxezX6XZcrf7+V4jJZbijERDLeai4kQAIuBu
 pLgCAAA=
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

Functions are declared as phytec_am6* and not phytec_am62*.
Update the definitions to match the declarations.

Fixes: 9d152c23279c ("board: phytec: Add SOM detection for AM6x")

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/common/am6_som_detection.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/board/phytec/common/am6_som_detection.c b/board/phytec/common/am6_som_detection.c
index 2e9884dab44..7930ab42d1c 100644
--- a/board/phytec/common/am6_som_detection.c
+++ b/board/phytec/common/am6_som_detection.c
@@ -73,7 +73,7 @@ static u8 phytec_check_opt(struct phytec_eeprom_data *data, u8 option)
  *  - The size
  *  - PHYTEC_EEPROM_INVAL when the data is invalid.
  */
-u8 __maybe_unused phytec_get_am62_ddr_size(struct phytec_eeprom_data *data)
+u8 __maybe_unused phytec_get_am6_ddr_size(struct phytec_eeprom_data *data)
 {
 	u8 ddr_id = phytec_check_opt(data, 3);
 
@@ -89,7 +89,7 @@ u8 __maybe_unused phytec_get_am62_ddr_size(struct phytec_eeprom_data *data)
  *  - Otherwise a board depended code for the size.
  *  - PHYTEC_EEPROM_INVAL when the data is invalid.
  */
-u8 __maybe_unused phytec_get_am62_spi(struct phytec_eeprom_data *data)
+u8 __maybe_unused phytec_get_am6_spi(struct phytec_eeprom_data *data)
 {
 	u8 spi = phytec_check_opt(data, 5);
 
@@ -105,7 +105,7 @@ u8 __maybe_unused phytec_get_am62_spi(struct phytec_eeprom_data *data)
  *  - 0x1 if 10/100/1000 MBit Phy is populated.
  *  - PHYTEC_EEPROM_INVAL when the data is invalid.
  */
-u8 __maybe_unused phytec_get_am62_eth(struct phytec_eeprom_data *data)
+u8 __maybe_unused phytec_get_am6_eth(struct phytec_eeprom_data *data)
 {
 	u8 eth = phytec_check_opt(data, 6);
 
@@ -121,7 +121,7 @@ u8 __maybe_unused phytec_get_am62_eth(struct phytec_eeprom_data *data)
  *  - 1 if it is populated.
  *  - PHYTEC_EEPROM_INVAL when the data is invalid.
  */
-u8 __maybe_unused phytec_get_am62_rtc(struct phytec_eeprom_data *data)
+u8 __maybe_unused phytec_get_am6_rtc(struct phytec_eeprom_data *data)
 {
 	u8 rtc = phytec_check_opt(data, 7);
 
@@ -131,28 +131,28 @@ u8 __maybe_unused phytec_get_am62_rtc(struct phytec_eeprom_data *data)
 
 #else
 
-inline int __maybe_unused phytec_am62_detect(struct phytec_eeprom_data *data)
+inline int __maybe_unused phytec_am6_detect(struct phytec_eeprom_data *data)
 {
 	return -1;
 }
 
 inline u8 __maybe_unused
-phytec_get_am62_ddr_size(struct phytec_eeprom_data *data)
+phytec_get_am6_ddr_size(struct phytec_eeprom_data *data)
 {
 	return PHYTEC_EEPROM_INVAL;
 }
 
-inline u8 __maybe_unused phytec_get_am62_spi(struct phytec_eeprom_data *data)
+inline u8 __maybe_unused phytec_get_am6_spi(struct phytec_eeprom_data *data)
 {
 	return PHYTEC_EEPROM_INVAL;
 }
 
-inline u8 __maybe_unused phytec_get_am62_eth(struct phytec_eeprom_data *data)
+inline u8 __maybe_unused phytec_get_am6_eth(struct phytec_eeprom_data *data)
 {
 	return PHYTEC_EEPROM_INVAL;
 }
 
-inline u8 __maybe_unused phytec_get_am62_rtc(struct phytec_eeprom_data *data)
+inline u8 __maybe_unused phytec_get_am6_rtc(struct phytec_eeprom_data *data)
 {
 	return PHYTEC_EEPROM_INVAL;
 }
-- 
2.34.1

