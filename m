Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89587C83F15
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 12:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE04D88BF7;
	Thu, 29 Aug 2024 14:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pritschet.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=pritschet.eu header.i=@pritschet.eu header.b="pHwOOMzj";
	dkim=permerror (0-bit key) header.d=pritschet.eu header.i=@pritschet.eu header.b="44toNygJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B0EA88BF7; Thu, 29 Aug 2024 14:45:11 +0200 (CEST)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24AE688953
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 14:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pritschet.eu
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=matthias@pritschet.eu
ARC-Seal: i=1; a=rsa-sha256; t=1724935508; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=fEUTWy0xYucd3oDzvXoadlcwFfgH3OCYijyF23NNfBY1TyDY8RrjnNQpDbmgjyEaBo
 mvVAcY6GB7IX94l3BMCOfnuWP6yKyU/BYEFV2hkmdoeDrxXdn68lVQWKftf955PttpoG
 FTFSjIeNHVjTlVMmqzZ45Z1y5YeK2CLW3PqOLKEGVlRJjU7CYbejuNORuOdfjM82GDV0
 +ZaEgeGvxmDIzcsRGWYFe5BG9EzrOfPxi39rsOu48irFZdWvps664/b3aXlB+rRARxnK
 F2HDlHwK9StJH/OzTXSsO0cOV1GcKHS8rRhjep3NwwE2iarNHIwR/91Q/yalTnLA8TX/
 4t5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1724935508;
 s=strato-dkim-0002; d=strato.com;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=ASKCOtMpYFFh0+khqICmzItNdexZipWLHwSF+wgf/J4=;
 b=kk/7C/ZqZwaoQYOpMcYT/UL1sCqUUNiUysRk02Nof6d7K3FKX++ZpGQj42g3A46aGV
 Xgcn1k7FE1jTxBkqDt3t5cJQ5OMHQnbOYbhaBvcsm+9zW/s3dyEGBs0zDufHSuwCxFKL
 STlbtdVKAD/ZxYPUM+YBh7Qvnd1G/DF/SizuNsEwWWOxsIwRkW+to02Wou3m4BxHnaRp
 rQh+d0VwoFZhr6cAW2cBxx4BlvbOxR2QUIQoC2UOtraYU7F1Ne0k3VvDi360O2ZB8jfJ
 eooOoh5SeHaOD+PhvZQjL+b1uXtEQDr+1lRVmnf4gAG9mbcuh1bShKhPFHLUaLMT2m6G
 j5Sw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1724935508;
 s=strato-dkim-0002; d=pritschet.eu;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=ASKCOtMpYFFh0+khqICmzItNdexZipWLHwSF+wgf/J4=;
 b=pHwOOMzj2If4EbJhc7ujTlvZcUxrqMO18WXRUAK7TRQPPsSMZHuZLDbxy8/91zEf74
 WED/GJ+bIWf6P/USFFSao9Sw3nZ3wJJDxtLdgN8dwjXLGbq1GzbyZQQqeZYorvB1hPBq
 mJOZij1GF2fHf+0nau7D+O6mNCIUJQ8Sn1M7UX0TLB2MfTIn7CR3X6LBQYh+TTKMV7Se
 p94nA7JbWbl2cx/pKSHw+UAV1Q2pdUtMHdOf4a/7JqQZduhFMGiKTJ1X6U1l1bhYJTkb
 qmk0DSutK4qVOYymQU/SueRG7LHvbAWVVGCwXnfHzAbezgm8hHrcQTjGXURtGz7dj+7P
 sCrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1724935508;
 s=strato-dkim-0003; d=pritschet.eu;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=ASKCOtMpYFFh0+khqICmzItNdexZipWLHwSF+wgf/J4=;
 b=44toNygJB2jajY6y7rLbJD5CIHuoqPzRgRGHDSOTVd1su/STdf/6sRDdr8UYMyzWNM
 QmPIMhKXyujL+Wf+zlAw==
X-RZG-AUTH: ":IW0QYUiheuxX18P29qqHt/qCfjagLCCd1qyzKexpcQi1jQNsuxOyhTejoQQ4wC2Bp2/bdTC02FQEAl7eTc3J8M8FnIwqKAofPvalCcY="
Received: from nibbler.fritz.box by smtp.strato.de (RZmta 51.2.3 AUTH)
 with ESMTPSA id Yed7a707TCj7xsU
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Thu, 29 Aug 2024 14:45:07 +0200 (CEST)
From: Matthias Pritschet <matthias@pritschet.eu>
To: u-boot@lists.denx.de
Cc: Matthias Pritschet <matthias.pritschet@itk-engineering.de>
Subject: [PATCH] mkimage: ecdsa: add nodes to signature/key node
Date: Thu, 29 Aug 2024 14:44:47 +0200
Message-Id: <20240829124447.46451-1-matthias@pritschet.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
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

Add the "required", "algo", and "key-name-hint" nodes to the
signature/key node if ecdsa256 is used.

This change is mainly copy&paste from rsa_add_verify_data which already
adds these nodes.

Signed-off-by: Matthias Pritschet <matthias.pritschet@itk-engineering.de>
---
 lib/ecdsa/ecdsa-libcrypto.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index db0a828a29..4513703d08 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -272,7 +272,8 @@ int ecdsa_verify(struct image_sign_info *info,
 	return ret;
 }
 
-static int do_add(struct signer *ctx, void *fdt, const char *key_node_name)
+static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
+		  struct image_sign_info *info)
 {
 	int signature_node, key_node, ret, key_bits;
 	const char *curve_name;
@@ -322,6 +322,11 @@ static int do_add(struct signer *ctx, void *fdt, const char *key_node_name)
 	point = EC_KEY_get0_public_key(ctx->ecdsa_key);
 	EC_POINT_get_affine_coordinates(group, point, x, y, NULL);
 
+	ret = fdt_setprop_string(fdt, key_node, FIT_KEY_HINT,
+				 info->keyname);
+	if (ret < 0)
+		return ret;
+
 	ret = fdt_setprop_string(fdt, key_node, "ecdsa,curve", curve_name);
 	if (ret < 0)
 		return ret;
@@ -334,6 +339,16 @@ static int do_add(struct signer *ctx, void *fdt, const char *key_node_name)
 	if (ret < 0)
 		return ret;
 
+	ret = fdt_setprop_string(fdt, key_node, FIT_ALGO_PROP,
+				 info->name);
+	if (ret < 0)
+		return ret;
+
+	ret = fdt_setprop_string(fdt, key_node, FIT_KEY_REQUIRED,
+				 info->require_keys);
+	if (ret < 0)
+		return ret;
+
 	return key_node;
 }
 
@@ -346,7 +361,7 @@ int ecdsa_add_verify_data(struct image_sign_info *info, void *fdt)
 	fdt_key_name = info->keyname ? info->keyname : "default-key";
 	ret = prepare_ctx(&ctx, info);
 	if (ret >= 0){
-		ret = do_add(&ctx, fdt, fdt_key_name);
+		ret = do_add(&ctx, fdt, fdt_key_name, info);
 		if (ret < 0)
 			ret = ret == -FDT_ERR_NOSPACE ? -ENOSPC : -EIO;
 	}
-- 
2.34.1

