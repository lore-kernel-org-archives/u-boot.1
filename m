Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA63C5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 19:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81D2D82CB6;
	Mon,  9 Jun 2025 21:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cqwj062C";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fHxoRGtI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E41A282C7D; Mon,  9 Jun 2025 21:27:31 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07CF08144A
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 21:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bGMPs6J13z9svm;
 Mon,  9 Jun 2025 21:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749497249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B+7PWodyPBqymz4YT5RqK5TvMbqb2zic6vuSFXAh+M0=;
 b=cqwj062C/JrnPWhu/s3gxnYN6QlN+gnmgl7JLlBK0jw6bk6OOssy44CZl0zmHW9SIPTkfc
 Q9gMkp3Fi77PdhPCDB+YASWB2dFIv5qJonOO0bt1F7jjhEoedojYqdcfDQ3o6bA7bmHjdn
 bc7jxgvgzfJgU33hiDadeu9C0kpAUmvivbptz/d4X9HRZ3Ft7bylAGYXuYlQLjmjewi4mN
 7/CIKCJLjG9NffyR6Jgin5baRg3L3O1Jsc/vklappXQ9uSGTpg80r0gVkn6ftg3OhNXX0a
 MMysGdYh5IaDXlWnFEru5MdN8Xz2QVsgQZbvyzmGipecXDcqawLbu5rbtyp76A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749497248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B+7PWodyPBqymz4YT5RqK5TvMbqb2zic6vuSFXAh+M0=;
 b=fHxoRGtIPWEKngQkyiA6SuVM6NPOoTZTePvGOeREJjsytQGDF32lVaokaA2o9uCdLIzdW0
 07Bzvfo1RNcrSNxvJJ1yPO9lfNetexuoOX11uKuo05dqgzMZddwfzou/TifwbVPMyI2wm3
 PS2NRSOQhYntX/BvCw1ea/0nJ8lwp8v+PaFa9anr9P32zYs9G7JkJmbNbEvjz7QfWhjl0I
 7d8/zLbf/h3F5FOk5lQyTHkJSXGoTdVmp/v5hgj//vX0Z9j24Brtt8uPVimV5MHUsisiHa
 kDLxoMqitEf6rRb1SnCJWucNZi+UGpg8AxZwC93R8wln2TYQzlIPxEUZZisLrA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 8/8] env: Drop DELAY_ENVIRONMENT
Date: Mon,  9 Jun 2025 21:26:43 +0200
Message-ID: <20250609192701.20260-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250609192701.20260-1-marek.vasut+renesas@mailbox.org>
References: <20250609192701.20260-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9ur7qjqogb9xt47kpub9hzceaa9khggc
X-MBO-RS-ID: 601e0705641785e58f8
X-Rspamd-Queue-Id: 4bGMPs6J13z9svm
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

There are no users of DELAY_ENVIRONMENT and the same effect can
be achieved either using DT /config/load-environment property,
or by using ENV_IS_NOWHERE . Remove this configuration option
and matching functionality.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
V2: Rebase on u-boot/next
---
 README           |  9 ---------
 common/board_r.c |  3 ---
 env/Kconfig      | 12 ------------
 3 files changed, 24 deletions(-)

diff --git a/README b/README
index 88b6e6f2772..40326ef3547 100644
--- a/README
+++ b/README
@@ -950,15 +950,6 @@ The following options need to be configured:
 		the environment like the "source" command or the
 		boot command first.
 
-		CONFIG_DELAY_ENVIRONMENT
-
-		Normally the environment is loaded when the board is
-		initialised so that it is available to U-Boot. This inhibits
-		that so that the environment is not available until
-		explicitly loaded later by U-Boot code. With CONFIG_OF_CONTROL
-		this is instead controlled by the value of
-		/config/load-environment.
-
 - Automatic software updates via TFTP server
 		CONFIG_UPDATE_TFTP
 		CONFIG_UPDATE_TFTP_CNT_MAX
diff --git a/common/board_r.c b/common/board_r.c
index 8ee2a4790bb..143d51d0633 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -442,9 +442,6 @@ static int should_load_env(void)
 	if (IS_ENABLED(CONFIG_OF_CONTROL))
 		return ofnode_conf_read_int("load-environment", 1);
 
-	if (IS_ENABLED(CONFIG_DELAY_ENVIRONMENT))
-		return 0;
-
 	return 1;
 }
 
diff --git a/env/Kconfig b/env/Kconfig
index 65ab8b6392d..58a0666cd49 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -774,18 +774,6 @@ config ENV_VARS_UBOOT_RUNTIME_CONFIG
 	  run-time determined information about the hardware to the
 	  environment.  These will be named board_name, board_rev.
 
-config DELAY_ENVIRONMENT
-	bool "Delay environment loading"
-	depends on !OF_CONTROL
-	help
-	  Enable this to inhibit loading the environment during board
-	  initialization. This can address the security risk of untrusted data
-	  being used during boot. Normally the environment is loaded when the
-	  board is initialised so that it is available to U-Boot. This inhibits
-	  that so that the environment is not available until explicitly loaded
-	  later by U-Boot code. With CONFIG_OF_CONTROL this is instead
-	  controlled by the value of /config/load-environment.
-
 config ENV_IMPORT_FDT
 	bool "Amend environment by FDT properties"
 	depends on OF_CONTROL
-- 
2.47.2

