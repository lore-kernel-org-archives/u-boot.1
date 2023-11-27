Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB36C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:02:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D1EB8759B;
	Mon, 27 Nov 2023 14:00:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x/IVGuUq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB09387578; Mon, 27 Nov 2023 14:00:30 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69E388757F
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:00:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-507975d34e8so5774535e87.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090027; x=1701694827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qPJJv7hLfTDO7x5IcfmhD4gQjttshRh+bEWycg4ObL8=;
 b=x/IVGuUqQL2m+o5c9GLzyEPlxXjoh/a9FHEO3rSM/DDK7sX0zjD24Si63edz5UmzLF
 lYHSRunu7CLQFnKqCuDOSopkmQDmCZu0mIetc78ww2DPgL1CfeZL+yAG3uc+J2fyAa86
 eGdyVsco0nhOlyXoSBKHzNXqVy5zBROBFhek6zyG4tzTfBIqKDHhqEE9DEX3dmAo0FsN
 /uIeNiu5jQ0Bx7xyHOzDCed1tQOUVhuyLvSrOMGyB0+eMqqbI1DHnHWvIsyhJgXPU6Ch
 lcjSNGVh0U41UvtORDKmTMiMY/mgGPpzpYJOKcQTZQjFClOIbxStx2yUu+PyRTyVk28K
 gbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090027; x=1701694827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qPJJv7hLfTDO7x5IcfmhD4gQjttshRh+bEWycg4ObL8=;
 b=fvb2Clk/PFpXQIkqoxvt463io11noybSU/WWD/Gm3RFEdJUAeVk4DU2vOYZdAGJcLu
 IrjLQHLTKJB9RzQkNsUfRUcbAl8BG0ZUlIsbG6aY5pictKJ8+YCngpEvTtGGIbtGiC9i
 fhiB71E3RnDtQ4h/tuOsb2c4c9u4jZSQPYEdm06OPzrf9dRvj2sumV2NQUq8TSJ7cckD
 6lwJhfYWWJSCfec7FdSsZngh1Nsfinjnda8dJbY5iXR5NisBDrgBKgNZ+yrPozK5Jsh+
 hzJ92EY9Uy6ba16mJpMxz8YZWEIZ5ToyLlUrarZb7nPYwQCQY/SgDp9bQfJhRS4N6woC
 4QfQ==
X-Gm-Message-State: AOJu0YwhkXZJu+eoSYXYxmgofnZUN6tdY7P1wgOSBK1EMbTI3KfDhVnq
 S83JCuyOOV9JMIpuyxiZtADqfImjo/mkG9JPZFRVYA==
X-Google-Smtp-Source: AGHT+IE6oZP5B0iK+V8GZEVl/BuMJrabfcapczhCr7c5fh3tV49h0uJF2Be8ZDf4bdK/DBMLpVCX3w==
X-Received: by 2002:a05:6512:b97:b0:502:ff3b:766f with SMTP id
 b23-20020a0565120b9700b00502ff3b766fmr10137862lfv.6.1701090027000; 
 Mon, 27 Nov 2023 05:00:27 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:00:26 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 08/43] net/lwip: implement ping cmd
Date: Mon, 27 Nov 2023 18:56:51 +0600
Message-Id: <20231127125726.3735-9-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 Makefile                       |  3 ++-
 include/net/lwip.h             | 15 +++++++++++++
 net/lwip/Makefile              |  1 +
 net/lwip/apps/ping/Makefile    | 12 +++++++++++
 net/lwip/apps/ping/lwip_ping.c | 39 ++++++++++++++++++++++++++++++++++
 net/lwip/apps/ping/lwip_ping.h | 15 +++++++++++++
 net/lwip/apps/ping/ping.h      | 28 ++++++++++++++++++++++++
 7 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 net/lwip/apps/ping/Makefile
 create mode 100644 net/lwip/apps/ping/lwip_ping.c
 create mode 100644 net/lwip/apps/ping/lwip_ping.h
 create mode 100644 net/lwip/apps/ping/ping.h

diff --git a/Makefile b/Makefile
index 132a60575a..769111bf09 100644
--- a/Makefile
+++ b/Makefile
@@ -2171,7 +2171,8 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       mkimage-out.spl.mkimage mkimage.spl.mkimage imx-boot.map \
 	       itb.fit.fit itb.fit.itb itb.map spl.map mkimage-out.rom.mkimage \
 	       mkimage.rom.mkimage mkimage-in-simple-bin* rom.map simple-bin* \
-	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb
+	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
+	       net/lwip/apps/ping/ping.c
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include/generated spl tpl vpl \
diff --git a/include/net/lwip.h b/include/net/lwip.h
index 04ffbec006..c9ea182d5d 100644
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
index 0000000000..cdbe8d3eef
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
+	log_err("%s: ping failed; host %s is not alive\n",
+		__func__, ipaddr_ntoa(&ip_target));
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
index 0000000000..dbb4e5f653
--- /dev/null
+++ b/net/lwip/apps/ping/ping.h
@@ -0,0 +1,28 @@
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
+		printf("host %s is alive\n", ipaddr_ntoa(addr)); \
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
+	} while (0);
+
+void ping_init(const ip_addr_t *ping_addr);
+void ping_stop(void);
-- 
2.30.2

