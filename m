Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE94C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C67F83A41;
	Wed, 28 May 2025 14:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="at3tAYve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63BF983A5E; Wed, 28 May 2025 14:33:42 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2187E83A61
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3dc8265b9b5so33792335ab.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748435618; x=1749040418; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=laIWPuuiNmcKhHbqhYb8y1ZE4cjmnnL5LbSkcrKfGv8=;
 b=at3tAYvehHNv4KjV5XBEQhevKv2bjfjiwANd38fisLPNO8ffWpcQzVvRsOrgWNmbYo
 cHwBiqNw4xeKho8A7O8oPHIk/hbApu2xvGBuFluf8cy1o5QiPIFoY40Ja9r07sDPS0E4
 2TPR6yJPG80w4XlB2x8q508K1zsegsFXV5oUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435618; x=1749040418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=laIWPuuiNmcKhHbqhYb8y1ZE4cjmnnL5LbSkcrKfGv8=;
 b=xMY3x5gssYgpfkJo3FOGyag/g9a3A//Og6fvEk2zZnzI30qq0lnGZwwEBRTZKqiUe5
 /7NlnU2D0Y7XcNvaGq/2pbJTwua7UosXhFGCfOHzAnf/52HVSn6uLUOZuHHVlpxACquw
 wJsPjG6szcl5V8gLk8rY0Y1g9p5Znz+QspPPoTuUVpmWxKSsLt5XipSwczO5ObX0FdJz
 SJT5Ap/60IECTQBRJGnm8NJGQ1ADYe8Z7+ck0wsDtrRKOoNEnJN0DSMTaPby13UWSO1C
 cOnGwL1sekdIRyFsSVr+JJuTT3eJ0o6W3sozN3BvfhsVAzHJkOWsKo/iJSzIgyPdpSNN
 R0iw==
X-Gm-Message-State: AOJu0Yy8JPemF7B+xfuvjIdB+MCj5XrjjA16zzD9ttM2AcmlQ+6eXDIS
 Tk/jaNk16pHOWDFHZPFE6dF64p6e5eVkltfrDrYMKoagGKfJFkW5AGSuqpY6tPK7HIgIercOGlR
 EnZKvt3rP
X-Gm-Gg: ASbGncvsJPxgakEIneKh9W/FsjtHx+oVoEA8NprKjdDoGUR5txbwRajKQ3dyLHAGRic
 pLkJ9i6AYh/Y4x+YU3qNdGzJ5cdaWILZuOGjpJTFCZJssLDUmF+yUNwJq1ukoyHXzjEFXiA22ap
 zSjr8ZJosMmNzs4jCj758gX9aLgslEGitOkgE5e7APOyH3NNog5aR2qEWJ9W/u0pcu39KYX/w3T
 vfcpLCvEBhunP9C0Wr7WcEjbB3VzctVDvdSlurmSbcsegEVdcH7x8UmDHEqGrGF2YjjWivPi6gt
 Vjl5bCjWSsWkMHgsp1vRQfA6mqX2kSDmVbjEL+bhp6u8JJYsC7VhR2v33/64qS2CzRRMjg0oP1t
 OgeZRbZbY362p
X-Google-Smtp-Source: AGHT+IGabCCI3dYV5JtELlj11+oLOsL8oxCRsrF0GCkuSgVQp2M6w0tPozD/mBnqrosynJO9uVH/AQ==
X-Received: by 2002:a92:ca46:0:b0:3dc:7a9a:44d3 with SMTP id
 e9e14a558f8ab-3dd8b0710d9mr20368765ab.21.1748435613420; 
 Wed, 28 May 2025 05:33:33 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd4bb408sm205972173.58.2025.05.28.05.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 05:33:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Simon Glass <sjg@chromium.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Ravi Minnikanti <rminnikanti@marvell.com>
Subject: [PATCH v5 09/25] fdt: Support reading FDT from standard passage
Date: Wed, 28 May 2025 06:32:11 -0600
Message-ID: <20250528123236.1138632-8-sjg@chromium.org>
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

Add an option to receive the FDT using standard passage from a previous
phase. Rename the FDT source to 'passage' to match the old terminology,
which was only partially added.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 env/common.c     |  2 +-
 include/fdtdec.h |  4 ++--
 lib/fdtdec.c     | 14 +++++++++++---
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/env/common.c b/env/common.c
index 86122582bc1..272a86b4dfc 100644
--- a/env/common.c
+++ b/env/common.c
@@ -375,7 +375,7 @@ static int env_update_fdt_addr_from_bloblist(void)
 	 * fdt_addr is by default used by booti, bootm and bootefi,
 	 * thus set it to point to the fdt embedded in a bloblist if it exists.
 	 */
-	if (!CONFIG_IS_ENABLED(BLOBLIST) || gd->fdt_src != FDTSRC_BLOBLIST)
+	if (!CONFIG_IS_ENABLED(BLOBLIST) || gd->fdt_src != FDTSRC_PASSAGE)
 		return 0;
 
 	return env_set_hex("fdt_addr", (uintptr_t)map_to_sysmem(gd->fdt_blob));
diff --git a/include/fdtdec.h b/include/fdtdec.h
index d9fcd037ed2..7f7e13cb904 100644
--- a/include/fdtdec.h
+++ b/include/fdtdec.h
@@ -72,7 +72,7 @@ struct bd_info;
  *	U-Boot is packaged as an ELF file, e.g. for debugging purposes
  * @FDTSRC_ENV: Provided by the fdtcontroladdr environment variable. This should
  *	be used for debugging/development only
- * @FDTSRC_BLOBLIST: Provided by a bloblist from an earlier phase
+ * @FDTSRC_PASSAGE: Provided by a bloblist from an earlier phase
  */
 enum fdt_source_t {
 	FDTSRC_SEPARATE,
@@ -80,7 +80,7 @@ enum fdt_source_t {
 	FDTSRC_BOARD,
 	FDTSRC_EMBED,
 	FDTSRC_ENV,
-	FDTSRC_BLOBLIST,
+	FDTSRC_PASSAGE,
 };
 
 /*
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 2fd6edde160..178b1b1247d 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -19,6 +19,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <net.h>
+#include <passage.h>
 #include <spl.h>
 #include <env.h>
 #include <errno.h>
@@ -90,7 +91,7 @@ static const char *const fdt_src_name[] = {
 	[FDTSRC_BOARD] = "board",
 	[FDTSRC_EMBED] = "embed",
 	[FDTSRC_ENV] = "env",
-	[FDTSRC_BLOBLIST] = "bloblist",
+	[FDTSRC_PASSAGE] = "passage",
 };
 
 extern u8 __dtb_dt_begin[];	/* embedded device tree blob */
@@ -1691,9 +1692,16 @@ int fdtdec_setup(void)
 {
 	int ret;
 
+	/* The devicetree is typically appended to U-Boot */
 	if (CONFIG_IS_ENABLED(OF_PASSAGE)) {
-		printf("Previous phase failed to provide standard passage\n");
-		return -ENOENT;
+		if (!passage_valid()) {
+			printf("Previous phase failed to provide standard passage\n");
+			bloblist_show_list();
+			return -ENOENT;
+		}
+		gd->fdt_blob = map_sysmem(gd_passage_dtb(), 0);
+		gd->fdt_src = FDTSRC_PASSAGE;
+		log_debug("Devicetree is in bloblist at %p\n", gd->fdt_blob);
 	} else {
 		/* The devicetree is typically appended to U-Boot */
 		if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
-- 
2.43.0

