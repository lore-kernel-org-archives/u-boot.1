Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5610DC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 13:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E1C0883C2;
	Thu,  6 Jun 2024 15:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tDs0sYUB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB3C2883C2; Thu,  6 Jun 2024 15:37:06 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DB978844E
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 15:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42108856c33so12596085e9.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 06:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717681023; x=1718285823; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gixJyMqtgR/Ja9yTjknGq4WaI5xi6z803iO4UfDzWGo=;
 b=tDs0sYUB5abuuc7nzP9F1xE2q76RxWY4mLGiiF9MxzexMgeWU6i+LfUSdVC1qW8kJZ
 vZSALIz2ey/OtvpjpbTQVht5oo8LzxgvauTbhaFd8172XwojzHRmOPMMu2hzr+vtRJqw
 xfmWnx4CdhhfTqAifFQFyHCVLGA4TeO4gHEx7sen7TxEKWnomV+cAkdGdxHfLZL4cnjJ
 Q+WMmOCmMCJDpsLgfiRQaEXSY4OOIW+g+OPQ8jmU+38S1nLNxJGzdM4pcBX/re092I7F
 BpfQOe7tPOEAeJSA3pZXbfj09gi7AIZmERJBM1i+rRben67lWsoFMvHenK2NQyZwnDj8
 thJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717681023; x=1718285823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gixJyMqtgR/Ja9yTjknGq4WaI5xi6z803iO4UfDzWGo=;
 b=HZXeuzFKetIw437XZeCxgUGN9RKCKUm1lUd3LgItmT30nXLnjH//s4euRKbZFXM7xR
 2hBjvkp/eXcDZDA1u4lSCspf1IkwGulA9AsBdaxgebIe0glsgO5Hqj7U+TI28lETpsw2
 5pBYaoMlMzSQwpx0/ulBNsp/J/JX2UzeVRAsCz0isOszXlAqKomDPo9UwXjpW5V5xpAR
 +pVbm7EcuyVuKbMs3u3HqdrR1OfcmnNft4Pd8V0lS+OSNiHezXaPLzzAXI/o+t1qF8L5
 UL2msjLk+nLK24xm2Zfk4DFI/J7XL5sHt5xJENEyXLaZ2sXp1KBPanYKckmgY49dpVkM
 B0NA==
X-Gm-Message-State: AOJu0YzKFf9GzwZE5tf3z9vfSczpi+iDIyIL+qmluSWxVA5t7N91GdR9
 cweWd+Em/Yzi9SwLZYck+2TvFwIepmI05i0QTNfD9Un8xaY2XGPqb/aa0lMm2Dhl7Km2SfrAD4a
 wFuUJi8Dq
X-Google-Smtp-Source: AGHT+IGovyUG+2Kx42iGne2CzrOoDQNz8/VcWX9FRp7k4T0++HF2mnaL89Voo2SRO8JdJWO/7zmkdQ==
X-Received: by 2002:a05:600c:1c28:b0:420:1a72:69dd with SMTP id
 5b1f17b1804b1-4215acf92damr22605235e9.10.1717681023372; 
 Thu, 06 Jun 2024 06:37:03 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c19d52dsm23111955e9.8.2024.06.06.06.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 06:37:03 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 04/12] net-lwip: add TFTP support and tftpboot command
Date: Thu,  6 Jun 2024 15:35:59 +0200
Message-Id: <805d51e8a6a2f54ae7fc20d9fbc599fb71866755.1717680809.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1717680809.git.jerome.forissier@linaro.org>
References: <cover.1717680809.git.jerome.forissier@linaro.org>
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

Implement do_tftpb().

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/Kconfig     |   3 +-
 cmd/net-lwip.c  |   8 ++
 net-lwip/dhcp.c |  11 ++-
 net-lwip/tftp.c | 202 +++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 219 insertions(+), 5 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 1bfa528e945..94a8de266f6 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2101,10 +2101,9 @@ config CMD_DHCP
 config CMD_TFTPBOOT
 	bool "tftp"
 	select PROT_UDP_LWIP
-	default n
+	default y
 	help
 	  tftpboot - load file via network using TFTP protocol
-	  Currently a placeholder (not implemented)
 
 endif
 
diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
index 966d7226eda..490a2e4ac5c 100644
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
diff --git a/net-lwip/dhcp.c b/net-lwip/dhcp.c
index d1d35999b04..7bacc234f1e 100644
--- a/net-lwip/dhcp.c
+++ b/net-lwip/dhcp.c
@@ -94,11 +94,20 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
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
diff --git a/net-lwip/tftp.c b/net-lwip/tftp.c
index 1fa246f55d9..02ee4aacca5 100644
--- a/net-lwip/tftp.c
+++ b/net-lwip/tftp.c
@@ -2,10 +2,208 @@
 /* Copyright (C) 2024 Linaro Ltd. */
 
 #include <command.h>
+#include <console.h>
+#include <image.h>
+#include <linux/delay.h>
+#include <lwip/apps/tftp_client.h>
+#include <lwip/timeouts.h>
 #include <net-lwip.h>
+#include <time.h>
+
+static ulong daddr;
+static ulong size;
+static ulong prevsize;
+#define PROGRESS_PRINT_STEP_BYTES (100 * 1024)
+static ulong start_time;
+static enum done_state {
+	NOT_DONE = 0,
+	SUCCESS = 1,
+	FAILURE = 2
+} done;
+
+static void *tftp_open(const char *fname, const char *mode, u8_t is_write)
+{
+	return NULL;
+}
+
+static void tftp_close(void *handle)
+{
+	ulong elapsed;
+
+	if (done == FAILURE) {
+		/* Closing after an error */
+		return;
+	}
+
+	elapsed = get_timer(start_time);
+	done = SUCCESS;
+	printf("\nBytes transferred = %lu (%lx hex)\n", size, size);
+
+	if (env_set_hex("filesize", size)) {
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
+	struct pbuf *q;
+
+	for (q = p; q != NULL; q = q->next) {
+		memcpy((void *)daddr, q->payload, q->len);
+		daddr += q->len;
+		size += q->len;
+		if (size - prevsize > PROGRESS_PRINT_STEP_BYTES) {
+			printf("#");
+			prevsize = size;
+		}
+	}
+
+	return 0;
+}
+
+static void tftp_error(void *handle, int err, const char *msg, int size)
+{
+	char message[100];
+
+	done = FAILURE;
+	memset(message, 0, sizeof(message));
+	memcpy(message, msg, LWIP_MIN(sizeof(message) - 1, (size_t)size));
+
+	log_info("\nTFTP error: %d (%s)\n", err, message);
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
+static int tftp_run(ulong addr, char *fname, ip_addr_t srvip)
+{
+	void *f = (void *)0x1; /* unused fake file handle*/
+	err_t err;
+
+	if (!fname || addr == 0)
+		return -1;
+
+	done = NOT_DONE;
+	size = 0;
+	prevsize = 0;
+	daddr = addr;
+
+	log_info("TFTP from server %s; our IP address is %s\n",
+		 ip4addr_ntoa(&srvip), env_get("ipaddr"));
+	log_info("Filename '%s'.\n", fname);
+	log_info("Load address: 0x%lx\n", daddr);
+	log_info("Loading: ");
+
+	err = tftp_init_client(&tftp_context);
+	if (!(err == ERR_OK || err == ERR_USE))
+		log_err("tftp_init_client err: %d\n", err);
+
+	start_time = get_timer(0);
+	err = tftp_get(f, &srvip, TFTP_PORT, fname, TFTP_MODE_OCTET);
+	/* might return different errors, like routing problems */
+	if (err != ERR_OK) {
+		log_err("tftp_get err=%d\n", err);
+		return -1;
+	}
+
+	while (!done) {
+		eth_rx();
+		sys_check_timeouts();
+		if (ctrlc())
+			break;
+	}
+
+	tftp_cleanup();
+
+	if (done == SUCCESS) {
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
+	char *fname;
+	char *server_ip;
+	ip_addr_t srvip;
+	ulong addr;
+	char *end;
+	char *col;
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
+			fname = argv[1];
+		}
+		break;
+	case 3:
+		image_load_addr = hextoul(argv[1], NULL);
+		fname = argv[2];
+		break;
+	default:
+		return CMD_RET_USAGE;
+	}
+
+	col = strchr(fname, ':');
+	if (col) {
+		server_ip = fname;
+		*col = '\0';
+		fname = col + 1;
+	} else {
+		server_ip = env_get("serverip");
+		if (!server_ip) {
+			log_err("error: serverip variable has to be set\n");
+			return CMD_RET_FAILURE;
+		}
+	}
+	if (!ipaddr_aton(server_ip, &srvip)) {
+		log_err("error: ipaddr_aton\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (!fname) {
+		log_err("error: no file name\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (!image_load_addr) {
+		log_err("error: no load address\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (tftp_run(image_load_addr, fname, srvip) < 0)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
 }
-- 
2.40.1

