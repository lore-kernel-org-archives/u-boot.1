Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5D1C43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 02:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBE1E84CD1;
	Tue, 14 Jul 2026 04:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B70BF84CD1; Tue, 14 Jul 2026 04:33:54 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCE3984CCA
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 04:33:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wjSxo-000000002F4-3RGi; Tue, 14 Jul 2026 02:33:40 +0000
Date: Tue, 14 Jul 2026 03:33:38 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Ludwig Nussel <ludwig.nussel@siemens.com>, Anton Ivanov <anton@binarly.io>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: [PATCH v2 1/3] boot: fit: factor out node-path collection in
 fit_config_add_hash()
Message-ID: <4c13afc8a9b3e2cc7af563b7fe9c45aa9ce10916.1783995924.git.daniel@makrotopia.org>
References: <cover.1783995924.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783995924.git.daniel@makrotopia.org>
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

fit_config_add_hash() repeats the same sequence to append a node's path
to the hashed-node list three times: for the image node, for each hash
subnode and for the cipher subnode. Extract it into a helper,
fit_config_add_node(), with no functional change.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
v2: no changes

 boot/image-fit-sig.c | 73 ++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 29 deletions(-)

diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index 9b5ab754561..513ee9cc16a 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -230,6 +230,37 @@ int fit_image_verify_required_sigs(const void *fit, int image_noffset,
 	return 0;
 }
 
+/**
+ * fit_config_add_node() - Append one node's path to the hashed-node list
+ *
+ * @fit:		FIT blob
+ * @noffset:		Offset of the node whose path should be added
+ * @node_inc:		Array of path pointers to fill
+ * @count:		Pointer to current count (updated on return)
+ * @max_nodes:		Maximum entries in @node_inc
+ * @buf:		Buffer for packed path strings
+ * @buf_used:		Pointer to bytes used in @buf (updated on return)
+ * @buf_len:		Total size of @buf
+ * Return: 0 on success, -ve on error
+ */
+static int fit_config_add_node(const void *fit, int noffset, char **node_inc,
+			       int *count, int max_nodes, char *buf,
+			       int *buf_used, int buf_len)
+{
+	int ret, len;
+
+	if (*count >= max_nodes)
+		return -ENOSPC;
+	ret = fdt_get_path(fit, noffset, buf + *buf_used, buf_len - *buf_used);
+	if (ret < 0)
+		return -ENOENT;
+	len = strlen(buf + *buf_used) + 1;
+	node_inc[(*count)++] = buf + *buf_used;
+	*buf_used += len;
+
+	return 0;
+}
+
 /**
  * fit_config_add_hash() - Add hash nodes for one image to the node list
  *
@@ -250,18 +281,12 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
 			       char **node_inc, int *count, int max_nodes,
 			       char *buf, int *buf_used, int buf_len)
 {
-	int noffset, hash_count, ret, len;
+	int noffset, hash_count, ret;
 
-	if (*count >= max_nodes)
-		return -ENOSPC;
-
-	ret = fdt_get_path(fit, image_noffset, buf + *buf_used,
-			   buf_len - *buf_used);
-	if (ret < 0)
-		return -ENOENT;
-	len = strlen(buf + *buf_used) + 1;
-	node_inc[(*count)++] = buf + *buf_used;
-	*buf_used += len;
+	ret = fit_config_add_node(fit, image_noffset, node_inc, count,
+				  max_nodes, buf, buf_used, buf_len);
+	if (ret)
+		return ret;
 
 	/* Add all this image's hash subnodes */
 	hash_count = 0;
@@ -273,15 +298,10 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
 		if (strncmp(name, FIT_HASH_NODENAME,
 			    strlen(FIT_HASH_NODENAME)))
 			continue;
-		if (*count >= max_nodes)
-			return -ENOSPC;
-		ret = fdt_get_path(fit, noffset, buf + *buf_used,
-				   buf_len - *buf_used);
-		if (ret < 0)
-			return -ENOENT;
-		len = strlen(buf + *buf_used) + 1;
-		node_inc[(*count)++] = buf + *buf_used;
-		*buf_used += len;
+		ret = fit_config_add_node(fit, noffset, node_inc, count,
+					  max_nodes, buf, buf_used, buf_len);
+		if (ret)
+			return ret;
 		hash_count++;
 	}
 
@@ -296,15 +316,10 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
 	if (noffset != -FDT_ERR_NOTFOUND) {
 		if (noffset < 0)
 			return -EIO;
-		if (*count >= max_nodes)
-			return -ENOSPC;
-		ret = fdt_get_path(fit, noffset, buf + *buf_used,
-				   buf_len - *buf_used);
-		if (ret < 0)
-			return -ENOENT;
-		len = strlen(buf + *buf_used) + 1;
-		node_inc[(*count)++] = buf + *buf_used;
-		*buf_used += len;
+		ret = fit_config_add_node(fit, noffset, node_inc, count,
+					  max_nodes, buf, buf_used, buf_len);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-- 
2.55.0
