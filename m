Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF16C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 17:46:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7B408340A;
	Fri, 23 May 2025 19:46:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90BB6833F9; Fri, 23 May 2025 19:46:01 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28D4183327
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 19:45:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1uIW4N-0076pt-U1;
 Fri, 23 May 2025 17:20:32 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de,
	Stefano Babic <sbabic@nabladev.com>
Cc: Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 12/13] board: venice: append configuration string to model
Date: Fri, 23 May 2025 10:20:17 -0700
Message-Id: <20250523172018.4164647-12-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523172018.4164647-1-tharvey@gateworks.com>
References: <20250523172018.4164647-1-tharvey@gateworks.com>
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

Append the optional board configuration string to the model info.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 board/gateworks/venice/eeprom.c | 9 +++++++++
 board/gateworks/venice/eeprom.h | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/board/gateworks/venice/eeprom.c b/board/gateworks/venice/eeprom.c
index 702ab392a047..d9a871934340 100644
--- a/board/gateworks/venice/eeprom.c
+++ b/board/gateworks/venice/eeprom.c
@@ -449,6 +449,15 @@ int venice_eeprom_init(int quiet)
 					venice_model[i++] = fsa_info.model[9];
 			}
 		}
+
+		/* append extra model info */
+		if (som_info.config[0] >= 32 && som_info.config[0] < 0x7f) {
+			venice_model[i++] = '-';
+			strlcpy(venice_model + i, som_info.config, (sizeof(venice_model) - i) - 1);
+			i += strlen(som_info.config);
+			if (i >= sizeof(venice_model))
+				i = sizeof(venice_model) - 1;
+		}
 		venice_model[i++] = 0;
 	}
 
diff --git a/board/gateworks/venice/eeprom.h b/board/gateworks/venice/eeprom.h
index 30cd347d9453..a0f449299aa3 100644
--- a/board/gateworks/venice/eeprom.h
+++ b/board/gateworks/venice/eeprom.h
@@ -20,7 +20,7 @@ struct venice_board_info {
 	u8 sdram_width;	/* 0x2D: (8 << n) bit */
 	u8 res3[2];	/* 0x2E */
 	char model[16];		/* 0x30: model string */
-	u8 res4[14];	/* 0x40 */
+	u8 config[14];	/* 0x40: model config */
 	u8 chksum[2];	/* 0x4E */
 };
 
-- 
2.25.1

