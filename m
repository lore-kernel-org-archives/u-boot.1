Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AFAE77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1EDF896F9;
	Wed,  4 Dec 2024 00:47:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K4I3w6br";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DADE78967C; Wed,  4 Dec 2024 00:47:20 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A23C3896E9
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:47:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a7def51c9cso15738695ab.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269636; x=1733874436; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1iSLRxEmx5EzvBCuLgq4Mu5ho7dzmKpouUz9dyWfVWU=;
 b=K4I3w6brLq/6glMVAm/+TZbennxJ4G7cgMzNJwwceHZkv159mKf63ymz9y+4MqfVHd
 Voy0maP8J0yyro3t6hYZx/h9DFWjQ9+Ja7zPiMcJcnH6KMzUf7lBZFgmkC63d/P5h+YK
 Q2XnGVn6oSZAPLh9xo/YIQ6zCswkVttnFv0W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269636; x=1733874436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1iSLRxEmx5EzvBCuLgq4Mu5ho7dzmKpouUz9dyWfVWU=;
 b=eBIk/SM1B/xSdvaYIHME/TS6Tjpc2ZNQGW98Bzjbyb7eayVtGaikx7xBuxo3rHoRNl
 sa4lWW+u5f1oYZZmTBM22+tL+apqmQZvIQ3n2tAmbZTKVP6jOAR/QRx79rYtZXM4IbeS
 b3d3axyimV1leHhj02IGnfm2vJgT13DflaO9lAraGQsd1qa/R5cIY6wz8mo0/MS4I5Tl
 jKZVWqgqk8Gm+VrZvnYigucqTbjZ39yF6BmaFkTq+FUgB+/rBVEYs8cbrWDqBjiSDD6W
 ZwoMGWIbQT70dht04pTu9pRZQPKp+u74p4SW1QAnIY0oE2DLP1ctYLBlWH52/DuBTc1L
 EC7w==
X-Gm-Message-State: AOJu0YxgUjRs+nZh2PtPItj8kq2zXVKe0qZFypT1W/sr3PaDXGvM2M+y
 slv1xIyrDhWsgRX7yZ/wN17A1LE22U1Kl5lkBPzkheAVvK0llawagg7+6Y0/ThRz/bIc92s4R9M
 =
X-Gm-Gg: ASbGnctZL8tm/G640FaGWZEMVfa3AazmsNeyLYm/PeG2KZcvalahM1LgPF5RTqV4ROm
 8zyLg9jHH8So2BnpGBKj9KPXpJu2NNCkfRIAv5IxCrIX1iu0c6V2ryDkmAQnMYY0ksEY3CjAosE
 m7sQKZjZaq0RqGFC5cZWqPEkPBF21/eSXiwZdseRAhERM3gdh1QUJuXIb3dHEZnqUOJO8ppnZWp
 21zVwtkwn4d4MnpKcvnMIOAAEOuRiwjMn+oTLwbzfVTPzNolDs5kxcUiPXqFLzUknaDcSnR/9wf
 qLueM6fFmQc=
X-Google-Smtp-Source: AGHT+IGE0FthsmM8l/AQ9J5GeFI3WXwUcBXe8+ZtMza9S39Udi0Nbvb1YEHtVvy7a/NDg56ose65ig==
X-Received: by 2002:a05:6602:6b19:b0:842:ff2d:c3bb with SMTP id
 ca18e2360f4ac-8445b55af5fmr539375039f.6.1733269636312; 
 Tue, 03 Dec 2024 15:47:16 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:47:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 23/41] net: Refactor part of netboot_common() into a
 function
Date: Tue,  3 Dec 2024 16:45:41 -0700
Message-Id: <20241203234559.2938192-24-sjg@chromium.org>
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
2.34.1

