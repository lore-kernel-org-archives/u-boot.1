Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB785C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 18:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1769680FA8;
	Tue, 22 Apr 2025 20:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="NgHP/NPy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DBB4810E8; Tue, 22 Apr 2025 20:55:22 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0048180F9C
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 20:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-110-022.46.114.pool.telefonica.de
 [46.114.110.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 68E503F25A; 
 Tue, 22 Apr 2025 18:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745348118;
 bh=30Pcsabx//mPiDkvZOI1mIDH7Gp8QxcJYzX1SoOF+BQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=NgHP/NPyFugV1qt43waGWGrTadi2y8j5gpBwiexFFaX0IlSL2Z8ahe84zd1nEVYBN
 e81XM266rr2FYS940NTZ2p4jGvRUOWmZkU157WKkncLb/DNLYkV+Z0pcfsB8NQNNzu
 ZNdpqhyRyM/v5JEW/KNhavOcfoztd4LNq+DO3t5o1TZgXNvJMYpgMKK3rTZ/0L0cvv
 Y0VqTUXIf0wkVN8TRTsL9PFy0ftVFbttgwkrlMd8MFX78enXeLoz5lSOjbfME9Aznr
 c0IPZcrqHgJWsVYzeVHr+7tlhl3iLo91lj6mNwWdF+JQgD4hZydZzkFHG32rl/ZxPq
 Dh+KeEJAT314w==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Paul Burton <paul.burton@mips.com>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] configs: add UNIT_TESTS to big-endian Malta boards
Date: Tue, 22 Apr 2025 20:55:10 +0200
Message-ID: <20250422185510.11561-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

We currently only run the unit tests on low-endian boards.
We should run them on big-endian, too.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 configs/malta64_defconfig | 1 +
 configs/malta_defconfig   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/malta64_defconfig b/configs/malta64_defconfig
index ec5df0b5a7a..d1211b07f8a 100644
--- a/configs/malta64_defconfig
+++ b/configs/malta64_defconfig
@@ -46,3 +46,4 @@ CONFIG_PCI_MSC01=y
 CONFIG_RTC_MC146818=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_PORT_MAPPED=y
+CONFIG_UNIT_TEST=y
diff --git a/configs/malta_defconfig b/configs/malta_defconfig
index ca017c4865d..dfa37d1ddd9 100644
--- a/configs/malta_defconfig
+++ b/configs/malta_defconfig
@@ -45,3 +45,4 @@ CONFIG_PCI_MSC01=y
 CONFIG_RTC_MC146818=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_PORT_MAPPED=y
+CONFIG_UNIT_TEST=y
-- 
2.48.1

