Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD47CE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:43:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3E1786C0E;
	Sun, 24 Sep 2023 22:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VqsT4sml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CD1A86B75; Sun, 24 Sep 2023 22:40:38 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66EE386ACC
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-35130c8bc79so5756505ab.1
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588035; x=1696192835; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a/H0cfitOa549A1Wcyk3rA5ym4/yZ0PJ394bv01j/oA=;
 b=VqsT4sml5rbtbk2e0hYEGsbIFhAUxRgJpFbKBzkqDYnjRvMDbFYyzH/VAmLVBNpjQR
 zFuqQxpKot5c5ZDOl9fl6Pbe2nLmCpMNpiA0mlDQKusFTlvDKVthmea/m8NyMk0dEkDY
 tkBSVuL7luIgkPIcGn2u1Yc203gEA75CDlQ2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588035; x=1696192835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a/H0cfitOa549A1Wcyk3rA5ym4/yZ0PJ394bv01j/oA=;
 b=hduGdjXdWSC0LzS2Kq11qkNmjgHMXjSFqHATGD8BXHZgySx56v0KUTEECRzvDdgohu
 nudOyMUJzjloQCIxywdFYGgbskxUKDSkWFW/pbjUPXYKLvy7AmQipISowDCoJvUBgU0j
 dtbJD0cExxkXvs8QtQnpgu0rodNhuSCw0Yf54PnMBIzsasF2WdChwStFe+fwdP38KzMH
 /8XJF9j7OZ8FaxsgSHFMKsDQQhpiKCB8pxfGV+jn49ww/Qdmc421oBVyykzvDc7IH0iZ
 c91OsHX+BXxZ8jSaCVzGht+EdP6JbyjGvwo9yfY5tFKt9tWOM7WxOyMJiMfpOAtfpbuJ
 Azng==
X-Gm-Message-State: AOJu0YzLNeAttcK4R4hlcmEu5NsAqtXo43Nuo4AeAYn/fcxP7pmVWQ/d
 NQz8hZ7jK0G3MlMEPBzszSW/t5ahlU55s7s6IqI=
X-Google-Smtp-Source: AGHT+IErMet//R1GY9ibDMGnbXZj/4wPqYM2t0Gwnd8zT26iTUDnq0seslFIdD6sZesYptTwiUpSDA==
X-Received: by 2002:a05:6e02:1c0f:b0:351:1382:9366 with SMTP id
 l15-20020a056e021c0f00b0035113829366mr6841903ilh.24.1695588035025; 
 Sun, 24 Sep 2023 13:40:35 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH 17/25] fdt: Move working_fdt into fdt_support
Date: Sun, 24 Sep 2023 14:39:35 -0600
Message-ID: <20230924203953.1829820-18-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924203953.1829820-1-sjg@chromium.org>
References: <20230924203953.1829820-1-sjg@chromium.org>
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
index 2401ea8b44cb..f842fd84b4b2 100644
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
2.42.0.515.g380fc7ccd1-goog

