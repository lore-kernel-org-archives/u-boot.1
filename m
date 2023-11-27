Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CFCC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:03:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11640875C9;
	Mon, 27 Nov 2023 14:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oKmqpuEt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 418D987570; Mon, 27 Nov 2023 14:00:42 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08325875C5
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:00:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507ad511315so5788099e87.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090036; x=1701694836; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XN+2i4v4HChf7Eh1TzVL8+a/6lpRru38mCzvIWotMmQ=;
 b=oKmqpuEtVEcI7wDoSPCHtYMCZeg/djEhDVXuxNVVdbhFYfo1j7lfGao+MDnN1aF6SM
 tH/cfxDVNSauA/61RExHNSB9Yrx3chDIPnJV9rTMJ0m+slenHy1zHKDsrT0EHP57Ud2I
 bU6oOjqh7vVWnDW8vIFC2UJ8LPwDao49poL5viPNw+B7eIHMNY2D/Kavi/GUUwPtSJ+j
 m0QqtYRtUOID1sudv/iCBm78j5crsNuatBPSF6OQt2xVGk5YLfamy2vXlX9L6knF4sTP
 bcBXCpexkI8pu/QPrRjYPpxHSyZSqLip7far/OsR56jLAsG3UAny4mIBpczVrbM3bdQQ
 l09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090036; x=1701694836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XN+2i4v4HChf7Eh1TzVL8+a/6lpRru38mCzvIWotMmQ=;
 b=Txw+GCAFrybiSjgGcWsd//Ax+iKFgxto1nWqBLIAjomYYXbUvQH5jEALS4+68NcleD
 Nmsq41D48FzbJccXCtppAUNO2WUEOGBs7TdDlSmFYEQz/VvwnXa5MvsXYcjIfoAmfGtT
 TkHJpVexGVqY8Y8C2SGAyU271IL0aRvACW4+KmrOgYeRX538AtG2USTuDxEmBGfgVuPd
 jGHAHA++nomGRopd77Ee+c0Qd7ndaFuPvO0FoIxvWhSCJavYJLrwfXATP2ZJt1o3c1ZX
 0Y0TTUW/L+vIb0DbfCqdfmhwaai53r3dXKYtkg70z6BU2+7tKG4VvJP6e4fD/+fk8021
 JFIQ==
X-Gm-Message-State: AOJu0YzCS0HcrWfrMCWcJkZCLOn5aHxslj3O/WYz+zBqVQP9o5Amnp28
 j4EukeTwVzMgOwtu4uNwh9va48u6AYbD2UNpSS1hBA==
X-Google-Smtp-Source: AGHT+IGgRbkStbOunKjRlXQOX2HGplEAqJ8qipy48mHrXV/DRvp6nsywCj9lTifvOF5ihPxCWIUwyQ==
X-Received: by 2002:a19:a404:0:b0:508:17be:c366 with SMTP id
 q4-20020a19a404000000b0050817bec366mr7286810lfc.21.1701090036313; 
 Mon, 27 Nov 2023 05:00:36 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:00:36 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 12/43] net/lwip: connection between cmd and lwip apps
Date: Mon, 27 Nov 2023 18:56:55 +0600
Message-Id: <20231127125726.3735-13-maxim.uvarov@linaro.org>
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

Use lwip variants of network commands.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 cmd/Makefile   |   1 +
 cmd/net-lwip.c | 307 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 308 insertions(+)
 create mode 100644 cmd/net-lwip.c

diff --git a/cmd/Makefile b/cmd/Makefile
index 9a6790cc17..1b28b02844 100644
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
index 0000000000..37b5005da5
--- /dev/null
+++ b/cmd/net-lwip.c
@@ -0,0 +1,307 @@
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
+			char *const argv[])
+{
+	if (!ulwip_init())
+		return CMD_RET_SUCCESS;
+	return CMD_RET_FAILURE;
+}
+
+#if defined(CONFIG_CMD_DHCP) || defined(CONFIG_CMD_DNS)
+static void ulwip_timeout_handler(void)
+{
+	eth_halt();
+	net_set_state(NETLOOP_FAIL);	/* we did not get the reply */
+	ulwip_loop_set(0);
+}
+#endif
+
+#if defined(CONFIG_CMD_DHCP) || defined(CONFIG_CMD_PING) || defined(CONFIG_CMD_DNS) || defined(CONFIG_CMD_WGET) || defined(CONFIG_CMD_TFTPBOOT)
+int ulwip_loop(void)
+{
+	int ret = CMD_RET_FAILURE;
+	struct udevice *udev;
+	struct ulwip *ulwip;
+
+	udev = eth_get_dev();
+	if (!udev)
+		return -1;
+
+	ulwip = eth_lwip_priv(udev);
+
+	ulwip_loop_set(1);
+	if (!net_loop(LWIP))
+		ret = CMD_RET_SUCCESS;
+	ulwip_loop_set(0);
+	net_loop(LWIP);
+	ulwip->active = 0;
+	return ret;
+}
+#endif
+
+#if defined(CONFIG_CMD_PING)
+int do_lwip_ping(struct cmd_tbl *cmdtp, int flag, int argc,
+		 char *const argv[])
+{
+	int ret;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	ret = ulwip_init();
+	if (ret) {
+		log_err("ulwip_init err %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	log_info("Using %s device\n", eth_get_name());
+	log_info("pinging addr: %s\n", argv[1]);
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
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	net_set_timeout_handler(200000UL, ulwip_timeout_handler);
+
+	ret = ulwip_loop();
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	if (IS_ENABLED(CONFIG_CMD_TFTPBOOT)) {
+		if (!env_get_yesno("autoload"))
+			return ret;
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
+			 char *const argv[])
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
+	if (ret != -EINPROGRESS)
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
+			 "boot image via network using TFTP protocol\n",
+			 "[loadAddress] [[hostIPaddr:]bootfilename]"),
+#endif
+#if defined(CONFIG_CMD_DHCP)
+	U_BOOT_CMD_MKENT(dhcp, 1, 0, _do_lwip_dhcp,
+			 "boot image via network using DHCP/TFTP protocol",
+			 ""),
+#endif
+#if defined(CONFIG_CMD_DNS)
+	U_BOOT_CMD_MKENT(dns, 3, 0, do_lwip_dns,
+			 "lookup dns name [and store address at variable]",
+			 ""),
+#endif
+};
+
+static int do_ops(struct cmd_tbl *cmdtp, int flag, int argc,
+		  char *const argv[])
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

