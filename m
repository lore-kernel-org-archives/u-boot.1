Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5295DCD3424
	for <u-boot@archiver.kernel.org>; Sun,  3 May 2026 20:50:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 880138460D;
	Sun,  3 May 2026 22:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YU9RL2hg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BFF48460D; Sun,  3 May 2026 22:50:17 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 323818460E
 for <u-boot@lists.denx.de>; Sun,  3 May 2026 22:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6949f3eeaf6so1837686eaf.0
 for <u-boot@lists.denx.de>; Sun, 03 May 2026 13:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777841413; x=1778446213; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CjL/zERxLRKvSiRJOy+ECOsm64FP/vH4t+IFexREaws=;
 b=YU9RL2hgcBgH94vyWvKcugK8bXg/gNZVaDxm+Eg4HuIuf47TRu7lAHL9JHrNvt2HN1
 2+YoNo6sc5iWyoLtVqcl/RFMHfO1uSK2DTfqNrcY1OFW66tCrQGYxSXEGbWnz6kGjRgO
 FUu7nwC9HhL4edjj9E+02uVqiYiV7Ts0BNAQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777841413; x=1778446213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CjL/zERxLRKvSiRJOy+ECOsm64FP/vH4t+IFexREaws=;
 b=XhDxDCeGpqoyu7nxma7STHzD0QiiC1DeBi1vwv2deRMM1uRpoZVIlyBVPfCzx+QiR9
 OggT0kla4QW25zfdiXcWQPe2xgxsaHvtKODP1922SWFnHLb8gGFI6QS9tja8ROzLKyLW
 la9ogsc+pB3LqLdZ40VI9BkPRvl2u0W9R3SU61s8B8hVia16Lltsd5aTJizYntkdk2S6
 ovRTXNC0GuqXEGa4+ZgvgbUHc3szBdE6jTfwK93kKi1LjZAxS64FYG07K9PNKpHMr4SI
 LkTr17BfnLNjbFBGZfy8zcuVFSaT3sVatemp8kjGmLQs8uoZQyVNeV5BOTJdg2cGZlY/
 drJA==
X-Gm-Message-State: AOJu0YwvKr9gyBnYrJw9D3VAtpaQvcEt55/e3gqjXcpcps93QufRMTdO
 rXpj87o4Zual+2wWkVO093a6J/E3G0T/3zvX6w4YHDuKhJNToMwp//f3dP1zniXcjNZ6joeae3e
 suM2Ttw==
X-Gm-Gg: AeBDieu0Yfs8YYWq6W98eYlnn3gbEQrBBCc6wtP0jgQduZ3ozUUHgZIhHMfp/p8nqkI
 yhguHmtF+NO4loJbkHZnPJkOvThcRnF5YsGnzmMaa97IHUE30FNx9LOLJJWpIDQRw2wRm0O+qo8
 7ohUG3PqG0d4+Ho0jCtZp9JnNPubesE2y5ute6TQckMfx+5Z5PHLrdpZTh9vWUXyxm2l5rfbb3h
 LQ/DZIq7VZBp60MNT//LGg0dQiTfnFSIJA0ojXH0S1tdU2KsnPG3Z+XhIDpAJ8aIuxIlkHPQhmq
 07HhTVakcp3jbrOf36VL0aFEfznLlmh0lRRvWHEAZzG7rnBw/Zu66aDPGTigQUNVqQnriTY7Jsm
 7X9bUOo99enadqssaayN4idWEIgkO+6eARJzRFAWWA5biWLRxNubqlIcTb1jYvSXpS//XtQrEPr
 4UaXFWqxIwSfJbujO00RM4JaOuSP4D
X-Received: by 2002:a05:6820:16ac:b0:694:9910:f78f with SMTP id
 006d021491bc7-69696b029b3mr2821014eaf.3.1777841413388; 
 Sun, 03 May 2026 13:50:13 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696aacbb5bbsm1142940eaf.15.2026.05.03.13.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2026 13:50:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Enrico Leto <enrico.leto@siemens.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/6] siemens: Quote A/B flags in env tests
Date: Sun,  3 May 2026 14:49:21 -0600
Message-ID: <20260503204936.3151124-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260503204936.3151124-1-sjg@chromium.org>
References: <20260503204936.3151124-1-sjg@chromium.org>
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

The Siemens am33x-common, env-common and draco-etamin headers gate
boot-partition selection logic on:

    if test -n ${A}; then ...
    if test -n ${B}; then ...

A and B are flags that the upgrade machinery sets to mark "the other
partition just became active".  The default state is unset, in which
case the expression expands to 'test -n' with no operand and relies
on a U-Boot 'test' quirk that treats a missing operand as false to
skip the branch.

Quote each variable so an unset A or B expands to 'test -n ""' and
the emptiness check is explicit.

Fixes: 8b0619579b22 ("cmd: test: fix handling of single-argument form of test")
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/configs/draco-etamin.h         |  4 ++--
 include/configs/siemens-am33x-common.h | 12 ++++++------
 include/configs/siemens-env-common.h   |  8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/configs/draco-etamin.h b/include/configs/draco-etamin.h
index 6ae85b575b7..b1b403980b1 100644
--- a/include/configs/draco-etamin.h
+++ b/include/configs/draco-etamin.h
@@ -99,10 +99,10 @@
 	"nand_args=run bootargs_defaults;" \
 		"mtdparts default;" \
 		"setenv ${partitionset_active} true;" \
-		"if test -n ${A}; then " \
+		"if test -n \"${A}\"; then " \
 			"setenv nand_active_ubi_vol ${rootfs_name}_a;" \
 		"fi;" \
-		"if test -n ${B}; then " \
+		"if test -n \"${B}\"; then " \
 			"setenv nand_active_ubi_vol ${rootfs_name}_b;" \
 		"fi;" \
 		"setenv nand_root ubi0:${nand_active_ubi_vol} rw " \
diff --git a/include/configs/siemens-am33x-common.h b/include/configs/siemens-am33x-common.h
index a918dc1350c..da822556909 100644
--- a/include/configs/siemens-am33x-common.h
+++ b/include/configs/siemens-am33x-common.h
@@ -104,11 +104,11 @@
 				"then " \
 				"setenv upgrade_available 0;" \
 				"setenv ${partitionset_active} true;" \
-				"if test -n ${A}; then " \
+				"if test -n \"${A}\"; then " \
 					"setenv partitionset_active B; " \
 					"env delete A; " \
 				"fi;" \
-				"if test -n ${B}; then " \
+				"if test -n \"${B}\"; then " \
 					"setenv partitionset_active A; " \
 					"env delete B; " \
 				"fi;" \
@@ -205,11 +205,11 @@
 	"nand_args=run bootargs_defaults;" \
 		"mtdparts default;" \
 		"setenv ${partitionset_active} true;" \
-		"if test -n ${A}; then " \
+		"if test -n \"${A}\"; then " \
 			"setenv nand_active_ubi_vol ${nand_active_ubi_vol_A};" \
 			"setenv nand_src_addr ${nand_src_addr_A};" \
 		"fi;" \
-		"if test -n ${B}; then " \
+		"if test -n \"${B}\"; then " \
 			"setenv nand_active_ubi_vol ${nand_active_ubi_vol_B};" \
 			"setenv nand_src_addr ${nand_src_addr_B};" \
 		"fi;" \
@@ -279,10 +279,10 @@
 	"nand_args=run bootargs_defaults;" \
 		"mtdparts default;" \
 		"setenv ${partitionset_active} true;" \
-		"if test -n ${A}; then " \
+		"if test -n \"${A}\"; then " \
 			"setenv nand_active_ubi_vol ${rootfs_name}_a;" \
 		"fi;" \
-		"if test -n ${B}; then " \
+		"if test -n \"${B}\"; then " \
 			"setenv nand_active_ubi_vol ${rootfs_name}_b;" \
 		"fi;" \
 		"setenv nand_root ubi0:${nand_active_ubi_vol} rw " \
diff --git a/include/configs/siemens-env-common.h b/include/configs/siemens-env-common.h
index c028823e1eb..8ced77cc5e2 100644
--- a/include/configs/siemens-env-common.h
+++ b/include/configs/siemens-env-common.h
@@ -81,12 +81,12 @@
  */
 #define ENV_FCT_TOGGLE_PARTITION "toggle_partition="\
 	"setenv ${partitionset_active} true;" \
-	"if test -n ${A}; " \
+	"if test -n \"${A}\"; " \
 	"then " \
 		"setenv partitionset_active B; " \
 		"env delete A; " \
 	"fi;" \
-	"if test -n ${B}; "\
+	"if test -n \"${B}\"; "\
 	"then " \
 		"setenv partitionset_active A; " \
 		"env delete B; " \
@@ -103,11 +103,11 @@
  */
 #define ENV_EMMC_FCT_SET_ACTIVE_PARTITION "set_partition=" \
 	"setenv ${partitionset_active} true;" \
-	"if test -n ${A}; " \
+	"if test -n \"${A}\"; " \
 	"then " \
 		"setenv mmc_part_nr 1;" \
 	"fi;" \
-	"if test -n ${B}; " \
+	"if test -n \"${B}\"; " \
 	"then " \
 		"setenv mmc_part_nr 2;" \
 	"fi;" \
-- 
2.43.0

