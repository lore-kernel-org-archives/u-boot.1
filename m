Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D75DCFD313
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 22:58:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB20783C14;
	Sun, 23 Nov 2025 23:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="OIxpZsQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4251783B7E; Sun, 23 Nov 2025 23:58:11 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 398DC83C0E
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 23:58:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1A2E1409BD; 
 Sun, 23 Nov 2025 22:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763938676;
 bh=JhyGvXXtXXPfto8vezLrwMfEwKZ+d8+019bAlvI+kAA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=OIxpZsQ4hDWJ7Md9Q/j/7T9zGiRmN5oKV1hfm3GPR5BkQQhXUc7l5gHuJoJdJBYSQ
 9lKy4jATzGUX74Emj1WklRqdYxGYvrUmjx2yKkRTiGrg75gcP4yHaabKUB+d0ZYxGq
 kWxBfdVeeVTxFF24vbDYWLT0ErJVoH3YQb8i9PAXih7OjFLzMdUlAZEPIsuzraLrgq
 hrDRoSXIL/sHBBnjCuCksrD09X9MTo5Hl4AeH19bzwREFALM6Zk7DJ7MlmtGdaDhhH
 UCSj90Nf3ciIHI6OmudecFPQq/TEYoAbV1j40dh1gFaQA9KUp8qAp1XFwf+RkFT6lW
 vQehTPSIDmNLqqbCiv3B6wZjG5+WhAbwuEb7jLzXZjqj8iJMndP/jiBq3NdvCdI7ls
 pm/zQWfvoCQhcbpYEZxHcyzAYNSRIc6T2+M284xdq0e5fkFXx6pzqQNdIfxxIrFCxv
 B9aOLTAEUrYzfLzAyBPTnGkLLH2bDRGCLQsoGceFR6/c2YkytdQEYcTm3tLeET2a0b
 j4jtSZQrAYqbduJgY9Y6vTDuI7TKsn8gVpVsxGSfu9xFExZpoE73BbUI4MwtOUIrpE
 jF466eS5HLhdZ1ea5THU+lQaWucQN1xpguXpDK/mX2+I5xFKtUpgkANQZO8RjQp+yM
 SgZHHGJUpEL6TU+W5McrSlig=
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
Subject: [PATCH 04/19] test: don't test for CONFIG_UNIT_TEST twice
Date: Sun, 23 Nov 2025 23:56:56 +0100
Message-ID: <20251123225711.227016-5-heinrich.schuchardt@canonical.com>
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

Makefile already checks CONFIG_UNIT_TEST.
There is point in checking it in test/Makefile again.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/Makefile b/test/Makefile
index f7ab9a36b2a..5676bd35963 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_$(PHASE_)CMDLINE) += cmd_ut.o
 obj-y += dm/
 obj-$(CONFIG_FUZZ) += fuzz/
 ifndef CONFIG_SANDBOX_VPL
-obj-$(CONFIG_UNIT_TEST) += lib/
+obj-y += lib/
 endif
 ifneq ($(CONFIG_HUSH_PARSER),)
 obj-$(CONFIG_$(PHASE_)CMDLINE) += hush/
@@ -19,7 +19,7 @@ obj-y += ut.o
 
 ifeq ($(CONFIG_XPL_BUILD),)
 obj-y += boot/
-obj-$(CONFIG_UNIT_TEST) += common/
+obj-y += common/
 obj-$(CONFIG_UT_ENV) += env/
 obj-$(CONFIG_UT_FDT_OVERLAY) += fdt_overlay/
 obj-y += log/
-- 
2.51.0

