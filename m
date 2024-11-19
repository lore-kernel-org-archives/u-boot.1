Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39193D44157
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:21:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C751A895D0;
	Tue, 19 Nov 2024 14:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mWaciX3T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79EC0895E7; Tue, 19 Nov 2024 14:19:40 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D9598954F
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a75eaaab59so7703805ab.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022376; x=1732627176; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tbf1CIVWWF57w0jmOfLwYx8AHJt4RWX9FArv94FqCv0=;
 b=mWaciX3T7RfyqkqUJyx8ip3wgXPayZ/ZMMRndfOrIyNgJkAph3qZEBiYZvAFDpEoXP
 YNu4OUUIvmAAx+dNL3VECa8jcOfKC7ub/0pXkj538ixGPYylqENERyPrx7mxa5wxI248
 krdSHwjIYawpNiSCqqt1Zh2Zh1wY0XlCvlyJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022376; x=1732627176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tbf1CIVWWF57w0jmOfLwYx8AHJt4RWX9FArv94FqCv0=;
 b=oeHzHGOGGJfo2cv0gnV4kRR9Aoj3i7IvhsGXLa0hwgkG7nnqlEfdntQ/abHkvaRnV6
 OfhWa8sSUuffdGNAuGnoBP8sNXTwa+x32SvJtpCGCVJzxdaZV9pZ3EY+wxqNblAke0Lx
 TaD+QuK9nfSQtu5kmcu9Iw0uuROt8dvi0wXaZbGH3bxLE7uPU8iFAPfrmwUwtkW/GCIs
 ywAPLuEeBdnQM4O5XUTpR2WQ1R/mt6uaa35mtWDUa4WUfOhyro3R3C0ES0yntFskL7QZ
 N0n0ZCyx0hijtEE0RHYMcMS2jM4Bw7muKMPhGfNV7oHK+zo5BEvAtQWJavT55FmslDiu
 SyXg==
X-Gm-Message-State: AOJu0YyjVeq/dcXOqZwWmfhD4BFqi68Q1nat68qwEi07CQhVITPy/7Vw
 TV/YdJgghuvIXhfh79qkkOuR2l4Biuair4eewx3ZknCtowAOlt4eCKbWVYpPfiILLGoPyMqE4Ew
 =
X-Google-Smtp-Source: AGHT+IGusbEQeMDr7XEkCUGyuZRC+rDAiki1H0d1hLQC2TN0c+1yEFxgg3wLTwi4x1zu3Mtj/A5qOw==
X-Received: by 2002:a05:6e02:1c08:b0:3a7:7e8d:9cdc with SMTP id
 e9e14a558f8ab-3a77e8da2d4mr7851665ab.7.1732022376504; 
 Tue, 19 Nov 2024 05:19:36 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:19:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 17/39] net: Simplify parse_args()
Date: Tue, 19 Nov 2024 06:18:22 -0700
Message-Id: <20241119131844.4078144-18-sjg@chromium.org>
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

This function repeats the same code in a few places, namely setting
net_boot_file_name_explicit and copying of the filename to
net_boot_file_name

Move these two operations to the caller, with just the filename (or
NULL) returned by parse_args()

This makes things a little easier to follow.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/net.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index 01332d57b98..7c7489efe4d 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -312,10 +312,6 @@ static int parse_addr_size(char * const argv[])
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
@@ -323,21 +319,20 @@ static int parse_addr_size(char * const argv[])
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
@@ -350,16 +345,10 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
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
@@ -368,9 +357,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 				return 1;
 		} else {
 			image_load_addr = hextoul(argv[1], NULL);
-			net_boot_file_name_explicit = true;
-			copy_filename(net_boot_file_name, argv[2],
-				      sizeof(net_boot_file_name));
+			*fnamep = argv[2];
 		}
 		break;
 
@@ -378,20 +365,20 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
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
@@ -415,11 +402,19 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
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

