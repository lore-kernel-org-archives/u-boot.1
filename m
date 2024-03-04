Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D8BC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 12:31:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EEC787FA3;
	Mon,  4 Mar 2024 13:31:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="kVDWFdYU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C1D987F8B; Mon,  4 Mar 2024 13:31:05 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9EE187F97
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 13:31:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1709555460; x=1712147460;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AMo5SyEXxPfRMypYYH8XzbzshnvDBHxNqxnTRJrWnE0=;
 b=kVDWFdYUQNmQNbLngrV3BdfZ6Ir7wvksFaVdu0FByieTZ6n6wSvMQCsZXr3dpWQi
 kC964bJCvebOZuIjDKhSd+hsoqQHR62krxHQulJvBVYCTV2G1JGu6/3cXn6Y7k7v
 wZeAAMhu1HnE/ZKsZv3Yzf6Dww7MdbA/VaAjxicDhyI=;
X-AuditID: ac14000a-fadff7000000290d-37-65e5bf043816
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 95.36.10509.40FB5E56;
 Mon,  4 Mar 2024 13:31:00 +0100 (CET)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 4 Mar 2024
 13:31:00 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Mon, 4 Mar 2024 13:30:48 +0100
Subject: [PATCH 2/2] board: phycore_imx8mp: Use 2GHz RAM timings for
 PCL-070 from pcb_rev 1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240304-pcl-070-patches-v1-2-6aa6c89e3b81@phytec.de>
References: <20240304-pcl-070-patches-v1-0-6aa6c89e3b81@phytec.de>
In-Reply-To: <20240304-pcl-070-patches-v1-0-6aa6c89e3b81@phytec.de>
To: Tom Rini <trini@konsulko.com>, Teresa Remmet <t.remmet@phytec.de>, Fabio
 Estevam <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709555459; l=1011;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=AMo5SyEXxPfRMypYYH8XzbzshnvDBHxNqxnTRJrWnE0=;
 b=peP+kViI23qUwihcc42fhjfqP3z8ZUWnqwme4NLPpJubT3PA+YPYMCqIcVeOEVPt4yiOKWyW9
 XE2Y+h6cXcxAFHEPHkHSFu0DsqrNY/GG/7sNpV70LCc+EKorH6Fj2v+
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWyRpKBR5dl/9NUg/Xb1SweXvW3mDppM7vF
 272d7Bbd79QdWDx2zrrL7vHqwCp2j7N3djB69He3sAawRHHZpKTmZJalFunbJXBlXH7NX/CV
 vWLX701sDYwn2LoYOTgkBEwkpv+X7GLk4hASWMwkcXjhRUYI5wGjxJvPx1m6GDk52ATUJHa9
 ec0K0sAioCJx/p8uiCksECsxeYMQSAWvgKDEyZlPWEDCzAKaEut36YOEmQXkJba/ncMMUeIk
 0bDiKViJEJA97ZUoiMkp4CzxfVcQSIWIQLbEs84t7BBDoiTeTQyCOFFYYtNOLZCrJAR2M0lM
 brjMDhFPlNj5Wg6kU0hAVuLm+S1sILYE0M5p514zQ9ihEkc2rWaawCgyC8mVsxCunIXkygWM
 zKsYhXIzk7NTizKz9QoyKktSk/VSUjcxgmJAhIFrB2PfHI9DjEwcjIcYJTiYlUR4a349SRXi
 TUmsrEotyo8vKs1JLT7EKM3BoiTOu7ojOFVIID2xJDU7NbUgtQgmy8TBKdXAmKZlJz8ho8gt
 aZ5qbHPiXNvnJWdLfFYV7ttxSqWj4hWz7d/6zcdv28UfznQvemEa9ctX32retw8GnyQ2VO4t
 Uz+8/LkL9wePmb+PPHwvLnFP7diSVZMfr1wZvDS+Z9PEq1/trxp5eptr1j68/1L25yQ3W+2W
 fR+iQqTUysO2W8YKrc9NPR5+R4mlOCPRUIu5qDgRACW9//dvAgAA
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

We need to differ between PCL-070 and PCM-070. PCL-070 supports 2GHz RAM
timings from pcb rev 1 or newer. PCM-070 supports 2GHz RAM timings from
pcb rev 3 or newer.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 board/phytec/phycore_imx8mp/spl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/board/phytec/phycore_imx8mp/spl.c b/board/phytec/phycore_imx8mp/spl.c
index d38f6368fe36..15a8c75e9982 100644
--- a/board/phytec/phycore_imx8mp/spl.c
+++ b/board/phytec/phycore_imx8mp/spl.c
@@ -46,8 +46,10 @@ void spl_dram_init(void)
 	if (!ret)
 		phytec_print_som_info(NULL);
 
-	ret = phytec_get_rev(NULL);
-	if (ret >= 3 && ret != PHYTEC_EEPROM_INVAL) {
+	u8 rev = phytec_get_rev(NULL);
+	u8 somtyp = phytec_get_som_type(NULL);
+
+	if (rev != PHYTEC_EEPROM_INVAL && (rev >= 3 || (somtyp == PCL && rev >= 1))) {
 		dram_timing.ddrc_cfg[3].val = 0x1323;
 		dram_timing.ddrc_cfg[4].val = 0x1e84800;
 		dram_timing.ddrc_cfg[5].val = 0x7a0118;

-- 
2.34.1

