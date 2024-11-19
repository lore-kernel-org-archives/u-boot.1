Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494E0D44157
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:22:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB08B895F4;
	Tue, 19 Nov 2024 14:19:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RrjhZD4G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CCB08959D; Tue, 19 Nov 2024 14:19:48 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B4BF8954F
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:19:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a777fd574bso3721125ab.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022384; x=1732627184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6YuZbEVanAWkF2egJKfwozVwGw+/BbhZamLjm8PHR0=;
 b=RrjhZD4GuSW6s/R7u/YISKQSEMlKbNWyksneqwYthl3ppk5lpwF8HR6Zq8Q+jTOvoC
 OWi3SPxnDu6MuKHWeDDy4JFI8ZVvLGHGKZAH9G+pPEoj+JapPgQ6VDLx6pN40K1knnIM
 Hz5KryKOu06EZiE7mKmL8Cfvf8zqnWp9mwG7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022384; x=1732627184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f6YuZbEVanAWkF2egJKfwozVwGw+/BbhZamLjm8PHR0=;
 b=Ydq5acK89Hn1uaMwHrb4YRdvCWNtup0bZ0e/RfWDLuVjDS1sSxWri4YiOHyIgz64Ji
 qnrfEvyTeDK5xXaumcoAPSPxwqOg1wQDmU28aq/Ms7b6Bo3NzjTWi6qhEum0+kECG+rj
 Bz1KqSooZrASobjBOdSMQtMD3Rlhy3pirZZcaeUhnyyDKDOOD1MtMMXyXetLEjESBwwh
 Hg/wRRnJ3ZI6ADHo1fLprmRhTJ1WgUATCWt2MxkxY9fQut46Jd2Mq+0I3F5bLc2oWu+9
 jQG+sgHixHWH8YqhKxHC31KPioLFScD5W6BPqU3tslB2W64bO+wptx0HHMBGo3DtWgaF
 NQBQ==
X-Gm-Message-State: AOJu0YzZA/xLD1j6/kNS4588wK1TSKHVpOq0NoNISTXgqCqbUiVOsm8o
 fxKx5WB4IdTb5dRPvSRVIFHpuL07mVsT1HpSmf1tfJyCKSvGNDMLDhv943eoR+as0Pf9fjGm1WE
 =
X-Google-Smtp-Source: AGHT+IEH8tPvQMS3rRqlFUNsJEo5v0Xn6RAidAw/g0jBWTl2TH3gMwu6SE3XH7Ysr8qkYJFLm5KFAg==
X-Received: by 2002:a05:6e02:1b06:b0:3a0:9c99:32d6 with SMTP id
 e9e14a558f8ab-3a7480d5e95mr175531555ab.24.1732022384170; 
 Tue, 19 Nov 2024 05:19:44 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:19:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 20/39] net: Return the size from parse_args()
Date: Tue, 19 Nov 2024 06:18:25 -0700
Message-Id: <20241119131844.4078144-21-sjg@chromium.org>
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

Rather than setting global variables, return the size, if provided. For
tftput, use the addr argument to store the save address, to avoid adding
yet another parameter.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/net.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index 920d9918ff6..8bb8604faf6 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -321,12 +321,14 @@ static int parse_addr_size(char * const argv[], ulong *addrp, ulong *sizep)
  *		parsed
  * @argv:	command line arguments, with argv[0] being the command
  * @fnamep:	set to the filename, if provided, else NULL
- * @addrp:	returns the load address, if any is provided, else it is left
+ * @addrp:	returns the load/save address, if any is provided, else it is
+ *		left unchanged
+ * @sizep:	returns the save size, if any is provided, else it is left
  *		unchanged
  * Return:	0 on success
  */
 static int parse_args(enum proto_t proto, int argc, char *const argv[],
-		      const char **fnamep, ulong *addrp)
+		      const char **fnamep, ulong *addrp, ulong *sizep)
 {
 	ulong addr;
 	char *end;
@@ -356,8 +358,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[],
 
 	case 3:
 		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
-			if (parse_addr_size(argv, &image_save_addr,
-					    &image_save_size))
+			if (parse_addr_size(argv, addrp, sizep))
 				return 1;
 		} else {
 			*addrp = hextoul(argv[1], NULL);
@@ -367,7 +368,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[],
 
 #ifdef CONFIG_CMD_TFTPPUT
 	case 4:
-		if (parse_addr_size(argv, &image_save_addr, &image_save_size))
+		if (parse_addr_size(argv, addrp, sizep))
 			return 1;
 		*fnamep = argv[3];
 		break;
@@ -383,6 +384,7 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 			  char *const argv[])
 {
 	const char *fname;
+	ulong addr;
 	char *s;
 	int   rcode = 0;
 	int   size;
@@ -390,10 +392,10 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 	net_boot_file_name_explicit = false;
 	*net_boot_file_name = '\0';
 
-	/* pre-set image_load_addr */
+	/* pre-set addr */
 	s = env_get("loadaddr");
 	if (s != NULL)
-		image_load_addr = hextoul(s, NULL);
+		addr = hextoul(s, NULL);
 
 	if (IS_ENABLED(CONFIG_IPV6)) {
 		use_ip6 = false;
@@ -406,10 +408,14 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 		}
 	}
 
-	if (parse_args(proto, argc, argv, &fname, &image_load_addr)) {
+	if (parse_args(proto, argc, argv, &fname, &addr, &image_save_size)) {
 		bootstage_error(BOOTSTAGE_ID_NET_START);
 		return CMD_RET_USAGE;
 	}
+	if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		image_save_addr = addr;
+	else
+		image_load_addr = addr;
 
 	if (fname) {
 		net_boot_file_name_explicit = true;
-- 
2.34.1

