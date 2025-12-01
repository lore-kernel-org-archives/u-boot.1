Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8DED116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 17:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FE6383CB1;
	Mon,  1 Dec 2025 18:49:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="q67K7nV+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B14283D1A; Mon,  1 Dec 2025 18:49:42 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF95B83D0C
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 18:49:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5125D3FA6A
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 17:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1764611368;
 bh=Q+1s8w8kvYcvqyfpjFQgvbWb7I9WRuDEMHA9PooceB8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=q67K7nV+bulMtxk5y5nhe9XU2icKLJcArAU2tbJSdTMhyMFBVEQwJ3v2pVrBI0nCc
 3iF9NyJcx0IUMpQumYV4o98v0ckOqurbus7cfi2Yrt2wlyESQ3Jav3YVBBRnZEvKjU
 st1rLp2X1G0bKws2VuQiZQBn+kopSkTZvzQHMJz/ussOHVl94bggGTP9Q8s1at4JsC
 2KSN7jV1y2eKT4PIRXHYWFt/CXK5eBxLGTqDPClbMaRALlbz+G4iN7hIoLpuA59NHz
 OgcU1lmIIaUP4zbR0r8WT6pscFzWWGRAxXq1wjxLAV5iFbYGFP2g8LuwHGnLFEs4kZ
 ankhdt2yS81Y1tVcAya7BDlAAVlIYbh1onIw0ph/nDMUSHDbBiEoXmIMjX5oEUZZbJ
 NyWI89N0/FGsTPeozLEbrHW/sXPuNK2HngPoDn07M3Js1gZblP21oP1rls7Zy7l7di
 XMs3wgDJQQkXUOH0IjuBt0jSFAuEC2r5E2vtM+wM6NuIKQT1EcrzjECPnza8r62p0O
 kLVBYKAN8tp/cQEcPU2A5iZKYmH1P5R2/GvcTkpi/KCTizUIdwYsilgfqMpZ+WHw2p
 wIjh9fcFL1QIDqow1Z16ySI3pGmD4mBLUwo+uxEZlnmn2QCpKQUDslUzeKD+LAyYav
 1OqA7sMacC1wF5iCT8igzeic=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477939321e6so26109755e9.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 09:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764611360; x=1765216160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q+1s8w8kvYcvqyfpjFQgvbWb7I9WRuDEMHA9PooceB8=;
 b=mTqeqFYVoFrAfYDhMT8EnVGN3tMGRyBTN7XEnei2eKI4tnmF8Dn1qGUg2EkTRckv7n
 4vaELqkfOSJAYb5/xLwHpwhxMmD5b61KQPdabaWxaC22NKF9N6nfE81IxImZjZU5ya+o
 KkczEqNsT8CH1SEP1c73W7upt3ZrSMF8ImMhKlRQV6Wctx/A5xPTHf6+YmDOW8wsyeyq
 MYaBtsaGQcMNdlvWJnOPXIMKRKuuAn0dd57wQO2fWYNlXdiI0SSgSVeXVPfJ2W3ywi8O
 yP+aHaVb/a7vL7iKtf6IH37/jdG6l4VF8zR5CiU/A3LJHKvcLu9koUi9XlN5AjJjXR51
 O1uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZkHW7mpAijv8oWe3xaLHj4K8SyTQKmYCklYKx+ecxyVE3H3/2zyRrb//mdqGZYVcloGxp2pM=@lists.denx.de
X-Gm-Message-State: AOJu0YzUAEALZ87g1tXTfWKIGWdv76TihGCZFpFt/o42SDf7GbRbyoku
 AEoQWRvf4ICyp4LWX5MgFTNQi/KRi6y8/1iaNRy3zRI98LECIdD9b8gWxXln3IW3mj5ZXM0XB5k
 JrexRZuqA0Jj1vQInmlSgQzKvoqeCnLr7oeeS8bxC8mG1/cuZ/EPF1luRV8HHGLNvPF11hWA=
X-Gm-Gg: ASbGncvO/7vbjXJ4Kpej3zPzZVLEnu/RNuBgL8g9QBR+EmdjZPVfrKCUZKbZznHnNMg
 8YT7hmxZpAE5PEvuEYgSn13uozvYmF8St4BnQQu28FPwIwZye1iiRJPjmpih9CWoRyHuUK7wO4l
 KTgFYy8wv/6c0svkbukwXJS2SXzhq5s7VkD9itmaFRQqri7/hl/YxKjO3sppkcvyyh1sSDP/jSD
 yEM9dQEbcRUMBQ2KjXYFEpeesM5cngK3V6H/sTLODnJyrAVAchvaRtdzfw/muOSZUiMnM4X1gzq
 YcnPDNa+XZLvJ0wOe4Lel3IwQEzeWBzFSiLTgPXzKpV2zMq8/NT5N+5yPAx3n+ks1lo500vGHeH
 mBBOIICvx1RFhxPXp80gPrCaOdw+XwBOPes1wNlZsDPIDpfyXy4S3E0qyWMNNnia5Uf1ZeAqxUg
 np
X-Received: by 2002:a05:600c:1f94:b0:477:73cc:82c2 with SMTP id
 5b1f17b1804b1-47904ad4af1mr236042525e9.9.1764611360195; 
 Mon, 01 Dec 2025 09:49:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLzaTSY3p7/HChAZNLDPDzBp6Y9giOwYiFv3Zk1dMq5D7hwNHwoQbom3q2B/AsdpPg/Zpa6Q==
X-Received: by 2002:a05:600c:1f94:b0:477:73cc:82c2 with SMTP id
 5b1f17b1804b1-47904ad4af1mr236042235e9.9.1764611359744; 
 Mon, 01 Dec 2025 09:49:19 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790b0c3a1dsm324072125e9.10.2025.12.01.09.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 09:49:19 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Yao Zi <ziyao@disroot.org>, E Shattow <e@freeshell.de>,
 Hal Feng <hal.feng@starfivetech.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] test: provide unit tests for the RISC-V private GCC
 library
Date: Mon,  1 Dec 2025 18:49:04 +0100
Message-ID: <20251201174904.652954-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201174904.652954-1-heinrich.schuchardt@canonical.com>
References: <20251201174904.652954-1-heinrich.schuchardt@canonical.com>
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

Add unit tests for the functions for counting leading and trailing zero
bits.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

