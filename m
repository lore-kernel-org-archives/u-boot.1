Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF052EB3637
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 22:09:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB20A83A1B;
	Mon,  2 Mar 2026 23:09:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LwwVBcBv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 899FC83F0A; Mon,  2 Mar 2026 23:09:42 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BDAD8063E
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 23:09:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-45f194e9a98so1981165b6e.3
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 14:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772489379; x=1773094179; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Np7MBhsKoVqUTI9MuFr81PUWcKJjqw79opbY0eDHDGU=;
 b=LwwVBcBvqoGABgNY4YvTOh0BCWfPa401FUxfBCcDd+0gJn6xQYwDNxMmxxyJbqz+A4
 Mo+OIoysRY6Cn5g+0JcFXTpAkXJEmTqQn8gG17/w/WsplAq7TzBHHub3H9kswxvgQ57m
 Lj/UDlnlxj+p90MNVsGyZCYN0JJVGhA4r9HcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772489379; x=1773094179;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Np7MBhsKoVqUTI9MuFr81PUWcKJjqw79opbY0eDHDGU=;
 b=ifcNKU5cdqoZ5YEFX/fQVKHr+4zf2JNz+tLPdox/G7LIbI6SHe8PU067+h8Udp8NZW
 BulmdEjnBPrajnJipcbyX381YJ/ueSJNTaWUy1/3gYB9j4LScmEMJ03XvAWazf7u4elc
 RUkJ1RA1XGajsQ9xi2oom3YZuGOfInwtCGlCtxoOD1NPiNwuBWsteXFxalJjNKKrrUbM
 HNrk8uaWwpOEnzA273TbQAcjGEBxCniltefs0qCQavPCVN/DjfUUAsZEftwAnJiYvkC3
 8uadw1PgJ5mCjZHoHDtsrHHqKjLBlcKmSpIzk8iWYL7Oh81+rqhVHtExYr9gpLeKhwaK
 sg8w==
X-Gm-Message-State: AOJu0Yxc/Lh5d0miPKlIoZQW9pHjeZDa4C9Ut+0W7BkR8QUomCvrqcRy
 0ZMqVYUPBIT6BCdoZ29dwLr8QIPUOObcDDYt4zU1VhRk4si0TGoUb5TItodwH9+hAYMwu3baIPw
 fRWKxwHA=
X-Gm-Gg: ATEYQzwGwb/1v47J2yV+3pE5YR+QFfFi+hXmQzWhjCoZmseAdLIMzD9+Yl0qVr0zrYj
 yiv3YHDNvgx5D1qeAnBxfmIg4A3tc+63JZtOnQc2rHlUJjNMjf0aWeZlF8KV7lsBrbso0p4XN7m
 ajyTcQWaiJzdlTCox5GZBQ7Wp0WMxB02x9tu0JVOgEZHG8eGUAhGy9X0UEkcDaNOkCF4enFJ+8E
 8Lftz/mXGQQJTHD/OB64Hm8nJfzE69zm23T8CvUJrw7XtfmRR0BfCwFoWCH6tlTZd9C7tkvY+mx
 dnH7lfUaFQI7d77rgm1ahWfskvXWh3YYRaFWJmpfqigFJYzgxyX/W2LAXtl4SFVEoTobsVvqcx1
 fQhlXvc8uotpQDGPw+5E5H6Pb3+TCvx/NyTwXX6kxau5zGtvVk62Ohac83sG2IuxLs4DkxbbQg9
 VzHkAKHk85XzdsA3SUBjzd6OuOGjcugH5+IRGH4hF5Pg6C4R9HvO3k5m6Z2MvWlGsbASaJYZTup
 TqdEpsFUB4BRBZ56SIKKJIeQwkWAcYw3OYEiwhgO/vGO7NuThdkHA==
X-Received: by 2002:a05:6808:6718:b0:44d:bcb0:1409 with SMTP id
 5614622812f47-464bea613a1mr6587490b6e.22.1772489378961; 
 Mon, 02 Mar 2026 14:09:38 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb0991f5sm8401674b6e.0.2026.03.02.14.09.38
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 14:09:38 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] FIT: Address Secure Boot Bypass for Signed FIT Images
Date: Mon,  2 Mar 2026 16:09:37 -0600
Message-ID: <20260302220937.3682128-1-trini@konsulko.com>
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

There is a flaw in how U-Boot verifies and generates signatures for FIT
images. To prevent mix and match style attacks, it is recommended to
use signed configurations. How this is supposed to work is documented in
doc/usage/fit/signature.rst.

Crucially, the `hashed-nodes` property of the `signature` node contains
which nodes of the FIT device tree were hashed as part of the signature
and should be verified. However, this property itself is not part of the
hash and can therefore be modified by an attacker. Furthermore, the
signature only contains the name of each node and not the path in the
device tree to the node.

This patch reworks the code to address this specific oversight.

Thanks to Apple Security Engineering and Architecture (SEAR) for
reporting this issue and then coming up with a fix.

Reported-by: Apple Security Engineering and Architecture (SEAR)
Signed-off-by: Tom Rini <trini@konsulko.com>
---
I assume one question will be about adding a test case. I have been
asked to not share the testcase for a few releases yet, so plan to add
that later in the year.
---
 boot/image-fit-sig.c | 31 +++++++++++++++++++++++--------
 include/image.h      | 12 ++++++++++++
 tools/image-host.c   |  9 +++++++--
 3 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index f23e9d5d0b0f..dce8bbe30e93 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -44,12 +44,6 @@ struct image_region *fit_region_make_list(const void *fit,
 	debug("Hash regions:\n");
 	debug("%10s %10s\n", "Offset", "Size");
 
-	/*
-	 * Use malloc() except in SPL (to save code size). In SPL the caller
-	 * must allocate the array.
-	 */
-	if (!IS_ENABLED(CONFIG_XPL_BUILD) && !region)
-		region = calloc(sizeof(*region), count);
 	if (!region)
 		return NULL;
 	for (i = 0; i < count; i++) {
@@ -62,6 +56,23 @@ struct image_region *fit_region_make_list(const void *fit,
 	return region;
 }
 
+int fit_region_add_hashed_nodes(struct image_region *region, int count,
+					const char* hashed_nodes, int hashed_nodes_len)
+{
+	/* Add the spacer to ensure the hashed strings and hashed-nodes cannot "overlap". */
+	const char* HASHED_NODES_SPACER = "hashed-nodes";
+	region[count].data = HASHED_NODES_SPACER;
+	region[count].size = strlen(HASHED_NODES_SPACER);
+	count++;
+
+	region[count].data = hashed_nodes;
+	region[count].size = hashed_nodes_len;
+	count++;
+
+	/* Now add the actual hashed-nodes value. */
+	return count;
+}
+
 static int fit_image_setup_verify(struct image_sign_info *info,
 				  const void *fit, int noffset,
 				  const void *key_blob, int required_keynode,
@@ -376,10 +387,14 @@ static int fit_config_check_sig(const void *fit, int noffset, int conf_noffset,
 		count++;
 	}
 
-	/* Allocate the region list on the stack */
-	struct image_region region[count];
+	/* Allocate the region list on the stack, +2 for the hashed-nodes */
+	struct image_region region[count+2];
 
 	fit_region_make_list(fit, fdt_regions, count, region);
+
+	/* Add the hashed-nodes */
+	count = fit_region_add_hashed_nodes(region, count, prop, prop_len);
+
 	if (info.crypto->verify(&info, region, count, fit_value,
 				fit_value_len)) {
 		*err_msgp = "Verification failed";
diff --git a/include/image.h b/include/image.h
index 34efac6056dd..5b847527b586 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1771,6 +1771,18 @@ struct image_region *fit_region_make_list(const void *fit,
 		struct fdt_region *fdt_regions, int count,
 		struct image_region *region);
 
+/**
+ * fit_region_add_hashed_nodes() - Add a list of hashed nodes to the regions
+ *
+ * @region:		List of regions to add to
+ * @count:		Number of existing regions (Note: region needs to have space for an additional two regions)
+ * @hashed_nodes:		List of hashed nodes
+ * @hashed_nodes_len:	Length of list
+ * Return: The updated count value (i.e. count+2).
+ */
+int fit_region_add_hashed_nodes(struct image_region *region, int count,
+		const char* hashed_nodes, int hashed_nodes_len);
+
 static inline int fit_image_check_target_arch(const void *fdt, int node)
 {
 #ifndef USE_HOSTCC
diff --git a/tools/image-host.c b/tools/image-host.c
index 48d69191c921..1e7c38a9a211 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -1018,13 +1018,15 @@ static int fit_config_get_regions(const void *fit, int conf_noffset,
 		return -EINVAL;
 	}
 
-	/* Build our list of data blocks */
-	region = fit_region_make_list(fit, fdt_regions, count, NULL);
+	/* Allocate the region array, +2 for the hashed-nodes region. */
+	region = calloc(count+2, sizeof(*region));
 	if (!region) {
 		fprintf(stderr, "Out of memory hashing configuration '%s/%s'\n",
 			conf_name, sig_name);
 		return -ENOMEM;
 	}
+	/* Build our list of data blocks */
+	fit_region_make_list(fit, fdt_regions, count, region);
 
 	/* Create a list of all hashed properties */
 	debug("Hash nodes:\n");
@@ -1043,6 +1045,9 @@ static int fit_config_get_regions(const void *fit, int conf_noffset,
 		strcpy(region_prop + len, node_inc.strings[i]);
 	strlist_free(&node_inc);
 
+	/* Add the hashed-nodes. */
+	count = fit_region_add_hashed_nodes(region, count, region_prop, len);
+
 	*region_countp = count;
 	*regionp = region;
 	*region_propp = region_prop;
-- 
2.43.0

