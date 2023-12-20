Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AE5C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 09:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04D8786FFE;
	Wed, 20 Dec 2023 10:00:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1619D86DEE; Wed, 20 Dec 2023 10:00:56 +0100 (CET)
Received: from 7.mo584.mail-out.ovh.net (7.mo584.mail-out.ovh.net
 [178.33.253.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9944687480
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 10:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director4.ghost.mail-out.ovh.net (unknown [10.108.25.156])
 by mo584.mail-out.ovh.net (Postfix) with ESMTP id 0BBBF289D9
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 09:00:50 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-8n8c9 (unknown [10.111.182.166])
 by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 164D21FE94;
 Wed, 20 Dec 2023 09:00:50 +0000 (UTC)
Received: from armadeus.com ([37.59.142.97])
 by ghost-submission-6684bf9d7b-8n8c9 with ESMTPSA
 id jDdyAEKtgmXqFQAA+qPHTg
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Wed, 20 Dec 2023 09:00:49 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0024a5eb072-6ccb-4b1a-9261-c667a59cfd72,
 CCF55E9A36CE62B71F09469834F038924BAB166A)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 92.148.253.243
From: =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Fabio Estevam <festevam@denx.de>,
 Heiko Schocher <hs@denx.de>, Jesse Taube <mr.bossman075@gmail.com>,
 Eduard Strehlau <eduard@lionizers.com>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
Subject: [PATCH 1/1] Makefile: pass -ansi option to cmd_gen_envp
Date: Wed, 20 Dec 2023 09:59:54 +0100
Message-ID: <20231220085955.25561-1-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12484541119409613803
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduuddguddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnheptdevkeeuhfdtvdevkeegffegveduleehvdetkeegtdekjeefhfettdfggedviefgnecuffhomhgrihhnpehgnhhurdhorhhgnecukfhppeduvdejrddtrddtrddupdelvddrudegkedrvdehfedrvdegfedpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoshgvsggrshhtihgvnhdrshiihihmrghnshhkihesrghrmhgruggvuhhsrdgtohhmqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdpoffvtefjohhsthepmhhoheekgedpmhhouggvpehsmhhtphhouhht
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

Without the '-ansi' option, the 'linux' string in env. files is replaced
with the string '1 '. For example, in the
board/armadeus/opos6uldev/opos6uldev.env file,

kernelimg=opos6ul-linux.bin

becomes

kernelimg=opos6ul-1 .bin

in the include/generated/env.in.

That's because 'linux' is a System-specific Predefined Macros. [1]

Pass the '-ansi' option as suggested by the GCC documentation. [1]
Fix the two .env files using C++ comment style for their SPDX licence.

[1] https://gcc.gnu.org/onlinedocs/gcc-13.2.0/cpp/System-specific-Predefined-Macros.html

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 Makefile                            | 3 ++-
 board/siemens/iot2050/iot2050.env   | 2 +-
 board/storopack/smegw01/smegw01.env | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 750bbdb1b713..5fc7a20df7f0 100644
--- a/Makefile
+++ b/Makefile
@@ -1803,7 +1803,8 @@ ENV_FILE := $(if $(ENV_SOURCE_FILE),$(ENV_FILE_CFG),$(wildcard $(ENV_FILE_BOARD)
 quiet_cmd_gen_envp = ENVP    $@
       cmd_gen_envp = \
 	if [ -s "$(ENV_FILE)" ]; then \
-		$(CPP) -P $(CFLAGS) -x assembler-with-cpp -D__ASSEMBLY__ \
+		$(CPP) -P $(CFLAGS) -x assembler-with-cpp -ansi \
+			-D__ASSEMBLY__ \
 			-D__UBOOT_CONFIG__ \
 			-I . -I include -I $(srctree)/include \
 			-include linux/kconfig.h -include include/config.h \
diff --git a/board/siemens/iot2050/iot2050.env b/board/siemens/iot2050/iot2050.env
index 8bbd7abe98f0..a3bdbf4f6998 100644
--- a/board/siemens/iot2050/iot2050.env
+++ b/board/siemens/iot2050/iot2050.env
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) Siemens AG, 2023
  *
diff --git a/board/storopack/smegw01/smegw01.env b/board/storopack/smegw01/smegw01.env
index 93de8669109d..6807ada71887 100644
--- a/board/storopack/smegw01/smegw01.env
+++ b/board/storopack/smegw01/smegw01.env
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 #ifdef CONFIG_SYS_BOOT_LOCKED
 #define SETUP_BOOT_MENU setup_boot_menu=setenv bootmenu_0 eMMC=run bootcmd
 #else
-- 
2.41.0

