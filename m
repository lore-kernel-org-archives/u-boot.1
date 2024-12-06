Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700ADE7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2BBA89629;
	Fri,  6 Dec 2024 03:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JNwPd9VZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F36D48918C; Fri,  6 Dec 2024 03:37:52 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81E5A89639
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3a814831760so320205ab.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452669; x=1734057469; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tTkBwhrC1LPXtT0zrlJsSb3uQn27kt+msnO3TO925OI=;
 b=JNwPd9VZJdJzd6gxg0J8Ikxk/SwGRzbuB4zHmRcbe1ctpoUhqXEvsQcPFz7iRrkBEl
 5E7L6XRLpo7Nvs39068HYivsJZz3Tnin2Dhpg0MxPkTckF4N0Kfs797OZdLRks2jQf8G
 bcDcx7lr0aMvoYkZ/WCz8dBFnCf1A440dOMzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452669; x=1734057469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tTkBwhrC1LPXtT0zrlJsSb3uQn27kt+msnO3TO925OI=;
 b=jDamwHyl5VqNQ24DQVFa1INAkN2FgOAFAOxLWmpGlvEef3/U8C923j046sHl7n6J6i
 mzBMq9Fist9CQ4AItSXGunQ3plmQELgcDLf5cfSLFGP6mGC904t3IqhFHQajQn1kxJCW
 edwCyLJz94T8tHmA/CVF9Wmm8xbG7nGPN3xgtpjj6CMcytSW9tP34Amtb2DETDMqwN9V
 POSlr2/gEnzWUahS8HEztncO9qyiG2U9BhKhje0hStpIRT3GVGTty3OiL+k2mYa+DtJ9
 K7MQV80usTqrDUREpHMPteJSKjJwEslPGdSQkDGs65VeKg9ysnAhA3hn4MdJslJMZifU
 wlXg==
X-Gm-Message-State: AOJu0YwKgca8qRq3a5FG7alzQwcZ6IbWDgCXYwn7NxoujyyCpe6oFH18
 t7fYDl424xdsvoLWSny8go3UUE688npNaz1p/zPjm0yiKu7nDVYBad2oSNFdUm0t8YXkb4QveeM
 =
X-Gm-Gg: ASbGnctbZAqp27B2WWV6QTiWOGSoi4ZRV/KJy+NhX/4dYeIZrdhFW5X4uSWj0KD9aH0
 T9vemcbFHAB4MetQI2f6KlzU/jB9wO9BVAKkaZHeDRfl8tkzlEJ+VT47Tag2aB87TcUx5/RJn4p
 u08lt7ZRMe54GUYCE4jGc0unL5a/0Y5A+HVxesW1Qhrkle6QGvS0aZ8pE293IR/aWh7drQkqQ7S
 kQYzd2dAmLSfRJ10jkrTWhGwkGy0lLmavg+It7kFpCFwWCe68oR6WMgZwKW8D9tIoexRjz0D9YP
 1Qr/OFY+5+I=
X-Google-Smtp-Source: AGHT+IG4y0KFLyRyLTdX0LTVmydyCRNnGsCQ8Le1KNjs0flBPf3F/JQ27CNnJXt7FJCZeGbblOcQJg==
X-Received: by 2002:a05:6e02:1b0e:b0:3a7:e732:471f with SMTP id
 e9e14a558f8ab-3a811d7731bmr22385085ab.1.1733452668761; 
 Thu, 05 Dec 2024 18:37:48 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:37:47 -0800 (PST)
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
Subject: [PATCH v3 29/46] net: Provide a function to run network operations
Date: Thu,  5 Dec 2024 19:36:08 -0700
Message-Id: <20241206023626.2456858-30-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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
index 93154f05c44..556ab347cc9 100644
--- a/net/net.c
+++ b/net/net.c
@@ -737,6 +737,50 @@ done:
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

