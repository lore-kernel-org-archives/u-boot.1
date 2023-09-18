Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE26CD37B0
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 06:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7504D8658D;
	Mon, 18 Sep 2023 08:11:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jc+fTlcv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E30B4867EA; Mon, 18 Sep 2023 08:11:50 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E85F88654B
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 08:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50300141a64so2668055e87.0
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 23:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695017508; x=1695622308; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OeREpAKEdFu+9uW1+y26vE0h+am1lCCggH9F4AHux34=;
 b=jc+fTlcvemTgZfez/8Bm+lNA0Nr6D/hzn3oqu1rTkQwokoa59k64euSGd76RsbAN3/
 a9cE/2tIeSyRQmpXCS1H2tdewSk7dHQ4+sziElAmk7qN+1SQSOcoktGEs3CMF3cZKwPW
 UOHFehlFUauojr+T+2JpoxC99i3wnzGlethammZ/pe6yPS99evY1bJ2yVUAxae2nIt+g
 hKZ6bwELhSzKxXGYpNCLFXAlIkyMU6/YEYxlNE+Wi4lwGdyaB0vOMV6GOnTL8sJIxj0Z
 Pc32rtDcgCLR/+pbvgMCv5fXdRvz6h4Fy8Sz/NWOdN/isKRhoxIzgyQx7zEbjccs+Z88
 lHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695017508; x=1695622308;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OeREpAKEdFu+9uW1+y26vE0h+am1lCCggH9F4AHux34=;
 b=aLXXMI1jpqDKBSjtXmvHQNC1ycxveJq795n3gbcgiq/UoqqnNqVRKso/kGBcUj3GXG
 u6gljs7OiaP8nHtvcQkQSyC8qOdMal9WEZma9HVMHO3fZ23Y+Mi4YRh5hL1c9lfSWr4X
 REHIj0zwl/Ubp0SU17kBO11FVleza4L0ft9kI8t4ALr7IKNMLGHquDSJ1hbCPxW570Aa
 a4WfgmjtAMGtTW0HfDkRf06FBwgABpdCOAq6a+LkH+Bw5sE8buONb7rJzblIEIjfpF82
 Q9O4WBDLw9HhnrnPL0O2BEHMsmsQsrg68YVL5c1LD0Q/hHBa/bRRW5bGJTj3vgP0sFs0
 Oktg==
X-Gm-Message-State: AOJu0YybWwTYuFas0Ge8dRjTD7ufiGWTaGsUkdL+ErDPh5rn2R+fRsOC
 jFwyyXhzhHIJEGH2noq6Ry3Rb1Ci0YnHgMJfBDU=
X-Google-Smtp-Source: AGHT+IF9X30ZNDvjCVAtdoP23ksMIpxt6JsBFQSFXsxAxpphCU+U1XwQY5XFDtrzVewk9SpJmkpw6A==
X-Received: by 2002:a05:6512:1090:b0:4fb:8948:2b28 with SMTP id
 j16-20020a056512109000b004fb89482b28mr9100148lfg.63.1695017507861; 
 Sun, 17 Sep 2023 23:11:47 -0700 (PDT)
Received: from Fecusia.lan (c-05d8225c.014-348-6c756e10.bbcust.telenor.se.
 [92.34.216.5]) by smtp.gmail.com with ESMTPSA id
 v18-20020ac25932000000b005009b4d5c14sm1636781lfi.265.2023.09.17.23.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 23:11:47 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Mauro Condarelli <mc5686@mclink.it>, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] RFT: mips: implement __udivdi3
Date: Mon, 18 Sep 2023 08:11:39 +0200
Message-ID: <20230918061139.810552-1-linus.walleij@linaro.org>
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

Squashfs wasn't compiling because the lldiv() directives
turn into __udivdi3 and we are using private libgcc.
This is just copied from the Linux kernel v6.6-rc1
arch/mips/include/asm/div64.h and then adjusted for
U-Boot.

After this squashfs compiles for MIPS.

Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Cc: Mauro Condarelli <mc5686@mclink.it>
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I can't test this because it didn't work for MTD devices
as I had expected, but I saw Mauro had this problem
before so I think I might have fixed it. I better put
the patch out there rather than let it sit on my drive.
---
 arch/mips/lib/Makefile  |  2 +-
 arch/mips/lib/udivdi3.c | 86 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/lib/udivdi3.c

diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 9ee1fcb5c702..1621cc9a1ff9 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -14,4 +14,4 @@ obj-$(CONFIG_CMD_BOOTM) += bootm.o
 obj-$(CONFIG_CMD_GO) += boot.o
 obj-$(CONFIG_SPL_BUILD) += spl.o
 
-lib-$(CONFIG_USE_PRIVATE_LIBGCC) += ashldi3.o ashrdi3.o lshrdi3.o
+lib-$(CONFIG_USE_PRIVATE_LIBGCC) += ashldi3.o ashrdi3.o lshrdi3.o udivdi3.o
diff --git a/arch/mips/lib/udivdi3.c b/arch/mips/lib/udivdi3.c
new file mode 100644
index 000000000000..6a4ee5fa46ab
--- /dev/null
+++ b/arch/mips/lib/udivdi3.c
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2000, 2004, 2021  Maciej W. Rozycki
+ * Copyright (C) 2003, 07 Ralf Baechle (ralf@linux-mips.org)
+ */
+
+#include "libgcc.h"
+
+/*
+ * No traps on overflows for any of these...
+ */
+
+#define do_div64_32(res, high, low, base) ({				\
+	unsigned long __cf, __tmp, __tmp2, __i;				\
+	unsigned long __quot32, __mod32;				\
+									\
+	__asm__(							\
+	"	.set	push					\n"	\
+	"	.set	noat					\n"	\
+	"	.set	noreorder				\n"	\
+	"	move	%2, $0					\n"	\
+	"	move	%3, $0					\n"	\
+	"	b	1f					\n"	\
+	"	 li	%4, 0x21				\n"	\
+	"0:							\n"	\
+	"	sll	$1, %0, 0x1				\n"	\
+	"	srl	%3, %0, 0x1f				\n"	\
+	"	or	%0, $1, %5				\n"	\
+	"	sll	%1, %1, 0x1				\n"	\
+	"	sll	%2, %2, 0x1				\n"	\
+	"1:							\n"	\
+	"	bnez	%3, 2f					\n"	\
+	"	 sltu	%5, %0, %z6				\n"	\
+	"	bnez	%5, 3f					\n"	\
+	"2:							\n"	\
+	"	 addiu	%4, %4, -1				\n"	\
+	"	subu	%0, %0, %z6				\n"	\
+	"	addiu	%2, %2, 1				\n"	\
+	"3:							\n"	\
+	"	bnez	%4, 0b					\n"	\
+	"	 srl	%5, %1, 0x1f				\n"	\
+	"	.set	pop"						\
+	: "=&r" (__mod32), "=&r" (__tmp),				\
+	  "=&r" (__quot32), "=&r" (__cf),				\
+	  "=&r" (__i), "=&r" (__tmp2)					\
+	: "Jr" (base), "0" (high), "1" (low));				\
+									\
+	(res) = __quot32;						\
+	__mod32;							\
+})
+
+#define __div64_32(n, base) ({						\
+	unsigned long __upper, __low, __high, __radix;			\
+	unsigned long long __quot;					\
+	unsigned long long __div;					\
+	unsigned long __mod;						\
+									\
+	__div = (*n);							\
+	__radix = (base);						\
+									\
+	__high = __div >> 32;						\
+	__low = __div;							\
+									\
+	if (__high < __radix) {						\
+		__upper = __high;					\
+		__high = 0;						\
+	} else {							\
+		__upper = __high % __radix;				\
+		__high /= __radix;					\
+	}								\
+									\
+	__mod = do_div64_32(__low, __upper, __low, __radix);		\
+									\
+	__quot = __high;						\
+	__quot = __quot << 32 | __low;					\
+	(*n) = __quot;							\
+	__mod;								\
+})
+
+long long __udivdi3(long long u, word_type b)
+{
+	long long ret = u;
+
+	__div64_32(&ret, b);
+	return ret;
+}
-- 
2.41.0

