Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46065CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 11:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1A19808AF;
	Tue,  4 Nov 2025 12:07:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="dMTrw3A8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33341832AD; Tue,  4 Nov 2025 12:07:12 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F65E8003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 12:07:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 62F233F189; 
 Tue,  4 Nov 2025 11:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762254427;
 bh=bEWWcmJBwXQzzYlpQ7AnAt0Mmh16fP7tqkcSKo2Hnw8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=dMTrw3A8bYIe9TAqtipt7p6jIONoSbLG/norqWJ6qO7lHlujdPUX8SouGnzzqlMgO
 WuGR2L9LjKpbwe2w0/VybXC/URq6kMq4HrUOYMrbMT3QJnbzoU+I9UQqYZVmHXgxzb
 fjYcS6FlGYsuTA5rOO9WqPyuMB2fJU//Cfo0PF6Hp4FupOgpqbzmwO0PcbWjZMLk9S
 e3c5GdqZ6qH94pp2sdpmDcR+dDsVZNb5hWzYj2oXPNnRpPSPxk+oXXSX8+BHrlTfZC
 3/s3Y8lfjQoPut+XRH9s0BMAlExZQOX2PD2QNEAP2/qNmw+uFnUg5RMHsz0Xrwq5If
 g+cJCzIJ972kZzT6CZKDXwad85LYreYzfVQ1wnUsd2WyoAcctbqMaZNMNSAGrXCSD8
 bS52TY3W1XmJUeSed2Pgx7eXVWRPkrD/rEqigEAKIKwWbDnPsQRP+k1y4e41bG4Qxk
 Ejho2NhtBikohMzQa2EdLolLB8a4Ha/P9RPif0eFrr86A9sC0Gp2fI9eS4gbU9Nr7+
 A6zVKh5LDbysJWD6BjlXHm40O9xchoP1NPODtDUOa2ZkEiFfBjVq6/yF2CUhmMbJzd
 QHgyqj5qQ/JMGTBkNa+W6O/5t5rhW0A3+EQ1oj6rpb+FLoqle6MUrHUma/NunkA8oh
 49wKj8+VnQqhVMtyZDs3Mixk=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Ying-Chun Liu <paul.liu@linaro.org>, Adriano Cordova <adrianox@gmail.com>,
 Yang Gang <yanggang@byosoft.com.cn>,
 Ben Wolsieffer <ben.wolsieffer@hefring.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi: Use struct efi_gop_mode_info in struct
 efi_entry_gopmode
Date: Tue,  4 Nov 2025 12:07:02 +0100
Message-ID: <20251104110702.62877-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Since C99 flexible array members are allowed at the end of structures.
We require C11.

Use struct efi_gop_mode_info in the definition of struct efi_entry_gopmode
to avoid code duplication and unnecessary conversions.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi.h     | 36 +++++++++++++++++++++++-------------
 include/efi_api.h |  9 ---------
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/include/efi.h b/include/efi.h
index f9bbb175c3a..66725b876f9 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -385,6 +385,28 @@ struct efi_entry_memmap {
 	struct efi_mem_desc desc[];
 };
 
+/**
+ * struct efi_gop_mode_info - graphics output mode information
+ */
+struct efi_gop_mode_info {
+	/** @version:	version of the data structure (use zero) */
+	u32 version;
+	/** @width:	horizontal screen size */
+	u32 width;
+	/** @height:	vertical screen size */
+	u32 height;
+	/** @pixel_format:   enum that specifies the storage format of pixels */
+	u32 pixel_format;
+	/**
+	 * @pixel_bitmask:   bitmasks used with PixelPixelBitMask
+	 *
+	 * The values which bits are used for red, green, blue, and alpha.
+	 */
+	u32 pixel_bitmask[4];
+	/** @pixels_per_scanline:	pixels per video memory line */
+	u32 pixels_per_scanline;
+};
+
 /**
  * struct efi_entry_gopmode - a GOP mode table passed to U-Boot
  *
@@ -404,19 +426,7 @@ struct efi_entry_gopmode {
 	 */
 	u64 fb_size;
 	u64 info_size;
-	/*
-	 * We cannot directly use 'struct efi_gop_mode_info info[]' here as
-	 * it causes compiler to complain: array type has incomplete element
-	 * type 'struct efi_gop_mode_info'.
-	 */
-	struct /* efi_gop_mode_info */ {
-		u32 version;
-		u32 width;
-		u32 height;
-		u32 pixel_format;
-		u32 pixel_bitmask[4];
-		u32 pixels_per_scanline;
-	} info[];
+	struct efi_gop_mode_info info[];
 };
 
 /**
diff --git a/include/efi_api.h b/include/efi_api.h
index 77a05f752e5..d4fdd50c49e 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -1490,15 +1490,6 @@ struct efi_hii_config_access_protocol {
 #define EFI_GOT_BGRA8		1
 #define EFI_GOT_BITMASK		2
 
-struct efi_gop_mode_info {
-	u32 version;
-	u32 width;
-	u32 height;
-	u32 pixel_format;
-	u32 pixel_bitmask[4];
-	u32 pixels_per_scanline;
-};
-
 struct efi_gop_mode {
 	u32 max_mode;
 	u32 mode;
-- 
2.51.0

