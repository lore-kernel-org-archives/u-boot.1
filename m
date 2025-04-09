Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0432BC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 15:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14CE38386F;
	Wed,  9 Apr 2025 17:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6C0683873; Wed,  9 Apr 2025 17:10:47 +0200 (CEST)
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch
 [84.16.66.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF41182A33
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 17:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZXmbk4h9qz7Sr;
 Wed,  9 Apr 2025 17:10:42 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4ZXmbk0zC5z3q3; Wed,  9 Apr 2025 17:10:42 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 09 Apr 2025 17:10:27 +0200
Subject: [PATCH RFC 3/4] boot/fit: declare (and use) new constant for
 conf's compatible prop
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-fit-compat-v1-3-56df89ef486a@cherry.de>
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

Fit conf node may have a compatible property[1] which stores the root
compatible of the first blob in the fdt property of the node. This can
be used to automatically select the proper conf node based on the
compatible from the running U-Boot (matching the former's compatible
with the latter)[2].

This adds (and uses) this constant for FIT node parsing.

Note that this property may also appear in fpga image nodes[3] but that
isn't done in this commit.

[1] https://fitspec.osfw.foundation/#optional-properties compatible paragraph
[2] https://fitspec.osfw.foundation/#select-a-configuration-to-boot
[3] https://fitspec.osfw.foundation/#images-node 2.3.2 Conditionally mandatory property
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 boot/image-fit.c | 2 +-
 include/image.h  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 7c822a39fd85554a716d9cada54cbaf91b3ec24a..52dbd7e96180da306da7f1516e8a3ab18a51ea33 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1756,7 +1756,7 @@ int fit_conf_find_compat(const void *fit, const void *fdt)
 			continue;
 
 		/* If there's a compat property in the config node, use that. */
-		if (fdt_getprop(fit, noffset, "compatible", NULL)) {
+		if (fdt_getprop(fit, noffset, FIT_COMPAT_PROP, NULL)) {
 			fdt = fit;		  /* search in FIT image */
 			compat_noffset = noffset; /* search under config node */
 		} else {	/* Otherwise extract it from the kernel FDT. */
diff --git a/include/image.h b/include/image.h
index c1db8383459c9d7ce1ecc318ccccb4627a7066e5..c8286f2ffd32ed312f25d5d8cdc0a601f8e02f2f 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1103,6 +1103,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 #define FIT_STANDALONE_PROP	"standalone"
 #define FIT_SCRIPT_PROP		"script"
 #define FIT_PHASE_PROP		"phase"
+#define FIT_COMPAT_PROP		"compatible"
 
 #define FIT_MAX_HASH_LEN	HASH_MAX_DIGEST_SIZE
 

-- 
2.49.0

