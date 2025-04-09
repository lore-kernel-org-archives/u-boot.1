Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C761C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 15:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B8C88387E;
	Wed,  9 Apr 2025 17:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3AF18388A; Wed,  9 Apr 2025 17:10:48 +0200 (CEST)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::8fa8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFE558386F
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 17:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZXmbj4JyLz89b;
 Wed,  9 Apr 2025 17:10:41 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4ZXmbj1Xf6z3dG; Wed,  9 Apr 2025 17:10:41 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 09 Apr 2025 17:10:25 +0200
Subject: [PATCH RFC 1/4] boot/fit: use constants for property strings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-fit-compat-v1-1-56df89ef486a@cherry.de>
References: <20250409-fit-compat-v1-0-56df89ef486a@cherry.de>
In-Reply-To: <20250409-fit-compat-v1-0-56df89ef486a@cherry.de>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>, 
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
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

Some properties have their string represented in include/image.h via
constants, so let's use those constants instead of using a hardcoded
string.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 boot/common_fit.c | 4 ++--
 boot/image-fit.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/boot/common_fit.c b/boot/common_fit.c
index a2f9b8d83c3b66a39ae0e172445d162f5146578a..fd434fe28e1908596365c9d31892a73ec97c36e3 100644
--- a/boot/common_fit.c
+++ b/boot/common_fit.c
@@ -46,12 +46,12 @@ int fit_find_config_node(const void *fdt)
 		return -EINVAL;
 	}
 
-	dflt_conf_name = fdt_getprop(fdt, conf, "default", &len);
+	dflt_conf_name = fdt_getprop(fdt, conf, FIT_DEFAULT_PROP, &len);
 
 	for (node = fdt_first_subnode(fdt, conf);
 	     node >= 0;
 	     node = fdt_next_subnode(fdt, node)) {
-		name = fdt_getprop(fdt, node, "description", &len);
+		name = fdt_getprop(fdt, node, FIT_DESC_PROP, &len);
 		if (!name) {
 #ifdef CONFIG_SPL_LIBCOMMON_SUPPORT
 			printf("%s: Missing FDT description in DTB\n",
diff --git a/boot/image-fit.c b/boot/image-fit.c
index 41ab1f552b04d6a5731625ce8c03e17730f8d0cd..7c822a39fd85554a716d9cada54cbaf91b3ec24a 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1760,7 +1760,7 @@ int fit_conf_find_compat(const void *fit, const void *fdt)
 			fdt = fit;		  /* search in FIT image */
 			compat_noffset = noffset; /* search under config node */
 		} else {	/* Otherwise extract it from the kernel FDT. */
-			kfdt_name = fdt_getprop(fit, noffset, "fdt", &len);
+			kfdt_name = fdt_getprop(fit, noffset, FIT_FDT_PROP, &len);
 			if (!kfdt_name) {
 				debug("No fdt property found.\n");
 				continue;

-- 
2.49.0

