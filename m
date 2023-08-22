Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1093EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 09:39:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7422864A2;
	Tue, 22 Aug 2023 11:38:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M03O/Aaf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AD18864B1; Tue, 22 Aug 2023 11:38:38 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 904BD864A2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2bb97f2c99cso67193881fa.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 02:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697114; x=1693301914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=beSHh4g9ra1GABo9J+FQ7EEjHXXv7vNirX9EgmEK+o8=;
 b=M03O/AafP4wCYaPnoGjrXT9KYzeXn0JcouTMeSUc+eG+qq4UkXnJoB0CSBdgT+s6/8
 T6TMDXQXSity6TBb9ZXvzPlrX5PjI4Rv+S1gUJvRY2BXwLk0PxX5VI0RbmJHChS+kahk
 cQmMVKyyzZ+PGi/6/GW8h9xBIVNpfa4+AWsSvH4I02JRArPgEtx7wFg0uSaJPz7OxIGV
 bIt3TwueMnIpN3cn+CbjtJ9piyUB6mzyuYlzSJ0a46bhZ6LvB+3UvsoghobAaWDWtGte
 zbQ+3t1jQo5Nzl6/dvbQ3koSVTDhQktxZCeJYXWndfpuvAHGF3hh2Z8mzYuCUHMvLEMP
 ICeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697114; x=1693301914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=beSHh4g9ra1GABo9J+FQ7EEjHXXv7vNirX9EgmEK+o8=;
 b=ABHWpMkUQD8qe8F6p8CIdo8OAbPhBZpX4ftaqlCEyQ83fe76j69nJm7OJE0KhWn83Q
 zUhA4N8+heOFnypTX2c3GMY20bH+OU6s4HTfqYeMdu+6b9Y6fF9xaZni8tajmmQcwmqC
 7ddp+2KmzaREhxrF3m2KW4ClAcHmVuwd6Win1Yv2Aeu2bnu5JuRmS+tcLuhuofI/786o
 yRwBG5iF1POmV3dewYKhPZ+N3yfwCfTnm9BXvTdQAYVA7jixrTo8y8OX7QmGXTgOsqde
 KGh8Q88ZKKcdasd8RH9r6VwMp4vRr/3ONU7E23B4RXPEVRmIk8x+0aPbUMrYZuXC3QFO
 xLMA==
X-Gm-Message-State: AOJu0Yz/Hw96SUdQNnfs8lcFaxLhViY2yay+ILgzunkRnq0yF7whK/kH
 UGjP0Igye1tG6O2VFjehJdPSXeTen+sr/6ENxVTKIQ==
X-Google-Smtp-Source: AGHT+IE8P5pq8/52Zl/SqRj9VCC9+G0ywCLGrZ09+Bm+1OJTABYV8EpqDybbPYLTObU83S2JTLsXmw==
X-Received: by 2002:a2e:330f:0:b0:2b8:4079:fd9d with SMTP id
 d15-20020a2e330f000000b002b84079fd9dmr6601300ljc.29.1692697114765; 
 Tue, 22 Aug 2023 02:38:34 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a2e8089000000b002b724063010sm2649637ljg.47.2023.08.22.02.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 02:38:34 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv7 06/15] net/lwip: implement wget cmd
Date: Tue, 22 Aug 2023 15:36:05 +0600
Message-Id: <20230822093614.4717-7-maxim.uvarov@linaro.org>
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
Replace wget command with the LWIP variant while keeping the output and
error messages identical.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 include/net/lwip.h             |  15 +++++
 net/lwip/Makefile              |   1 +
 net/lwip/apps/http/Makefile    |  13 ++++
 net/lwip/apps/http/lwip-wget.c | 111 +++++++++++++++++++++++++++++++++
 4 files changed, 140 insertions(+)
 create mode 100644 net/lwip/apps/http/Makefile
 create mode 100644 net/lwip/apps/http/lwip-wget.c

diff --git a/include/net/lwip.h b/include/net/lwip.h
index 14a65470ee..724f68b148 100644
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
+*/
+int ulwip_wget(ulong addr, char *url);
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
index 0337d82cf5..4c6df94807 100644
--- a/net/lwip/Makefile
+++ b/net/lwip/Makefile
@@ -68,3 +68,4 @@ obj-$(CONFIG_NET) += port/sys-arch.o
 obj-$(CONFIG_CMD_DHCP) += apps/dhcp/lwip-dhcp.o
 obj-$(CONFIG_CMD_DNS) += apps/dns/lwip-dns.o
 obj-$(CONFIG_CMD_TFTPBOOT) += apps/tftp/
+obj-$(CONFIG_CMD_WGET) += apps/http/
diff --git a/net/lwip/apps/http/Makefile b/net/lwip/apps/http/Makefile
new file mode 100644
index 0000000000..3e92b0ef1b
--- /dev/null
+++ b/net/lwip/apps/http/Makefile
@@ -0,0 +1,13 @@
+ccflags-y += -I$(srctree)/net/lwip/port/include
+ccflags-y += -I$(srctree)/net/lwip/lwip-external/src/include -I$(srctree)/net/lwip
+ccflags-y += -I$(obj)
+
+$(obj)/http_clinet.o: $(obj)/http_client.c
+.PHONY: $(obj)/http_client.c
+$(obj)/http_client.c:
+	cp $(srctree)/net/lwip/lwip-external/src/apps/http/http_client.c $(obj)/http_client.c
+	cp $(srctree)/net/lwip/lwip-external/src/include/lwip/apps/http_client.h $(obj)/http_client.h
+
+obj-$(CONFIG_CMD_WGET) += http_client.o
+obj-$(CONFIG_CMD_WGET) += lwip-wget.o
+
diff --git a/net/lwip/apps/http/lwip-wget.c b/net/lwip/apps/http/lwip-wget.c
new file mode 100644
index 0000000000..a9bb29e156
--- /dev/null
+++ b/net/lwip/apps/http/lwip-wget.c
@@ -0,0 +1,111 @@
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
+		env_set_ulong("filesize", rx_content_len);
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
+	if (!p) {
+		printf("err: no http://!\n");
+		return -1;
+	}
+
+	p += strlen("http://");
+
+	/* parse hostname */
+	pp = strchr(p, '/');
+	if (!pp) {
+		printf("wrong url\n");
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
+	if (err) {
+		log_err("error parse_url\n");
+		return -1;
+	}
+
+	log_info("downloading %s to addr 0x%lx\n", url, addr);
+	memset(&settings, 0, sizeof(settings));
+	settings.result_fn = httpc_result;
+	err = httpc_get_file_dns(server_name, port, url, &settings,
+				 httpc_recv, NULL,  &connection);
+	if (err != ERR_OK) {
+		log_err("httpc_init_connection failed\n");
+		return err;
+	}
+
+	env_set_hex("fileaddr", addr);
+	return 0;
+}
-- 
2.30.2

