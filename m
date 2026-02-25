Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F01F357DA
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 07:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7B728366F;
	Wed, 25 Feb 2026 08:24:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jUBgD6x5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01DCC83DEA; Wed, 25 Feb 2026 08:24:04 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0208982A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:24:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 469DD40013; 
 Wed, 25 Feb 2026 07:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772004241;
 bh=m23M/BaocHNSWgJotcp684HJwazC2suRI3Ffm9pcYN0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=jUBgD6x5GAEuqgOvhgyXHdYS4ZrJvoHwl32Cdnex4L9pbw7uh8C0UyshH4RPHakl4
 b/AZ5d7+sZZqE2sPt5xhFcLwleMkRSq73IGThQwxeB8NSJrvvklXGXl2oK5oPquvZG
 N4IlREacRfOzZs9YErHOiF8Ga8JrFim13Ss1YEtjBT2CFV9u3enGZSdt3qhQP15+3h
 BzRfGjCxA22iIQpxQRVrDP3vCxJGzYEnRcEH7hL3cf2Keg/0sv8vJzJ+vkwajhwyM8
 z+9glFP/BdjVPaUE+RQKrw7wq1DB+EywSuToXLYsCVdOjmrI22AyNwrZhcEkQU4Vc+
 r536MhGgClLcdaLYuqn0ZeV1tg7ldi1oH/hXQ6rJdFBsLOGQSC/zN1/oHqob2YDIhU
 12vtAPdBvn/xwjs5RUf90OLk3FbIGIGlFGJAR0S9zJjHMX5sEfzvM5QuH+TFLgTBS1
 HTj7P+hSM0JGXcHE7GFDBrMrjihx9hVIwgDuQQA4+EruRpcybk8RWbKfiE6C0SFKIS
 LNfiFBKrANV7MXEWVxrqvwggEoe+ihZa12CF7G7+LVbbZxoNZxCtJ5kSwBMJU3Q6PJ
 vz0Q853tKIVWZ2boR2HNUgfedyL++g08/8CMuLLUltog9+sTLC+lZvRm/IssIu7P0L
 WADs3geOJG32jJVE6a1IqRN4=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] mbedtls: don't use non-existent CONFIG_TPL_LEGACY_CRYPTO.
Date: Wed, 25 Feb 2026 08:23:59 +0100
Message-ID: <20260225072359.50691-1-heinrich.schuchardt@canonical.com>
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

Symbol CONFIG_TPL_LEGACY_CRYPTO does not exist.
Don't select it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/mbedtls/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 789721ee6cd..1e0cf8579df 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -556,7 +556,6 @@ choice
 config TPL_LEGACY_HASHING_AND_CRYPTO
 	bool "legacy crypto libraries"
 	select TPL_LEGACY_HASHING
-	select TPL_LEGACY_CRYPTO
 
 config TPL_MBEDTLS_LIB
 	bool "MbedTLS libraries"
-- 
2.51.0

