Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092E8CD6E44
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 11:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C022846AE;
	Thu, 28 May 2026 13:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="OecSdJJn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FE99844CF; Thu, 28 May 2026 13:49:13 +0200 (CEST)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CBDD846CA
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 13:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20260528114910f902103a43000207f1 for <u-boot@lists.denx.de>;
 Thu, 28 May 2026 13:49:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ecCfR4hJz50ILCIELC/E90qogwM1KK1onE5rTNnJ72I=;
 b=OecSdJJnocuD69nFlf7AgOLKqp5CCu6TSTIHJT1nTN3y2dOaO/kqndr/ZfKa9Jt0NoElYW
 zLxh0p4J2ufoHhZOJhCC5mnIbeFL8vjddbPBXKQI3u5vMe9pShqKGkQAyxALoRR8B3frcGLe
 5Fg1ICrMTPT9ih+Mgz0DYvyOMV9rmCc/NcUFzbGNWfnvwuKLNvijFCgd4G4lA1W1pEuajh8X
 G7PVyE+fb1CRwTWnC94pVqN/8gR/N82J5Vc0IB/b6poDzFY7Hlt/Mbk9pkyXBBG5D5j6nxe7
 1iLnqdyBJUvMCtTnV7AGjvYcuYN75euc6gLBr4Ckw57+1KzjUfV3q1qQ==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>,
 Ferass El Hafidi <funderscore@postmarketos.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v5 5/7] iminfo: also verify signatures
Date: Thu, 28 May 2026 13:48:01 +0200
Message-ID: <20260528134802.v5.5.eb9898db9115ab0e26701a962ff8b41b199e78b2@changeid>
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

The iminfo command already verifies hashes of images. This change
also verifies signatures of configurations if enabled.
If FIT_REQUIRE_CONFIG_SIGS is enabled, iminfo also fails if
signatures are missing.

While at it print "OK\n" in success case of fit_all_image_verify()
too so iminfo output matches bootm. This will simplify the tests.

Adjusts error output slightly to be on stderr

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>

---

Changes in v5:
- rely on inline dummy for fit_all_configurations_verify
- use CONFIG_IS_ENABLED(FIT_SIGNATURE) to guard fit_all_configurations_verify
- print warning if /configurations node is missing
- print "OK\n" in fit_all_image_verify()

Changes in v4:
- fix documentation to use kdoc style

Changes in v3:
- use log_err instead of printf in fit_config_verify_required_keys()
- don't make iminfo fail unless FIT_SIGNATURE_REQUIRED is set
- update fit_all_configurations_verify documentation
- stub fit_all_configurations_verify unless FIT_SIGNATURES

Changes in v2:
- document fit_all_configurations_verify()

 boot/image-fit.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++-
 cmd/bootm.c      |  8 +++++++
 include/image.h  |  8 +++++++
 3 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index b0fcaf6e17f..7b5c51fab73 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1506,12 +1506,65 @@ int fit_all_image_verify(const void *fit)
 
 			if (!fit_image_verify(fit, noffset))
 				return 0;
-			printf("\n");
+			printf("OK\n");
 		}
 	}
 	return 1;
 }
 
+/**
+ * fit_all_configurations_verify() - verify signatures of all configurations
+ * @fit: pointer to the FIT format image header
+ *
+ * fit_all_configurations_verify() iterates over all configurations
+ * in the FIT and checks the signatures. Returns success if all
+ * configurations have valid signatures. See documentation at
+ * fit_config_verify_required_keys() or fit_config_verify_key().
+ *
+ * Return:
+ * * 0, all configurations have valid signatures
+ * * -ENOENT, no configurations found
+ * * < 0, -errno
+ */
+#if CONFIG_IS_ENABLED(FIT_SIGNATURE)
+int fit_all_configurations_verify(const void *fit)
+{
+	int confs_noffset;
+	int noffset;
+	int r = -ENOENT;
+
+	/* Find configurations parent node offset */
+	confs_noffset = fdt_path_offset(fit, FIT_CONFS_PATH);
+	if (confs_noffset < 0) {
+		log_info("Missing '%s' node: %s\n",
+			 FIT_CONFS_PATH, fdt_strerror(confs_noffset));
+		return r;
+	}
+
+	/* Process all config subnodes, check signature for each */
+	log_info("## Checking configuration signatures ...\n");
+
+	fdt_for_each_subnode(noffset, fit, confs_noffset) {
+		int ret;
+
+		log_info("   %s ... ", fit_get_name(fit, noffset, NULL));
+		ret = fit_config_verify(fit, noffset);
+		if (ret) {
+			r = ret;
+			log_err("FAIL\n");
+			continue;
+		}
+		/* valid config found */
+		if (r == -ENOENT)
+			r = 0;
+
+		log_info("OK\n");
+	}
+
+	return r;
+}
+#endif
+
 static int fit_image_uncipher(const void *fit, int image_noffset,
 			      void **data, size_t *size)
 {
diff --git a/cmd/bootm.c b/cmd/bootm.c
index ca7cec91fad..ea12639d288 100644
--- a/cmd/bootm.c
+++ b/cmd/bootm.c
@@ -329,6 +329,14 @@ static int image_info(ulong addr)
 
 		fit_print_contents(hdr);
 
+		int ret = fit_all_configurations_verify(hdr);
+
+		if (ret != 0 && (ret != -ENOENT ||
+				 CONFIG_IS_ENABLED(FIT_REQUIRE_CONFIG_SIGS))) {
+			unmap_sysmem(hdr);
+			return 1;
+		}
+
 		if (!fit_all_image_verify(hdr)) {
 			puts("Bad hash in FIT image!\n");
 			unmap_sysmem(hdr);
diff --git a/include/image.h b/include/image.h
index 34efac6056d..841b6fb77cf 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1355,6 +1355,14 @@ static inline int fit_config_verify(const void *fit, int conf_noffset)
 }
 #endif
 int fit_all_image_verify(const void *fit);
+#if CONFIG_IS_ENABLED(FIT_SIGNATURE)
+int fit_all_configurations_verify(const void *fit);
+#else
+static inline int fit_all_configurations_verify(const void *fit)
+{
+	return 0;
+}
+#endif
 int fit_config_decrypt(const void *fit, int conf_noffset);
 int fit_image_check_os(const void *fit, int noffset, uint8_t os);
 int fit_image_check_arch(const void *fit, int noffset, uint8_t arch);
-- 
2.43.0

