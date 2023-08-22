Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41020EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 09:40:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 311EA864AF;
	Tue, 22 Aug 2023 11:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MY0CujmQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC0AF864C8; Tue, 22 Aug 2023 11:38:50 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03F2A86483
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:38:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b9a2033978so66622441fa.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 02:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697127; x=1693301927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FRoLHHce4JOrxPpx2ezZa+k60uaaJrxdQ0nPimAy89s=;
 b=MY0CujmQhhPfI8PdylGSOgQhcW3QnjqP2IYDkGtTN/BG2xmyzTFzdL459mrnhE0u+S
 kmKfiQ8cGmoAZ60KLE7oHcppkHyoe540myiWYvYFd5TZxK9agRQbZh4O/mctyEFBTjAC
 Kjjtjk0E2Z+HHC4BhBNrul4FPqlDxqRLq5Ew2z+5IHLOLSKl5UFQo7i4ixMXoocevjIQ
 oYwItOEtotfAlPstnHWS7oRJy9PR7qM9NDB9e/ZMMVoVGVw+cpUcjMOYP76paB8ySkw+
 O1/A55WX68D6C1RvYtOazw1SaWT41a7PPMF5j8qQeGdqXkIc1dlNI6Ht6zxwjTveL8bv
 XSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697127; x=1693301927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FRoLHHce4JOrxPpx2ezZa+k60uaaJrxdQ0nPimAy89s=;
 b=EU+v8xfDOEUriWC/rPVZehgqSiCbbeKQdexqWJNjVqql1I1sQNQArmII24muoQx8Z5
 yFWAcSBy13TJGYwlFstLkV92AExCASBpkBU08IOpSzYyLv8neXzkI213t3cOayg4NtXR
 2ao0xRpeGisNWysPd6sWoYTTxsbGaHOBntVyjBfW6erTJqtwg/nw7Ov+PJJooanvIuFH
 PcrnglN6UwVa9396Rp8CX7yOIJCicyzHlpDcDyRBsgoKtK8i/TdwdoORtPTnnEvmHbTT
 D8ufWjJTE2ARitZzqX1mTv5EfOYvPNBlbzUR7XA4+n8DK+xKBiumPgrpHmWW36toMwon
 YoGA==
X-Gm-Message-State: AOJu0YwfRrQtS6o85pVLTY12TaH84mTAFE8mVtsudB5y0gjUZrHYEmDf
 pHRXA1b6f2gOaNXwhjnk2DB2fBcdaJBrAacvEUA6XA==
X-Google-Smtp-Source: AGHT+IGfIV4QDSk3CIq3CejpaOnJI+E0ENsJ5KcP6JJSYRtLbGX6bMqArVBbEhSvhOm3La55g4IDTw==
X-Received: by 2002:a2e:9b8a:0:b0:2b9:581d:73bb with SMTP id
 z10-20020a2e9b8a000000b002b9581d73bbmr6292200lji.26.1692697127011; 
 Tue, 22 Aug 2023 02:38:47 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a2e8089000000b002b724063010sm2649637ljg.47.2023.08.22.02.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 02:38:46 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv7 11/15] net/lwip: connection between cmd and lwip apps
Date: Tue, 22 Aug 2023 15:36:10 +0600
Message-Id: <20230822093614.4717-12-maxim.uvarov@linaro.org>
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

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 cmd/Makefile   |   1 +
 cmd/net-lwip.c | 306 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 307 insertions(+)
 create mode 100644 cmd/net-lwip.c

diff --git a/cmd/Makefile b/cmd/Makefile
index 9bebf321c3..6ab6b16aab 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -128,6 +128,7 @@ endif
 obj-$(CONFIG_CMD_MUX) += mux.o
 obj-$(CONFIG_CMD_NAND) += nand.o
 obj-$(CONFIG_CMD_NET) += net.o
+obj-$(CONFIG_CMD_NET) += net-lwip.o
 obj-$(CONFIG_CMD_NVEDIT_EFI) += nvedit_efi.o
 obj-$(CONFIG_CMD_ONENAND) += onenand.o
 obj-$(CONFIG_CMD_OSD) += osd.o
diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
new file mode 100644
index 0000000000..46fe4f091f
--- /dev/null
+++ b/cmd/net-lwip.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * (C) Copyright 2023 Maxim Uvarov, maxim.uvarov@linaro.org
+ */
+
+#include <common.h>
+#include <command.h>
+#include <console.h>
+#include <display_options.h>
+#include <memalign.h>
+#include <net.h>
+#include <image.h>
+
+#include "net/lwip.h"
+#include "net/ulwip.h"
+
+static int do_lwip_init(struct cmd_tbl *cmdtp, int flag, int argc,
+		      char *const argv[])
+{
+	if (!ulwip_init())
+		return CMD_RET_SUCCESS;
+	return CMD_RET_FAILURE;
+}
+
+static int lwip_empty_tmo(void) { return 0; };
+int (*ulwip_tmo)(void) = lwip_empty_tmo;
+void ulwip_set_tmo(int (*tmo)(void))
+{
+	ulwip_tmo = tmo;
+}
+
+static void ulwip_clear_tmo(void)
+{
+	ulwip_tmo = lwip_empty_tmo;
+}
+
+static void ulwip_timeout_handler(void)
+{
+	eth_halt();
+	ulwip_tmo();
+	net_set_state(NETLOOP_FAIL);	/* we did not get the reply */
+	ulwip_loop_set(0);
+}
+
+int ulwip_loop(void)
+{
+	int ret = CMD_RET_FAILURE;
+
+	ulwip_loop_set(1);
+	if (!net_loop(LWIP))
+		ret = CMD_RET_SUCCESS;
+	ulwip_loop_set(0);
+	return ret;
+}
+
+#if defined(CONFIG_CMD_PING)
+int do_lwip_ping(struct cmd_tbl *cmdtp, int flag, int argc,
+		 char *const argv[])
+{
+	int ret;
+
+	if (argc < 2) {
+		printf("argc = %d, error\n", argc);
+		return CMD_RET_USAGE;
+	}
+
+	ret = ulwip_init();
+	if (ret) {
+		log_err("ulwip_init err %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	printf("Using %s device\n", eth_get_name());
+	printf("pinging addr: %s\n", argv[1]);
+
+	net_set_timeout_handler(1000UL, ulwip_timeout_handler);
+
+	if (ulwip_ping(argv[1])) {
+		printf("ping init fail\n");
+		return CMD_RET_FAILURE;
+	}
+
+	return ulwip_loop();
+}
+#endif /* CONFIG_CMD_PING */
+
+#if defined(CONFIG_CMD_WGET)
+int do_lwip_wget(struct cmd_tbl *cmdtp, int flag, int argc,
+		 char *const argv[])
+{
+	char *url;
+	int ret;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	url = argv[1];
+
+	ret = ulwip_init();
+	if (ret) {
+		log_err("ulwip_init err %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	ret = ulwip_wget(image_load_addr, url);
+	if (ret) {
+		log_err("lwip_wget err %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+
+	return ulwip_loop();
+}
+#endif
+
+#if defined(CONFIG_CMD_TFTPBOOT)
+int do_lwip_tftp(struct cmd_tbl *cmdtp, int flag, int argc,
+		 char *const argv[])
+{
+	char *filename;
+	ulong addr;
+	char *end;
+	int ret;
+
+	switch (argc) {
+	case 1:
+		filename = env_get("bootfile");
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
+			filename = env_get("bootfile");
+		} else {
+			filename = argv[1];
+		}
+		break;
+	case 3:
+		image_load_addr = hextoul(argv[1], NULL);
+		filename = argv[2];
+		break;
+	default:
+		return CMD_RET_USAGE;
+	}
+
+	ret = ulwip_init();
+	if (ret) {
+		log_err("ulwip_init err %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	ret = ulwip_tftp(image_load_addr, filename);
+	if (ret)
+		return ret;
+
+	return ulwip_loop();
+}
+#endif /* CONFIG_CMD_TFTPBOOT */
+
+#if defined(CONFIG_CMD_DHCP)
+int do_lwip_dhcp(void)
+{
+	int ret;
+	char *filename;
+
+	ret = ulwip_init();
+	if (ret) {
+		log_err("ulwip_init err %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	ret = ulwip_dhcp();
+
+	net_set_timeout_handler(2000UL, ulwip_timeout_handler);
+
+	ulwip_loop();
+	if (IS_ENABLED(CONFIG_CMD_TFTPBOOT)) {
+		ulwip_clear_tmo();
+
+		filename = env_get("bootfile");
+		if (!filename) {
+			log_notice("no bootfile\n");
+			return CMD_RET_SUCCESS;
+		}
+
+		ret = ulwip_init();
+		if (ret) {
+			log_err("ulwip_init err %d\n", ret);
+			return CMD_RET_FAILURE;
+		}
+
+		net_set_timeout_handler(20000UL, ulwip_timeout_handler);
+		ulwip_tftp(image_load_addr, filename);
+
+		ret =  ulwip_loop();
+	}
+
+	return ret;
+}
+
+static int _do_lwip_dhcp(struct cmd_tbl *cmdtp, int flag, int argc,
+		char *const argv[])
+{
+	return do_lwip_dhcp();
+}
+#endif /* CONFIG_CMD_DHCP */
+
+#if defined(CONFIG_CMD_DNS)
+int do_lwip_dns(struct cmd_tbl *cmdtp, int flag, int argc,
+		char *const argv[])
+{
+	int ret;
+	char *name;
+	char *varname;
+	int LWIP_ERR_INPROGRESS = -5; /* lwip/err.h */
+
+	if (argc == 1)
+		return CMD_RET_USAGE;
+
+	name = argv[1];
+
+	if (argc == 3)
+		varname = argv[2];
+	else
+		varname = NULL;
+
+	ret = ulwip_init();
+	if (ret) {
+		log_err("ulwip_init err %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	ret = ulwip_dns(name, varname);
+	if (ret == 0)
+		return CMD_RET_SUCCESS;
+	if (ret != LWIP_ERR_INPROGRESS)
+		return CMD_RET_FAILURE;
+
+	net_set_timeout_handler(1000UL, ulwip_timeout_handler);
+
+	return ulwip_loop();
+}
+#endif /* CONFIG_CMD_DNS */
+
+static struct cmd_tbl cmds[] = {
+	U_BOOT_CMD_MKENT(init, 1, 0, do_lwip_init,
+			 "initialize lwip stack", ""),
+#if defined(CONFIG_CMD_PING)
+	U_BOOT_CMD_MKENT(ping, 2, 0, do_lwip_ping,
+			 "send ICMP ECHO_REQUEST to network host",
+			 "pingAddress"),
+#endif
+#if defined(CONFIG_CMD_WGET)
+	U_BOOT_CMD_MKENT(wget, 2, 0, do_lwip_wget, "", ""),
+#endif
+#if defined(CONFIG_CMD_TFTPBOOT)
+	U_BOOT_CMD_MKENT(tftp, 3, 0, do_lwip_tftp,
+			"boot image via network using TFTP protocol\n",
+			"[loadAddress] [[hostIPaddr:]bootfilename]"),
+#endif
+#if defined(CONFIG_CMD_DHCP)
+	U_BOOT_CMD_MKENT(dhcp, 1, 0, _do_lwip_dhcp,
+			"boot image via network using DHCP/TFTP protocol",
+			""),
+#endif
+#if defined(CONFIG_CMD_DNS)
+	U_BOOT_CMD_MKENT(dns, 3, 0, do_lwip_dns,
+			 "lookup dns name [and store address at variable]",
+			 ""),
+#endif
+};
+
+static int do_ops(struct cmd_tbl *cmdtp, int flag, int argc,
+		     char *const argv[])
+{
+	struct cmd_tbl *cp;
+
+	cp = find_cmd_tbl(argv[1], cmds, ARRAY_SIZE(cmds));
+
+	argc--;
+	argv++;
+
+	if (cp == NULL || argc > cp->maxargs)
+		return CMD_RET_USAGE;
+	if (flag == CMD_FLAG_REPEAT && !cmd_is_repeatable(cp))
+		return CMD_RET_SUCCESS;
+
+	return cp->cmd(cmdtp, flag, argc, argv);
+}
+
+U_BOOT_CMD(
+	lwip, 4, 1, do_ops,
+	"LWIP sub system",
+	"init - init LWIP\n"
+	"ping addr - pingAddress\n"
+	"wget http://IPadress/url/\n"
+	"tftp [loadAddress] [[hostIPaddr:]bootfilename]\n"
+	"dhcp - boot image via network using DHCP/TFTP protocol\n"
+	);
-- 
2.30.2

