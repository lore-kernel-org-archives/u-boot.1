Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B9ECD6E7D
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 14:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DC5B844CF;
	Fri,  5 Jun 2026 16:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dc5qGsOB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C7BD84956; Fri,  5 Jun 2026 15:58:14 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C42E784911
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 15:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=erich.e.hoover@gmail.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-48611d28204so784525b6e.3
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 06:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780667890; x=1781272690; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SoQRUU6hEmrBmNpTQ3udHkVT/uqOk2AbhQfcuXSpmPQ=;
 b=Dc5qGsOBRhIT7l1R8yN5VU2nbcJV/eZe4bMXPEFtr1q8p37PPdm0oGcrEGHz3T6dvF
 5f9culV/cIkELIVqqrDpL9T0d8wOMqfHNypayIZsWCyR3d1qIVfZaunas+3rvekOTLPk
 Bpa+67omKG+woLFxDhUPI1A4ba41816OT+knBQ/Y0r3UjdWCACkeOSxSO5uiiA2jLxQs
 243Hy+aMoaSYJmBa9oEsTWVKVqawe+V3IDDczar5AvaSt/K0IpjiK1CR1shx+GfE5ySS
 2qmt7LD2gY4NLBh/g2yWT2rdDnKqR2czYLqklL10IL8cE0yv3k/2usociAIaus8NN9p7
 wtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780667890; x=1781272690;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SoQRUU6hEmrBmNpTQ3udHkVT/uqOk2AbhQfcuXSpmPQ=;
 b=geN/Hm6UIV6b49sfXESuDLF3YT40fQwlLa6YrEicVup0EgBlSHQviBefkUc1r7ZLI+
 w9TJx817ntxDAzYQMnaso4Ml2zI3HhoxVm9RDinycDjyNbY1NIajpXuYhc2vNlPYxMfA
 AlAEJHghg9ZusYRN0+OsvOZQ377gziE8hkDY7YoaMPTSQMdI2D9j6GmoIHk/dEnfAgZ6
 1PCKbW+6EQdgkp+VP1e8zr3SIPcmI7TgcYSnQv2DNSvCzAcVrjp9yXUNdmJQdxUC4kDi
 /wmNguftLw6Ngq0Lndy8juOilqFApO08YOYmn/xbNxdDKwf+5QOldvONDkw+HXD1E69G
 TPGw==
X-Gm-Message-State: AOJu0Yz5epePFXYqyQmTFE8to2Vob+Bv/Pa/NGDfWrwB0B3pPhSyFAGW
 fcagznVK2bLO+hgR6jXUbCQmZfbUwU48UEN5VAWRA3ENdq3oqNsGq8QQ9lHSHw==
X-Gm-Gg: Acq92OFpYGjMFHWlv2k88Pzf4Wlbw2dKmZhAnUntMr2P0U268X06cD1tco1/a/9bYjR
 B6zlUL4deW4femo08ZnOTrOjaZQQ+amCFLED1Q64w3ky3H+6YQ76xxd5GU0qw7W8DazepdE3PAZ
 sWxPPzAxeB6WBLhgvdgnWzunGgV4M3jQ+CP7OTSgTJrUdsDZViK1LwK8f+j0y6EBO754+kTZPk8
 NPFppCblHj9Bn9nq4qj45PNiMtdB+saOquuLVHihofeMR6CWt064K4GkGTgjshdXN9g0729VDVS
 iAb/BumkyIMRShP3c6SvrsQZRb1gKDSf+hgBw7Kz3nUal9YhUv21UMiSYM3+bd9N78twtoxTifW
 bzJApqe0azUodG/9a+0ipoIO09IGcarTCUbaTC/h7nvICk6rFW+vD946XSK8kXtqWCyFjSOWMri
 Ymv0g5ZBfeWpaFxF1UWsebJa0v8PXDHvLExWTQ72YR
X-Received: by 2002:a05:6808:e7cc:10b0:479:e96e:65aa with SMTP id
 5614622812f47-4868def0d55mr1430815b6e.42.1780667890437; 
 Fri, 05 Jun 2026 06:58:10 -0700 (PDT)
Received: from af-fff5r54.. ([50.169.220.58]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e79237a1sm6192191a34.19.2026.06.05.06.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 06:58:09 -0700 (PDT)
From: "Erich E. Hoover" <erich.e.hoover@gmail.com>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Michal Simek <michal.simek@xilinx.com>,
 "Erich E. Hoover" <erich.e.hoover@gmail.com>
Subject: [PATCH v2] mkimage: allow zynqmpbif to use a register initialization
 file
Date: Fri,  5 Jun 2026 07:57:47 -0600
Message-ID: <20260605135747.1814307-1-erich.e.hoover@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 05 Jun 2026 16:41:13 +0200
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
commit leverages that existing capability to add support for the
"[init]" attribute in the zynqmpbif backend:
https://docs.amd.com/r/en-US/ug1283-bootgen-user-guide/init

We are using this feature, in combination with other zynqmpbif
options, like so:
===
image : {
     [init] fsbl.int
     [bootloader] fsbl.elf
     [pmufw_image] pmufw.elf
     [destination_cpu=none] fsbl.tcl
     [destination_cpu=a53-0, exception_level=el-3] bl31.elf
     [destination_cpu=a53-0, exception_level=el-2, load=0x08000000,
startup=0x08000000] u-boot.bin
}
===

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

