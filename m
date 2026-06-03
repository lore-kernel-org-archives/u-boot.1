Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EC7CD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 15:58:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41CA48488F;
	Wed,  3 Jun 2026 17:58:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WvJ6nmB1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 007D084868; Wed,  3 Jun 2026 16:55:13 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE1F68056B
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 16:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=erich.e.hoover@gmail.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-440d9bfa309so950299fac.2
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780498509; x=1781103309; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FHtjTzVGTOwgQruuyDSResNQGFZHE3U/S6Qrf6+J828=;
 b=WvJ6nmB10XYnAk8P+SaNrs9PuECBsvsEEAgJpmnzhrMpPu3tH6vw2H7ACQNTWNSU5W
 gR01Hd3hhCNv9RN+5Gyhx5WySNwFyg270KV9sgzih67JUK6YF8H/HSR9FE8qq3m6s6nN
 L9Oz2oUmQJ8wSGHSz+qcxxBROrFNVC9iLFL4shOl3umJJN/m4LUaeFd2lXM1IjJ2EVLz
 MfqfFdLwY5wD24Dw3nAbw3Or+mGS8sRlY5ZBi65ru25g8nxhXCovO0HP4mKYPqfelPIF
 v+fVbOQcIa492WtICSBVerXv8imwEgdtl7Y09lJWdxPdYNX8XdlT8TIUsHSWFlPZlYFs
 IiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780498509; x=1781103309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FHtjTzVGTOwgQruuyDSResNQGFZHE3U/S6Qrf6+J828=;
 b=AyVd7IVcr9marZmTCnvWQCTtG7Aa0M+/EAM8Zu+aiClOI9K8yGcxqgJJIl25zhylG9
 SXA4qXp/wE3YPiX0iOX11ZGDZtKvNlwy+BtNT/9MP26oll1gjlSL909YqLbL+s+snHfl
 yvL/rUhe/Wk5UQxLX8wQTO1NWqQEfdT8Shcvo2sTadw5Yy3HVinkUj8M1vsM1l0urf08
 rDigwEG+7Jq7dQItPjiz3Vf23lUUOaf6oDYkF/xw17a6DeZjYo6CAp+zmQldC1f0pDt3
 nX3GEnsvHZpO9VUjy1GXDFeOiLI+Y2EBHzf549O6mp7q/d+/qby7zwO0SLYcQFXvmxIS
 0TUA==
X-Gm-Message-State: AOJu0Yz73+yluAKc6S6XkJAkev1Ap06tMHvhHS9sHT0TdrZqiQCQ5zNf
 8nIk9A63NYlj0jv9u/TUZPKNUx05589paoL93DLkE5fQS2puJFj0EbAC8zaAfg==
X-Gm-Gg: Acq92OH8pMAcz1bnIOq18qShCaq1fzPWhnCr95PeZFuYrt/tq8wbumICBSAUVDSbSRd
 bLAev0SQ7vDBOAS8dDw6+zbE/Ojd70IFPmftm0uD20REtX4Jb0U5ECOGNfowN2DmFiD5dgo+rEs
 eKDxKQ0xA5Uae2HDEwLy2Gsk5GUY7auFXO9IpOZAiGwoBZPGSqVD7vg+ADW8Zyzvd9bsZag9j5b
 uN4ksy4YGzm9uweL4lJ97G3FC8aPiunS8QcHk9z+r9mLZlQL/tBZ63nhKKZ3fQW5BmenKeqAenq
 yUGaX5F2W0JXN80NC+0wLBVHrclTjMshyC8uoiKR6TjmdJt+r21K8bG4yd2rXkTxRUr1Uf6MpFB
 tCLSVkUUFAk2BmYQwvj6ey16t3S8c8kkjjrh5T7IDoI73j5DkcnpY4DjS9j/+kO1rjKxSI+Bvo2
 6BiBseNzOHVlb2EZYoEjd08PiEQdD9I99uNAhKAkLG
X-Received: by 2002:a05:6870:23a2:b0:434:56c8:5c76 with SMTP id
 586e51a60fabf-440db65e8bfmr2517637fac.9.1780498509443; 
 Wed, 03 Jun 2026 07:55:09 -0700 (PDT)
Received: from af-fff5r54.. ([50.169.220.58]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d9509e0esm2579197fac.14.2026.06.03.07.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 07:55:08 -0700 (PDT)
From: "Erich E. Hoover" <erich.e.hoover@gmail.com>
To: u-boot@lists.denx.de
Cc: Mike Looijmans <mike.looijmans@topic.nl>,
 Michal Simek <michal.simek@xilinx.com>,
 "Erich E. Hoover" <erich.e.hoover@gmail.com>
Subject: [PATCH] mkimage: allow zynqmpbif to use a register initialization file
Date: Wed,  3 Jun 2026 08:54:53 -0600
Message-ID: <20260603145453.552101-1-erich.e.hoover@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cab1c990-a44a-4b2f-b50f-1481dd00b16a@amd.com>
References: <cab1c990-a44a-4b2f-b50f-1481dd00b16a@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 03 Jun 2026 17:58:10 +0200
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

The ZynqMP Boot Image Format allows specifying the register
initialization file with the "[init]" attribute.  Since this
feature is already supported by the "zynqmpimage" backend, this
commit implements a binding to that existing support.

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

