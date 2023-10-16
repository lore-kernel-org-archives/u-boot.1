Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5703BCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 12:51:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9207386BB3;
	Mon, 16 Oct 2023 14:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697460661;
	bh=cANVZncrAf3Ssba4HbP7v6h6COg5jy/kePxYKS6Ii0Y=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FTDKmmMCHDvmWHMffC5VFyKMZ1o8/FMDFu4JkbnBt1m1D4OCPyJ31YNOFnNNvDPNb
	 RpOxpgUu5bGbdCURZ2wF+naT+qNhzMc5DmE+CJs1WoF1TlA14fMMrNh1u5//NCulZo
	 V9KJq8Rx0QVrPVFy68h8C1zWgGjl22MfKI4UFL9Kvz7NTSc2IMeWK98uyTDifVSfPx
	 kSBa50LTZT8Rzxd2lt+cp33nXIAAWWtXwi/OEbQVpbsRSksBaMxn3YJddaVbqCmzjs
	 QuqxDQ7DrrCN/2jVgw8Ke0Odf6TERa71ovuD3SLp/ytBZMAasBnI37rw+7Xji5hlYw
	 A7+vz+/qZsiYg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C6825865A2;
 Mon, 16 Oct 2023 14:50:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697460660;
 bh=cANVZncrAf3Ssba4HbP7v6h6COg5jy/kePxYKS6Ii0Y=;
 h=From:To:Cc:Subject:Date:From;
 b=QTQLWApJs/yR3H08lNuZalckK+Q54TIVkUy58JEKinXUJ6nEutE8SJCwXC9tliVC1
 2FgkNwc3nzG6tT8Jnc/h158tTv5+5KTmHHH3u7/6cdD+RwCosWQsgLSuSkWFme6Wzq
 siJIC/VzvfyuxMjVHDaxo16nXE+/lD0HOLmfVodgCPlMOBCySAgz/MNzvvV750XN60
 sCthX/V6ru0LRmdDpvH9caukapxrekLIEuxputUJRaPKx3e4EOMdLfSmiK7UL+XKz4
 jO9qItcAZncVuYPrak4YD9f7h+ZVLm2Vbrt5lOHC3CRqWWyJfy/ySCf0tr484UkphU
 pxQBi7dwPNkaQ==
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
Subject: [PATCH v2 1/7] spl: fit: Add board level function to decide
 application of DTO
Date: Mon, 16 Oct 2023 14:50:02 +0200
Message-ID: <20231016125019.21583-1-marex@denx.de>
X-Mailer: git-send-email 2.42.0
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
V2: Rebase and collect the patches in one series
---
 common/spl/spl_fit.c | 23 ++++++++++++++++++++---
 include/spl.h        | 16 ++++++++++++++++
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index ce6b8aa370a..1409b926372 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -372,6 +372,11 @@ static bool os_takes_devicetree(uint8_t os)
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
@@ -414,11 +419,23 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
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
index 7d30fb57dac..1d416b4c929 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -918,6 +918,22 @@ void spl_perform_fixups(struct spl_image_info *spl_image);
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
 
-- 
2.42.0

