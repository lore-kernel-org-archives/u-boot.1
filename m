Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24B8C19F32
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:32:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3B0E8197F;
	Thu,  6 Mar 2025 01:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IoWlCzBe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5A65819AA; Thu,  6 Mar 2025 01:28:22 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 453F581878
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:28:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-85afcb0c18fso3497439f.1
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220859; x=1741825659; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fSBtI3ek1sGeOcYPPR1d6WrYkzf5KoT2SDy3QbukChg=;
 b=IoWlCzBe9L6w9dBq8YzAQCi9M5nJsP/uLW8j7+0pRID/n45+9Jx+RMtHzZ/FTY1Jqp
 Io76zNUm4G8jl9buzpuXUTH/bVuTgfK1X0y2+Hyj5pggXYqwl51mIPWA5jbSyQhsfFMK
 sGZyQke2Dh91eXwla3i0qlvoMQsmJ+Q6eJhOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220859; x=1741825659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fSBtI3ek1sGeOcYPPR1d6WrYkzf5KoT2SDy3QbukChg=;
 b=a9lBD444FYaknnoU4hKGAqdwlhd5SAmwAjgJjO/ntUuFE9ewU5iDfseAdACrmksspX
 6OshYRbyyrN+uj9GLOirKWqtxKvUVWLkim/hmWURbq2Ty71HDCfc+1ojeL1dbFjr1yA+
 pcvzCo/eTnf05OEc1bekUPNA4j00Ic60+MrMEIH17vGMcigaQeu1R2tT6OkCfDP40H6P
 AFSp2JSfkFzz3LUSc876U30/XutNQRoTIsp4OVe7NYmQ42IZSu67KLG1xk/EjzgOIVVH
 mfc95KUKHIM75y1tTNvQE1X4ryhWqNxlVYHwRNbFSQct86M2vGAZn8NtsrvD6wsIPOU3
 OuKA==
X-Gm-Message-State: AOJu0Yy+Qez7lwtSJQbK5Yos/aZyN88wD285wwFj2qJWlE5IlATJsnsD
 gOc7Vq0b2Q6sLLZcDuMDNU90NjrRp318DzW4i5Xzm0Wn9zeY+zhlXytO/Yo9ZbFIFlfNRhaVMAA
 =
X-Gm-Gg: ASbGnct5lTeIUSVuMBLjFwGX2ek44dx70gCCy8n0lt0jrhS5f2BX9etdNs5D3b7gkLL
 9Nh796SMQmlfJig/9oSFc/sYerstu0vhXuY0hYIEbgxnEH1dLHvtnlAa8PGTEMBvSxlg/wxMQ3W
 s4VTjYAZ63sX2RzwOpIhycdkkuKVRi7sPYom3A2TVcvbRyL/8I7J4uNEDEcn7gmXjieBjsH5RGY
 9lmh+uP2B+xBlx4jMzCk9vp+BnJzKOGDR9JvSZ6tJn3NAmfuSQhdcqEIe028IB4vejyogXuiTXZ
 shcSsOGgFJyg1qZ9udXyXIdzdi303ZWBBJ6YZ3XpTb24VWcIIcoqpXGFwKWHloJNXUR3uQCW8C4
 I4sDJdw==
X-Google-Smtp-Source: AGHT+IEbFKET9rsjVerOFis3M+kzhMIb68avTtkY4AZnAVKyxZM+MO4W9wA1zUuEUUE1xapdNL2H3Q==
X-Received: by 2002:a05:6602:4fd9:b0:85a:fff5:a1db with SMTP id
 ca18e2360f4ac-85afff5a244mr561441339f.0.1741220859573; 
 Wed, 05 Mar 2025 16:27:39 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:27:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v5 27/29] net: Refactor part of netboot_common() into a
 function
Date: Wed,  5 Mar 2025 17:25:21 -0700
Message-ID: <20250306002533.2380866-28-sjg@chromium.org>
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

Move the core code for starting an netboot operation into a separate
function, so that we can (with additional work) move towards calling it
from outside the file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/net.c | 62 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index 572fa75a72f..f980448e0ef 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -382,11 +382,50 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[],
 	return 0;
 }
 
+static int netboot_run_(enum proto_t proto, ulong addr, const char *fname,
+			ulong size, bool fname_explicit, bool ipv6)
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
 static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 			  char *const argv[])
 {
+	ulong addr, save_size;
+	bool fname_explicit;
 	const char *fname;
-	ulong addr;
 	char *s;
 	int   rcode = 0;
 	int   size;
@@ -410,22 +449,17 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 		}
 	}
 
-	if (parse_args(proto, argc, argv, &fname, &addr, &image_save_size)) {
+	if (parse_args(proto, argc, argv, &fname, &addr, &save_size)) {
 		bootstage_error(BOOTSTAGE_ID_NET_START);
 		return CMD_RET_USAGE;
 	}
-	if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
-		image_save_addr = addr;
-	else
-		image_load_addr = addr;
 
 	if (fname) {
-		net_boot_file_name_explicit = true;
+		fname_explicit = true;
 	} else {
-		net_boot_file_name_explicit = false;
+		fname_explicit = false;
 		fname = env_get("bootfile");
 	}
-	copy_filename(net_boot_file_name, fname, sizeof(net_boot_file_name));
 
 	if (IS_ENABLED(CONFIG_IPV6) && !use_ip6) {
 		char *s, *e;
@@ -440,14 +474,10 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 		}
 	}
 
-	bootstage_mark(BOOTSTAGE_ID_NET_START);
-
-	size = net_loop(proto);
-	if (size < 0) {
-		bootstage_error(BOOTSTAGE_ID_NET_NETLOOP_OK);
+	size = netboot_run_(proto, addr, fname, save_size, fname_explicit,
+			    use_ip6);
+	if (size < 0)
 		return CMD_RET_FAILURE;
-	}
-	bootstage_mark(BOOTSTAGE_ID_NET_NETLOOP_OK);
 
 	/* net_loop ok, update environment */
 	netboot_update_env();
-- 
2.43.0

