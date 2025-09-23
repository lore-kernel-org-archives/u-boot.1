Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49525CAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 10:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A6AC833E9;
	Tue, 23 Sep 2025 12:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFEE78344E; Tue, 23 Sep 2025 12:27:39 +0200 (CEST)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::bc09])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD1C4833ED
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 12:27:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cWGQ13QtPzDf7;
 Tue, 23 Sep 2025 12:27:37 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cWGQ1067pzJt0; Tue, 23 Sep 2025 12:27:36 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 23 Sep 2025 12:27:21 +0200
Subject: [PATCH 2/3] mkimage: fit: do not ignore fdt_setprop return code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-mkimage-2-runs-data-size-v1-2-ef3fa57e9645@cherry.de>
References: <20250923-mkimage-2-runs-data-size-v1-0-ef3fa57e9645@cherry.de>
In-Reply-To: <20250923-mkimage-2-runs-data-size-v1-0-ef3fa57e9645@cherry.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lars Feyaerts <lars@bitbiz.be>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

All explicit calls to fdt_setprop* in tools/ are checked except those
three. Let's add a check for the return code of fdt_setprop_u32() calls.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 tools/fit_image.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index 88a9060256a1acc0f33c084fb6fad241d160b0fa..41c386bdc9c8e01a66ee8f62e0e7116e47a68bd8 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -610,13 +610,25 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
 		}
 		if (params->external_offset > 0) {
 			/* An external offset positions the data absolutely. */
-			fdt_setprop_u32(fdt, node, FIT_DATA_POSITION_PROP,
-					params->external_offset + buf_ptr);
+			ret = fdt_setprop_u32(fdt, node, FIT_DATA_POSITION_PROP,
+					      params->external_offset + buf_ptr);
 		} else {
-			fdt_setprop_u32(fdt, node, FIT_DATA_OFFSET_PROP,
-					buf_ptr);
+			ret = fdt_setprop_u32(fdt, node, FIT_DATA_OFFSET_PROP,
+					      buf_ptr);
 		}
-		fdt_setprop_u32(fdt, node, FIT_DATA_SIZE_PROP, len);
+
+		if (ret) {
+			ret = -EINVAL;
+			goto err_munmap;
+		}
+
+		ret = fdt_setprop_u32(fdt, node, FIT_DATA_SIZE_PROP, len);
+
+		if (ret) {
+			ret = -EINVAL;
+			goto err_munmap;
+		}
+
 		buf_ptr += ALIGN(len, align_size);
 	}
 

-- 
2.51.0

