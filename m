Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85350C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:02:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DB7287594;
	Mon, 27 Nov 2023 14:00:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vhpwbF7Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19C9A87534; Mon, 27 Nov 2023 14:00:29 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A17CA87534
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:00:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-507962561adso6358750e87.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090025; x=1701694825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2qRP6YcRRm8tIBssE9iVz21S/OfyKc2+IZmXmtAWGrY=;
 b=vhpwbF7Qn+YvTZzYQMMZArGsFI8eRUBFwiINGyqI9k/A69Gdc/W8+nVF65/OjE+ahI
 Q6QZd2B2ke//H6lI/iZevGzm2gULwF28qkNfi0uvfJRM2a0cbD1ZzFsxEkUqR9puMvVu
 ccYbILnic7GTGLvKikFkE24/zfFxBeoWNUMsOcHKHrYVCSoImqmyUPieU2JLXieo9LEg
 yMrMIBQjC7SGgBFyShUm8fpYjOL1hVmTdkSTKEjuwTF+6WJvRMTBXfgReB2Hl7b+y9y+
 aploygZELTso1oe/n2L5ybbA5TQo2WiemUYp89+AOi7Mc1EQ6Sf+hnM97N5bv7xrVlOo
 aC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090025; x=1701694825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2qRP6YcRRm8tIBssE9iVz21S/OfyKc2+IZmXmtAWGrY=;
 b=q+SSjRfcsJuxB7PccPsl7dlYlqgwPNbTEqXLzjrPTM2UVsmCsaFCBJ1WnWHHVdCMkT
 iTWDET21A2btSBTXg1lAEzzPnG9/qxbZE7agKoUWvXUhGJWSgrk2D0wqBeLMJKOEeu6r
 4hhI/QDNXG/92qbw5hojBcKzygqwmH3/J9aG3xo9LE3IsYULdDJspN9Vx6UJHszC/4Wh
 QMWYs+YKdbMkzVpCYPPfGnjz44ps+3g50oylFf5x1NfSC/QV9jRTKoZhl3h5DNQx9jOG
 acn6HyrhMCO/is/Qz/HOnaaHaEewYq8nX/kds1Tw/yUVBXEd4IO77o/guWTsylnHnz0H
 LPUw==
X-Gm-Message-State: AOJu0Yz1RBJz0DzS2wUB8MKktuyQfrRe54oVd+v2UWXjVMJOSLokZ/0s
 Lvkolv1rkaaSGpho7xQwgxrUJqi43t7qzsT6pY6/pg==
X-Google-Smtp-Source: AGHT+IF/ZFhLF+ewIvYpSbYABL9zMz/q6llQSDY2KZKODl/dTYMAdVpDckv9pWX1oHErj9KJySEEgA==
X-Received: by 2002:a05:6512:ba6:b0:50b:a88d:79ad with SMTP id
 b38-20020a0565120ba600b0050ba88d79admr7045097lfv.43.1701090024701; 
 Mon, 27 Nov 2023 05:00:24 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:00:24 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 07/43] net/lwip: implement wget cmd
Date: Mon, 27 Nov 2023 18:56:50 +0600
Message-Id: <20231127125726.3735-8-maxim.uvarov@linaro.org>
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
index f025384c26..04ffbec006 100644
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
index 0000000000..7a7cc3273d
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
+	if (p + SERVER_NAME_SIZE <= pp)
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

