Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D325C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B148587575;
	Mon, 27 Nov 2023 14:00:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pRma1mKL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8D8887570; Mon, 27 Nov 2023 14:00:27 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3341E8757A
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50aaaf6e58fso6349246e87.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090022; x=1701694822; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fXZ+TfT7jRJ5McRBW6s5c0kyNJ2VbY4wiD3KAsqo7M=;
 b=pRma1mKLwCsB7egWsXmIr1eZvVjF62KzCgmj403X/g8Jaiqk59AYsApSi8Ua2zMaF5
 mv0JmyiJVqhGqKjA3gND4yz3lcXpfwEXhCNLvsKZYK6TN6j0s4GQ/LwrKKRYECH4WlwT
 u/5lmB0iVcNOhgcEnIPY0i7eji9nUOg9mWXsWYMKitza+V+fl8uMw+5fJfMwN8aanvHG
 PrwbJ+Jw2MULa2j6byKvEGTDpqml8N5eRUdZXN5++aoEmXpOyED80fzycV4nk4C89ZHV
 MjoQmdUOndoa7gX7hvjwpECsNgQWVM/enEoHM3zjvxgJh1uoQ4QvCKI+9fu/MbrAUmDr
 QFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090022; x=1701694822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9fXZ+TfT7jRJ5McRBW6s5c0kyNJ2VbY4wiD3KAsqo7M=;
 b=EyZf4spGtq3PxZBcjAg2PHRkJFxp2TgkZBjhpX1VVTMdnQWrXOTirLpHXiZ2rkg06g
 PQY9MhlDfVDZ5z9ExNfovbYNJD3j34wtP0bN+H3hEhF5I/YUDU5cxgj4gMxY2+JVRvXM
 mqsXPQyy8qI0FjFvgDJSLcFp0JVy8OxsWY8+mzTVm/vk6UpnXeYtDWUrKhgeywNT+D4t
 9YsgaiEHhi849+C29WcVjPshBuYORCw4JtI0UsYIYDLpvHamByZSsUOXhFcV8UFGCzMi
 i7Xm2y94shTxNfWvoDjCZAFg9DHsgupETg6/DiC7FBfqj/BUu1J3gpBQurcvfJOjkaHf
 J74Q==
X-Gm-Message-State: AOJu0Yx6fa2dwEd1aPKZf4k3qSNZJB6d2HcngSJtZp4PS205Zh7WBSrd
 9Dwk8XR7SScpnM6eL/TZ1y0z+M9g4N+sjOWn6tLEvw==
X-Google-Smtp-Source: AGHT+IFmtPWPbF2EMVA2+UqaRnLzQOaZCdIYDy5T3QNJycKoKgPAZd95UmiPOlAAXhJGv2ZIysU3iA==
X-Received: by 2002:ac2:5b04:0:b0:50a:aa72:f00d with SMTP id
 v4-20020ac25b04000000b0050aaa72f00dmr7512928lfn.29.1701090022323; 
 Mon, 27 Nov 2023 05:00:22 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:00:22 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 06/43] net/lwip: implement tftp cmd
Date: Mon, 27 Nov 2023 18:56:49 +0600
Message-Id: <20231127125726.3735-7-maxim.uvarov@linaro.org>
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
Replace tftp command with the LWIP variant while keeping the output and
error messages identical.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 include/net/lwip.h             |  13 ++++
 net/lwip/Makefile              |   1 +
 net/lwip/apps/tftp/Makefile    |   7 ++
 net/lwip/apps/tftp/lwip-tftp.c | 132 +++++++++++++++++++++++++++++++++
 4 files changed, 153 insertions(+)
 create mode 100644 net/lwip/apps/tftp/Makefile
 create mode 100644 net/lwip/apps/tftp/lwip-tftp.c

diff --git a/include/net/lwip.h b/include/net/lwip.h
index 9941845f8c..f025384c26 100644
--- a/include/net/lwip.h
+++ b/include/net/lwip.h
@@ -29,3 +29,16 @@ int ulwip_dns(char *name, char *varname);
  *         Other value < 0, if error
  **/
 int ulwip_dhcp(void);
+
+/**
+ * ulwip_tftp() - load file with tftp
+ *
+ * Load file with tftp to specific address
+ *
+ * @addr: Address to store downloaded file
+ * @filename: File name on remote tftp server to download
+ *
+ *
+ * Returns:  0 if success, !0 if error
+ */
+int ulwip_tftp(ulong addr, const char *filename);
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index a3a33b7f71..b348e5ca31 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -65,3 +65,4 @@ obj-$(CONFIG_NET) += port/sys-arch.o
 
 obj-y += apps/dhcp/lwip-dhcp.o
 obj-y += apps/dns/lwip-dns.o
+obj-y += apps/tftp/
diff --git a/net/lwip/apps/tftp/Makefile b/net/lwip/apps/tftp/Makefile
new file mode 100644
index 0000000000..c3ad3c6353
--- /dev/null
+++ b/net/lwip/apps/tftp/Makefile
@@ -0,0 +1,7 @@
+ccflags-y += -I$(srctree)/net/lwip/port/include
+ccflags-y += -I$(srctree)/net/lwip/lwip-external/src/include -I$(srctree)/net/lwip
+ccflags-y += -I$(srctree)/net/lwip/lwip-external/src/include/lwip/apps
+ccflags-y += -I$(srctree)/net/lwip/lwip-external/contrib/examples/tftp/
+
+obj-y += ../../lwip-external/src/apps/tftp/tftp.o
+obj-y += lwip-tftp.o
diff --git a/net/lwip/apps/tftp/lwip-tftp.c b/net/lwip/apps/tftp/lwip-tftp.c
new file mode 100644
index 0000000000..7b384cecf8
--- /dev/null
+++ b/net/lwip/apps/tftp/lwip-tftp.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
+ */
+
+#include <common.h>
+#include <command.h>
+#include <console.h>
+#include <bootstage.h>
+
+#include "tftp_client.h"
+#include "tftp_server.h"
+#include <tftp_example.h>
+
+#include <string.h>
+
+#include <net/ulwip.h>
+
+static ulong daddr;
+static ulong size;
+static unsigned int progress_print;
+#define PROGRESS_PRINT 700 /* about one # per Megabyte */
+
+static void *tftp_open(const char *fname, const char *mode, u8_t is_write)
+{
+	return NULL;
+}
+
+static void tftp_close(void *handle)
+{
+	log_info("\ndone\n");
+	log_info("Bytes transferred = %ld (0x%lx hex)\n", size, size);
+
+	bootstage_mark_name(BOOTSTAGE_KERNELREAD_STOP, "tftp_done");
+	if (env_set_hex("filesize", size)) {
+		log_err("filesize not updated\n");
+		ulwip_exit(-1);
+		return;
+	}
+	ulwip_exit(0);
+}
+
+static int tftp_read(void *handle, void *buf, int bytes)
+{
+	return 0;
+}
+
+static int tftp_write(void *handle, struct pbuf *p)
+{
+	struct pbuf *q;
+
+	for (q = p; q != NULL; q = q->next) {
+		memcpy((void *)daddr, q->payload, q->len);
+		daddr += q->len;
+		size += q->len;
+		if (!(progress_print++ % PROGRESS_PRINT))
+			log_info("#");
+	}
+
+	return 0;
+}
+
+static void tftp_error(void *handle, int err, const char *msg, int size)
+{
+	char message[100];
+
+	memset(message, 0, sizeof(message));
+	memcpy(message, msg, LWIP_MIN(sizeof(message) - 1, (size_t)size));
+
+	log_info("TFTP error: %d (%s)", err, message);
+}
+
+static const struct tftp_context tftp = {
+	tftp_open,
+	tftp_close,
+	tftp_read,
+	tftp_write,
+	tftp_error
+};
+
+int ulwip_tftp(ulong addr, char *fname)
+{
+	void *f = (void *)0x1; /* unused fake file handle*/
+	err_t err;
+	ip_addr_t srv;
+	int ret;
+	char *server_ip;
+
+	if (!fname || addr == 0)
+		return CMD_RET_FAILURE;
+
+	size = 0;
+	daddr = addr;
+	server_ip = env_get("serverip");
+	if (!server_ip) {
+		log_err("error: serverip variable has to be set\n");
+		return CMD_RET_FAILURE;
+	}
+
+	ret = ipaddr_aton(server_ip, &srv);
+	if (!ret) {
+		log_err("error: ipaddr_aton\n");
+		return CMD_RET_FAILURE;
+	}
+
+	log_info("TFTP from server %s; our IP address is %s\n",
+		 server_ip, env_get("ipaddr"));
+	log_info("Filename '%s'.\n", fname);
+	log_info("Load address: 0x%lx\n", daddr);
+	log_info("Loading:");
+
+	bootstage_mark_name(BOOTSTAGE_KERNELREAD_START, "tftp_start");
+
+	err = tftp_init_client(&tftp);
+	if (!(err == ERR_OK || err == ERR_USE))
+		log_err("tftp_init_client err: %d\n", err);
+
+	err = tftp_get(f, &srv, TFTP_PORT, fname, TFTP_MODE_OCTET);
+	/* might return different errors, like routing problems */
+	if (err != ERR_OK) {
+		log_err("tftp_get err=%d\n", err);
+		return CMD_RET_FAILURE;
+	}
+
+	if (env_set_hex("fileaddr", addr)) {
+		log_err("fileaddr not updated\n");
+		return CMD_RET_FAILURE;
+	}
+
+	return CMD_RET_SUCCESS;
+}
-- 
2.30.2

