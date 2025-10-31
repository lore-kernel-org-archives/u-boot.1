Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD396CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 17:09:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DC9383A5B;
	Fri, 31 Oct 2025 18:08:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E80B483A61; Fri, 31 Oct 2025 18:08:46 +0100 (CET)
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch
 [84.16.66.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1FC8839DF
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 18:08:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cynWH4QqVzbqL;
 Fri, 31 Oct 2025 18:08:43 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cynWG4fx3zy9S; Fri, 31 Oct 2025 18:08:42 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 31 Oct 2025 18:08:22 +0100
Subject: [PATCH v2 3/5] boot: group SPL_FIT symbols together
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-rsa-pss-always-v2-3-a29184ea064d@cherry.de>
References: <20251031-rsa-pss-always-v2-0-a29184ea064d@cherry.de>
In-Reply-To: <20251031-rsa-pss-always-v2-0-a29184ea064d@cherry.de>
To: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martin Schwan <m.schwan@phytec.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Alexander Graf <agraf@csgraf.de>, Loic Poulain <loic.poulain@linaro.org>, 
 Tobias Olausson <tobias@eub.se>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Shiji Yang <yangshiji66@outlook.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>, E Shattow <e@freeshell.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

Let's not mix with symbols from other phases.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 boot/Kconfig | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 967b17b5d6c..a37d08eff1d 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -174,12 +174,6 @@ config SPL_FIT
 	select SPL_HASH
 	select SPL_OF_LIBFDT
 
-config TPL_FIT
-	bool "Support Flattened Image Tree within TPL"
-	depends on TPL
-	select TPL_HASH
-	select TPL_OF_LIBFDT
-
 config SPL_FIT_PRINT
 	bool "Support FIT printing within SPL"
 	depends on SPL_FIT
@@ -285,6 +279,27 @@ config SPL_LOAD_FIT_FULL
 	  particular it can handle selecting from multiple device tree
 	  and passing the correct one to U-Boot.
 
+config SPL_FIT_IMAGE_POST_PROCESS
+	bool "Enable post-processing of FIT artifacts after loading by the SPL"
+	depends on SPL_LOAD_FIT
+	default y if TI_SECURE_DEVICE
+	help
+	  Allows doing any sort of manipulation to blobs after they got extracted
+	  from the U-Boot FIT image like stripping off headers or modifying the
+	  size of the blob, verification, authentication, decryption etc. in a
+	  platform or board specific way. In order to use this feature a platform
+	  or board-specific implementation of board_fit_image_post_process() must
+	  be provided. Also, anything done during this post-processing step would
+	  need to be comprehended in how the images were prepared before being
+	  injected into the FIT creation (i.e. the blobs would have been pre-
+	  processed before being added to the FIT image).
+
+config TPL_FIT
+	bool "Support Flattened Image Tree within TPL"
+	depends on TPL
+	select TPL_HASH
+	select TPL_OF_LIBFDT
+
 config TPL_LOAD_FIT
 	bool "Enable TPL loading U-Boot as a FIT (basic fitImage features)"
 	depends on TPL
@@ -307,21 +322,6 @@ config TPL_LOAD_FIT
 	  3. FDTs are only loaded for images with an "os" property of "u-boot".
 	     "linux" images are also supported with Falcon boot mode.
 
-config SPL_FIT_IMAGE_POST_PROCESS
-	bool "Enable post-processing of FIT artifacts after loading by the SPL"
-	depends on SPL_LOAD_FIT
-	default y if TI_SECURE_DEVICE
-	help
-	  Allows doing any sort of manipulation to blobs after they got extracted
-	  from the U-Boot FIT image like stripping off headers or modifying the
-	  size of the blob, verification, authentication, decryption etc. in a
-	  platform or board specific way. In order to use this feature a platform
-	  or board-specific implementation of board_fit_image_post_process() must
-	  be provided. Also, anything done during this post-processing step would
-	  need to be comprehended in how the images were prepared before being
-	  injected into the FIT creation (i.e. the blobs would have been pre-
-	  processed before being added to the FIT image).
-
 if VPL
 
 config VPL_FIT

-- 
2.51.0

