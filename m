Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F457CD6E5D
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 00:24:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50859848D1;
	Wed,  3 Jun 2026 02:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SOn/Hfir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCE7B84857; Tue,  2 Jun 2026 23:01:54 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B314F84837
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 23:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=erich.e.hoover@gmail.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7e6dcad6018so709944a34.3
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 14:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780434111; x=1781038911; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P7Ik/SF4dh9va/I0iR0g7vuLWeX5R7AsWVlIca95NpU=;
 b=SOn/Hfir8z+4RDRHKZSlQrr/10Cqwhi2Da1juYAM1ZOPdMhkctSRW1RWET7HtQEQTR
 LMY0NzXzWbNPS5rnfq++n5QNL+adrZo+KhdSpTOJUbGeUhIWav2qYn7mxyM73tzZTvz1
 DciSUuyFU7eMcxPIIRn9ZyqHYtf4Dx5Ph70k6pDD/3hc8jXS2RZ3Jx4eJrxp+JHLSaKc
 EE27gIKp4oqBY6tHOOw2MOw+Y6K1exK6Ow89lYdF3EZ+FppRvB++jiucFpsIVWGL3w58
 1fmjY2ABAW4faziZCvGotFPbSdPZ+frDZ3rRtuz4G29aLdnXn4SGgBibeqfmmyEm8WwK
 YfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780434111; x=1781038911;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7Ik/SF4dh9va/I0iR0g7vuLWeX5R7AsWVlIca95NpU=;
 b=LJLKaZoC9Jpd6ygHwr4vw8+v7cXMhb85nLxemlJOnu6zsaybmCGIpH+zxSVmExdYuL
 vGtMHTg3Ov/SK5xom8h77eGhQluO8+nXURq9xvB4K8kXJyBsgsz7fRcmZyPbubabVsP5
 4utc7fEv1F8T9RArDbBdQLxbOmvfg+uZJMHABu7QLRA9JfxOHFumQ9708cpZacxV2luE
 PznhVfNogYR2T0AwE9fZqrMfpDJDl1NGHsqMovZchF/zRV5xJlmtVaCYvyfbPjW3YdUR
 PY7ZrR2Op6z/xm1BqtefReyVGkXBjmGMOrCHgtnKJ8sNtqRZq2qSnw10WNP0jJ/EyugV
 tgKQ==
X-Gm-Message-State: AOJu0YyRUWNDmNjDgOSxQGb5+IelweAlv2pGvtkzFBNuOoHLwOp+q6gZ
 HSjkpABR6A/Az/D2CkbWKLzNbwSHyD6w7O0kfbrNcUliyCJu8TE8SSRPSZbCoQ==
X-Gm-Gg: Acq92OFtPVo9aog1tTs5WxFIBfe6ecVtXiSy7E66q6NBNvNP2wFjz1bA18g1gtJffih
 5dhjk8ujzdI7l2vJEzVt+FJS+qvOw2hd0hBoQmqyD8EuDV16hpzlWslQ7wD8Ya+iNDrqJoHC3L7
 qcsTQAYpjt2O5QDZhhX3hAABjzg2ZD4HBAu9CQloyMPX5O2zO//4AupCl3020VtlUu8u30zvYbJ
 0s0l4STe4IWE1VQ/hrsrX8HWqro/pHK9l9Y+ygYmXWZGZcdPiFApnB3/LZNX6Vl18w13iCHcwgZ
 DyjnhohlXxVFeKcxmcu05SeWT89WhDRbO9xQwisg96UWe2iZEJXX/Q7XVWKQXUxJG5EtH0NPofU
 30t3IkQ7Dq7MMOkxunvFgC+ZyxtjnOLwUnBil0DkkRZCrC/sCbm3HMS0eUninU9H1vFJ0icQ+Mq
 +ftfw65QRMyg5W76erS7b407mbl5So89C8T7EAyYst
X-Received: by 2002:a05:6830:67e7:b0:7dc:c7aa:22bd with SMTP id
 46e09a7af769-7e6e94e681cmr231075a34.6.1780434111200; 
 Tue, 02 Jun 2026 14:01:51 -0700 (PDT)
Received: from af-fff5r54.. ([50.169.220.58]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e78dd7b9sm348921a34.15.2026.06.02.14.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 14:01:50 -0700 (PDT)
From: "Erich E. Hoover" <erich.e.hoover@gmail.com>
To: u-boot@lists.denx.de
Cc: Mike Looijmans <mike.looijmans@topic.nl>,
 Michal Simek <michal.simek@xilinx.com>,
 "Erich E. Hoover" <erich.e.hoover@gmail.com>
Subject: mkimage: allow zynqmp to use a register initialization file
Date: Tue,  2 Jun 2026 15:01:41 -0600
Message-ID: <20260602210141.62966-1-erich.e.hoover@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 03 Jun 2026 02:23:44 +0200
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

Signed-off-by: Erich E. Hoover <erich.e.hoover@gmail.com>
---
 tools/zynqmpbif.c   | 16 ++++++++++++++--
 tools/zynqmpimage.c |  4 ++--
 tools/zynqmpimage.h |  2 ++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/tools/zynqmpbif.c b/tools/zynqmpbif.c
index 82ce0ac1a52..546b9e4fd9d 100644
--- a/tools/zynqmpbif.c
+++ b/tools/zynqmpbif.c
@@ -191,6 +191,7 @@ static char *parse_partition_owner(char *line, struct bif_entry *bf)
 }
 
 static const struct bif_flags bif_flags[] = {
+	{ "init", BIF_FLAG_INIT },
 	{ "fsbl_config", BIF_FLAG_FSBL_CONFIG },
 	{ "trustzone", BIF_FLAG_TZ },
 	{ "pmufw_image", BIF_FLAG_PMUFW_IMAGE },
@@ -279,7 +280,7 @@ static int bif_add_blob(const void *data, size_t len, size_t *offset)
 	return 0;
 }
 
-static int bif_init(void)
+static int bif_initialize(void)
 {
 	struct zynqmp_header header = { { 0 } };
 	int r;
@@ -316,6 +317,15 @@ static int bif_add_pmufw(struct bif_entry *bf, const char *data, size_t len)
 	return 0;
 }
 
+static int bif_init(struct bif_entry *init)
+{
+	/* User can pass in text file with init list */
+	if (strlen(init->filename))
+		zynqmpimage_parse_initparams(bif_output.header, init->filename);
+
+	return 0;
+}
+
 static int bif_add_part(struct bif_entry *bf, const char *data, size_t len)
 {
 	size_t parthdr_offset = 0;
@@ -340,6 +350,8 @@ static int bif_add_part(struct bif_entry *bf, const char *data, size_t len)
 
 	if (bf->flags & (1ULL << BIF_FLAG_PMUFW_IMAGE))
 		return bif_add_pmufw(bf, data, len);
+	else if (bf->flags & (1ULL << BIF_FLAG_INIT))
+		return bif_init(bf);
 
 	r = bif_add_blob(data, len, &bf->offset);
 	if (r)
@@ -837,7 +849,7 @@ int zynqmpbif_copy_image(int outfd, struct image_tool_params *mparams)
 	uint32_t csum;
 	int bldr = -1;
 
-	bif_init();
+	bif_initialize();
 
 	/* Read .bif input file */
 	bif = read_full_file(mparams->datafile, NULL);
diff --git a/tools/zynqmpimage.c b/tools/zynqmpimage.c
index 4db9877127e..eb79c0696cc 100644
--- a/tools/zynqmpimage.c
+++ b/tools/zynqmpimage.c
@@ -400,8 +400,8 @@ static void zynqmpimage_pmufw(struct zynqmp_header *zynqhdr,
 	fclose(fpmu);
 }
 
-static void zynqmpimage_parse_initparams(struct zynqmp_header *zynqhdr,
-	const char *filename)
+void zynqmpimage_parse_initparams(struct zynqmp_header *zynqhdr,
+				  const char *filename)
 {
 	FILE *fp;
 	struct zynqmp_reginit reginit;
diff --git a/tools/zynqmpimage.h b/tools/zynqmpimage.h
index 7c47dc0763b..867fc5294a3 100644
--- a/tools/zynqmpimage.h
+++ b/tools/zynqmpimage.h
@@ -142,6 +142,8 @@ struct zynqmp_header {
 
 void zynqmpimage_default_header(struct zynqmp_header *ptr);
 void zynqmpimage_print_header(const void *ptr, struct image_tool_params *params);
+void zynqmpimage_parse_initparams(struct zynqmp_header *zynqhdr,
+				  const char *filename);
 
 static inline struct image_header_table *
 zynqmp_get_iht(const struct zynqmp_header *zynqhdr)
-- 
2.43.0

