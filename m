Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACB7EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 09:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1612D864B7;
	Tue, 22 Aug 2023 11:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z297Z67h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78C7D864B4; Tue, 22 Aug 2023 11:38:40 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C25B1864AF
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:38:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2b9b5ee9c5aso66999451fa.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 02:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697117; x=1693301917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SvRHG8MlVJT0eTt3Mg5xTPVVHznraxxGDudki/j9xKA=;
 b=Z297Z67hhzHQEoujgz1WgWCXoxXhBDGbq8euRuYwkzjK0iaDTjCx+/ng9taS2fHh22
 MEKE8T5C9iAF9nYbIHie+f2Fqpp7b/FYG2ApUUL2jRb0Ziqu1U8SCvRX3+ojaoaKeJb7
 VWk+pHSXbIm7CU/lhqeUe6wizNw98cE5wBysh2fr3eQJ4YBmJOPqc6qJat5SSc65BJqt
 nykYtw2Z6BNT+5E9NL/lmkl4628Vyir4lm0q2hYwrth8F784gplJOLuJW5bM0afUiqyE
 HYpiHCQJLC0jNeZKJPE195X0lvt0lydWBZWAcSb93iHyIBQKcU+/2foB9th7o2P0ijoI
 s9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697117; x=1693301917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SvRHG8MlVJT0eTt3Mg5xTPVVHznraxxGDudki/j9xKA=;
 b=P1IqFKxOM1AJEHVJU4J3mBteHC1vkhVm2T4DXvGQTPCuskk40uMlLZ2o/+sln46jNu
 hNY2zgqFXNpuHC1ShMT0qJyYmY+9QQulISgc3JA93Yv6Tc++NT04Gbxu5o3jUkQ4TQO4
 FFwIo8/BVSYsiVBZuqxoqP7kyO5RhFHQpbjiPAG63zpNDofhetznWiW4iJ8FJZ3JY9rD
 rLSWyhhynbqaKJQdLi4M00d55lqHb7YXLN43QhkKJteFo5ihNgVaPzdH1TuIHOnNskHB
 eOlkE97Lh3UYWDHWiJRXBgNTU9yCGfWsXxQVdxAuQ8eT9Jr01MnG7KC1sWBjMOg0LHsQ
 tciA==
X-Gm-Message-State: AOJu0YyhOU94JmhHd+YF+F8rRPwr0Y2LFwszXPKAKTM3Uc0E7draKWHa
 qe9PjYgMRSsTmZFkW2ZSJdknBF9L9Y6YUHsUJuM8YA==
X-Google-Smtp-Source: AGHT+IEyj8uxJhzXo3jm39RNgLeCAvdVSOrcgewuZ3152yw5XifIYuAaNLW+kp5li/xYDg0wD5yRTQ==
X-Received: by 2002:a2e:a0cf:0:b0:2b6:ebc6:1e86 with SMTP id
 f15-20020a2ea0cf000000b002b6ebc61e86mr6970642ljm.47.1692697116889; 
 Tue, 22 Aug 2023 02:38:36 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a2e8089000000b002b724063010sm2649637ljg.47.2023.08.22.02.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 02:38:36 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv7 07/15] net/lwip: implement ping cmd
Date: Tue, 22 Aug 2023 15:36:06 +0600
Message-Id: <20230822093614.4717-8-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230822093614.4717-1-maxim.uvarov@linaro.org>
References: <20230822093614.4717-1-maxim.uvarov@linaro.org>
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

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 include/net/lwip.h             | 15 ++++++++++++++
 net/lwip/Makefile              |  1 +
 net/lwip/apps/ping/Makefile    | 11 ++++++++++
 net/lwip/apps/ping/lwip_ping.c | 37 ++++++++++++++++++++++++++++++++++
 net/lwip/apps/ping/lwip_ping.h | 15 ++++++++++++++
 net/lwip/apps/ping/ping.h      | 19 +++++++++++++++++
 6 files changed, 98 insertions(+)
 create mode 100644 net/lwip/apps/ping/Makefile
 create mode 100644 net/lwip/apps/ping/lwip_ping.c
 create mode 100644 net/lwip/apps/ping/lwip_ping.h
 create mode 100644 net/lwip/apps/ping/ping.h

diff --git a/include/net/lwip.h b/include/net/lwip.h
index 724f68b148..aa82d71715 100644
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
index 4c6df94807..8b3e843426 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -67,5 +67,6 @@ obj-$(CONFIG_NET) += port/sys-arch.o
 
 obj-$(CONFIG_CMD_DHCP) += apps/dhcp/lwip-dhcp.o
 obj-$(CONFIG_CMD_DNS) += apps/dns/lwip-dns.o
+obj-$(CONFIG_CMD_PING) += apps/ping/
 obj-$(CONFIG_CMD_TFTPBOOT) += apps/tftp/
 obj-$(CONFIG_CMD_WGET) += apps/http/
diff --git a/net/lwip/apps/ping/Makefile b/net/lwip/apps/ping/Makefile
new file mode 100644
index 0000000000..dc63feb7b5
--- /dev/null
+++ b/net/lwip/apps/ping/Makefile
@@ -0,0 +1,11 @@
+ccflags-y += -I$(srctree)/net/lwip/port/include
+ccflags-y += -I$(srctree)/net/lwip/lwip-external/src/include -I$(srctree)/net/lwip
+ccflags-y += -I$(obj)
+
+.PHONY: $(obj)/ping.c
+$(obj)/ping.o: $(obj)/ping.c
+$(obj)/ping.c:
+	cp $(srctree)/net/lwip/lwip-external/contrib/apps/ping/ping.c $(obj)/ping.c
+
+obj-$(CONFIG_CMD_PING) += ping.o
+obj-$(CONFIG_CMD_PING) += lwip_ping.o
diff --git a/net/lwip/apps/ping/lwip_ping.c b/net/lwip/apps/ping/lwip_ping.c
new file mode 100644
index 0000000000..a2fe58f5e9
--- /dev/null
+++ b/net/lwip/apps/ping/lwip_ping.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
+ */
+
+#include "lwip/opt.h"
+#include "lwip/ip_addr.h"
+#include "ping.h"
+#include "lwip_ping.h"
+
+static ip_addr_t ip_target;
+
+static int ulwip_ping_tmo(void)
+{
+
+	log_err("ping failed; host %s is not alive\n", ipaddr_ntoa(&ip_target));
+	return 1;
+}
+
+int ulwip_ping(char *ping_addr)
+{
+	int err;
+
+	err = ipaddr_aton(ping_addr, &ip_target);
+	if (!err) {
+		log_err("Invalid ip address\n");
+		return -1;
+	}
+
+	ulwip_set_tmo(ulwip_ping_tmo);
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

