Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E42D116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 17:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEBFD83CCF;
	Mon,  1 Dec 2025 18:47:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="P3VHuo7a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 437DD83D00; Mon,  1 Dec 2025 18:47:33 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A38383C6C
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 18:47:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9D0FB3F28B
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 17:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1764611250;
 bh=97FFX131qpsTSXM7E21sFR09Ta/tR9/Qmutjow/JkZc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=P3VHuo7a6hEokU2wezQJbwqa1pjI2QUtwk3kWlzt1NnbDu2jqHhuRx1MRL9hKfLDp
 N5Z/226NuEykDA7n1EsDm46A0BM/oZltq/VEA1ZijYeGMcN6RWeaoRhUVGyRG+iORG
 XgjlC/7qVnt1jiDwaNAStcf652s7PvMQXWDVn9AD9Ky6LdlLEMpIZ9BoEXpQ3U+5R7
 97vemTYmsVCxggOEdrJOZrwqVFIlt0vM8L7ZbWP8S/a4zkxUlcNDLJdau962smLXx7
 pWrfAxJiZZhSSaXaPTZVD8O1s7KtKwmLYsE+kQvU8vbv+CLHCI0U9/WZ891ZyyVAqc
 gNsDTd0SPv7A02QsU33SccwMyrjhr3cDPPXR5BZnZwxVGE5BalMLrZtQMiGuD7u1Oz
 +mI5deOE3os8Qxe3hA2CuOrmPUofuGxBQoC/JdySP8YoUor3gbcYQSzjQbdr3nkYZN
 02dXdkKbLoqzAFGUMgHzXR7Jrx71rq1yxIS9YZcgK+7QCVIZiyAibDAWsrlMSruf4L
 wObIJz3o3KdI2x+12P5WZL+iGIs9NbxaCHLG82YDcwc8g75yJQud18xypT1UngA9vR
 xQpqp10ZYRk8SWVp6D0rAH2gCKUD33IYg4nwAiOKNETA/Qj8YEh5wFtoUc+bAkpgFp
 Nmq/zs4aRfyTenR8egePXkzQ=
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6460725c6a9so5531014a12.3
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 09:47:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764611250; x=1765216050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=97FFX131qpsTSXM7E21sFR09Ta/tR9/Qmutjow/JkZc=;
 b=Gsugko4+5TAenp54IOOm9Pbd+USWmfaOBbgRWIMCOaSKHzvtjez2MutfXELmFa+v5U
 lQ/BBRkX7DV8+YhzgAJdBE1brJDqbseqc+WcLNb5oKIUgoDUSROd7FAjZ7tTZait914U
 lSxjN4x4pj842Xi+rimav4X6w38ZWX82Kps3jjVPLLOcfdGZ2lZae60tQPPxXdfh1Bnz
 iM2mLr3qw/nB0ca8q2nyLt0X/JiIXxF8NMpzDw9x9yxOEiqqV/W+onOg2Qxw348Vr8oe
 jFiKLyfvoMAX7xfsTXoe77LSzThJPskbK2CWsAGs9CueEV2nOFlX7w27VMO+snlPnTPY
 5klw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtuMC2vGn++ppdPzOROhxrDYXD2Zb/3O6o2ho04NqpsKNvvR/yS+7JaSquV+v6qqKV4OC6KUw=@lists.denx.de
X-Gm-Message-State: AOJu0YyYuDzh2ggfOe4yv9wjk6HwWDM6SjXki/Zk/qzOoVnBMLaw4mUp
 4XR7OyFBm17nSD2fO2n5IqkXwkAu/7msz1UdSqnnUm87Ru+wfgbiaAO88wsc9l/+pktc4ojddBB
 ZRdPzdKBuhAlrtRX8tgoWiAI+0q5MhB9GGgYqQGC1QuvwSxqkBEohHBxy4Bb597ipAAkFIW0=
X-Gm-Gg: ASbGncuvq/G6RKjsoSMcIe6iP50fM4hqy17Qh11B6HtEGbbSEwWh+Kt5+Jb5timbY6v
 y1cOGrc/vmUKbJTawX/7R/mUczVijdFklfOI6cgDXewAl8o5lYpVKsK4ZlhBBrys3XtzSb6+HH/
 MIqFpnNVPBpQVsw//CXrhQ5l/AwAhcP6sb8M92rnOJklSfO5KfSiYY6LBbMirLdrJ9WulA05+vj
 Zl36V4fkbx7r/P2EkQv2qltv16EE4gacrCIWfqmx0ptPPszfrVChAXT3GWWXadBiL4gMKH0O6KN
 IAsV4XR0GF5AGiUKzqXn7firt9xmiE8LysGoAdQjuo7t5EtVzp8Mey8ldPYPdeqv72dEO7h750c
 2tftuSSTOph4iuRG/jNrAUBmdRs69chrr4gWkwDua9Y6obrsAdgOdFo5ing==
X-Received: by 2002:a17:907:3f14:b0:b76:4b18:49b6 with SMTP id
 a640c23a62f3a-b767170ad4cmr4295147366b.46.1764611250180; 
 Mon, 01 Dec 2025 09:47:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHL8Qs3PzVQpvXttrxrEgYdgxxWY4LMnu80MGeuDtvuNJNdmcWYHdXI/knVwIwuzoHna8c99A==
X-Received: by 2002:a17:907:3f14:b0:b76:4b18:49b6 with SMTP id
 a640c23a62f3a-b767170ad4cmr4295143466b.46.1764611249694; 
 Mon, 01 Dec 2025 09:47:29 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f51c67e2sm1288993566b.27.2025.12.01.09.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 09:47:29 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <zfsdt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Yao Zi <ziyao@disroot.org>, E Shattow <e@freeshell.de>,
 Hal Feng <hal.feng@starfivetech.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Heinrich Schuchardt <zfsdt@canonical.com>
Subject: [PATCH 2/2] test: provide unit tests for the RISC-V private GCC
 library
Date: Mon,  1 Dec 2025 18:47:05 +0100
Message-ID: <20251201174705.652626-3-zfsdt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201174705.652626-1-zfsdt@canonical.com>
References: <20251201174705.652626-1-zfsdt@canonical.com>
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Add unit tests for the functions for counting leading and trailing zero
bits.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Heinrich Schuchardt <zfsdt@canonical.com>
---
 test/lib/Makefile   |  4 ++++
 test/lib/test_clz.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
 test/lib/test_ctz.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 test/lib/test_clz.c
 create mode 100644 test/lib/test_ctz.c

diff --git a/test/lib/Makefile b/test/lib/Makefile
index 35b40b584c4..7c9dc180c8d 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -10,6 +10,10 @@ obj-y += abuf.o
 obj-y += alist.o
 obj-$(CONFIG_EFI_LOADER) += efi_device_path.o efi_memory.o
 obj-$(CONFIG_EFI_SECURE_BOOT) += efi_image_region.o
+ifdef CONFIG_RISCV
+obj-$(CONFIG_USE_PRIVATE_LIBGCC) += test_clz.o
+obj-$(CONFIG_USE_PRIVATE_LIBGCC) += test_ctz.o
+endif
 obj-y += hexdump.o
 obj-$(CONFIG_SANDBOX) += kconfig.o
 obj-y += lmb.o
diff --git a/test/lib/test_clz.c b/test/lib/test_clz.c
new file mode 100644
index 00000000000..11fd527d063
--- /dev/null
+++ b/test/lib/test_clz.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2025, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
+ */
+
+#include <test/lib.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+int __clzsi2(int a);
+int __clzdi2(long a);
+int __clzti2(long long a);
+
+/**
+ * test_clz() - test library functions to count leading zero bits
+ *
+ * @uts:	unit test state
+ */
+static int test_clz(struct unit_test_state *uts)
+{
+	ut_asserteq(0, __clzti2(0xffffffffffffffffLL));
+	ut_asserteq(0, __clzti2(0x8000000000000000LL));
+	ut_asserteq(1, __clzti2(0x4000000000000000LL));
+	ut_asserteq(17, __clzti2(0x0000500000a00000LL));
+	ut_asserteq(62, __clzti2(0x0000000000000002LL));
+	ut_asserteq(63, __clzti2(0x0000000000000001LL));
+
+#if BITS_PER_LONG == 64
+	ut_asserteq(0, __clzdi2(0xffffffffffffffffLL));
+	ut_asserteq(0, __clzti2(0x8000000000000000LL));
+	ut_asserteq(1, __clzti2(0x4000000000000000LL));
+	ut_asserteq(17, __clzdi2(0x0000500000a00000LL));
+	ut_asserteq(62, __clzdi2(0x0000000000000002LL));
+	ut_asserteq(63, __clzdi2(0x0000000000000001LL));
+#else
+	ut_asserteq(0, __clzdi2(0xffffffff));
+	ut_asserteq(0, __clzdi2(0x80000000));
+	ut_asserteq(1, __clzdi2(0x40000000));
+	ut_asserteq(9, __clzdi2(0x0050a000));
+	ut_asserteq(30, __clzdi2(0x00000002));
+	ut_asserteq(31, __clzdi2(0x00000001));
+#endif
+
+	ut_asserteq(0, __clzsi2(0xffffffff));
+	ut_asserteq(0, __clzsi2(0x80000000));
+	ut_asserteq(1, __clzsi2(0x40000000));
+	ut_asserteq(9, __clzsi2(0x0050a000));
+	ut_asserteq(30, __clzsi2(0x00000002));
+	ut_asserteq(31, __clzsi2(0x00000001));
+
+	return 0;
+}
+LIB_TEST(test_clz, 0);
diff --git a/test/lib/test_ctz.c b/test/lib/test_ctz.c
new file mode 100644
index 00000000000..96c08202dc2
--- /dev/null
+++ b/test/lib/test_ctz.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2025, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
+ */
+
+#include <test/lib.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+int __ctzsi2(int a);
+int __ctzdi2(long a);
+int __ctzti2(long long a);
+
+/**
+ * test_ctz() - test library functions to count trailing zero bits
+ *
+ * @uts:	unit test state
+ */
+static int test_ctz(struct unit_test_state *uts)
+{
+	ut_asserteq(0, __ctzti2(0xffffffffffffffffLL));
+	ut_asserteq(63, __ctzti2(0x8000000000000000LL));
+	ut_asserteq(62, __ctzti2(0x4000000000000000LL));
+	ut_asserteq(21, __ctzti2(0x0000500000a00000LL));
+	ut_asserteq(1, __ctzti2(0x0000000000000002LL));
+	ut_asserteq(0, __ctzti2(0x0000000000000001LL));
+
+#if BITS_PER_LONG == 64
+	ut_asserteq(0, __ctzdi2(0xffffffffffffffffLL));
+	ut_asserteq(63, __ctzdi2(0x8000000000000000LL));
+	ut_asserteq(62, __ctzdi2(0x4000000000000000LL));
+	ut_asserteq(21, __ctzdi2(0x0000500000a00000LL));
+	ut_asserteq(1, __ctzdi2(0x0000000000000002LL));
+	ut_asserteq(0, __ctzdi2(0x0000000000000001LL));
+#else
+	ut_asserteq(0, __ctzdi2(0xffffffff));
+	ut_asserteq(31, __ctzdi2(0x80000000));
+	ut_asserteq(30, __ctzdi2(0x40000000));
+	ut_asserteq(13, __ctzdi2(0x0050a000));
+	ut_asserteq(1, __ctzdi2(0x00000002));
+	ut_asserteq(0, __ctzdi2(0x00000001));
+#endif
+
+	ut_asserteq(0, __ctzsi2(0xffffffff));
+	ut_asserteq(31, __ctzsi2(0x80000000));
+	ut_asserteq(30, __ctzsi2(0x40000000));
+	ut_asserteq(13, __ctzsi2(0x0050a000));
+	ut_asserteq(1, __ctzsi2(0x00000002));
+	ut_asserteq(0, __ctzsi2(0x00000001));
+
+	return 0;
+}
+LIB_TEST(test_ctz, 0);
-- 
2.51.0

