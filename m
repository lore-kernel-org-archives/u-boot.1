Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB70CE7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:24:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 588B3806F4;
	Wed,  1 Jan 2025 23:23:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NLkUlSGd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 955EA806E5; Wed,  1 Jan 2025 23:23:00 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8B298062B
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-215770613dbso107664305ad.2
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770176; x=1736374976; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GOAskS++J0sM8XTs9umDE5qKVh9YU/MsRZxQ0+mcdHI=;
 b=NLkUlSGdOizLrsFgehc7hRue0CeLmiN2CgGgm2ehuX6kTNOlRJSlKSFMj2q/1P2VBd
 OwZZ216ENW2FatOh/1SkFz5nQfFjL8ynXldesw9rDq9o3DTpoDM25+3tIobBehoDd0zH
 SX8HCjQX6Lo/SSsUtucvDI0wvkORpJxWW+FA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770176; x=1736374976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GOAskS++J0sM8XTs9umDE5qKVh9YU/MsRZxQ0+mcdHI=;
 b=F5z35wCSEoyffaaIOhMSndDt0bnGdCv4irnN1JMumzKMfIp0qVomw9Sovp9Br1BtqQ
 3g9q50fPfHVVn3NgAEQc5UeGKQzZqfU8Gn/L8crjCjv4dPMzH6IEzmQ8qEbOW56Uatxj
 0locOfEObsZbJehgTCkfRUCFJOym6I/eRSJNOhpdUZtbjI703KvgpEzFSVz2NKzR27c6
 y2YvoUp++yv7m+oNZCLcPf73nMkQqv+7cNfHyvbtnKdDL2gDS3ZIju3IjHdEuNxhhmDT
 RrsgqT77FeduX3alGC3ZEDKfxSiaPA0FBvp00UwM1zvVDC3ZTrX9B5QYyk0xNlwwPxZc
 NWVg==
X-Gm-Message-State: AOJu0YxWEFZpiGSpRLIGs77Zk+lz6TUr+Jp2+zUhCNal2+5HLT1/xD0D
 ZU/YKlWhhyRRCOJQ61HuF5NWEF/hP+JAQV6ZdHfmQODNva65Q+HZZneuSR8grCnNqsvJ76J+Rww
 =
X-Gm-Gg: ASbGnctp3QPNdm8egFrl5JZ1jku1p09Z7PhPcCat9HrbdSnIa9BIdnNXJZOWj7yDkjt
 sPwY6eYmKz0Aawzw28+E4fx2B4C4EZ0EAjY4BWI7S2w3IUzvwIujtiohifZ2dn3vo4aLI9i+fLb
 nbAQggwexqUhj34TQk3+RfboE/91AxNWFwtiNYvamQhkdkuld55cZqTqPvRb6IMuKieUX9PefDl
 EIj4Uq7q9/LNE+4zbOS1QoMFzNioZdXfB8Vp6O0l5VUhCM5w86MJvs=
X-Google-Smtp-Source: AGHT+IFC/ViuPOWcbRZQ/z7BMQQZn3R3Ab/B1szXUsje5T03tbEgYRrbsfv50BsR5sTlCgZUTZel3w==
X-Received: by 2002:a05:6a00:948a:b0:72a:a9d9:5a82 with SMTP id
 d2e1a72fcca58-72abdbdd3a6mr53082334b3a.0.1735770175699; 
 Wed, 01 Jan 2025 14:22:55 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:22:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 55/67] upl: Update and tidy writing of images
Date: Thu,  2 Jan 2025 11:09:41 +1300
Message-ID: <20250101221003.1944600-56-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

The current implementation of images does not cover all the requirements
of the current, updated UPL spec. Add support for an entry address, the
offset of the image within the FIT as well as the load address and size,
which are subsumed into the new 'reg' property.

Support writing this information out to the UPL handoff.

Update SPL to handle the struct change as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_read.c      | 51 +++++++++++--------------------------------
 boot/upl_write.c     | 52 ++++++++++++++++----------------------------
 cmd/upl.c            |  4 ++--
 common/spl/spl_upl.c |  5 +++--
 include/upl.h        | 34 ++++++++++++++---------------
 test/boot/upl.c      | 36 +++++++++++++++---------------
 6 files changed, 73 insertions(+), 109 deletions(-)

diff --git a/boot/upl_read.c b/boot/upl_read.c
index 8fcc5a77c15..99f7a83ff0a 100644
--- a/boot/upl_read.c
+++ b/boot/upl_read.c
@@ -46,39 +46,6 @@ static int read_addr(const struct upl *upl, ofnode node, const char *prop,
 	return ret;
 }
 
-/**
- * read_size() - Read a size
- *
- * Reads a size in the correct format, either 32- or 64-bit
- *
- * @upl: UPL state
- * @node: Node to read from
- * @prop: Property name to read
- * @addr: Place to put the size
- * Return: 0 if OK, -ve on error
- */
-static int read_size(const struct upl *upl, ofnode node, const char *prop,
-		     ulong *sizep)
-{
-	int ret;
-
-	if (upl->size_cells == 1) {
-		u32 val;
-
-		ret = ofnode_read_u32(node, prop, &val);
-		if (!ret)
-			*sizep = val;
-	} else {
-		u64 val;
-
-		ret = ofnode_read_u64(node, prop, &val);
-		if (!ret)
-			*sizep = val;
-	}
-
-	return ret;
-}
-
 /**
  * ofnode_read_bitmask() - Read a bit mask from a string list
  *
@@ -332,11 +299,19 @@ static int decode_upl_images(struct upl *upl, ofnode options)
 	ofnode_for_each_subnode(node, images) {
 		struct upl_image img;
 
-		ret = read_addr(upl, node, UPLP_LOAD, &img.load);
-		if (!ret)
-			ret = read_size(upl, node, UPLP_SIZE, &img.size);
-		if (!ret)
-			ret = read_uint(node, UPLP_OFFSET, &img.offset);
+		memset(&img, '\0', sizeof(img));
+		buf = ofnode_read_prop(node, UPLP_REG, &size);
+		if (!buf)
+			return log_msg_ret("dui", ret);
+		ret = decode_addr_size(upl, buf, size, &img.reg);
+		log_debug("node %s: ret=%d, base=%llx\n", ofnode_get_name(node),
+			  ret, img.reg.base);
+		if (ret < 0)
+			return log_msg_ret("duI", ret);
+
+		read_addr(upl, node, UPLP_ENTRY, &img.entry);
+
+		ret = read_uint(node, UPLP_OFFSET, &img.offset);
 		img.description = ofnode_read_string(node, UPLP_DESCRIPTION);
 		if (!img.description)
 			return log_msg_ret("sim", ret);
diff --git a/boot/upl_write.c b/boot/upl_write.c
index 32c68308149..4b4232af6e5 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -37,30 +37,6 @@ static int write_addr(const struct upl *upl, ofnode node, const char *prop,
 	return ret;
 }
 
-/**
- * write_size() - Write a size
- *
- * Writes a size in the correct format, either 32- or 64-bit
- *
- * @upl: UPL state
- * @node: Node to write to
- * @prop: Property name to write
- * @size: Size to write
- * Return: 0 if OK, -ve on error
- */
-static int write_size(const struct upl *upl, ofnode node, const char *prop,
-		      ulong size)
-{
-	int ret;
-
-	if (upl->size_cells == 1)
-		ret = ofnode_write_u32(node, prop, size);
-	else
-		ret = ofnode_write_u64(node, prop, size);
-
-	return ret;
-}
-
 /**
  * ofnode_write_bitmask() - Write a bit mask as a string list
  *
@@ -309,24 +285,34 @@ static int add_upl_images(const struct upl *upl, ofnode options)
 		return log_msg_ret("upi", ret);
 
 	for (i = 0; i < upl->image.count; i++) {
-		const struct upl_image *img = alist_get(&upl->image, i,
-							struct upl_image);
+		const struct upl_image *img;
+		char buf[sizeof(u64) * 4];
 		ofnode subnode;
-		char name[10];
+		char name[30];
+		int len;
 
-		snprintf(name, sizeof(name), UPLN_IMAGE "-%d", i + 1);
+		img = alist_get(&upl->image, i, struct upl_image);
+		snprintf(name, sizeof(name), UPLN_IMAGE "@%llx", img->reg.base);
 		ret = ofnode_add_subnode(node, name, &subnode);
 		if (ret)
 			return log_msg_ret("sub", ret);
 
-		ret = write_addr(upl, subnode, UPLP_LOAD, img->load);
-		if (!ret)
-			ret = write_size(upl, subnode, UPLP_SIZE, img->size);
+		len = encode_addr_size(upl, buf, sizeof(buf), &img->reg);
+		if (len < 0)
+			return log_msg_ret("rbf", len);
+		ret = ofnode_write_prop(subnode, UPLP_REG, buf, len, true);
+
+		if (!ret && img->entry) {
+			ret = write_addr(upl, subnode, UPLP_ENTRY, img->entry);
+			if (ret < 0)
+				return log_msg_ret("uwr", ret);
+		}
 		if (!ret && img->offset)
 			ret = ofnode_write_u32(subnode, UPLP_OFFSET,
 					       img->offset);
-		ret = ofnode_write_string(subnode, UPLP_DESCRIPTION,
-					  img->description);
+		if (!ret)
+			ret = ofnode_write_string(subnode, UPLP_DESCRIPTION,
+						  img->description);
 		if (ret)
 			return log_msg_ret("sim", ret);
 	}
diff --git a/cmd/upl.c b/cmd/upl.c
index 676e8f1f9e2..461f8f4f0aa 100644
--- a/cmd/upl.c
+++ b/cmd/upl.c
@@ -37,8 +37,8 @@ static int do_upl_info(struct cmd_tbl *cmdtp, int flag, int argc,
 			const struct upl_image *img =
 				alist_get(&upl->image, i, struct upl_image);
 
-			printf("image %d: load %lx size %lx offset %x: %s\n", i,
-			       img->load, img->size, img->offset,
+			printf("image %d: load %llx size %lx entry %lx offset %x: %s\n",
+			       i, img->reg.base, img->reg.size, img->entry, img->offset,
 			       img->description);
 		}
 	}
diff --git a/common/spl/spl_upl.c b/common/spl/spl_upl.c
index 5777148bbe4..71b699aed23 100644
--- a/common/spl/spl_upl.c
+++ b/common/spl/spl_upl.c
@@ -38,8 +38,9 @@ int _upl_add_image(int node, ulong load_addr, ulong size, const char *desc)
 	struct upl *upl = &s_upl;
 	struct upl_image img;
 
-	img.load = load_addr;
-	img.size = size;
+	memset(&img, '\0', sizeof(img));
+	img.reg.base = load_addr;
+	img.reg.size = size;
 	img.offset = node;
 	img.description = desc;
 	if (!alist_add(&upl->image, img))
diff --git a/include/upl.h b/include/upl.h
index cff3401a932..19fa78b108e 100644
--- a/include/upl.h
+++ b/include/upl.h
@@ -35,8 +35,7 @@ struct unit_test_state;
 #define UPLN_IMAGE		"image"
 #define UPLP_FIT		"fit"
 #define UPLP_CONF_OFFSET	"conf-offset"
-#define UPLP_LOAD		"load"
-#define UPLP_SIZE		"size"
+#define UPLP_ENTRY		"entry"
 #define UPLP_OFFSET		"offset"
 #define UPLP_DESCRIPTION	"description"
 
@@ -91,21 +90,6 @@ enum upl_boot_mode {
 	UPLBM_COUNT,
 };
 
-/**
- * struct upl_image - UPL image informaiton
- *
- * @load: Address image was loaded to
- * @size: Size of image in bytes
- * @offset: Offset of the image in the FIT (0=none)
- * @desc: Description of the iamge (taken from the FIT)
- */
-struct upl_image {
-	ulong load;
-	ulong size;
-	uint offset;
-	const char *description;
-};
-
 /**
  * struct memregion - Information about a region of memory
  *
@@ -117,6 +101,22 @@ struct memregion {
 	ulong size;
 };
 
+/**
+ * struct upl_image - UPL image informaiton
+ *
+ * @reg: address and size of image in memory (within FIT)
+ * @offset: Offset of the image in the FIT (0=none)
+ * @load: Address image should be loaded to
+ * @entry: Entry address to jump to (must be within the image), or 0 if none
+ * @desc: Description of the iamge (taken from the FIT)
+ */
+struct upl_image {
+	struct memregion reg;
+	uint offset;
+	ulong entry;
+	const char *description;
+};
+
 /**
  * struct upl_mem - Information about physical-memory layout
  *
diff --git a/test/boot/upl.c b/test/boot/upl.c
index 8e1a016943a..264aab3038c 100644
--- a/test/boot/upl.c
+++ b/test/boot/upl.c
@@ -53,16 +53,18 @@ int upl_get_test_data(struct unit_test_state *uts, struct upl *upl)
 	upl->acpi_nvs_size = 0x100;
 
 	/* image[0] */
-	img.load = 0x1;
-	img.size = 0x2;
+	img.reg.base = 0x1;
+	img.reg.size = 0x2;
 	img.offset = 0x3;
+	img.entry = 0x4;
 	img.description = "U-Boot";
 	ut_assertnonnull(alist_add(&upl->image, img));
 
 	/* image[1] */
-	img.load = 0x4;
-	img.size = 0x5;
-	img.offset = 0x6;
+	img.reg.base = 0x5;
+	img.reg.size = 0x6;
+	img.offset = 0x7;
+	img.entry = 0x8;
 	img.description = "ATF";
 	ut_assertnonnull(alist_add(&upl->image, img));
 
@@ -155,24 +157,24 @@ int upl_get_test_data(struct unit_test_state *uts, struct upl *upl)
 	return 0;
 }
 
-static int compare_upl_image(struct unit_test_state *uts,
-			     const struct upl_image *base,
-			     const struct upl_image *cmp)
+static int compare_upl_memregion(struct unit_test_state *uts,
+				 const struct memregion *base,
+				 const struct memregion *cmp)
 {
-	ut_asserteq(base->load, cmp->load);
+	ut_asserteq(base->base, cmp->base);
 	ut_asserteq(base->size, cmp->size);
-	ut_asserteq(base->offset, cmp->offset);
-	ut_asserteq_str(base->description, cmp->description);
 
 	return 0;
 }
 
-static int compare_upl_memregion(struct unit_test_state *uts,
-				 const struct memregion *base,
-				 const struct memregion *cmp)
+static int compare_upl_image(struct unit_test_state *uts,
+			     const struct upl_image *base,
+			     const struct upl_image *cmp)
 {
-	ut_asserteq(base->base, cmp->base);
-	ut_asserteq(base->size, cmp->size);
+	ut_assertok(compare_upl_memregion(uts, &base->reg, &cmp->reg));
+	ut_asserteq(base->offset, cmp->offset);
+	ut_asserteq(base->entry, cmp->entry);
+	ut_asserteq_str(base->description, cmp->description);
 
 	return 0;
 }
@@ -427,7 +429,7 @@ static int upl_test_info_norun(struct unit_test_state *uts)
 
 	img = alist_get(&upl->image, 1, struct upl_image);
 	ut_asserteq_str("firmware-1", fdt_get_name(fit, img->offset, NULL));
-	ut_asserteq(CONFIG_TEXT_BASE, img->load);
+	ut_asserteq(CONFIG_TEXT_BASE, img->reg.base);
 
 	return 0;
 }
-- 
2.43.0

