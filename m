Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B6AEEAA53
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CC3286AE9;
	Thu, 14 Sep 2023 18:20:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L1dFDGKq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F414886E6B; Thu, 14 Sep 2023 18:20:56 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC75086D45
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2bfbd7d49e7so18458251fa.1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694708454; x=1695313254; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ej/bqt+mfyHFFKJj2NMu41mYOCWSZiMsqtww6RhsVjY=;
 b=L1dFDGKqXvvQs2ObFtoJaLAjRY/ezg9h1vwo5JXYF/z05JL8MOtZ4J5p7UYiLZQvPl
 fhkULb9+iWFnOI/JITgtXgPBX7seW1Yw19OXMYIM/1I1XIHG+UQUdxDZMSbb1d8GNWnV
 zm7O74PhRdRjV/8KVx/4FJ3m1t7pKgq8Gw7YzbITBnWy7GlRAFLbHI+FqwGGZmXJdNO+
 mamtc1Q6vlstLJ0fLOMnwGX3bqCCOZScWUbMUHZGx3SbRiIyQI6uwgWn3w+08ZMLkPZK
 5tvf9AOxHSa6SsjFa0qJyOqdL2ja9WC9LhNczik5pd4MRuUl8cKL2gNc2uXUkZ0x4hHm
 CIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694708454; x=1695313254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ej/bqt+mfyHFFKJj2NMu41mYOCWSZiMsqtww6RhsVjY=;
 b=ufjkT/seEzT9V5rDk7h1m3yaIu1vD3uIl/rgz+/FTf2xoJ9IY0hSdtd4dKl7kbmMHo
 m9DI0swoRMyfEgoZC/YGKY8YGkGm2/9Zlb7jGYt962h+rJO5O4Keo8Up81wsct08Xe9s
 2jETOETTpoxJtBPw/vmNgq2MPRFSGxxaMP3pzm8EZ1Mnxg/SuQiQ+8ed539d+UQ7TAev
 ZXjnYoiYtkAfEsOBBGRyorFI8CEFj52OztTGfOuPQpkT+BdY4eeGOtLMJEfTF2f8MlWA
 m/8FtWovi8dN0yBrybwD4VRAGDgPpLuouW2LJL1SqqHHAkiJM1lUESpOoEOp4pzuNWgt
 ia3A==
X-Gm-Message-State: AOJu0Ywe725GY9FK8h9lcdXkeV+2YCeeutKt6GpOScQoQ31Oagi5yKIB
 xY84engcOjc+HvOc0P2X5sxGE87MtO3S6fske36/ow==
X-Google-Smtp-Source: AGHT+IEKQZEWvdXbUqLInFqUF9XzvhQzWpy6opAqZxBV5CQh/+zVGgrvpY0ChfYSw/RA6vwMe2yOCw==
X-Received: by 2002:a2e:9f4e:0:b0:2b9:e831:f16a with SMTP id
 v14-20020a2e9f4e000000b002b9e831f16amr6140183ljk.26.1694708454104; 
 Thu, 14 Sep 2023 09:20:54 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a2e8e8f000000b002ba7ae1f52asm346919ljk.0.2023.09.14.09.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:20:53 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv9 08/15] net/lwip: implement ping cmd
Date: Thu, 14 Sep 2023 22:18:21 +0600
Message-Id: <20230914161828.3662-9-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230914161828.3662-1-maxim.uvarov@linaro.org>
References: <20230914161828.3662-1-maxim.uvarov@linaro.org>
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

U-Boot recently got support for an alternative network stack using LWIP.
Replace ping command with the LWIP variant while keeping the output and
error messages identical. ping uses lwIP contrib/apps/ping/ping.c code.
Custom timeout is used to get an error message on not modified example.
lwIP timeouts are not yet implemented in U-Boot (#define LWIP_TIMERS 1)
so that for now ping can not rechange itself for continuous pings and
stops after the first request (the same behavior as the original ping.)

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 include/net/lwip.h             | 15 ++++++++++++++
 net/lwip/Makefile              |  1 +
 net/lwip/apps/ping/Makefile    | 12 +++++++++++
 net/lwip/apps/ping/lwip_ping.c | 38 ++++++++++++++++++++++++++++++++++
 net/lwip/apps/ping/lwip_ping.h | 15 ++++++++++++++
 net/lwip/apps/ping/ping.h      | 19 +++++++++++++++++
 6 files changed, 100 insertions(+)
 create mode 100644 net/lwip/apps/ping/Makefile
 create mode 100644 net/lwip/apps/ping/lwip_ping.c
 create mode 100644 net/lwip/apps/ping/lwip_ping.h
 create mode 100644 net/lwip/apps/ping/ping.h

diff --git a/include/net/lwip.h b/include/net/lwip.h
index 85f08343fd..1e92f9871c 100644
--- a/include/net/lwip.h
+++ b/include/net/lwip.h
@@ -2,6 +2,8 @@
 
 int do_lwip_dns(struct cmd_tbl *cmdtp, int flag, int argc,
 		char *const argv[]);
+int do_lwip_ping(struct cmd_tbl *cmdtp, int flag, int argc,
+		 char *const argv[]);
 
 /**
  * ulwip_dns() - creates the DNS request to resolve a domain host name
@@ -56,3 +58,16 @@ int ulwip_tftp(ulong addr, const char *filename);
  * Returns: 0 for success, !0 if error
  */
 int ulwip_wget(ulong addr, char *url);
+
+/**
+ * ulwip_ping - create the ping request
+ *
+ * This function creates the ping for  address provided in parameters.
+ * After this function you need to invoke the polling
+ * loop to process network communication.
+ *
+ *
+ * @ping_addr: IP address to ping
+ * Returns: 0 for success, !0 if error
+*/
+int ulwip_ping(char *ping_addr);
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index 61042862e1..5839d125c2 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -67,3 +67,4 @@ obj-y += apps/dhcp/lwip-dhcp.o
 obj-y += apps/dns/lwip-dns.o
 obj-y += apps/tftp/
 obj-y += apps/http/
+obj-y += apps/ping/
diff --git a/net/lwip/apps/ping/Makefile b/net/lwip/apps/ping/Makefile
new file mode 100644
index 0000000000..e567c0dc3e
--- /dev/null
+++ b/net/lwip/apps/ping/Makefile
@@ -0,0 +1,12 @@
+ccflags-y += -I$(srctree)/net/lwip/port/include
+ccflags-y += -I$(srctree)/net/lwip/lwip-external/src/include -I$(srctree)/net/lwip
+ccflags-y += -I$(obj)
+
+# ping.c includes "ping.h", copy it to local directory, to override ping.h
+.PHONY: $(obj)/ping.c
+$(obj)/ping.o: $(obj)/ping.c
+$(obj)/ping.c:
+	cp $(srctree)/net/lwip/lwip-external/contrib/apps/ping/ping.c $(obj)/ping.c
+
+obj-y += ping.o
+obj-y += lwip_ping.o
diff --git a/net/lwip/apps/ping/lwip_ping.c b/net/lwip/apps/ping/lwip_ping.c
new file mode 100644
index 0000000000..8e74b0a05b
--- /dev/null
+++ b/net/lwip/apps/ping/lwip_ping.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
+ */
+
+#include "lwip/opt.h"
+#include "lwip/ip_addr.h"
+#include "lwip/timeouts.h"
+#include <linux/errno.h>
+#include "ping.h"
+#include "lwip_ping.h"
+
+#define PING_WAIT_MS 1000
+
+static ip_addr_t ip_target;
+
+static void ping_tmo(void *arg)
+{
+	log_err("ping failed; host %s is not alive\n", (char *)arg);
+	ulwip_exit(1);
+}
+
+int ulwip_ping(char *ping_addr)
+{
+	int err;
+
+	err = ipaddr_aton(ping_addr, &ip_target);
+	if (!err)
+		return -ENOENT;
+
+	sys_timeout(PING_WAIT_MS, ping_tmo, ping_addr);
+
+	ping_init(&ip_target);
+	ping_send_now();
+
+	return 0;
+}
diff --git a/net/lwip/apps/ping/lwip_ping.h b/net/lwip/apps/ping/lwip_ping.h
new file mode 100644
index 0000000000..0374f07d9e
--- /dev/null
+++ b/net/lwip/apps/ping/lwip_ping.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+/*
+ * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
+ */
+
+#ifndef LWIP_PING_H
+#define LWIP_PING_H
+
+#include <lwip/ip_addr.h>
+
+void ping_raw_init(void);
+void ping_send_now(void);
+
+#endif /* LWIP_PING_H */
diff --git a/net/lwip/apps/ping/ping.h b/net/lwip/apps/ping/ping.h
new file mode 100644
index 0000000000..006a18c658
--- /dev/null
+++ b/net/lwip/apps/ping/ping.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <net/ulwip.h>
+#include "lwip/ip_addr.h"
+
+#define LWIP_DEBUG 1 /* ping_time is under ifdef*/
+#define PING_RESULT(cond) { \
+	if (cond == 1) { \
+		printf("host %s a alive\n", ipaddr_ntoa(addr)); \
+		printf(" %"U32_F" ms\n", (sys_now() - ping_time)); \
+		ulwip_exit(0); \
+	} else { \
+		printf("ping failed; host %s in not alive\n",\
+		       ipaddr_ntoa(addr)); \
+		ulwip_exit(-1); \
+	} \
+     } while (0);
+
+void ping_init(const ip_addr_t *ping_addr);
-- 
2.30.2

