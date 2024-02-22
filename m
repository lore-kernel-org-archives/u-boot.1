Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF01C48BF8
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 13:09:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F91F880BA;
	Thu, 22 Feb 2024 14:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gH8VXAOd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9E93880BA; Thu, 22 Feb 2024 14:08:35 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DD22880AC
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 14:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41MD8JAD129376;
 Thu, 22 Feb 2024 07:08:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708607299;
 bh=ZJGb08Vr84bCQ3MHM6cFbff+B5FS/o7q0UOdQPRbH80=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=gH8VXAOdulTEH3w20NQbLkgG9C9kWW1KgJWREt4UjYG7RRn8PyFJ7Oc+3v5MCGSST
 X78zptwCQZ323E63T2BK9YT6k4ZwaB7noHUjTJi/tPB5rxb0Ay2pzIpCOfn0msGVc5
 ukc/AhH/nUTvdrlKL8NqM7EVEtLWD0mjy2kULYQg=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41MD8IUc020639
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 22 Feb 2024 07:08:18 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 07:08:18 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 07:08:18 -0600
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41MD8HJV081888;
 Thu, 22 Feb 2024 07:08:17 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>
CC: <bmeng@tinylab.org>, <xypron.glpk@gmx.de>, <patrick.delaunay@foss.st.com>, 
 <patrice.chotard@foss.st.com>, <hvilleneuve@dimonoff.com>,
 <michal.simek@amd.com>, <troykiskyboundary@gmail.com>,
 <j-humphreys@ti.com>, <afd@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
 <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH 3/4] boot: Move framebuffer reservation to separate helper
Date: Thu, 22 Feb 2024 18:38:10 +0530
Message-ID: <20240222130811.3878567-4-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222130811.3878567-1-devarsht@ti.com>
References: <20240222130811.3878567-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Create separate helper for just reserving framebuffer region without
creating or enabling simple-framebuffer node.

This is useful for scenarios where user want to preserve the bootloader
splash screen till OS boots up and display server gets started without
displaying anything else in between and thus not requiring
simple-framebuffer.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 boot/fdt_simplefb.c   | 12 +-----------
 boot/fdt_support.c    | 21 +++++++++++++++++++++
 include/fdt_support.h |  2 ++
 3 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/boot/fdt_simplefb.c b/boot/fdt_simplefb.c
index b0221eaf2a..837920bd3a 100644
--- a/boot/fdt_simplefb.c
+++ b/boot/fdt_simplefb.c
@@ -107,7 +107,6 @@ static int fdt_simplefb_enable_existing_node(void *blob)
 #if IS_ENABLED(CONFIG_VIDEO)
 int fdt_simplefb_enable_and_mem_rsv(void *blob)
 {
-	struct fdt_memory mem;
 	int ret;
 
 	/* nothing to do when video is not active */
@@ -118,15 +117,6 @@ int fdt_simplefb_enable_and_mem_rsv(void *blob)
 	if (ret)
 		return ret;
 
-	/* nothing to do when the frame buffer is not defined */
-	if (gd->video_bottom == gd->video_top)
-		return 0;
-
-	/* reserved with no-map tag the video buffer */
-	mem.start = gd->video_bottom;
-	mem.end = gd->video_top - 1;
-
-	return fdtdec_add_reserved_memory(blob, "framebuffer", &mem, NULL, 0, NULL,
-					  FDTDEC_RESERVED_MEMORY_NO_MAP);
+	return fdt_add_fb_mem_rsv(blob);
 }
 #endif
diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 090d82ee80..07aa7337e8 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -22,6 +22,9 @@
 #include <exports.h>
 #include <fdtdec.h>
 #include <version.h>
+#include <video.h>
+
+DECLARE_GLOBAL_DATA_PTR;
 
 /**
  * fdt_getprop_u32_default_node - Return a node's property or a default
@@ -2042,6 +2045,24 @@ int fdt_setup_simplefb_node(void *fdt, int node, u64 base_address, u32 width,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_VIDEO)
+int fdt_add_fb_mem_rsv(void *blob)
+{
+	struct fdt_memory mem;
+
+	/* nothing to do when the frame buffer is not defined */
+	if (gd->video_bottom == gd->video_top)
+		return 0;
+
+	/* reserved with no-map tag the video buffer */
+	mem.start = gd->video_bottom;
+	mem.end = gd->video_top - 1;
+
+	return fdtdec_add_reserved_memory(blob, "framebuffer", &mem, NULL, 0, NULL,
+					  FDTDEC_RESERVED_MEMORY_NO_MAP);
+}
+#endif
+
 /*
  * Update native-mode in display-timings from display environment variable.
  * The node to update are specified by path.
diff --git a/include/fdt_support.h b/include/fdt_support.h
index 25600d62f2..4b71b8948d 100644
--- a/include/fdt_support.h
+++ b/include/fdt_support.h
@@ -423,6 +423,8 @@ int arch_fixup_memory_node(void *blob);
 int fdt_setup_simplefb_node(void *fdt, int node, u64 base_address, u32 width,
 			    u32 height, u32 stride, const char *format);
 
+int fdt_add_fb_mem_rsv(void *blob);
+
 int fdt_overlay_apply_verbose(void *fdt, void *fdto);
 
 int fdt_valid(struct fdt_header **blobp);
-- 
2.34.1

