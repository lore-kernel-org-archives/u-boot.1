Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1304CCFA00
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 17:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1196283A89;
	Fri, 31 Oct 2025 18:08:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06E9D83A43; Fri, 31 Oct 2025 18:08:48 +0100 (CET)
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::8faa])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE06983A45
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 18:08:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cynWJ3WMTzcMX;
 Fri, 31 Oct 2025 18:08:44 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cynWH4GGKzyJn; Fri, 31 Oct 2025 18:08:43 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 31 Oct 2025 18:08:23 +0100
Subject: [PATCH v2 4/5] rsa: rename FIT_RSASSA_PSS to RSASSA_PSS and move
 symbols under lib/rsa
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-rsa-pss-always-v2-4-a29184ea064d@cherry.de>
References: <20251031-rsa-pss-always-v2-0-a29184ea064d@cherry.de>
In-Reply-To: <20251031-rsa-pss-always-v2-0-a29184ea064d@cherry.de>
To: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martin Schwan <m.schwan@phytec.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Alexander Graf <agraf@csgraf.de>, Loic Poulain <loic.poulain@linaro.org>, 
 Tobias Olausson <tobias@eub.se>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Shiji Yang <yangshiji66@outlook.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>, E Shattow <e@freeshell.de>, 
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

This renames FIT_RSASSA_PSS symbols to drop the FIT_ prefix to avoid
potential confusion since there's nothing FIT specific to those symbols.

It also isn't really related to booting, so boot/Kconfig is an odd place
for them to live. Since they make sense only in relation with RSA,
simply move them to lib/rsa where it makes more sense for them to
reside.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 boot/Kconfig              | 14 --------------
 configs/sandbox_defconfig |  2 +-
 lib/rsa/Kconfig           | 14 ++++++++++++++
 lib/rsa/rsa-sign.c        |  2 +-
 lib/rsa/rsa-verify.c      |  2 +-
 tools/Kconfig             |  2 +-
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index a37d08eff1d..708a18fd0ad 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -116,13 +116,6 @@ config FIT_SIGNATURE_MAX_SIZE
 	  device memory. Assure this size does not extend past expected storage
 	  space.
 
-config FIT_RSASSA_PSS
-	bool "Support rsassa-pss signature scheme"
-	depends on RSA_VERIFY
-	help
-	  Enable this to support the pss padding algorithm as described
-	  in the rfc8017 (https://tools.ietf.org/html/rfc8017).
-
 config FIT_CIPHER
 	bool "Enable ciphering data in a FIT uImages"
 	depends on DM
@@ -212,13 +205,6 @@ config SPL_FIT_SIGNATURE_MAX_SIZE
 	  device memory. Assure this size does not extend past expected storage
 	  space.
 
-config SPL_FIT_RSASSA_PSS
-	bool "Support rsassa-pss signature scheme in SPL"
-	depends on SPL_RSA_VERIFY
-	help
-	  Enable this to support the pss padding algorithm as described
-	  in the rfc8017 (https://tools.ietf.org/html/rfc8017) in SPL.
-
 config SPL_LOAD_FIT
 	bool "Enable SPL loading U-Boot as a FIT (basic fitImage features)"
 	depends on SPL
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index cf5a8accd50..f4c2cc5d155 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -18,7 +18,6 @@ CONFIG_EFI_CAPSULE_AUTHENTICATE=y
 CONFIG_EFI_CAPSULE_CRT_FILE="board/sandbox/capsule_pub_key_good.crt"
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
-CONFIG_FIT_RSASSA_PSS=y
 CONFIG_FIT_CIPHER=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTMETH_ANDROID=y
@@ -383,6 +382,7 @@ CONFIG_MBEDTLS_LIB=y
 CONFIG_HKDF_MBEDTLS=y
 CONFIG_ECDSA=y
 CONFIG_ECDSA_VERIFY=y
+CONFIG_RSASSA_PSS=y
 CONFIG_TPM=y
 CONFIG_ERRNO_STR=y
 CONFIG_GETOPT=y
diff --git a/lib/rsa/Kconfig b/lib/rsa/Kconfig
index 9033384e60a..904eafa9441 100644
--- a/lib/rsa/Kconfig
+++ b/lib/rsa/Kconfig
@@ -67,6 +67,20 @@ config SPL_RSA_VERIFY_WITH_PKEY
 	  key properties will be calculated on the fly in verification code
 	  in the SPL.
 
+config RSASSA_PSS
+	bool "Support rsassa-pss signature scheme"
+	depends on RSA_VERIFY
+	help
+	  Enable this to support the pss padding algorithm as described
+	  in the rfc8017 (https://tools.ietf.org/html/rfc8017).
+
+config SPL_RSASSA_PSS
+	bool "Support rsassa-pss signature scheme within SPL"
+	depends on SPL_RSA_VERIFY
+	help
+	  Enable this to support the pss padding algorithm as described
+	  in the rfc8017 (https://tools.ietf.org/html/rfc8017) within SPL.
+
 config RSA_SOFTWARE_EXP
 	bool "Enable driver for RSA Modular Exponentiation in software"
 	depends on DM
diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
index 92b9d7876e5..0e38c9e802f 100644
--- a/lib/rsa/rsa-sign.c
+++ b/lib/rsa/rsa-sign.c
@@ -421,7 +421,7 @@ static int rsa_sign_with_key(EVP_PKEY *pkey, struct padding_algo *padding_algo,
 		goto err_sign;
 	}
 
-	if (CONFIG_IS_ENABLED(FIT_RSASSA_PSS) && padding_algo &&
+	if (CONFIG_IS_ENABLED(RSASSA_PSS) && padding_algo &&
 	    !strcmp(padding_algo->name, "pss")) {
 		if (EVP_PKEY_CTX_set_rsa_padding(ckey,
 						 RSA_PKCS1_PSS_PADDING) <= 0) {
diff --git a/lib/rsa/rsa-verify.c b/lib/rsa/rsa-verify.c
index b65fbe44007..0d618f15ea9 100644
--- a/lib/rsa/rsa-verify.c
+++ b/lib/rsa/rsa-verify.c
@@ -89,7 +89,7 @@ U_BOOT_PADDING_ALGO(pkcs_15) = {
 };
 #endif
 
-#if CONFIG_IS_ENABLED(FIT_RSASSA_PSS)
+#if CONFIG_IS_ENABLED(RSASSA_PSS)
 static void u32_i2osp(uint32_t val, uint8_t *buf)
 {
 	buf[0] = (uint8_t)((val >> 24) & 0xff);
diff --git a/tools/Kconfig b/tools/Kconfig
index 652b0f22557..a1b4d701ac7 100644
--- a/tools/Kconfig
+++ b/tools/Kconfig
@@ -55,7 +55,7 @@ config TOOLS_FIT_PRINT
 	help
 	  Print the content of the FIT verbosely in the tools builds
 
-config TOOLS_FIT_RSASSA_PSS
+config TOOLS_RSASSA_PSS
 	def_bool y
 	help
 	  Support the rsassa-pss signature scheme in the tools builds

-- 
2.51.0

