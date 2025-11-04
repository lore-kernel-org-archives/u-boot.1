Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3156CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 11:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 042DE808AF;
	Tue,  4 Nov 2025 12:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="G0odh4gZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCC098144A; Tue,  4 Nov 2025 12:03:08 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B5968003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 12:03:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7CE3E408A3; 
 Tue,  4 Nov 2025 11:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762254185;
 bh=yCMx1VZeAxqKAP6AS2ozyL0bEPq+wR92PBjPTQwIJds=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=G0odh4gZW2HRcgSKxA68MPjYtA5ER4ZjitQkRJGPSA6d58oW1nNSRTh5zl9kKdv/s
 mCXqy3QBb/me+etX0eyBraYFvQWpTRLw/q8uAwJft8iBaa3Me4e9Uax3896mipE9XI
 ixyOVVh5JPOOFzpwvcT9zYC6k5rDUv2WNefYhEzV6ZLHhtI2rlKltDrn0efX590C08
 uwB4hFEGQ8NhF0Ixlvi5hJOZsgiKB++k70rKULUxrgvsM8RAIlcBQJn8ueOoL9Vt3U
 WXEK9UrJ6CC/682zUCRrTl7dqdMGOPDKhnIr6NWGpUWC7YdB1Q44cTGIoVzYVz3ND7
 lZCm2jvZT9qFU32v1clXGofJJKtgZ4oZJzLt6soP7/lVanIQ21/nU/KOe2JaK0Pkav
 a3oTy81+RviNg7jODJxGBV4hB24zQpFXJhNMQKId2Y/g1bsjBwsxv6YeNDc4gyzY+v
 YzcSjxhlv7RUdU1F4n3wQRYG/UDsUWZs4haCN6oKiVxD8kSHeivMZjoz4CxdpNUClP
 hMmMoFqNqqAFjs0OjhQwN2LECajZB1ihgr6qwwlo+CqOA5BTHZKDvWFBXFHanwaZVG
 y2W0jYvARFDQ31GsUPi99m6hmboq0zYrDDu3qCiSvFudCcOUEIWTDAGc0rBw7yQ2o2
 v2mlcEj/F5MYi0rSQZKnKjRE=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tobias Waldekranz <tobias@waldekranz.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: correct struct efi_priv description
Date: Tue,  4 Nov 2025 12:02:40 +0100
Message-ID: <20251104110240.62368-1-heinrich.schuchardt@canonical.com>
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

Add a missing colon ':' to match Sphinx style.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/efi.h b/include/efi.h
index 66725b876f9..b98871fedad 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -454,7 +454,7 @@ static inline struct efi_mem_desc *efi_get_next_mem_desc(
  * @memmap_key: Key returned from get_memory_map()
  * @memmap_desc: List of memory-map records
  * @memmap_alloc: Amount of memory allocated for memory map list
- * @memmap_size Size of memory-map list in bytes
+ * @memmap_size: Size of memory-map list in bytes
  * @memmap_desc_size: Size of an individual memory-map record, in bytes
  * @memmap_version: Memory-map version
  *
-- 
2.51.0

