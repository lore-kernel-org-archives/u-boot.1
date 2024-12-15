Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7E0E77180
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 02:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F6E980092;
	Sun, 15 Dec 2024 03:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="NpWAS8rz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 983D88006D; Sun, 15 Dec 2024 03:37:53 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0584C8006E
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 03:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7565141226; 
 Sun, 15 Dec 2024 02:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1734230270;
 bh=rE4jaRVRb+beysPu7GtTuOYoZ4Nuhx3OAW3UHab8uec=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=NpWAS8rzVfvmWP5Sa2Kl0HkehfcWjPuzlFeLZ+eoVkccGBhYFQTB/+Cr+r6rj3NdN
 OWwvBIncN4FMUjB+8Vno+a1TBVOMvv7AGvr1MY2Md6qP14xmqvmBkKQ0zbPrzxjBwv
 H/6u7UGgrJPx/izjqhuFffJBNCOQcv2e24neodgjbYlRDqNzpPsBRvcZ0zG0cA0hhz
 zeZLsU1QMf7tSM59jPvJvkN6xw84RElJ4X0w/yaChNos+IcXugCHUFwZ7JVhw62IDi
 f2hqxnQGtGe3qzc4FpOROpjn1599gWVMa3LIX8kMmXQ4dtkejWpHkxvNIVz6P0TDoc
 w7JJ3mg5AJNbw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] scripts/checkpatch.pl: allow special characters in
 spelling.txt
Date: Sun, 15 Dec 2024 03:37:31 +0100
Message-ID: <20241215023732.68902-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241215023732.68902-1-heinrich.schuchardt@canonical.com>
References: <20241215023732.68902-1-heinrich.schuchardt@canonical.com>
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

Checkpatch.pl uses the misspelled words from spelling.txt both as keys of a
hash and as part of a regular expression. For usage in the regular
expression special characters like the plus sign need to be escaped.

Escape special characters in the list of misspelled words.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b8eb57f38c7..cee60e390e7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -942,7 +942,7 @@ if ($codespell) {
 	}
 }
 
-$misspellings = join("|", sort keys %spelling_fix) if keys %spelling_fix;
+$misspellings = join("|", map{quotemeta($_)} sort keys %spelling_fix) if keys %spelling_fix;
 
 sub read_words {
 	my ($wordsRef, $file) = @_;
-- 
2.45.2

