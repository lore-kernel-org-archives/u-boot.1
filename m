Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0707C2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 11:38:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7A0288811;
	Wed,  3 Jul 2024 13:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15C0C882DB; Wed,  3 Jul 2024 13:38:09 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1CFB2887E3
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 13:38:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E4A71007;
 Wed,  3 Jul 2024 04:38:31 -0700 (PDT)
Received: from localhost.localdomain (X72Y076X74.nice.arm.com [10.34.125.15])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 A7AA43F762; Wed,  3 Jul 2024 04:38:05 -0700 (PDT)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 1/2] efi: move guid helper functions to efi.h
Date: Wed,  3 Jul 2024 13:37:55 +0200
Message-ID: <20240703113756.1293218-2-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703113756.1293218-1-vincent.stehle@arm.com>
References: <20240627170629.2696427-1-vincent.stehle@arm.com>
 <20240703113756.1293218-1-vincent.stehle@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Move the guidcmp() and guidcpy() functions to efi.h, near the definition of
the efi_guid_t type those functions deal with.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 include/efi.h        | 10 ++++++++++
 include/efi_loader.h | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/efi.h b/include/efi.h
index c3c4b93f860..d5af2139946 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -78,6 +78,16 @@ typedef struct {
 	u8 b[16];
 } efi_guid_t __attribute__((aligned(4)));
 
+static inline int guidcmp(const void *g1, const void *g2)
+{
+	return memcmp(g1, g2, sizeof(efi_guid_t));
+}
+
+static inline void *guidcpy(void *dst, const void *src)
+{
+	return memcpy(dst, src, sizeof(efi_guid_t));
+}
+
 #define EFI_BITS_PER_LONG	(sizeof(long) * 8)
 
 /* Bit mask for EFI status code with error */
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 6c993e1a694..ca8fc0820f6 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -21,16 +21,6 @@
 struct blk_desc;
 struct jmp_buf_data;
 
-static inline int guidcmp(const void *g1, const void *g2)
-{
-	return memcmp(g1, g2, sizeof(efi_guid_t));
-}
-
-static inline void *guidcpy(void *dst, const void *src)
-{
-	return memcpy(dst, src, sizeof(efi_guid_t));
-}
-
 #if CONFIG_IS_ENABLED(EFI_LOADER)
 
 /**
-- 
2.43.0

