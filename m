Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CF4E6ADE7
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 08:48:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52FFB893FD;
	Sat, 23 Nov 2024 09:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MU+bOywg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00649893F7; Sat, 23 Nov 2024 09:48:23 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F12C7893EB
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 09:48:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4BDE43FDCA; 
 Sat, 23 Nov 2024 08:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732351699;
 bh=ym8MDGCESs3av4plzji1BGY+Cf57FThtYchu5EXzbtk=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=MU+bOywgbfTlEblGKs9Ui39128XmBNEjw/87HYwg/UmV163UKYHcWK8aBv4JbPrhF
 KFoKGZasbmiwZyarZvJQUwZu0+/HsEnKVS81TyvO7dqE3lYWfvbxI9YTdTgLoc0sBX
 IXAf7jbxecdQZloJhsSVrDSStKIl5TvND3v41AF0YwTjGb4xWg26BGJGaWdNyev9YL
 zD+utQj6hGyidM1pbRDKY6UeN2eXPLQFwu8jLbe3d6ereXx7Dfd8VW5jv21yQy01R9
 uR3M1RLFrOANMguPn+dxag0S02Gzpfzk7oq6pg2ETK1bGBdcx/YHvt+L6aUK6SuvKg
 xf5atUasqZvpQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Kalen Brunham <kalen.brunham@intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/4] examples: use architecture specific memset() on RISC-V
Date: Sat, 23 Nov 2024 09:47:53 +0100
Message-ID: <20241123084754.59182-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241123084754.59182-1-heinrich.schuchardt@canonical.com>
References: <20241123084754.59182-1-heinrich.schuchardt@canonical.com>
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

Build the architecture specific memset() if configured.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 examples/api/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/examples/api/Makefile b/examples/api/Makefile
index ec1643e4875..13e859cf080 100644
--- a/examples/api/Makefile
+++ b/examples/api/Makefile
@@ -43,8 +43,8 @@ EXT_COBJ-y += lib/vsprintf.o
 EXT_COBJ-y += lib/charset.o
 EXT_COBJ-$(CONFIG_LIB_UUID) += lib/uuid.o
 EXT_SOBJ-$(CONFIG_PPC) += arch/powerpc/lib/ppcstring.o
-ifeq ($(ARCH),arm)
-EXT_SOBJ-$(CONFIG_USE_ARCH_MEMSET) += arch/arm/lib/memset.o
+ifneq ($(CONFIG_ARM)$(CONFIG_RISCV),)
+EXT_SOBJ-$(CONFIG_USE_ARCH_MEMSET) += arch/$(ARCH)/lib/memset.o
 endif
 
 # Create a list of object files to be compiled
-- 
2.45.2

