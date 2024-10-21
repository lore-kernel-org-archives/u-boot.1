Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89638D0E6C9
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 08:21:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D59C98932A;
	Mon, 21 Oct 2024 10:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gZ2dTxmE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BBB589323; Mon, 21 Oct 2024 10:19:49 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A8E6892F7
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 10:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9a0ec0a94fso503054366b.1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 01:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729498786; x=1730103586; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qGL7VDqdQcuVjymD+DIml5NmUMDCCgX1RA8nBZ3KpKs=;
 b=gZ2dTxmEoXkCeeOmJfiVVg3WDn/hCCtZDHCjaI/GZQ0LgcWms844q3n21Ve26GTvQ4
 XUM6gzlbX90hFpEjkeEh3znja63zmwvtIL6DLpp3aI4MaPP5O6P/w2IU03Do6Osov/xz
 wLFbgw5tlPPGzzWUyE7GKs+zlrz8ExE3ozMKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729498786; x=1730103586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qGL7VDqdQcuVjymD+DIml5NmUMDCCgX1RA8nBZ3KpKs=;
 b=EmRtQqNhL5VnZekXqKH6k+x9ULblapY2I5U+q1M2cR9Grj6lxlVrnXcShe+kVwszlj
 fMJvuyXjBoQ8GdtiZAK48B5wEGMwuoR/R4AI8cJ+9Ey6fEubgWf8i9ST4qJO1ONi1gwg
 QRnuntZgkUsjVMJqCBRKuP2TY/neR5+a+r3G1L6+cSfqvp7WB7Ai0PxrTLR8NnZCYIM1
 DUWUSM+E7fq/v5zAJOUARziQeIk9WReQKXtqbwu1bF2JXU3/Kzi1B1lmybaMnAG2ISVO
 V2+qFYEGIss+OKSH8XZ9cZKnPkUE07qlsecmHASUzioQYx18dVH8IzoqlL5E8K5uywN7
 3fsw==
X-Gm-Message-State: AOJu0Yzk7wI7FiYXcrNTcE4oOO3s1zsLIQfirwYeCVPLRZ2Ynx2NWnqs
 pO10T804VD4Ph5vvFnA+U1e+X7ehH0ZUtK8+gmEtb16Lcgek7GT1hdwIeDVTaVBG2EVjcv4EuHU
 gO1d8
X-Google-Smtp-Source: AGHT+IGcVgALDWTSEwt0u+ebk/gxbOPwZ6xxxrUwnbVKesOIUVK6bjXaGM/uTq0T+T+nqwcNY3mFlA==
X-Received: by 2002:a17:907:2cc6:b0:a9a:1565:1051 with SMTP id
 a640c23a62f3a-a9a69969fbfmr1129036766b.10.1729498786340; 
 Mon, 21 Oct 2024 01:19:46 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912f6520sm176057766b.73.2024.10.21.01.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 01:19:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 8/8] meminfo: Show the lmb records
Date: Mon, 21 Oct 2024 10:19:32 +0200
Message-ID: <20241021081934.289473-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021081934.289473-1-sjg@chromium.org>
References: <20241021081934.289473-1-sjg@chromium.org>
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

Add the lmb records onto the end of the memory map.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Add new patch to show the lmb records

 cmd/meminfo.c      | 26 +++++++++++++++++++++++++-
 test/cmd/meminfo.c |  6 +++++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/cmd/meminfo.c b/cmd/meminfo.c
index 0e6d2f9cc2c..5e83d61c2dd 100644
--- a/cmd/meminfo.c
+++ b/cmd/meminfo.c
@@ -8,6 +8,7 @@
 #include <bootstage.h>
 #include <command.h>
 #include <display_options.h>
+#include <lmb.h>
 #include <malloc.h>
 #include <mapmem.h>
 #include <asm/global_data.h>
@@ -25,6 +26,27 @@ static void print_region(const char *name, ulong base, ulong size, ulong *uptop)
 	*uptop = base;
 }
 
+static void show_lmb(const struct lmb *lmb, ulong *uptop)
+{
+	int i;
+
+	for (i = lmb->used_mem.count - 1; i >= 0; i--) {
+		const struct lmb_region *rgn = alist_get(&lmb->used_mem, i,
+							 struct lmb_region);
+
+		/*
+		 * Assume that the top lmb region is the U-Boot region, so just
+		 * take account of the memory not already reported
+		 */
+		if (lmb->used_mem.count - 1)
+			print_region("lmb", rgn->base, *uptop - rgn->base,
+				     uptop);
+		else
+			print_region("lmb", rgn->base, rgn->size, uptop);
+		*uptop = rgn->base;
+	}
+}
+
 static int do_meminfo(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
@@ -63,7 +85,9 @@ static int do_meminfo(struct cmd_tbl *cmdtp, int flag, int argc,
 			     bloblist_get_total_size(), &upto);
 	stk_bot = gd->start_addr_sp - CONFIG_STACK_SIZE;
 	print_region("stack", stk_bot, CONFIG_STACK_SIZE, &upto);
-	print_region("free", gd->ram_base, stk_bot, &upto);
+	if (IS_ENABLED(CONFIG_LMB))
+		show_lmb(lmb_get(), &upto);
+	print_region("free", gd->ram_base, upto, &upto);
 
 	return 0;
 }
diff --git a/test/cmd/meminfo.c b/test/cmd/meminfo.c
index 84981305bf0..53b41e3b49e 100644
--- a/test/cmd/meminfo.c
+++ b/test/cmd/meminfo.c
@@ -30,7 +30,11 @@ static int cmd_test_meminfo(struct unit_test_state *uts)
 	ut_assert_nextlinen("bootstage");
 	ut_assert_nextlinen("bloblist");
 	ut_assert_nextlinen("stack");
-	ut_assert_nextlinen("free");
+
+	/* we expect at least one lmb line, but don't know how many */
+	ut_assert_nextlinen("lmb");
+	ut_assert_skip_to_linen("free");
+
 	ut_assert_console_end();
 
 	return 0;
-- 
2.43.0

