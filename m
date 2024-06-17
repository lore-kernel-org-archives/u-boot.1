Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3BBC2BA15
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 15:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4995E883EB;
	Mon, 17 Jun 2024 17:33:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iNRy8f7n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FDAC883B6; Mon, 17 Jun 2024 17:33:49 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CB13883B6
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 17:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-421d32fda86so46793775e9.0
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 08:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718638426; x=1719243226; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3qbyK31RMThpiUrcrmeTE01WYxS4Fh/X83z+XOCuec=;
 b=iNRy8f7nHG8wOCQvbDaqOzkSNBnuswSdxWh6w6Q1iFkDP3banKCuEXqGvkK0r6pEeO
 BAvE4h24Q5bmor72jINFx0dgrjt/ExwE+8UjKgESKKqh6uGgRlo1EnwvRZ2qq5VWHDp8
 +1QGXoaJtvF4vkAjX54ko9GuA8x5S7Gg4w2DxIPeWqj9wzny4fLKmyoni9ppijC59h4R
 VlhpgMFv+k0977saSclCdxbtIyCadTxRIIKwPlylbKY3cHWTuoKveV0Jg50FgcWtNfvU
 ntMY5gcABu+n7ckH8N3RQXpWgJC5jkuf55SeFh/eaNw0+EM4/DdSdvUBwIYMEQ8jcMSU
 eK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718638426; x=1719243226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m3qbyK31RMThpiUrcrmeTE01WYxS4Fh/X83z+XOCuec=;
 b=R3uuhHz23QwX82KjN0zLeqpZOR9ensicFWOURqy/U/VDhohMJj5etz4J13TCQRt9yx
 Ysu6nCvJRM6ixq9rX4XFyizBSe/KwiO5RkBE80EyUxD7runht2Eb8XZEVwzrAjhVL13/
 4QGOTwD5Io21S3Yr+iiPGYnMl8S5seGx369saHIBIbDbRCHb8hh+e4jXDmisoXc007JK
 7lto+8xgqAd39VKzi2Gnn+GFLA6wOaa+DxFXj84GR2AzC9qRKDL+k+XSVopSIRwXNF+d
 3uhkxFMSkmPY0PpfRLdumDWmWt2XK2Vb34mei1gYPBK8OgL7dbDh6YD43y7BgYZh2Z9n
 0NmQ==
X-Gm-Message-State: AOJu0Yypj6IRHglOOdBeDmH2ahbuPVLoME4GojcY57AYeCLYc/9RSU92
 IaaRUNubyC8KvZrWW0gV3bjGEK7c2ImK0V2raY6sYyI0YiAApzFgRPp4fnlR+qQbjzibcB3uWRS
 P6q4=
X-Google-Smtp-Source: AGHT+IFLzCXChFrZtSNtCDNWn2EuF3SFlbfQfCdyUlX16JJwyKz4zj31lmw40R9M2UNzq6ZjM0iFPw==
X-Received: by 2002:a05:600c:154f:b0:422:7a16:6986 with SMTP id
 5b1f17b1804b1-42304820b5fmr87521175e9.9.1718638426336; 
 Mon, 17 Jun 2024 08:33:46 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6e75:be8f:56ae:2b5e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f602f620sm161350895e9.19.2024.06.17.08.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 08:33:46 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v4 09/14] net: split cmd/net.c into cmd/net.c and
 cmd/net-common.c
Date: Mon, 17 Jun 2024 17:33:01 +0200
Message-Id: <890c609387330d691d8c19dd9d56b87e69bc57e5.1718638104.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1718638104.git.jerome.forissier@linaro.org>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
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
index 535b6838ca5..e90f2f68211 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -129,8 +129,11 @@ obj-$(CONFIG_CMD_MUX) += mux.o
 obj-$(CONFIG_CMD_NAND) += nand.o
 obj-$(CONFIG_CMD_NET) += net.o
 obj-$(CONFIG_CMD_NET_LWIP) += net-lwip.o
+obj-$(filter y,$(CONFIG_CMD_NET) $(CONFIG_CMD_NET_LWIP)) += net-common.o
 ifdef CONFIG_CMD_NET_LWIP
-CFLAGS_net-lwip.o := -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
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
index d407d8320a3..03b4582204f 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -676,118 +676,3 @@ U_BOOT_CMD(
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

