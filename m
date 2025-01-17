Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E214EC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 20:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 370708069D;
	Fri, 17 Jan 2025 21:34:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="A0U3jYJm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7703480716; Fri, 17 Jan 2025 21:34:12 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B0480423
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 21:34:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DD23A408D1; 
 Fri, 17 Jan 2025 20:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737146048;
 bh=KVMFYC+0CVpBok66Hdo/V4aL6s+kkU8DW3PQpbdkys4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=A0U3jYJm4jgb4E4Da1JNwgCmkCB+ei7bjZlByCzGJAVxjTas+bxDKbaLzRGtgpmdS
 ftLEe6JGlTWUNheIiSdp1QoZZqXK7f9dd7+QQPuSwPlGUiX1D1sn5Tt4TJ8YKi4T3E
 ous0zU3QzXXmYrM/vQaHzrPi7wE658BcgoVqg4t3FLhsZ3FuLhws7Su2CDTNpamolt
 thC+mUVGu481ZraAdww7NNzUuL5cJ2ZNVL1UTxB/Uwa/fntuwjiCUggkJPcSIx5feW
 pFSezpq0QmbZEgJ2pONBo9vyyQWtolz92N2sxyAemZ92JMljUxtlkJd0hfBBE5Jf5A
 kO9pzMZfz5aGw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: reduce UEFI size if HAS_BOARD_SIZE_LIMIT=y
Date: Fri, 17 Jan 2025 21:34:01 +0100
Message-ID: <20250117203401.23380-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

If a board has a strict size limit, disable

* Unicode capitalization and
* HII protocols

by default to reduce the image size.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index c46ffe3a9d8..59df4e19cb6 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -386,7 +386,7 @@ config EFI_DT_FIXUP
 
 config EFI_LOADER_HII
 	bool "HII protocols"
-	default y
+	default y if !HAS_BOARD_SIZE_LIMIT
 	help
 	  The Human Interface Infrastructure is a complicated framework that
 	  allows UEFI applications to draw fancy menus and hook strings using
@@ -406,7 +406,7 @@ if EFI_UNICODE_COLLATION_PROTOCOL2
 
 config EFI_UNICODE_CAPITALIZATION
 	bool "Support Unicode capitalization"
-	default y
+	default y if !HAS_BOARD_SIZE_LIMIT
 	help
 	  Select this option to enable correct handling of the capitalization of
 	  Unicode codepoints in the range 0x0000-0xffff. If this option is not
-- 
2.47.1

