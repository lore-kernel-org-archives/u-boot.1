Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7971DCD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 12:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1833884AF2;
	Thu,  7 May 2026 14:07:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="SwiHhU2O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76E3F84B41; Thu,  7 May 2026 14:07:48 +0200 (CEST)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28FEC84AF2
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 14:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 202605071207398603725f2900020771 for <u-boot@lists.denx.de>;
 Thu, 07 May 2026 14:07:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=wPUB7v8xYdmIJJTDRVBqt4KNNUMDMMnlzqR75DOmo1E=;
 b=SwiHhU2OBquZiDSsE8esn22CWJUizce3zOAsOvUF/c6kKZkhvs5rPKzl+kWovEZJTipyUi
 WgnhywKqisyoKCRq388cCQm0z2IKXP/rcu8rro7I4+mpoZydiyiGReeGfm4k3yQBQ4bN0Y19
 oREUdM7Ur7Klpyp5LdAHBkiy4Q1v/y+ZqrdC1E+zhzUkloHydi2Q7+zNIDBKhBlqD22q6jlG
 foaW3fUQWnjOZVsCiI84DbZmpaNhHDhsM+/G18ooSV+ng5xu1iqByXLkVDzbmzMRebz9lzyP
 hOxsUx4t7yFTpKBLEgfxsngMrh8QBFRl8b0HVcjCvHuGA4CXNmr21/EQ==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>,
 David Lechner <dlechner@baylibre.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v3 4/4] iminfo: also verify signatures
Date: Thu,  7 May 2026 14:06:25 +0200
Message-ID: <20260507140624.v3.4.eb9898db9115ab0e26701a962ff8b41b199e78b2@changeid>
In-Reply-To: <20260507120735.310325-1-ludwig.nussel@siemens.com>
References: <20260507120735.310325-1-ludwig.nussel@siemens.com>
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

The iminfo command already verifies hashes of images. This change also
verifies signatures of configurations if enabled.

Adjusts error output slighly to be on stderr

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>

---

Changes in v3:
- use log_err instead of printf in fit_config_verify_required_keys()
- don't make iminfo fail unless FIT_SIGNATURE_REQUIRED is set
- update fit_all_configurations_verify documentation
- stub fit_all_configurations_verify unless FIT_SIGNATURES

Changes in v2:
- document fit_all_configurations_verify()

 boot/image-fit.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 cmd/bootm.c      |  7 +++++++
 include/image.h  |  8 +++++++
 3 files changed, 69 insertions(+)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 2d2709aa5b1..d77f69953e2 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1512,6 +1512,60 @@ int fit_all_image_verify(const void *fit)
 	return 1;
 }
 
+/**
+ * fit_all_configurations_verify - verify signatures of all configurations
+ * @fit: pointer to the FIT format image header
+ *
+ * fit_all_configurations_verify() iterates over all configurations
+ * in the FIT and checks the signatures. Returns success if all
+ * configurations have valid signatures. See documentation at
+ * fit_config_verify_required_keys() or fit_config_verify_key().
+ *
+ * returns:
+ *     0, success
+ *     -ENOENT, no configurations present
+ *     <0, error
+ */
+#if FIT_IMAGE_ENABLE_VERIFY
+int fit_all_configurations_verify(const void *fit)
+{
+	int confs_noffset;
+	int noffset;
+	int r = -ENOENT;
+
+	/* Find configurations parent node offset */
+	confs_noffset = fdt_path_offset(fit, FIT_CONFS_PATH);
+	if (confs_noffset < 0) {
+		log_err("Can't find configurations parent node '%s' (%s)\n",
+			FIT_CONFS_PATH, fdt_strerror(confs_noffset));
+		return confs_noffset;
+	}
+
+	/* Process all config subnodes, check signature for each */
+	log_info("## Checking configuration signatures ...\n");
+
+	fdt_for_each_subnode(noffset, fit, confs_noffset) {
+		int ret;
+
+		log_info("   %s ... ", fit_get_name(fit, noffset, NULL));
+		/* fit_config_verify() prints results so we can be silent */
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
index ca7cec91fad..0aacf7b7d7b 100644
--- a/cmd/bootm.c
+++ b/cmd/bootm.c
@@ -335,6 +335,13 @@ static int image_info(ulong addr)
 			return 1;
 		}
 
+		if (CONFIG_IS_ENABLED(FIT_SIGNATURE) &&
+		    fit_all_configurations_verify(hdr) != 0) {
+			puts("Signature verification failed!\n");
+			unmap_sysmem(hdr);
+			return CONFIG_IS_ENABLED(FIT_SIGNATURE_REQUIRED) == 1;
+		}
+
 		unmap_sysmem(hdr);
 		return 0;
 #endif
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

