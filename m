Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCECCD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 23:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D748C87E13;
	Thu, 11 Apr 2024 01:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="TfCnnZLe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3271287F1E; Thu, 11 Apr 2024 01:31:27 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CCA48772A
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 01:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 01AE23F14D; 
 Wed, 10 Apr 2024 23:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712791883;
 bh=K/yQZcYn0AMXVGizTKMIvzddqhebBvyu/oSc3rPROKQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=TfCnnZLe0X8CLk9WQTp3ZkmBo26F9ORQJz+KLYXezt/flVhO8W5dUjcelTtIKmPkG
 x71t7cOmk1+RPTSVBkVLYhmjVFo908/yM/Ir4nj6jYV2Qm7Ty5zT5nrUilynfYLKsF
 4B5M4h+F6R0frJd+gMyoT1uVfREuEx+KFkdCFgBxZbq9Vt3q+FMnctxR/zSkqqMGgX
 J11lbuiTU4ty9Gg9FeP1o/6I7oMVfxeRERGj9wFADRTOKUfYyxD9R+l3JGJqSrTp9V
 PmMcjDycBPR+QbIotCYwI3H4gxoXWBgA0D+MDFO5Bke44x9dkQv5xG2bMtw5TAIw0o
 sWxUShRAW6wFQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Hugo Cornelis <hugo.cornelis@essensium.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] tools: use adequate entropy source for initialization
 vector
Date: Thu, 11 Apr 2024 01:31:16 +0200
Message-ID: <20240410233116.57402-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

The random() function is unsafe to initialize cryptographic data.
Use getrandom() which reads from /dev/urandom instead.

getrandom() is available on Linux sine release 3.17 and on BSD.

Addresses-Coverity-ID: 312953 Calling risky function
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/image-host.c | 36 +++---------------------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index b2a0f2e6d16..d30a235baf6 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -13,11 +13,11 @@
 #include <fdt_region.h>
 #include <image.h>
 #include <version.h>
-
 #if CONFIG_IS_ENABLED(FIT_SIGNATURE)
 #include <openssl/pem.h>
 #include <openssl/evp.h>
 #endif
+#include <sys/random.h>
 
 /**
  * fit_set_hash_value - set hash value in requested has node
@@ -364,36 +364,6 @@ static int fit_image_read_key_iv_data(const char *keydir, const char *key_iv_nam
 	return ret;
 }
 
-static int get_random_data(void *data, int size)
-{
-	unsigned char *tmp = data;
-	struct timespec date;
-	int i, ret;
-
-	if (!tmp) {
-		fprintf(stderr, "%s: pointer data is NULL\n", __func__);
-		ret = -1;
-		goto out;
-	}
-
-	ret = clock_gettime(CLOCK_MONOTONIC, &date);
-	if (ret) {
-		fprintf(stderr, "%s: clock_gettime has failed (%s)\n", __func__,
-			strerror(errno));
-		goto out;
-	}
-
-	srandom(date.tv_nsec);
-
-	for (i = 0; i < size; i++) {
-		*tmp = random() & 0xff;
-		tmp++;
-	}
-
- out:
-	return ret;
-}
-
 static int fit_image_setup_cipher(struct image_cipher_info *info,
 				  const char *keydir, void *fit,
 				  const char *image_name, int image_noffset,
@@ -465,8 +435,8 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
 		if (ret < 0)
 			goto out;
 	} else {
-		/* Generate an ramdom IV */
-		ret = get_random_data((void *)info->iv, info->cipher->iv_len);
+		/* Generate a ramdom initialization vector */
+		ret = getrandom((void *)info->iv, info->cipher->iv_len, 0);
 	}
 
  out:
-- 
2.43.0

