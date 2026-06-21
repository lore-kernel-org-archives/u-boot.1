Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B15CD98F0
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 08:20:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA499849E8;
	Sun, 21 Jun 2026 10:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="TVLcQBKG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D3A8849EB; Sun, 21 Jun 2026 10:19:26 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B448849BB
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 10:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-176-006-085-155.176.6.pool.telefonica.de
 [176.6.85.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id BE2673F1E4; 
 Sun, 21 Jun 2026 08:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782029962;
 bh=2YNHNUBXVOmEPpYUWqjMJEtfTaPcgAznd0qeyQdKmPg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=TVLcQBKGyMhufNTABUabNvlHawNCymwlCjDVxnD4VCeVntaUEwyakjNcCRcsB2OHb
 wHX5FmbMiR7QG97XkEPFJanZImqvGenw47uWbjoAbqmTOkLkbWCaIhb6xggq+bujbR
 q1vlr0uPC3F0gHHQdQroXcvphtl+dJ+bBk4idbsToK4CYlzWln8BqhGCAZM9qhKazA
 Ma+aGbqLpIbknS5s0AkFj882w8RHfN70tuOCAI442GGGC0pDUq4TpiORdiv3xE5iig
 rUVKZQfLpgqIR5OG0Ej9m4+92KAuDuu1Am912Wr+qRRy0WnEq70T78Bo3hwLBAVNZw
 xfC3qbWkOEHje1LMmfcGXxcF0yDeufp75ty1Vssi558OMqyt8SxCX/tdO1TNalUzEB
 BiF5JfRYNRoR6QeV6LgfHIwaK3sUNUpt7GwbdXjfr6jr/8zxtXd8r/2Rm/bSXhso7B
 ss1xRHCZRl1kHYiB9wqD5m/7Wiyg0xkUcGDBq+p8eITEkxGUTZ+p9cYN9hVa9kOcsH
 70onOAPvzh8/jovNpLQfJM850mbLhMP7moJqdeuOatEEKXqZhgiV171yV9WQFzBYUC
 TELssEhgLM1m1binH2TiT3KD8y91SAijXyXBlY3/j+JxtCpmtExaQeex3Mss0OLDxY
 HVY5Ncbd3bMtJWymxFxSrVRk=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 04/11] efi_loader: fix open_file_system() memory leak on
 fallback path
Date: Sun, 21 Jun 2026 10:19:08 +0200
Message-ID: <20260621081915.19154-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
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

In dtbdump.c and smbiosdump.c, open_file_system() falls back to
locating the UEFI system partition via locate_handle_buffer() when
the loaded image's own partition does not expose the simple file
system protocol. The handle buffer returned by locate_handle_buffer()
must be freed via free_pool().

The guard condition read 'if (handle)' (checking the image handle,
which is never NULL) instead of 'if (handle_buffer)', so the buffer
was freed unconditionally even when locate_handle_buffer() was never
called and handle_buffer remained NULL, and it also obscured the
intent. Change the condition to 'if (handle_buffer)'.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 lib/efi_loader/dtbdump.c    | 2 +-
 lib/efi_loader/smbiosdump.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/dtbdump.c b/lib/efi_loader/dtbdump.c
index 1e72404ecc1..865edc33a97 100644
--- a/lib/efi_loader/dtbdump.c
+++ b/lib/efi_loader/dtbdump.c
@@ -350,7 +350,7 @@ open_file_system(struct efi_simple_file_system_protocol **file_system)
 					EFI_OPEN_PROTOCOL_GET_PROTOCOL);
 	if (ret != EFI_SUCCESS)
 		error(u"Failed to open simple file system protocol\r\n");
-	if (handle)
+	if (handle_buffer)
 		bs->free_pool(handle_buffer);
 
 	return ret;
diff --git a/lib/efi_loader/smbiosdump.c b/lib/efi_loader/smbiosdump.c
index 974728a43af..494c3d18945 100644
--- a/lib/efi_loader/smbiosdump.c
+++ b/lib/efi_loader/smbiosdump.c
@@ -248,7 +248,7 @@ open_file_system(struct efi_simple_file_system_protocol **file_system)
 					EFI_OPEN_PROTOCOL_GET_PROTOCOL);
 	if (ret != EFI_SUCCESS)
 		error(u"Failed to open simple file system protocol\r\n");
-	if (handle)
+	if (handle_buffer)
 		bs->free_pool(handle_buffer);
 
 	return ret;
-- 
2.53.0

