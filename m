Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F107CF6D25
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 13:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2F00890C5;
	Wed,  2 Oct 2024 15:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="XGCAsSml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA78B88FEC; Wed,  2 Oct 2024 15:26:47 +0200 (CEST)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [IPv6:2a01:4f8:201:9162::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF40289080
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 15:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martyn.welch@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1727875603;
 bh=gOtH3IcovzYiksgXKK03SnWkdcCwbpCpBDl2ELr+10A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XGCAsSmlDMLyGAAxV1UU7Rsny2WCzLGQKEFCX4Hf6RxaYfpc+tUZ+Vt/wz6+9YBsX
 /Fbq8Fb7/lAX0l1F8FT5qtSFjBG2uGph3F6T0HId1zckdh4H9S4axj55HCsqyEqDPB
 T+W8k15Nq7WH6DVz7FbOtMH02vYcyH4FwlI9N/AJDnDAU/5cirkxms7h9AzHxQmroU
 ZxoYYGuMtml10NZzHR1XoJn+LGjMk9rOSWJgJB/Wli3V6fcZWjcn3ropShaxep7gfu
 aS2Htxct3VhMKNbtipz5NgzKFeIzS0P96Ot5uiPfvVDlQf7r/1XInzaRRBpAJPhobE
 jaex+gSfaD0Xg==
Received: from pan.lan (unknown [IPv6:2a00:23c6:c32f:9100::16d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: martyn)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5228517E35F2;
 Wed,  2 Oct 2024 15:26:43 +0200 (CEST)
From: Martyn Welch <martyn.welch@collabora.com>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Martyn Welch <martyn.welch@collabora.com>
Subject: [PATCH 3/4] bootstd: Add command to enable setting of bootmeth
 specific properties
Date: Wed,  2 Oct 2024 14:26:32 +0100
Message-ID: <20241002132633.246942-3-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002132633.246942-1-martyn.welch@collabora.com>
References: <20241002132633.246942-1-martyn.welch@collabora.com>
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

We have previously added logic to allow a "fallback" option to be
specified in the extlinux configuration. Provide a command that allows
us to set this as the preferred default option when booting.

Combined with the bootcount functionality, this allows the "altbootcmd"
to provide a means of falling back to a previously known good state
after a failed update. For example, if "bootcmd" is set to:

    bootflow scan -lb

We would set "altbootcmd" to:

    bootmeth set extlinux fallback 1; bootflow scan -lb

Causing the boot process to boot from the fallback option.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---
 boot/bootmeth-uclass.c   | 25 ++++++++++++++
 boot/bootmeth_extlinux.c | 73 +++++++++++++++++++++++++++++++++++++++-
 cmd/bootmeth.c           | 25 ++++++++++++--
 include/bootmeth.h       | 31 +++++++++++++++++
 4 files changed, 151 insertions(+), 3 deletions(-)

diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index c0abadef97..5b5fea39b3 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -251,6 +251,31 @@ int bootmeth_set_order(const char *order_str)
 	return 0;
 }
 
+int bootmeth_set_property(const char *name, const char *property, const char *value)
+{
+	int ret;
+	int len;
+	struct udevice *dev;
+	const struct bootmeth_ops *ops;
+
+	len = strlen(name);
+
+	ret = uclass_find_device_by_namelen(UCLASS_BOOTMETH, name, len,
+					    &dev);
+	if (ret) {
+		printf("Unknown bootmeth '%s'\n", name);
+		return ret;
+	}
+
+	ops = bootmeth_get_ops(dev);
+	if (!ops->set_property) {
+		printf("set_property not found\n");
+		return -ENODEV;
+	}
+
+	return ops->set_property(dev, property, value);
+}
+
 int bootmeth_setup_fs(struct bootflow *bflow, struct blk_desc *desc)
 {
 	int ret;
diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index 26c61a65e2..be8fbf4df6 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -21,6 +21,39 @@
 #include <mmc.h>
 #include <pxe_utils.h>
 
+struct extlinux_plat {
+	bool use_fallback;
+};
+
+enum extlinux_option_type {
+	EO_FALLBACK,
+	EO_INVALID
+};
+
+struct extlinux_option {
+	char *name;
+	enum extlinux_option_type option;
+};
+
+static const struct extlinux_option options[] = {
+	{"fallback", EO_FALLBACK},
+	{NULL, EO_INVALID}
+};
+
+static enum extlinux_option_type get_option(const char *option)
+{
+	int i = 0;
+
+	while (options[i].name) {
+		if (!strcmp(options[i].name, option))
+			return options[i].option;
+
+		i++;
+	}
+
+	return EO_INVALID;
+};
+
 static int extlinux_get_state_desc(struct udevice *dev, char *buf, int maxsize)
 {
 	if (IS_ENABLED(CONFIG_SANDBOX)) {
@@ -142,14 +175,18 @@ static int extlinux_boot(struct udevice *dev, struct bootflow *bflow)
 	struct cmd_tbl cmdtp = {};	/* dummy */
 	struct pxe_context ctx;
 	struct extlinux_info info;
+	struct extlinux_plat *plat;
 	ulong addr;
 	int ret;
 
 	addr = map_to_sysmem(bflow->buf);
 	info.dev = dev;
 	info.bflow = bflow;
+
+	plat = dev_get_plat(dev);
+
 	ret = pxe_setup_ctx(&ctx, &cmdtp, extlinux_getfile, &info, true,
-			    bflow->fname, false, false);
+			    bflow->fname, false, plat->use_fallback);
 	if (ret)
 		return log_msg_ret("ctx", -EINVAL);
 
@@ -160,6 +197,38 @@ static int extlinux_boot(struct udevice *dev, struct bootflow *bflow)
 	return 0;
 }
 
+static int extlinux_set_property(struct udevice *dev, const char *property, const char *value)
+{
+	struct extlinux_plat *plat;
+	static enum extlinux_option_type option;
+
+	plat = dev_get_plat(dev);
+
+	option = get_option(property);
+	if (option == EO_INVALID) {
+		printf("Invalid option\n");
+		return -EINVAL;
+	}
+
+	switch (option) {
+	case EO_FALLBACK:
+		if (!strcmp(value, "1")) {
+			plat->use_fallback = true;
+		} else if (!strcmp(value, "0")) {
+			plat->use_fallback = false;
+		} else {
+			printf("Unexpected value '%s'\n", value);
+			return -EINVAL;
+		}
+		break;
+	default:
+		printf("Unrecognised property '%s'\n", property);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int extlinux_bootmeth_bind(struct udevice *dev)
 {
 	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
@@ -176,6 +245,7 @@ static struct bootmeth_ops extlinux_bootmeth_ops = {
 	.read_bootflow	= extlinux_read_bootflow,
 	.read_file	= bootmeth_common_read_file,
 	.boot		= extlinux_boot,
+	.set_property	= extlinux_set_property,
 };
 
 static const struct udevice_id extlinux_bootmeth_ids[] = {
@@ -190,4 +260,5 @@ U_BOOT_DRIVER(bootmeth_1extlinux) = {
 	.of_match	= extlinux_bootmeth_ids,
 	.ops		= &extlinux_bootmeth_ops,
 	.bind		= extlinux_bootmeth_bind,
+	.plat_auto	= sizeof(struct extlinux_plat)
 };
diff --git a/cmd/bootmeth.c b/cmd/bootmeth.c
index ebf8b7e253..2f41fa1bec 100644
--- a/cmd/bootmeth.c
+++ b/cmd/bootmeth.c
@@ -103,10 +103,31 @@ static int do_bootmeth_order(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
+static int do_bootmeth_set(struct cmd_tbl *cmdtp, int flag, int argc,
+			     char *const argv[])
+{
+	int ret;
+
+	if (argc < 4) {
+		printf("Required parameters not provided\n");
+		return CMD_RET_FAILURE;
+	}
+
+	ret = bootmeth_set_property(argv[1], argv[2], argv[3]);
+	if (ret) {
+		printf("Failed (err=%d)\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	return 0;
+}
+
 U_BOOT_LONGHELP(bootmeth,
 	"list [-a]     - list available bootmeths (-a all)\n"
-	"bootmeth order [<bd> ...]  - select bootmeth order / subset to use");
+	"bootmeth order [<bd> ...]  - select bootmeth order / subset to use\n"
+	"bootmeth set <bootmeth> <property> <value> - set optional property");
 
 U_BOOT_CMD_WITH_SUBCMDS(bootmeth, "Boot methods", bootmeth_help_text,
 	U_BOOT_SUBCMD_MKENT(list, 2, 1, do_bootmeth_list),
-	U_BOOT_SUBCMD_MKENT(order, CONFIG_SYS_MAXARGS, 1, do_bootmeth_order));
+	U_BOOT_SUBCMD_MKENT(order, CONFIG_SYS_MAXARGS, 1, do_bootmeth_order),
+	U_BOOT_SUBCMD_MKENT(set, CONFIG_SYS_MAXARGS, 1, do_bootmeth_set));
diff --git a/include/bootmeth.h b/include/bootmeth.h
index 4d8ca48efd..a08ebf005a 100644
--- a/include/bootmeth.h
+++ b/include/bootmeth.h
@@ -146,6 +146,22 @@ struct bootmeth_ops {
 	 *	something changes, other -ve on other error
 	 */
 	int (*boot)(struct udevice *dev, struct bootflow *bflow);
+
+	/**
+	 * set_property() - set the bootmeth property
+	 *
+	 * This allows the setting of boot method specific properties to enable
+	 * automated finer grain control of the boot process
+	 *
+	 * @name: String containing the name of the relevant boot method
+	 * @property: String containing the name of the property to set
+	 * @value: String containing the value to be set for the specified
+	 *         property
+	 * Return: 0 if OK, -ENODEV if an unknown bootmeth or property is
+	 *      provided, -ENOENT if there are no bootmeth devices
+	 */
+	int (*set_property)(struct udevice *dev, const char *property,
+			    const char *value);
 };
 
 #define bootmeth_get_ops(dev)  ((struct bootmeth_ops *)(dev)->driver->ops)
@@ -290,6 +306,21 @@ int bootmeth_setup_iter_order(struct bootflow_iter *iter, bool include_global);
  */
 int bootmeth_set_order(const char *order_str);
 
+/**
+ * bootmeth_set_property() - Set the bootmeth property
+ *
+ * This allows the setting of boot method specific properties to enable
+ * automated finer grain control of the boot process
+ *
+ * @name: String containing the name of the relevant boot method
+ * @property: String containing the name of the property to set
+ * @value: String containing the value to be set for the specified property
+ * Return: 0 if OK, -ENODEV if an unknown bootmeth or property is provided,
+ * -ENOENT if there are no bootmeth devices
+ */
+int bootmeth_set_property(const char *name, const char *property,
+			  const char *value);
+
 /**
  * bootmeth_setup_fs() - Set up read to read a file
  *
-- 
2.45.2

