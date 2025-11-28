Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09ED4D116F1
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6924883B1E;
	Fri, 28 Nov 2025 17:35:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZeRA5ArT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63DA083AED; Fri, 28 Nov 2025 17:35:55 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E70983AED
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 17:35:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-8b2d7c38352so288706485a.0
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 08:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764347752; x=1764952552; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jRa/XPibuvZ6Al72mq7c1N8vyOD0HIidnyiLfOOx5Wk=;
 b=ZeRA5ArT1rbTrqFBVzVUwB5aKnxtpikA0myrL6p0HEGk1LXAEGZtLUDQ7Ke2R8Dx94
 Zx229LuiPvgIKxb/e2XjEICFhcuDTw0P0GqpLkUJc3Or7ldnstzZMvt2LX7kH/fc5GWA
 b2r60gUIB5TOtEHbgeU1mVc1OWZj0gEh0CZkkFjMnra7523Z+/D1gIXnL/DhN4ykGeI+
 frXq7ryyfh3Fsd/2HBfvNeby747foSzb7A+QTHuRUPxqAkoECPuZF+64i96ufVqA4ouB
 0++xprU7Jj35/TFIf+g16tfPyLLvtxsW65YNI78Lgs6ajqb+JRAJSPVf5j5ELiLG5ymR
 Fr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764347752; x=1764952552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jRa/XPibuvZ6Al72mq7c1N8vyOD0HIidnyiLfOOx5Wk=;
 b=IM3OxaYLeq0XAK6yRHEgDRXlo7HJE+FPU92kvPLPJO6AuQr3PdQ0wQqI7SjGpWxW91
 KX0hgSSSFF4y5dz4HCvd3bpbZhxB+10pSZ4pOFIzpxRqIkp16e7wP7FdlgexUUW+Rmp5
 fmyy74HqfIs3yQdqqqIigv3ySviykpqDmNY/SEhatW4pcPDlYoPPZpMEEXQJ3eftW7EU
 0FZViGj69qAs65Z4eNXGnGtGtV4f7Pbo4HXgM4T+pYSOYypQWJ8RvyE/welSlyw/lijD
 TXSZrXQpJ7RF1wMNJv2BKphZVOHPe6YpRNNw26Maa789V16XIOz1AmuV8e+2I6auepsv
 theA==
X-Gm-Message-State: AOJu0Yy4KGpyxG9vRSSDagCX2TaP/KelkE0rnKmqvclrJCFBlyAse83r
 lcBVYSf8aM6aFNt5yR75vn6SpuKQC3B8CszNmoxNSH4P/RtIrh0/ZYAe30goQeIkRY8=
X-Gm-Gg: ASbGncvUcHV9Uwu3g78INdGbz/2deh86psIwgbHUuRG0MtOp2/2GARnBooTTrAI0QZz
 2FcRCYPjntOy1MZAy63k7Ih17jhzpdd2wqDmtGvPt/H7np56OvTt31gYV3pwAfTfAO2rcCvrAPu
 9+Pri24UFmUiqjSI9beKq2faWCiD+aeq8ekO2xVLF+HBq93ttYgHfAKzgXYf7ereNIOiSL+PBfp
 XS24VR4o3X86eVdiencRNwyQgy8+95EfvtAzzAAKFWRziTodsZSCjaT8XRL8AT2dU17M4t3CcOl
 zz8eiGzRRysc1uDypoIwASe7XAkohe9KqiQmCEwl0U64ebQCWikLV7rep1pG+gdCRzlzWfTxmhu
 PWVaOEYrk7Tvwmgh5Ma0Bm4CZEJ2BEYDW/rbFai2txun2uWuYoOARyIdFaFtRRNrRsnIhLhyZtE
 Qv57ZRzJYp4vzZYPyffnZsV5bMzil8TmP9TJASS3TYKg==
X-Google-Smtp-Source: AGHT+IGvEaEDT1NfBMmfORx/Aa8nkH86Vkpoc6tGhF75L7qnI+L8n3N4DRMsdWiOvqxbcFgpvg1z+w==
X-Received: by 2002:a05:620a:4402:b0:8b2:eebc:64bc with SMTP id
 af79cd13be357-8b33be05c80mr5071295785a.35.1764347751734; 
 Fri, 28 Nov 2025 08:35:51 -0800 (PST)
Received: from ubuntu.localdomain ([216.58.22.99])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1b75a9sm331227985a.25.2025.11.28.08.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 08:35:51 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <kettenis@openbsd.org>,
 Baocheng Su <baocheng.su@siemens.com>,
 Li Hua Qian <huaqian.li@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Samuel Holland <samuel.holland@sifive.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v5 1/6] smbios: Fix duplicated smbios handles
Date: Fri, 28 Nov 2025 08:35:18 -0800
Message-Id: <20251128163535.2301653-2-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128163535.2301653-1-raymondmaoca@gmail.com>
References: <20251128163535.2301653-1-raymondmaoca@gmail.com>
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
Signed-off-by: Raymond Mao <raymondmaoca@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v3:
- Initial patch.
Changes in v4:
- None.
Changes in v5:
- None.

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

