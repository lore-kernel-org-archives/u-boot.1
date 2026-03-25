Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A085D109C059
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:00:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDB5C83CD3;
	Wed, 25 Mar 2026 20:00:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QKewJyKl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB96983F86; Wed, 25 Mar 2026 20:00:25 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96EA983AAB
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d7f09aa39fso189201a34.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774465222; x=1775070022; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zIz5Iy2q+QCrDoKr77CawpoPk0gmdru0oTOun5N3aj8=;
 b=QKewJyKlqakeMP8Njm9L+UoKjT1oxmI1qksR/UOCNqB/uTRpiJ3m1byUbzLzRjk8fu
 j/tXAxgUxl8GpMWL5Nr7ppPETgNQaXpa9fOnowbXE/PuZgegoBlOvTKdMMXxT+1Fc/FR
 8mD38ovOf2RUANel1lVqFdWmuQZlS8n36mxcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774465222; x=1775070022;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zIz5Iy2q+QCrDoKr77CawpoPk0gmdru0oTOun5N3aj8=;
 b=LKtwk750UstpOt62qKVCrhSQjFwO7B0b+jBsnAZVkOfI+QQswGcI9H+dHkvGegn0Sz
 AQwfVW+kTcBVF1kpLmQtjxp3pxPISw4CdbMBPGvDBlRxrmiylUPubPdabPLEjXc4/wE8
 ORpaBnQTi19Cm6TQkRIfa/B8uAv6chAVgxZrZ3pKjk9854XknfJJ1n6lSrthfz9tbp8H
 fcewKWJ8CB0jgighFTbkp9A+Xf6dx7T8btPSumZW40jAFukesEjeFzo3a1KZU4hgsWId
 3bzd04xpbYGn6OJJlzIw+Clqc44j7sgoUUI+H91p62rqV1bxJPY+63b01hJ2LCyXEfk6
 SBMQ==
X-Gm-Message-State: AOJu0YwaTE9q4KKuHIYrFmMlhhvzRRIWj0TA/RPlc9aBx63EkJmNL97Q
 zRrlYrqHBVqwAy1N2IjikodPbrFHfVCLgCvU4xXV/XU4ZYz22ajEnWF+QCeJ1/6NezbuGPWkrpM
 ELg7pdFY=
X-Gm-Gg: ATEYQzztDgiIZm2RWfc9F35OoKBm5HJLc85pUk8xcaOKVtgPzT5mFUQyoi/SNE4i8d8
 kXl9lFfsexZvQAAPzkHFSd45mtftF/etscjx6gV6hOagQSvG9lPqO247V2J4Jpwh19iAJFV1Tb7
 j78xbeuypKdHkWboDiIzFDRQJceYvdSoKnGoZlckJZSVZOKImXYJdiqqitkBQ00b5EK/THjVpj7
 0ugdphdi7o29Vlb9RbW/RUkNlPDmHqge0G9B+AFN5cn7ITX97zH+FLUVPDqFC7pR9vfg8cqRbDr
 ohxGAHcnHlT5wLkIFMTpNZIdX/mnhM/FFeCaI1aYPoXtQbvej/dk1PN53rzS6nKQvPLzXa2+rRf
 RLxervkqS5AcY64uowA6aNc0uhKx4KzZ5zUionDM2VBeuXcheEFzCHKsuxHRcBdFrYH8Q3Lsqh+
 /qwdVe+EzdQeISjzJcyDzBa6huDUE5Z24Y+oH6s6Q/0GUPBTzxgHMhlwCJo2RcrEgASifeGpDGO
 LplFzUhKBU8S5AIYHrqSyqnXiNfOuDeiRRUHpnzV7y3LKlj3Ro=
X-Received: by 2002:a05:6830:6f45:b0:7d7:b85f:25e7 with SMTP id
 46e09a7af769-7d9d6a99aa9mr2295783a34.28.1774465222172; 
 Wed, 25 Mar 2026 12:00:22 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d9e6fde0d1sm518811a34.7.2026.03.25.12.00.21
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:00:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] spl: Remove unused CONFIG_SPL_FRAMEWORK_BOARD_INIT_F option
Date: Wed, 25 Mar 2026 13:00:20 -0600
Message-ID: <20260325190020.3428514-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The option CONFIG_SPL_FRAMEWORK_BOARD_INIT_F enables a simple
board_init_f function in SPL. This however is never enabled, so remove
this function and option.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/spl/Kconfig |  9 ---------
 common/spl/spl.c   | 17 -----------------
 2 files changed, 26 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 57b2bef5e541..a21b71ad5d19 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -27,15 +27,6 @@ config SPL_FRAMEWORK
 	  supports MMC, NAND and YMODEM and other methods loading of U-Boot
 	  and the Linux Kernel.  If unsure, say Y.
 
-config SPL_FRAMEWORK_BOARD_INIT_F
-	bool "Define a generic function board_init_f"
-	depends on SPL_FRAMEWORK
-	help
-	  Define a generic function board_init_f that:
-	  - initialize the spl (spl_early_init)
-	  - initialize the serial (preloader_console_init)
-	  Unless you want to provide your own board_init_f, you should say Y.
-
 config SPL_SIZE_LIMIT
 	hex "Maximum size of SPL image"
 	default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 8256fa978629..722b18c98edc 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -669,23 +669,6 @@ static int boot_from_devices(struct spl_image_info *spl_image,
 	return ret;
 }
 
-#if defined(CONFIG_SPL_FRAMEWORK_BOARD_INIT_F)
-void board_init_f(ulong dummy)
-{
-	if (CONFIG_IS_ENABLED(OF_CONTROL)) {
-		int ret;
-
-		ret = spl_early_init();
-		if (ret) {
-			debug("spl_early_init() failed: %d\n", ret);
-			hang();
-		}
-	}
-
-	preloader_console_init();
-}
-#endif
-
 void board_init_r(gd_t *dummy1, ulong dummy2)
 {
 	u32 spl_boot_list[] = {
-- 
2.43.0

