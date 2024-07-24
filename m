Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B73EC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5375F889E6;
	Wed, 24 Jul 2024 17:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Tz6LTEHk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7B23887F5; Wed, 24 Jul 2024 17:09:56 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8E478896E
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:09:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3737dc4a669so25737115ab.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833793; x=1722438593; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vobSoGhsqn912POxsBfd4AWQ0/zEws7WrznojH5l53Q=;
 b=Tz6LTEHkFWr0/YFWh7ISHME6rhGTvMOs1Jsp3nZFWpnmXW5r25keS08fv/GEk694eY
 0IEN9L3JGIWQMwvHVquMHVp1nhhIloRkFYFxuyTF0V6Oi3TiidWvbRngRlaPz9cxNoO0
 uCkIhrsIflQkepMv0KPKdq5dohAdiwSRepbvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833793; x=1722438593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vobSoGhsqn912POxsBfd4AWQ0/zEws7WrznojH5l53Q=;
 b=MfiKx0GWp2HY7QrkYfm2vv3Hr5JrT7nHsGgUT1LtaMdZujEpcufKrccRADEbBvwkpD
 ir4YSQzWLfkHaL1Xc1kRD7tXFkXoGetLHOATuYtVxtSltnxn1u6FjpPE3x8j93hj7g5i
 XQ8T1fLKwQaOENcOkc4e2R+D2jB3e459sXivKZt3/VL0UPLEnNY/K4V5LZug90ZTiXDz
 +WuzhP0Vx7/N4XMh66TG5tD+Wl2BDDfP1XHY+2v9votMT8XLbSZK3LE6x4XWl0UHUrSZ
 cxukMzgGAzZLfwX3QxqWzgNw5vAyrLjqCbAV4xvRZzakygsnz7aW9le2SqcMkbkHgZR5
 GazA==
X-Gm-Message-State: AOJu0YwpkZ1BLwCIQsmFQ8lQsT/ct1vzX6z4bDf89KG9+QAVfTmIKPn5
 OCIpw8oNt2GZrAMg1dUGAJiXf+oBJacog4ryai6eLEnqFLQav/+HjyRM6e8vQ81LEq0v3h5b/O8
 =
X-Google-Smtp-Source: AGHT+IF7sg2MmMi7rV6fz3o4D20Db+sNDNEdJoUIWcGLDJBiTYJ0ysben6r9HyjMVRymIk1br5+uyg==
X-Received: by 2002:a92:c24d:0:b0:39a:16f7:f9d3 with SMTP id
 e9e14a558f8ab-39a16f7fbd1mr37314255ab.9.1721833793188; 
 Wed, 24 Jul 2024 08:09:53 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymond.mao@linaro.org>, Shiji Yang <yangshiji66@outlook.com>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH 18/35] board_f: Move fdt_size to board
Date: Wed, 24 Jul 2024 09:09:05 -0600
Message-Id: <20240724150922.2343249-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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

This value is only really used before relocation. There is not much use
to showing its value in bdinfo, so drop it. Move it to the new boardf
struct.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/bdinfo.c                      |  1 -
 common/board_f.c                  | 11 +++++++----
 include/asm-generic/global_data.h |  4 ----
 include/board_f.h                 |  4 ++++
 test/cmd/bdinfo.c                 |  1 -
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index b53b51acca4..59fbaea498b 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -154,7 +154,6 @@ static int bdinfo_print_all(struct bd_info *bd)
 	if (IS_ENABLED(CONFIG_CMD_NET))
 		print_eth();
 	bdinfo_print_num_l("fdt_blob", (ulong)map_to_sysmem(gd->fdt_blob));
-	bdinfo_print_num_l("fdt_size", (ulong)gd->fdt_size);
 	if (IS_ENABLED(CONFIG_VIDEO))
 		show_video_info();
 #if CONFIG_IS_ENABLED(MULTI_DTB_FIT)
diff --git a/common/board_f.c b/common/board_f.c
index 2125eb5ca50..71194cccdb5 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -574,12 +574,15 @@ static int reserve_fdt(void)
 		 * section, then it will be relocated with other data.
 		 */
 		if (gd->fdt_blob) {
-			gd->fdt_size = ALIGN(fdt_totalsize(gd->fdt_blob), 32);
+			gd->boardf->fdt_size =
+				ALIGN(fdt_totalsize(gd->fdt_blob), 32);
 
-			gd->start_addr_sp = reserve_stack_aligned(gd->fdt_size);
-			gd->boardf->new_fdt = map_sysmem(gd->start_addr_sp, gd->fdt_size);
+			gd->start_addr_sp = reserve_stack_aligned(
+				gd->boardf->fdt_size);
+			gd->boardf->new_fdt = map_sysmem(gd->start_addr_sp,
+							 gd->boardf->fdt_size);
 			debug("Reserving %lu Bytes for FDT at: %08lx\n",
-			      gd->fdt_size, gd->start_addr_sp);
+			      gd->boardf->fdt_size, gd->start_addr_sp);
 		}
 	}
 
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index bd053f77f6c..81becbac2ad 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -225,10 +225,6 @@ struct global_data {
 	 * @fdt_blob: U-Boot's own device tree, NULL if none
 	 */
 	const void *fdt_blob;
-	/**
-	 * @fdt_size: space reserved for relocated device space
-	 */
-	unsigned long fdt_size;
 	/**
 	 * @fdt_src: Source of FDT
 	 */
diff --git a/include/board_f.h b/include/board_f.h
index 74fca6df75c..d9c793fbeb1 100644
--- a/include/board_f.h
+++ b/include/board_f.h
@@ -18,6 +18,10 @@ struct board_f {
 	 * @new_fdt: relocated device tree
 	 */
 	void *new_fdt;
+	/**
+	 * @fdt_size: space reserved for relocated device space
+	 */
+	unsigned long fdt_size;
 };
 
 #endif
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 60adc4aa960..591390560b7 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -185,7 +185,6 @@ static int bdinfo_test_all(struct unit_test_state *uts)
 	ut_assert(map_to_sysmem(gd->fdt_blob) == env_get_hex("fdtcontroladdr", 0x1234));
 	ut_assertok(test_num_l(uts, "fdt_blob",
 			       (ulong)map_to_sysmem(gd->fdt_blob)));
-	ut_assertok(test_num_l(uts, "fdt_size", (ulong)gd->fdt_size));
 
 	if (IS_ENABLED(CONFIG_VIDEO))
 		ut_assertok(test_video_info(uts));
-- 
2.34.1

