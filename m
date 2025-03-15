Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A00C28B30
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B68CE81F32;
	Sat, 15 Mar 2025 15:28:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VWnG8dk0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDF7281F0B; Sat, 15 Mar 2025 15:28:28 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D64FA81E25
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:28:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3913b539aabso1899999f8f.2
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048905; x=1742653705; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CaaQnQ47zK2KuiITYwjJ4Zaer8HBHGv3M4EKx9sYM9g=;
 b=VWnG8dk0V/cTx87X1FmyS5OJ5Bz1q4PigvHxmY7EPifW9jkVqaLFfujCc+yfLxmFdn
 ip3KBsv5UTCDuc0gTR8o7Wu02KkvbKfIUgQnpYXYLEq9TLXfBJQE2vHWmtfoV73uKCj4
 esQN+oG3XOVdo3l5LoKZZNjxUI1zr/COlPBHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048905; x=1742653705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CaaQnQ47zK2KuiITYwjJ4Zaer8HBHGv3M4EKx9sYM9g=;
 b=r5HdLzqsifVvM0/A8vsWpIJ30S37carhKiHQQFPEraJFoA1CWBUBFczSK4VusmjV0E
 qDKuQ8VSYHQzugsIvuqH1oGy6yaigrRw2BSUabjzE43CJbMiIDSb0z6h7iXCbjbWTlLm
 8PtVsYeCEZCOdVoY1QJYGV45qIoYiy+aGrLZoUONdpnTCIU4bFDocto1inhfJZAsQV3D
 ttG6TIIBsnvYs26ZY6UjvIVX6FoywpsBCYsEkLl06zAMrl9XZKkP1mqzs1G5w4XVNK6i
 QXFEolrXQd9Y+FcI7QXtztGEedqCr2H9FtW/4RFgyCldo+XV4CD068LGeQu+6hpWN6cq
 FdwA==
X-Gm-Message-State: AOJu0YwJLmg0XW3XdsubLsZjk9LXzf4k+vPCUOQ/jxW+bwp/dvA2mRgM
 jHDUZE8D4BCmxA3HoGYHv0f7iWFXycDmiyyg8KTm7aVI5HynOnobR+ak1NikLUryRe011/wzW8o
 mlA==
X-Gm-Gg: ASbGncv5aR1wCRetRkNeyBoMBohpELHUfKfX1QdiEGhCKKQvrCyZm/waxUYvJpmH58Q
 jRh+7TILLHGKP6dcsYOJDR702AvAWQGWt7OWMjDBzfwRNWZFZ0LGqqCnQXg94KKajoY37qQMk9o
 OfwAbd8RvJIkT2AsMI5Y1lLz6uTh+vr0VQGU/yBT2eUskuzYqYGaecRnrGDmmmR2Z1dNAEQqZR6
 k+yH7pDjfjxrw7EN+EKHoz9Q09HbwSJ8ELryrM1hM9GKA0024TGVmhNASWA+syaMpd73r7wZHdc
 cIpksC88rKTfJRyexs5vFocOH17aKczd4q/mYTUYnwVQ9aSQI+o7
X-Google-Smtp-Source: AGHT+IHUVWEN/ZbO1yOWc4LGHCjaaE9iDiqMGcO6Ptt56M0YXIoJ+5ptheAO+/8/TTzlmugb0bHx1Q==
X-Received: by 2002:adf:a343:0:b0:391:2f15:c1f4 with SMTP id
 ffacd0b85a97d-3972130fd2cmr7333933f8f.55.1742048905364; 
 Sat, 15 Mar 2025 07:28:25 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:28:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 36/46] x86: Support a 64-bit ramdisk address
Date: Sat, 15 Mar 2025 14:25:56 +0000
Message-ID: <20250315142643.2600605-37-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

