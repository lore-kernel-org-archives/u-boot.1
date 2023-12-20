Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122B5C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 09:01:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A9A38760D;
	Wed, 20 Dec 2023 10:01:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 083798765B; Wed, 20 Dec 2023 10:01:22 +0100 (CET)
Received: from 5.mo550.mail-out.ovh.net (5.mo550.mail-out.ovh.net
 [178.33.45.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB318761C
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 10:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director4.ghost.mail-out.ovh.net (unknown [10.108.9.73])
 by mo550.mail-out.ovh.net (Postfix) with ESMTP id C6D9B26B27
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 09:01:18 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-8n8c9 (unknown [10.111.182.166])
 by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id ED18C1FED4;
 Wed, 20 Dec 2023 09:01:17 +0000 (UTC)
Received: from armadeus.com ([37.59.142.97])
 by ghost-submission-6684bf9d7b-8n8c9 with ESMTPSA
 id 4MM7NF2tgmXqFQAA+qPHTg
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Wed, 20 Dec 2023 09:01:17 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0027aff7159-53ee-45f6-97a9-5694e135af5a,
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
Subject: [PATCH v2 1/1] Makefile: pass -ansi option to cmd_gen_envp
Date: Wed, 20 Dec 2023 09:59:55 +0100
Message-ID: <20231220085955.25561-2-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231220085955.25561-1-sebastien.szymanski@armadeus.com>
References: <20231220085955.25561-1-sebastien.szymanski@armadeus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12492422416434195435
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepuforsggrshhtihgvnhcuufiihihmrghnshhkihcuoehsvggsrghsthhivghnrdhsiiihmhgrnhhskhhisegrrhhmrgguvghushdrtghomheqnecuggftrfgrthhtvghrnhepudevgfevlefghfelteevvefhieekudfhfeeuvdegudeludejkeefffeffeffueelnecuffhomhgrihhnpehgnhhurdhorhhgnecukfhppeduvdejrddtrddtrddupdelvddrudegkedrvdehfedrvdegfedpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoshgvsggrshhtihgvnhdrshiihihmrghnshhkihesrghrmhgruggvuhhsrdgtohhmqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdpoffvtefjohhsthepmhhoheehtddpmhhouggvpehsmhhtphhouhht
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

in the include/generated/env.in file.

That's because 'linux' is a System-specific Predefined Macros. [1]

Pass the '-ansi' option as suggested by the GCC documentation. [1]
The option "disables recognition of C++ style ‘//’ comments" [2] so fix the
two .env files using C++ comment style for the SPDX licence.

[1] https://gcc.gnu.org/onlinedocs/gcc-13.2.0/cpp/System-specific-Predefined-Macros.html
[2] https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-Options.html#index-ANSI-support

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---

Changes for v2:
 - explain the change of iot2050.env and smegw01.env in the commit log

 Makefile                            | 3 ++-
 board/siemens/iot2050/iot2050.env   | 2 +-
 board/storopack/smegw01/smegw01.env | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 220411a293f4..6703646d48a4 100644
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

