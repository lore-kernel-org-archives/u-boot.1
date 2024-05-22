Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456BEC25B7F
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 16:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA38F88096;
	Wed, 22 May 2024 18:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W86n/ket";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D18388823; Wed, 22 May 2024 18:04:24 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CA6787F19
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 18:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a5a5cce2ce6so914834266b.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716393861; x=1716998661; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oMey1tvGymla2qXVjGCNgRyoqTxggvJazFeCn7h91jk=;
 b=W86n/ket3veE+jmpkqrMa+NlbITPEuiT31u3vr/TTHK9uVvxxMsCB1tqK78L7cYxNW
 GoQ0fVcCC+EqeqhDcOcQItd9gGjIYvuvouPxz9awoWsVk92jdbOkT8YH5E5zfiqWqyeR
 JZkZdIFgD42hN3Cnv7/uj820fPLCNv92QsqoAzTA9NIEK8MpfxtFCXLAN9Y240ysklD+
 H2jdRxThZ0dLh3Ub3rSmfe/3/TR/rhirFIqO9dq0xbQ6VY1au5wWN8kRdGZu5cys6wAv
 OOGqG1KApURQSs0KuuNuHA+jxJHnA9cf0iK++O2HvA6+71RrYaUvtKtOz87HBygceyci
 gyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716393861; x=1716998661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oMey1tvGymla2qXVjGCNgRyoqTxggvJazFeCn7h91jk=;
 b=Me82mtJfoJrq/GB/jc/zZxuWb6zZw3rJC4ye6Igble1tnyXdZdc8DJKnVtu/2TOS9h
 VUeMw0H5bC67FJCPoXfLgg70A5V3kXrmMBbm7PUb/BLwXNYn3+Xrxl5WhYZ3jmENxWSQ
 2h8W3ImGFPVaZSX/BdRDTTz0iqMLUx84hoAf10IG3IJfR4J7FC2U/NSCJ1aAHgtNCX+u
 wlsotKErKAqoUwC6YkjrfMVZCJ1e/zWF1QtDEUxraU3ytIqVv0FCVXYvgEEDiVL2Wfzn
 gI7rf6mJeaYZfl4X7O1ftPiWBoSZNXCv3z3ibB1/1I8aAtcWReEGeEgolOI3/odzhrkO
 xymw==
X-Gm-Message-State: AOJu0YzLxzwerj9rwGbeBnDq7bwreYQlAnMtnmqTXBUBrCSUf7LlU6h7
 ZLLQ9sHAsf+SnMUb0slhMtD6Ecgq5r4CN+3G7ftPxRqKNGDpAeLWcU31sNIBBe1nFmGVRpfBtS+
 GPNUhxBYp
X-Google-Smtp-Source: AGHT+IFUdmvL2IvNGPL+PDsrbt3MlV585DS6JTQ92Zr32QCGhjh3jqSnzbSeTfPOCip/BzfySFnY4g==
X-Received: by 2002:a17:906:c46:b0:a59:ab57:7413 with SMTP id
 a640c23a62f3a-a6228171a99mr163479966b.73.1716393861457; 
 Wed, 22 May 2024 09:04:21 -0700 (PDT)
Received: from jerome-XPS-13-9310.. ([2a01:e0a:3cb:7bb0:d6a3:fbd6:c45b:172c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6209f64ba8sm367670266b.210.2024.05.22.09.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 09:04:21 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 04/15] net-lwip: add TFTP support and tftpboot command
Date: Wed, 22 May 2024 18:00:04 +0200
Message-Id: <412191bd889baf77c19adf3eb4b04a87fd52a0c2.1716393035.git.jerome.forissier@linaro.org>
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

Implement do_tftpb().

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/Kconfig     |   3 +-
 cmd/net-lwip.c  |   8 ++
 net-lwip/dhcp.c |  11 ++-
 net-lwip/tftp.c | 206 +++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 223 insertions(+), 5 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 0ef3189d8c..7bb6269b7a 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2101,10 +2101,9 @@ config CMD_DHCP_LWIP
 config CMD_TFTPBOOT_LWIP
 	bool "tftp"
 	select PROT_UDP_LWIP
-	default n
+	default y
 	help
 	  tftpboot - load file via network using TFTP protocol
-	  Currently a placeholder (not implemented)
 
 endif
 
diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
index c740461c64..30b396f2d0 100644
--- a/cmd/net-lwip.c
+++ b/cmd/net-lwip.c
@@ -11,3 +11,11 @@ U_BOOT_CMD(
         "[loadAddress] [[hostIPaddr:]bootfilename]"
 );
 #endif
+
+#if defined(CONFIG_CMD_TFTPBOOT_LWIP)
+U_BOOT_CMD(
+	tftpboot,	3,	0,	do_tftpb,
+	"boot image via network using TFTP protocol\n",
+	"[loadAddress] [[hostIPaddr:]bootfilename]"
+);
+#endif
diff --git a/net-lwip/dhcp.c b/net-lwip/dhcp.c
index ae2d922cda..f4655162fe 100644
--- a/net-lwip/dhcp.c
+++ b/net-lwip/dhcp.c
@@ -94,11 +94,20 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 int dhcp_run(ulong addr, const char *fname, bool autoload)
 {
 	char *dhcp_argv[] = {"dhcp", NULL, };
+#ifdef CONFIG_CMD_TFTPBOOT_LWIP
+	char *tftp_argv[] = {"tftpboot", boot_file_name, NULL, };
+#endif
 	struct cmd_tbl cmdtp = {};	/* dummy */
 
 	if (autoload) {
-		/* Will be supported when TFTP is added */
+#ifdef CONFIG_CMD_TFTPBOOT_LWIP
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
index 1fa246f55d..19bf083d99 100644
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

