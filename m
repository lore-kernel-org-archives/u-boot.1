Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9432EC52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA33F88E3F;
	Wed, 21 Aug 2024 18:19:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dz+Lcau0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 405E488E43; Wed, 21 Aug 2024 18:19:57 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18F3688E34
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-709339c91f9so3585757a34.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257193; x=1724861993; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K8Nm9U2/pXPrJV3wUpOAG9bpzUKx8cKaDn3r8DAeB/8=;
 b=dz+Lcau0NvdmLC2s61X3ttdG3ZWJD2ZKMesj3V6LPiJGW8jVBHED1URpEVSA7iR3hp
 y+ruTqYeigyzL3r/vCmgl5hQ/rzpZg0zfnDcSCric8QqCbTQ1NxlF1zF3azNN88+JDnZ
 uPTxSsK5RG/L/6mLS7kuzHzI7s2nRf7Vk4pcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257193; x=1724861993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K8Nm9U2/pXPrJV3wUpOAG9bpzUKx8cKaDn3r8DAeB/8=;
 b=FSRTNjm1lYNZBvHQ2w8ZHoH3LdndJtX8PEenD+XZrya3xEUBKyfcOPDf5s9QUE5Gai
 kwgG/+QCt17/i7ovYEj8ynAJLISpSyRVDbcgUlLloayhBWaPCSW0h2ODhJx+m0qVxY/t
 RbH4vkKw4k58GP3XR3NDwv0wQJVmMHhxtuOVdQCACaylwyGnLy7R4+W9tL3gtSBmcrFP
 ROwgrEen6ImCGMBvRo/UrwLqrIOFXl8wL4wsKXUaz640IFS2wg5crU99wRWzHjDxFx3B
 el+SscVlrbkeE8PWIa0YVIJVwBlWde7Vj02ePm8BGoHn2UURHQwYUKTqpHT4XSDIUPex
 Ys9Q==
X-Gm-Message-State: AOJu0YweznzMqu069crlDVzZyMOEmRhEEL6GqZd4rpoRSRV/Vb/vnWAP
 tqABmDasomR3157XjhSawY4xGdqd3jySdLK3jDhHFDjB3N5rQibzO9Db1DCO87s7/llr/PIMAK8
 =
X-Google-Smtp-Source: AGHT+IG0Ub61Dr8rVLh5vjgsilcq2Uf6tv68/kryPgR2ZR2tWSgS8kuCIQSPZl8eK6IeWuVp9DxZZg==
X-Received: by 2002:a05:6830:658b:b0:709:3921:7920 with SMTP id
 46e09a7af769-70df886b119mr3268343a34.26.1724257192753; 
 Wed, 21 Aug 2024 09:19:52 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 18/35] board_f: Move fdt_size to board
Date: Wed, 21 Aug 2024 10:19:10 -0600
Message-Id: <20240821161927.695717-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

This value is only really used before relocation. There is not much use
to showing its value in bdinfo, so drop it. Move it to the new boardf
struct.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/bdinfo.c                      |  1 -
 common/board_f.c                  | 11 +++++++----
 include/asm-generic/global_data.h |  4 ----
 include/board_f.h                 |  4 ++++
 test/cmd/bdinfo.c                 |  1 -
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index b53b51acca4..59fbaea498b 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -154,7 +154,6 @@ static int bdinfo_print_all(struct bd_info *bd)
 	if (IS_ENABLED(CONFIG_CMD_NET))
 		print_eth();
 	bdinfo_print_num_l("fdt_blob", (ulong)map_to_sysmem(gd->fdt_blob));
-	bdinfo_print_num_l("fdt_size", (ulong)gd->fdt_size);
 	if (IS_ENABLED(CONFIG_VIDEO))
 		show_video_info();
 #if CONFIG_IS_ENABLED(MULTI_DTB_FIT)
diff --git a/common/board_f.c b/common/board_f.c
index 8f7c56e812f..046d9f45f8b 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -575,12 +575,15 @@ static int reserve_fdt(void)
 		 * section, then it will be relocated with other data.
 		 */
 		if (gd->fdt_blob) {
-			gd->fdt_size = ALIGN(fdt_totalsize(gd->fdt_blob), 32);
+			gd->boardf->fdt_size =
+				ALIGN(fdt_totalsize(gd->fdt_blob), 32);
 
-			gd->start_addr_sp = reserve_stack_aligned(gd->fdt_size);
-			gd->boardf->new_fdt = map_sysmem(gd->start_addr_sp, gd->fdt_size);
+			gd->start_addr_sp = reserve_stack_aligned(
+				gd->boardf->fdt_size);
+			gd->boardf->new_fdt = map_sysmem(gd->start_addr_sp,
+							 gd->boardf->fdt_size);
 			debug("Reserving %lu Bytes for FDT at: %08lx\n",
-			      gd->fdt_size, gd->start_addr_sp);
+			      gd->boardf->fdt_size, gd->start_addr_sp);
 		}
 	}
 
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 8a1a4e298ac..325777dc539 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -226,10 +226,6 @@ struct global_data {
 	 * @fdt_blob: U-Boot's own device tree, NULL if none
 	 */
 	const void *fdt_blob;
-	/**
-	 * @fdt_size: space reserved for relocated device space
-	 */
-	unsigned long fdt_size;
 	/**
 	 * @fdt_src: Source of FDT
 	 */
diff --git a/include/board_f.h b/include/board_f.h
index 74fca6df75c..d9c793fbeb1 100644
--- a/include/board_f.h
+++ b/include/board_f.h
@@ -18,6 +18,10 @@ struct board_f {
 	 * @new_fdt: relocated device tree
 	 */
 	void *new_fdt;
+	/**
+	 * @fdt_size: space reserved for relocated device space
+	 */
+	unsigned long fdt_size;
 };
 
 #endif
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 60adc4aa960..591390560b7 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -185,7 +185,6 @@ static int bdinfo_test_all(struct unit_test_state *uts)
 	ut_assert(map_to_sysmem(gd->fdt_blob) == env_get_hex("fdtcontroladdr", 0x1234));
 	ut_assertok(test_num_l(uts, "fdt_blob",
 			       (ulong)map_to_sysmem(gd->fdt_blob)));
-	ut_assertok(test_num_l(uts, "fdt_size", (ulong)gd->fdt_size));
 
 	if (IS_ENABLED(CONFIG_VIDEO))
 		ut_assertok(test_video_info(uts));
-- 
2.34.1

