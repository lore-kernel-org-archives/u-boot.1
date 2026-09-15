Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A8EC88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 12:53:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D346080BCD;
	Tue, 15 Sep 2026 12:53:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fSrXrtQYz1lO; Tue, 15 Sep 2026 12:53:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E9A83809B4
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789476820;
	b=kxvqzSD/oMxoqqrKRHXpdVzy65pZpPx9T6sM5yvswH4sOvaQjBpEOLWi11crXJKYcUqE
	 45JgMUDLC4VJcyTpC/bCw60RiesPe4ccZLB0II6OjSreOdSRAT9Eo6aA/lbz9eRrrP2k8
	 L+OH03oYkgMQjJC4+ZvsI037KuNLelktaR2MvqJYVD2M+tYgD62oW6zuNjaqX8X/szLRi
	 emSkw1W3s5kKsliIEsEd2/nY8SyjEBYU5mKy+pZZOWdWs9QopgBPfpmqAEkd58BWwtdps
	 QN4V2n81CbVdfO6CxFp61nouortVqMxE4Hj9M7siAKa7PyTMTDC5SG02OP8EnPuSoeQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476820;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-Virus-Scanned:X-Virus-Status:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=a6F9QU3ZATdmZ5cCxmVeIGD2MEVYDA4+OUvVGMY6QCs=;
	b=bU1u82cQtaYhrV+Rg2GbNGlminFUinSvs29NYfmUSFWBUmrm4i5YtywHkxicIsyWIo4A
	 M9pSzl7hzw03iuAzdpOJsS3T300XjLE8uyFk00HBQ0mZdGv94v4dus0rQDSkUKfaCaqqU
	 BT1XGbIXUYXNBrKAmC4y83OMxJ94gGcx/VKYKdLTKhZFveu9jj+/U6xoJwhvFN6RNhlz3
	 z0GzGFdkd1wL4xCb9saiylwHBdWQYmq5OFZgvfdVc8a2SG2D2CPFR3icK+8Zc7HoqwAQu
	 Clabfs6WEqKc/0YJ8LcmXCmbj+9YArvx4d/dFZZeb2h0Vx+HuBM6Qr7XRicDnbIBcFw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789476820;
	bh=a6F9QU3ZATdmZ5cCxmVeIGD2MEVYDA4+OUvVGMY6QCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a6JF13WdGdA7qd24u8kDI9M5e7OHgKU58J0RUNiaTRSW5V9wht0PCxK9QaG81sZgl
	 BRGq+4fzeSnoqRrLArH7rEzCLtaRjZwtJUKJkoIXTYAyCHHvZo0q1bSJ94xw+Vqbew
	 YOqtNIU+Ps6S3ltZL1z+U1iIqJq65bL4/zhXxnR/VSE3FqTR+0YubikeKIpqeVjdnc
	 CJafKto6n6TK+jm4U01qB0I4ZI6VXd/q6KfF9a/nfXUYfIpUbzjOxRSV+2cvjUyOut
	 kTiMIadXki8s2ta1S49MXAagjyFy6BbCC32eK/KahTR9crIbrlgOh2evbUcdJ93w8e
	 CCBybl4NNOvDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9A83809B4;
	Tue, 15 Sep 2026 12:53:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BA972E3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1165D4050E
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yll-UJe3rHRU for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 12:53:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5430140509
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476810;
 b=BZZWLQfFPi9n73gk3Qj4ahSmRHPq32DZyMxzkiJ6yjiFRxShhCzYgXjrfzDJYdfMVzax
 vGe5mKjfFeWPJhzqNPTCnIBV2878jX/ndLjdXA6pANYrH4XW4BwCGci1BcsfTvM7G5sc7
 ZOgLvlQEPjPOpSfcMhUVR3EYwklA/U9TCThdRQz/jd3PnFwM9jNZ5L1CkyeUSdiiqvyAn
 WRR8gqlNdR11OHb0ATlC/paP0vfNXMUCrTppe1lUj20OJkAHbw/imAzOApxZxtqpiP+LI
 uE5Sy3Sy6KPBb4LIQeTAlwC/p06xvCyzAnqKNCzLo+mJhFcsrUzX+N4uH+yjZ1XUCXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476810;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
 X-Flowmailer-Platform:Feedback-ID:X-Virus-Scanned:X-Virus-Status;
 bh=a6F9QU3ZATdmZ5cCxmVeIGD2MEVYDA4+OUvVGMY6QCs=;
 b=nR2Ym0YILxSZwRpZDff60ZaSAjWxCrl1yp+/1AIi4SYpuOCRXmcAQi1xbC3+a9CXuPwD
 z6zUY1VEDIgCMGnhRHddYOiG3yE6CeGe1LjmjyPTTUAwXywr4yKtCNf+I9WEhwFJNJHGR
 dPEmnZs1h2UNk4+8C2aNz2jmShjiCXbR3vflJVthrSf7YgDmnMTk/985bs/lDNgfRKMIU
 L+HVv4BwDaJjq2CfenkKZ61m/23oVgJhvHqP51ZJqax2UPPrHZg/r0Ff3laiAN1QGTgCT
 TjcoiC7jt5+iTltfI10rKUUTE83ZtsXUP8Ww2AvW7ZqFLhadpWanqwKfSVDhsKBmg7g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 spf=fail smtp.mailfrom=siemens.com;
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=UeJ+89bD; 
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ludwig.nussel@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=UeJ+89bD
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5430140509
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:28 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA0D1847DF; Tue, 15 Sep 2026 14:53:26 +0200 (CEST)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD60A80117
 for <u-boot@lists.denx.de>; Tue, 15 Sep 2026 14:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.b="UeJ+89bD"; dkim-atps=neutral
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 202609151253242405c96e80000207d9 for <u-boot@lists.denx.de>;
 Tue, 15 Sep 2026 14:53:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=a6F9QU3ZATdmZ5cCxmVeIGD2MEVYDA4+OUvVGMY6QCs=;
 b=UeJ+89bDmO9iUFTyOomOvlF+4F9v6zVQnQL89E1V1/iQ/wcdIRPRbvD/hnQ4Tqif7iBlZd
 dX4Hu3d23/PCMD/36DlRXD8fmeUMR5jeUwR1C0ji5IJJkwJHIPfuYTjRx2DgZDxJbJ5biX5A
 QNexGKtwbf2GIdFjdEz0YmKxad9Gm+DRkHkAgWZ/KCCRRHeQyjVPi9Pb6tYVAJi3WiWsKtyD
 xRQr81A2qPe2I/HwC7ctH/68zHn9tcNcxPLHxvDk/InCnpAp8chTxFnthFTWIC9m6mD/UGQc
 p0Jp1DhUtHtA1D+m0nqCAg1FI8gxQAGfs5k0BflmjsX2q0kSoZZWa8WA==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH v9 4/8] image-fit-sig: Optionally require signatures
Date: Tue, 15 Sep 2026 14:52:15 +0200
Message-ID: <20260915145217.v9.4.6d1d5d14140677a76a7cd7bb99a9088d8c8f480c@changeid>
In-Reply-To: <20260915125317.180911-1-ludwig.nussel@siemens.com>
References: <20260915125317.180911-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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
Introduce FIT_SIGNATURE_REQUIRED to avoid a fail-open setup.
Defaults to off so existing setups are not affected; boards wanting
fail-closed behaviour must enable it explicitly.

Consistently use log_err for errors in fit_config_verify_required_keys()
while at it

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

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
index 433df20281f..0e04089fde0 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -632,7 +632,7 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
 	 * name root but different @ suffix to be equal
 	 */
 	if (strchr(name, '@')) {
-		printf("Configuration node '%s' contains '@'\n", name);
+		log_err("Configuration node '%s' contains '@'\n", name);
 		return -EPERM;
 	}
 
@@ -641,6 +641,8 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
 	if (key_node < 0) {
 		debug("%s: No signature node found: %s\n", __func__,
 		      fdt_strerror(key_node));
+		if (CONFIG_IS_ENABLED(FIT_REQUIRE_CONFIG_SIGS))
+			return -EPERM;
 		return 0;
 	}
 
@@ -674,8 +676,8 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
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
@@ -685,9 +687,14 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
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
index da08cc75c3a..73153c97367 100644
--- a/doc/usage/fit/signature.rst
+++ b/doc/usage/fit/signature.rst
@@ -420,11 +420,14 @@ below examples::
 
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
@@ -436,6 +439,10 @@ WARNING: When relying on signed FIT images with required signature check
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

