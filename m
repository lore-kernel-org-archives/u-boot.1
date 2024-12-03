Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9E3E77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DE8D896E3;
	Wed,  4 Dec 2024 00:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oDhOwb3o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28338896E2; Wed,  4 Dec 2024 00:47:09 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFCFA896D9
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-841a6af60e9so195390839f.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269625; x=1733874425; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1Iq6mSs4INgAob9R3/1RMubhmT6VYYhyvbqf/5X+3w=;
 b=oDhOwb3oS+xkALIy4svgM+X4fEpofcF5cEm/QbFtTQ+20G7MMj2Pj0xG4aOhtrDZRU
 zy+hm23j8oMHJSqqthA24j/3BgMRXB5dj8sG9tFztbVAkaTlAO+X7V2+XDGTN4nU0Lgh
 AfaXMjDFWYlpQnSpM+9kSzjK1s/kXax+oHgWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269625; x=1733874425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1Iq6mSs4INgAob9R3/1RMubhmT6VYYhyvbqf/5X+3w=;
 b=nJN418UB/veexYcbV2o7H27HFfPqJElJYML6OFz6r7z78qEsAU9juXOD8QijXVk5GJ
 ucJy4YMjt8HkH85Is+J4fKvF4x12zYHbQ1K5D0uKAILBri0fcx78YxSPLQ3oyjqj0r/5
 swukV07eN/7xKpxoiAMGOvO8BVM0NQwlYcxbaer0Z7EHBiF0a0/hteMOrCk6udtOe5Gu
 iBF3cbDuwAc+oNU1r85F4ROkbQTFe/WWmDQ99O4mvDkJwxK90Rn0CoAfK6/RGXZDaUHh
 4InNpnrjAVvCYL8g4tT4kG+3Vop+XuOq5apvtOjUs4plAt41FDJQX0uFfA8AQKbRd+tl
 FT2w==
X-Gm-Message-State: AOJu0YzbrGACCW6yjvMYWLoLAP9LTZGPPZfIKSS7gCGw4POSyOWi6QiD
 xEfIOwuyDA/Bs5rvOdBcCapFSYxRauR3YL5Xruv1QI3SUiZ6zaxPm4myqP01/1D34tOb3ramUxQ
 =
X-Gm-Gg: ASbGncuxexdcJwkEUQpdNC0RQ2qXvkqsotoJfRHjYzHN6JQkSHLF9ZTf8cTCaGjqSbg
 yhzomBezQy0+qe24dSJf1U9m0dMlqCmME4KuBBbFSTleoUlvgX3cbESHtkZeIZapFl+gqc4V5IV
 skCM91E4ubg/tngwdzl5phaR+muXjccBZngEQvwNywWyMZ0Q8j/uHIHhylAnSzDtsWM+pM1Kwbp
 ReX6/JgqxahDhmbgDXEbLe+SeoSMEUldrbsfeqM2JkKiwNKwofW9gJnTcb2+Ld4Oa7z76A5opU5
 TS/N1FyP4Bs=
X-Google-Smtp-Source: AGHT+IFr6B0SKAhEVW3k4vIicBCGPeO/U50b/oWgHKCIKS6bYVJ/q6c3AV/9SvNyoYPj4nmhzX4ujg==
X-Received: by 2002:a05:6602:29c8:b0:842:ff2d:c3d2 with SMTP id
 ca18e2360f4ac-8445b5745fbmr570448139f.9.1733269625119; 
 Tue, 03 Dec 2024 15:47:05 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:47:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 19/41] net: Simplify parse_args()
Date: Tue,  3 Dec 2024 16:45:37 -0700
Message-Id: <20241203234559.2938192-20-sjg@chromium.org>
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

This function repeats the same code in a few places, namely setting
net_boot_file_name_explicit and copying of the filename to
net_boot_file_name

Move these two operations to the caller, with just the filename (or
NULL) returned by parse_args()

This makes things a little easier to follow.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/net.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index 89a4d9b38d4..cc7d14eb082 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -314,10 +314,6 @@ static int parse_addr_size(char * const argv[])
  * parse_args() - parse command line arguments
  *
  * Sets:
- *
- * - net_boot_file_name_explicit to true if a filename was specified
- * - net_boot_file_name to that filename, if specified, else the value of the
- *	'bootfile' environment variable
  * - image_load_addr if a load address was provided
  * - image_save_addr and image_save_size, if proto == TFTPPUT
  *
@@ -325,21 +321,20 @@ static int parse_addr_size(char * const argv[])
  * @argc:	number of arguments, include the command, which has already been
  *		parsed
  * @argv:	command line arguments, with argv[0] being the command
+ * @fnamep:	set to the filename, if provided, else NULL
  * Return:	0 on success
  */
-static int parse_args(enum proto_t proto, int argc, char *const argv[])
+static int parse_args(enum proto_t proto, int argc, char *const argv[],
+		      const char **fnamep)
 {
 	ulong addr;
 	char *end;
 
+	*fnamep = NULL;
 	switch (argc) {
 	case 1:
 		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
 			return 1;
-
-		/* refresh bootfile name from env */
-		copy_filename(net_boot_file_name, env_get("bootfile"),
-			      sizeof(net_boot_file_name));
 		break;
 
 	case 2:
@@ -352,16 +347,10 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		 * mis-interpreted as a valid number.
 		 */
 		addr = hextoul(argv[1], &end);
-		if (end == (argv[1] + strlen(argv[1]))) {
+		if (end == (argv[1] + strlen(argv[1])))
 			image_load_addr = addr;
-			/* refresh bootfile name from env */
-			copy_filename(net_boot_file_name, env_get("bootfile"),
-				      sizeof(net_boot_file_name));
-		} else {
-			net_boot_file_name_explicit = true;
-			copy_filename(net_boot_file_name, argv[1],
-				      sizeof(net_boot_file_name));
-		}
+		else
+			*fnamep = argv[1];
 		break;
 
 	case 3:
@@ -370,9 +359,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 				return 1;
 		} else {
 			image_load_addr = hextoul(argv[1], NULL);
-			net_boot_file_name_explicit = true;
-			copy_filename(net_boot_file_name, argv[2],
-				      sizeof(net_boot_file_name));
+			*fnamep = argv[2];
 		}
 		break;
 
@@ -380,20 +367,20 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 	case 4:
 		if (parse_addr_size(argv))
 			return 1;
-		net_boot_file_name_explicit = true;
-		copy_filename(net_boot_file_name, argv[3],
-			      sizeof(net_boot_file_name));
+		*fnamep = argv[3];
 		break;
 #endif
 	default:
 		return 1;
 	}
+
 	return 0;
 }
 
 static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 			  char *const argv[])
 {
+	const char *fname;
 	char *s;
 	int   rcode = 0;
 	int   size;
@@ -417,11 +404,19 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 		}
 	}
 
-	if (parse_args(proto, argc, argv)) {
+	if (parse_args(proto, argc, argv, &fname)) {
 		bootstage_error(BOOTSTAGE_ID_NET_START);
 		return CMD_RET_USAGE;
 	}
 
+	if (fname) {
+		net_boot_file_name_explicit = true;
+	} else {
+		net_boot_file_name_explicit = false;
+		fname = env_get("bootfile");
+	}
+	copy_filename(net_boot_file_name, fname, sizeof(net_boot_file_name));
+
 	if (IS_ENABLED(CONFIG_IPV6) && !use_ip6) {
 		char *s, *e;
 		size_t len;
-- 
2.34.1

