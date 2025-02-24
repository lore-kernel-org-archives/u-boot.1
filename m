Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B2AC021B6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D677812BF;
	Tue, 25 Feb 2025 00:08:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LLFnMNzJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B13E80F56; Tue, 25 Feb 2025 00:08:13 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C94FF811D8
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-854a68f5afcso132686939f.0
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438488; x=1741043288; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTitju+KnB8bk2wFLM7o3nkH//Dtx8lx88dhtzFn7yY=;
 b=LLFnMNzJK3p/8oRL1j0PDdOPsAqD0tBtajCcJqDw5B2h3qcztVn8sLc2YX3sVI9Mww
 bmkacBb0YaebFzuHXhx4LvBWRfeLhSxZzFyfU2E0l7Hm5TE+C4Z6Sc/6H+7xNbBFHYpH
 q2Wuy/OcF6EsAwej0CdOZjE9hUXxN99EJ6fxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438488; x=1741043288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTitju+KnB8bk2wFLM7o3nkH//Dtx8lx88dhtzFn7yY=;
 b=pP6nE7lNz1Aaia6WLGWl5Y4IQ3CW2QNgPi+jdvVQZBevcWXlbqKXJlK+ZnkX2JnmiH
 v+J6ZhMvaLkOIeBUCYT360Zb18kOJ1q34+cx1ori3uyUCt7/hrYzODS//G4+lQX3jQjs
 RrF6c+bLBEUQbL1+MqPNSm58v5Mtd6/07y3renXrUTk6CH07zaktbW4wmB0WdKCCNip6
 7miII3W+QHsYNpJ3jPXH/+N82mYNyCzibhU9cd3ZltuFf+AJ4hRaceMYAPoxS8Oycuwf
 wnSbtI5qskS3zZ3YefOKfxUnTGw/y29uKP/PAQMogocQqWF13lCI74eVM69mb8jedrDR
 2ORQ==
X-Gm-Message-State: AOJu0YzeANYKCODHmQBZFwHRewfZSdBbOksphAZ5wGT8TOBJV6W3XORI
 SFNfr4TJW3ja+jK7/sjHuxIDCQPtHW5AkMZggC9Yd87zHUVqHJTMrORrzNL6S+N77rM7C9m5sqo
 =
X-Gm-Gg: ASbGnctoTyGfe5hP5OhVVjhSMtjhMMbz+8C26IRtxZ+vvjM32Qd7purFwxy7V/zySlz
 bj8Sz8rN8Bes5yJPFzaeByzcb6qBsNOh+s1vBNbtypMb3KHlNRp3NXTa6eHQGA8zSG3CHzTqNDM
 u4fAgSzaysAdHsfYQVHZIEYSz939snkHDgAK+n/PiIeAhbKRqnp8KcuMg83h/bYT0CxR+6C6CxV
 fhdBAap8biWGkJjiVUwWX82YCblUR1f8A0I2wF5F9I5NB1YenMADalzGw82kSb/mLLqabt0yyWV
 ExIy2+Ub+RSp/5dlfI17gnLDPNS9odd1xQPw9KWOm2Ztq6DymkWtG54xGe6ljcg=
X-Google-Smtp-Source: AGHT+IG0BOLFNWemu7dSrp5oMTBZuMJSWJQKkbnvKtPXh4O+wjeqcP1bQRXR+MTBeSSUeLx6Gy40mw==
X-Received: by 2002:a92:c268:0:b0:3d0:443d:a5ad with SMTP id
 e9e14a558f8ab-3d2fc0c3483mr13252965ab.2.1740438488507; 
 Mon, 24 Feb 2025 15:08:08 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:08:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 34/44] x86: Support a 64-bit ramdisk address
Date: Mon, 24 Feb 2025 16:06:23 -0700
Message-ID: <20250224230640.2665206-35-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

Add some missing pieces to bootparams so that a 64-bit ramdisk address
can be used. Tidy up the logging while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to support a 64-bit ramdisk address

 arch/x86/include/asm/bootparam.h | 15 ++++++++++++++-
 arch/x86/lib/zimage.c            | 12 +++++++-----
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/bootparam.h b/arch/x86/include/asm/bootparam.h
index ac4865300f1..657d920b14f 100644
--- a/arch/x86/include/asm/bootparam.h
+++ b/arch/x86/include/asm/bootparam.h
@@ -122,6 +122,14 @@ struct efi_info {
 	__u32 efi_memmap_hi;
 };
 
+/* Gleaned from OFW's set-parameters in cpu/x86/pc/linux.fth */
+struct olpc_ofw_header {
+	__u32 ofw_magic;	/* OFW signature */
+	__u32 ofw_version;
+	__u32 cif_handler;	/* callback into OFW */
+	__u32 irq_desc_table;
+} __attribute__((packed));
+
 /* The so-called "zeropage" */
 struct boot_params {
 	struct screen_info screen_info;			/* 0x000 */
@@ -134,7 +142,12 @@ struct boot_params {
 	__u8  hd0_info[16];	/* obsolete! */		/* 0x080 */
 	__u8  hd1_info[16];	/* obsolete! */		/* 0x090 */
 	struct sys_desc_table sys_desc_table;		/* 0x0a0 */
-	__u8  _pad4[144];				/* 0x0b0 */
+	struct olpc_ofw_header olpc_ofw_header;		/* 0x0b0 */
+	__u32 ext_ramdisk_image;			/* 0x0c0 */
+	__u32 ext_ramdisk_size;				/* 0x0c4 */
+	__u32 ext_cmd_line_ptr;				/* 0x0c8 */
+	__u8  _pad4[112];				/* 0x0cc */
+	__u32 cc_blob_address;				/* 0x13c */
 	struct edid_info edid_info;			/* 0x140 */
 	struct efi_info efi_info;			/* 0x1c0 */
 	__u32 alt_mem_k;				/* 0x1e0 */
diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index 3ffc7593f87..bd1ee273dec 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -222,7 +222,7 @@ struct boot_params *load_zimage(char *image, unsigned long kernel_size,
 	else
 		*load_addressp = ZIMAGE_LOAD_ADDR;
 
-	printf("Building boot_params at 0x%8.8lx\n", (ulong)setup_base);
+	printf("Building boot_params at %lx\n", (ulong)setup_base);
 	memset(setup_base, 0, sizeof(*setup_base));
 	setup_base->hdr = params->hdr;
 
@@ -298,10 +298,13 @@ int setup_zimage(struct boot_params *setup_base, char *cmd_line, int auto_boot,
 		hdr->type_of_loader = 0x80;	/* U-Boot version 0 */
 		if (initrd_addr) {
 			printf("Initial RAM disk at linear address "
-			       "0x%08lx, size %ld bytes\n",
-			       initrd_addr, initrd_size);
+			       "%lx, size %lx (%ld bytes)\n",
+			       initrd_addr, initrd_size, initrd_size);
 
 			hdr->ramdisk_image = initrd_addr;
+			setup_base->ext_ramdisk_image = 0;
+			setup_base->ext_ramdisk_size = 0;
+			setup_base->ext_cmd_line_ptr = 0;
 			hdr->ramdisk_size = initrd_size;
 		}
 	}
@@ -372,8 +375,7 @@ int zboot_load(struct bootm_info *bmi)
 		struct boot_params *from = (struct boot_params *)bmi->base_ptr;
 
 		base_ptr = (struct boot_params *)DEFAULT_SETUP_BASE;
-		log_debug("Building boot_params at 0x%8.8lx\n",
-			  (ulong)base_ptr);
+		log_debug("Building boot_params at %lx\n", (ulong)base_ptr);
 		memset(base_ptr, '\0', sizeof(*base_ptr));
 		base_ptr->hdr = from->hdr;
 	} else {
-- 
2.43.0

