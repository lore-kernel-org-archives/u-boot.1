Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDBFD44157
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1296589603;
	Tue, 19 Nov 2024 14:19:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cTmzHHdn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C16488954F; Tue, 19 Nov 2024 14:19:57 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89B81895EA
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:19:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a77fcc787fso1047805ab.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022394; x=1732627194; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eV3BYvIrlc1Fyb9PlH8Cm7wB42myzV1diYSsehGAAig=;
 b=cTmzHHdngirt5AdMWjOu28dqD7Y+T/xM9ebzhAxzyJ1ZGgTCf/Ruz+izC/TZTjbiVI
 Aa3gp139iQxR8dIvmB04M8Q3IW8IzcbLnEYxc8BtEeSSNnsAtd2NlpFCGNbgkX+bFNJx
 3/UHBv/z6JRgZAJ9XcFF9kdewPE6UBiH60jzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022394; x=1732627194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eV3BYvIrlc1Fyb9PlH8Cm7wB42myzV1diYSsehGAAig=;
 b=Kt8KsxSYmqSGtyDiHDA0NvOqOCAIBNohY6t+Z1h5GxwK28cDzW5Ezs6qkNMRN2YPao
 d3irAMX/7EchTBoIHfhDvPdIPLki1JOSdb8Xn8iyC2WbVN8NhWsvS6X6kparl64lFC9I
 NgwOGao90FOc+IalOwofwYuy5VI76AhE7wQ4fI6Dr1PyYhFW9JOQZA7wKmAhPpErWM/Y
 L58E6wGoBqpUMwZQd+pAgrVUoco1DzqK2QcGr7BcUZ+7GEYQo3lih5DocWHfT54YF5Rh
 8z9bAxqVtZRD80bpJ+QMmW8+i8jeYhwJLy1p7EsDc9wGVUFvWRWpUfh8OeGVeIwVjzZl
 9epw==
X-Gm-Message-State: AOJu0YwmBkRxUxP64OCafE4AbtLBtCmlY+Jq5TxuVXSBVCzJgH3eDrBR
 VWqivuZN19Uh4Zi7clOMBE4cJqd+uWUoA9xiH9nlidxhMgAUNdxuBS+aGocZUXD3SSN+yumzSiA
 =
X-Google-Smtp-Source: AGHT+IF8Tm0lEbqa16LOmtnVX98s1O3zrPoXh9yHhkQePVt6lEdRIS6fXVG/cmzxsXHxOSwkYEcz4A==
X-Received: by 2002:a05:6e02:19ce:b0:3a7:1a65:2fbc with SMTP id
 e9e14a558f8ab-3a74808cc28mr191195415ab.23.1732022393673; 
 Tue, 19 Nov 2024 05:19:53 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:19:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH 23/39] net: Provide a function to run network operations
Date: Tue, 19 Nov 2024 06:18:28 -0700
Message-Id: <20241119131844.4078144-24-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
References: <20241119131844.4078144-1-sjg@chromium.org>
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

Add a new netboot_run() function which can be used for simple network
operations, such as loading a file. Put the implementation in an
internal function, used by the existing code.

Place this function into the net/ code, so that it does not need the
command line to be available.

Document which network operations are supported, i.e. a limited subset,
for now.

For the one board which uses lwip, it is not quite clear how to avoid
using the cmdline interface. This will need some discussion.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/net.c            | 40 +---------------------------------------
 include/net-common.h | 30 ++++++++++++++++++++++++++++++
 net/net.c            | 44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 39 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index 03b33aa1f20..8ae4639ecb4 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -380,44 +380,6 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[],
 	return 0;
 }
 
-static int netboot_run_(enum proto_t proto, ulong addr, const char *fname,
-			ulong size, bool fname_explicit, bool ipv6)
-{
-	int ret;
-
-	bootstage_mark(BOOTSTAGE_ID_NET_START);
-
-	/*
-	 * For now we use the global variables as that is the only way to
-	 * control the network stack. At some point, perhaps, the state could be
-	 * in a struct
-	 */
-	if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
-		image_save_addr = addr;
-	else
-		image_load_addr = addr;
-
-	net_boot_file_name_explicit = fname_explicit;
-	copy_filename(net_boot_file_name, fname, sizeof(net_boot_file_name));
-	if (IS_ENABLED(CONFIG_IPV6))
-		use_ip6 = ipv6;
-	if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
-		image_save_addr = addr;
-		image_save_size = size;
-	} else {
-		image_load_addr = addr;
-	}
-
-	ret = net_loop(proto);
-	if (ret < 0) {
-		bootstage_error(BOOTSTAGE_ID_NET_NETLOOP_OK);
-		return ret;
-	}
-	bootstage_mark(BOOTSTAGE_ID_NET_NETLOOP_OK);
-
-	return 0;
-}
-
 static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 			  char *const argv[])
 {
@@ -473,7 +435,7 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 	}
 
 	size = netboot_run_(proto, addr, fname, save_size, fname_explicit,
-			    use_ip6);
+			    IS_ENABLED(CONFIG_IPV6) && use_ip6);
 	if (size < 0)
 		return CMD_RET_FAILURE;
 
diff --git a/include/net-common.h b/include/net-common.h
index 524ed4ad131..839d82f7d1f 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -463,6 +463,36 @@ int net_init(void);
 enum proto_t;
 int net_loop(enum proto_t protocol);
 
+/* internal function: do not use! */
+int netboot_run_(enum proto_t proto, ulong addr, const char *fname, ulong size,
+		 bool fname_explicit, bool ipv6);
+
+/**
+ * netboot_run() - Run a network operation
+ *
+ * The following proto values are NOT supported:
+ *	PING, since net_ping_ip cannot be set
+ *	NETCONS, since its parameters cannot bet set
+ *	RS, since first_call cannot be set, along with perhaps other things
+ *	UDP, since udp_ops cannot be set
+ *	DNS, since net_dns_resolve and net_dns_env_var cannot be set
+ *	WGET, since DNS must be done first and that is not supported
+ *	DHCP6, since the required parameters cannot be passed in
+ *
+ * To support one of these, either add the required arguments or perhaps a
+ * separate function and a struct to hold the information.
+ *
+ * @proto: Operation to run: TFTPGET, FASTBOOT_UDP, FASTBOOT_TCP, BOOTP,
+ *	TFTPPUT, RARP, NFS, DHCP
+ * @addr: Load/save address
+ * @fname: Filename
+ * @size: Save size (not used for TFTPGET)
+ * @ipv6: true to use IPv6, false to use IPv4
+ * Return 0 on success, else -ve error code
+ */
+int netboot_run(enum proto_t proto, ulong addr, const char *fname, ulong size,
+		bool ipv6);
+
 /**
  * dhcp_run() - Run DHCP on the current ethernet device
  *
diff --git a/net/net.c b/net/net.c
index f47e9fbe33a..0a1b477bbf8 100644
--- a/net/net.c
+++ b/net/net.c
@@ -770,6 +770,50 @@ done:
 	return ret;
 }
 
+int netboot_run_(enum proto_t proto, ulong addr, const char *fname, ulong size,
+		 bool fname_explicit, bool ipv6)
+{
+	int ret;
+
+	bootstage_mark(BOOTSTAGE_ID_NET_START);
+
+	/*
+	 * For now we use the global variables as that is the only way to
+	 * control the network stack. At some point, perhaps, the state could be
+	 * in a struct
+	 */
+	if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		image_save_addr = addr;
+	else
+		image_load_addr = addr;
+
+	net_boot_file_name_explicit = fname_explicit;
+	copy_filename(net_boot_file_name, fname, sizeof(net_boot_file_name));
+	if (IS_ENABLED(CONFIG_IPV6))
+		use_ip6 = ipv6;
+	if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
+		image_save_addr = addr;
+		image_save_size = size;
+	} else {
+		image_load_addr = addr;
+	}
+
+	ret = net_loop(proto);
+	if (ret < 0) {
+		bootstage_error(BOOTSTAGE_ID_NET_NETLOOP_OK);
+		return ret;
+	}
+	bootstage_mark(BOOTSTAGE_ID_NET_NETLOOP_OK);
+
+	return 0;
+}
+
+int netboot_run(enum proto_t proto, ulong addr, const char *fname, ulong size,
+		bool ipv6)
+{
+	return netboot_run_(proto, addr, fname, size, true, ipv6);
+}
+
 /**********************************************************************/
 
 static void start_again_timeout_handler(void)
-- 
2.34.1

