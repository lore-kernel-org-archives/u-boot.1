Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5808BC25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 16:22:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D28F6888C7;
	Fri, 24 May 2024 18:22:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XLN0fxA1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A26888B7; Fri, 24 May 2024 18:22:16 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48B3C88552
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-351da5838fcso7124495f8f.1
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716567733; x=1717172533; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R00WIUp7S/NsY8Gw7Sp0lsVx5QNHhMW2f0XZWPnOEDw=;
 b=XLN0fxA1GARbDfYQix/iInQn6Xrh2OS+vylu3HTHxWb8Pbn0TJTTK98AuBZyeufuEq
 LDzHCA19UTdRzunBzsmSEVdZgH0v5GVyT3OYV0ZBv5D33tyckUzvGXf9S3oQp8OqMiI4
 mNJTunej97w7lPBzn1H6rN/aEBdHYvZ6SqD3eq8kmguip9Zg/H8k51BQyEK62JNgrD/L
 d1nmpyr1RyzQuUH1q2m8mYiWbeLP02vp3WAIiJ7eacjtR2HJT0NjJdT4vFOK0wkFKFxm
 zTiKyBFl5Xl1RDF6V7zyEwquK+qHz4xX/SGefc5oxm51gqF6AqOUl9nZJcHiU+wvIaw2
 fl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716567733; x=1717172533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R00WIUp7S/NsY8Gw7Sp0lsVx5QNHhMW2f0XZWPnOEDw=;
 b=wUEeNTFw5T7ZicDRyWREnsPBUJgI0UdQjsoDwCiHVVGLlfoTTCEfHRanj07ayaeaX+
 PPuoc7guB72nVSkS3NNR7X6ykVlCBaciHNeUWFeV93nomarjESR6NFChzCIQ1O/jh5m7
 3qwxxFsjNz82kXKzdFPIxFJDGRD4S//hqHkVvoqjuk9Zz+gcFhfaHEUEltaNMJKDNKgp
 lLL+2ERlf3jTo9v3fmXq2KRXKgzlF3yediIiyZhXsCDVDqOth9JqWEQrVRsVk3nsm+pF
 HmefO16o9GWKt+bJDZgd9QzlqnXBS1uJlbfo3nCeNxQJvKuNZP/XP7WJYyMJAg3IlhFB
 xynA==
X-Gm-Message-State: AOJu0Yy1EvI5EqSa+MZd+wQ8OMfAZkmQpx0VHJxceIwhI5ufP72y8kzW
 bFZPlKRv1jELm44Q+zox8rqYq6FzPp7VkM1Q1lW5RSjnqc4myJHgdt2vIEwHShmbhfRgolmNIZF
 i2Mz32d9c
X-Google-Smtp-Source: AGHT+IE3avGnuQj8uOoxFnLKuRQV75Vnp3ya9QlmnuOLGBkuonPSFuu6GRQEh86H9Y6sT2LrTGNybg==
X-Received: by 2002:a5d:68c1:0:b0:354:e0e8:e8bd with SMTP id
 ffacd0b85a97d-35527056169mr1827286f8f.49.1716567733494; 
 Fri, 24 May 2024 09:22:13 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:80fe:af01:c137:b43b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a1c918csm1928465f8f.77.2024.05.24.09.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 09:22:13 -0700 (PDT)
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
Subject: [PATCH v2 05/14] net-lwip: add TFTP support and tftpboot command
Date: Fri, 24 May 2024 18:19:59 +0200
Message-Id: <f155d93c8986b875526b4a5d2293f3b2a99da8d8.1716566960.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716566960.git.jerome.forissier@linaro.org>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
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
 net-lwip/tftp.c | 206 +++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 223 insertions(+), 5 deletions(-)

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
index 1fa246f55d9..19bf083d995 100644
--- a/net-lwip/tftp.c
+++ b/net-lwip/tftp.c
@@ -2,10 +2,212 @@
 /* Copyright (C) 2024 Linaro Ltd. */
 
 #include <command.h>
+#include <console.h>
+#include <display_options.h>
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
+	log_info("\n%lu bytes transferred in %lu ms (", size,
+		 get_timer(start_time));
+	print_size(size / elapsed * 1000, "/s)\n");
+
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

