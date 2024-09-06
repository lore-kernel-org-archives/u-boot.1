Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07013CE7B06
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 12:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77EFF88C9F;
	Fri,  6 Sep 2024 14:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CDKIdGIm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B84288CD1; Fri,  6 Sep 2024 14:35:11 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8160388C5C
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 14:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-374c5bab490so1843460f8f.1
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 05:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725626107; x=1726230907; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+Lk/w69NsA/TI0A0wUcPiB48B6Rw/VrcXK6XGOpXwQ=;
 b=CDKIdGImJptSNKbE6n3lJ5IHaKuHwSMGEB3NR4XlmDQWgzR10SmoMso3LKfHfBH13o
 N5t258o48gNFw8AFYcN48k4zFzOuUFGtW/CgmIsbsSxfj+LKCE+UeblTgPgMI+GRPDrQ
 TrinZnIvXAwSdUQf+HiabB4eMSKF98y6uuar5VPIuQifHCpPRKLySknSaUcbWSFE4rST
 ARaVFLz+1rhv4IpEfRNxDxJfpaiNry86UfPeld2xAPRSYRx40Y1a73fXMedDbrzVNqZK
 bgp8F3Ko3e92MRZvO4elzk+wG6RJ6WAq0RAyjUOnp/wvJwxrNx+2DflIQ+f1z9BRc5Am
 cAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725626107; x=1726230907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p+Lk/w69NsA/TI0A0wUcPiB48B6Rw/VrcXK6XGOpXwQ=;
 b=W0Tth7lS7XhfExRA44Rg9U5z82UWzcKB2P3PRV/A78pgaYrOiQvqOYUyAojcbzTSRf
 /cy3VJ3UA/zq+cm7Kd8K1RiH7Ca4fNskbbLwtwRR2HMTkcz+nUD4Z15ZmyEFt0YZDcZM
 MpUqHsiNggFa4k2TWsmhDqR1uU7o42fGtRalEFnmPVRFPflMfoYtSEnloB/ovbKmgRVR
 lHBT3dVGNxusrJJAmJ09FEar9TOofp411gEPNHcxX9Bo/rIl0wd1PZHqpYXk+5J9/kSU
 tKysv6D5JwzGIYMlf9GUz0iaaynIkID/3sfXr/GiXBQuwtZBwis4vIIeExaHSldojudu
 7wJg==
X-Gm-Message-State: AOJu0YwFyidKGg30PM4aS8q+K8H0AlCzmHfl0uX6VfaunSUpznlwc6kB
 TiMan9ZpLCNh6HMxBseUWumPg8vNf+tbxtVml4xZMClsaMJZg1M0aGzfSAu7sihWZUrxby4Cppv
 ZIPGeWixi
X-Google-Smtp-Source: AGHT+IGvhS/HuWaIsxyUNuefsjYD0SzjLBMBJ+FlE9VDzYaWVrVZtN2i8zA7ayK+8dRKpICNsteFag==
X-Received: by 2002:a5d:4146:0:b0:367:938f:550 with SMTP id
 ffacd0b85a97d-3779bb2e591mr6227420f8f.25.1725626106689; 
 Fri, 06 Sep 2024 05:35:06 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1ff1:215c:d8a4:9f99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05cf0e8sm19640125e9.27.2024.09.06.05.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:35:06 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marek Vasut <marex@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v10 09/25] net-lwip: add TFTP support and tftpboot command
Date: Fri,  6 Sep 2024 14:33:25 +0200
Message-Id: <f8583b86b7f0d05136d2ebe1ebb206025218ff29.1725625913.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725625913.git.jerome.forissier@linaro.org>
References: <cover.1725625913.git.jerome.forissier@linaro.org>
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

It also supports taking the server IP from ${tftpserverip} if
defined, before falling back to ${serverip}.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/Kconfig          |   3 +-
 cmd/net-lwip.c       |   8 ++
 include/net-common.h |   4 +
 include/net-lwip.h   |   4 +
 net/lwip/dhcp.c      |  11 +-
 net/lwip/net-lwip.c  |  16 +++
 net/lwip/tftp.c      | 279 ++++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 319 insertions(+), 6 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c3281c97501..6691c2d6fa6 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2116,10 +2116,9 @@ config CMD_MDIO
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
diff --git a/include/net-common.h b/include/net-common.h
index 68963a3e9ac..eb23a8883b4 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -440,6 +440,10 @@ static inline struct in_addr env_get_ip(char *var)
 
 int net_init(void);
 
+/* NET compatibility */
+enum proto_t;
+int net_loop(enum proto_t protocol);
+
 /**
  * dhcp_run() - Run DHCP on the current ethernet device
  *
diff --git a/include/net-lwip.h b/include/net-lwip.h
index cfd06726577..37744b0e2cd 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -6,6 +6,10 @@
 #include <lwip/ip4.h>
 #include <lwip/netif.h>
 
+enum proto_t {
+	TFTPGET
+};
+
 struct netif *net_lwip_new_netif(struct udevice *udev);
 struct netif *net_lwip_new_netif_noip(struct udevice *udev);
 void net_lwip_remove_netif(struct netif *netif);
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index e492ad82a9b..2b5d51924af 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -114,11 +114,20 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
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
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index fa4ad2a65f8..dd8e3deeff4 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -24,6 +24,7 @@ static uchar net_pkt_buf[(PKTBUFSRX) * PKTSIZE_ALIGN + PKTALIGN];
 uchar *net_rx_packets[PKTBUFSRX];
 uchar *net_rx_packet;
 const u8 net_bcast_ethaddr[6] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+char net_boot_file_name[1024];
 
 static err_t linkoutput(struct netif *netif, struct pbuf *p)
 {
@@ -280,6 +281,21 @@ void net_process_received_packet(uchar *in_packet, int len)
 #endif
 }
 
+int net_loop(enum proto_t protocol)
+{
+	char *argv[1];
+
+	switch (protocol) {
+	case TFTPGET:
+		argv[0] = "tftpboot";
+		return do_tftpb(NULL, 0, 1, argv);
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
 u32_t sys_now(void)
 {
 	return get_timer(0);
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 1fa246f55d9..50b8fbad00d 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -2,10 +2,283 @@
 /* Copyright (C) 2024 Linaro Ltd. */
 
 #include <command.h>
-#include <net-lwip.h>
+#include <console.h>
+#include <display_options.h>
+#include <dm/device.h>
+#include <efi_loader.h>
+#include <image.h>
+#include <linux/delay.h>
+#include <lwip/apps/tftp_client.h>
+#include <lwip/timeouts.h>
+#include <mapmem.h>
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
+		efi_set_bootdev("Net", "", fname, map_sysmem(addr, 0),
+				ctx.size);
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
+	ulong laddr;
+	ulong addr;
+	int ret;
+	int i;
+
+	laddr = env_get_ulong("loadaddr", 16, image_load_addr);
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
+			laddr = addr;
+			fname = env_get("bootfile");
+		} else {
+			arg = strdup(argv[1]);
+		}
+		break;
+	case 3:
+		laddr = hextoul(argv[1], NULL);
+		arg = strdup(argv[2]);
+		break;
+	default:
+		ret = CMD_RET_USAGE;
+		goto out;
+	}
+
+	if (!arg)
+		arg = net_boot_file_name;
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
+		server_ip = env_get("tftpserverip");
+	if (!server_ip)
+		server_ip = env_get("serverip");
+	if (!server_ip) {
+		log_err("error: tftpserverip/serverip has to be set\n");
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
+	if (!laddr) {
+		log_err("error: no load address\n");
+		ret = CMD_RET_FAILURE;
+		goto out;
+	}
+
+	eth_set_current();
+
+	if (tftp_loop(eth_get_dev(), laddr, fname, srvip, port) < 0)
+		ret = CMD_RET_FAILURE;
+out:
+	free(arg);
+	return ret;
 }
-- 
2.40.1

