Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B94E7D0A4
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 18:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 227DC86784;
	Thu, 21 Sep 2023 20:45:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695321910;
	bh=LkE6R/xIskgwNpWjRLdeOXCP6m0rIdwpJohxR2qpQgc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nZ8BNYe++irbRU9l8OH/Awm7r6QoaxxfhDnq2lqtOlzVu6shtl5Jw61o59Rkh76gz
	 QmcBvp/vuQvY4qQCAgA94N1yQRP9qiutaSe7VegND3zGSZIEWhcmb2s6xxNDGo0s0o
	 Mq47Cnma/Uh03h+RvHx0BpG/H16bL8IYg4q8TzHUAUPVYOoQacl9p4neBXZlF0wWr5
	 ASjW5LRLvpWcQwonOKMhrhJfLRnYbWERo2Pq9h9/F/5gojaXNRKS2UHgLiUKKQXxHn
	 yFAqHCyRUXDBYoma9/5R5g8WxjikYszRMfpweODi2MB1SreQF5vPXzQiBHp03epc9U
	 5TtOmgOGsaMoA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A67138645F;
 Thu, 21 Sep 2023 20:45:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1695321909;
 bh=LkE6R/xIskgwNpWjRLdeOXCP6m0rIdwpJohxR2qpQgc=;
 h=From:To:Cc:Subject:Date:From;
 b=r2XDZ6fTbIXTs2LsZvB4vU3gpmn1+2EfN8+1XQLKOkgOeBT5KocLpP9+52UmbqbLn
 x0tHPic1OJBrjXyWJ3s4/ou496OV4H5OfWx+1XpKN8tu4aX7hFNJQcyEvD8JzRLbYp
 jJlGlH8QXukoxZkNseH1WgSXl3yDtAQ1k4wGhgPqPIZv7RR8fxqxK3ilGMOFUTIo0n
 FEB9x0VHMWdqS2Z27wn0ulGppQa0j9jMfi33Hty7CkpfCBhLX3+ZO3Ja9+GUdzth4O
 nlHqcO0t1uZ9sl+Zn46JPtVAfAMZbBcwekjLAXuOXoekJLzbhy5XR2N7dgswdtr+7M
 WosjnEkEITBaQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Fabio Estevam <festevam@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Ovidiu Panait <ovpanait@gmail.com>, Roger Quadros <rogerq@kernel.org>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com
Subject: [PATCH 1/5] spl: fit: Add board level function to decide application
 of DTO
Date: Thu, 21 Sep 2023 20:44:16 +0200
Message-Id: <20230921184420.45186-1-marex@denx.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add board-specific function used to indicate whether a DTO from fitImage
configuration node 'fdt' property DT and DTO list should be applied onto
the base DT or not applied.

This is useful in case of DTOs which implement e.g. different board revision
details, where such DTO should be applied on one board revision, and should
not be applied on another board revision.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Cc: Ovidiu Panait <ovpanait@gmail.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@dh-electronics.com
---
 common/spl/spl_fit.c | 23 ++++++++++++++++++++---
 include/spl.h        | 16 ++++++++++++++++
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 730639f7562..ed91ddd6b40 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -357,6 +357,11 @@ static bool os_takes_devicetree(uint8_t os)
 	}
 }
 
+__weak int board_spl_fit_append_fdt_skip(const char *name)
+{
+	return 0;	/* Do not skip */
+}
+
 static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 			      struct spl_load_info *info, ulong sector,
 			      const struct spl_fit_info *ctx)
@@ -400,11 +405,23 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 		void *tmpbuffer = NULL;
 
 		for (; ; index++) {
-			node = spl_fit_get_image_node(ctx, FIT_FDT_PROP, index);
-			if (node == -E2BIG) {
+			const char *str;
+
+			ret = spl_fit_get_image_name(ctx, FIT_FDT_PROP, index, &str);
+			if (ret == -E2BIG) {
 				debug("%s: No additional FDT node\n", __func__);
+				ret = 0;
 				break;
-			} else if (node < 0) {
+			} else if (ret < 0) {
+				continue;
+			}
+
+			ret = board_spl_fit_append_fdt_skip(str);
+			if (ret)
+				continue;
+
+			node = fdt_subnode_offset(ctx->fit, ctx->images_node, str);
+			if (node < 0) {
 				debug("%s: unable to find FDT node %d\n",
 				      __func__, index);
 				continue;
diff --git a/include/spl.h b/include/spl.h
index 92bcaa90a4a..60a432c4b15 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -895,6 +895,22 @@ void spl_perform_fixups(struct spl_image_info *spl_image);
  */
 struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size);
 
+/**
+ * board_spl_fit_append_fdt_skip(): test whether DTO application should be skipped
+ * @name:	DTO node name within fitImage images node
+ *
+ * A board-specific function used to indicate whether a DTO from fitImage
+ * configuration node 'fdt' property DT and DTO list should be applied onto
+ * the base DT or not applied.
+ *
+ * This is useful in case of DTOs which implement e.g. different board revision
+ * details, where such DTO should be applied on one board revision, and should
+ * not be applied on another board revision.
+ *
+ * Return:	0 to indicate DTO is not skipped, all else to indicate DTO is skipped.
+ */
+int board_spl_fit_append_fdt_skip(const char *name);
+
 void board_boot_order(u32 *spl_boot_list);
 void spl_save_restore_data(void);
 #endif
-- 
2.40.1

