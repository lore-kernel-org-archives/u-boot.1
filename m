Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A1DE7D270
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 09:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08C0A86DDF;
	Tue, 26 Sep 2023 11:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tGoFxcYJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4A5B86DD6; Tue, 26 Sep 2023 11:44:04 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DB2D86AF7
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c15463ddd4so76407751fa.3
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 02:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695721441; x=1696326241; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pH9eugOd8aFs3gNXR1JStyjAyyg8COenbqgCMOQgxEo=;
 b=tGoFxcYJsfMH3ZGBsYqsh0d0TjpBD8fE359eoDOY7ueFFo/iqLb/SOU5XKmnQmRIlC
 D7duHa/bWA+kYZ5akVPA7NL00JwIA0CuVexqPSwUxyXkHHQ8EYz9Y/SOVPyeSb+w3axZ
 4tV6J7ZQnwMZ98pZEJB7fV6tVxyHiqqMEqnSrLvwyPqPNmgmGPGHCAkiV9OYAAtoWpbq
 E+ug+MYUbu+naAbwrAdmUmLYGUrRwyu6fyE+/NDCfVXpAtzfZKTOPsDCzLU8xWi48Vpe
 q5s7WiWEpXBd7dnoezF4IqxiLYtjTPrxZzfT7JSDvquuUIo2fOJH/gDfqVG3EFcJjVAK
 2COA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695721441; x=1696326241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pH9eugOd8aFs3gNXR1JStyjAyyg8COenbqgCMOQgxEo=;
 b=MQybvS3BRY4uwtLZ+TauWYP/mmfD5Lj+Nd73H/Q81pTY4RWOvtuBgjUq0X28m6at22
 IrnLu7NmzV07nSL+ny3KFbWRLxXwZ14qaKPASMBpt6QsFvu8pXaITE6H0nOasrhab5nt
 IyDZU3pmwtHAlnqjVmK/wr50Ci3RzZjjf60eh/OdnzF7lmAxhGHkDRD8adU6mxq7hUSU
 KHntuTiNoQkV4yM9vkcA/Xb14qb2SYjy7jkWD7uBEtSNkpGmejFXnFVMutGNciYMQ4is
 fGDoOMaUzZtB94oJa8luHx03JlBTmc5jKxfgP+jK+3kEYt8BmEO9HFyeKvCG0Llbt1bc
 03Mg==
X-Gm-Message-State: AOJu0YzbkPleAx3ISDQcWmZ/fuJCSY98KKy7RGh5PqwyzA8LstV5F2rh
 7zWT87Pp2v+hsAXo5FXVD7QoCfp5cK6YnanOL3Bu8w==
X-Google-Smtp-Source: AGHT+IGG0Cv4c6dv1PO58HwigqpjJpRVnjvCfvDIWVxhkaJcfXWmvNSTPI7EvzaKsD6C0ssg2JCPzQ==
X-Received: by 2002:a05:6512:3ca2:b0:503:985:92c9 with SMTP id
 h34-20020a0565123ca200b00503098592c9mr9644492lfv.22.1695721441541; 
 Tue, 26 Sep 2023 02:44:01 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 x6-20020ac25dc6000000b004fe09e6d1e7sm2131131lfq.110.2023.09.26.02.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 02:44:01 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv10 09/15] net/lwip: implement ping cmd
Date: Tue, 26 Sep 2023 15:41:18 +0600
Message-Id: <20230926094124.7024-10-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230926094124.7024-1-maxim.uvarov@linaro.org>
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
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

There is pending lwip patch:
	https://lists.nongnu.org/archive/html/lwip-devel/2023-09/msg00004.html
	https://savannah.nongnu.org/bugs/?64697
Once applied, more clean way can be used, to unset pending timers and exit
from the ping application:
	net/lwip/apps/ping/ping.h:
 #define PING_RESULT(cond) { \
..
-               raw_remove(pcb); \
+               ping_destroy(); \

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 include/net/lwip.h             | 15 +++++++++++++
 net/lwip/Makefile              |  1 +
 net/lwip/apps/ping/Makefile    | 12 +++++++++++
 net/lwip/apps/ping/lwip_ping.c | 39 ++++++++++++++++++++++++++++++++++
 net/lwip/apps/ping/lwip_ping.h | 15 +++++++++++++
 net/lwip/apps/ping/ping.h      | 27 +++++++++++++++++++++++
 6 files changed, 109 insertions(+)
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
index 0000000000..ba02e7ed47
--- /dev/null
+++ b/net/lwip/apps/ping/lwip_ping.c
@@ -0,0 +1,39 @@
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
+#define PING_WAIT_MS 5000
+
+static ip_addr_t ip_target;
+
+void ping_tmo(void *arg)
+{
+	log_err("ping_tmo: ping failed; host %s is not alive\n",
+		ipaddr_ntoa(&ip_target));
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
+	sys_timeout(PING_WAIT_MS, ping_tmo, NULL);
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
index 0000000000..5dd631f2f7
--- /dev/null
+++ b/net/lwip/apps/ping/ping.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <net/ulwip.h>
+#include "lwip/ip_addr.h"
+
+void ping_tmo(void *arg);
+
+#define LWIP_DEBUG 1 /* ping_time is under ifdef*/
+#define PING_RESULT(cond) { \
+	if (cond == 1) { \
+		printf("host %s a alive\n", ipaddr_ntoa(addr)); \
+		printf(" %"U32_F" ms\n", (sys_now() - ping_time)); \
+		raw_remove(pcb); \
+		sys_untimeout(ping_tmo, NULL); \
+		sys_check_timeouts(); \
+		ulwip_exit(0); \
+	} else { \
+		printf("ping failed; host %s in not alive\n",\
+		       ipaddr_ntoa(addr)); \
+		raw_remove(pcb); \
+		sys_untimeout(ping_tmo, NULL); \
+		sys_check_timeouts(); \
+		ulwip_exit(-1); \
+	} \
+     } while (0);
+
+void ping_init(const ip_addr_t *ping_addr);
-- 
2.30.2

