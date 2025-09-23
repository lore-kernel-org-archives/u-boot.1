Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D99FCAC5B0
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 10:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DC9A834E1;
	Tue, 23 Sep 2025 12:27:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAD2880C93; Tue, 23 Sep 2025 12:27:41 +0200 (CEST)
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch
 [185.125.25.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4663F83445
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 12:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cWGQ16ym4zBfD;
 Tue, 23 Sep 2025 12:27:37 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cWGQ13tNGzFgY; Tue, 23 Sep 2025 12:27:37 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 23 Sep 2025 12:27:22 +0200
Subject: [PATCH 3/3] mkimage: fit: erase data-size property when importing data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-mkimage-2-runs-data-size-v1-3-ef3fa57e9645@cherry.de>
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

When importing data, the data-offset property is removed and the data
content is imported inside the data property of the node.

When mkimage is run twice on the same FIT, data-size property is already
set in the second run, from the first run (via the fit_export_data
function). If we don't remove the data-size property, nothing guarantees
it matches the actual size of data within the data property. To avoid
possible mistakes when handling the data property, let's simply remove
the data-size property as well.

This also fixes an ordering issue of the data-size and data-offset
properties in FIT when comparing the FIT after one run of mkimage and a
second run. This is due to fit_export_data setting data-offset property
first (it doesn't exist so it's added) and then data-size (it doesn't
exist so it's added) for the first run, while it sets data-offset
property first (removed in fit_import_data, so it doesn't exist so it's
added) and then data-size (it exists already from the first run, so it's
simply modified) for the second run.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 tools/fit_image.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index 41c386bdc9c8e01a66ee8f62e0e7116e47a68bd8..feb0cfeeeebd2de9581f39e8f784a63105f5091b 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -771,6 +771,14 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 			ret = -EINVAL;
 			goto err_munmap;
 		}
+
+		ret = fdt_delprop(fdt, node, FIT_DATA_SIZE_PROP);
+		if (ret) {
+			debug("%s: Failed to erase %s property: %s\n", __func__,
+			      FIT_DATA_SIZE_PROP, fdt_strerror(ret));
+			ret = -EINVAL;
+			goto err_munmap;
+		}
 	}
 
 	confs = fdt_path_offset(fdt, FIT_CONFS_PATH);

-- 
2.51.0

