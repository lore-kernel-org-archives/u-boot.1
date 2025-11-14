Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D81CE8D5D
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 17:06:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF78F841E7;
	Fri, 14 Nov 2025 18:06:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C0f8gyvu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 971FF841E7; Fri, 14 Nov 2025 18:06:26 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 538EA8419A
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 18:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4edb166b4e3so16733241cf.3
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 09:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763139983; x=1763744783; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T31Oo6rlbmR6IyeC9EY/VXajtFfLfsnhKYkzj1G722s=;
 b=C0f8gyvudw7J0mjlocdndkMlNlmTqaSFpFtfxKqHSSJ+O4ucZbyBwk4+KgOUeYDHHs
 a6LLFs6wOvK+LBq+cwnJmqoHd5rM0MPViBRjdoiMOtHdB8aghOsjDClbAImCrBXXxKX7
 tXb928Nl8IVn3JQU6bk2/YV4DMy/CZYHQujfqOqaiuYoCKkq66fEqnqzEZVBxYhJuY4Z
 /0kMV6/G2kXv6+hqh54ZgBReR85Fg5A2L9xw4/eGE/9U1YZCROBiRChbt6qxq7bhrXfr
 EMs4BrOA3UqG63aCcaDcpKbEKhMuDv/VczrKxO2YjGx+3dEGuklysiZA0/VfThvWeyhY
 UjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763139983; x=1763744783;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T31Oo6rlbmR6IyeC9EY/VXajtFfLfsnhKYkzj1G722s=;
 b=Mjg/ILa5aKcat5Hz344zCEffKN3n9Q+7/SvEVCHRh6TCMFOIAeo1vL9DJ0rJTXsSwo
 KkfdOcrFt1OdXpUxAFoIX8onhTwe2Y1tYOipygkkKTdDS8qTzxTvSTQtWJlJqhWHcReI
 uI/i+ntoKkO3SRmWwFNxuezUa8wfMHDgg3NgwnMrHQShbx50wAR5gfNs8JT+qjcXRccT
 zGDrLXiK0Qf5hCnaosUXrZjgK2te4hXoXToT/djhLAWbnJfkAjqd+GufhSmJjNFuLGxM
 /uPD8hXnP2RLLXXRqRK4C9Sa/rQ5rAhlelfRqwgZ4Aqc65vy1I4kaD++wx82+Q3RsYnC
 4M/g==
X-Gm-Message-State: AOJu0YwTjOql36mHzTBk40R+2cfPIU78eTnVuqysC9dY3mK0mgea5Za4
 dmqgZJtp4aQ8VIfIpN0dqym19xxEytYHfeV46iek2Gr1RafaZuFqkeirNn0ohwncTjc=
X-Gm-Gg: ASbGnctoZl8ieLPBzOBQ3jI+OcgckQjz/QomAKUVPsHZrv4hoeNZf//5jEUd0v6RcAP
 7gXN4sZqklRbyFXFETbhAldOT+h4SUVB+vauGFmKXsEmm/I78DWFp4bZqKjPHMrpsnl58SW4rvE
 gy3yqShjWYvJDG5rtLrOkEYizdGqRH/u3wzUnu03vGL0VrBGEQpV5czI8GwIvTvecgI6giEbBg2
 qDgzDhsmgcH3Ag8K1AUTaZBknjqkXgoX144q8uFDGuHPiT0PSs5DzcsnfSpgBO94RdeLRJYObrS
 qH6Y/qw4CTQNUqyQvBeKSSU6ew93JCtFc5EzYb/a7eu/tvk8+IMhl9HD0HAlg3tAhClrTymfuuW
 WUumCdvGxArujKx0glFw/9OPAAjrihnrX/K7PbiVfaKg5VPSECl2LrlMHPZnWFs1q9hSR8M+J0J
 NLpLtTdodao0O1lVSB6P6Y+qcQ6KkCnLOIUP2QhkLJKw==
X-Google-Smtp-Source: AGHT+IErs7fkUzcDGfEZAG0Q+cLanzmmXKHZuTAPYJPYwLQNw87gp3zDSGaXpuQ1KluNrFVUY3n5qA==
X-Received: by 2002:ac8:590e:0:b0:4ed:a7ba:69c with SMTP id
 d75a77b69052e-4edf2168c22mr51070931cf.83.1763139981185; 
 Fri, 14 Nov 2025 09:06:21 -0800 (PST)
Received: from ubuntu.localdomain ([216.58.22.99])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ede8593c6asm32234861cf.0.2025.11.14.09.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 09:06:20 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <kettenis@openbsd.org>,
 Baocheng Su <baocheng.su@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Simon Glass <sjg@chromium.org>, Li Hua Qian <huaqian.li@siemens.com>,
 Peng Fan <peng.fan@nxp.com>, Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 1/5] smbios: Fix duplicated smbios handles
Date: Fri, 14 Nov 2025 09:05:58 -0800
Message-Id: <20251114170615.17698-1-raymondmaoca@gmail.com>
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
Signed-off-by: Raymond Mao <raymondmaoca@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v3:
- Initial patch.
Changes in v4:
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

