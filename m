Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2428AD637C4
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 21:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5407F89043;
	Wed, 13 Nov 2024 22:06:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="rdRnUaFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3EBE89198; Wed, 13 Nov 2024 22:06:54 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B75C489040
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 22:06:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 1D53840928; 
 Wed, 13 Nov 2024 21:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1731532011;
 bh=2onuO1trqWGNlT3y7ISqxpFq0+MZhjSkfMsuWNUj6mg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=rdRnUaFMOu/5oVNIx3wEFPnQg+JYWzJqKZ+wq+3VchFs2OLQ2Yzzaisn6kxnKQKIX
 5QD828M2hGk4RQJRc+AJa0M8MuGnVXx3V3O5d8gd1tCyKJCpFqj/ti+Vb9a4wJC9D1
 PKqwKRbbTgvcktqePL2FA8mjvUNBhl9HjrgnMGxyEpERSKnvaRXRfgxpuT4wIsVO0J
 Ao7grZx3Kbo+q/lLFazYLKHJOa6EQfWWQ2g5smNqh+Uenp1OHjB5WYoE4StV0GwhZK
 o/TkRuZIg89MSgmSr49oyRlOPJq8VY6q/1uP0ofHGklz/mkqDeg/UEwHCtRYDcWSjr
 KB6F7olsMmk9Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] test: str_ut.c depends on CONFIG_STRTO
Date: Wed, 13 Nov 2024 22:06:46 +0100
Message-ID: <20241113210646.88937-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

The string conversion functions are implemented in lib/strto.c which is
only compiled if CONFIG_STRTO=y.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/Makefile b/test/Makefile
index 145c952d2c3..efd5ba7acfd 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -21,7 +21,7 @@ ifneq ($(CONFIG_HUSH_PARSER),)
 obj-$(CONFIG_$(XPL_)CMDLINE) += hush/
 endif
 obj-$(CONFIG_$(XPL_)CMDLINE) += print_ut.o
-obj-$(CONFIG_$(XPL_)CMDLINE) += str_ut.o
+obj-$(CONFIG_$(PHASE_)STRTO) += str_ut.o
 obj-$(CONFIG_UT_TIME) += time_ut.o
 obj-y += ut.o
 
-- 
2.45.2

