Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAA0C19F32
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:31:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F363581A0F;
	Thu,  6 Mar 2025 01:28:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P3sZl0Fh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6788F81919; Thu,  6 Mar 2025 01:28:14 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AF0A81898
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:28:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-85ad83ba141so8992539f.2
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220865; x=1741825665; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CsK0qnPYelA6Ry7us+PUl40YbKj1m9ha0jKIFjy3TGw=;
 b=P3sZl0FhbII+es0wzoWliy9LdE1aRCSfdpFGPMC2scg5FnsWjSZVmF5ALYjdjpnhOs
 rezKwRJ1KtAcvk7ZPw9DzetR2Bu+80kua0l533YB3fZnX/jZjqqpej9mbgRSe/JNTlDq
 nmVORWhOAqukrJ5D7e0XglNflADoSZypmosNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220865; x=1741825665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CsK0qnPYelA6Ry7us+PUl40YbKj1m9ha0jKIFjy3TGw=;
 b=i60nmU655OgvE2ICu7kgkZyB+g7Wb0GB163vhsPyUsf9QDp0j2APGgFRZHfR0UBN0g
 Km4QezSsCbXLbN/XWwxDrtc2i7kx+67vs9o2QNfHKGYeAlaLTLRUpKyLUI/loDSfMNyu
 pV2E1VBfk2Jfr5WqcpKYr+lPhCQwhFjKpdPnmXNXP2jGJrsnJXw1qLJtiYZhwbO6faMj
 9ljHRD+mkhLNs6KufojCR20LJP73gw+utJfnArLELFo0spoeDGkXFtqs9v0n66JPLtCC
 O42K7/s+WZ9pfYgVviVxqGj43B/uCmUFeIvnfmmwMoL2o5Dx4p3F6nq2A/59MiBPrmyP
 ZASQ==
X-Gm-Message-State: AOJu0YxUerhvCxtQk7/giadLyJg7OcFcsJh8ADkMqc+FHn5LfMwJ9rgY
 e77vFBb57KAJRPUJkEcjiXZjvphZQrByEV/0DT78WlCZuL7tgQXEqr4moFrq2rmi3WgeFxlEBY0
 =
X-Gm-Gg: ASbGncsiO37DXDnhw9QVSULzVOga8YuYdWJNEVGhKtutZlVKyFw5cEbTpcNRNVIS85v
 BllRAc1J/9topwkepPilfwZ1UzGh5FwEMsQMHRw3JzV4V1+oCb/lTxfrJ6iv0DsaHdIqPDIBcSk
 oCE6i3vl6o/X+okekQUhDMA9gY0xQ2SHYRCKY8clnHJWMK9YH0B/+nuX9UHclYX0RaNujP26XYs
 NeUGvIZHgMf+LE3m+bzNEAamkOLxeglBiuj6ga1acJG5U6ioEVSnPfpnB2CmwDFPDEV1X6/Bejs
 7east6a/zUTCiKLMogEWjY3CeKhaHl4xd064qhzDGOIZu/SPlKqE1Ln8lTdE7wVdcHO75iuoLm8
 byrqUNQ==
X-Google-Smtp-Source: AGHT+IFyn++zLANROiBKCQLaJDvU1x4zO1NS2FvH+Tl9jUpwB7vCiUpc5PbWxG9kXhvgMFXQOtJnrQ==
X-Received: by 2002:a05:6602:4a06:b0:85a:e24f:2b60 with SMTP id
 ca18e2360f4ac-85aff89b196mr847125839f.4.1741220865006; 
 Wed, 05 Mar 2025 16:27:45 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:27:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v5 29/29] net: Provide a function to run network operations
Date: Wed,  5 Mar 2025 17:25:23 -0700
Message-ID: <20250306002533.2380866-30-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306002533.2380866-1-sjg@chromium.org>
References: <20250306002533.2380866-1-sjg@chromium.org>
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

Changes in v5:
- Split off the first part into a separate series

 cmd/net.c            | 40 +---------------------------------------
 include/net-common.h | 30 ++++++++++++++++++++++++++++++
 net/net.c            | 44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 39 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index 6d1c6374f76..8f33c9f55d5 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -382,44 +382,6 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[],
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
@@ -475,7 +437,7 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 	}
 
 	size = netboot_run_(proto, addr, fname, save_size, fname_explicit,
-			    use_ip6);
+			    IS_ENABLED(CONFIG_IPV6) && use_ip6);
 	if (size < 0)
 		return CMD_RET_FAILURE;
 
diff --git a/include/net-common.h b/include/net-common.h
index 29d31f37263..210042fc337 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -474,6 +474,36 @@ int net_init(void);
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
index 1828f1cca36..ef97377cdec 100644
--- a/net/net.c
+++ b/net/net.c
@@ -775,6 +775,50 @@ done:
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
2.43.0

