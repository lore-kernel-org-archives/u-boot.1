Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521ACCCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 21:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C532783936;
	Tue,  4 Nov 2025 22:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gdX2B7mI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B0478393F; Tue,  4 Nov 2025 22:48:12 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C36768391C
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 22:48:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 80DAE402AB; 
 Tue,  4 Nov 2025 21:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762292888;
 bh=294oGhXnQdM90dD9X9wQ7+1rYJs6omCLLOIxAplKZZA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=gdX2B7mI9AefuZBtdnZOlQdL3SoHz/4SYPfxV9xeNjhWHcNUvkhNDqRxU36fB+Uid
 0xF25C5uvi6W6skdTWky31xs3Vz8gvqGJ3xuJYDH2MLWOsX5s/8Jj7yZwH+0eKq1bU
 V5/k5ZavJCVeamWZNUMzOK7iG/dmUroo/e8jVHqUfAPcR5ZiLOKsHy5Vlg5QcBwta4
 +2BZ8AyBDFwXH5okmZqfARs5KFY91RejCZIb9bv6Jla/5ZY2h/MlYWXFkB5D+c4Ea3
 DKzqqxSNhghlCobY8R03KBqnW/5ECroIRjoAPPGw7fUA+18Jxamw9hVVRQxkO2hOxN
 DQeAXPzgZ4eEFmXrwrVbyFZmLsR/S6lo5UF2n7YqIwbGGZjfdn+S7P2tXCbhnAqZqQ
 hqSDzKB+lqx8gZKSnpphkUi1WsTQnlF702JotNy3FeB7udjrGcmrwotkXM/5Jr35Cj
 6SqFH4X+xYi0A05i1MW4IARXzvhP5KuWdnOp559VUr3ZwdkOGUhMV84COE6s6lNvKV
 8y5bzLqCA89ByxpEgjHWgdKnEUqoOyvyKEoTKzhTBs6/Vo0XzDe2r8g2Cbe+7NR5ya
 6UNfp6rQ0mTSBY2oT6vT/6KHrViWAPTiISEF1H6WBjdMqT5nsa7MT8HADr4qrwfNSs
 B9LzMKL6wfn5/VOg3WZHk9hs=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: typo 'mange' in efi_net.c
Date: Tue,  4 Nov 2025 22:48:04 +0100
Message-ID: <20251104214804.18043-1-heinrich.schuchardt@canonical.com>
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

%s/mange/manage/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index b8a6e08ba8e..0f8a851e3f2 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -372,7 +372,7 @@ out:
 }
 
 /*
- * efi_net_receive_filters() - mange multicast receive filters
+ * efi_net_receive_filters() - manage multicast receive filters
  *
  * This function implements the ReceiveFilters service of the
  * EFI_SIMPLE_NETWORK_PROTOCOL. See the Unified Extensible Firmware Interface
-- 
2.51.0

