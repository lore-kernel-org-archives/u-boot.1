Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A54CD6E44
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 11:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACB61846FA;
	Thu, 28 May 2026 13:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="TvTd8Zta";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D4888341A; Thu, 28 May 2026 13:49:14 +0200 (CEST)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7176683FF5
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 13:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 2026052811490968c5d3645c00020774 for <u-boot@lists.denx.de>;
 Thu, 28 May 2026 13:49:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=H5nMSxi2ThCNxirChY6gOACWhPcoY+i7BtB5pTqoKFU=;
 b=TvTd8Ztanjks4kyd41G/o0+hs7M/r4Ll5ESEJHxhATLIIWXVuOEJ3FRlL7EyJ560AhgKUP
 pB+3oT2nGViUrguwTcBnDh9zez0JpUuMy6qP2n0RlwG66T5pAlN4n+pZaOtZu8f/J+WsTWr9
 lJ8Z2q35ISMba8FwIpMZdBirkufclzDdBPxOZhffDCLUrEIFtjyFSGwPxwfdn107YAzplnzi
 /nJtphuxzuERwAs5MavjEcG+gpQVwZuuL++AInoXJNmhhCUMMh6y5EYgB4erf2MY8r0j1dOe
 wx8fDKH/D0Ws7ovf24YhK7w5n7ZA/ZzQ1pP0x0xs2JrGHBVXlO7WRQ4Q==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Anshul Dalal <anshuld@ti.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 3/7] image-fit-sig: Optionally require signatures
Date: Thu, 28 May 2026 13:47:59 +0200
Message-ID: <20260528134802.v5.3.6d1d5d14140677a76a7cd7bb99a9088d8c8f480c@changeid>
In-Reply-To: <20260528114900.1505642-1-ludwig.nussel@siemens.com>
References: <20260528114900.1505642-1-ludwig.nussel@siemens.com>
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

(no changes since v4)

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

