Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E54C98307
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 11:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6542180DB4;
	Wed, 23 Sep 2026 11:51:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M8mJDzyRNvAH; Wed, 23 Sep 2026 11:51:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7CD6280E85
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790164267;
	b=K18aR/CqtWvHX4Uu5OJ/ooKyh2JdGud5T9WfWpicDdI6bQwSGnRkB/cMtsFFXbOwotiR
	 aJofYUmmlwuMX7DHProYG+pR5QKzYQQ4m7jQMMuUUfoZWzP5vLkdYm5mBwnO0HsZkFBPs
	 eqbIOVnemREkzOhRsvK5vx0e7NGFhyhQCDddJz12bErni/HuXOClGmzaIZu5Vldl/KT70
	 /f5+9fVZw4c3HRGIDYrc5/j+99QBOB2aD7xFlzadRlAcyRFADepBC0hFYjqEJlDYzv1cR
	 OL3Gl3UULhh8UXA2mpB6boixpuOpMX42CkL5I+MfXwxBLBLZN642OvYsCboEFRRsMWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790164267;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kQ4u2pdVi04zpBg+GQMFO7lcrVbIMVSTYW2NTwxuwao=;
	b=BObsYolKe2ekfhol8Z494P5L65MGEgrKV//9xsP2nMxSpKis9eywCKT5p8vQLP741PDD
	 Bd2qQnLjzohlwDr5LEdUQSnLWjWbZFbSAJ2Uz0rMNtLOtSmORPx/XUYo+WtyaVrZfE9uL
	 fxqvGwT+ABOcz+460fY/mjdI6MVlhPaCg/5WA5a1zlvkF95tx20NPHEcTU2nJQsmy7Feh
	 JaZYSBznNRXlqHg9Y7Vn3EEpeBycHKXnDnsw/hpsSZu2RpKAFxZeHPLLt/WvP/iO2sHcU
	 1efH/u0LtsWX6KKvby5FQdfK0T/P2IDQgYnCBs9TiwowjHlltmAdoMbZHNEA9co0hbA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790164267;
	bh=kQ4u2pdVi04zpBg+GQMFO7lcrVbIMVSTYW2NTwxuwao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pO5HTEH763av+bEQ2spgqK/LkZ7JmbK/Ucsk6GysKahcJtfVAgz6mZ/jNDQ8Z/uPy
	 eKJenPRls/AXTRUkrTLRLPwWBO1k2E5C82DYX1AQZp784YMh9Wmdg9ASKY+gG2Ashr
	 8JZ5NOZBZ0T/LA/D+3NeVcuu7387u9V8rX+/yqpFz/jit4KUKOeA7GFJQMOCCsb50B
	 SrPNmeehYVcwYsy+eqdgVVL5bdYO3W61EPEviiSdSqpIRXtV3wmJHlphxehcLPLf82
	 2g1zmXis2kX3MKmeOOQxnmBhEchN8q680np9sJSKIuj2GZ7DtG020XWz0L4BxXmWmG
	 kHigxvUM+Lm1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CD6280E85;
	Wed, 23 Sep 2026 11:51:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DACCBB0C
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:51:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C6952406EF
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:51:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MfrJ6gewwTvl for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 11:51:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E1641406AE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.225
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790164261;
 b=K/1AjEHexm3zRKCPwPKiXWVH7O4ycmAzg8uNcGgGTnHXdZNAeAun4C4eewB8m92Lgv0j
 D553Wx5vuXmqNoHuiHxFLW2eShTiF2WsR3YYf9xO6KRgIP8SvQOCujN1zwDPHIXo/fVMK
 8O81Poghd1pLuty+bvyIplWrU9imKkfFBJ9CKuGxAKgZlkU+Q+arxDOOyekhU9NBMhY3c
 sFzdTGIiVAb5LUZHiAT6oVPYrr4CYziftxL9SQkcTyVck1Jh5z81WqWF2bH95btP8bfxZ
 BNjmsLmRbeHLixThetmOQDkv0WXt9KNqGSjVoduyOyDSakLT2z7N1mRPDMvFZYMaROw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790164261;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=kQ4u2pdVi04zpBg+GQMFO7lcrVbIMVSTYW2NTwxuwao=;
 b=GEE4dd7zBw1nZg2CQBnSKBqUTEg7Q7Gv/BzplFsJ5uG+oevJDVqCXjft2J8F4HgFzG56
 s51JY57zCOV9cVbghqg1hBpT6EGIkdwUxBEhPvn3Mifd6nwzTi4ZitOO+1hdkTxBvc2DY
 VkSzp10X9NH14kc/gJvbY0GACx8z8sUOGmwMsighUCunC/R/fy5m4tR+lo/eVPQa/8hMf
 ys6EypG6F3Uo4EmmAEGwWc0kuHGW8aPLe9AVtTK3kAXE678HkqL9Sjpqwm2AKtyn3XPxX
 2N51mhYKLaOy3nTEU3nNKgx02pRZEj+oJyf+pcBrNkmoSEWNYAhjbrNLtyeBUbJLvcQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=lHvBj5zn; 
 arc=none smtp.remote-ip=185.136.64.225
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 23 Sep 2026 11:50:59 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=lHvBj5zn
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.225;
 helo=mta-64-225.siemens.flowmailer.net;
 envelope-from=fm-1328817-202609231149539cd9248eda000207b5-ck3kfc@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1641406AE
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 11:50:59 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 202609231149539cd9248eda000207b5
 for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 13:49:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kQ4u2pdVi04zpBg+GQMFO7lcrVbIMVSTYW2NTwxuwao=;
 b=lHvBj5znjLsW0IJ0AULqTtNBPPJ0rcUDquID4EIutWucErCViQyU8q8DybTpaFmNjFJeDv
 LOKloiW3CbanIwpKoUAq92LNFekify8Z0+pK68OKBGzPbLqMHt2xRLZ1+Tz2WwcXRGOEoTf/
 h39PSwlk2UoVyzTXCv97qFu2dpxLQBEg2VUDa4eWzqkO7HRSyjyFbQcM1/wdN1Aw7PS5AYBN
 t+IggkHUQaO+ulE9anbh9jr1LHBUJKvLIvB+gggxz7JUHYP3W6KSLgsmcHhrS6L0I5jgoFt/
 R1kF/9PyQSs3ykaNN2D70RAKCF7pCUlz2a9ynZhV9F3qPjPA5mAkAh0g==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Johan Jonker <jbx6244@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 3/7] image-fit-sig: Optionally require signatures
Date: Wed, 23 Sep 2026 13:49:30 +0200
Message-ID: <20260923134933.v10.3.6d1d5d14140677a76a7cd7bb99a9088d8c8f480c@changeid>
In-Reply-To: <20260923114940.349985-1-ludwig.nussel@siemens.com>
References: <20260923114940.349985-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

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

