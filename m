Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F01FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 15:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC5E384106;
	Mon, 27 Apr 2026 17:04:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="eWx+ilLO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D277E83693; Mon, 27 Apr 2026 17:04:54 +0200 (CEST)
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EACEA83BC4
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 17:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 202604271504529eac80577b00020742 for <u-boot@lists.denx.de>;
 Mon, 27 Apr 2026 17:04:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=PI0QmtJYVsFSstnRi3T5SNM14DYZPOzFo/Dn9f2D84A=;
 b=eWx+ilLO/clZIjEaQdBrga5EgO0hHT0yLHts1SdvWJdCVNNhcAGqmxjn/duNvPeF+3I2ij
 pQNq5cEANyOfVHrjvrkT0vl+GGiFk+H+o+VSIFgW7HCObtVOL0YKplxDJPEqac8geMgTIHHX
 9v1HwRFJAXoHc2zQLpJzbHN1IdxH31UPczFJWIxveErUG1xXt34zMPZ6wqu1Snx6/EDpgNeF
 wcqfYebXLXEr2qn5O0laFi4cM3DxJ7fLS3dgn1lnrdao/fdkGKSjobWX5lpx40HPJfC9loqC
 Zg7r/mGvdkzls1AyVAQX5sc9wSVVGZlI+gznpiE0jjXClLQo1ix6im/w==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Julien Stephan <jstephan@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Shiji Yang <yangshiji66@outlook.com>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH 2/4] iminfo: also verify signatures
Date: Mon, 27 Apr 2026 17:03:39 +0200
Message-ID: <20260427150409.400914-2-ludwig.nussel@siemens.com>
In-Reply-To: <20260427150409.400914-1-ludwig.nussel@siemens.com>
References: <20260427150409.400914-1-ludwig.nussel@siemens.com>
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

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
---

 boot/image-fit.c | 36 ++++++++++++++++++++++++++++++++++++
 cmd/bootm.c      |  7 +++++++
 include/image.h  |  1 +
 3 files changed, 44 insertions(+)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 2d2709aa5b1..b2c6db79edb 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1512,6 +1512,42 @@ int fit_all_image_verify(const void *fit)
 	return 1;
 }
 
+int fit_all_configurations_verify(const void *fit)
+{
+	int confs_noffset;
+	int noffset;
+	int r = -ENOENT;
+
+	/* Find images parent node offset */
+	confs_noffset = fdt_path_offset(fit, FIT_CONFS_PATH);
+	if (confs_noffset < 0) {
+		printf("Can't find configurations parent node '%s' (%s)\n",
+		       FIT_IMAGES_PATH, fdt_strerror(confs_noffset));
+		return confs_noffset;
+	}
+
+	/* Process all config subnodes, check hashes for each */
+	printf("## Checking signatures for FIT Image at %08lx ...\n",
+	       (ulong)fit);
+
+	fdt_for_each_subnode(noffset, fit, confs_noffset) {
+		int ret;
+
+		printf("%s ... ", fit_get_name(fit, noffset, NULL));
+		ret = fit_config_verify(fit, noffset);
+		if (ret) {
+			r = ret;
+			continue;
+		}
+		/* at least one correct config */
+		if (r == -ENOENT)
+			r = 0;
+		puts("OK\n");
+	}
+
+	return r;
+}
+
 static int fit_image_uncipher(const void *fit, int image_noffset,
 			      void **data, size_t *size)
 {
diff --git a/cmd/bootm.c b/cmd/bootm.c
index ca7cec91fad..2faa9648c46 100644
--- a/cmd/bootm.c
+++ b/cmd/bootm.c
@@ -335,6 +335,13 @@ static int image_info(ulong addr)
 			return 1;
 		}
 
+		if (CONFIG_IS_ENABLED(FIT_SIGNATURE) &&
+		    fit_all_configurations_verify(hdr) != 0) {
+			puts("Signature verification failed!\n");
+			unmap_sysmem(hdr);
+			return 1;
+		}
+
 		unmap_sysmem(hdr);
 		return 0;
 #endif
diff --git a/include/image.h b/include/image.h
index 34efac6056d..7948090f6e0 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1355,6 +1355,7 @@ static inline int fit_config_verify(const void *fit, int conf_noffset)
 }
 #endif
 int fit_all_image_verify(const void *fit);
+int fit_all_configurations_verify(const void *fit);
 int fit_config_decrypt(const void *fit, int conf_noffset);
 int fit_image_check_os(const void *fit, int noffset, uint8_t os);
 int fit_image_check_arch(const void *fit, int noffset, uint8_t arch);
-- 
2.43.0

base-commit: 9f61fd5b80a43ae20ba115e3a2933d47d720ab82
branch: us-qemu-signatures
