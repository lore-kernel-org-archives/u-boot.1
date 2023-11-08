Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D342C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 15:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 367A7874C9;
	Wed,  8 Nov 2023 16:10:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=enrico.leto@siemens.com header.b="BChoDvwj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9554F871C1; Wed,  8 Nov 2023 15:53:34 +0100 (CET)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36CF8874B7
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 15:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 2023110814532638fb1e5257464f4e93 for <u-boot@lists.denx.de>;
 Wed, 08 Nov 2023 15:53:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=enrico.leto@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=k/eoAcSP1u2XgeaodbSky2F37KJumxhYCiXukQKZ58o=;
 b=BChoDvwjNzY3btiGvAUMpBjAUBSRIClXyYv2IBiDSNeTtmquTMaFPfkBH55b9GJA+cdT0j
 QnV//+fLSQfpAbGbb/wUhUsgoAwVwXGRc7MAcf+VhS6BBkce+jDfIEoJ0ckuHHVYQh7x9f0n
 0w/+uaYheVFvuaJJ0cv7JMtGhWR+8=;
From: Enrico Leto <enrico.leto@siemens.com>
To: u-boot@lists.denx.de
Cc: Enrico Leto <enrico.leto@siemens.com>
Subject: [PATCH 5/6] configs: draco: disable misc init
Date: Wed,  8 Nov 2023 15:53:21 +0100
Message-Id: <20231108145322.302927-6-enrico.leto@siemens.com>
In-Reply-To: <20231108145322.302927-1-enrico.leto@siemens.com>
References: <20231108145322.302927-1-enrico.leto@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320603:519-21489:flowmailer
X-Mailman-Approved-At: Wed, 08 Nov 2023 16:10:16 +0100
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

The initcall sequence fails at arch_misc_init. Disable misc init until
driver model and DT are clean.

Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
---
 configs/draco-etamin_defconfig   | 1 -
 configs/draco-rastaban_defconfig | 1 -
 configs/draco-thuban_defconfig   | 1 -
 3 files changed, 3 deletions(-)

diff --git a/configs/draco-etamin_defconfig b/configs/draco-etamin_defconfig
index 7814e125c29..8180bb004cc 100644
--- a/configs/draco-etamin_defconfig
+++ b/configs/draco-etamin_defconfig
@@ -32,7 +32,6 @@ CONFIG_RESET_TO_RETRY=y
 CONFIG_USE_PREBOOT=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_BOARDINFO is not set
-CONFIG_ARCH_MISC_INIT=y
 CONFIG_SPL_BSS_START_ADDR=0x80000000
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
diff --git a/configs/draco-rastaban_defconfig b/configs/draco-rastaban_defconfig
index 2460182b12c..539ead3d862 100644
--- a/configs/draco-rastaban_defconfig
+++ b/configs/draco-rastaban_defconfig
@@ -30,7 +30,6 @@ CONFIG_RESET_TO_RETRY=y
 CONFIG_USE_PREBOOT=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_BOARDINFO is not set
-CONFIG_ARCH_MISC_INIT=y
 CONFIG_SPL_BSS_START_ADDR=0x80000000
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
diff --git a/configs/draco-thuban_defconfig b/configs/draco-thuban_defconfig
index 766b1596a17..f919754c2e4 100644
--- a/configs/draco-thuban_defconfig
+++ b/configs/draco-thuban_defconfig
@@ -30,7 +30,6 @@ CONFIG_RESET_TO_RETRY=y
 CONFIG_USE_PREBOOT=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_BOARDINFO is not set
-CONFIG_ARCH_MISC_INIT=y
 CONFIG_SPL_BSS_START_ADDR=0x80000000
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-- 
2.30.2

