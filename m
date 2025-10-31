Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5117CCF9FE
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D988883981;
	Fri, 31 Oct 2025 16:23:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4063783677; Fri, 31 Oct 2025 16:23:12 +0100 (CET)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [45.157.188.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E481D83952
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cyl9S34G9z4Qr;
 Fri, 31 Oct 2025 16:23:08 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cyl9R4X9lzZD4; Fri, 31 Oct 2025 16:23:07 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 31 Oct 2025 16:22:58 +0100
Subject: [PATCH 1/3] fit: support signing with only an engine_id
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-binman-engine-v1-1-c13c1b5dac43@cherry.de>
References: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
In-Reply-To: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Aristo Chen <jj251510319013@gmail.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Shiji Yang <yangshiji66@outlook.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Bryan Brattlof <bb@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
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

Currently, when one wants to use an OpenSSL engine to sign a FIT image,
one needs to pass a keydir (via -k) to mkimage which will then be
prepended to the value of the key-name-hint before being passed as
key_id argument to the OpenSSL Engine API, or pass a keyfile (via -G) to
mkimage.

My OpenSSL engine only has "slots" which are not mapped like
directories, so using keydir is not proper, though I could simply have
-k '' I guess but this won't work currently with binman anyway.

Additionally, passing a keyfile when using an engine doesn't make sense
as the key is stored in the engine.

Let simply allow FIT images be signed if both keydir and keyfile are
missing but an engine is to be used.

The keyname member is already filled by looking at key-name-hint
property in the FIT and passed verbatim to the engine, which is exactly
what is needed here.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 tools/fit_image.c  | 3 ++-
 tools/image-host.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index 0306333141e..694bb927c7d 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -26,7 +26,8 @@ static struct legacy_img_hdr header;
 
 static int fit_estimate_hash_sig_size(struct image_tool_params *params, const char *fname)
 {
-	bool signing = IMAGE_ENABLE_SIGN && (params->keydir || params->keyfile);
+	bool signing = IMAGE_ENABLE_SIGN &&
+		(params->keydir || params->keyfile || params->engine_id);
 	struct stat sbuf;
 	void *fdt;
 	int fd;
diff --git a/tools/image-host.c b/tools/image-host.c
index 21dd7f2d922..54df86316ae 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -696,7 +696,7 @@ int fit_image_add_verification_data(const char *keydir, const char *keyfile,
 			     strlen(FIT_HASH_NODENAME))) {
 			ret = fit_image_process_hash(fit, image_name, noffset,
 						data, size);
-		} else if (IMAGE_ENABLE_SIGN && (keydir || keyfile) &&
+		} else if (IMAGE_ENABLE_SIGN && (keydir || keyfile || engine_id) &&
 			   !strncmp(node_name, FIT_SIG_NODENAME,
 				strlen(FIT_SIG_NODENAME))) {
 			ret = fit_image_process_sig(keydir, keyfile, keydest,
@@ -1366,7 +1366,7 @@ int fit_add_verification_data(const char *keydir, const char *keyfile,
 	}
 
 	/* If there are no keys, we can't sign configurations */
-	if (!IMAGE_ENABLE_SIGN || !(keydir || keyfile))
+	if (!IMAGE_ENABLE_SIGN || !(keydir || keyfile || engine_id))
 		return 0;
 
 	/* Find configurations parent node offset */

-- 
2.51.0

