Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7DFC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 22:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E82E84AC0;
	Thu,  9 Jul 2026 00:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="AhCSHPfK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BD4184AD3; Thu,  9 Jul 2026 00:06:11 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3F3B84A1F
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 00:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=747f=FD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1783548365; bh=crqUNb7gd9GqO+zyn/HsYY1XaGNpuBejtlJXtddvKgY=;
 b=AhCSHPfKgt0qK3SXF/uV4VE07dlufvIJeakREbH8IWhti3qmGC1o5rLIabgbne82DbIVo4CwW
 TmeV3XkLovoHhZvIHeUUyEgjqPgIg0+jimEfQc6T1w7+aWAmqNrlelssfOTolycetqhwAM5qGyL
 dmom8mQsjwUkjn6o2YsDbPRbHhEy+XxlkyRKHqTl6yZxVs+KpKyhqMKtJ4WmvrzPXWjLhHC1pfD
 Osx97kPurBSv+FfSsUszMrrxAU5JpwUQIz3KROC7dSL8I90iaV1zING+TvarjxbqYNo3VoJwFOT
 8nTmQ73A97QZVyjy3QCmR6Uiig7WKjg/6RVOZ4pq0CHg==
X-Forward-Email-ID: 6a4ec9ca2402b3ca75f904a4
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 07/11] Kconfig: Depend on correct xPL symbol
Date: Wed,  8 Jul 2026 22:05:33 +0000
Message-ID: <20260708220540.3368825-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708220540.3368825-1-jonas@kwiboo.se>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
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

Change to depend on correct xPL symbol instead of a xPL symbol intended
for a different phase to make affected symbols available for correct
phase.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/Kconfig         | 2 +-
 common/spl/Kconfig   | 2 +-
 drivers/core/Kconfig | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8d63afeb138e..408e53524e5f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -508,7 +508,7 @@ config SPL_SKIP_LOWLEVEL_INIT
 
 config TPL_SKIP_LOWLEVEL_INIT
 	bool "Skip calls to certain low level initialization functions in TPL"
-	depends on SPL && ARM
+	depends on TPL && ARM
 	help
 	  If enabled, then certain low level initializations (like setting up
 	  the memory controller) are omitted and/or U-Boot does not relocate
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 0618f42c9410..988d815f8c79 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1768,7 +1768,7 @@ config TPL
 source "common/spl/Kconfig.tpl"
 
 config VPL
-	depends on SUPPORT_SPL && !COMPILE_TEST
+	depends on SUPPORT_VPL && !COMPILE_TEST
 	bool "Enable VPL"
 	help
 	  If you want to build VPL as well as the normal image, TPL and SPL,
diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index ae0c34667723..a0e252b0529c 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -394,8 +394,8 @@ config TPL_OF_TRANSLATE
 	  smaller in size than fdt_translate_address()
 
 config VPL_OF_TRANSLATE
-	bool "Translate addresses using fdt_translate_address in SPL"
-	depends on SPL_DM && VPL_OF_CONTROL
+	bool "Translate addresses using fdt_translate_address in VPL"
+	depends on VPL_DM && VPL_OF_CONTROL
 	help
 	  If this option is enabled, the reg property will be translated
 	  using the fdt_translate_address() function. This is necessary
-- 
2.54.0

