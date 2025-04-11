Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8F9C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 16:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CDB684137;
	Fri, 11 Apr 2025 18:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E472B8413B; Fri, 11 Apr 2025 18:32:24 +0200 (CEST)
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch
 [185.125.25.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1522884130
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 18:32:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZZ2K12JLgzG4m;
 Fri, 11 Apr 2025 18:32:21 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4ZZ2K04XFDzg7N; Fri, 11 Apr 2025 18:32:20 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 11 Apr 2025 18:32:09 +0200
Subject: [PATCH RFC] fit: allow to specify RSAPSS padding salt length magic
 value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-rsapss-saltlen-v1-1-f2913c4b3415@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAhE+WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDE0ND3aLixILiYt3ixJySnNQ83SSLFPNEM3MzUzPTRCWgpoKi1LTMCrC
 B0UpBbs5KsbW1AKwSC1hlAAAA
X-Change-ID: 20250411-rsapss-saltlen-b8d7a676565a
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Loic Poulain <loic.poulain@linaro.org>, 
 SESA644425 <giojahermann@gmail.com>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

Before commit 1b99c15d73c1 ("lib: rsa: Set conventional salt length
RSA-PSS parameter"), the salt length for PSS padding was openSSL's
default. Prior to openSSL 3.1, this was the maximum allowed value ("max"
when passed from CLI or RSA_PSS_SALTLEN_MAX (-3) if from library).[1]
Starting from 3.1, the default is now "maximized up to the digest
length" ("auto-digestmax" from CLI or RSA_PSS_SALTLEN_AUTO_DIGEST_MAX
(-4) from library).[2]

After commit 1b99c15d73c1 ("lib: rsa: Set conventional salt length
RSA-PSS parameter"), the salt length has been forced to the digest
length, but manually instead of using "digest" from CLI or
RSA_PSS_SALTLEN_DIGEST from lib.

Before commit 81eff51047e2 ("lib: rsa: Update function
padding_pss_verify (any-salt)"), verifying a signature with PSS padding
could only be done when the padding was using the max value for the salt
length. While that is now history and the code should now detect the
appropriate length when verifying, this lack of support in older
versions bring some issue. Indeed, U-Boot is typically split in two
binaries (at least on Rockchip platforms), one for U-Boot FIT (with
U-Boot proper, TF-A, TEE, etc..) which can be signed and one for the
stage(s) before U-Boot proper, who's in charge of verifying the FIT
signature. It would be possible to update only U-Boot FIT and not the
other prior stages binary in which case the device would be bricked if
it has a pre-81eff51047e2 prior stages with a U-Boot FIT signed from
post-1b99c15d73c1 or from pre-1b99c15d73c1 with openSSL >= 3.1.

This introduces a "padding-saltlen" string property to the signature
node of a FIT node which expects the CLI name of the openSSL option for
setting the RSAPSS padding salt length, it can be:
- "max"
- "digest"
- "auto" ("max" alias, but U-Boot internals pass "auto" to openSSL)
- "auto-digestmax" (only available on openSSL >= 3.1)

If it is missing, "digest" is assumed, to match current behavior.

Note that while openSSL allows to pass the length as number, the string
magic values are represented as negative numbers. FDT only allowing
u32/u64 for numbers, we cannot represent those negative numbers in the
same property as the magic string values. Hence the choice to go with a
string property.

[1] https://docs.openssl.org/3.0/man3/EVP_PKEY_CTX_ctrl/#rsa-parameters
[2] https://docs.openssl.org/3.4/man3/EVP_PKEY_CTX_ctrl/#rsa-parameters

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
How to test:
- generate keys and certs at the root of U-Boot's source directory:
  - openssl genpkey -algorithm RSA -out dev.key \
	  -pkeyopt rsa_keygen_bits:2048 -pkeyopt rsa_keygen_pubexp:65537
  - openssl req -batch -new -x509 -key dev.key -out dev.crt
- apply the following diff for generating signed U-Boot FIT + adding the
  pubkey to U-Boot SPL + making signature verification required:

 diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
 index c8c928c7e50..e5fd8c73602 100644
 --- a/arch/arm/dts/rockchip-u-boot.dtsi
 +++ b/arch/arm/dts/rockchip-u-boot.dtsi
 @@ -29,7 +29,14 @@
  			u-boot-tpl {
  			};
  #endif
 -			u-boot-spl {
 +			section {
 +				u-boot-spl-nodtb {
 +				};
 +				u-boot-spl-pubkey-dtb {
 +					algo = "sha256,rsa2048";
 +					required = "conf";
 +					key-name-hint = "dev";
 +				};
  			};
  		};
  
 @@ -45,6 +52,7 @@
  			filename = "u-boot.itb";
  			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
  			fit,align = <512>;
 +			fit,sign;
  			offset = <CONFIG_SPL_PAD_TO>;
  			images {
  				u-boot {
 @@ -162,6 +170,13 @@
  					fit,firmware = "op-tee", "u-boot";
  #endif
  					fit,loadables;
 +
 +					signature {
 +						algo = "sha256,rsa2048";
 +						key-name-hint = "dev";
 +						padding = "pss";
 +						sign-images = "fdt", "loadables", "firmware";
 +					};
  				};
  			};
  		};

You need RSA and RSAPSS support in SPL for this to work (it'll compile
just fine but always fail to verify).

It'll successfully boot.

Now revert commit 81eff51047e2 ("lib: rsa: Update function
padding_pss_verify (any-salt)") and regenerate the images.

U-Boot SPL will fail to verify U-Boot FIT signature and refuse to boot.

Now, add `padding-saltlen = "max";` to the signature node and regenerate
the images, U-Boot SPL will now be able to verify U-Boot FIT signature.

Note that I have no security background and I essentially just made sure
it compiles and boots (or refuses to boot).

This is marked as RFC because we would need to add the property to
https://fitspec.osfw.foundation/#configuration-signature-nodes
and
https://fitspec.osfw.foundation/#image-signature-nodes
I assume. Don't want to suggest something to the FIT spec if it's anyway
going to be denied in U-Boot :)

Note that I actually need a patch like this (for now I just hardcoded
the salt length to use MAX instead of digest length) for one of our
products. I don't mind keeping it downstream but I felt like this was a
semi-reasonable approach to making this configurable.

What do you think?
---
 include/image.h    |  1 +
 lib/rsa/rsa-sign.c | 34 +++++++++++++++++++++++++++-------
 tools/image-host.c |  3 +++
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/include/image.h b/include/image.h
index c1db8383459c9d7ce1ecc318ccccb4627a7066e5..785852a92f838b7b89bede1c6e6c9a346a9efd1d 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1511,6 +1511,7 @@ struct image_sign_info {
 	int required_keynode;		/* Node offset of key to use: -1=any */
 	const char *require_keys;	/* Value for 'required' property */
 	const char *engine_id;		/* Engine to use for signing */
+	const char *saltlen_name;	/* OpenSSL RSA PSS salt length magic value */
 	/*
 	 * Note: the following two fields are always valid even w/o
 	 * RSA_VERIFY_WITH_PKEY in order to make sure this structure is
diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
index fa9e143b4ca8cbc50297acdfbb4ccb39cb160f84..10b25094a2fada08eb37c38a5d618b6e07972139 100644
--- a/lib/rsa/rsa-sign.c
+++ b/lib/rsa/rsa-sign.c
@@ -384,7 +384,7 @@ static void rsa_engine_remove(ENGINE *e)
 static int rsa_sign_with_key(EVP_PKEY *pkey, struct padding_algo *padding_algo,
 			     struct checksum_algo *checksum_algo,
 		const struct image_region region[], int region_count,
-		uint8_t **sigp, uint *sig_size)
+		uint8_t **sigp, uint *sig_size, const char *saltlen_name)
 {
 	EVP_PKEY_CTX *ckey;
 	EVP_MD_CTX *context;
@@ -423,17 +423,37 @@ static int rsa_sign_with_key(EVP_PKEY *pkey, struct padding_algo *padding_algo,
 
 	if (CONFIG_IS_ENABLED(FIT_RSASSA_PSS) && padding_algo &&
 	    !strcmp(padding_algo->name, "pss")) {
+		int saltlen;
+
 		if (EVP_PKEY_CTX_set_rsa_padding(ckey,
 						 RSA_PKCS1_PSS_PADDING) <= 0) {
 			ret = rsa_err("Signer padding setup failed");
 			goto err_sign;
 		}
 
-		/* Per RFC 3447 (and convention) the Typical salt length is the
-		 * length of the output of the digest algorithm.
-		 */
-		if (EVP_PKEY_CTX_set_rsa_pss_saltlen(ckey,
-						     checksum_algo->checksum_len) <= 0) {
+		if (saltlen_name && !strcmp(saltlen_name, "max")) {
+			saltlen = RSA_PSS_SALTLEN_MAX;
+		} else if (saltlen_name && !strcmp(saltlen_name, "auto")) {
+			saltlen = RSA_PSS_SALTLEN_AUTO;
+#if OPENSSL_VERSION_NUMBER >= 0x31000000L
+		} else if (saltlen_name && !strcmp(saltlen_name, "auto-digestmax")) {
+			saltlen = RSA_PSS_SALTLEN_AUTO_DIGEST_MAX;
+#endif
+		} else if (saltlen_name && !strcmp(saltlen_name, "digest")) {
+			saltlen = RSA_PSS_SALTLEN_DIGEST;
+		} else if (saltlen_name) {
+			fprintf(stderr, "Invalid salt length '%s'\n", saltlen_name);
+			rsa_err("Invalid salt length");
+			goto err_sign;
+		} else {
+			/* Per RFC 3447 (and convention) the Typical salt length is the
+			 * length of the output of the digest algorithm.
+			 */
+			debug("padding saltlen missing, assuming \"digest\"\n");
+			saltlen = RSA_PSS_SALTLEN_DIGEST;
+		}
+
+		if (EVP_PKEY_CTX_set_rsa_pss_saltlen(ckey, saltlen) <= 0) {
 			ret = rsa_err("Signer salt length setup failed");
 			goto err_sign;
 		}
@@ -491,7 +511,7 @@ int rsa_sign(struct image_sign_info *info,
 	if (ret)
 		goto err_priv;
 	ret = rsa_sign_with_key(pkey, info->padding, info->checksum, region,
-				region_count, sigp, sig_len);
+				region_count, sigp, sig_len, info->saltlen_name);
 	if (ret)
 		goto err_sign;
 
diff --git a/tools/image-host.c b/tools/image-host.c
index a9b8690276386aa21983612c6a306b7897a0af26..63055f2044ac5c320c52dc87e59b275d4bc79e4a 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -175,6 +175,7 @@ static int fit_image_setup_sig(struct image_sign_info *info,
 {
 	const char *node_name;
 	const char *padding_name;
+	const char *saltlen_name;
 
 	node_name = fit_get_name(fit, noffset, NULL);
 	if (!algo_name) {
@@ -187,6 +188,7 @@ static int fit_image_setup_sig(struct image_sign_info *info,
 	}
 
 	padding_name = fdt_getprop(fit, noffset, "padding", NULL);
+	saltlen_name = fdt_getprop(fit, noffset, "padding-saltlen", NULL);
 
 	memset(info, '\0', sizeof(*info));
 	info->keydir = keydir;
@@ -198,6 +200,7 @@ static int fit_image_setup_sig(struct image_sign_info *info,
 	info->checksum = image_get_checksum_algo(algo_name);
 	info->crypto = image_get_crypto_algo(algo_name);
 	info->padding = image_get_padding_algo(padding_name);
+	info->saltlen_name = saltlen_name;
 	info->require_keys = require_keys;
 	info->engine_id = engine_id;
 	if (!info->checksum || !info->crypto) {

---
base-commit: cb7555e93075114fe4af0adb806877ac4d4ef80d
change-id: 20250411-rsapss-saltlen-b8d7a676565a

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

