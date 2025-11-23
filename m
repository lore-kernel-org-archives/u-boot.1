Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C75CFD313
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 22:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 327D883C32;
	Sun, 23 Nov 2025 23:58:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="oEnkfPR1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9E9283C40; Sun, 23 Nov 2025 23:58:22 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F105583C30
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 23:58:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4852044972; 
 Sun, 23 Nov 2025 22:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763938679;
 bh=JR6KQNt33bcLEoguPKysmFGCX+OEoG4IwAFHOuzys3c=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=oEnkfPR1WTkdQlBsUkhVAfwZ02HfkF1f63Lgj+Sz8hqpclBmCLLRhVXOuu0IS/Yi7
 yHz2IAsHV/0VQlfHwB2Ghf0vppNgX65Xz163Ww2gw45CqBw/M5oW7GOXFjWERd9Lw6
 hxIaFoMhU4N7C7vh5ZoLd3XX7b+Zcv9zgpialDeQei9LzeXmcM65F9o+J/CB9kWaJ7
 JtR+vzWMFCU7MCvITShMedi0TrN/MpYxkKQKlq5kh5WIJefd4EXfbX1DF81GMFl/H+
 R3ftIUQHZAX2lb/aORsiEPJ6C8C22nsktjhokpG/IkSozzFfgzs/UofpzMZIbDPWtZ
 bslAejfKlfH0BTu1vXh28m28HYLFwQirCAuYVeaSb4tsEd0IP9nwzxYPGBwsDTqPTH
 c97WH1GautcGimlvXHKRvwSD5ZTwMQ1ZvcV/9tafMPIknikR39VI4UTWHo01HD14UC
 LRnZGX64vmmy2OftRMJkiuRisZybF+D53sAikH5VhKiGMxD4/JqXSkiOP7SZWyZid0
 ow+xl5bCvCtsrs3XO7mzyzeJrcSgJKb+xsbsnOIzf0vdOveHiOcaBrzD7sMv7j2m0e
 Pf6gDpiv5/ozeX8qV5hTBglf9BSaUJ0oNtbDQ0qlc2ZFG1R25CL8Y/zm4b4pj4r+PU
 XP3fjwSSaC/P2XH1v6aVwy8I=
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
Subject: [PATCH 07/19] test: cmd_exit_test depends on CONFIG_HUSH_PARSER
Date: Sun, 23 Nov 2025 23:56:59 +0100
Message-ID: <20251123225711.227016-8-heinrich.schuchardt@canonical.com>
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

The exit command is not available if CONFIG_HUSH_PARSER=n

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/Kconfig      | 1 +
 test/cmd/Makefile | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/test/Kconfig b/test/Kconfig
index 77e7cad3984..6a4a5fc6708 100644
--- a/test/Kconfig
+++ b/test/Kconfig
@@ -3,6 +3,7 @@ menu "Testing"
 config UNIT_TEST
 	bool "Unit tests"
 	depends on CMDLINE
+	imply HEXDUMP
 	help
 	  Select this to compile in unit tests for various parts of
 	  U-Boot. Test suites will be subcommands of the "ut" command.
diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 841763fec02..d7ff11e458a 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -10,7 +10,7 @@ endif
 ifdef CONFIG_CONSOLE_RECORD
 obj-$(CONFIG_CMD_PAUSE) += test_pause.o
 endif
-obj-y += exit.o
+obj-$(CONFIG_HUSH_PARSER) += exit.o
 obj-$(CONFIG_X86) += cpuid.o msr.o
 obj-$(CONFIG_CMD_ADDRMAP) += addrmap.o
 ifdef CONFIG_CONSOLE_RECORD
-- 
2.51.0

