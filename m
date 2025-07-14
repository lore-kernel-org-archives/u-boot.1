Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89611C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 17:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0165B830C8;
	Mon, 14 Jul 2025 19:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ED43830C0; Mon, 14 Jul 2025 19:23:12 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E281830B3
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 19:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1ubMtP-008k39-FW;
 Mon, 14 Jul 2025 17:23:07 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 4/4] venice: display DRAM MR registers and decoding if
 debug enabled
Date: Mon, 14 Jul 2025 10:23:04 -0700
Message-Id: <20250714172304.4095241-4-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250714172304.4095241-1-tharvey@gateworks.com>
References: <20250714172304.4095241-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

While this is interesting and useful for debugging there isn't extremely
useful information so we will only show it if debug is enabled.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2: remove accidental define of DEBUG
---
 board/gateworks/venice/spl.c | 60 +++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/board/gateworks/venice/spl.c b/board/gateworks/venice/spl.c
index d9bc593fa0d5..2c303211d328 100644
--- a/board/gateworks/venice/spl.c
+++ b/board/gateworks/venice/spl.c
@@ -271,7 +271,65 @@ void board_init_f(ulong dummy)
 		       dram_timing->fsp_msg[0].drate,
 		       dram_timing->fsp_msg[0].drate / 2,
 		       dram_desc[0] ? dram_desc : "");
-		puts("\n");
+
+#ifdef DEBUG
+		u8 mr[9] = { 0 };
+		/* Read MR5-MR8 to obtain details about DRAM part (and verify DRAM working) */
+		for (i = 5; i < 9; i++)
+			mr[i] = lpddr4_mr_read(0xf, i) & 0xff;
+
+		printf(" (0x%02x%02x%02x%02x", mr[5], mr[6], mr[7], mr[8]);
+		/* MR5 MFG_ID */
+		switch (mr[5]) {
+		case 0xff:
+			printf(" Micron");
+			break;
+		default:
+			break;
+		}
+		/* MR8 OP[7:6] Width */
+		i = 0;
+		switch ((mr[8] >> 6) & 0x3) {
+		case 0:
+			i = 16;
+			break;
+		case 1:
+			i = 8;
+			break;
+		}
+		if (i)
+			printf(" x%d", i);
+		/* MR8 OP[5:2] Density */
+		i = 0;
+		switch ((mr[8] >> 2) & 0xf) {
+		case 0:
+			i = 4;
+			break;
+		case 1:
+			i = 6;
+			break;
+		case 2:
+			i = 8;
+			break;
+		case 3:
+			i = 12;
+			break;
+		case 4:
+			i = 16;
+			break;
+		case 5:
+			i = 24;
+			break;
+		case 6:
+			i = 32;
+			break;
+		default:
+			break;
+		}
+		if (i)
+			printf(" %dGb per die", i);
+#endif
+		puts(")\n");
 	} else {
 		hang();
 	}
-- 
2.25.1

