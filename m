Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994BDCCF9EB
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 11:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F10F58004F;
	Wed, 29 Oct 2025 12:29:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCBC28006D; Wed, 29 Oct 2025 12:29:08 +0100 (CET)
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch
 [84.16.66.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F1FB8003E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 12:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cxQ4L0ghKzdW0;
 Wed, 29 Oct 2025 12:29:06 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cxQ4J5t7RzJJP; Wed, 29 Oct 2025 12:29:04 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 29 Oct 2025 12:28:53 +0100
Subject: [PATCH] rsa: always build pss padding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-rsa-pss-always-v1-1-ad2b652e75aa@cherry.de>
X-B4-Tracking: v=1; b=H4sIAHT6AWkC/x3MSwqAMAwA0atI1gZspUi9iriINmpAVBrwQ/HuF
 pdvMZNAOQortEWCyKeo7FuGKQsYF9pmRgnZYCvrTGU9RiU8VJHWix7FMAzkRtcEb2rI0RF5kvs
 fdv37ftIQZS9gAAAA
X-Change-ID: 20251029-rsa-pss-always-dbba5c57d913
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, Martin Schwan <m.schwan@phytec.de>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Alexander Graf <agraf@csgraf.de>, 
 Loic Poulain <loic.poulain@linaro.org>, Tobias Olausson <tobias@eub.se>, 
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

One could very well want to verify signed files which aren't a FIT
image (e.g. via rsa_verify_hash() when $(PHASE_)RSA_VERIFY_WITH_PKEY=y)
but that is currently only possible if the FIT_SIGNATURE symbol is
enabled for the stage this signed file needs to be verified.

While we could remove the dependency on FIT_SIGNATURE and find a better
name for the symbol, let's simply always build support for PSS padding
when RSA is enabled, like we currently do for pkcs-1.5 padding.

When $(PHASE_)RSA_VERIFY is enabled on PX30 Ringneck, the difference is
an additional 904B for the SPL (spl/u-boot-spl.bin) and 1000B for U-Boot
proper (u-boot-nodtb.bin).

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Another option is to remove the FIT_SIGNATURE dependency. For context, I
have a system where U-Boot proper verifies the signature of a few
binaries thanks to rsa_verify_hash() (see CONFIG_RSA_VERIFY_WITH_PKEY)
with an embedded public key. We do not use FIT images in proper and I
would like to avoid building code we don't use to limit the attack
surface, so I was looking at ways to remove the FIT support in proper
and this dependency makes it impossible as we use PSS padding.

The cost of always building all RSA paddings may be too high though, I
don't know where we should draw the line.
---
 boot/Kconfig              | 14 --------------
 configs/sandbox_defconfig |  1 -
 lib/rsa/rsa-sign.c        |  3 +--
 lib/rsa/rsa-verify.c      |  3 ---
 tools/Kconfig             |  5 -----
 5 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 9adb051400f..75c74cb8cda 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -116,13 +116,6 @@ config FIT_SIGNATURE_MAX_SIZE
 	  device memory. Assure this size does not extend past expected storage
 	  space.
 
-config FIT_RSASSA_PSS
-	bool "Support rsassa-pss signature scheme of FIT image contents"
-	depends on FIT_SIGNATURE
-	help
-	  Enable this to support the pss padding algorithm as described
-	  in the rfc8017 (https://tools.ietf.org/html/rfc8017).
-
 config FIT_CIPHER
 	bool "Enable ciphering data in a FIT uImages"
 	depends on DM
@@ -224,13 +217,6 @@ config SPL_FIT_SIGNATURE_MAX_SIZE
 	  device memory. Assure this size does not extend past expected storage
 	  space.
 
-config SPL_FIT_RSASSA_PSS
-	bool "Support rsassa-pss signature scheme of FIT image contents in SPL"
-	depends on SPL_FIT_SIGNATURE
-	help
-	  Enable this to support the pss padding algorithm as described
-	  in the rfc8017 (https://tools.ietf.org/html/rfc8017) in SPL.
-
 config SPL_LOAD_FIT
 	bool "Enable SPL loading U-Boot as a FIT (basic fitImage features)"
 	depends on SPL
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index cf5a8accd50..3b2c2f1a498 100644
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
diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
index 92b9d7876e5..802924fe90c 100644
--- a/lib/rsa/rsa-sign.c
+++ b/lib/rsa/rsa-sign.c
@@ -421,8 +421,7 @@ static int rsa_sign_with_key(EVP_PKEY *pkey, struct padding_algo *padding_algo,
 		goto err_sign;
 	}
 
-	if (CONFIG_IS_ENABLED(FIT_RSASSA_PSS) && padding_algo &&
-	    !strcmp(padding_algo->name, "pss")) {
+	if (padding_algo && !strcmp(padding_algo->name, "pss")) {
 		if (EVP_PKEY_CTX_set_rsa_padding(ckey,
 						 RSA_PKCS1_PSS_PADDING) <= 0) {
 			ret = rsa_err("Signer padding setup failed");
diff --git a/lib/rsa/rsa-verify.c b/lib/rsa/rsa-verify.c
index b65fbe44007..e929f5fe54d 100644
--- a/lib/rsa/rsa-verify.c
+++ b/lib/rsa/rsa-verify.c
@@ -89,7 +89,6 @@ U_BOOT_PADDING_ALGO(pkcs_15) = {
 };
 #endif
 
-#if CONFIG_IS_ENABLED(FIT_RSASSA_PSS)
 static void u32_i2osp(uint32_t val, uint8_t *buf)
 {
 	buf[0] = (uint8_t)((val >> 24) & 0xff);
@@ -305,8 +304,6 @@ U_BOOT_PADDING_ALGO(pss) = {
 };
 #endif
 
-#endif
-
 /**
  * rsa_verify_key() - Verify a signature against some data using RSA Key
  *
diff --git a/tools/Kconfig b/tools/Kconfig
index 652b0f22557..35801020b59 100644
--- a/tools/Kconfig
+++ b/tools/Kconfig
@@ -55,11 +55,6 @@ config TOOLS_FIT_PRINT
 	help
 	  Print the content of the FIT verbosely in the tools builds
 
-config TOOLS_FIT_RSASSA_PSS
-	def_bool y
-	help
-	  Support the rsassa-pss signature scheme in the tools builds
-
 config TOOLS_FIT_SIGNATURE
 	depends on TOOLS_LIBCRYPTO
 	def_bool y

---
base-commit: 4cad9faf8d2887b8851f0ced5194ffbaa92ca71e
change-id: 20251029-rsa-pss-always-dbba5c57d913

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

