Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AD8C3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E70182977;
	Sat, 10 May 2025 15:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C0u2rIkd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6394382977; Sat, 10 May 2025 15:43:46 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6618082B46
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5fbf534f8dbso4451266a12.3
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746884623; x=1747489423; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q2qqVaHbsGHQjffHo5INfbmWwQCXB5n1vA4IFmaeOcc=;
 b=C0u2rIkdI7IS//gfP5cctNgo4lEzvtIYAEer3cj2JnHn8lB+8uWpUrYZGZXu/qPqFB
 wWhB6098w/a25nudy4pu/ehsEhUTCCLEjSf1uwXAo4fhXWaoOWoIuK0SHsUg7nSo1mg2
 hWSVhSyqqT10VQtzd98lDRxKCyLOIj5X6aCE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746884623; x=1747489423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q2qqVaHbsGHQjffHo5INfbmWwQCXB5n1vA4IFmaeOcc=;
 b=GlXL4rs4+vlDNav8SgsCAZ4uz3ATaDfuyI9ZOfLBgZ3ESHBxbAiJEJ862lW+19CPXd
 1ZSK3wAHOC1AFsU4nXFHgLKUtEBvpEcQ7kozNTGVydy8vA9905vsovArWQVqxZf8MoJo
 TYG6QlVUcq6QIX/bZE8rW+F06t3y21qI8DJryunqJfreAbtXBWFVPcLnlr80xx3RWBgm
 YcZuEUhDIW9LY/KLOE/efc/MuhTv9PrHkeDz2wBuvzgLP0olTdxEymWp0Q/avfRVwSXk
 /4r9slt5ApzIxoZe4hktcl4qM9TqjpwsfdNG+J6v8e4auYeXlvUYaM4JzbWTHAisjmne
 4a3w==
X-Gm-Message-State: AOJu0Yy+6I4q0ADA8hb6WFenP0n0kUIVBr1XasG5DCxSvamo3YMZHQzE
 k0nZ86xq7Mzd1p7ATZtok8cGDqNZdH9DrigiwQR8zj32B9hbdZC37LvL9OVgUcoAjEyt/BDxEOB
 hvd7QptnJSg==
X-Gm-Gg: ASbGncvajZQ7R6HIWyjeFPsVi9FnORM/j86CtTpH/NXEb4af+qj4KJ+KbT5oy7GtyMc
 7UInHrMspFSY+6uv8icWIwlnGTAkLq1Zi5kyzI6lOSmq/QY8njDGAo41206Wv4a7n8/F/Moc7Tl
 Ab8/qfBg/WivcwVKYi2IKlgWbtb3nSrUU1QLY6G1nMh46kJn6770gxIEAFDBGG4JozObj8pPF3a
 2ot/BrQQbYFS5/ppwy6kZCUQCnOVPPaBcQetAn2fRQvBNz8RU2HCGlY4sQJVpDMAvK/D4+AOUoo
 4q88RC2Lzffw7LAJIMpNK1rg04roJowlXbAxDbXdxkdXW7H8iR+Rb0KaCxVx1gH890dJ
X-Google-Smtp-Source: AGHT+IH2OZyy+01YKp5Si6RjJQQmBa5Bmj5HL88+qjuKo278naToteWInK2w0dKcvo+362MVyPADHg==
X-Received: by 2002:a17:907:d8d:b0:ace:c2ab:a728 with SMTP id
 a640c23a62f3a-ad218e577a3mr651922166b.9.1746884623155; 
 Sat, 10 May 2025 06:43:43 -0700 (PDT)
Received: from chromium.org (82-132-222-17.dab.02.net. [82.132.222.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219747028sm319763866b.106.2025.05.10.06.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:43:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Ravi Minnikanti <rminnikanti@marvell.com>
Subject: [PATCH v4 07/22] fdt: Support reading FDT from standard passage
Date: Sat, 10 May 2025 15:42:05 +0200
Message-ID: <20250510134253.1581164-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510134253.1581164-1-sjg@chromium.org>
References: <20250510134253.1581164-1-sjg@chromium.org>
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
 lib/fdtdec.c     | 16 ++++++++++++----
 3 files changed, 15 insertions(+), 7 deletions(-)

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
index 8559616873b..178b1b1247d 100644
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
 
-	if (CONFIG_IS_ENABLED(OF_BLOBLIST)) {
-		printf("Previous phase failed to provide standard passage\n");
-		return -ENOENT;
+	/* The devicetree is typically appended to U-Boot */
+	if (CONFIG_IS_ENABLED(OF_PASSAGE)) {
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

