Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFC4CFD313
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 22:59:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF3D583CA4;
	Sun, 23 Nov 2025 23:58:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XWcO84SL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A265983C6E; Sun, 23 Nov 2025 23:58:42 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2FA783C94
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 23:58:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E2A1844978; 
 Sun, 23 Nov 2025 22:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763938689;
 bh=IMZ/smCP6jwpdQtLL/xO3KtzbCojrWMsGB6d5jTpBmY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=XWcO84SLz9apgXegqW8+cADaCCRS4B07sFMOyqoBt56gySfdZoid8us8BoOR3eyIY
 JmGT3LytXFNrH/Zzbcfcl4F480WFbZXoLjsn8M2kJulczI1liNvW26FWJJrPPOctQh
 wQ1q0ESWN1PXmgHv8nCQ4hrXDvl8VW2hKfXFI4O9mvmNEVJ+EmLPXwJnDPUWr9cI3Q
 SwYxA0lsoItB3iTB7J2nr47JyXUZjhu+/vfASGCrRAiWkYZxdixgs0zVnzwCgsY63B
 H2J3mXOySW7AsEsaDD0ECBO96sINOOSigeGBR6lEZlEYIwpi/Fuol+D1riRFsQaMlK
 OsXfqbgZS6+LmhvJQouUfxz4q+ivB7PQZO70h85nqoGeD6ZpZtkuU6BVUWcGlqLJlB
 QXtrs01o7RFmJg7U3qoaf+0vbuWUBTW8p2IIaczQneM+oPz7vt0XOjdfA9cCvKez4+
 TcTnLIdhEcozvMJDhbc8d3Ik3Otn/NTHVXE9wQn1UdWH3kgFshwivL0/NG0SprhYWu
 QMlMzxXLa914BEF9/BaQvjUyqZB2stcJyewkIlD0S2GWc/K+R9fub97EZvOPSGG5P5
 pTVYbWOcLWcT3QTorHeoJ61EfGByNvOFUs2wkYv26CjeOXAHoPE6iKq200sNZGueB1
 98zT2PokbI4iH9O/97h7XwvU=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Paul Burton <paulburton@kernel.org>,
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heiko Schocher <hs@nabladev.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Richard Weinberger <richard@nod.at>,
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 13/19] malta: increase SYS_MALLOC_F_LEN and SYS_MALLOC_LEN
Date: Sun, 23 Nov 2025 23:57:05 +0100
Message-ID: <20251123225711.227016-14-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
References: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
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

If CONFIG_CONSOLE_RECORD_INIT_F=y we need additional memory according to
CONFIG_CONSOLE_RECORD_OUT_SIZE_F. Similarly CONFIG_SYS_MALLOC_LEN must be
increased by CONSOLE_RECORD_OUT_SIZE.

Go with the default values for CONFIG_CONSOLE_RECORD_INIT_F and
CONFIG_SYS_MALLOC_LEN.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 configs/malta64_defconfig   | 2 --
 configs/malta64el_defconfig | 2 --
 configs/malta_defconfig     | 2 --
 configs/maltael_defconfig   | 2 --
 4 files changed, 8 deletions(-)

diff --git a/configs/malta64_defconfig b/configs/malta64_defconfig
index d1211b07f8a..e927be3b38e 100644
--- a/configs/malta64_defconfig
+++ b/configs/malta64_defconfig
@@ -1,7 +1,5 @@
 CONFIG_MIPS=y
 CONFIG_TEXT_BASE=0xFFFFFFFFBE000000
-CONFIG_SYS_MALLOC_LEN=0x20000
-CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_SECT_SIZE=0x20000
 CONFIG_DEFAULT_DEVICE_TREE="mti,malta"
diff --git a/configs/malta64el_defconfig b/configs/malta64el_defconfig
index b9573dc79f4..ac3039ec744 100644
--- a/configs/malta64el_defconfig
+++ b/configs/malta64el_defconfig
@@ -1,7 +1,5 @@
 CONFIG_MIPS=y
 CONFIG_TEXT_BASE=0xFFFFFFFFBE000000
-CONFIG_SYS_MALLOC_LEN=0x20000
-CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_SECT_SIZE=0x20000
 CONFIG_DEFAULT_DEVICE_TREE="mti,malta"
diff --git a/configs/malta_defconfig b/configs/malta_defconfig
index dfa37d1ddd9..da0ac95ae13 100644
--- a/configs/malta_defconfig
+++ b/configs/malta_defconfig
@@ -1,7 +1,5 @@
 CONFIG_MIPS=y
 CONFIG_TEXT_BASE=0xBE000000
-CONFIG_SYS_MALLOC_LEN=0x20000
-CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_SECT_SIZE=0x20000
 CONFIG_DEFAULT_DEVICE_TREE="mti,malta"
diff --git a/configs/maltael_defconfig b/configs/maltael_defconfig
index d016115a027..663e9197726 100644
--- a/configs/maltael_defconfig
+++ b/configs/maltael_defconfig
@@ -1,7 +1,5 @@
 CONFIG_MIPS=y
 CONFIG_TEXT_BASE=0xBE000000
-CONFIG_SYS_MALLOC_LEN=0x20000
-CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_SECT_SIZE=0x20000
 CONFIG_DEFAULT_DEVICE_TREE="mti,malta"
-- 
2.51.0

