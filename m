Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0A5C282DE
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4128381DCD;
	Thu,  6 Mar 2025 17:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ROevpHlw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E784581DCA; Thu,  6 Mar 2025 17:06:06 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF68C81D52
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-71e10e6a1ceso189769a34.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277163; x=1741881963; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CaaQnQ47zK2KuiITYwjJ4Zaer8HBHGv3M4EKx9sYM9g=;
 b=ROevpHlwBr5rOlgFF90QoZkEOC8APMLGsgP4o+OUzrJU6xWBqMnatxE1KD4KNdrfaB
 Wm54AOuqwBh5VoRodFibmzZsEWUiGCZcF7gNc4RPjj/kisJe5VG2x9zY1eUKsJLRQXCH
 4WhmGxYiWrTSdghq/FsHtoRV0w2Casqs+QFis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277163; x=1741881963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CaaQnQ47zK2KuiITYwjJ4Zaer8HBHGv3M4EKx9sYM9g=;
 b=qKcQg3TGYVnLudSzySnLSEZ0t+r1OiBmlWqF/qxWI2ool/8WzbHjkoohQQ22M97ytx
 m6c9DmUYSXPWbUOajKzHo0uS8O1heeOr5a+rz8+x/TRrzxaZDEZ5Q7YYFzf/C5Cp7Cyl
 COWIO0gJluQELmCEdf7HjIc8p/0YB2cYoOmhcWPD8ttMidCCL6rhn0OvMLzmNvkI4bOf
 fGIxlfZs5f33QAJQyIQwBY75lDrw3udPbe+84QiEx7gX7WOU1xtnyWs7mnSYcw6ycIfc
 3NWCjcMsLZPB2clp3XJNfbOathlj3KeiOfxlQealg6af+GLPKjdZQ2Wn1tt+CdaARLGi
 XpRA==
X-Gm-Message-State: AOJu0Yy5+WZj+0IRzkf9wmMAWU+WxFYMHd5HR3574PM1TRoqxT96dqnJ
 /GO3ThHMppattuqTaUddHnMVYZFzR1sKqSEC+eBKPLRGkpEHgU+fY8CVVIraFMfwpxLnFu23fNU
 =
X-Gm-Gg: ASbGnctBXq3aFO6KFu4eYpsZuesPZ7y8TLB70RhOgqAqysjhegjw3lv3RozavwM1G5F
 ByvuV59YCFqJXFqisxtvmIoBCSshdNz44nwxNj0fwomCJttgFOLfZxuV++9FkzWXagwkeHgC4DQ
 18IF99kitZFcjg8ywabHOG62yUaueYbWoUkylM+siNQXeF4Y4+ygtl7sb0IsFVts+SRCiQkEXls
 00vWwcJV3rjYDmlWboLsxe7C0Du1wXUZ2i6vg5F5E+W3rvCOXY8WosGbla0P6atuSYRhDxnEojM
 xNR2NTSAPUASYW4ufaPmLwJq4BuPZyI/pwOtPVgnj0IUs125gPIhCooklM2H+3YR07g5r+xltTY
 1y7p3Wg==
X-Google-Smtp-Source: AGHT+IGAmACAR2reMeYLH/amTwLV8HsmRN3fofo2SxslnvYYlnK2R/oOtvOiI06MDnC9FCCLlJLj9A==
X-Received: by 2002:a05:6830:6a8d:b0:727:3111:1416 with SMTP id
 46e09a7af769-72a1fca24bamr4503872a34.24.1741277162861; 
 Thu, 06 Mar 2025 08:06:02 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:06:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 36/47] x86: Support a 64-bit ramdisk address
Date: Thu,  6 Mar 2025 09:04:03 -0700
Message-ID: <20250306160428.3041057-37-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

(no changes since v3)

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

