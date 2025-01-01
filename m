Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C6BE7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:17:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66314806FE;
	Wed,  1 Jan 2025 23:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YHbByFSE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3F8C806EE; Wed,  1 Jan 2025 23:17:12 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B18D80040
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-216728b1836so129070505ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769828; x=1736374628; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O899JSdGYmDQY01OaNAV+A+mOeBgcXagOejON0M8PdA=;
 b=YHbByFSEARbXdxbJIYI19mSiPwpmGvDLoWjnMsEkxULob0jb1vJYfAm6CHi6iyXJUo
 P8w+0y/9daP7dGHQqtvDonfTO4aM54+Tkvdq0pGiIC8w2AiZkBmv1fziIlRLRGV4zEya
 db8GhKXLJGx4ZVG3LkMa6ppt9Sm0JSX0beevg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769828; x=1736374628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O899JSdGYmDQY01OaNAV+A+mOeBgcXagOejON0M8PdA=;
 b=Y2Yw00vXVrcHkdk1DvuJrQlFtUvTCufgadBdwZZuE2KQFk6VV0BmNICpZtdDR7qNql
 RliLHdvYBNqveDn5k0DKv427IVy6RzxpHM4O1naHt2YfvJ5pBGvc0rY3f0sNHB8+1zac
 FxxZcQa+4LNTGtTYRO/ZqNDdD5ZseoLOY0kSR0Pa8fBkxGKhzB3Y8WkH/dEVVTp3N72N
 btzqFMFF1J2X/5hvS9E3LsB5Zgt05C8gcRjMzOEvuuKyslaJDIJ70/q/Be0a4DikQ9rg
 81boazGSrC6YJjePdDaSgNroN3p+igPdk9VRYNjyuW/5bsuhkcvPGgyYWot9uSeLO4iO
 3Mtw==
X-Gm-Message-State: AOJu0Yy6DGPKrXmNn8RPsTZ55bJyaIUs04nf5Giu40RFRc1wCSL1INMx
 0RrtgBszuK5KCIxrVIOK2965NfiF1/4XJC/ANwp+lwMrnA8K3RtY9SV3/CfhzBoXHaDk1QleBIc
 =
X-Gm-Gg: ASbGncsdvL2F2/P/EO7crA1mbb81/XlxTH6sMdGkuhYHJeZzhGnenLFBhG99MeVtw15
 rD9kMF/ZbVYmE6seH6Omvolo5uv8GdpFQyjZudgboy+Zn5qUkHVEESUoefF8WtCgZljZAr2oX1D
 absR5NvqjvSxvZfpxcoQOucS2/VG0bqRWqR9yK/zN8A/ClM03bI7uzquA2blTeClK7BdjDllZCS
 yTzldaJ7khvfoE5wZowtOQl5opIG4b0F0/R6Y0eN2JNdnmdbUzi1ro=
X-Google-Smtp-Source: AGHT+IE63Ao5pVKpx4ARm3ixqxOqUUwq/MP5ONPl2ponW62kP0npJ1Dsl3ds9OGagjaSwphZGOOfMg==
X-Received: by 2002:a05:6a00:1702:b0:728:9d19:d2ea with SMTP id
 d2e1a72fcca58-72abddb2115mr64518400b3a.13.1735769828227; 
 Wed, 01 Jan 2025 14:17:08 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:17:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 41/67] upl: Use a 64-bit value for a memregion base-address
Date: Thu,  2 Jan 2025 11:09:27 +1300
Message-ID: <20250101221003.1944600-42-sjg@chromium.org>
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

With 32-bit machines sometimes a 64-bit address needs to be provided.
For example, ISA I/O access is indicated by setting bit 32 of the base
address.

Update the existing type to use 64 bits and drop the 0x prefix on unit
addresses.

Fix a 'nennap' typo while here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_write.c | 6 +++---
 include/upl.h    | 7 ++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/boot/upl_write.c b/boot/upl_write.c
index c53fa5396e8..c2bb3187803 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -315,7 +315,7 @@ static int write_mem_node(const struct upl *upl, ofnode parent,
 		return log_msg_ret("reg", -EINVAL);
 	}
 	first = alist_get(mem, 0, struct memregion);
-	sprintf(name, "%s@0x%lx", leaf, first->base);
+	sprintf(name, "%s@%llx", leaf, first->base);
 	ret = ofnode_add_subnode(parent, name, &node);
 	if (ret)
 		return log_msg_ret("wmn", ret);
@@ -466,7 +466,7 @@ static int add_upl_serial(const struct upl *upl, ofnode root,
 	if (!ser->reg.count)
 		return log_msg_ret("ser", -EINVAL);
 	first = alist_get(&ser->reg, 0, struct memregion);
-	sprintf(name, UPLN_SERIAL "@0x%lx", first->base);
+	sprintf(name, UPLN_SERIAL "@%llx", first->base);
 	ret = ofnode_add_subnode(root, name, &node);
 	if (ret)
 		return log_msg_ret("img", ret);
@@ -526,7 +526,7 @@ static int add_upl_graphics(const struct upl *upl, ofnode root)
 	if (!gra->reg.count)
 		return log_msg_ret("gra", -ENOENT);
 	first = alist_get(&gra->reg, 0, struct memregion);
-	sprintf(name, UPLN_GRAPHICS "@0x%lx", first->base);
+	sprintf(name, UPLN_GRAPHICS "@%llx", first->base);
 	ret = ofnode_add_subnode(root, name, &node);
 	if (ret)
 		return log_msg_ret("gra", ret);
diff --git a/include/upl.h b/include/upl.h
index ce357d16ebe..aef23ad8e8e 100644
--- a/include/upl.h
+++ b/include/upl.h
@@ -14,6 +14,7 @@
 #include <alist.h>
 #include <image.h>
 #include <dm/ofnode_decl.h>
+#include <asm/types.h>
 
 struct unit_test_state;
 
@@ -111,7 +112,7 @@ struct upl_image {
  * @size: Size in bytes
  */
 struct memregion {
-	ulong base;
+	u64 base;
 	ulong size;
 };
 
@@ -254,8 +255,8 @@ struct upl_graphics {
  * @acpi_nvs_size: Size of the ACPI non-volatile-storage area in bytes
  * @image: Information about each image (struct upl_image)
  * @mem: Information about physical-memory regions (struct upl_mem)
- * @nennap: Information about logical-memory regions (struct upl_memmap)
- * @nennap: Information about reserved-memory regions (struct upl_memres)
+ * @menmap: Information about logical-memory regions (struct upl_memmap)
+ * @memres: Information about reserved-memory regions (struct upl_memres)
  */
 struct upl {
 	int addr_cells;
-- 
2.43.0

