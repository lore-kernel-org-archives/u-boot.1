Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E63E77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 972CB896AE;
	Wed,  4 Dec 2024 00:47:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ezTYSUhy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8324D896AE; Wed,  4 Dec 2024 00:47:25 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AF9B88F55
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-841a9366b5eso226078539f.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269641; x=1733874441; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5TwS9qRWHoTpsyIwbNPowt9I677j4M2uGdbGNTrn7Fw=;
 b=ezTYSUhytOXZpHNhn9WIyelpElsQUUAVGZwYmkNwKpXdHEdC1sDSVATfSJ0BRlbgIJ
 BIpUmGn/loRy0xuXPU7qixTV4VK/zDKRNn15wP4/KP7CTEoQCT/9DLYSmHTek31SEsGn
 icmnjEE+ps74AZOeFE8tjlXA54J9v2LtLkEXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269641; x=1733874441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5TwS9qRWHoTpsyIwbNPowt9I677j4M2uGdbGNTrn7Fw=;
 b=iWefwrcsSrlkO3uwLA00VONcE88LKsQEK4O7F9/70DS0y5PQ+TNzYMub+Iu3jGnMo5
 nZPFHxdVVSVxuSPzD4maEVSXxP3MS58akCOgRHQTL/7mkBW85yp+wL7clwGOWgV0JDnP
 iXGfjEBSjyiKq29Wktazw4s0dPP7oZZYEhd095qnsI3COg+YGSICS9b6eBGx96jtbk//
 1CN1Y3Qb7svwSj+v0ug1FCt0zYkv6A+LTWtQDHg90dU9HNrgMPBsgj27pstEvrPVNlKe
 wL4B45fVZ2vDF9KsPoGUxZKZ3CLtGUt0EvvcOrresDY2vqSfhAYy8saeiQcedqUXnLMt
 1LPA==
X-Gm-Message-State: AOJu0YyzaI4tpHOP6ss29l7GTAzJI6NnrffY+aSz2AxUFMeEbwEW3XZU
 TjE/kkYKmoUPoaXXGA5KyX9xMjce4zn0rhf0wZxUGbSLucS3Kqzrc7EywQ011HduT6C4pQEd6fw
 =
X-Gm-Gg: ASbGncsW4DYVdy1HR35yggrA0PexwdgXIWRo0Z6o5M/A3OlPKumD0uWPFOU+nakrkPq
 cbtElS6ah+R0wEpn9KXjmAtJ3hq2lxOb8G+TYZvPjkqznRB8QqVP33YRwBrIGCuTM48fDoPBkmR
 Pl5DskLoU4LUHTI4G2mEy8XbzS3a7FcZfRn/PKLKbPeQVofrcFc+JpAIgbfQtYRuNCZ9Ajap9PY
 rvjPpRhNLNcBLcvUsDmD3Egx0ddGN45JSnvvrWqCn3F++aoHr0IZ93vDrnrUC9Fy8EKSMp4K65y
 QnBkxlGV8vg=
X-Google-Smtp-Source: AGHT+IGma7vQe74HWEbjZcp3nDebkX1ouMKiyqKHLStu35UtT5ghIcliDignEwZQpIkWyxkaZAaRgQ==
X-Received: by 2002:a05:6602:1649:b0:841:9b5c:cfb3 with SMTP id
 ca18e2360f4ac-8445b5c665amr440593239f.10.1733269641480; 
 Tue, 03 Dec 2024 15:47:21 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:47:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2 25/41] net: Provide a function to run network operations
Date: Tue,  3 Dec 2024 16:45:43 -0700
Message-Id: <20241203234559.2938192-26-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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

(no changes since v1)

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
index c5e314b360d..12c50e2a41e 100644
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
index ca35704f661..da98460a667 100644
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

