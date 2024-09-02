Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCD7CD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 05:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABBF088A13;
	Mon,  2 Sep 2024 07:33:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4B21888D7; Mon,  2 Sep 2024 07:33:36 +0200 (CEST)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58CAF88A2F
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 07:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chiawei_wang@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 2 Sep
 2024 13:33:26 +0800
Received: from mail.aspeedtech.com (192.168.10.152) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 2 Sep 2024 13:33:26 +0800
From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <bob.wolff68@gmail.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 2/4] lib: ecdsa: Create device tree node automatically
Date: Mon, 2 Sep 2024 13:33:24 +0800
Message-ID: <20240902053326.3273410-3-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902053326.3273410-1-chiawei_wang@aspeedtech.com>
References: <20240902053326.3273410-1-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Both the signature and the public key are stored as DTS nodes
in the FIT image and SPL/U-Boot DTBs.

Like the RSA signing & verification do, this patch either creates
the nodes or overwirte the content automatically.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 lib/ecdsa/ecdsa-libcrypto.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index 5fa9be10b4b..cd0c09ca6e4 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -281,15 +281,26 @@ static int do_add(struct signer *ctx, void *fdt, const char *key_node_name)
 	BIGNUM *x, *y;
 
 	signature_node = fdt_subnode_offset(fdt, 0, FIT_SIG_NODENAME);
-	if (signature_node < 0) {
-		fprintf(stderr, "Could not find 'signature node: %s\n",
-			fdt_strerror(signature_node));
-		return signature_node;
+	if (signature_node == -FDT_ERR_NOTFOUND) {
+		signature_node = fdt_add_subnode(fdt, 0, FIT_SIG_NODENAME);
+		if (signature_node < 0) {
+			fprintf(stderr, "Could not find 'signature node: %s\n",
+				fdt_strerror(signature_node));
+			return signature_node;
+		}
 	}
 
-	key_node = fdt_add_subnode(fdt, signature_node, key_node_name);
-	if (key_node < 0) {
-		fprintf(stderr, "Could not create '%s' node: %s\n",
+	/* Either create or overwrite the named key node */
+	key_node = fdt_subnode_offset(fdt, signature_node, key_node_name);
+	if (key_node == -FDT_ERR_NOTFOUND) {
+		key_node = fdt_add_subnode(fdt, signature_node, key_node_name);
+		if (key_node < 0) {
+			fprintf(stderr, "Could not create '%s' node: %s\n",
+				key_node_name, fdt_strerror(key_node));
+			return key_node;
+		}
+	} else if (key_node < 0) {
+		fprintf(stderr, "cannot select '%s' node: %s\n",
 			key_node_name, fdt_strerror(key_node));
 		return key_node;
 	}
-- 
2.25.1

