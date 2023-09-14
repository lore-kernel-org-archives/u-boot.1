Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06FBEEAA55
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:21:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADDC986AB5;
	Thu, 14 Sep 2023 18:20:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xOJTY1oy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DC8F869BC; Thu, 14 Sep 2023 18:20:55 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F36386AB5
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2bcbfb3705dso18084761fa.1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694708452; x=1695313252; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKZJ9HOZxIBTiLch9aEDpcZKIBMQWo/QAQDhGkXMw7E=;
 b=xOJTY1oyzb/z1gIN1S3U1+zEC67MGf0lrNFuopB++NZ4qVADYErZW1gpO5wxAKyYMh
 he9FK+y1gp3FCmJwUND8l/O7P4uIbFmtNWQv+FFzXGbAZ+iMhtKSQd0ugI5QZV3jv0pu
 lLr7N5wgXp1oqRdXVMRa+7sc8ovpqrsd93CsgqQJftZPgOcGf7Hs8yAl9bgDQNs7xpPP
 8xCCEwCkzc/uZDg9kKqKExEAEXYhAOgtEW4LE61sNEFU5otIo2Q+Hmqd0qZKVujAg2JI
 xZVSOJYkYGm7mbYcMbkdxr9Rx7aVTz6ixtiitd7NyrzhPKHnCg0V5VpzaeDJUsK8mhQM
 UlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694708452; x=1695313252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PKZJ9HOZxIBTiLch9aEDpcZKIBMQWo/QAQDhGkXMw7E=;
 b=C1IghAvaJNqdDIhxczudlSrTsmuLnl3hpDbD63nLyEFxq7meLXWRNUY45hT2EgEBVq
 dyhogL2v0tAVPdW23W1uYnr8gORXjxChVKZx4yLcvKilCqbLZwIknmz8mOmn/vMX5P6H
 za5y5Bo9+Ud4EFJ/mx0J5qwFnjLzqtuW4XNmUHb5/beMxIvCCyuOprgrutdc/rCszqRF
 bgGO6VrqnE8kUypO6CzcRpOprkUDN267ECf5p+uhb+1gv5w+3tEMEBsmdDMMfMyoi5CV
 LpjE6sDSND5PrVLz0it7hwBYlvnilbRDzFAEzVMVmHGBy6qg8ae6QpA1LI8i7ZF0of15
 8LaA==
X-Gm-Message-State: AOJu0Yzl5+sADTCtJbzKVNCJ91twA4VKd8SxR9GK/21cFZ7dgwgliLJK
 OquR9yN7n0w+WrzhxdRMoH1/h3hrq5NJS4Mw/3rz0A==
X-Google-Smtp-Source: AGHT+IHN4PSdI1QID1VTWSFjlSsjk7oS1CUSZdwn50RE/w4VYEcq9sMOdlmU0mb6yOWRJ0t1wlINOQ==
X-Received: by 2002:a2e:8ed3:0:b0:2b9:53bd:47a7 with SMTP id
 e19-20020a2e8ed3000000b002b953bd47a7mr5293350ljl.30.1694708451941; 
 Thu, 14 Sep 2023 09:20:51 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a2e8e8f000000b002ba7ae1f52asm346919ljk.0.2023.09.14.09.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:20:51 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv9 07/15] net/lwip: implement wget cmd
Date: Thu, 14 Sep 2023 22:18:20 +0600
Message-Id: <20230914161828.3662-8-maxim.uvarov@linaro.org>
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
Replace wget command with the LWIP variant while keeping the output and
error messages identical.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 include/net/lwip.h             |  14 +++++
 net/lwip/Makefile              |   1 +
 net/lwip/apps/http/Makefile    |   6 ++
 net/lwip/apps/http/lwip-wget.c | 105 +++++++++++++++++++++++++++++++++
 4 files changed, 126 insertions(+)
 create mode 100644 net/lwip/apps/http/Makefile
 create mode 100644 net/lwip/apps/http/lwip-wget.c

diff --git a/include/net/lwip.h b/include/net/lwip.h
index 11389bb038..85f08343fd 100644
--- a/include/net/lwip.h
+++ b/include/net/lwip.h
@@ -42,3 +42,17 @@ int ulwip_dhcp(void);
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
index 0000000000..d82d450c0f
--- /dev/null
+++ b/net/lwip/apps/http/lwip-wget.c
@@ -0,0 +1,105 @@
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
+/* http://hostname/url */
+static int parse_url(char *url, char *host, u16 *port)
+{
+	char *p, *pp;
+
+	p = strstr(url, "http://");
+	if (!p)
+		return -ENOENT;
+
+	p += strlen("http://");
+
+	/* parse hostname */
+	pp = strchr(p, '/');
+	if (!pp)
+		return -ENOENT;
+
+	if (p  + SERVER_NAME_SIZE >= pp)
+		return -ENOENT;
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

