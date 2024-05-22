Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E9CC25B7A
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 16:05:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB4278883C;
	Wed, 22 May 2024 18:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lLwhls23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B443F88854; Wed, 22 May 2024 18:04:38 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0BB288836
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 18:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-572b37afd73so11724697a12.2
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716393876; x=1716998676; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXd7oGzAMI7gUWNT3VNVwMYJxcvxucOXgjKCsm3HACk=;
 b=lLwhls23+YSGWrQnvCpSqkQ/BdyijmTUzKimtEEuf9ABHEbqi4GuJmQtxv/qkw6n9S
 M1CR2bXYwbQBB0n+4D7COPcUVwJc7MQuAKhB5uQpnhE/0msPDR1lbk2L27rwIIgaYHlp
 rhq0DM2Vs+JKG+axGg1HUbmr1e3MN3fq3IFh54+kZAns6zhMGHfE0AimT/scuKOtnFZK
 vNKcyP0bexHBCfeKbwwQZlcKLByNMI8zca8lVdR5OrgFZXBGt11dJA0qOVCmsSPrV3gb
 pWLQgUoVl7BG+2BL8HMMdEWnMrmmuSzcjwOC5ZML2KI37fsvMHZ6iMEKvsyOL8m/D10E
 /1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716393876; x=1716998676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXd7oGzAMI7gUWNT3VNVwMYJxcvxucOXgjKCsm3HACk=;
 b=mFK78ztuxB36IupS9ncrL1Dy/QfshEI1rvevji9X9RSQpD173fwr17R51a2l8KSW1m
 rY9GwVLIBkZcGz626gmaVFS1+vJrk+kU2DfwYDiwAC1T0YWqgvsqBQsE4MoMJ32WoW+/
 QA02iZUuQokQ8OOx2wpqPeGEUkFaj7Gnvx8rBRZv1LJ5ToQAzUbfBpD3AtONelHmaNSJ
 KXptU+rqzsn6UJCBagi40kEXXstSmSOx/dsT+Fu/XUArHSn3oFGdfW/x76HbfeGKBqb7
 zky+RrBWBy6MdzzCEJqvh2UE47qkuR7U4wISfa/Zp9CyW5bCU+Sz75Mt6GKI2U17kBnD
 iX+w==
X-Gm-Message-State: AOJu0YwpPafG0wjj6BVSeB37z3ykMGDDKTCIlQmi/xloLf0z2Biv+87M
 E3DlJ4L3eExn7a5fDaM3OeGocGuzLYQnc4C0nUCA6kzbJa5gbI+ARkwIf+bHZloHFp41U29Xd6W
 ciEXAeFIq
X-Google-Smtp-Source: AGHT+IE+HJ0DVGU27N87qs4TxcsesUSQwWrhOT1npfaSyyyupMdWGqznswknl+PnCIhkbRzsU3fMJg==
X-Received: by 2002:a17:906:7f12:b0:a59:9a68:7327 with SMTP id
 a640c23a62f3a-a6228143b77mr180423866b.54.1716393875662; 
 Wed, 22 May 2024 09:04:35 -0700 (PDT)
Received: from jerome-XPS-13-9310.. ([2a01:e0a:3cb:7bb0:d6a3:fbd6:c45b:172c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6209f64ba8sm367670266b.210.2024.05.22.09.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 09:04:34 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH 07/15] net-lwip: add wget command
Date: Wed, 22 May 2024 18:00:07 +0200
Message-Id: <1d5602d47f312fd8f0220d628f147f1e3c24a2a9.1716393035.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716393035.git.jerome.forissier@linaro.org>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
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

Add CONFIG_CMD_WGET_LWIP depending on CONFIG_NET_LWIP to provide the
wget command using the lightweight IP stack.

About the small change in cmd/efidebug.c: when the wget command based
on the lwIP stack is used (CONFIG_CMD_WGET_LWIP=y) the wget command
has a built-in URL validation function since it needs to parse it
anyways (in parse_url()). Therefore wget_validate_uri() doesn't exist.
So, guard the call in efidebug.c with CONFIG_CMD_WGET.

Based on code initially developed by Maxim U.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Maxim Uvarov <muvarov@gmail.com>
Cc: Maxim Uvarov <muvarov@gmail.com>
---
 cmd/Kconfig        |   7 ++
 cmd/efidebug.c     |   8 ++-
 cmd/net-lwip.c     |   8 +++
 include/net-lwip.h |   1 +
 net-lwip/Makefile  |   1 +
 net-lwip/wget.c    | 168 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 190 insertions(+), 3 deletions(-)
 create mode 100644 net-lwip/wget.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 1aba10b14c..3c6292654d 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2117,6 +2117,13 @@ config CMD_TFTPBOOT_LWIP
 	help
 	  tftpboot - load file via network using TFTP protocol
 
+config CMD_WGET_LWIP
+	bool "wget"
+	select PROT_TCP_LWIP
+	help
+	  wget is a simple command to download kernel, or other files,
+	  from a http server over TCP.
+
 endif
 
 endif
diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index c2c525f235..d80e91ecad 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -741,9 +741,11 @@ static int efi_boot_add_uri(int argc, char *const argv[], u16 *var_name16,
 	if (!label)
 		return CMD_RET_FAILURE;
 
-	if (!wget_validate_uri(argv[3])) {
-		printf("ERROR: invalid URI\n");
-		return CMD_RET_FAILURE;
+	if (IS_ENABLED(CONFIG_CMD_WGET)) {
+		if (!wget_validate_uri(argv[3])) {
+			printf("ERROR: invalid URI\n");
+			return CMD_RET_FAILURE;
+		}
 	}
 
 	efi_create_indexed_name(var_name16, var_name16_size, "Boot", id);
diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
index 4179861b2d..2926399bd0 100644
--- a/cmd/net-lwip.c
+++ b/cmd/net-lwip.c
@@ -35,3 +35,11 @@ U_BOOT_CMD(
 	"hostname [envvar]"
 );
 #endif
+
+#if defined(CONFIG_CMD_WGET_LWIP)
+U_BOOT_CMD(
+	wget,   3,      1,      do_wget,
+	"boot image via network using HTTP protocol",
+	"[loadAddress] URL"
+);
+#endif
diff --git a/include/net-lwip.h b/include/net-lwip.h
index 0019d1524e..23ad70fc09 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -85,5 +85,6 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
 
 #endif /* __NET_LWIP_H__ */
diff --git a/net-lwip/Makefile b/net-lwip/Makefile
index a1f2842855..63fbeaaf04 100644
--- a/net-lwip/Makefile
+++ b/net-lwip/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_CMD_DHCP_LWIP) += dhcp.o
 obj-$(CONFIG_CMD_DNS_LWIP) += dns.o
 obj-$(CONFIG_CMD_PING_LWIP) += ping.o
 obj-$(CONFIG_CMD_TFTPBOOT_LWIP) += tftp.o
+obj-$(CONFIG_CMD_WGET_LWIP) += wget.o
 
 # Disable this warning as it is triggered by:
 # sprintf(buf, index ? "foo%d" : "foo", index)
diff --git a/net-lwip/wget.c b/net-lwip/wget.c
new file mode 100644
index 0000000000..0ed8b77c47
--- /dev/null
+++ b/net-lwip/wget.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2024 Linaro Ltd. */
+
+#include <command.h>
+#include <console.h>
+#include <display_options.h>
+#include <image.h>
+#include <lwip/apps/http_client.h>
+#include <lwip/timeouts.h>
+#include <net-lwip.h>
+#include <time.h>
+
+#define SERVER_NAME_SIZE 200
+#define HTTP_PORT_DEFAULT 80
+
+static ulong daddr;
+static ulong saved_daddr;
+static ulong size;
+static ulong prevsize;
+#define PROGRESS_PRINT_STEP_BYTES (100 * 1024)
+static ulong start_time;
+static enum done_state {
+        NOT_DONE = 0,
+        SUCCESS = 1,
+        FAILURE = 2
+} done;
+
+static int parse_url(char *url, char *host, u16 *port, char **path)
+{
+	char *p, *pp;
+	long lport;
+
+	p = strstr(url, "http://");
+	if (!p)
+		return -EINVAL;
+
+	p += strlen("http://");
+
+	/* Parse hostname */
+	pp = strchr(p, ':');
+	if (!pp)
+		pp = strchr(p, '/');
+	if (!pp)
+		return -EINVAL;
+
+	if (p + SERVER_NAME_SIZE <= pp)
+		return -EINVAL;
+
+	memcpy(host, p, pp - p);
+	host[pp - p + 1] = '\0';
+
+	if (*pp == ':') {
+		/* Parse port number */
+		p = pp + 1;
+		lport = simple_strtol(p, &pp, 10);
+		if (pp && *pp != '/')
+			return -EINVAL;
+		if (lport > 65535)
+			return -EINVAL;
+		*port = (u16)lport;
+	} else {
+		*port = HTTP_PORT_DEFAULT;
+	}
+	if (*pp != '/')
+		return -EINVAL;
+	*path = pp;
+
+	return 0;
+}
+
+static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
+			   err_t err)
+{
+	struct pbuf *buf;
+
+	if (!pbuf)
+		return ERR_BUF;
+
+	for (buf = pbuf; buf; buf = buf->next) {
+		memcpy((void *)daddr, buf->payload, buf->len);
+		daddr += buf->len;
+		size += buf->len;
+		if (size - prevsize > PROGRESS_PRINT_STEP_BYTES) {
+			printf("#");
+			prevsize = size;
+		}
+	}
+
+	altcp_recved(pcb, pbuf->tot_len);
+	pbuf_free(pbuf);
+	return ERR_OK;
+}
+
+static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
+			    u32_t rx_content_len, u32_t srv_res, err_t err)
+{
+	ulong elapsed;
+
+	if (httpc_result != HTTPC_RESULT_OK) {
+		log_err("\nHTTP client error %d\n", httpc_result);
+		done = FAILURE;
+		return;
+	}
+
+	elapsed = get_timer(start_time);
+        log_info("\n%u bytes transferred in %lu ms (", rx_content_len,
+                 get_timer(start_time));
+        print_size(rx_content_len / elapsed * 1000, "/s)\n");
+
+	if (env_set_hex("filesize", rx_content_len) ||
+	    env_set_hex("fileaddr", saved_daddr)) {
+		log_err("Could not set filesize or fileaddr\n");
+		done = FAILURE;
+		return;
+	}
+
+	done = SUCCESS;
+}
+
+int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
+{
+	char server_name[SERVER_NAME_SIZE];
+	httpc_connection_t conn;
+	httpc_state_t *state;
+	char *path;
+	char *url;
+	u16 port;
+
+	if (argc < 2 || argc > 3)
+		return CMD_RET_USAGE;
+
+	done = NOT_DONE;
+	size = 0;
+	prevsize = 0;
+	daddr = image_load_addr;
+	saved_daddr = image_load_addr;
+
+	if (!strncmp(argv[1], "0x", 2)) {
+		if (argc < 3)
+			return CMD_RET_USAGE;
+		daddr = hextoul(argv[1], NULL);
+		url = argv[2];
+	} else {
+		url = argv[1];
+	}
+
+	if (parse_url(url, server_name, &port, &path))
+		return CMD_RET_USAGE;
+
+	memset(&conn, 0, sizeof(conn));
+	conn.result_fn = httpc_result_cb;
+	start_time = get_timer(0);
+	if (httpc_get_file_dns(server_name, port, path, &conn, httpc_recv_cb,
+			       NULL, &state))
+		return CMD_RET_FAILURE;
+
+	while (!done) {
+		eth_rx();
+		sys_check_timeouts();
+		if (ctrlc())
+			break;
+	}
+
+	if (done == SUCCESS)
+		return CMD_RET_SUCCESS;
+
+	return CMD_RET_FAILURE;
+}
-- 
2.40.1

