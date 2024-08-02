Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A74C52D6D
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 13:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD29F88BC6;
	Fri,  2 Aug 2024 15:15:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r4BBhDeu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4B2588BC9; Fri,  2 Aug 2024 15:15:02 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47C0288B9B
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 15:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3683329f787so4391007f8f.1
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 06:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722604498; x=1723209298; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FoWkk/O4vlu8pKvieTpAWd01EMDz/OnzgA2UGEcJPMc=;
 b=r4BBhDeuimn+HJGXbDCPKl5qG4jeXzTs2ty3hcuUaZvv9O9Neom/9HO/DOnf73L9Go
 /Mlm/jmQQJ5iiubNrdPGwAWdvd1f0qYxXpEnp8APuktKIm+WrLl6cg9LOyxnTUTx9WjE
 azamieIJJxEPcAE4Bydu/jga+VHeyCrU+Svxwr0B0vanFKBwJGE+AykZsa3xEYCkcHTt
 vTZYk2Hfb2EclqmvH0jHnUTobdQYwgpDbbqtUl7vN9U096tjGEyLWXVgSfd9xZVkob/z
 ecxGr/5WA39BDBSGZV9ZNypkB4fqEQVqGnFQL2m7H+n6FNkUSJbxXb7JhJIDKs0qMGJH
 k1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722604498; x=1723209298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FoWkk/O4vlu8pKvieTpAWd01EMDz/OnzgA2UGEcJPMc=;
 b=TgM/lwAnpbzYYNweb+q4fJt8v0KwWQm3+3cqfyzFKqbs98ZJB6AwrNSu5E96Ng46sG
 OzelqhZVGhLPhy0SzNR02d69TCL+q1J7idFnZNeERFYCQCykIUXfVSAVZn0eL5w3Synz
 K6vm8jf4p1sl7ZkqLI1jOoRz1coWiacXiSU8HFfoLzF+GaQmy43CdzQTqsi2O0uGyfqc
 pFD66KCH/Wg5OpmqaossiGXgjTM8GiKl5Cw6qMmqMwuUIYj1w0Q1HvybAuo5NIhHRkai
 LK/A4/XmJU5wH7KNzWBrGw4sa4YcFXztSGQyJ3M1v3cg0iTcXvpq1GLsl5vAyu1Rw5ZG
 OAdA==
X-Gm-Message-State: AOJu0YzjprAKrjvYF7uEM+UCCVngfVcBsvNR2+QH5R/J/0bPDeo+CK7B
 CNAfpiNK3ZimK06A/qTP3sYlcvWrfrJSOmTYTXleuyjw/qkPfecMF/IJ/3vOjVws6c+yL45x5Bj
 Ei40QLtkv
X-Google-Smtp-Source: AGHT+IElcRjBwxGjZ5WV0SMmEBCOQKd92OIhkJucZ5TinGdVnX6OJyX0maOpG12hfMzJYdJdmaXr7Q==
X-Received: by 2002:a05:6000:1bd2:b0:368:4492:eca9 with SMTP id
 ffacd0b85a97d-36bbc0e41d7mr1889008f8f.20.1722604498431; 
 Fri, 02 Aug 2024 06:14:58 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0cc58sm1970304f8f.2.2024.08.02.06.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 06:14:58 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v6 09/20] net-lwip: add TFTP support and tftpboot command
Date: Fri,  2 Aug 2024 15:13:56 +0200
Message-Id: <1a110949a675c10b1e04e86c1d1e9b2530e888fb.1722601509.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722601509.git.jerome.forissier@linaro.org>
References: <cover.1722601509.git.jerome.forissier@linaro.org>
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

Implement do_tftpb(). This implementation of the tftp command
supports an optional port number. For example:

 tftp 192.168.0.30:9069:file.bin

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/Kconfig     |   3 +-
 cmd/net-lwip.c  |   8 ++
 net/lwip/dhcp.c |  11 +-
 net/lwip/tftp.c | 269 +++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 285 insertions(+), 6 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index a7f6d23d248..02243138515 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2101,10 +2101,9 @@ config CMD_MDIO
 config CMD_TFTPBOOT
 	bool "tftp"
 	select PROT_UDP_LWIP if NET_LWIP
-	default n
+	default y
 	help
 	  tftpboot - load file via network using TFTP protocol
-	  Currently a placeholder (not implemented) when NET_LWIP=y.
 
 endif  # if CMD_NET
 
diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
index 82edb5fd2e6..80f0872bb8f 100644
--- a/cmd/net-lwip.c
+++ b/cmd/net-lwip.c
@@ -11,3 +11,11 @@ U_BOOT_CMD(
         "[loadAddress] [[hostIPaddr:]bootfilename]"
 );
 #endif
+
+#if defined(CONFIG_CMD_TFTPBOOT)
+U_BOOT_CMD(
+	tftpboot,	3,	0,	do_tftpb,
+	"boot image via network using TFTP protocol\n",
+	"[loadAddress] [[hostIPaddr:]bootfilename]"
+);
+#endif
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 3c1eeaf9fb1..a91d7e1ca0f 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -116,11 +116,20 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 int dhcp_run(ulong addr, const char *fname, bool autoload)
 {
 	char *dhcp_argv[] = {"dhcp", NULL, };
+#ifdef CONFIG_CMD_TFTPBOOT
+	char *tftp_argv[] = {"tftpboot", boot_file_name, NULL, };
+#endif
 	struct cmd_tbl cmdtp = {};	/* dummy */
 
 	if (autoload) {
-		/* Will be supported when TFTP is added */
+#ifdef CONFIG_CMD_TFTPBOOT
+		/* Assume DHCP was already performed */
+		if (boot_file_name[0])
+			return do_tftpb(&cmdtp, 0, 2, tftp_argv);
+		return 0;
+#else
 		return -EOPNOTSUPP;
+#endif
 	}
 
 	return do_dhcp(&cmdtp, 0, 1, dhcp_argv);
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 1fa246f55d9..78de0bd0dba 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -2,10 +2,273 @@
 /* Copyright (C) 2024 Linaro Ltd. */
 
 #include <command.h>
-#include <net-lwip.h>
+#include <console.h>
+#include <display_options.h>
+#include <dm/device.h>
+#include <image.h>
+#include <linux/delay.h>
+#include <lwip/apps/tftp_client.h>
+#include <lwip/timeouts.h>
+#include <net.h>
+#include <time.h>
+
+#define PROGRESS_PRINT_STEP_BYTES (10 * 1024)
+
+enum done_state {
+	NOT_DONE = 0,
+	SUCCESS = 1,
+	FAILURE = 2
+};
+
+struct tftp_ctx {
+	ulong daddr;
+	ulong size;
+	ulong block_count;
+	ulong start_time;
+	enum done_state done;
+};
+
+static void *tftp_open(const char *fname, const char *mode, u8_t is_write)
+{
+	return NULL;
+}
+
+static void tftp_close(void *handle)
+{
+	struct tftp_ctx *ctx = handle;
+	ulong elapsed;
+
+	if (ctx->done == FAILURE) {
+		/* Closing after an error */
+		return;
+	}
+	ctx->done = SUCCESS;
+
+	elapsed = get_timer(ctx->start_time);
+	if (elapsed > 0) {
+		puts("\n\t ");	/* Line up with "Loading: " */
+		print_size(ctx->size / elapsed * 1000, "/s");
+	}
+	puts("\ndone\n");
+	printf("Bytes transferred = %lu (%lx hex)\n", ctx->size, ctx->size);
+
+	if (env_set_hex("filesize", ctx->size)) {
+		log_err("filesize not updated\n");
+		return;
+	}
+}
+
+static int tftp_read(void *handle, void *buf, int bytes)
+{
+	return 0;
+}
+
+static int tftp_write(void *handle, struct pbuf *p)
+{
+	struct tftp_ctx *ctx = handle;
+	struct pbuf *q;
+
+	for (q = p; q != NULL; q = q->next) {
+		memcpy((void *)ctx->daddr, q->payload, q->len);
+		ctx->daddr += q->len;
+		ctx->size += q->len;
+		ctx->block_count++;
+		if (ctx->block_count % 10 == 0) {
+			putc('#');
+			if (ctx->block_count % (65 * 10) == 0)
+				puts("\n\t ");
+		}
+	}
+
+	return 0;
+}
+
+static void tftp_error(void *handle, int err, const char *msg, int size)
+{
+	struct tftp_ctx *ctx = handle;
+	char message[100];
+
+	ctx->done = FAILURE;
+	memset(message, 0, sizeof(message));
+	memcpy(message, msg, LWIP_MIN(sizeof(message) - 1, (size_t)size));
+
+	printf("\nTFTP error: %d (%s)\n", err, message);
+}
+
+static const struct tftp_context tftp_context = {
+	tftp_open,
+	tftp_close,
+	tftp_read,
+	tftp_write,
+	tftp_error
+};
+
+static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
+		     ip_addr_t srvip, uint16_t srvport)
+{
+	struct netif *netif;
+	struct tftp_ctx ctx;
+	err_t err;
+
+	if (!fname || addr == 0)
+		return -1;
+
+	if (!srvport)
+		srvport = TFTP_PORT;
+
+	netif = net_lwip_new_netif(udev);
+	if (!netif)
+		return -1;
+
+	ctx.done = NOT_DONE;
+	ctx.size = 0;
+	ctx.block_count = 0;
+	ctx.daddr = addr;
+
+	printf("Using %s device\n", udev->name);
+	printf("TFTP from server %s; our IP address is %s\n",
+		 ip4addr_ntoa(&srvip), env_get("ipaddr"));
+	printf("Filename '%s'.\n", fname);
+	printf("Load address: 0x%lx\n", ctx.daddr);
+	printf("Loading: ");
+
+	err = tftp_init_client(&tftp_context);
+	if (!(err == ERR_OK || err == ERR_USE))
+		log_err("tftp_init_client err: %d\n", err);
+
+	ctx.start_time = get_timer(0);
+	err = tftp_get(&ctx, &srvip, srvport, fname, TFTP_MODE_OCTET);
+	/* might return different errors, like routing problems */
+	if (err != ERR_OK) {
+		printf("tftp_get() error %d\n", err);
+		net_lwip_remove_netif(netif);
+		return -1;
+	}
+
+	while (!ctx.done) {
+		net_lwip_rx(udev, netif);
+		sys_check_timeouts();
+		if (ctrlc())
+			break;
+	}
+
+	tftp_cleanup();
+
+	net_lwip_remove_netif(netif);
+
+	if (ctx.done == SUCCESS) {
+		if (env_set_hex("fileaddr", addr)) {
+			log_err("fileaddr not updated\n");
+			return -1;
+		}
+		return 0;
+	}
+
+	return -1;
+}
 
 int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	/* Not implemented */
-	return CMD_RET_FAILURE;
+	char *arg = NULL;
+	char *words[3] = { };
+	char *fname = NULL;
+	char *server_ip = NULL;
+	char *server_port = NULL;
+	char *end;
+	ip_addr_t srvip;
+	uint16_t port = TFTP_PORT;
+	ulong addr;
+	int ret;
+	int i;
+
+	image_load_addr = env_get_ulong("loadaddr", 16, image_load_addr);
+
+	switch (argc) {
+	case 1:
+		fname = env_get("bootfile");
+		break;
+	case 2:
+		/*
+		 * Only one arg - accept two forms:
+		 * Just load address, or just boot file name. The latter
+		 * form must be written in a format which can not be
+		 * mis-interpreted as a valid number.
+		 */
+		addr = hextoul(argv[1], &end);
+		if (end == (argv[1] + strlen(argv[1]))) {
+			image_load_addr = addr;
+			fname = env_get("bootfile");
+		} else {
+			arg = strdup(argv[1]);
+		}
+		break;
+	case 3:
+		image_load_addr = hextoul(argv[1], NULL);
+		arg = strdup(argv[2]);
+		break;
+	default:
+		ret = CMD_RET_USAGE;
+		goto out;
+	}
+
+	if (arg) {
+		/* Parse [ip:[port:]]fname */
+		i = 0;
+		while ((*(words + i) = strsep(&arg,":")))
+			i++;
+
+		switch (i) {
+		case 3:
+			server_ip = words[0];
+			server_port = words[1];
+			fname = words[2];
+			break;
+		case 2:
+			server_ip = words[0];
+			fname = words[1];
+			break;
+		case 1:
+			fname = words[0];
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!server_ip)
+		server_ip = env_get("serverip");
+	if (!server_ip) {
+		log_err("error: serverip variable has to be set\n");
+		ret = CMD_RET_FAILURE;
+		goto out;
+	}
+
+	if (server_port)
+		port = dectoul(server_port, NULL);
+
+	if (!ipaddr_aton(server_ip, &srvip)) {
+		log_err("error: ipaddr_aton\n");
+		ret = CMD_RET_FAILURE;
+		goto out;
+	}
+
+	if (!fname) {
+		log_err("error: no file name\n");
+		ret = CMD_RET_FAILURE;
+		goto out;
+	}
+
+	if (!image_load_addr) {
+		log_err("error: no load address\n");
+		ret = CMD_RET_FAILURE;
+		goto out;
+	}
+
+	eth_set_current();
+
+	if (tftp_loop(eth_get_dev(), image_load_addr, fname, srvip, port) < 0)
+		ret = CMD_RET_FAILURE;
+out:
+	free(arg);
+	return ret;
 }
-- 
2.40.1

