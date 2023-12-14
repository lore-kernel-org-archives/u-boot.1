Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D0AC4167D
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 12:12:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54C0E87A7A;
	Thu, 14 Dec 2023 13:11:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="UZ5iobR3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F356B87A70; Thu, 14 Dec 2023 13:11:49 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B594287A75
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 13:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
From: Alexander Dahl <ada@thorsis.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1702555904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i+qKHloild841IPwMxcQCQJpKaljMHW8FYSM4s3hypc=;
 b=UZ5iobR3/ZORIzw8ANNzBZzTM9mO7KdOsFgm3zvp8CDN2K9o2CRGrKTTIcCbOlnx7htVZY
 iiVt0pF0H+a4GydyP4GNc9UzXu4jb3+X+g6JTSHEm2JrFs23mxLN6qOaygkMLbWEYbl6YG
 H87izytwyk8HB0COg0bqCoKBFqhca9rOEscGwJUhyJmd31Ql+IJDMjEzMv7lkhvshGJHhO
 vbuVVVD/uNcF861bysZa6bOPECq3u0MG1FqwvuZ0g1Wu6gG01HLN6IYpkT6uZ/kVjoXvD5
 sRd2n+BE5tz6TwBx7pHFUNPYmHNFR1m7rNe+n9G/KR5c2DzVorg6ajnCNUValw==
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Terry Lv <terry.lv@nxp.com>
Subject: [PATCH v2 2/2] tools: fix build without LIBCRYPTO support
Date: Thu, 14 Dec 2023 13:11:36 +0100
Message-Id: <20231214121136.3286703-3-ada@thorsis.com>
In-Reply-To: <20231214121136.3286703-1-ada@thorsis.com>
References: <20231214121136.3286703-1-ada@thorsis.com>
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

From: Paul-Erwan Rio <paulerwan.rio@gmail.com>

Commit cb9faa6f98ae ("tools: Use a single target-independent config to
enable OpenSSL") introduced a target-independent configuration to build
crypto features in host tools.

But since commit 2c21256b27d7 ("hash: Use Kconfig to enable hashing in
host tools and SPL") the build without OpenSSL is broken, due to FIT
signature/encryption features. Add missing conditional compilation
tokens to fix this.

Signed-off-by: Paul-Erwan Rio <paulerwan.rio@gmail.com>
Tested-by: Alexander Dahl <ada@thorsis.com>
Cc: Simon Glass <sjg@chromium.org>
---

Notes:
    Added another guard around the header includes and slightly reworded the
    commit message.  Otherwise it's the same patch as before, so I kept the
    author as is and only added my Tested-by:
    I removed the Reviewed-by: from Simon from this patch, because of the
    changes mentioned and because the patch was based on an U-Boot three or
    four releases ago.

 include/image.h    | 2 +-
 tools/Kconfig      | 1 +
 tools/fit_image.c  | 2 +-
 tools/image-host.c | 4 ++++
 tools/mkimage.c    | 5 +++--
 5 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/image.h b/include/image.h
index 2e3cf839ee3..48b8a8995a4 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1391,7 +1391,7 @@ int calculate_hash(const void *data, int data_len, const char *algo,
  * device
  */
 #if defined(USE_HOSTCC)
-# if defined(CONFIG_FIT_SIGNATURE)
+# if CONFIG_IS_ENABLED(FIT_SIGNATURE)
 #  define IMAGE_ENABLE_SIGN	1
 #  define FIT_IMAGE_ENABLE_VERIFY	1
 #  include <openssl/evp.h>
diff --git a/tools/Kconfig b/tools/Kconfig
index f8632cd59d0..f01ed783e6f 100644
--- a/tools/Kconfig
+++ b/tools/Kconfig
@@ -51,6 +51,7 @@ config TOOLS_FIT_RSASSA_PSS
 	  Support the rsassa-pss signature scheme in the tools builds
 
 config TOOLS_FIT_SIGNATURE
+	depends on TOOLS_LIBCRYPTO
 	def_bool y
 	help
 	  Enable signature verification of FIT uImages in the tools builds
diff --git a/tools/fit_image.c b/tools/fit_image.c
index 71e031c8550..beef1fa86e2 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -61,7 +61,7 @@ static int fit_add_file_data(struct image_tool_params *params, size_t size_inc,
 		ret = fit_set_timestamp(ptr, 0, time);
 	}
 
-	if (!ret)
+	if (CONFIG_IS_ENABLED(FIT_SIGNATURE) && !ret)
 		ret = fit_pre_load_data(params->keydir, dest_blob, ptr);
 
 	if (!ret) {
diff --git a/tools/image-host.c b/tools/image-host.c
index ca4950312f9..90bc9f905f3 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -14,8 +14,10 @@
 #include <image.h>
 #include <version.h>
 
+#if CONFIG_IS_ENABLED(FIT_SIGNATURE)
 #include <openssl/pem.h>
 #include <openssl/evp.h>
+#endif
 
 /**
  * fit_set_hash_value - set hash value in requested has node
@@ -1131,6 +1133,7 @@ static int fit_config_add_verification_data(const char *keydir,
 	return 0;
 }
 
+#if CONFIG_IS_ENABLED(FIT_SIGNATURE)
 /*
  * 0) open file (open)
  * 1) read certificate (PEM_read_X509)
@@ -1239,6 +1242,7 @@ int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
  out:
 	return ret;
 }
+#endif
 
 int fit_cipher_data(const char *keydir, void *keydest, void *fit,
 		    const char *comment, int require_keys,
diff --git a/tools/mkimage.c b/tools/mkimage.c
index 6dfe3e1d42d..ac62ebbde9b 100644
--- a/tools/mkimage.c
+++ b/tools/mkimage.c
@@ -115,7 +115,7 @@ static void usage(const char *msg)
 		"          -B => align size in hex for FIT structure and header\n"
 		"          -b => append the device tree binary to the FIT\n"
 		"          -t => update the timestamp in the FIT\n");
-#ifdef CONFIG_FIT_SIGNATURE
+#if CONFIG_IS_ENABLED(FIT_SIGNATURE)
 	fprintf(stderr,
 		"Signing / verified boot options: [-k keydir] [-K dtb] [ -c <comment>] [-p addr] [-r] [-N engine]\n"
 		"          -k => set directory containing private keys\n"
@@ -130,8 +130,9 @@ static void usage(const char *msg)
 		"          -o => algorithm to use for signing\n");
 #else
 	fprintf(stderr,
-		"Signing / verified boot not supported (CONFIG_FIT_SIGNATURE undefined)\n");
+		"Signing / verified boot not supported (CONFIG_TOOLS_FIT_SIGNATURE undefined)\n");
 #endif
+
 	fprintf(stderr, "       %s -V ==> print version information and exit\n",
 		params.cmdname);
 	fprintf(stderr, "Use '-T list' to see a list of available image types\n");
-- 
2.39.2

