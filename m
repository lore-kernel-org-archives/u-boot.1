Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC74C36008
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 21:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C2B081E0F;
	Sat, 22 Mar 2025 22:56:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MHCPDhyX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pCEPs3tz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DB1981219; Sat, 22 Mar 2025 22:56:55 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6731381219
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 22:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZKtSj0j6Nz9sdP;
 Sat, 22 Mar 2025 22:56:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742680613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RgTIM8SEPbglHaaH+9iYiMDmXPoCEQgXByIQFLJjWt0=;
 b=MHCPDhyXgKhuvA4qHn8oVnOlU/tln+RUyYdQjrVLY3hoc/bZOjPFoQQCPsFZpZ4q+Bmbjs
 ZRRcI7CvCAHDvFnvAitP7k6RhJpZ7eB4PiLrg7UFRtNvBpFCngPLDOHpxe2Nm3NdJ34R8N
 P4ZUjMExDtcHVTj/nIDHxIkY06LxlEROhuOiU0KzTY1/SCHAyba0/gQEpX2bT37wd/pSZS
 0xtEw67a1pxmRG9ORLFvJjmCGVFV2MdYBgDlxYx6BPszxXw7XLyyh2tOrGw+9eg6+jdp2M
 Zz37T8VLsIfFopkm1FNglbtemMsLVDwcEMUKuzDcURstoZehQq7/DEqEhVJkMA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742680610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RgTIM8SEPbglHaaH+9iYiMDmXPoCEQgXByIQFLJjWt0=;
 b=pCEPs3tzPtW21/fRvcse1jl9wgCuBM5i9+QO/a5jF2Q0QNLArsOBi+pKtQooOsjD9YAIKX
 u3/c4tOIsVV0q1P5A621fPXiIwCEeFflnpHA7f19oJEeH7OOB0HO+rHLgixHX/EZ/86Hd1
 0HTvhCsj1levYDQ6tD5TDnS939N07zZhhCf30/aDz3dyEbKxU1re9EU2uSZ1ecD5gnNgCL
 vHcN7IiCPm7tiiRV1RfPbow9J9UohMOtO74qdAkkBU0Lk94SgImEncWuAUMp54mdjOq6Sn
 PyfPhZB2CduDu0azyZzOHyNiPjST3yif1yKE1ohvQGt/LzfsI6Q13lGh6rVgFg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 8/8] env: Drop DELAY_ENVIRONMENT
Date: Sat, 22 Mar 2025 22:55:28 +0100
Message-ID: <20250322215624.18994-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
References: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 43b71b040677d250d00
X-MBO-RS-META: wimi3o13e1uuppw3sgea9mwthgh8pzam
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
 README           |  9 ---------
 common/board_r.c |  3 ---
 env/Kconfig      | 12 ------------
 3 files changed, 24 deletions(-)

diff --git a/README b/README
index 334bbcf0dd1..bada9beef7f 100644
--- a/README
+++ b/README
@@ -962,15 +962,6 @@ The following options need to be configured:
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
index 3e2916db8c7..37259ddac36 100644
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
index d951ec190f7..092070ab01c 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -736,18 +736,6 @@ config ENV_VARS_UBOOT_RUNTIME_CONFIG
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

