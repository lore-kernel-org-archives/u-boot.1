Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A14CAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 10:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8B9F80C93;
	Tue, 23 Sep 2025 12:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B94C583443; Tue, 23 Sep 2025 12:27:41 +0200 (CEST)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [84.16.66.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5962B800B6
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 12:27:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cWGQ10BvkzDf6;
 Tue, 23 Sep 2025 12:27:37 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cWGQ046L2zJsy; Tue, 23 Sep 2025 12:27:36 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 23 Sep 2025 12:27:20 +0200
Subject: [PATCH 1/3] mkimage: fit: do not overwrite fdt_setprop return
 value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-mkimage-2-runs-data-size-v1-1-ef3fa57e9645@cherry.de>
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

The return code of fdt_setprop is overwritten by the one from
fdt_delprop meaning we could very well have an issue when setting the
property that would be ignored if the deletion of the property that
comes right after passes.

Let's add a separate check for each.

Fixes: 4860ee9b09e0 ("mkimage: allow internalization of data-position")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 tools/fit_image.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index 331be5ae71d94691c7f6aa77547746409cfc074e..88a9060256a1acc0f33c084fb6fad241d160b0fa 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -745,14 +745,20 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 		debug("Importing data size %x\n", len);
 
 		ret = fdt_setprop(fdt, node, FIT_DATA_PROP, data, len);
-		ret = fdt_delprop(fdt, node, ext_data_prop);
-
 		if (ret) {
 			debug("%s: Failed to write property: %s\n", __func__,
 			      fdt_strerror(ret));
 			ret = -EINVAL;
 			goto err_munmap;
 		}
+
+		ret = fdt_delprop(fdt, node, ext_data_prop);
+		if (ret) {
+			debug("%s: Failed to erase property: %s\n", __func__,
+			      fdt_strerror(ret));
+			ret = -EINVAL;
+			goto err_munmap;
+		}
 	}
 
 	confs = fdt_path_offset(fdt, FIT_CONFS_PATH);

-- 
2.51.0

