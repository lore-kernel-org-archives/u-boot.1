Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD797606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=erbn1CBR;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=bV5s3VZR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A6926068D;
	Thu, 29 Oct 2026 10:05:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id si3VFekWOh32; Thu, 29 Oct 2026 10:05:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8C03E606DE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793268316;
	b=Xxep3/Xh9FCrTgJSWVL+o8M4w2oPnR75v+iG9rALOxUVlwt5VnB5bGhSjXFTSB0t3Q3x
	 yf9XGQCV2QNUwC+x+T8hYZnoozNA+yRBD3g88yJvonWv0iuu55S9hrnhV0fZVBF3Gcl7o
	 X/eAlZ2aMGXbMCPlSWab8Pfxm3gX92HSqxqAnb62gP+hWDCsQMyQGek79LSh36ECa6KPv
	 RDBu6KO5wxN2e0arB0f+uMRJgFZ/jUOLNpm+bA8Yw1jiFZQN9ldyoVB5Gaj4OgiQZZXpC
	 50p73+UeXdYRTg5zUBKYPCVMH8fz0G9i2K0pQpygMSYwqk1LRxW3WJjtRPud96TApOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793268316;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=C5Ql6G0+YZEhGxeG4zqJnp6McEPN7Tp6gloVNz9hGVc=;
	b=b3hi0eC/9z2SCA1nKtPAX57SLr4b1ySTUDFHFe7z6Zo3pJXTNusZ43xCgAA7ajklqTCR
	 XDZQE3qJiGDzF3LRtz1jVPFHt29UvB6JjzUXhkgpIank9hbfRnMRbebkPdEHAu09JA2rh
	 OZTdVeZpD5DW25dGdwXphfprvsrVg9ua50+zidFLyfB6Icqquq2703KG4vW6gqhb4Pm9Z
	 hzc3MWmTjPvV7IMPiXXUDRz5Q4ip7o8H5gNngGN5B7nrRASPiBX/24wiABoW6AMw3BYKj
	 b6mG2/hh8ZWcK46/tXiqeOiB0laVq4EiMnJq20WG3K9fYvrxtb6EG+o68uapFTyVmMw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=bV5s3VZR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793268316;
	bh=C5Ql6G0+YZEhGxeG4zqJnp6McEPN7Tp6gloVNz9hGVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=erbn1CBRBu9abzdcKkxjw0H1enZRG/H+Xh/HED8BB/oN35k+d6NNneEl2pLdW4iNO
	 daUO0+snR/CVUddyuVX/EqNobd47xdZSiH57P37NsYjhCJai9QTz5GT1+cd+x44EZa
	 Ly4IuHS+MBUgkSYU1TGGGNyp/Ce6iGqRQO8XcBtxNTErtBtg/chBF+VTXwJePv9ViG
	 Zs7/cnTpL1jWGDeHd2hyfDKc4SlBXNk9W9Pjoerdl7693lq4GT7wxOILTFl57xSwQH
	 Vq4cVjtInnlDgI5YEbAM+/WyN1BnvF4hnji5BoMMFQOu14bR1ox5IktUiZTV4X5RoE
	 O++1Nm7XY0LNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C03E606DE;
	Thu, 29 Oct 2026 10:05:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B249972
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:05:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7183E60677
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:05:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U0Oku3GNEy2O for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:05:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5EBC26068D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.226
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793268306;
 b=VQD6QdR7JTreIUpc4WybUzxUwf18eOToBIfbv1207hlxNKsHz0PEG27RfIkMN6aoYjFS
 O/MUGp2LqAxHrdbbP9odMTTJpGtYaDLCkExvDNZ1zCrIQv8pUWH8HibVuTzNiYUZBDdHD
 V0N+KCGH0HdcX57B8H20Os/0/oyniCqKXZS9Uvoee2rmZeD7GACWdS6+MHyMcrF0XFOM8
 DZNiJfmddkJWS1oxw3R7ZId0qGk7qeHPczsqKB9F30gWrQV9lvSzSmBpzmjFH7xo06BNd
 rA/UGPM4aqhFcZ8OVuM14ox6wiikjRpbec/RBcRHZJDK5+a0aQWPkxm503WxcuN7zYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793268306;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=C5Ql6G0+YZEhGxeG4zqJnp6McEPN7Tp6gloVNz9hGVc=;
 b=oXJih/yOIWfSiCD6U0Rt4oHU/yySf3ywWjHuiN+e/zMrLdkJr27Wo19MsPEDNBIxpA7X
 snChmRQdN6xjAB0kaSJ8GYNBSbEYUEm6+BGvTgW6o7n1bLPYi1xVvR+wmCl82QcAHo4KG
 W1PHIh14rldzzRVz2hUpR2AFMIsYwZS3tTpGOVQZK9QYreMB9J52QxpATDx5mP0f+oM2z
 9327jd5aiu4zsRce+My0YnWMayR6RImsUiyLFWlyWslsXNrjeN4ZX2bjPSHlc5VLCihsJ
 /+li8A2rsloszyASIGYerZoMeVDmIjYfXu/6+ZC4AEngW8HktsAE3JAV2PUO/0nQklg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=bV5s3VZR; 
 arc=none smtp.remote-ip=185.136.64.226
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.226;
 helo=mta-64-226.siemens.flowmailer.net;
 envelope-from=fm-1328817-20261029100500a59b7a7c5500020748-z_b2nx@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=bV5s3VZR
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5EBC26068D
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:05:03 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20261029100500a59b7a7c5500020748
 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 11:05:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=C5Ql6G0+YZEhGxeG4zqJnp6McEPN7Tp6gloVNz9hGVc=;
 b=bV5s3VZRw/CGoThdMX1SlSlD/Ha8FDcf8kKu1HMrGDuIaZPx0hcoMtZXiBMmvgDsZnepnl
 KWUpRUPWaI8EVAVMXiCo6fo2+QPPuHtu8V6/iyaVun0uM1sM+NC9+isetUoIh4wusrOi6BGE
 lYutlJ9o+N1tk1YXfnk0emfvNidneRMrfoZ8rAZJ6yS4472swn8CvtjBMsfrwRZx6Pyse9/n
 5Z54yj72hqhPnvmfb5jl+CgkrHVyIuUaQwkekaNNbbpLt2uGRJO09N0MzMyP3KyK97JTaAS0
 UfhVLsl7xxwV2XrLh2I57AfY/8q1lH45lvz8f6aRyeeaUz4k0Qirw1lQ==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Johan Jonker <jbx6244@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v11 2/6] image-fit-sig: Optionally require signatures
Date: Thu, 29 Oct 2026 11:03:53 +0100
Message-ID: <20261029110356.v11.2.6d1d5d14140677a76a7cd7bb99a9088d8c8f480c@changeid>
In-Reply-To: <20261029100455.31820-1-ludwig.nussel@siemens.com>
References: <20261029100455.31820-1-ludwig.nussel@siemens.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If U-Boot is built with signature verification but no keys are
included in the device tree, the boot would still continue.
Introduce CONFIG_FIT_REQUIRE_CONFIG_SIGS to avoid a fail-open setup.
Defaults to off so existing setups are not affected; boards wanting
fail-closed behaviour must enable it explicitly.

Consistently use log_err for errors in fit_config_verify_required_keys()
while at it

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v10)

Changes in v10:
- fix description referring to CONFIG_FIT_REQUIRE_CONFIG_SIGS

Changes in v9:
- restore debug message instead of errro

Changes in v7:
- mention CONFIG_FIT_REQUIRE_CONFIG_SIGS in documentation

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

 boot/Kconfig                | 22 ++++++++++++++++++++++
 boot/image-fit-sig.c        | 19 +++++++++++++------
 doc/usage/fit/signature.rst | 13 ++++++++++---
 3 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index dfaef99b231..0b3399a66d9 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -137,6 +137,23 @@ config FIT_SIGNATURE
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
@@ -259,6 +276,11 @@ config SPL_FIT_SIGNATURE_MAX_SIZE
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
index c0fbe81b4c7..5a2c6316b19 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -674,7 +674,7 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
 	 * name root but different @ suffix to be equal
 	 */
 	if (strchr(name, '@')) {
-		printf("Configuration node '%s' contains '@'\n", name);
+		log_err("Configuration node '%s' contains '@'\n", name);
 		return -EPERM;
 	}
 
@@ -683,6 +683,8 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
 	if (key_node < 0) {
 		debug("%s: No signature node found: %s\n", __func__,
 		      fdt_strerror(key_node));
+		if (CONFIG_IS_ENABLED(FIT_REQUIRE_CONFIG_SIGS))
+			return -EPERM;
 		return 0;
 	}
 
@@ -716,8 +718,8 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
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
@@ -727,9 +729,14 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
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
diff --git a/doc/usage/fit/signature.rst b/doc/usage/fit/signature.rst
index e5d6ce85c7e..4c43b1999ba 100644
--- a/doc/usage/fit/signature.rst
+++ b/doc/usage/fit/signature.rst
@@ -422,11 +422,14 @@ below examples::
 
 Enabling FIT Verification
 -------------------------
-In addition to the options to enable FIT itself, the following CONFIGs must
-be enabled:
+In addition to the options to enable FIT itself, the following
+settings configure signature verification support:
 
 CONFIG_FIT_SIGNATURE
-    enable signing and verification in FITs
+    required to enable signing and verification in FITs
+
+CONFIG_FIT_REQUIRE_CONFIG_SIGS
+    make signature verification mandatory
 
 CONFIG_RSA
     enable RSA algorithm for signing
@@ -438,6 +441,10 @@ WARNING: When relying on signed FIT images with required signature check
 the legacy image format is default disabled by not defining
 CONFIG_LEGACY_IMAGE_FORMAT
 
+WARNING: CONFIG_FIT_REQUIRE_CONFIG_SIGS is not set by default for
+backwards compatibility. It is recommended to be turned on whenever
+configuration signatures are used to avoid fail-open behavior
+
 
 Testing
 -------
-- 
2.43.0

