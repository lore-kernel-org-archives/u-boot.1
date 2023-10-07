Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5D1E95A7E
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39E1C86F31;
	Sun,  8 Oct 2023 01:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SsTv1yh0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCE4B86E9F; Sun,  8 Oct 2023 01:13:56 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF70886F02
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3512740906dso13429235ab.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720398; x=1697325198; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U5WPBePYB2Htc96QQockFuBo89KBptoCzmLFnIsGNN0=;
 b=SsTv1yh0fnOptLKwL3bpDQjQGXHIfIdtk+a/OOZnEOqdVu8bHOYc/UZFeNiSrTBoXo
 wHANcIS1QMoMpevOMZBKOfdeF+XHjCXCDZsWO3IRWtagDFC7Ja3xnzBb/7L87aC7THHv
 UejQEMwdsBH61/x52eq9erhi7uLUMXhmO7mng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720398; x=1697325198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U5WPBePYB2Htc96QQockFuBo89KBptoCzmLFnIsGNN0=;
 b=MLcbmZGbvjUJF21JnEGaQ0kRfHrLdSswbwau5gwFmYn/qgSZOMN9Ug11VgJeuhH2TX
 XSZY7Q9L+ArmLHnzrraTWt3vXxzY/7qHGBrOk5uF+/SSplhM2OV4Q2C77fS8eZ+mTbKX
 F5By37yyRkNcK0v7BHqHyrg4i0DQewzml1UMf0NwGt2HpcmJ5J34K8lfT5Bk6fF+XLOe
 eUUjdXrmTYDF6ur4KebUlpE98ty+mvgCy6k2QK6A4Zn3jFa3RpGzNRWGfHGAE3urHf3/
 eTMwJjIHpi1piyhPFWjzx2O+wiD13eDhnU97W4ygA2EmiFlsVhBzVwBJTc16BGl4PaIw
 Nu9Q==
X-Gm-Message-State: AOJu0YytNbAf4YHr1M0I6f12RRcU7y3W103DmDV/VfjY768Akurom0Cr
 8aCKNwGSPGTeor5FuAPD8M7u5o8uS9ystg9AwZQ=
X-Google-Smtp-Source: AGHT+IHJklnmMkyD5BAiV9R9W9rZlb48v7JPNOjSTLgF9BkQEjJ9qZFdm+Z039gIgO6aUkzKZLWQWw==
X-Received: by 2002:a05:6e02:1c02:b0:350:ef09:ff82 with SMTP id
 l2-20020a056e021c0200b00350ef09ff82mr13728779ilh.24.1696720398145; 
 Sat, 07 Oct 2023 16:13:18 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerry Van Baren <vanbaren@cideas.com>
Subject: [PATCH v2 17/27] fdt: Move working_fdt into fdt_support
Date: Sat,  7 Oct 2023 17:12:36 -0600
Message-ID: <20231007231255.277623-18-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007231255.277623-1-sjg@chromium.org>
References: <20231007231255.277623-1-sjg@chromium.org>
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

This can be accessed even when commands are not enabled. Move it into
the fdt_support.c file, which is where most of the FDT helpers are.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/fdt_support.c | 5 +++++
 cmd/fdt.c          | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 5e49078f8c35..6ae7b8e20f65 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -23,6 +23,11 @@
 #include <fdtdec.h>
 #include <version.h>
 
+/*
+ * The working_fdt points to our working flattened device tree.
+ */
+struct fdt_header *working_fdt;
+
 /**
  * fdt_getprop_u32_default_node - Return a node's property or a default
  *
diff --git a/cmd/fdt.c b/cmd/fdt.c
index 331564c13be9..86e847a41826 100644
--- a/cmd/fdt.c
+++ b/cmd/fdt.c
@@ -31,11 +31,6 @@ static int fdt_parse_prop(char *const*newval, int count, char *data, int *len);
 static int fdt_print(const char *pathp, char *prop, int depth);
 static int is_printable_string(const void *data, int len);
 
-/*
- * The working_fdt points to our working flattened device tree.
- */
-struct fdt_header *working_fdt;
-
 static void set_working_fdt_addr_quiet(ulong addr)
 {
 	void *buf;
-- 
2.42.0.609.gbb76f46606-goog

