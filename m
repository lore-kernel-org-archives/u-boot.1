Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E2DC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 12:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ECBB88263;
	Thu, 25 Jul 2024 14:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ie7zh1JW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C33E588263; Thu, 25 Jul 2024 14:59:03 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94BAF87919
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 14:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4272738eb9eso6913655e9.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 05:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721912341; x=1722517141; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ObdJLDoM2TCUQzyM64NPNPwq1f4gb1V8LUAS/4Ap9I=;
 b=ie7zh1JWgbRm9wqIKizfu+i9Sr7ELS07LNDOxRpC/41hqsriXKgzFRXMo0285Dde0e
 Gn5SD0Cncq6T4+pC2BmHCkSlFrx2/S+DLYtyxZGtxFbHpOGZuLBtzs6aQS8VYgg9QasE
 xUQ8NkTNofD1+NemeCqPBPViTnx3Ep4Ykzg3x0eiUckaq+2X01hpSO/FF1uJZN6UkQXL
 NE9SdijZC5n2qy1h2p6Zefz5qodYQDI5Jd8Z4vhg+Q6lmng3XNSvs2nXZAU+C77h8pA1
 suWpaZo/HxdlCWFtYX1fjzrzELz+AE9dz+3L6z1wIzmbkzHbrKY8vliyrGbTQ/xg9tmy
 dsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721912341; x=1722517141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ObdJLDoM2TCUQzyM64NPNPwq1f4gb1V8LUAS/4Ap9I=;
 b=rCeAiM3sdldUoSaXIMeyi45xEZxYom/T8er3NJebMv+BiGyD6m9ScLmcS2ghF/TPyw
 2SOgcedaP45MBGLMJq8ANwvCApg9z0sec6idZY/JDjHK6Giq+FBAkLR1zp8jPS7zF0yp
 +wXMpAPuyaIRyPvkL2Y+ZsqEeobWlklYy/J94DAcCcN7HKsLKM8712wRlWX/uKEEDE75
 uduf4yPB06Ui6uTmItMD3oqdSLciRl38P1fE3tv2x99nMUo6b+UTk1shNhjY/2mn2zFu
 FHFS3AZUu5fefR1W2OIusH6Kf34zMi/zdgbzH6Asva/CDyhr9EbkKyeg5ikimnY9IBIH
 6+Gg==
X-Gm-Message-State: AOJu0YzVl1j1IBfPiMMMSxehaGdQkVeWrDiPsn1rSFJxwqZYc+N7YgtY
 hCrbvNRmMH0dBRnrzV51C8EvGs2MKuZ4e0YPgbMnUVHQzVOpqSLy6Qkw0mx2EuZA6J2pJYajdkl
 fWLDiew==
X-Google-Smtp-Source: AGHT+IGTfbY10Wa3Fow0zF0DKbaDY+QQasPKEUTsawCiN1JdZcxZtEUw71I0cXTZ9YMGT0Hg/oSFGA==
X-Received: by 2002:a05:600c:1d96:b0:426:5983:ed0a with SMTP id
 5b1f17b1804b1-4280573cb8cmr13779645e9.30.1721912340865; 
 Thu, 25 Jul 2024 05:59:00 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:a701:ef5f:d613:3e14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280573fd83sm34765205e9.19.2024.07.25.05.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 05:59:00 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Subject: [PATCH v5 12/20] net: split cmd/net.c into cmd/net.c and
 cmd/net-common.c
Date: Thu, 25 Jul 2024 14:57:33 +0200
Message-Id: <f28efa0115c71e97fbef0bd1a6628e087cd210c1.1721910373.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1721910373.git.jerome.forissier@linaro.org>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
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

Extract some code from cmd/net.c that will be useful in a subsequent
commit to implement wget with NET_LWIP.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/Makefile     |   5 ++-
 cmd/net-common.c | 109 ++++++++++++++++++++++++++++++++++++++++++++
 cmd/net.c        | 115 -----------------------------------------------
 3 files changed, 113 insertions(+), 116 deletions(-)
 create mode 100644 cmd/net-common.c

diff --git a/cmd/Makefile b/cmd/Makefile
index fe733cf6ba9..2c3de45a074 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -130,7 +130,10 @@ obj-$(CONFIG_CMD_NAND) += nand.o
 ifdef CONFIG_CMD_NET
 obj-$(CONFIG_NET) += net.o
 obj-$(CONFIG_NET_LWIP) += net-lwip.o
-CFLAGS_net-lwip.o := -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
+obj-$(filter y,$(CONFIG_CMD_NET) $(CONFIG_CMD_NET_LWIP)) += net-common.o
+lwip-includes := -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
+CFLAGS_net-lwip.o := $(lwip-includes)
+CFLAGS_net-common.o := $(lwip-includes)
 endif
 obj-$(CONFIG_ENV_SUPPORT) += nvedit.o
 obj-$(CONFIG_CMD_NVEDIT_EFI) += nvedit_efi.o
diff --git a/cmd/net-common.c b/cmd/net-common.c
new file mode 100644
index 00000000000..1c9fb83b896
--- /dev/null
+++ b/cmd/net-common.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2000
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ */
+
+#include <command.h>
+#include <dm/device.h>
+#include <dm/uclass.h>
+#include <net.h>
+#include <linux/compat.h>
+#include <linux/ethtool.h>
+
+static int do_net_list(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	const struct udevice *current = eth_get_dev();
+	unsigned char env_enetaddr[ARP_HLEN];
+	const struct udevice *dev;
+	struct uclass *uc;
+
+	uclass_id_foreach_dev(UCLASS_ETH, dev, uc) {
+		eth_env_get_enetaddr_by_index("eth", dev_seq(dev), env_enetaddr);
+		printf("eth%d : %s %pM %s\n", dev_seq(dev), dev->name, env_enetaddr,
+		       current == dev ? "active" : "");
+	}
+	return CMD_RET_SUCCESS;
+}
+
+static int do_net_stats(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	int nstats, err, i, off;
+	struct udevice *dev;
+	u64 *values;
+	u8 *strings;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	err = uclass_get_device_by_name(UCLASS_ETH, argv[1], &dev);
+	if (err) {
+		printf("Could not find device %s\n", argv[1]);
+		return CMD_RET_FAILURE;
+	}
+
+	if (!eth_get_ops(dev)->get_sset_count ||
+	    !eth_get_ops(dev)->get_strings ||
+	    !eth_get_ops(dev)->get_stats) {
+		printf("Driver does not implement stats dump!\n");
+		return CMD_RET_FAILURE;
+	}
+
+	nstats = eth_get_ops(dev)->get_sset_count(dev);
+	strings = kcalloc(nstats, ETH_GSTRING_LEN, GFP_KERNEL);
+	if (!strings)
+		return CMD_RET_FAILURE;
+
+	values = kcalloc(nstats, sizeof(u64), GFP_KERNEL);
+	if (!values)
+		goto err_free_strings;
+
+	eth_get_ops(dev)->get_strings(dev, strings);
+	eth_get_ops(dev)->get_stats(dev, values);
+
+	off = 0;
+	for (i = 0; i < nstats; i++) {
+		printf("  %s: %llu\n", &strings[off], values[i]);
+		off += ETH_GSTRING_LEN;
+	};
+
+	kfree(strings);
+	kfree(values);
+
+	return CMD_RET_SUCCESS;
+
+err_free_strings:
+	kfree(strings);
+
+	return CMD_RET_FAILURE;
+}
+
+static struct cmd_tbl cmd_net[] = {
+	U_BOOT_CMD_MKENT(list, 1, 0, do_net_list, "", ""),
+	U_BOOT_CMD_MKENT(stats, 2, 0, do_net_stats, "", ""),
+};
+
+static int do_net(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	struct cmd_tbl *cp;
+
+	cp = find_cmd_tbl(argv[1], cmd_net, ARRAY_SIZE(cmd_net));
+
+	/* Drop the net command */
+	argc--;
+	argv++;
+
+	if (!cp || argc > cp->maxargs)
+		return CMD_RET_USAGE;
+	if (flag == CMD_FLAG_REPEAT && !cmd_is_repeatable(cp))
+		return CMD_RET_SUCCESS;
+
+	return cp->cmd(cmdtp, flag, argc, argv);
+}
+
+U_BOOT_CMD(
+	net, 3, 1, do_net,
+	"NET sub-system",
+	"list - list available devices\n"
+	"stats <device> - dump statistics for specified device\n"
+);
diff --git a/cmd/net.c b/cmd/net.c
index b206ff58e68..ad5aaf9245e 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -675,118 +675,3 @@ U_BOOT_CMD(
 );
 
 #endif  /* CONFIG_CMD_LINK_LOCAL */
-
-static int do_net_list(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	const struct udevice *current = eth_get_dev();
-	unsigned char env_enetaddr[ARP_HLEN];
-	const struct udevice *dev;
-	struct uclass *uc;
-
-	uclass_id_foreach_dev(UCLASS_ETH, dev, uc) {
-		eth_env_get_enetaddr_by_index("eth", dev_seq(dev), env_enetaddr);
-		printf("eth%d : %s %pM %s\n", dev_seq(dev), dev->name, env_enetaddr,
-		       current == dev ? "active" : "");
-	}
-	return CMD_RET_SUCCESS;
-}
-
-static int do_net_stats(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	int nstats, err, i, off;
-	struct udevice *dev;
-	u64 *values;
-	u8 *strings;
-
-	if (argc < 2)
-		return CMD_RET_USAGE;
-
-	err = uclass_get_device_by_name(UCLASS_ETH, argv[1], &dev);
-	if (err) {
-		printf("Could not find device %s\n", argv[1]);
-		return CMD_RET_FAILURE;
-	}
-
-	if (!eth_get_ops(dev)->get_sset_count ||
-	    !eth_get_ops(dev)->get_strings ||
-	    !eth_get_ops(dev)->get_stats) {
-		printf("Driver does not implement stats dump!\n");
-		return CMD_RET_FAILURE;
-	}
-
-	nstats = eth_get_ops(dev)->get_sset_count(dev);
-	strings = kcalloc(nstats, ETH_GSTRING_LEN, GFP_KERNEL);
-	if (!strings)
-		return CMD_RET_FAILURE;
-
-	values = kcalloc(nstats, sizeof(u64), GFP_KERNEL);
-	if (!values)
-		goto err_free_strings;
-
-	eth_get_ops(dev)->get_strings(dev, strings);
-	eth_get_ops(dev)->get_stats(dev, values);
-
-	off = 0;
-	for (i = 0; i < nstats; i++) {
-		printf("  %s: %llu\n", &strings[off], values[i]);
-		off += ETH_GSTRING_LEN;
-	};
-
-	return CMD_RET_SUCCESS;
-
-err_free_strings:
-	kfree(strings);
-
-	return CMD_RET_FAILURE;
-}
-
-static struct cmd_tbl cmd_net[] = {
-	U_BOOT_CMD_MKENT(list, 1, 0, do_net_list, "", ""),
-	U_BOOT_CMD_MKENT(stats, 2, 0, do_net_stats, "", ""),
-};
-
-static int do_net(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct cmd_tbl *cp;
-
-	cp = find_cmd_tbl(argv[1], cmd_net, ARRAY_SIZE(cmd_net));
-
-	/* Drop the net command */
-	argc--;
-	argv++;
-
-	if (!cp || argc > cp->maxargs)
-		return CMD_RET_USAGE;
-	if (flag == CMD_FLAG_REPEAT && !cmd_is_repeatable(cp))
-		return CMD_RET_SUCCESS;
-
-	return cp->cmd(cmdtp, flag, argc, argv);
-}
-
-U_BOOT_CMD(
-	net, 3, 1, do_net,
-	"NET sub-system",
-	"list - list available devices\n"
-	"stats <device> - dump statistics for specified device\n"
-);
-
-#if defined(CONFIG_CMD_NCSI)
-static int do_ncsi(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
-{
-	if (!phy_interface_is_ncsi() || !ncsi_active()) {
-		printf("Device not configured for NC-SI\n");
-		return CMD_RET_FAILURE;
-	}
-
-	if (net_loop(NCSI) < 0)
-		return CMD_RET_FAILURE;
-
-	return CMD_RET_SUCCESS;
-}
-
-U_BOOT_CMD(
-	ncsi,	1,	1,	do_ncsi,
-	"Configure attached NIC via NC-SI",
-	""
-);
-#endif  /* CONFIG_CMD_NCSI */
-- 
2.40.1

