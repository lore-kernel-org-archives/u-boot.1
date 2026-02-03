Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399FBE8782A
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:36:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96E3D841F7;
	Tue,  3 Feb 2026 14:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="ah2ZaBXc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 873E1840B1; Tue,  3 Feb 2026 14:08:54 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9762983FFA
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 14:08:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 68AAB26369;
 Tue,  3 Feb 2026 14:08:52 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ks3vgsNOsjEV; Tue,  3 Feb 2026 14:08:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1770124131; bh=nDnFj4h0nuJCNbmKKCuDO0WRogBzgmS3oIGTvuve1fI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ah2ZaBXc255w8XfK07hcW9yOQdS8Fo8fj5CWAQt2Fw2Wdk1+armB/+vR7kaCdQfkE
 ILgSNExGX3FzxKEavJ5YGwhSUBHD7RXvVyeeVXMUEAhjUXpWYxyRWde2lJaWsSdjLP
 yqd3XEWNW3w/DyWk0OakxA2rbPX+yxB3Q5ei6VX4MYNZfgueIBHxM4ryZfi/nWkpjv
 +RPOXyp19FnkrJGh7I6Y+HEjpUMluA+91a4tuuGUIF8tmf7NhvbNqo+LItyhaf2XDX
 fQ3l+XgRtcUxUoHUx7IX3R7niZfL+cvM7gPUYADoUBiZQDy8w2CpP+8nDCOY4Mqqgr
 XcXixuj0rgG3Q==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 03 Feb 2026 18:38:40 +0530
Subject: [PATCH 02/11] board: samsung: exynos-mobile: resolve env vars
 without board_info data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-exynos-mobile-external-dtb-v1-2-a16a0e57991c@disroot.org>
References: <20260203-exynos-mobile-external-dtb-v1-0-a16a0e57991c@disroot.org>
In-Reply-To: <20260203-exynos-mobile-external-dtb-v1-0-a16a0e57991c@disroot.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Tue, 03 Feb 2026 14:35:06 +0100
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

Move environment variable setup procedure to exynos_env_setup(). This
function is independent of data from exynos_board_info as it is due for
removal in the succeding commits.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 board/samsung/exynos-mobile/exynos-mobile.c | 89 +++++++++++++++++++++++------
 1 file changed, 72 insertions(+), 17 deletions(-)

diff --git a/board/samsung/exynos-mobile/exynos-mobile.c b/board/samsung/exynos-mobile/exynos-mobile.c
index 915bda64082..c17d7052b1c 100644
--- a/board/samsung/exynos-mobile/exynos-mobile.c
+++ b/board/samsung/exynos-mobile/exynos-mobile.c
@@ -18,6 +18,7 @@
 #include <lmb.h>
 #include <part.h>
 #include <stdbool.h>
+#include <string.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -213,6 +214,76 @@ static void exynos_parse_dram_banks(const void *fdt_base)
 	}
 }
 
+static void exynos_env_setup(void)
+{
+	const char *bootargs = exynos_prev_bl_get_bootargs();
+	const char *dev_compatible, *soc_compatible;
+	char *ptr;
+	char buf[128];
+	int nr_compatibles;
+	int offset;
+	int ret;
+
+	if (bootargs) {
+		/* Read the cmdline property which stores the serial number. */
+		ret = cmdline_get_arg(bootargs, "androidboot.serialno", &offset);
+		if (ret > 0) {
+			strlcpy(buf, bootargs + offset, ret);
+			env_set("serial#", buf);
+		}
+	}
+
+	nr_compatibles = ofnode_read_string_count(ofnode_root(), "compatible");
+	if (nr_compatibles < 2) {
+		log_warning("%s: expected 2 or more compatible strings\n",
+			    __func__);
+		return;
+	}
+
+	ret = ofnode_read_string_index(ofnode_root(), "compatible",
+				       nr_compatibles - 1, &soc_compatible);
+	if (ret) {
+		log_warning("%s: failed to read SoC compatible\n",
+			    __func__);
+		return;
+	}
+
+	ret = ofnode_read_string_index(ofnode_root(), "compatible", 0,
+				       &dev_compatible);
+	if (ret) {
+		log_warning("%s: failed to read device compatible\n",
+			    __func__);
+		return;
+	}
+
+	/* <manufacturer>,<soc> => platform = <soc> */
+	ptr = strchr(soc_compatible, ',');
+	if (ptr)
+		soc_compatible = ptr + 1;
+	env_set("platform", soc_compatible);
+
+	/* <manufacturer>,<codename> => board = <manufacturer>-<codename> */
+	strlcpy(buf, dev_compatible, sizeof(buf) - 1);
+	ptr = strchr(buf, ',');
+	if (ptr)
+		*ptr = '-';
+	env_set("board", buf);
+
+	/*
+	 * NOTE: Board name usually goes as <manufacturer>-<codename>, but
+	 * upstream device trees for Exynos SoCs are <soc>-<codename>.
+	 * Extraction of <codename> from the board name is required.
+	 */
+	ptr = strchr(dev_compatible, ',');
+	if (ptr)
+		dev_compatible = ptr + 1;
+
+	/* EFI booting requires the path to correct DTB, specify it here. */
+	snprintf(buf, sizeof(buf), "exynos/%s-%s.dtb", soc_compatible,
+		 dev_compatible);
+	env_set("fdtfile", buf);
+}
+
 static int exynos_fastboot_setup(void)
 {
 	struct blk_desc *blk_dev;
@@ -371,23 +442,7 @@ int board_init(void)
 
 int misc_init_r(void)
 {
-	const struct exynos_board_info *board_info;
-	char buf[128];
-
-	if (!gd->board_type)
-		return -ENODATA;
-	board_info = (const struct exynos_board_info *)gd->board_type;
-
-	env_set("platform", board_info->chip);
-	env_set("board", board_info->name);
-
-	if (strlen(board_info->serial))
-		env_set("serial#", board_info->serial);
-
-	/* EFI booting requires the path to correct dtb, specify it here. */
-	snprintf(buf, sizeof(buf), "exynos/%s-%s.dtb", board_info->chip,
-		 board_info->name);
-	env_set("fdtfile", buf);
+	exynos_env_setup();
 
 	return exynos_fastboot_setup();
 }

-- 
2.52.0

