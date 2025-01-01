Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2567BE7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9486280601;
	Wed,  1 Jan 2025 23:23:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i8Ky82Un";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41AE88042F; Wed,  1 Jan 2025 23:23:10 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA49880379
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:23:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so154478075ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770186; x=1736374986; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j8z94d4iYTP+u4bAD2NRY4Y8mUiDm8jmfakroKKrAWc=;
 b=i8Ky82Un0+nT2nO5dYPL66V/SSSQwUIqBfW0CJhdVf90P2YTls6CMPfRF2xMggODpt
 fK0u0XAk9kL3VrpKcotlm9f1u7iRb9lj8bUHTOqdq1Dl+kwiBrxMQ+1Tf5QAdzqYmktD
 IAWSz7boUF3IDGOCucHkIPzN3Nj9P8JB0HjyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770186; x=1736374986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j8z94d4iYTP+u4bAD2NRY4Y8mUiDm8jmfakroKKrAWc=;
 b=OQSfM5wSkw95KyYqHMYb1TsOvFkL0NjbggndUARTPkZ5ebBMa3IfdyGRHhXn76hp/J
 H59fzjJ1YfYLcS4BHPKhfHvCsbJoTNwC0WG1p51H787V1x0IS8qVmt691ZfElGoyJV8i
 4jKnIWLN/QZrqC+UKo+KSUSuhpTFBm+KI2+sAwt9DNnu8CJSW6HoIexS/pNyzygs2pf9
 J2J+3nlUF94yM1M0gR3O6i0Y0lBh4q/OVPxo6w8M+1tZ8FK7TyjlhoWwNuECe0G0i7W9
 F079BF3lp6FiPa+5JXScNFtNzw98lkHOiaQhepSHsYrJ5kiSYDxFqWWeP1oIOwiJAK/C
 gekQ==
X-Gm-Message-State: AOJu0YytmnjErO/Zz3nBKoZFCTv/dy5kBW7y2/PHSjKmLsKCKy4uKl+P
 ehyyyWEupdCZGkwsOxMmCw2iYrmC/KalG6HThiCb3RVjy5dGFghDdVEHPT2PHxX5EiWc7Stzae4
 =
X-Gm-Gg: ASbGncv/QM4Kl74ZtK4F3nSJDBSp9oVJ+Bu7xQGfiFjwPpEVvoaN4lINjfwCSYW7m/q
 sPjVOqDOIpaCKe/mFvWPIBsnLujbntNIZm3s5lx0R8cgi4NhPKZxXhZXa+JlSM+/2MiUmvLXSzO
 3znnsl2+uNwDizcY6S36Nhku1YRAK9q0FQzniUbSTet1vJY1jZ35M6ZXPIriytK6zmZVFtNGlBS
 ZYYZMLIv9XNn0jl9Sdep05+/4qsw5liLeK8O8EN6s59IKdtEQR551k=
X-Google-Smtp-Source: AGHT+IFABQ5/okTAUjhGXtqGNjZ6HD5mia0cpwSVDXw5fB55ks9WDT71R2b6Wiyr/4Ju2/ebprS1jw==
X-Received: by 2002:a05:6a21:e92:b0:1db:822f:36d8 with SMTP id
 adf61e73a8af0-1e5e1e0424cmr60077316637.3.1735770185848; 
 Wed, 01 Jan 2025 14:23:05 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:23:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 58/67] upl: Drop acpi_nvs_size
Date: Thu,  2 Jan 2025 11:09:44 +1300
Message-ID: <20250101221003.1944600-59-sjg@chromium.org>
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

This was removed from the spec in favour of reserved-memory nodes. Drop
the field and its uses.

Future work will address the new implementation of ACPI NVS.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_read.c  | 3 ---
 boot/upl_write.c | 3 ---
 include/upl.h    | 3 ---
 test/boot/upl.c  | 2 --
 4 files changed, 11 deletions(-)

diff --git a/boot/upl_read.c b/boot/upl_read.c
index 99f7a83ff0a..4f07204546e 100644
--- a/boot/upl_read.c
+++ b/boot/upl_read.c
@@ -261,9 +261,6 @@ static int decode_upl_params(struct upl *upl, ofnode options)
 	ret = read_uint(node, UPLP_ADDR_WIDTH, &upl->addr_width);
 	if (ret)
 		return log_msg_ret("add", ret);
-	ret = read_uint(node, UPLP_ACPI_NVS_SIZE, &upl->acpi_nvs_size);
-	if (ret)
-		return log_msg_ret("nvs", ret);
 
 	return 0;
 }
diff --git a/boot/upl_write.c b/boot/upl_write.c
index 773c03ad1c6..79613a0f463 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -237,9 +237,6 @@ static int add_upl_params(const struct upl *upl, ofnode options)
 					   UPLBM_COUNT, upl->bootmode);
 	if (!ret)
 		ret = ofnode_write_u32(node, UPLP_ADDR_WIDTH, upl->addr_width);
-	if (!ret)
-		ret = ofnode_write_u32(node, UPLP_ACPI_NVS_SIZE,
-				       upl->acpi_nvs_size);
 	if (ret)
 		return log_msg_ret("cnf", ret);
 
diff --git a/include/upl.h b/include/upl.h
index 19fa78b108e..0d76595cc48 100644
--- a/include/upl.h
+++ b/include/upl.h
@@ -28,7 +28,6 @@ struct unit_test_state;
 #define UPLP_ACPI		"acpi"
 #define UPLP_BOOTMODE		"bootmode"
 #define UPLP_ADDR_WIDTH		"addr-width"
-#define UPLP_ACPI_NVS_SIZE	"acpi-nvs-size"
 
 #define UPLPATH_UPL_IMAGES	"/options/upl-images"
 #define UPLN_UPL_IMAGES		"upl-images"
@@ -253,7 +252,6 @@ struct upl_graphics {
  * @fit: Address and size of FIT image that was loaded
  * @conf_offset: Offset in FIT of the configuration that was selected
  * @addr_width: Adress-bus width of machine, e.g. 46 for 46 bits
- * @acpi_nvs_size: Size of the ACPI non-volatile-storage area in bytes
  * @image: Information about each image (struct upl_image)
  * @mem: Information about physical-memory regions (struct upl_mem)
  * @menmap: Information about logical-memory regions (struct upl_memmap)
@@ -269,7 +267,6 @@ struct upl {
 	struct memregion fit;
 	uint conf_offset;
 	uint addr_width;
-	uint acpi_nvs_size;
 
 	struct alist image;
 	struct alist mem;
diff --git a/test/boot/upl.c b/test/boot/upl.c
index 264aab3038c..7171f16e42e 100644
--- a/test/boot/upl.c
+++ b/test/boot/upl.c
@@ -50,7 +50,6 @@ int upl_get_test_data(struct unit_test_state *uts, struct upl *upl)
 	upl->fit.size = 0xabc;
 	upl->conf_offset = 0x234;
 	upl->addr_width = 46;
-	upl->acpi_nvs_size = 0x100;
 
 	/* image[0] */
 	img.reg.base = 0x1;
@@ -301,7 +300,6 @@ static int compare_upl(struct unit_test_state *uts, struct upl *base,
 	ut_asserteq(base->fit.size, cmp->fit.size);
 	ut_asserteq(base->conf_offset, cmp->conf_offset);
 	ut_asserteq(base->addr_width, cmp->addr_width);
-	ut_asserteq(base->acpi_nvs_size, cmp->acpi_nvs_size);
 
 	ut_asserteq(base->image.count, cmp->image.count);
 	for (i = 0; i < base->image.count; i++)
-- 
2.43.0

