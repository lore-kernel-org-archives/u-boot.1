Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B23CCD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 05:34:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF07488A75;
	Mon,  2 Sep 2024 07:33:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D57F8888D7; Mon,  2 Sep 2024 07:33:37 +0200 (CEST)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF84588A1D
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 07:33:32 +0200 (CEST)
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
Subject: [PATCH 1/4] lib: ecdsa: Add ECDSA384 support
Date: Mon, 2 Sep 2024 13:33:23 +0800
Message-ID: <20240902053326.3273410-2-chiawei_wang@aspeedtech.com>
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

Add ECDSA384 algorithm support for image signing and verification.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 include/u-boot/ecdsa.h   |  1 +
 lib/ecdsa/ecdsa-verify.c | 14 +++++++++++---
 tools/image-sig-host.c   |  7 +++++++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/u-boot/ecdsa.h b/include/u-boot/ecdsa.h
index 53490c6b287..0d4df9887e6 100644
--- a/include/u-boot/ecdsa.h
+++ b/include/u-boot/ecdsa.h
@@ -65,5 +65,6 @@ int ecdsa_verify(struct image_sign_info *info,
 /** @} */
 
 #define ECDSA256_BYTES	(256 / 8)
+#define ECDSA384_BYTES	(384 / 8)
 
 #endif
diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
index 4d1835b598a..629b662cf6c 100644
--- a/lib/ecdsa/ecdsa-verify.c
+++ b/lib/ecdsa/ecdsa-verify.c
@@ -22,8 +22,10 @@ static int ecdsa_key_size(const char *curve_name)
 {
 	if (!strcmp(curve_name, "prime256v1"))
 		return 256;
-	else
-		return 0;
+	else if (!strcmp(curve_name, "secp384r1"))
+		return 384;
+
+	return 0;
 }
 
 static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
@@ -121,12 +123,18 @@ int ecdsa_verify(struct image_sign_info *info,
 	return ecdsa_verify_hash(dev, info, hash, sig, sig_len);
 }
 
-U_BOOT_CRYPTO_ALGO(ecdsa) = {
+U_BOOT_CRYPTO_ALGO(ecdsa256) = {
 	.name = "ecdsa256",
 	.key_len = ECDSA256_BYTES,
 	.verify = ecdsa_verify,
 };
 
+U_BOOT_CRYPTO_ALGO(ecdsa384) = {
+	.name = "ecdsa384",
+	.key_len = ECDSA384_BYTES,
+	.verify = ecdsa_verify,
+};
+
 /*
  * uclass definition for ECDSA API
  *
diff --git a/tools/image-sig-host.c b/tools/image-sig-host.c
index d0133aec4c8..22253502065 100644
--- a/tools/image-sig-host.c
+++ b/tools/image-sig-host.c
@@ -76,6 +76,13 @@ struct crypto_algo crypto_algos[] = {
 		.add_verify_data = ecdsa_add_verify_data,
 		.verify = ecdsa_verify,
 	},
+	{
+		.name = "ecdsa384",
+		.key_len = ECDSA384_BYTES,
+		.sign = ecdsa_sign,
+		.add_verify_data = ecdsa_add_verify_data,
+		.verify = ecdsa_verify,
+	},
 };
 
 struct padding_algo padding_algos[] = {
-- 
2.25.1

