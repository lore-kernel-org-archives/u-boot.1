Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EDBC5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C76F83A6B;
	Wed, 28 May 2025 14:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z4icJ/6Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0916783A61; Wed, 28 May 2025 14:33:39 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D06BA83A6B
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3dd7a95d19eso20220595ab.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748435615; x=1749040415; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jtVEWTaEhcdi26ANWFOalN9+UtwW0THDh9KdOFc58CA=;
 b=Z4icJ/6YkjOq7I/5zIB0Jw1R99GTjNHgJkrUQIb7B8g5pMq145zPMMN//vN6DQiVi0
 dIrLc7Asjm16aFxe1SJdGYEtaLWZOgTX4thEzhK+6wBTgjAmCBC3ZlzgyvxWp9BCaozp
 tKg7z8MwG5vd8GCrSxk5HWwIjoze3JB4Ubvls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435615; x=1749040415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jtVEWTaEhcdi26ANWFOalN9+UtwW0THDh9KdOFc58CA=;
 b=xSi3Z/RQJnL5t8ninOjorqtrDy9VASeedlwf8sXY0UBKrLnWFsoTROrFyHCsEHAg1N
 YCH1uo1yc98XLaBDLPTp1wHBD5TerTxbagS8H9yXkJgCWOuTe3HuWZo3jmCUYBUcwizN
 H9sO+94EI55qlZ6xUCoD77E5tTwgMSVPSfgCykrYkUzKlbpm9yySkYZ5a++3e1VGQpJV
 NqdkjDoQ46+LEVxei/zjR6CJyaUL2eWaQCLyRIYBh8K3/IysQn7e96LZVHYjfZXv+g68
 NGnR2bCX7Sk6wZmOLjGlNH3MlOHRL6N9Ki5Iz/9hENNQlgAzXuS1Pd2mfRjqCLw83IbK
 en/g==
X-Gm-Message-State: AOJu0Yw+EPfoEfu5jrot6l6JhHHP+eFPJvUUT+7y87dwkI4vKzoCg7Av
 hUtUlbSpJXXb+evios7NjS2nCm8AH123PvKkCwEDwsGFqiqHKQ4Dmg2EKRm2XfOmQta4A3/7213
 7oHEESHkN
X-Gm-Gg: ASbGncveklwT5OHUgv1L9/Y137jV9JfQ2rjVE70eUvKZKgjryStKZ2EqyZkI7GH+lXy
 mUBTfpcSJWNddrk9UPlXR7pOtAXrI9bizi4Ja0o10D6v+9G0H7VYtmM+e3TMWU7uHuU6O5GF4h9
 J42bRhhEyUSrX+Kblivbe/XV2BTV4j3a74AEyvHo7Qdhdydr/BmGoEojCMpQyjLmW7acJNUSNVr
 xTnZpZfvhhnUfxC284hDrKBNvyNjdOwq8r2plRSC0ll+YrK+75j/UNpzk3CVE187JJwkTpr6YbH
 lJ3zjoYUl9dJJ5j/pS179kRHSPsHiJ3MGR4GL0KZxSe/kwVpjPKUVu6tKW8PPccVOu1F9P57z5K
 Yk6TOSa4E/GvN+8WzmutFvdc=
X-Google-Smtp-Source: AGHT+IGcCW7uC4PB797lrrnyN2zYvwS40OB1uVefAncYAiF8PuUA2qaiZXI5ppxoNY+S35pHpO9WXg==
X-Received: by 2002:a05:6e02:188d:b0:3dc:8109:d64b with SMTP id
 e9e14a558f8ab-3dc9b695261mr155573145ab.5.1748435615054; 
 Wed, 28 May 2025 05:33:35 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd4bb408sm205972173.58.2025.05.28.05.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 05:33:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v5 10/25] bloblist: Adjust how the bloblist is received from
 passage
Date: Wed, 28 May 2025 06:32:12 -0600
Message-ID: <20250528123236.1138632-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528123236.1138632-1-sjg@chromium.org>
References: <20250528123236.1138632-1-sjg@chromium.org>
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

With standard passage we can read the bloblist from global_data. Update
the implementation to handle this, thus simplifying the code somewhat.

Shrink the log_msg_ret() string back down to a more normal size.

Note that if OF_BLOBLIST is enabled, this code should never be reached
unless there is a valid bloblist, since the devicetree is processed
first.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to adjust how the bloblist is received from stdpass

 common/bloblist.c | 70 ++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 40 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 6e4f020d7c4..c7322b96bcb 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -11,6 +11,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <mapmem.h>
+#include <passage.h>
 #include <spl.h>
 #include <tables_csum.h>
 #include <asm/global_data.h>
@@ -513,47 +514,37 @@ int __weak xferlist_from_boot_arg(ulong __always_unused *addr)
 int bloblist_init(void)
 {
 	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
-	int ret = 0;
-	ulong addr = 0, size;
-
-	/* Check if a valid transfer list passed in */
-	if (!xferlist_from_boot_arg(&addr)) {
-		size = bloblist_get_total_size();
-	} else {
-		/*
-		 * If U-Boot is not in the first phase, an existing bloblist must
-		 * be at a fixed address.
-		 */
-		bool from_addr = fixed && !xpl_is_first_phase();
-
-		/*
-		 * If Firmware Handoff is mandatory but no transfer list is
-		 * observed, report it as an error.
-		 */
-		if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
-			return -ENOENT;
-
-		ret = -ENOENT;
-
-		if (xpl_prev_phase() == PHASE_TPL &&
-		    !IS_ENABLED(CONFIG_TPL_BLOBLIST))
-			from_addr = false;
-		if (fixed)
-			addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
-					      CONFIG_BLOBLIST_ADDR);
-		size = CONFIG_BLOBLIST_SIZE;
-
-		if (from_addr)
-			ret = bloblist_check(addr, size);
-
-		if (ret)
-			log_warning("Bloblist at %lx not found (err=%d)\n",
+	int ret = -ENOENT;
+	ulong addr, size;
+	bool expected;
+
+	/**
+	 * We don't expect to find an existing bloblist in the first phase of
+	 * U-Boot that runs. The only way to receive the address of an allocated
+	 * bloblist from a previous stage is with standard passage, so without
+	 * that, the bloblist must be at a fixed address.
+	 */
+	expected = (fixed && !xpl_is_first_phase()) || passage_valid();
+	if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
+		expected = false;
+	if (fixed)
+		addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
+				      CONFIG_BLOBLIST_ADDR);
+	size = CONFIG_BLOBLIST_SIZE;
+	if (expected) {
+		if (passage_valid()) {
+			addr = gd_passage_bloblist();
+			size = 0;
+		}
+		ret = bloblist_check(addr, size);
+		if (ret) {
+			log_warning("Expected bloblist at %lx not found (err=%d)\n",
 				    addr, ret);
-		else
-			/* Get the real size */
+		} else {
+			/* Get the real size, if it is not what we expected */
 			size = gd->bloblist->total_size;
+		}
 	}
-
 	if (ret) {
 		/*
 		 * If we don't have a bloblist from a fixed address, or the one
@@ -567,8 +558,7 @@ int bloblist_init(void)
 				return log_msg_ret("alloc", -ENOMEM);
 			addr = map_to_sysmem(ptr);
 		} else if (!fixed) {
-			return log_msg_ret("BLOBLIST_FIXED is not enabled",
-					   ret);
+			return log_msg_ret("!fixed", ret);
 		}
 		log_debug("Creating new bloblist size %lx at %lx\n", size,
 			  addr);
-- 
2.43.0

