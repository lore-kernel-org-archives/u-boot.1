Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B74EC02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:33:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3411880A29;
	Fri,  7 Feb 2025 19:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DxgBnF10";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CB4880ADE; Fri,  7 Feb 2025 19:32:04 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3611B801BE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:32:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-8550803e1afso20664839f.1
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953120; x=1739557920; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xiufgrbEaRM9DM1K0GsUFHHzwt8LXzTqCGlvzdmNDBU=;
 b=DxgBnF10m87gQ59Vu3sYZD+sxYMDiNIN+ajQ7vUaW98TEKYMmQfgtmGPER/wNLIXir
 Urhnt7n0GqaKwgzx+0V9Cc1y/PEotC9jVbPmbEpnCQJFsSh/CusTJP8Shn/KDD1enyDT
 tNDXAVmncbw6sD4nDnFLRW5kvqL8o5ool35gU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953120; x=1739557920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xiufgrbEaRM9DM1K0GsUFHHzwt8LXzTqCGlvzdmNDBU=;
 b=GAWuhjBQcP1OMWhoSB4/4hN+csIAhc6D+ZcO7rAg0574cWkhRwPhaPiy7jmavHDNDh
 GQDtPJUnYnKlZ/BnH2rMriYawo5U4eV7y/Ji08AGdzkL6N/BfOFLyW4C29Q+ByB4k94h
 mynwKA5jSJDjZWiqP3fonH7AW02ZZiLy/9HXTUdzMO4YmKKCynirxXk+pjrsk/f1GsjP
 AmLqOEu42IgF0IOvi6OYjWxxeWwEsT8BpWTCnew8ONpUC2dZ3an9dcDIkVydv+a1Jy5S
 3kChyHcROMtTwhSATrze5QzKusBFvs5vo+CafIcn2X0SjHG7hECafhzmAMVwnOpu9xOy
 kp+g==
X-Gm-Message-State: AOJu0YyH4AfiLUgLJxVBbX6YfGRyj1+n4GXsCHtmyDa/Y6tW918c1og4
 KjXRVeRfldx3x3PBb/qbydzCeHju5P8fZDL366ttFyP8H0XDYty3O7XOei3rcn5Q42pFG2C9Xww
 =
X-Gm-Gg: ASbGncuI5ac0y/BNDmbugNe7UFFgKVs26Uhu79ntM4Da2AZcBHHBiMFs5FQUKIJREfL
 sKojDSXP094HfmlSY0RkLV0lhERL73yYEhcLn+cceJvQlVI9O8K4o+bYWnEpa4mMIoI4kysQX6q
 8xKubq1wfA8jU8pF1j4bnIxrVFrjXZVCKm0CHY1K3l0G7FFPjrPvx4rt3Xu3Dz7maI2I2784O9X
 3EY+N/kVp3SxkJvVor5ug4p3T4li/LHUtS0vBDqeDnIkJxNDeqEi4Ub/+syuqUckfYSw5kzeAzK
 sTFiuvbEA4XxYDEaLeqXqLyqRDEQ3TAGlA/ws26OmR92SHgo45ta
X-Google-Smtp-Source: AGHT+IEBjzsS+rR0fi4kPQW4y2b0a3JxzN7xZpALj1Q2YPHzHV0N13kir3Fma1tnlzRMYO20Nz0Z4A==
X-Received: by 2002:a05:6602:6cc2:b0:83a:a746:68a6 with SMTP id
 ca18e2360f4ac-854fd89d459mr499109439f.5.1738953120029; 
 Fri, 07 Feb 2025 10:32:00 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:31:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 14/29] test: Update fdt_overlay test to use fdtdec functions
Date: Fri,  7 Feb 2025 11:30:45 -0700
Message-ID: <20250207183121.117663-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207183121.117663-1-sjg@chromium.org>
References: <20250207183121.117663-1-sjg@chromium.org>
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

Use the helpers provided for this purpose, rather than different ones in
this particular test.

Leave fdt_getprop_str() alone as it seems to have more value.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/fdt_overlay/cmd_ut_fdt_overlay.c | 73 ++++++++-------------------
 1 file changed, 22 insertions(+), 51 deletions(-)

diff --git a/test/fdt_overlay/cmd_ut_fdt_overlay.c b/test/fdt_overlay/cmd_ut_fdt_overlay.c
index e4ed7de850c..ac8a3b2be23 100644
--- a/test/fdt_overlay/cmd_ut_fdt_overlay.c
+++ b/test/fdt_overlay/cmd_ut_fdt_overlay.c
@@ -6,6 +6,7 @@
 
 #include <command.h>
 #include <errno.h>
+#include <fdtdec.h>
 #include <fdt_support.h>
 #include <image.h>
 #include <log.h>
@@ -81,33 +82,6 @@ static int fdt_overlay_init(struct unit_test_state *uts)
 	return 0;
 }
 
-static int ut_fdt_getprop_u32_by_index(void *fdt, const char *path,
-				    const char *name, int index,
-				    u32 *out)
-{
-	const fdt32_t *val;
-	int node_off;
-	int len;
-
-	node_off = fdt_path_offset(fdt, path);
-	if (node_off < 0)
-		return node_off;
-
-	val = fdt_getprop(fdt, node_off, name, &len);
-	if (!val || (len < (sizeof(uint32_t) * (index + 1))))
-		return -FDT_ERR_NOTFOUND;
-
-	*out = fdt32_to_cpu(*(val + index));
-
-	return 0;
-}
-
-static int ut_fdt_getprop_u32(void *fdt, const char *path, const char *name,
-			   u32 *out)
-{
-	return ut_fdt_getprop_u32_by_index(fdt, path, name, 0, out);
-}
-
 static int fdt_getprop_str(void *fdt, const char *path, const char *name,
 			   const char **out)
 {
@@ -125,11 +99,12 @@ static int fdt_getprop_str(void *fdt, const char *path, const char *name,
 
 static int fdt_overlay_test_change_int_property(struct unit_test_state *uts)
 {
-	u32 val = 0;
+	int off;
 
-	ut_assertok(ut_fdt_getprop_u32(fdt, "/test-node", "test-int-property",
-				    &val));
-	ut_asserteq(43, val);
+	off = fdt_path_offset(fdt, "/test-node");
+	ut_assert(off >= 0);
+
+	ut_asserteq(43, fdtdec_get_uint(fdt, off, "test-int-property", 0));
 
 	return CMD_RET_SUCCESS;
 }
@@ -202,7 +177,7 @@ FDT_OVERLAY_TEST(fdt_overlay_test_add_subnode_property, 0);
 static int fdt_overlay_test_local_phandle(struct unit_test_state *uts)
 {
 	uint32_t local_phandle;
-	u32 val = 0;
+	u32 val[2];
 	int off;
 
 	off = fdt_path_offset(fdt, "/new-local-node");
@@ -211,13 +186,10 @@ static int fdt_overlay_test_local_phandle(struct unit_test_state *uts)
 	local_phandle = fdt_get_phandle(fdt, off);
 	ut_assert(local_phandle);
 
-	ut_assertok(ut_fdt_getprop_u32_by_index(fdt, "/", "test-several-phandle",
-					     0, &val));
-	ut_asserteq(local_phandle, val);
-
-	ut_assertok(ut_fdt_getprop_u32_by_index(fdt, "/", "test-several-phandle",
-					     1, &val));
-	ut_asserteq(local_phandle, val);
+	ut_assertok(fdtdec_get_int_array(fdt, 0, "test-several-phandle", val,
+					 ARRAY_SIZE(val)));
+	ut_asserteq(local_phandle, val[0]);
+	ut_asserteq(local_phandle, val[1]);
 
 	return CMD_RET_SUCCESS;
 }
@@ -226,7 +198,7 @@ FDT_OVERLAY_TEST(fdt_overlay_test_local_phandle, 0);
 static int fdt_overlay_test_local_phandles(struct unit_test_state *uts)
 {
 	uint32_t local_phandle, test_phandle;
-	u32 val = 0;
+	u32 val[2];
 	int off;
 
 	off = fdt_path_offset(fdt, "/new-local-node");
@@ -241,13 +213,10 @@ static int fdt_overlay_test_local_phandles(struct unit_test_state *uts)
 	test_phandle = fdt_get_phandle(fdt, off);
 	ut_assert(test_phandle);
 
-	ut_assertok(ut_fdt_getprop_u32_by_index(fdt, "/", "test-phandle", 0,
-					     &val));
-	ut_asserteq(test_phandle, val);
-
-	ut_assertok(ut_fdt_getprop_u32_by_index(fdt, "/", "test-phandle", 1,
-					     &val));
-	ut_asserteq(local_phandle, val);
+	ut_assertok(fdtdec_get_int_array(fdt, 0, "test-phandle", val,
+					 ARRAY_SIZE(val)));
+	ut_asserteq(test_phandle, val[0]);
+	ut_asserteq(local_phandle, val[1]);
 
 	return CMD_RET_SUCCESS;
 }
@@ -255,11 +224,13 @@ FDT_OVERLAY_TEST(fdt_overlay_test_local_phandles, 0);
 
 static int fdt_overlay_test_stacked(struct unit_test_state *uts)
 {
-	u32 val = 0;
+	int off;
+
+	off = fdt_path_offset(fdt, "/new-local-node");
+	ut_assert(off > 0);
 
-	ut_assertok(ut_fdt_getprop_u32(fdt, "/new-local-node",
-				       "stacked-test-int-property", &val));
-	ut_asserteq(43, val);
+	ut_asserteq(43,
+		    fdtdec_get_uint(fdt, off, "stacked-test-int-property", 0));
 
 	return CMD_RET_SUCCESS;
 }
-- 
2.43.0

