Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86EAE7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:40:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77FC58951F;
	Fri,  6 Dec 2024 03:37:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hd18a1nR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39F6F89629; Fri,  6 Dec 2024 03:37:37 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E706A8918C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:37:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-841a7ae8d8aso107755339f.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452653; x=1734057453; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1Iq6mSs4INgAob9R3/1RMubhmT6VYYhyvbqf/5X+3w=;
 b=Hd18a1nRWQEX2yRkRdpbD3jWCg8mSVXFuO3fo7xv4xaZIEg1fTVq1wZfpXYD0lyNN0
 gZvyv1Ob2mTGsbWTVcCr3Sfl5x7FUwk66j7MCQe5tjRO/VNxmIqqTvpVUtkyaj/aq9cV
 SAxk6J3qrIit5XGuWE/iNHqTm6oFfCaZ47pMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452653; x=1734057453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1Iq6mSs4INgAob9R3/1RMubhmT6VYYhyvbqf/5X+3w=;
 b=pDtuasrsRvDUGbKkaGiRgtsCKaP4q9IpyIzt9tPp9lP/uV1I7w+fgwxCzrgwqcksBD
 fUWoOFBUzm62fIstMhW87Wo+DuXGwK/K+aDQsAxf5XniU3CYkAmiYWDjdJWPn8q1ghdD
 XBz+QyJSYvypNGUUN4UhjohyEMRFSMyDdY3bA4C0WmHkf9pZIqX1gI8XNzw7A9a582Mc
 SJN/RYrrqJjpcsmjW+GB8HhzH9gMfJMBUo1NHVys/Cj7t9xN6Ew/i0iMcLyQ64LXpDCl
 g4FMu8fiRNelGI4cOBoUQkpK603fP24fvIVC9qSwtam8hk3tPlPWJGBSIDPwgTinBqSL
 ScSA==
X-Gm-Message-State: AOJu0Ywq8IarcUF88ako7faqNTGQGMjYD7pZvuCo/CqjkvgcXsh/dEbS
 HoOU1MSoKRxVrFWSABUkxg6zG5ZPyQhwTXCvcJs0MkjBPRLhSP3gO4V7VtJuTf4PhgvDQkA3Kc4
 =
X-Gm-Gg: ASbGncvIB8WyfwW5ctwMbq8kg4OTwFt5rG5Uyb582lfpRqILKMLp5pGcPSci1uWs8Za
 c5Y8V1k55OOckQuZ2xxonphXLc7f3EwOOAacA3q70+p6pDTUPpbQMFJLibQ6Oedic0SV06pTCWf
 ErzIh1RsqmGeDgYWw8nezmEApsn7XJTFsq+q5LbrS15Gs47MfW/DE+rQtY3Zj+4QjhwvOot+iPp
 R1uCijPzyuhp7RTqGL8CF3tydNJVJrC1IoqOpl+3mAmg/31URhVH2wCjUb/nLRSM20eu3VuLjAF
 xdkW0O2qfTI=
X-Google-Smtp-Source: AGHT+IESNYJm0yE1C6xOMvI2cI/PknJB4V6ouLHUxvn3JNKb0sqyt6vFuUavy0dLahsWBSxeg5mESg==
X-Received: by 2002:a05:6602:6c18:b0:83a:b188:7a4d with SMTP id
 ca18e2360f4ac-8447e0da473mr238819039f.0.1733452653176; 
 Thu, 05 Dec 2024 18:37:33 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:37:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v3 23/46] net: Simplify parse_args()
Date: Thu,  5 Dec 2024 19:36:02 -0700
Message-Id: <20241206023626.2456858-24-sjg@chromium.org>
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

