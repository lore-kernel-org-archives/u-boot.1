Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C6DEE7FF3
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 13:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE50386A91;
	Fri,  8 Sep 2023 15:55:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nufeNNPa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79EC986A88; Fri,  8 Sep 2023 15:55:48 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1D1C86A50
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 15:55:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2b974031aeaso37230441fa.0
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 06:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694181345; x=1694786145; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HfQkS+Ld/qDASFnGXUOeUGjIwT7to1GV91ev5AX2Umc=;
 b=nufeNNPazYu5yZEO7c8A4/9oZKGVY+8f0ATjd8AlodwiXRA02npWlVvyCyXSpyR89n
 vWENOOWdJK3AjTrpqtkUbewlglXTOiiNXgo6mUsZRByeSRHKdSJV4PayeGl4nEOBMXXO
 EulziDGyZd/X2Slnzy1sIOVNr5HW22h1rSuCN0qEfD0a+nbWSJcOTOo81frkTg3kTO1X
 OLSMlhYvZpW6s2XzrdPy6y/3PssFr8U3jO/Po5E5dTcx/71HzOISMzdKnb4g7X1yDoug
 rfZmKooMKTYaT4p9iBeF6P8k/z5TrdFvawnDwfKmxrmQHyvfvpZ+hHELcYWKgYITfuMS
 e+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694181345; x=1694786145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HfQkS+Ld/qDASFnGXUOeUGjIwT7to1GV91ev5AX2Umc=;
 b=cb1rrbFX5/SFGQXcBAxP78GqBl0/gNdFLH34EYSdyE0vfCH9E58uVt0683MTM3Wh4f
 W/Op5MeT9lxlusgobq5WjjQvJj3Bu9aZWNdSaVvVSP4DrBKsqokzF3NFh4+pmeyQ0uXK
 YUpJ8TfaqsFz3Wc3/txEfxycIdvDZpYoRvt2qCjlfRUY1qHiHOzedT3a1KsNjrVzLQ4I
 Wp/yAMILCCHi/FJ7hVrPmzy2eA3/oK2Y+3SAbejFT5OiwJxg07oZTQEudUGgYgEi1BDA
 i2OQEhtjD+KoBlEtO2keQZN86GP9rzJKFWleI0arbufp+ByjBDqPmd7v0sYCOQXCzfI7
 LhCw==
X-Gm-Message-State: AOJu0YyB8nXMK/kXhGnfuL0SxQos6r79ooLlBUpuadS/rAZIOl/pZIJd
 UxCKiTvPGBbMK2OtCYqbW1LpXp36Gtr3mbJOII9o9Q==
X-Google-Smtp-Source: AGHT+IFms76wWRcVY2TyZzSdDjov4UOUZjG4Szo325G3S0VWYSnuHJ+dGueFHkvGVd2N1HAqwfcTbw==
X-Received: by 2002:a2e:9012:0:b0:2bc:db5a:9540 with SMTP id
 h18-20020a2e9012000000b002bcdb5a9540mr1954900ljg.42.1694181344944; 
 Fri, 08 Sep 2023 06:55:44 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a2e9f0e000000b002bcbae4c21fsm306907ljk.50.2023.09.08.06.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 06:55:44 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv8 06/15] net/lwip: implement wget cmd
Date: Fri,  8 Sep 2023 19:53:11 +0600
Message-Id: <20230908135320.7066-7-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230908135320.7066-1-maxim.uvarov@linaro.org>
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
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
Replace wget command with the LWIP variant while keeping the output and
error messages identical.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 include/net/lwip.h             |  15 +++++
 net/lwip/Makefile              |   1 +
 net/lwip/apps/http/Makefile    |   6 ++
 net/lwip/apps/http/lwip-wget.c | 106 +++++++++++++++++++++++++++++++++
 4 files changed, 128 insertions(+)
 create mode 100644 net/lwip/apps/http/Makefile
 create mode 100644 net/lwip/apps/http/lwip-wget.c

diff --git a/include/net/lwip.h b/include/net/lwip.h
index c9e2982a78..85f08343fd 100644
--- a/include/net/lwip.h
+++ b/include/net/lwip.h
@@ -28,6 +28,7 @@ int ulwip_dns(char *name, char *varname);
  * Returns: 0 if success
  *         Other value < 0, if error
 */
+int ulwip_dhcp(void);
 
 /**
  * ulwip_tftp() - load file with tftp
@@ -41,3 +42,17 @@ int ulwip_dns(char *name, char *varname);
  * Returns:  0 if success, !0 if error
  */
 int ulwip_tftp(ulong addr, const char *filename);
+
+/**
+ * ulwip_wget() - creates the HTTP request to download file
+ *
+ * This function creates the HTTP request to download file from url to the address
+ * specified in parameters. After this function you need to invoke the polling
+ * loop to process network communication.
+ *
+ *
+ * @addr:  start address to download result
+ * @url:   url in format http://host/url
+ * Returns: 0 for success, !0 if error
+ */
+int ulwip_wget(ulong addr, char *url);
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index b348e5ca31..61042862e1 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -66,3 +66,4 @@ obj-$(CONFIG_NET) += port/sys-arch.o
 obj-y += apps/dhcp/lwip-dhcp.o
 obj-y += apps/dns/lwip-dns.o
 obj-y += apps/tftp/
+obj-y += apps/http/
diff --git a/net/lwip/apps/http/Makefile b/net/lwip/apps/http/Makefile
new file mode 100644
index 0000000000..ac0b3ede0d
--- /dev/null
+++ b/net/lwip/apps/http/Makefile
@@ -0,0 +1,6 @@
+ccflags-y += -I$(srctree)/net/lwip/port/include
+ccflags-y += -I$(srctree)/net/lwip/lwip-external/src/include -I$(srctree)/net/lwip
+ccflags-y += -I$(srctree)/net/lwip/lwip-external/src/include/lwip/apps
+
+obj-$(CONFIG_CMD_WGET) += ../../lwip-external/src/apps/http/http_client.o
+obj-$(CONFIG_CMD_WGET) += lwip-wget.o
diff --git a/net/lwip/apps/http/lwip-wget.c b/net/lwip/apps/http/lwip-wget.c
new file mode 100644
index 0000000000..5c432056b1
--- /dev/null
+++ b/net/lwip/apps/http/lwip-wget.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
+ */
+
+#include <common.h>
+#include <command.h>
+#include <console.h>
+#include <vsprintf.h>
+
+#include "http_client.h"
+#include <net/ulwip.h>
+
+static ulong daddr;
+static httpc_connection_t settings;
+
+#define SERVER_NAME_SIZE 200
+#define HTTP_PORT_DEFAULT 80
+
+static err_t httpc_recv(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
+			err_t unused_err)
+{
+	struct pbuf *buf;
+
+	if (!pbuf)
+		return ERR_BUF;
+
+	for (buf = pbuf; buf != NULL; buf = buf->next) {
+		memcpy((void *)daddr, buf->payload, buf->len);
+		log_debug("downloaded chunk size %d, to addr 0x%lx\n",
+			  buf->len, daddr);
+		daddr += buf->len;
+	}
+
+	altcp_recved(pcb, pbuf->tot_len);
+	pbuf_free(pbuf);
+	return ERR_OK;
+}
+
+static void httpc_result(void *arg, httpc_result_t httpc_result, u32_t rx_content_len,
+			 u32_t srv_res, err_t err)
+{
+	if (httpc_result == HTTPC_RESULT_OK) {
+		log_info("\n%d bytes successfully downloaded.\n", rx_content_len);
+		env_set_hex("filesize", rx_content_len);
+		ulwip_exit(0);
+	} else {
+		log_err("\nhttp eroror: %d\n", httpc_result);
+		ulwip_exit(-1);
+	}
+}
+
+/* http://hostname:port/url */
+static int parse_url(char *url, char *host, u16 *port)
+{
+	char *p, *pp;
+
+	p = strstr(url, "http://");
+	if (!p)
+		return -1;
+
+	p += strlen("http://");
+
+	/* parse hostname */
+	pp = strchr(p, '/');
+	if (!pp) {
+		return -2;
+	}
+
+	if (pp - p >= SERVER_NAME_SIZE)
+		return -3;
+
+	memcpy(host, p, pp - p);
+	host[pp - p + 1] = '\0';
+	*port = HTTP_PORT_DEFAULT;
+
+	return 0;
+}
+
+int ulwip_wget(ulong addr, char *url)
+{
+	err_t err;
+	u16 port;
+	char server_name[SERVER_NAME_SIZE];
+	httpc_state_t *connection;
+
+	daddr = addr;
+
+	err = parse_url(url, server_name, &port);
+	if (err)
+		return -ENOENT;
+
+	log_info("downloading %s to addr 0x%lx\n", url, addr);
+	memset(&settings, 0, sizeof(settings));
+	settings.result_fn = httpc_result;
+	err = httpc_get_file_dns(server_name, port, url, &settings,
+				 httpc_recv, NULL,  &connection);
+	if (err != ERR_OK)
+		return -EPERM;
+
+	if (env_set_hex("fileaddr", addr))
+		return -EACCES;
+
+	return 0;
+}
-- 
2.30.2

