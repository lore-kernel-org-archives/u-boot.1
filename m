Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF87EF99E0
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 22:53:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B643283CF2;
	Fri, 13 Feb 2026 23:53:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c8ny8IFg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4454C83015; Fri, 13 Feb 2026 23:53:21 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FBBE83CF2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 23:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-502acd495feso14846731cf.2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 14:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771023197; x=1771627997; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l2c1f2hmBrJkskgvPshBZwnOj63EEDYt2WYn12Ztcoc=;
 b=c8ny8IFgaWrxZ/i3Lu5i9wkaXlZjEK8KlfpRzEtzjTEBPkdcm7txo9nNjtMQdAMj2v
 N0Zz4I4AxIwXfs2llVnqn7tkLSTlXRumCW/QvSZssvSPkw3QMdr1+hHh7dBBS6yFqSY7
 mYnwUsuMi+u2Ji8Ba6V1zHUKIoZco2D13xvkbTqN8uyDLK9p9mNGd/eSoxZPWidVKs4o
 04n6N1jsZHfLlaiifLAi2gyOhYoOg5RrwnYcOL5rmUsga1szDrokwrwbP3va18LuA7yB
 0M2dT8Bo9eGZdlA+Xii1jOj5InkFfESazpFdrhw4KPeXANTsyNgTGj3Rwi76Q7xbnQN2
 nYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771023197; x=1771627997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l2c1f2hmBrJkskgvPshBZwnOj63EEDYt2WYn12Ztcoc=;
 b=QFL0nWVmfA0Y77C6DXHl1uwHXi2bb6+EpHvsvUIv79tRXOlszdsM0qvSt45a5cWLSd
 IMlLYXMngV4g/TpSb876MSABWxrkM0/F3ejb/aH0uTi2I5I+dY2O91qyEhbaVjGhBIPm
 fKx5ZdVIHpS/p+rJ81Of0FQRNWAAB9EyVGUjHsHvtTxmKjyOcyx7plYS7QE9+KdlU/C/
 AJsShTrTacTk9E9dkqu8R5GMAAVlcMROhuZFVvg+U7nTyp/BGpERdN1Ls5TUD7rijjn6
 S3ilgX0nItWWKEtCLBMKwHBkLJByV0n7yBpbeBxRxHwn/iWL22RvtKYJ1yUjuYmWegb8
 Ly8w==
X-Gm-Message-State: AOJu0YzFM6bgGoK5nhKcb/0oL/WAxtoUSYz4eh7Vjm1vvEeZ/Po+n2qI
 E4o4qjVdqA6pGNHYUImB++Yy6xvZAX5jzbtbj92VnWSFxLWo+Exo44FPAYw08Q==
X-Gm-Gg: AZuq6aKlrGnwSt6I9hKC7bdDDXDjXY+bs89Dp5qPZtDYXq4AfWEDN8TtRFmccJk9jwR
 Nh6FxYXKx1j6cePIPRfOwnbCLL2QneD/05JJC0VxJg0g6GIm6kYajmuTZFAW1WA5oZWVG+N5tBc
 GjLZNRiNjJyHqbl24ekez/+3qrcy+a8XKVTPRdr8bCq9A1asZaWXusPE3dI8yfxt09lX34g3REK
 1r81pCGZ69V+nLdLcUH4viEArZldSPS1tXfBAnzsUwCYz0ErjjuTWBMJtoD9lJhsiu9PrIBl8Ts
 XKL0PSe6/J7EbIXmMeSJFpHV4HExeMS01k7eH5Wsp1ohn4i3ZvxhEkAOxjq1//U9u98qTKA4JN8
 o4KJ0zw4Sybn23Z5m0nQ9/ekLiGDVi89VYZI8orn6ROAZzaYoneStkX+bXXszzAJIdFNbbllXRC
 BOq+yP0b0CkNnbK6n82H45KQGg1zBkIoALkciQdWwECU+XGR8hkHuztaucdjq6PVBaxDJ/uPrW4
 2M6+f80iGIpALdWs/h+LA==
X-Received: by 2002:a05:622a:1190:b0:501:5113:da4b with SMTP id
 d75a77b69052e-506b4032ab2mr15657361cf.71.1771023197373; 
 Fri, 13 Feb 2026 14:53:17 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-506847ed9c4sm72845731cf.8.2026.02.13.14.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 14:53:17 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <kettenis@openbsd.org>,
 Baocheng Su <baocheng.su@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Li Hua Qian <huaqian.li@siemens.com>,
 Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v6 1/6] smbios: Fix duplicated smbios handles
Date: Fri, 13 Feb 2026 17:52:46 -0500
Message-Id: <20260213225254.2544596-2-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260213225254.2544596-1-raymondmaoca@gmail.com>
References: <20260213225254.2544596-1-raymondmaoca@gmail.com>
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
Changes in v6:
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

