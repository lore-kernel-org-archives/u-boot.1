Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599F1CAC59A
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 20:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82C858309A;
	Fri, 19 Sep 2025 22:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LOyfTyfC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BA048329F; Fri, 19 Sep 2025 22:56:20 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9742A81D6A
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 22:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-4248b3204d4so1569355ab.3
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 13:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758315376; x=1758920176; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qJ/iQeIaWSW+oH35VRSf0eSRXhpSFeJ5jLB6yi05+EE=;
 b=LOyfTyfCSPns3u0n/Vo1THuS1sqrE00QV6s08d3u5q/X8SO2UOJYj4STdF/qt81iMN
 Wsfw06KREZH/yUlKJPCX9YxWaGt8IzaE6WbeNAOIwHO8iVvMT+MxqyXP7iaU9STUWtk1
 6Sbb8oFQiQJ5E0GC+cfrj+B9ItSf+Rz5CmkNs0t1CpUPWVqjjXie5qISQ4cMNzpmmKkP
 Ce/7mKGikQNmwa0De4+HGcDWC6j8fFa4Z0apPGHRmm675jn80boMtpElIubaZmtDXtk8
 ulnLYSJuSnRfnB5K9DUB3JxkG6GAVyQu50kvyow2fRYn7VZTjUhlbHSZirbbmPfT4qdV
 Dt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758315376; x=1758920176;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qJ/iQeIaWSW+oH35VRSf0eSRXhpSFeJ5jLB6yi05+EE=;
 b=g7Sz/b8nnZxOiOF83bpbDKVX1JUJin31Op/roQTxPPZ/HJ8xCQ/vheL9jZlezd9zuT
 /PRfvco+2B3RXzy5aTBheiwdHh/fRsA+HyRzz33s7QNnQbidgFslxSRDOe+9p4Je5Qd9
 3R9BN+ChcEE363npR6Xngr4ZSBAy9usSMQeAGqxG0G7Zp6hm+stj6b3ZXTyCSAJPKj7h
 ooFdR5GXUsyKW01eTIZxBCcPSy/FPiTF95jcYiQ+6QHiv9MiSJie+tRysOEWBKXLLwXm
 MlsUNoq1rpiX9mAXQ1BMvCxV9ju2DpH8fzqUS410kVziAKuPW+Ew47NicbEahWT55R5c
 uy7A==
X-Gm-Message-State: AOJu0YyO1YFubUJU8cnvFDQMLVObINSgm7nviOug+pZFg5d1vNJKzN+l
 0cbGANCL7+RZGrh+4OGV+ewvJ25Fewrivoq+12KMVpMXVsKvnziPQfaSwN7/xbRNjPynG7xNJro
 lOGeH
X-Gm-Gg: ASbGnct9S3xZN3owjOu9dU+d21lpWkb31CG889pRJOIsrlose9rXGfNS9g+mB/kAb+6
 XPjGBcTnACnejxuT8xe3LaxfruQxqtokz6qL7FfSnruPQWctEvgxAw3X5CiJcByZyvJe5reSZ59
 q7x64M+Mz+38oX9l9o8/wRU0IaFa8+3Z2EZG7rpY5YE4m4L4bxTLjg9dMgjy+ioxYUIm+QMorVL
 3ILs4i5gapnVjJi++bW2eKHfTBwWDTRFrzTF+xY8C9WdpM4WNRLhowXUoEhywK4BOesfyVVcjhQ
 K0XCd1YYCtnMunmfTy4tGvSgt6so5ElI0OqYDloZEdnOku17Sln4pDTPdICj3MRielgntVDyadS
 36WsuFHsUFf1oC8x2ITrVzd+kJo7DE1r1oL9CZc/mRyV+m4RNa32QNyMqu8O/TMlOzZQmc3/gBr
 Y4jimKv4zm1Q==
X-Google-Smtp-Source: AGHT+IEaCsQf3u1sMYnMFsp/h6GJfSVl6zgb6ZplqSEEjwTE3Qr1C+zqnGNQRYu3rWF2PWpCPDyeOA==
X-Received: by 2002:a05:6e02:380b:b0:424:8061:dec0 with SMTP id
 e9e14a558f8ab-42481922c60mr64142625ab.7.1758315375966; 
 Fri, 19 Sep 2025 13:56:15 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-115-235.cpe.distributel.net.
 [173.206.115.235]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-4244a36bcd9sm25930295ab.3.2025.09.19.13.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Sep 2025 13:56:15 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <kettenis@openbsd.org>,
 Baocheng Su <baocheng.su@siemens.com>, Simon Glass <sjg@chromium.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Li Hua Qian <huaqian.li@siemens.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 1/2] smbios: Fix duplicated smbios handles
Date: Fri, 19 Sep 2025 13:55:59 -0700
Message-Id: <20250919205605.291108-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Some smbios types can have multiple instances (e.g. Type 7, 9, 16, 17,
19), thus the 'handle' argument should be a pointer so that the value
can be accumulated when writing all the instances.
This also fix the observed duplicated Type 7 handles.

Fixes: bcf456dd369e ("smbios: add detailed smbios information")
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v3:
- Initial patch.

 lib/smbios.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index b8c2846277a..85508c06547 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -103,7 +103,7 @@ struct smbios_ctx {
  * @ctx:	context for writing the tables
  * Return:	size of the structure
  */
-typedef int (*smbios_write_type)(ulong *addr, int handle,
+typedef int (*smbios_write_type)(ulong *addr, int *handle,
 				 struct smbios_ctx *ctx);
 
 /**
@@ -364,7 +364,7 @@ static int smbios_string_table_len(const struct smbios_ctx *ctx)
 	return (ctx->next_ptr + 1) - ctx->eos;
 }
 
-static int smbios_write_type0(ulong *current, int handle,
+static int smbios_write_type0(ulong *current, int *handle,
 			      struct smbios_ctx *ctx)
 {
 	struct smbios_type0 *t;
@@ -372,7 +372,7 @@ static int smbios_write_type0(ulong *current, int handle,
 
 	t = map_sysmem(*current, len);
 	memset(t, 0, len);
-	fill_smbios_header(t, SMBIOS_BIOS_INFORMATION, len, handle);
+	fill_smbios_header(t, SMBIOS_BIOS_INFORMATION, len, *handle);
 	smbios_set_eos(ctx, t->eos);
 	t->vendor = smbios_add_prop_si(ctx, NULL, SYSID_SM_BIOS_VENDOR,
 				       "U-Boot");
@@ -423,7 +423,7 @@ static int smbios_write_type0(ulong *current, int handle,
 	return len;
 }
 
-static int smbios_write_type1(ulong *current, int handle,
+static int smbios_write_type1(ulong *current, int *handle,
 			      struct smbios_ctx *ctx)
 {
 	struct smbios_type1 *t;
@@ -434,7 +434,7 @@ static int smbios_write_type1(ulong *current, int handle,
 
 	t = map_sysmem(*current, len);
 	memset(t, 0, len);
-	fill_smbios_header(t, SMBIOS_SYSTEM_INFORMATION, len, handle);
+	fill_smbios_header(t, SMBIOS_SYSTEM_INFORMATION, len, *handle);
 	smbios_set_eos(ctx, t->eos);
 
 	t->manufacturer = smbios_add_prop_si(ctx, "manufacturer",
@@ -471,7 +471,7 @@ static int smbios_write_type1(ulong *current, int handle,
 	return len;
 }
 
-static int smbios_write_type2(ulong *current, int handle,
+static int smbios_write_type2(ulong *current, int *handle,
 			      struct smbios_ctx *ctx)
 {
 	struct smbios_type2 *t;
@@ -485,7 +485,7 @@ static int smbios_write_type2(ulong *current, int handle,
 	 */
 	t = map_sysmem(*current, len);
 	memset(t, 0, len);
-	fill_smbios_header(t, SMBIOS_BOARD_INFORMATION, len, handle);
+	fill_smbios_header(t, SMBIOS_BOARD_INFORMATION, len, *handle);
 
 	/* eos is at the end of the structure */
 	eos_addr = (u8 *)t + len - sizeof(t->eos);
@@ -519,7 +519,7 @@ static int smbios_write_type2(ulong *current, int handle,
 	 * t->number_contained_objects = <obj_handle_num>;
 	 */
 
-	t->chassis_handle = handle + 1;
+	t->chassis_handle = *handle + 1;
 
 	len = t->hdr.length + smbios_string_table_len(ctx);
 	*current += len;
@@ -528,7 +528,7 @@ static int smbios_write_type2(ulong *current, int handle,
 	return len;
 }
 
-static int smbios_write_type3(ulong *current, int handle,
+static int smbios_write_type3(ulong *current, int *handle,
 			      struct smbios_ctx *ctx)
 {
 	struct smbios_type3 *t;
@@ -548,7 +548,7 @@ static int smbios_write_type3(ulong *current, int handle,
 
 	t = map_sysmem(*current, len);
 	memset(t, 0, len);
-	fill_smbios_header(t, SMBIOS_SYSTEM_ENCLOSURE, len, handle);
+	fill_smbios_header(t, SMBIOS_SYSTEM_ENCLOSURE, len, *handle);
 #if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE)
 	elem_addr = (u8 *)t + offsetof(struct smbios_type3, sku_number);
 	sku_num_addr = elem_addr + elem_size;
@@ -669,7 +669,7 @@ static void smbios_write_type4_dm(struct smbios_type4 *t,
 #endif
 }
 
-static int smbios_write_type4(ulong *current, int handle,
+static int smbios_write_type4(ulong *current, int *handle,
 			      struct smbios_ctx *ctx)
 {
 	struct smbios_type4 *t;
@@ -679,7 +679,7 @@ static int smbios_write_type4(ulong *current, int handle,
 
 	t = map_sysmem(*current, len);
 	memset(t, 0, len);
-	fill_smbios_header(t, SMBIOS_PROCESSOR_INFORMATION, len, handle);
+	fill_smbios_header(t, SMBIOS_PROCESSOR_INFORMATION, len, *handle);
 	smbios_set_eos(ctx, t->eos);
 	t->socket_design = smbios_add_prop_si(ctx, "socket-design",
 					      SYSID_SM_PROCESSOR_SOCKET, NULL);
@@ -828,13 +828,14 @@ static int smbios_write_type7_1level(ulong *current, int handle,
 	return len;
 }
 
-static int smbios_write_type7(ulong *current, int handle,
+static int smbios_write_type7(ulong *current, int *handle,
 			      struct smbios_ctx *ctx)
 {
 	int len = 0;
 	int i, level;
 	ofnode parent = ctx->node;
 	struct smbios_ctx ctx_bak;
+	int hdl_base = *handle;
 
 	memcpy(&ctx_bak, ctx, sizeof(ctx_bak));
 
@@ -850,15 +851,17 @@ static int smbios_write_type7(ulong *current, int handle,
 			return 0;
 		ctx->subnode_name = buf;
 		ctx->node = ofnode_find_subnode(parent, ctx->subnode_name);
-		len += smbios_write_type7_1level(current, handle++, ctx, i);
+		*handle = hdl_base + i;
+		len += smbios_write_type7_1level(current, *handle, ctx, i);
 		memcpy(ctx, &ctx_bak, sizeof(*ctx));
 	}
+
 	return len;
 }
 
 #endif /* #if IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE) */
 
-static int smbios_write_type32(ulong *current, int handle,
+static int smbios_write_type32(ulong *current, int *handle,
 			       struct smbios_ctx *ctx)
 {
 	struct smbios_type32 *t;
@@ -866,7 +869,7 @@ static int smbios_write_type32(ulong *current, int handle,
 
 	t = map_sysmem(*current, len);
 	memset(t, 0, len);
-	fill_smbios_header(t, SMBIOS_SYSTEM_BOOT_INFORMATION, len, handle);
+	fill_smbios_header(t, SMBIOS_SYSTEM_BOOT_INFORMATION, len, *handle);
 	smbios_set_eos(ctx, t->eos);
 
 	*current += len;
@@ -875,7 +878,7 @@ static int smbios_write_type32(ulong *current, int handle,
 	return len;
 }
 
-static int smbios_write_type127(ulong *current, int handle,
+static int smbios_write_type127(ulong *current, int *handle,
 				struct smbios_ctx *ctx)
 {
 	struct smbios_type127 *t;
@@ -883,7 +886,7 @@ static int smbios_write_type127(ulong *current, int handle,
 
 	t = map_sysmem(*current, len);
 	memset(t, 0, len);
-	fill_smbios_header(t, SMBIOS_END_OF_TABLE, len, handle);
+	fill_smbios_header(t, SMBIOS_END_OF_TABLE, len, *handle);
 
 	*current += len;
 	unmap_sysmem(t);
@@ -954,7 +957,8 @@ ulong write_smbios_table(ulong addr)
 				ctx.node = ofnode_find_subnode(parent_node,
 							       method->subnode_name);
 		}
-		len += method->write((ulong *)&addr, handle++, &ctx);
+		len += method->write((ulong *)&addr, &handle, &ctx);
+		handle++;
 	}
 
 	/*
-- 
2.25.1

