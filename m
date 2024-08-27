Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0622EC5472F
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 17:52:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 424D98857C;
	Tue, 27 Aug 2024 19:52:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pritschet.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=pritschet.eu header.i=@pritschet.eu header.b="CyKIeLp4";
	dkim=permerror (0-bit key) header.d=pritschet.eu header.i=@pritschet.eu header.b="yIJEC4X7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D3DE88986; Tue, 27 Aug 2024 18:01:15 +0200 (CEST)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5269587C80
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:01:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pritschet.eu
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=matthias@pritschet.eu
ARC-Seal: i=1; a=rsa-sha256; t=1724774472; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=VRdOKZnXk0MaSkwFh3At502ao6xdSgeJMYMfA9CwxYSSaGKeP8TUNX3D0aaDdBhzaS
 Z+h1GkTzOh6bF1imv/VkCndmLJ8FRWswPnsGkhLCjHSqSC0ABRFKyGxinaaoUb0n4Saj
 i/e75eVxaDiC7aCwcFgnzpnjEHSULdrmblcbJg/YcDPuZsq8/uuCb+8ZbU7Fzeq3vVe5
 e3pzyR1gauCkIomIxMyBLmg2KrdNtYcnYA5HMwbW/LEQFUGhlpQrrwcRjoXaxZQxYb6e
 ETz0UIR2umqVtqJVPVB2BRiT5BSNhugIdEr3SKf9G23kCVKi5T5Nr6h3FrOG7BScm8WS
 mEoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1724774472;
 s=strato-dkim-0002; d=strato.com;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=95Fyep3drS9s1dhqgtRZmDy+HBxc19JgvJmNgWnBMm4=;
 b=ibNBS8py85cEyIrT7ZrCXHeMvgs81xXfYwwUKlT2K6v7glHDOnpZJ6C7hqtpKgYCQu
 vuN2mEpGdVABsGl+UsaUIgYFZwHFmSOoeU49YUjvrrhYuZsxzXRARYq+WV01EM1iiRDG
 /5M+dMkamnDZ1oIbV7P/lJjKcPy6jsBdBVyC4P8wffbxOBUAh9XU0v+8+pjfalQDEdE9
 nmVrRhLyMnZ81eT7yHXmD6mTnk3EC7qhnmgI/etyace6OIz1Tnyn3Ff4ymwWKOqgAp4/
 bAYoCcwCq7OHAdZKKlgpZtXCf2yiCKyLhOKyVFV1YtapM9Oi3zxQO1oZ1wVwK32Yeocu
 WVLw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1724774472;
 s=strato-dkim-0002; d=pritschet.eu;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=95Fyep3drS9s1dhqgtRZmDy+HBxc19JgvJmNgWnBMm4=;
 b=CyKIeLp4wJwUmWzLW4EA0GnRM/SJsTpXwQgwtELOXUbTLI8hXV9cqEU2O77N03NSrX
 rcfP9yhVemUdVxJdtLpsk/06aUPLTzBX3SG5vFEiFaaI1ZCjBZS2boSAHReVQNPeHd4d
 sOhoq7Fte59pwGw0OpOY8XD9mVKQHL+nE3EkSFzBJHQJleztIFpZ7GXxWpq1wxPII6zH
 C99Uk/eflAkPUs6gKmMHZc/RyC2xvzD/VQi1IBsFK3PrXsh7t2sUDRwsaLSJ7FYUqUJz
 BV9acrSSv6JF014FJH4vTdgRhxIrkWQ+tjAnsrlGbLI/1c84sM/qXCQ7iVPAJnfgSKhp
 k9KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1724774472;
 s=strato-dkim-0003; d=pritschet.eu;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=95Fyep3drS9s1dhqgtRZmDy+HBxc19JgvJmNgWnBMm4=;
 b=yIJEC4X7PxvwtqjCU2Oiw6nFCyksJ5AGFxCrl/eFli0+jB3YlvQDUKcPPG5TWIDxkT
 if1xQbkgSqHwlP1up9Bw==
X-RZG-AUTH: ":IW0QYUiheuxX18P29qqHt/qCfjagLCCd1qyzKexpcQi1jQNsuxOyhTejoQQ4wC2Bp2zYdWPg2FSPpHM+R6p3ahxC/QcEhi5P8D3O92w="
Received: from nibbler.fritz.box by smtp.strato.de (RZmta 51.2.3 AUTH)
 with ESMTPSA id Yed7a707RG1Coal
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 27 Aug 2024 18:01:12 +0200 (CEST)
From: Matthias Pritschet <matthias@pritschet.eu>
To: u-boot@lists.denx.de
Cc: Matthias Pritschet <matthias.pritschet@itk-engineering.de>
Subject: [PATCH] mkimage: ecdsa: add signature/key nodes to dtb if missing
Date: Tue, 27 Aug 2024 18:00:54 +0200
Message-Id: <20240827160054.26819-1-matthias@pritschet.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Mailman-Approved-At: Tue, 27 Aug 2024 19:52:05 +0200
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

From: Matthias Pritschet <matthias.pritschet@itk-engineering.de>

If the signature/key node(s) are not yet present in the U-Boot device
tree, ecdsa_add_verify_data simply fails if it can't find the nodes.
This behaviour differs from rsa_add_verify_data, wich does add the missing
nodes and proceeds in that case.

This change is mainly copy&paste from rsa_add_verify_data to add the
same behaviour to ecdsa_add_verify_data.

Signed-off-by: Matthias Pritschet <matthias.pritschet@itk-engineering.de>
---
 lib/ecdsa/ecdsa-libcrypto.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index 5fa9be10b4..db0a828a29 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -281,16 +281,35 @@ static int do_add(struct signer *ctx, void *fdt, const char *key_node_name)
 	BIGNUM *x, *y;
 
 	signature_node = fdt_subnode_offset(fdt, 0, FIT_SIG_NODENAME);
-	if (signature_node < 0) {
-		fprintf(stderr, "Could not find 'signature node: %s\n",
+	if (signature_node == -FDT_ERR_NOTFOUND) {
+		signature_node = fdt_add_subnode(fdt, 0, FIT_SIG_NODENAME);
+		if (signature_node < 0) {
+			if (signature_node != -FDT_ERR_NOSPACE) {
+				fprintf(stderr, "Couldn't create signature node: %s\n",
+					fdt_strerror(signature_node));
+			}
+			return signature_node;
+		}
+	} else if (signature_node < 0) {
+		fprintf(stderr, "Cannot select keys signature_node: %s\n",
 			fdt_strerror(signature_node));
 		return signature_node;
 	}
 
-	key_node = fdt_add_subnode(fdt, signature_node, key_node_name);
-	if (key_node < 0) {
-		fprintf(stderr, "Could not create '%s' node: %s\n",
-			key_node_name, fdt_strerror(key_node));
+	/* Either create or overwrite the named key node */
+	key_node = fdt_subnode_offset(fdt, signature_node, key_node_name);
+	if (key_node == -FDT_ERR_NOTFOUND) {
+		key_node = fdt_add_subnode(fdt, signature_node, key_node_name);
+		if (key_node < 0) {
+			if (key_node != -FDT_ERR_NOSPACE) {
+				fprintf(stderr, "Could not create key subnode: %s\n",
+					fdt_strerror(key_node));
+			}
+			return key_node;
+		}
+	} else if (key_node < 0) {
+		fprintf(stderr, "Cannot select keys key_node: %s\n",
+			fdt_strerror(key_node));
 		return key_node;
 	}
 
@@ -326,8 +345,11 @@ int ecdsa_add_verify_data(struct image_sign_info *info, void *fdt)
 
 	fdt_key_name = info->keyname ? info->keyname : "default-key";
 	ret = prepare_ctx(&ctx, info);
-	if (ret >= 0)
+	if (ret >= 0){
 		ret = do_add(&ctx, fdt, fdt_key_name);
+		if (ret < 0)
+			ret = ret == -FDT_ERR_NOSPACE ? -ENOSPC : -EIO;
+	}
 
 	free_ctx(&ctx);
 	return ret;
-- 
2.34.1

