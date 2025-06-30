Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7B4C7EE30
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 00:09:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50F7982F5E;
	Mon, 30 Jun 2025 02:09:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cLEzb9Lv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lPcndAU4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B925E82F8C; Mon, 30 Jun 2025 02:09:39 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A4D082ED0
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 02:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bVmk76DKNz9sdB;
 Mon, 30 Jun 2025 02:09:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751242175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=p16fxjxT+2U/aJ+p9YfeSixyrTPx9A2Spmr/uY1YwMk=;
 b=cLEzb9Lv1GVxD+JgjQTnXLi+G52kk78DjJndQohTUYSQhAPD9JiRLhTTHvbUqiZv2NIsOl
 OqN2sxYEezk4r6HyxAcVcVovhLYnpdvvdv9jdMftwQUguSBgvGDrtVL1n0Rzuqs607/1MB
 NCAbpQlsRlASKOaytwv+xPB4nwX18XWXQZSmGofuJ0EqoA5IyGGzomF43GQbVTy729T4vz
 Nz9weE4lM/NInzeTqydSGWv8JYRBbzod66XX4VR5hLXfdjsCDDX0y66hzHmAmLHiEUFM1d
 s5Wx8KNXRspsdlUbJWy/KP7prKCs6nPpPZZJkHZQEfzbKcVqaIaZO+7B1Zfdbg==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751242174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=p16fxjxT+2U/aJ+p9YfeSixyrTPx9A2Spmr/uY1YwMk=;
 b=lPcndAU47jw0YxIwaooynROfhYNfgdvEFBznCZDl9QcTs5DxbLelFme4s6WkWSfp5UOTRK
 7hJMvsRoyRNXGUbLTaHW35fJKihQm7Lwr2mjZVcM54CwGwshU+E82djBQxmT5wwvTMwzOj
 zx4d7p6wFFKIhsfBPHqwfWQII4++g4S8uoUknVWYPCSHOsjePrQQTB5N1x10RlteB/Hqxy
 Ymn5T5Rt4S3A8Nbh5UZzPn2QLZDh6lRmPzj1LtBcqyjAMnrqBuKxH6cJyVJRqHVq+0Ypbh
 /XGo37NcIobYQdoPT3u+xuuL7lPGKQ/o0nhcNincp7h6Zug+urWtpTOEM2wYIQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] reset: stm32: Fix header misuse
Date: Mon, 30 Jun 2025 02:09:07 +0200
Message-ID: <20250630000926.952277-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4xyjssudkwunqdfgow4wa4y151ib8xqq
X-MBO-RS-ID: 613336a11d33d5e10f6
X-Rspamd-Queue-Id: 4bVmk76DKNz9sdB
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

The stm32-reset-core.h is located in drivers/reset/stm32/ , it has to
be included using "stm32-reset-core.h" and not <stm32-reset-core.h> ,
otherwise the build fails. Fix it.

Fixes: 0994a627c278 ("reset: stm32mp25: add stm32mp25 reset driver")
Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 MAINTAINERS                            | 1 -
 drivers/reset/stm32/stm32-reset-core.c | 2 +-
 drivers/reset/stm32/stm32-reset-mp1.c  | 2 +-
 drivers/reset/stm32/stm32-reset-mp25.c | 2 +-
 drivers/reset/stm32/stm32-reset.c      | 2 +-
 5 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92119667618..da16816e51c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -730,7 +730,6 @@ F:	include/dt-bindings/clock/stm32fx-clock.h
 F:	include/dt-bindings/clock/stm32mp*
 F:	include/dt-bindings/pinctrl/stm32-pinfunc.h
 F:	include/dt-bindings/reset/stm32mp*
-F:	include/stm32-reset-core.h
 F:	include/stm32_rcc.h
 F:	tools/logos/st.bmp
 F:	tools/stm32image.c
diff --git a/drivers/reset/stm32/stm32-reset-core.c b/drivers/reset/stm32/stm32-reset-core.c
index 7dd92e07e1a..9eeed6536e0 100644
--- a/drivers/reset/stm32/stm32-reset-core.c
+++ b/drivers/reset/stm32/stm32-reset-core.c
@@ -6,7 +6,7 @@
 
 #include <dm.h>
 #include <reset-uclass.h>
-#include <stm32-reset-core.h>
+#include "stm32-reset-core.h"
 #include <stm32_rcc.h>
 #include <dm/device_compat.h>
 #include <linux/iopoll.h>
diff --git a/drivers/reset/stm32/stm32-reset-mp1.c b/drivers/reset/stm32/stm32-reset-mp1.c
index 6863f6e64b7..ce4532561e5 100644
--- a/drivers/reset/stm32/stm32-reset-mp1.c
+++ b/drivers/reset/stm32/stm32-reset-mp1.c
@@ -5,7 +5,7 @@
  */
 
 #include <dm.h>
-#include <stm32-reset-core.h>
+#include "stm32-reset-core.h"
 
 /* Reset clear offset for STM32MP RCC */
 #define RCC_CLR_OFFSET			0x4
diff --git a/drivers/reset/stm32/stm32-reset-mp25.c b/drivers/reset/stm32/stm32-reset-mp25.c
index 91c0336bc58..1cbe5c7f3d5 100644
--- a/drivers/reset/stm32/stm32-reset-mp25.c
+++ b/drivers/reset/stm32/stm32-reset-mp25.c
@@ -5,7 +5,7 @@
  */
 
 #include <dm.h>
-#include <stm32-reset-core.h>
+#include "stm32-reset-core.h"
 #include <stm32mp25_rcc.h>
 #include <dt-bindings/reset/st,stm32mp25-rcc.h>
 
diff --git a/drivers/reset/stm32/stm32-reset.c b/drivers/reset/stm32/stm32-reset.c
index 975f67f712a..918e81e588f 100644
--- a/drivers/reset/stm32/stm32-reset.c
+++ b/drivers/reset/stm32/stm32-reset.c
@@ -5,7 +5,7 @@
  */
 
 #include <dm.h>
-#include <stm32-reset-core.h>
+#include "stm32-reset-core.h"
 
 /* Timeout for deassert */
 #define STM32_DEASSERT_TIMEOUT_US	10000
-- 
2.47.2

