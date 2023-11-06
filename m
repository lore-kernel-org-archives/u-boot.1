Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66186C4167B
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:52:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C676C86F87;
	Mon,  6 Nov 2023 17:52:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f3jGjyW+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B621387097; Mon,  6 Nov 2023 17:52:10 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C624886335
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:52:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9dbb3e0ff65so646424866b.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 08:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699289528; x=1699894328; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fd3jwPCqgwA8prXs7k5nvHB/z/tLvqDtDEF1Dlg+HCg=;
 b=f3jGjyW+YM5pHoTkZ1ROAf2o8S5L3qNJUatUEGSZhgoauhXNa6XCqkehaHVbG0udYP
 iN5ztoQYCRK/P+nJmDSs8KOoAHVhvP2+gHLjbXucPnDiSU3L4ahlgPJVQqb0ne4k2/5A
 2nUqCgrqngV4oE2vSIyoEtbUgYhnGccxuQdy6gWL8OnrG9xT3WxecopVscmJjUujL7IR
 Ie2KUdkr7Ejn84E3QZt3xbfxcQFdmqWaPCaDAGTXPfWII/YE/x+o+3SW8ImANpb6xz56
 qP2nw/oyyS2QfIUeOdFW1NIZgeG88kr9MdfOyKm3bYzlmDUMdNf3B3/bOTuPSbvU1yqw
 LSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699289528; x=1699894328;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fd3jwPCqgwA8prXs7k5nvHB/z/tLvqDtDEF1Dlg+HCg=;
 b=GRg6ehSy7mazGWd3YkzwB76M7Z/C2TtCR+16VA+NL2KbxNvJSUd/Lvk5ett/mSgSYG
 geyAoti4LHUzwN1+ZNTere8PHIzlPFmHzq/UidxqPvHuPmQB6SukA/0XPAShH7vbv9ir
 nsV7ELEypqSkYAacdVaLPWUSfWu9RBlihxKsubLIfWWHbUbXajS3I6y/faeSUwOAaljJ
 c6ZWtB/TnepCUtnWcXjANy/2202kh9S7cVXNm35YG7FoDhqr4UwmOWAC0gClJZkXnR+y
 Z7Eme1AGzROu5VLlqzQUpHsIWdbnj190cfMK1MuCWQUHZJC9pihpF6gggStwEFRExhFv
 XD3Q==
X-Gm-Message-State: AOJu0YyWvUwg8jM8qwjD+AGptciAynlV6byPsM2hu0FsPoK9frfRzONB
 Ue9a4drKm2/DURx04gwQ8Af8oa7o12w=
X-Google-Smtp-Source: AGHT+IH8sn3sSZrOJDl95+VlVLYAOUDjqNBNSyKpuQxSirMYU18Ruy8GkLjy0kZxKtIjxqS4lrIA8g==
X-Received: by 2002:a17:907:2d91:b0:9ae:5765:c134 with SMTP id
 gt17-20020a1709072d9100b009ae5765c134mr17667543ejc.15.1699289528066; 
 Mon, 06 Nov 2023 08:52:08 -0800 (PST)
Received: from workstation.sas.sys.sphairon.com (51-6-142-46.pool.kielnet.net.
 [46.142.6.51]) by smtp.gmail.com with ESMTPSA id
 u11-20020a17090617cb00b009920e9a3a73sm28267eje.115.2023.11.06.08.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 08:52:07 -0800 (PST)
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
To: u-boot@lists.denx.de
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: [PATCH] mips: implement __udivdi3
Date: Mon,  6 Nov 2023 17:51:48 +0100
Message-ID: <20231106165157.298319-1-daniel.schwierzeck@gmail.com>
X-Mailer: git-send-email 2.41.0
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

From: Linus Walleij <linus.walleij@linaro.org>

Squashfs wasn't compiling because the lldiv() directives
turn into __udivdi3 and we are using private libgcc.

After this squashfs compiles for MIPS.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>

---
Linus, this is the updated and optimized version of your initial patch.
Sorry for the long delay ;)

 arch/mips/lib/Makefile  |  2 +-
 arch/mips/lib/udivdi3.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/lib/udivdi3.c

diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 9ee1fcb5c7..1621cc9a1f 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -14,4 +14,4 @@ obj-$(CONFIG_CMD_BOOTM) += bootm.o
 obj-$(CONFIG_CMD_GO) += boot.o
 obj-$(CONFIG_SPL_BUILD) += spl.o
 
-lib-$(CONFIG_USE_PRIVATE_LIBGCC) += ashldi3.o ashrdi3.o lshrdi3.o
+lib-$(CONFIG_USE_PRIVATE_LIBGCC) += ashldi3.o ashrdi3.o lshrdi3.o udivdi3.o
diff --git a/arch/mips/lib/udivdi3.c b/arch/mips/lib/udivdi3.c
new file mode 100644
index 0000000000..4d780117cf
--- /dev/null
+++ b/arch/mips/lib/udivdi3.c
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include "libgcc.h"
+
+#if BITS_PER_LONG == 32
+
+#include <div64.h>
+
+long long __udivdi3(long long u, word_type b)
+{
+	long long ret = u;
+
+	__div64_32(&ret, b);
+	return ret;
+}
+
+#endif /* BITS_PER_LONG == 32 */
-- 
2.41.0

