Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12145C27C53
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 17:31:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE2F7881BC;
	Sun, 16 Jun 2024 19:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Q1pRQqTX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AABA87DCA; Sun, 16 Jun 2024 19:31:12 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 655C188189
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 19:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-041-025.um47.pools.vodafone-ip.de
 [178.202.41.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1293941FA9; 
 Sun, 16 Jun 2024 17:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718559068;
 bh=CM4xTnbr/AUZS8Rffe5z0f1EQOCyRGHfbxHQrUK1WI8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Q1pRQqTXft8rKF5yq/IyAC4uy2yTM8WYKl8g/VCWaEZkmGFxghllrHz+9igKrpTkV
 R+0stnWFPFASijXZoGODAvDSjpPzo3WJnA2tqSXPlXKn800S/7im5ju/reTikXzp4S
 DMIlB9JggeQBiveq8Af3UZ8XDOvtKXm6/hVQELMSLwU7F2Ja+e72c5bfxdpC6ZeM/e
 2YrYa05FV7iZNhjPtFbFF0uuacYzF5u2trWsBF4fsq0QRnX5wwS/BYZIQWmuqamEL/
 yO8ivjywoutrdC0wOz5f0SP0JCZOtCk28H6VuHc20v7+g4x02re7jPmjlyTZjMzg9w
 PD50X0KP6UT7w==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/3] efi_loader: avoid duplicate weak invalidate_icache_all()
Date: Sun, 16 Jun 2024 19:31:05 +0200
Message-ID: <20240616173105.7430-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240616173105.7430-1-heinrich.schuchardt@canonical.com>
References: <20240616173105.7430-1-heinrich.schuchardt@canonical.com>
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

If multiple weak implementations of a weak function exist, it is unclear
which one the linker should chose. cmd/cache.c already defines a weak
invalidate_icache_all().

We don't need a call to invalidate_icache_all() on x86.
ARM, RISC-V, and Sandbox provide an implementation.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_image_loader.c | 13 +++++++------
 lib/efi_loader/efi_runtime.c      |  7 ++++++-
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index 60424360328..45dc5b6b244 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -173,11 +173,6 @@ static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION *rel,
 	return EFI_SUCCESS;
 }
 
-void __weak invalidate_icache_all(void)
-{
-	/* If the system doesn't support icache_all flush, cross our fingers */
-}
-
 /**
  * efi_set_code_and_data_type() - determine the memory types to be used for code
  *				  and data.
@@ -986,7 +981,13 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 	/* Flush cache */
 	flush_cache((ulong)efi_reloc,
 		    ALIGN(virt_size, EFI_CACHELINE_SIZE));
-	invalidate_icache_all();
+
+	/*
+	 * If on x86 a write affects a prefetched instruction,
+	 * the prefetch queue is invalidated.
+	 */
+	if (!CONFIG_IS_ENABLED(X86))
+		invalidate_icache_all();
 
 	/* Populate the loaded image interface bits */
 	loaded_image_info->image_base = efi_reloc;
diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index 011bcd04836..05369c47b01 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -783,7 +783,12 @@ void efi_runtime_relocate(ulong offset, struct efi_mem_desc *map)
 	lastoff = offset;
 #endif
 
-        invalidate_icache_all();
+	/*
+	 * If on x86 a write affects a prefetched instruction,
+	 * the prefetch queue is invalidated.
+	 */
+	if (!CONFIG_IS_ENABLED(X86))
+		invalidate_icache_all();
 }
 
 /**
-- 
2.43.0

