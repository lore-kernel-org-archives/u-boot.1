Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC46C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 19:00:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4D5587D9D;
	Wed,  6 Mar 2024 19:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="bMkbc5mG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB2D686D38; Wed,  6 Mar 2024 19:59:50 +0100 (CET)
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com
 [IPv6:2a00:1450:4864:20::54a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3275487DA7
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 19:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3F73oZQkKBmoLQUWZQVVgOWWOTM.KWUc-JWWbTQaba.LMVf.LM@flex--dimorinny.bounces.google.com
Received: by mail-ed1-x54a.google.com with SMTP id
 4fb4d7f45d1cf-564901924f4so24952a12.0
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 10:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709751576; x=1710356376; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=JLg0wWtrW/tIqSJgysEmUyHuXR8cZzTRkKM96ER484s=;
 b=bMkbc5mGCkKEJf5/iWWcULQOqNvYe3f4EmurHEddX1SKHummLSESNc9H+ndQgOKUy/
 BkfIWOJ81QvuG9CP3o0wxSOf5pmECazNSxSo1kntPLbjaR8SbyVPIHdZwOiJ2sxG9O+6
 Cn7yBKQmTiEOkqhMkmK0k/+E/BEyyFdPINtWIh+zcQGKKcyjSrODB5m1TICrxo24Dev2
 2V5zLHz1y8jC+WOsURoCeCKh9IeKxOBZr9ckqLQRMRpxy3Vu2lZEesFm8wvmclPjNm1X
 +f/SBEUTmXnBssTVh9ADUaAs9VgsBxjC+Y71PjdVDSv0z1fpAYSuCpxehWApT7e2TC8h
 TwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709751576; x=1710356376;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JLg0wWtrW/tIqSJgysEmUyHuXR8cZzTRkKM96ER484s=;
 b=QLnp/7dCM8VhsoCDHD/DFVwTIqCxFiD/Oxa+/6I/5Rd3xV3eJhfMtzap2N9/wmDkEZ
 BkDTUQGWk0fnPkoXFcStR8sHy2zuj93TXCG+nPHRjBySzoIv19wagFgTX9n5FAfdInZh
 ducIX0HFLOQHwt1522OXzNcgQ+GPuK002nWPrHfMArRF9OUHfxDhxaloFxa3ovWmo7ca
 bYf0zkPxr9YKU90J6OMwWr2pBbZUmMz6hgD1fvj5vgAaVGvWJQ5vEmCSrL3hO0tfW54M
 6wM6dTsaHmQWDVCyhbOLmVnuAfJGsLccZJM9YuPUOCY/7BYyan4ZbrehR1SoIo2YpcnF
 9+jg==
X-Gm-Message-State: AOJu0YwADsUs7R8Fg2gseY1bn9gVcqIwUsnScVWy9QCFraC3zf7t/Rb9
 ATt0lM3EUSGKdloQlgyZz6XUfEp6DKMNhUPpKRULdVd67KGKVOF9+HVQaYT3A394vPSffTUCxnd
 bNWcCyQ24XLFYU9VuYG2lA9hbyemHqIStX+goDZmiqs8Bowz67zfXkQbPmt5BK7y25xTaD0e9Rc
 GZKzTgtvWXXC+NCzWWSxd3swcoieY128cdoCL5HXuzx+F9qw==
X-Google-Smtp-Source: AGHT+IEyMz8cUs1Ot7+3BR58qqZJZ0gguKQ8TG45zyyQiE+L7DjToJBWoVzMih4d2xOXPDvrObEVCiSSC8yWW5I=
X-Received: from dimorinny0.lon.corp.google.com
 ([2a00:79e0:d:209:bf09:8cbc:464b:6c87])
 (user=dimorinny job=sendgmr) by 2002:a05:6402:121a:b0:566:77b7:ed46 with SMTP
 id c26-20020a056402121a00b0056677b7ed46mr54807edw.5.1709751575883; Wed, 06
 Mar 2024 10:59:35 -0800 (PST)
Date: Wed,  6 Mar 2024 18:59:21 +0000
In-Reply-To: <20240306185921.1854109-1-dimorinny@google.com>
Mime-Version: 1.0
References: <20240306185921.1854109-1-dimorinny@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306185921.1854109-4-dimorinny@google.com>
Subject: [PATCH 4/4] fastboot: integrate block flashing back-end
From: Dmitrii Merkurev <dimorinny@google.com>
To: u-boot@lists.denx.de
Cc: rammuthiah@google.com, Dmitrii Merkurev <dimorinny@google.com>, 
 Alex Kiernan <alex.kiernan@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ying-Chun Liu <paul.liu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

1. Get partition info/size
2. Erase partition
3. Flash partition
4. BCB

Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
Cc: Alex Kiernan <alex.kiernan@gmail.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
---
 drivers/fastboot/fb_command.c |  8 ++++++++
 drivers/fastboot/fb_common.c  | 15 +++++++++++----
 drivers/fastboot/fb_getvar.c  |  8 +++++++-
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index f95f4e4ae1..67ebe02efa 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -9,6 +9,7 @@
 #include <env.h>
 #include <fastboot.h>
 #include <fastboot-internal.h>
+#include <fb_block.h>
 #include <fb_mmc.h>
 #include <fb_nand.h>
 #include <part.h>
@@ -331,6 +332,10 @@ void fastboot_data_complete(char *response)
  */
 static void __maybe_unused flash(char *cmd_parameter, char *response)
 {
+	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
+		fastboot_block_flash_write(cmd_parameter, fastboot_buf_addr,
+					   image_size, response);
+
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
 		fastboot_mmc_flash_write(cmd_parameter, fastboot_buf_addr,
 					 image_size, response);
@@ -351,6 +356,9 @@ static void __maybe_unused flash(char *cmd_parameter, char *response)
  */
 static void __maybe_unused erase(char *cmd_parameter, char *response)
 {
+	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
+		fastboot_block_erase(cmd_parameter, response);
+
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
 		fastboot_mmc_erase(cmd_parameter, response);
 
diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
index 3576b06772..7602653c0b 100644
--- a/drivers/fastboot/fb_common.c
+++ b/drivers/fastboot/fb_common.c
@@ -97,16 +97,23 @@ int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
 		[FASTBOOT_REBOOT_REASON_FASTBOOTD] = "boot-fastboot",
 		[FASTBOOT_REBOOT_REASON_RECOVERY] = "boot-recovery"
 	};
-	const int mmc_dev = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
-					       CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
 
-	if (!IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
+	int device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+					CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
+	if (device == -1) {
+		device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
+					    CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
+	}
+	char *bcb_iface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+					     CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME, "mmc");
+
+	if (device == -1)
 		return -EINVAL;
 
 	if (reason >= FASTBOOT_REBOOT_REASONS_COUNT)
 		return -EINVAL;
 
-	ret = bcb_find_partition_and_load("mmc", mmc_dev, "misc");
+	ret = bcb_find_partition_and_load(bcb_iface, device, "misc");
 	if (ret)
 		goto out;
 
diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index f65519c57b..71507009ab 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -8,6 +8,7 @@
 #include <fastboot.h>
 #include <fastboot-internal.h>
 #include <fb_mmc.h>
+#include <fb_block.h>
 #include <fb_nand.h>
 #include <fs.h>
 #include <part.h>
@@ -114,7 +115,12 @@ static int getvar_get_part_info(const char *part_name, char *response,
 	struct disk_partition disk_part;
 	struct part_info *part_info;
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC)) {
+	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK)) {
+		r = fastboot_block_get_part_info(part_name, &dev_desc, &disk_part,
+						 response);
+		if (r >= 0 && size)
+			*size = disk_part.size * disk_part.blksz;
+	} else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC)) {
 		r = fastboot_mmc_get_part_info(part_name, &dev_desc, &disk_part,
 					       response);
 		if (r >= 0 && size)
-- 
2.44.0.278.ge034bb2e1d-goog

