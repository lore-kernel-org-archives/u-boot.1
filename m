Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A20C36017
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 07:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2929581ED8;
	Mon, 31 Mar 2025 09:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="au1nwQTg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BE0581EBB; Mon, 31 Mar 2025 09:24:38 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 051A381F6B
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 09:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-110-051.46.114.pool.telefonica.de
 [46.114.110.51])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B2C0D3FFD1; 
 Mon, 31 Mar 2025 07:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1743405869;
 bh=uEfkQcCQzlG1fWcAQDSF/RI6vxuvf0+EXt899VGDJvc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=au1nwQTg8yFuHG3NSohq9hbCLHUU3yF5TX8Xj0NJIhHRvaFQn0T5pP3kuGmxDtlkh
 kDRyP6B4BHyriOuArAiH7Uk5Ygws7dKZqQGcRpDH/jDjWPN4P8f+jCa7ONZnjjYxu8
 mQm2T5mOSskCHq4BkqbMXl9z+/9wTIYKZUUuZn1Qe1IgK73F9uxkf8KWhOEMk6cOw/
 VyNj4oZgv9EU5QrPHC5fmTgZP+iBN2fyczqUQqI16N1sZqfq5xO9pmiv4sSu4a94t8
 mSWwBUvrDWBhFIRAioijaEBuJvFxMpTAlZqZOGNHDHweVhFg6U5KNO0LHcQf+Nvj5W
 feT5Dw7XLjRfQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: E Shattow <e@freeshell.de>, E Shattow <lucent@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, H Bell <dmoo_dv@protonmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Simon Glass <sjg@chromium.org>,
 Andreas Schwab <schwab@suse.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 8/8] doc: jh7110: describe debug UART
Date: Mon, 31 Mar 2025 09:24:10 +0200
Message-ID: <20250331072410.8662-9-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331072410.8662-1-heinrich.schuchardt@canonical.com>
References: <20250331072410.8662-1-heinrich.schuchardt@canonical.com>
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

Provide the settings for using the debug UART in SPL.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 doc/board/starfive/jh7110_common.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/doc/board/starfive/jh7110_common.rst b/doc/board/starfive/jh7110_common.rst
index 44ccd612ff4..3c939d50de7 100644
--- a/doc/board/starfive/jh7110_common.rst
+++ b/doc/board/starfive/jh7110_common.rst
@@ -64,3 +64,17 @@ u-boot.itb via the Y-modem protocol.
 Due to restrictions of the boot ROM not all X-modem implementations are
 compatible. The package tio (https://github.com/tio/tio) has been found to be
 usable.
+
+Debug UART
+----------
+
+By default the SBI interface is used for the debug UART. But this only works
+in main U-Boot. To enable the debug UART in SPL, too, use the following
+settings::
+
+    CONFIG_DEBUG_UART=y
+    CONFIG_DEBUG_UART_NS16550=y
+    CONFIG_DEBUG_UART_BASE=0x10000000
+    CONFIG_SPL_DEBUG_UART_BASE=0x10000000
+    CONFIG_DEBUG_UART_CLOCK=24000000
+    CONFIG_DEBUG_UART_SHIFT=2
-- 
2.48.1

