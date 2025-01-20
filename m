Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D885C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:55:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7BB8807DD;
	Mon, 20 Jan 2025 22:54:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kBOb2+iM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFD7E8082D; Mon, 20 Jan 2025 22:54:16 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 715FB8082A
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:54:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3ce7a33ea70so18259835ab.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410052; x=1738014852; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84/EzPoM9uJG/rMrsN8r0IHITwFwOGdYkGsfQpB/QhI=;
 b=kBOb2+iMFSTvn5/P2Ev7P7wBxAoWMl6Pp2UiiqinJHKfKF+xDCtbPXge1i/Visr8+V
 B6H04+8kjCt1lF0Px/WV3frY82crGeEQUonwcGSCb/Rg9T2GUK56ZEnMFxgCQ/quXOK5
 QmVFn2b9PXRPS3+GkK4nCif55C2lJ4nF5i7tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410052; x=1738014852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=84/EzPoM9uJG/rMrsN8r0IHITwFwOGdYkGsfQpB/QhI=;
 b=HCJ1rl/ww1jAbc4/DgEBfozJcdULhl1/JNO2snWi4K/mDzKzinY8MjfMyu3+LCbzUZ
 ry0eU00YOxRLTZbP+ha8KgU5lladNppvJ5lDi80eFRmueMisbQR0uRbvPgRWcFxoDC1h
 AhK5bhew9YC2+euejqRNqGCpkfN3yYL5jVnHyVCVN7Gas3jEeNKHTYuih4HMDBJ/6cgf
 7Fp+AQW1iazRTYTYIKcaGXD+kAGTgjjsmq7OrtEmWxMd1o/Ggx37IWq2LjZ61h5RC8kd
 UzIwiHAx+8XXD5QEVQjeyt9resUwImjabdRRZyzFTdqjGCAUDTVI2FsVaRDdiYjxOQtc
 mk2A==
X-Gm-Message-State: AOJu0Yw9GDpDAqh5aLs7+N/2Bp46WXk06FhxFB7Orlksk36UVTpLKBkq
 wusRZuKgJYPKjkFX8Iu5+tOxvIGqO3TchPXl+vPedl08oPxng+7EaWZcukerTi7EcXJ2unjyCwc
 =
X-Gm-Gg: ASbGncv/0D7QtxS3CP+rMT6Gc37YM1BPl9tkNStTaqcVHn3fB2wuIEq4CGO74iIPrcp
 36Eh0blqoBkZnqWXLRAavrE86asB19hafIlCkGZw5uYV+tkvIaMpukoLO8Mqzk/wY9tRoAf6wyI
 1sgubaxGmuXL3/D2UsaZTD7lKie1ZuLw+ETppZgSsy4MRPUeoIwDN0yv/Lr8UC+PG2ZJJQ4DSAW
 qUMKfICjZd/xpo2Zc6YRHORqrRoDWj+CMLO7GPwsdZ20nSSJBC6Q0/bMln2V8KnvcZMoe647OGD
 YEEY5mqc13gDzyrTLiWyFqqdWKabJZI=
X-Google-Smtp-Source: AGHT+IEI0iZZt0elx4jS0L/mRpiILFC/DHvF1FHXc2d9CfUQlmHadziAo/asS4/+uZfW1qpum2kAgQ==
X-Received: by 2002:a05:6e02:9f:b0:3ce:7bbd:971c with SMTP id
 e9e14a558f8ab-3cf74496441mr126965705ab.15.1737410052068; 
 Mon, 20 Jan 2025 13:54:12 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:54:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/28] test: Update fdt_overlay test to use fdtdec functions
Date: Mon, 20 Jan 2025 14:53:13 -0700
Message-ID: <20250120215340.617194-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120215340.617194-1-sjg@chromium.org>
References: <20250120215340.617194-1-sjg@chromium.org>
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

