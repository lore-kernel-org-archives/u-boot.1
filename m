Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3876BD17120
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 18:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C19288F0A;
	Mon, 21 Oct 2024 20:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CGoLCmMg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11BCD88D51; Mon, 21 Oct 2024 20:01:29 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3CD288EA7
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 20:01:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from localhost.localdomain (1.general.zfsdt.uk.vpn [10.172.194.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 46E1540A5C; 
 Mon, 21 Oct 2024 18:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729533686;
 bh=7a26ypBmH1pSVwLYTsNUraigjTKACxEhrXx27KIKE/M=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=CGoLCmMgZzeGPmnVJQ8yu6PN75tShPVn12t9Voze36Iq9m25jpFMpJvSSLgvnxBZZ
 dP8YUVtkU8oSaPwRJ6WqPrnl07SXfvP8Orp169FBTgwGzw9NnTb1cFd/qqup2hQz3u
 DN4QNfLeigl2lu/CAACBerKUaUgLEM/Eyb0Q/T5CAq4jI3ZK1r/tF6ig84Vn7F1Dn+
 UaK8g3mtlup7NGOw+2eGASQG45C/YKKcMAYJbfeuFpmYFZmDZx9aq/4+h1duq7zSdZ
 SJSsZpdpVdZdEnD8tLBu24FP+Chz6wN452Yyja0taSg8D0k629gt+DFqky2eQZgMdi
 wqGHZBb+y1WxA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sean Anderson <sean.anderson@seco.com>, Nishanth Menon <nm@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Bryan Brattlof <bb@ti.com>,
 Dhruva Gole <d-gole@ti.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] doc: semihosting can only be once in TOC
Date: Mon, 21 Oct 2024 20:01:00 +0200
Message-ID: <20241021180101.18452-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241021180101.18452-1-heinrich.schuchardt@canonical.com>
References: <20241021180101.18452-1-heinrich.schuchardt@canonical.com>
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

Sphinx warns if a page is added to the table of contents twice.
Add a reference instead.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/board/emulation/index.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rst
index 98a0b26ad24..7d216f96a30 100644
--- a/doc/board/emulation/index.rst
+++ b/doc/board/emulation/index.rst
@@ -8,10 +8,13 @@ Emulation
 
    acpi
    blkdev
-   ../../usage/semihosting
    qemu-arm
    qemu-mips
    qemu-ppce500
    qemu-riscv
    qemu-x86
    qemu-xtensa
+
+Also see
+
+* :doc:`../../usage/semihosting`
-- 
2.45.2

