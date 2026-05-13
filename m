Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70448CD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 14:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10B4A8467C;
	Wed, 13 May 2026 16:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="JGFnB/gd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95A7484694; Wed, 13 May 2026 16:10:45 +0200 (CEST)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9D4D84676
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 16:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 202605131410407f8f1b5e200002078b for <u-boot@lists.denx.de>;
 Wed, 13 May 2026 16:10:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=GPsveUojlV5YA+s7Jw7/mz6nw63n65YkY55P4S/ZXRY=;
 b=JGFnB/gdwZMH2xOBYhEn5sH+o0HS6qZ42WE6oGdxeMWlbizlhqD33T7qM+PtQ2TSinZoZ0
 mhvjz5i6EO+Snlcl8A9nSy+LqxlPcZu/D3rBNOD/BAVqyqHq5gkZnuJJ/q92SnyY9Z4QITgI
 TB7KxTwyOfojtdDgFOcsvxXEIHUPBwoAMxQzyo/gy000x6mffx0itWqSmWWe3wmcbL2Fl5JZ
 KFSF8CdqS4SyfaG9CuEi39SoOpopg7+vZkYySIxnrcdpdIHZ0EDcj4v95GYzFcOPUCsxxmdt
 v5psnSjWiLZJJtiSINJUmo8mTQy3s7HkKreXkKoXGCrMNNjpJCENcNEA==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Anshul Dalal <anshuld@ti.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 3/6] image-fit-sig: Optionally require signatures
Date: Wed, 13 May 2026 16:08:13 +0200
Message-ID: <20260513160816.v4.3.6d1d5d14140677a76a7cd7bb99a9088d8c8f480c@changeid>
In-Reply-To: <20260513141027.351280-1-ludwig.nussel@siemens.com>
References: <20260513141027.351280-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

If U-Boot is built with signature verification but no keys are
included in the device tree, the boot would still continue.
Introduce FIT_SIGNATURE_REQUIRED to avoid a fail-open setup.
Defaults to off so existing setups are not affected; boards wanting
fail-closed behaviour must enable it explicitly.

Consistently use log_err for errors in fit_config_verify_required_keys()
while at it

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

Changes in v4:
- reword Kconfig help text
- rename option to FIT_REQUIRE_CONFIG_SIGS
- introduce SPL_FIT_REQUIRE_CONFIG_SIGS

Changes in v3:
- clarify error message when no keys were found
- change printfs to log_err
- reword Kconfig
- keep FIT_SIGNATURE_REQUIRED off by default

Changes in v2:
- introduce FIT_SIGNATURE_REQUIRED

 boot/Kconfig         | 22 ++++++++++++++++++++++
 boot/image-fit-sig.c | 22 ++++++++++++++--------
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index ae6f09a6ede..c36a403063e 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -124,6 +124,23 @@ config FIT_SIGNATURE
 	  format support in this case, enable it using
 	  CONFIG_LEGACY_IMAGE_FORMAT.
 
+config FIT_REQUIRE_CONFIG_SIGS
+	bool "Require configuration signature verification of FIT uImages"
+	depends on FIT_SIGNATURE
+	help
+	  This option requires that FIT uImages have configuration
+	  nodes that are signed or boot will fail.
+	  That means the U-Boot device tree must contain a
+	  "/signature" node and at least one public key with
+	  required="conf".
+	  All configuration sections of a FIT file must be signed
+	  using those keys based on "required-mode" policy.
+	  The option is useful to avoid fail-open situations so it
+	  is recommended to enable. The option currently defaults to
+	  off to avoid breaking existing setups. Keep it off if you
+	  need to reuse the same u-boot binary in setups without
+	  keys or rely on image node only signatures.
+
 config FIT_SIGNATURE_MAX_SIZE
 	hex "Max size of signed FIT structures"
 	depends on FIT_SIGNATURE
@@ -224,6 +241,11 @@ config SPL_FIT_SIGNATURE_MAX_SIZE
 	  device memory. Assure this size does not extend past expected storage
 	  space.
 
+config SPL_FIT_REQUIRE_CONFIG_SIGS
+	bool "Require signature verification of FIT firmware within SPL"
+	depends on SPL_FIT_SIGNATURE
+	select FIT_REQUIRE_CONFIG_SIGS
+
 config SPL_LOAD_FIT
 	bool "Enable SPL loading U-Boot as a FIT (basic fitImage features)"
 	depends on SPL
diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index 433df20281f..dc38a2413b0 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -632,15 +632,16 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
 	 * name root but different @ suffix to be equal
 	 */
 	if (strchr(name, '@')) {
-		printf("Configuration node '%s' contains '@'\n", name);
+		log_err("Configuration node '%s' contains '@'\n", name);
 		return -EPERM;
 	}
 
 	/* Work out what we need to verify */
 	key_node = fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
 	if (key_node < 0) {
-		debug("%s: No signature node found: %s\n", __func__,
-		      fdt_strerror(key_node));
+		log_err("No signature node found: %s\n", fdt_strerror(key_node));
+		if (CONFIG_IS_ENABLED(FIT_REQUIRE_CONFIG_SIGS))
+			return -EPERM;
 		return 0;
 	}
 
@@ -674,8 +675,8 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
 					    noffset);
 		if (ret) {
 			if (reqd_policy_all) {
-				printf("Failed to verify required signature '%s'\n",
-				       fit_get_name(key_blob, noffset, NULL));
+				log_err("Failed to verify required signature '%s'\n",
+					fit_get_name(key_blob, noffset, NULL));
 				return ret;
 			}
 		} else {
@@ -685,9 +686,14 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
 		}
 	}
 
-	if (reqd_sigs && !verified) {
-		printf("Failed to verify 'any' of the required signature(s)\n");
-		return -EPERM;
+	if (!verified) {
+		if (reqd_sigs) {
+			log_err("Failed to verify 'any' of the required signature(s)\n");
+			return -EPERM;
+		} else if (CONFIG_IS_ENABLED(FIT_REQUIRE_CONFIG_SIGS)) {
+			log_err("No suitable keys found for configuration verification\n");
+			return -EPERM;
+		}
 	}
 
 	return 0;
-- 
2.43.0

