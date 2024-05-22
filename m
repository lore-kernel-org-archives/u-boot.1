Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BE4C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 14:52:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A30288870;
	Wed, 22 May 2024 16:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="oIip9KYI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7769C887D9; Wed, 22 May 2024 08:18:51 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EABB87F4B
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 08:18:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716358729; x=1718950729;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RjUlBGr7fziLB92kOSpHEHTLBuzmwP/ycroGxwOQL+U=;
 b=oIip9KYIydzFlGSMzHiKbUB4GHKz8HUIQhfdwmJppQlITayqVyAfL45xoCx5Zz77
 /zLVpJwzC4QPadnG++dbGsXBdRYR5It40y9MwhT1b5/3lI8UKvSGw1NtrOefS6R2
 Kc9MdclfYsQIoGOcc67H9XYzYSEwfxTt+P4L79k9+Xw=;
X-AuditID: ac14000a-03e52700000021bc-6c-664d8e49be40
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id F4.10.08636.94E8D466;
 Wed, 22 May 2024 08:18:49 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 22 May
 2024 08:18:48 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 5/6] board: phytec: common: k3: Set MAC
Date: Tue, 21 May 2024 23:18:26 -0700
Message-ID: <20240522061827.601699-6-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522061827.601699-1-d.schultz@phytec.de>
References: <20240522061827.601699-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsWyRpKBR9ezzzfNYP5UVYu3ezvZLbrfqTsw
 eZy9s4PRo7+7hTWAKYrLJiU1J7MstUjfLoErY92kxYwFR7gqXlzcw97AeI6ji5GDQ0LAROLY
 sYguRi4OIYElTBK/L35gh3DuM0p8nPGStYuRk4NNQEvizpa5zCC2iICZxKK159lAmpkFNCTa
 nzGBhIUFzCVarh4FK2cRUJXoaX/JDlLCK2Ap8fxOFEhYQkBeYual7+wgNqeAlcTt2esZQWwh
 oJKvr/+BxXkFBCVOznzCAmIzA9U3b53NDGFLSBx88YIZol5BYva2yYwwM6ede80MYYdKbP2y
 nWkCo9AsJKNmIRk1C8moBYzMqxiFcjOTs1OLMrP1CjIqS1KT9VJSNzGCQleEgWsHY98cj0OM
 TByMhxglOJiVRHg3bfFME+JNSaysSi3Kjy8qzUktPsQozcGiJM67uiM4VUggPbEkNTs1tSC1
 CCbLxMEp1cAYNn/ayfp4XRtt/a9suwzqhfQ3W4nXunfsXXnQx3bCmd2Fb7asa+7X3iT7ZvnE
 D6cunnPPUDnEtzJ7YlRg4aziC6kPxNKubHRa6ryx6mIe77FLmV7XYnh1b8/NWHqv5PGaB2fY
 lV3V9vJUHfmeEOWrqSOwILn5d7L6LmVrwY1xW/Z5WrPFubMosRRnJBpqMRcVJwIASTg6HUsC
 AAA=
X-Mailman-Approved-At: Wed, 22 May 2024 16:50:43 +0200
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

Read the EEPROM API v3 content and set all available
MAC-Addresses to the environment.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/common/k3/board.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
index 9cb168c36cb..f21e154d4fe 100644
--- a/board/phytec/common/k3/board.c
+++ b/board/phytec/common/k3/board.c
@@ -8,6 +8,8 @@
 #include <spl.h>
 #include <asm/arch/hardware.h>
 
+#include "../am6_som_detection.h"
+
 #if IS_ENABLED(CONFIG_ENV_IS_IN_FAT) || IS_ENABLED(CONFIG_ENV_IS_IN_MMC)
 int mmc_get_env_dev(void)
 {
@@ -68,6 +70,27 @@ int board_late_init(void)
 		break;
 	};
 
+	if (IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION_BLOCKS)) {
+		struct phytec_api3_element *block_element;
+		struct phytec_eeprom_data data;
+		int ret;
+
+		ret = phytec_eeprom_data_setup(&data, 0, EEPROM_ADDR);
+		if (ret || !data.valid)
+			return 0;
+
+		PHYTEC_API3_FOREACH_BLOCK(block_element, &data) {
+			switch (block_element->block_type) {
+			case PHYTEC_API3_BLOCK_MAC:
+				phytec_blocks_add_mac_to_env(block_element);
+				break;
+			default:
+				debug("%s: Unknown block type %i\n", __func__,
+				      block_element->block_type);
+			}
+		}
+	}
+
 	return 0;
 }
 #endif
-- 
2.25.1

