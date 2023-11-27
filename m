Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF3BC07CB1
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A1F687627;
	Mon, 27 Nov 2023 14:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CT1kDOJn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7658D875A1; Mon, 27 Nov 2023 14:00:42 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 979E5875A0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:00:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-507c5249d55so6337783e87.3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090038; x=1701694838; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HXQZA2lweisW6lZDZljhC9dP9YlW/yMvHvEwcbIhoJk=;
 b=CT1kDOJnItPrIgkE8FrQcPZfjAyCZOhFTpm+fiKawL8rXZugXezEadsYtHjh9wYWqU
 xXruUF61V8frpXdIFMvXqj7YZaIST41ktHLGZWJqXyAJKHkmmVVi8cMe/WAOko62csCN
 Adpc1xA6eLBy2GuyWGMCg/+JYrsfs/Zj/xlPr0AAAGL3dhSJqlfoGgp+o8GiRX8zEG+A
 hAnRq6RZNN2W7tvtbqix4xXI/rRtmFyAvOLhI5/RFnfKjQiEPEKl78b9YdKwVJTwXOEQ
 0LhJxlaHfuNbKvLP95lnZqTXbgFTaUKALYmWq4VFmH2Kugw90NyueTr4dWKiJzCEAvQv
 fZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090038; x=1701694838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HXQZA2lweisW6lZDZljhC9dP9YlW/yMvHvEwcbIhoJk=;
 b=WhlERiVXXpBzAkHio1Z3bSUYZVu3n/9Zbjrou3xLGJro9oC2ZnnyVCIizLExN61W0x
 OYmRUJOsyXwfqGLwXlMFpwrsxEygN2Bl5IwWSQtSr0xVOA5fEAIQDBS7DNqgX3xHXBOV
 cTxXX7/E7DFll3DjQyRlk6W2y9V0k0XXzelvOr76e1+LUBGs73Y9hkpDSX4O5+eYDceb
 CdsGlB2st/RZ8Zf4DRHM8YxrOwvSHq0F3OcWFbTdhb+hOiorp/DmnM9F5Wpz/kyHSJZj
 macU4FlXg5nLkmYvZljQerwJpdtttLxwZtgc63UyDfXNkyVlPDlIsNpArmYPDybFtuuw
 s7XA==
X-Gm-Message-State: AOJu0Yx7OFYM3wvtNY2sj3SitThE49EdTr5huJ+N/AFXMjZNDO3nhpYf
 +Wy2jlcDaIP+a3olwCmYPSu4m/Z0ujVba8C9VW+lDA==
X-Google-Smtp-Source: AGHT+IEgtd9iLWSVvTusDhFxjsSFK8AyQZXdyV5JtUnFet8eYR5Uq+v5X5eVsTLBHVcheUxsFEz8Gw==
X-Received: by 2002:ac2:5596:0:b0:50b:adb7:bad1 with SMTP id
 v22-20020ac25596000000b0050badb7bad1mr2948018lfg.11.1701090038621; 
 Mon, 27 Nov 2023 05:00:38 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:00:38 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 13/43] net/lwip: replace original net commands with lwip
Date: Mon, 27 Nov 2023 18:56:56 +0600
Message-Id: <20231127125726.3735-14-maxim.uvarov@linaro.org>
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

Replace original commands: ping, tftp, dhcp and wget.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 boot/bootmeth_efi.c | 18 +++++++---
 boot/bootmeth_pxe.c | 21 ++++++-----
 cmd/net.c           | 86 +++++----------------------------------------
 cmd/pxe.c           | 19 +++++-----
 include/net.h       |  8 +++--
 include/net/ulwip.h | 67 +++++++++++++++++++++++++++++++++++
 6 files changed, 116 insertions(+), 103 deletions(-)
 create mode 100644 include/net/ulwip.h

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index ae936c8daa..52399d627c 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -20,6 +20,8 @@
 #include <mapmem.h>
 #include <mmc.h>
 #include <net.h>
+#include <net/lwip.h>
+#include <net/ulwip.h>
 #include <pxe_utils.h>
 #include <linux/sizes.h>
 
@@ -319,9 +321,7 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 
 static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 {
-	char file_addr[17], fname[256];
-	char *tftp_argv[] = {"tftp", file_addr, fname, NULL};
-	struct cmd_tbl cmdtp = {};	/* dummy */
+	char fname[256];
 	const char *addr_str, *fdt_addr_str;
 	int ret, arch, size;
 	ulong addr, fdt_addr;
@@ -368,7 +368,6 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	if (!fdt_addr_str)
 		return log_msg_ret("fdt", -EINVAL);
 	fdt_addr = hextoul(fdt_addr_str, NULL);
-	sprintf(file_addr, "%lx", fdt_addr);
 
 	/* We only allow the first prefix with PXE */
 	ret = distro_efi_get_fdt_name(fname, sizeof(fname), 0);
@@ -379,7 +378,16 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	if (!bflow->fdt_fname)
 		return log_msg_ret("fil", -ENOMEM);
 
-	if (!do_tftpb(&cmdtp, 0, 3, tftp_argv)) {
+	ret = ulwip_init();
+	if (ret)
+		return log_msg_ret("ulwip_init", ret);
+
+	ret = ulwip_tftp(fdt_addr, fname);
+	if (ret)
+		return log_msg_ret("ulwip_tftp", ret);
+
+	ret = ulwip_loop();
+	if (!ret) {
 		bflow->fdt_size = env_get_hex("filesize", 0);
 		bflow->fdt_addr = fdt_addr;
 	} else {
diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index 8d489a11aa..fc6aabaa18 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -21,6 +21,8 @@
 #include <mapmem.h>
 #include <mmc.h>
 #include <net.h>
+#include <net/ulwip.h>
+#include <net/lwip.h>
 #include <pxe_utils.h>
 
 static int extlinux_pxe_getfile(struct pxe_context *ctx, const char *file_path,
@@ -116,18 +118,21 @@ static int extlinux_pxe_read_file(struct udevice *dev, struct bootflow *bflow,
 				  const char *file_path, ulong addr,
 				  ulong *sizep)
 {
-	char *tftp_argv[] = {"tftp", NULL, NULL, NULL};
-	struct pxe_context *ctx = dev_get_priv(dev);
-	char file_addr[17];
 	ulong size;
 	int ret;
 
-	sprintf(file_addr, "%lx", addr);
-	tftp_argv[1] = file_addr;
-	tftp_argv[2] = (void *)file_path;
+	ret = ulwip_init();
+	if (ret)
+		return log_msg_ret("ulwip_init", ret);
+
+	ret = ulwip_tftp(addr, file_path);
+	if (ret)
+		return log_msg_ret("ulwip_tftp", ret);
+
+	ret = ulwip_loop();
+	if (ret)
+		return log_msg_ret("ulwip_loop", ret);
 
-	if (do_tftpb(ctx->cmdtp, 0, 3, tftp_argv))
-		return -ENOENT;
 	ret = pxe_get_file_size(&size);
 	if (ret)
 		return log_msg_ret("tftp", ret);
diff --git a/cmd/net.c b/cmd/net.c
index d407d8320a..dc5a114309 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -22,6 +22,7 @@
 #include <net/udp.h>
 #include <net/sntp.h>
 #include <net/ncsi.h>
+#include <net/lwip.h>
 
 static int netboot_common(enum proto_t, struct cmd_tbl *, int, char * const []);
 
@@ -40,19 +41,9 @@ U_BOOT_CMD(
 #endif
 
 #ifdef CONFIG_CMD_TFTPBOOT
-int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	int ret;
-
-	bootstage_mark_name(BOOTSTAGE_KERNELREAD_START, "tftp_start");
-	ret = netboot_common(TFTPGET, cmdtp, argc, argv);
-	bootstage_mark_name(BOOTSTAGE_KERNELREAD_STOP, "tftp_done");
-	return ret;
-}
-
 #if IS_ENABLED(CONFIG_IPV6)
 U_BOOT_CMD(
-	tftpboot,	4,	1,	do_tftpb,
+	tftpboot,	4,	1, do_lwip_tftp,
 	"boot image via network using TFTP protocol\n"
 	"To use IPv6 add -ipv6 parameter or use IPv6 hostIPaddr framed "
 	"with [] brackets",
@@ -60,7 +51,7 @@ U_BOOT_CMD(
 );
 #else
 U_BOOT_CMD(
-	tftpboot,	3,	1,	do_tftpb,
+	tftpboot,	3,	1,  do_lwip_tftp,
 	"load file via network using TFTP protocol",
 	"[loadAddress] [[hostIPaddr:]bootfilename]"
 );
@@ -139,7 +130,7 @@ U_BOOT_CMD(dhcp6,	3,	1,	do_dhcp6,
 static int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[])
 {
-	return netboot_common(DHCP, cmdtp, argc, argv);
+	return do_lwip_dhcp();
 }
 
 U_BOOT_CMD(
@@ -196,13 +187,11 @@ U_BOOT_CMD(
 #endif
 
 #if defined(CONFIG_CMD_WGET)
-static int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
-{
-	return netboot_common(WGET, cmdtp, argc, argv);
-}
+int do_lwip_wget(struct cmd_tbl *cmdtp, int flag, int argc,
+		 char *const argv[]);
 
 U_BOOT_CMD(
-	wget,   3,      1,      do_wget,
+	wget,   3,      1, do_lwip_wget,
 	"boot image via network using HTTP protocol",
 	"[loadAddress] [[hostIPaddr:]path and image name]"
 );
@@ -456,28 +445,8 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 }
 
 #if defined(CONFIG_CMD_PING)
-static int do_ping(struct cmd_tbl *cmdtp, int flag, int argc,
-		   char *const argv[])
-{
-	if (argc < 2)
-		return CMD_RET_USAGE;
-
-	net_ping_ip = string_to_ip(argv[1]);
-	if (net_ping_ip.s_addr == 0)
-		return CMD_RET_USAGE;
-
-	if (net_loop(PING) < 0) {
-		printf("ping failed; host %s is not alive\n", argv[1]);
-		return CMD_RET_FAILURE;
-	}
-
-	printf("host %s is alive\n", argv[1]);
-
-	return CMD_RET_SUCCESS;
-}
-
 U_BOOT_CMD(
-	ping,	2,	1,	do_ping,
+	ping,	2,	1, do_lwip_ping,
 	"send ICMP ECHO_REQUEST to network host",
 	"pingAddress"
 );
@@ -601,45 +570,8 @@ U_BOOT_CMD(
 #endif
 
 #if defined(CONFIG_CMD_DNS)
-int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	if (argc == 1)
-		return CMD_RET_USAGE;
-
-	/*
-	 * We should check for a valid hostname:
-	 * - Each label must be between 1 and 63 characters long
-	 * - the entire hostname has a maximum of 255 characters
-	 * - only the ASCII letters 'a' through 'z' (case-insensitive),
-	 *   the digits '0' through '9', and the hyphen
-	 * - cannot begin or end with a hyphen
-	 * - no other symbols, punctuation characters, or blank spaces are
-	 *   permitted
-	 * but hey - this is a minimalist implmentation, so only check length
-	 * and let the name server deal with things.
-	 */
-	if (strlen(argv[1]) >= 255) {
-		printf("dns error: hostname too long\n");
-		return CMD_RET_FAILURE;
-	}
-
-	net_dns_resolve = argv[1];
-
-	if (argc == 3)
-		net_dns_env_var = argv[2];
-	else
-		net_dns_env_var = NULL;
-
-	if (net_loop(DNS) < 0) {
-		printf("dns lookup of %s failed, check setup\n", argv[1]);
-		return CMD_RET_FAILURE;
-	}
-
-	return CMD_RET_SUCCESS;
-}
-
 U_BOOT_CMD(
-	dns,	3,	1,	do_dns,
+	dns,	3,	1,	do_lwip_dns,
 	"lookup the IP of a hostname",
 	"hostname [envvar]"
 );
diff --git a/cmd/pxe.c b/cmd/pxe.c
index 21134eb7a3..8145fbab64 100644
--- a/cmd/pxe.c
+++ b/cmd/pxe.c
@@ -8,6 +8,7 @@
 #include <command.h>
 #include <fs.h>
 #include <net.h>
+#include <net/lwip.h>
 #include <net6.h>
 #include <malloc.h>
 
@@ -29,21 +30,19 @@ const char *pxe_default_paths[] = {
 static int do_get_tftp(struct pxe_context *ctx, const char *file_path,
 		       char *file_addr, ulong *sizep)
 {
-	char *tftp_argv[] = {"tftp", NULL, NULL, NULL};
+	ulong addr;
+	char *end;
 	int ret;
-	int num_args;
 
-	tftp_argv[1] = file_addr;
-	tftp_argv[2] = (void *)file_path;
+	addr = hextoul(file_addr, &end);
+
 	if (ctx->use_ipv6) {
-		tftp_argv[3] = USE_IP6_CMD_PARAM;
-		num_args = 4;
-	} else {
-		num_args = 3;
+		/* @todo: check and fix me, here */
 	}
 
-	if (do_tftpb(ctx->cmdtp, 0, num_args, tftp_argv))
-		return -ENOENT;
+	ret = ulwip_tftp(addr, file_path);
+	if (ret)
+		return log_msg_ret("tftp", ret);
 
 	ret = pxe_get_file_size(sizep);
 	if (ret)
diff --git a/include/net.h b/include/net.h
index e63a946002..ed15064fc1 100644
--- a/include/net.h
+++ b/include/net.h
@@ -56,8 +56,10 @@ struct in_addr {
 	__be32 s_addr;
 };
 
+int do_lwip_dhcp(void);
+
 /**
- * do_tftpb - Run the tftpboot command
+ * do_lwip_tftp - Run the tftpboot command
  *
  * @cmdtp: Command information for tftpboot
  * @flag: Command flags (CMD_FLAG_...)
@@ -65,7 +67,7 @@ struct in_addr {
  * @argv: List of arguments
  * Return: result (see enum command_ret_t)
  */
-int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+int do_lwip_tftp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
 /**
  * dhcp_run() - Run DHCP on the current ethernet device
@@ -516,7 +518,7 @@ extern int		net_restart_wrap;	/* Tried all network devices */
 enum proto_t {
 	BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
 	NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
-	WOL, UDP, NCSI, WGET, RS
+	WOL, UDP, NCSI, WGET, RS, LWIP
 };
 
 extern char	net_boot_file_name[1024];/* Boot File name */
diff --git a/include/net/ulwip.h b/include/net/ulwip.h
new file mode 100644
index 0000000000..1747da8480
--- /dev/null
+++ b/include/net/ulwip.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/**
+ * ulwip_init() - initialize lwIP network stack
+ *
+ * @return 0 if success, !0 if error
+ */
+int ulwip_init(void);
+
+/**
+ * ulwip_active() - check if lwIP network stack was initialized
+ *
+ * @return 1 lwip processing, 0 if not
+ */
+int ulwip_active(void);
+
+/**
+ * ulwip_in_loop() - lwIP controls packet net loop
+ *
+ * @return 1 lwIP owns packet loop, 0 lwip does not own packet loop
+ */
+int ulwip_in_loop(void);
+
+/**
+ * ulwip_loop_set() - make loop to be used by lwIP
+ *
+ * Function is used to make lwIP control network pool.
+ *
+ * @loop: 1. Rx packets go to lwIP 2. Rx packets go to the original stack.
+ */
+void ulwip_loop_set(int loop);
+
+/**
+ * ulwip_exit() - exit from lwIP with a return code
+ *
+ * Exit from lwIP application back to the U-Boot with specific error code.
+ *
+ * @err: Error code to return
+ */
+void ulwip_exit(int err);
+
+/**
+ * ulwip_poll() - polling function to feed lwIP with ethernet packet
+ *
+ * Function takes network packet and passes it to lwIP network stack
+ *
+ * @in_packet:  Pointer to the network packet data
+ * @len: Length of the network packet
+ */
+void ulwip_poll(uchar *in_packet, int len);
+
+/**
+ * ulwip_app_get_err() - return error code from lwIP application
+ *
+ * @return error code
+ */
+int ulwip_app_get_err(void);
+
+/**
+ * ulwip_loop() - enter to packet polling loop
+ *
+ * When lwIP application did it's initialization stage, then it needs to enter
+ * to packet polling loop to grab rx packets.
+ *
+ * Returns:  0 if success, !0 if error
+ */
+int ulwip_loop(void);
-- 
2.30.2

