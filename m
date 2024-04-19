Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737C1C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8DC488782;
	Fri, 19 Apr 2024 18:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Y8crzEqh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 060F3886D9; Fri, 19 Apr 2024 17:55:56 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17806886DA
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 17:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1713542153; x=1716134153;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=woPLXzSDZjoP/iDLbE/qCjYZhmDxF5OqPJw5Xpmflco=;
 b=Y8crzEqhLAQpmOZxUnC2bBp9zlFZVAWrKrotKkQ1zbBf2eOri9dKIS3IN+cbqEgV
 uJVFbODCKbjai62HOQbPfjEhelXs4nzuQ8LOOMewx7JFQbKDOQdvCSpoOk26Jz2B
 fUiNBIyHF1u5ocshjW6oTRhJn2TWcANwO4UHy7KF7QM=;
X-AuditID: ac14000a-fbefe7000000290d-6e-662294098a47
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 0C.38.10509.90492266;
 Fri, 19 Apr 2024 17:55:53 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 19 Apr
 2024 17:55:52 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>
CC: Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 1/5] board: phytec: common: Generic "add extension" function
Date: Fri, 19 Apr 2024 08:55:36 -0700
Message-ID: <20240419155540.2447006-2-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240419155540.2447006-1-d.schultz@phytec.de>
References: <20240419155540.2447006-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWyRpKBR5dzilKawfQPlhZv93ayOzB6nL2z
 gzGAMYrLJiU1J7MstUjfLoEr4+zea8wFb8UqJr47zNLAeES4i5GTQ0LAROLNlctMXYxcHEIC
 S5gknr9fzwzh3GeU+H55DTtIFZuAlsSdLXOZQWwRASmJl50bgWwODmYBDYn2Z0wgYWEBH4m1
 HetYQGwWAVWJjf3dYOW8AlYS3ftOsUEsk5eYeek72EhOAWuJ79u/gNUIAdWcX3yeDaJeUOLk
 zCdgc5iB6pu3zmaGsCUkDr54AVWvIDF722RGmJnTzr1mhrBDJY5sWs00gVFoFpJRs5CMmoVk
 1AJG5lWMQrmZydmpRZnZegUZlSWpyXopqZsYQcEqwsC1g7FvjschRiYOxkOMEhzMSiK8ZhyK
 aUK8KYmVValF+fFFpTmpxYcYpTlYlMR5V3cEpwoJpCeWpGanphakFsFkmTg4pRoYlVNCJ9t6
 LSx8Wl/2LyvLSaPINfBeSsDswtX5YtbrCic+OTHn3M2Yhlb/sxulWHXY+vuYrOWln155wpBb
 45ezODjY/8C7ZxMdJF/tSbtS7WrO/EVoyekcozVXZ8unxShEJytEOH2POjzDqElmQ4Tsx3+5
 t7h1bunPiu9TZL8peiL2mXt1qrsSS3FGoqEWc1FxIgBh7ByYRAIAAA==
X-Mailman-Approved-At: Fri, 19 Apr 2024 18:22:18 +0200
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

Add a generic function to apply overlays in our board code to not
implement the same logic in different PHYTEC products.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/common/phytec_som_detection.c | 33 ++++++++++++++++++++++
 board/phytec/common/phytec_som_detection.h |  5 ++++
 2 files changed, 38 insertions(+)

diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index a56e0f60d62..d167a77c25b 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -9,6 +9,8 @@
 #include <dm/uclass.h>
 #include <i2c.h>
 #include <u-boot/crc.h>
+#include <malloc.h>
+#include <extension_board.h>
 
 #include "phytec_som_detection.h"
 
@@ -213,6 +215,28 @@ u8 __maybe_unused phytec_get_som_type(struct phytec_eeprom_data *data)
 	return data->data.data_api2.som_type;
 }
 
+#if IS_ENABLED(CONFIG_CMD_EXTENSION)
+struct extension *phytec_add_extension(const char *name, const char *overlay,
+				       const char *other)
+{
+	struct extension *extension;
+
+	if (strlen(overlay) > sizeof(extension->overlay)) {
+		pr_err("Overlay name %s is longer than %lu.\n", overlay,
+		       sizeof(extension->overlay));
+		return NULL;
+	}
+
+	extension = calloc(1, sizeof(struct extension));
+	snprintf(extension->name, sizeof(extension->name), name);
+	snprintf(extension->overlay, sizeof(extension->overlay), overlay);
+	snprintf(extension->other, sizeof(extension->other), other);
+	snprintf(extension->owner, sizeof(extension->owner), "PHYTEC");
+
+	return extension;
+}
+#endif /* IS_ENABLED(CONFIG_CMD_EXTENSION) */
+
 #else
 
 inline int phytec_eeprom_data_setup(struct phytec_eeprom_data *data,
@@ -253,4 +277,13 @@ u8 __maybe_unused phytec_get_som_type(struct phytec_eeprom_data *data)
 	return PHYTEC_EEPROM_INVAL;
 }
 
+#if IS_ENABLED(CONFIG_CMD_EXTENSION)
+inline struct extension *phytec_add_extension(const char *name,
+					      const char *overlay,
+					      const char *other)
+{
+	return NULL;
+}
+#endif /* IS_ENABLED(CONFIG_CMD_EXTENSION) */
+
 #endif /* IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION) */
diff --git a/board/phytec/common/phytec_som_detection.h b/board/phytec/common/phytec_som_detection.h
index 7edbfa3ca5c..ea99a687fee 100644
--- a/board/phytec/common/phytec_som_detection.h
+++ b/board/phytec/common/phytec_som_detection.h
@@ -76,4 +76,9 @@ char * __maybe_unused phytec_get_opt(struct phytec_eeprom_data *data);
 u8 __maybe_unused phytec_get_rev(struct phytec_eeprom_data *data);
 u8 __maybe_unused phytec_get_som_type(struct phytec_eeprom_data *data);
 
+#if IS_ENABLED(CONFIG_CMD_EXTENSION)
+struct extension *phytec_add_extension(const char *name, const char *overlay,
+				       const char *other);
+#endif /* IS_ENABLED(CONFIG_CMD_EXTENSION) */
+
 #endif /* _PHYTEC_SOM_DETECTION_H */
-- 
2.25.1

