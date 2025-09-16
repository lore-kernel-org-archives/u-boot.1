Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3710CAC592
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 22:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14CC581E13;
	Wed, 17 Sep 2025 00:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FSyl3s30";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC4438309A; Tue, 16 Sep 2025 23:56:22 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACACD800D7
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 23:56:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=compholio@gmail.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e96eb999262so3684457276.2
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 14:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758059779; x=1758664579; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NXCJh5w3iAVWaj1HoNnC3IN90nOx8eO/c2+iLGJUWT0=;
 b=FSyl3s30vkHQZlHxL4s8PlGmeEWdEhf4oxFuiWFZtV+PnbsFXXBbxsJfgrArChmxkN
 uGP0tnyES6xwOh4dCQpld+TIXWCq6oJiiA90oRoujkOb9XQs1Eg20ezJAb6tLn3J7P/9
 x5dRMZbbkI5tro5GFD+bhJuNc42age0B1T/vGVWIHVh+rk0upoFpycAlKT21Sad7wiUm
 cq/gCf0tJop9+wTgHRJo5cWHFD0Kbpk1VzNN08gPkwPlZfn6ETtsuQ+relGaKMhKCt49
 d/gsau2sTWPwOaVY58Qjz8r0wom3aPc6BHR1Itq64auCQBNWF2djV/77yoyBk0E+6JLG
 O2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758059779; x=1758664579;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NXCJh5w3iAVWaj1HoNnC3IN90nOx8eO/c2+iLGJUWT0=;
 b=h8Gsn/8XhE4dPiwuTrHuSUlwrHWkIqirIbSRx6FouFkR2SS0tGqdapP4JE2ut4bpp3
 RGB/QsNrLT6ZREZOEDCqKWYHe8WvekplMYWA6O+/6VcfDTYOYjL5k8bVqBOqlXHZq1XE
 6Ji9UMet6n0yas9lPLnlLxD2FZiH0Xg2e+II2/p9aDd8MeBeklVWnXWsG+HANmTYpHnp
 TEn8DIGx0KwITg8Km9Z6Jwv4fjMhElpaG4ttrmllw3y0mu05XCehekZYU4oo1EtV8aGr
 L+t3Tx9MnjlSg/Oo8ktyfkwifUMkFD43N1NCtOsLLwBFMQEMOYFRUAYrcTJInXNUDRQ4
 sbOw==
X-Gm-Message-State: AOJu0YyXCeFfiSV81r0wCWvD3e/lTZVM0tRsNVFxma1m8xCTqiXoGPkl
 1lbChh3/ZSI6RkFa1o7PynZxOZCNUcCqd2qf1tmm/Fh+BZFEe4NdpmsnBabHyh1apDuz56EFaWF
 oAt1DxIhU0sodhKb7BkgJQD+eaOmk5o1Dpzh1
X-Gm-Gg: ASbGncsg7Bsg/FKMZ1MdjAcLo5yrIKg/kqNaJ3ia0797v5rjmfw9Noqb9il240qx8yx
 VvQYKqPjZf7XhOR6BbIfodxc4vd798ogEsrc310vYx4sqrnDpdcDC+d1fi9HXfvScA/B6yvXL8T
 ngzAfVCe5/HoHqrq27dzmJ7y7ptgQBTW7DMHlUgOvukJjWAP6msgFT3c3FOXF9dJhS+A8SXmY/A
 9lyxgI=
X-Google-Smtp-Source: AGHT+IE6MqvJVGac3ij/hpojN3To1BPUCmKslb/WRxsjDQMqAJvniOKiPEgAnabiOAooJ4xpaZwwd7VpAHVjJ45fXsk=
X-Received: by 2002:a05:6902:1444:b0:e9d:6f79:57c with SMTP id
 3f1490d57ef6-ea5c03ade8amr26735276.9.1758059779100; Tue, 16 Sep 2025 14:56:19
 -0700 (PDT)
MIME-Version: 1.0
From: "Erich E. Hoover" <erich.e.hoover@gmail.com>
Date: Tue, 16 Sep 2025 15:56:08 -0600
X-Gm-Features: AS18NWApEH40FXUe8LbrDrQjSErnz-jAJ2QuYgDG7W8mNxBj7zklAhjNRCvrMS8
Message-ID: <CAEU2+vrO5KGeoWkDZGOkmL408R6SHqdGhq315cGq+mbq3XBz4g@mail.gmail.com>
Subject: [PATCH] mkimage: add register initialization file support to zynqmpbif
To: u-boot@lists.denx.de
Cc: Mike Looijmans <mike.looijmans@topic.nl>,
 Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 17 Sep 2025 00:01:01 +0200
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
patch implements a binding to that existing support.

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
@@ -191,6 +191,7 @@ static char *parse_partition_owner(char *line,
struct bif_entry *bf)
 }

 static const struct bif_flags bif_flags[] = {
+    { "init", BIF_FLAG_INIT },
     { "fsbl_config", BIF_FLAG_FSBL_CONFIG },
     { "trustzone", BIF_FLAG_TZ },
     { "pmufw_image", BIF_FLAG_PMUFW_IMAGE },
@@ -279,7 +280,7 @@ static int bif_add_blob(const void *data, size_t
len, size_t *offset)
     return 0;
 }

-static int bif_init(void)
+static int bif_initialize(void)
 {
     struct zynqmp_header header = { { 0 } };
     int r;
@@ -316,6 +317,15 @@ static int bif_add_pmufw(struct bif_entry *bf,
const char *data, size_t len)
     return 0;
 }

+static int bif_init(struct bif_entry *init)
+{
+    /* User can pass in text file with init list */
+    if (strlen(init->filename))
+        zynqmpimage_parse_initparams(bif_output.header, init->filename);
+
+    return 0;
+}
+
 static int bif_add_part(struct bif_entry *bf, const char *data, size_t len)
 {
     size_t parthdr_offset = 0;
@@ -340,6 +350,8 @@ static int bif_add_part(struct bif_entry *bf,
const char *data, size_t len)

     if (bf->flags & (1ULL << BIF_FLAG_PMUFW_IMAGE))
         return bif_add_pmufw(bf, data, len);
+    else if (bf->flags & (1ULL << BIF_FLAG_INIT))
+        return bif_init(bf);

     r = bif_add_blob(data, len, &bf->offset);
     if (r)
@@ -837,7 +849,7 @@ int zynqmpbif_copy_image(int outfd, struct
image_tool_params *mparams)
     uint32_t csum;
     int bldr = -1;

-    bif_init();
+    bif_initialize();

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
-    const char *filename)
+void zynqmpimage_parse_initparams(struct zynqmp_header *zynqhdr,
+                  const char *filename)
 {
     FILE *fp;
     struct zynqmp_reginit reginit;
diff --git a/tools/zynqmpimage.h b/tools/zynqmpimage.h
index 7c47dc0763b..867fc5294a3 100644
--- a/tools/zynqmpimage.h
+++ b/tools/zynqmpimage.h
@@ -142,6 +142,8 @@ struct zynqmp_header {

 void zynqmpimage_default_header(struct zynqmp_header *ptr);
 void zynqmpimage_print_header(const void *ptr, struct
image_tool_params *params);
+void zynqmpimage_parse_initparams(struct zynqmp_header *zynqhdr,
+                  const char *filename);

 static inline struct image_header_table *
 zynqmp_get_iht(const struct zynqmp_header *zynqhdr)
-- 
2.43.0
