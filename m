Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5DED12D7A
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 16:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF4E284009;
	Wed,  3 Dec 2025 17:19:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09C2B83FC4; Wed,  3 Dec 2025 17:19:45 +0100 (CET)
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc0a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB74183FB0
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 17:19:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dM2sV3MxkzvH1;
 Wed,  3 Dec 2025 17:19:42 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dM2sT4N8rzLP3; Wed,  3 Dec 2025 17:19:41 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 03 Dec 2025 17:19:34 +0100
Subject: [PATCH next v2 3/4] boot/fit: declare (and use) new constant for
 conf's compatible prop
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-fit-compat-v2-3-0fea56f23809@cherry.de>
References: <20251203-fit-compat-v2-0-0fea56f23809@cherry.de>
In-Reply-To: <20251203-fit-compat-v2-0-0fea56f23809@cherry.de>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>, 
 u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Shiji Yang <yangshiji66@outlook.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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
index 0205637ed16..c42b22ab02b 100644
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
index 9a1c828416d..8dcf0cea25f 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1105,6 +1105,7 @@ int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
 #define FIT_SCRIPT_PROP		"script"
 #define FIT_PHASE_PROP		"phase"
 #define FIT_TFA_BL31_PROP	"tfa-bl31"
+#define FIT_COMPAT_PROP		"compatible"
 
 #define FIT_MAX_HASH_LEN	HASH_MAX_DIGEST_SIZE
 

-- 
2.52.0

