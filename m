Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09939CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:10:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 731A084936;
	Mon,  8 Jun 2026 15:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="P0MvWjrk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C52383FEC; Mon,  8 Jun 2026 15:09:36 +0200 (CEST)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 161D9848DC
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:09:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 202606081309338af743397e000207f3 for <u-boot@lists.denx.de>;
 Mon, 08 Jun 2026 15:09:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=KL1IvirsGiWc4RDtJgX4+GhmVtAnZclJ2aaGYJEr7H0=;
 b=P0MvWjrkSdXasOwtfTqTdQyZJvzlZe3N8rTymp2y4nPbGYTq9t88z5jEFa9p5CZPnEpLKt
 nMHBCiuEo7oOsSmBCx0dYk9hFYBiIEWTwmz7zsDMK0AbwfSoKMerB2ZfsnxR/b+RqXCGeo+D
 OTPrIotu8Rh2i0AzbSlgXk87PBE9VKORt9Ibo++ju+CIYlTo/gQFfhk4nJtHQo9sy6FLuBfC
 xRajPebuToZHQif6hjSuTSGIg+fGXGstUdX9XqK33MLbBxLZWsAnrFetysJjIwn3ciDb547p
 5tn86eTaTft82eQmhPBORGa6eR3paTY3kf6EWoFQdo3gIuL1dLYBs7sQ==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Julien Stephan <jstephan@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Shiji Yang <yangshiji66@outlook.com>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v6 5/7] iminfo: also verify signatures
Date: Mon,  8 Jun 2026 15:08:51 +0200
Message-ID: <20260608150852.v6.5.eb9898db9115ab0e26701a962ff8b41b199e78b2@changeid>
In-Reply-To: <20260608130924.112831-1-ludwig.nussel@siemens.com>
References: <20260608130924.112831-1-ludwig.nussel@siemens.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>

---

Changes in v6:
- move 'ret' declaration to top of block

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
 cmd/bootm.c      | 10 +++++++++
 include/image.h  |  8 +++++++
 3 files changed, 72 insertions(+), 1 deletion(-)

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
index ca7cec91fad..25cc51cbab2 100644
--- a/cmd/bootm.c
+++ b/cmd/bootm.c
@@ -279,6 +279,9 @@ static int do_iminfo(struct cmd_tbl *cmdtp, int flag, int argc,
 static int image_info(ulong addr)
 {
 	void *hdr = (void *)map_sysmem(addr, 0);
+#if defined(CONFIG_FIT)
+	int ret;
+#endif
 
 	printf("\n## Checking Image at %08lx ...\n", addr);
 
@@ -329,6 +332,13 @@ static int image_info(ulong addr)
 
 		fit_print_contents(hdr);
 
+		ret = fit_all_configurations_verify(hdr);
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

