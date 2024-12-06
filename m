Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31BAE77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:40:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 874E88962F;
	Fri,  6 Dec 2024 03:37:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UPAxDJMI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BA7189629; Fri,  6 Dec 2024 03:37:44 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31B7589748
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:37:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a7d7c1b190so5591735ab.3
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452660; x=1734057460; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yv39WvHDrKZ7gT7q3Ct6k+vlbpMf/MblKm3sDcXH3hw=;
 b=UPAxDJMISNRoCV2NnVKysimPTCdpaqjUregpf1HUDRtN7zmFS84M0fy/RtKV48Irwl
 NrBbVafi14VK336nOZnX53m4jb9cROG32duPYJAwSImc0JkczyPNGKany4tiMDr6M1rB
 jLrStdo/SCvJZS6EepmVInoDjNZCLRvaod+/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452660; x=1734057460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yv39WvHDrKZ7gT7q3Ct6k+vlbpMf/MblKm3sDcXH3hw=;
 b=gd6JpF4kYeYwK7ldHqgFvEACnKsk28c7q7wV1ncldLVhtbG4Ir1BZ7R1WRg1LGDLHn
 JxwurEIOETO8wvcRODDWqcGg77P69xwzL4bc4tN10o6vOEiyjt/xHL9N3rEhx8RvuttC
 Rbp/4ns3begmtvxsDbMLOfpo5YTNxxVHhKptx+pn/l0o8LWJTYaxQkkhQp+0Hyy1VWZS
 UAq3RjWMeQFzTsXU07C+dRiXPEIKMlmqKm2T/rm4r2pLuAT9s1o5msOlWfkgrmxWNePD
 gaJkQrJSr5Kp5JMrZ6hhyFaFmr/ns5ZW0MZMJpkhI+7NHsmbMsLFRZBgo0Fmd7M/zkMj
 /0/A==
X-Gm-Message-State: AOJu0Yzn2IzQr1taSvGvLqLFf/NFQvkwo0IBP+Bd4CakJfXiIqHBYhZv
 7GCi9MT+xtdjxBO2W0ZIPdRVNr61K0Y44CGV5zc+IM2PBu/RHpfrpXA30UzWMQB4BVmm0KioDmk
 =
X-Gm-Gg: ASbGncvemwkyiY7WjYk+ViVww3u5Iko8LoD7kxaoxnvtP06MW+Gqm8Byn11WH804qz6
 PgUtH5tSmocLICqDfZ6f4ss38eTTbW0WnGy/WHffE7wgnQtFiEdawx7VimwMtAhU2MU2hBSblNk
 mEM1xY4RzzfdJuW8+PyTHQVVM5W7kKUDXJFmL6FKmINrNg6k87xdm5kn+4rNujFfYm7ZHuPw9sV
 Yj1RwboTgOHDO/VCGvsKCjQ2VH/Qh13yW6ICLmnNx/n7nBf5cCfBy14W6xv9l28CaS9Hqd9N2FZ
 qNNCGDwIJL4=
X-Google-Smtp-Source: AGHT+IElMap1576eiwmZIBoIHf4/afTYyygSY0NnOq4czMmimli111r2nCD4Y5uLFKePZHF67mGHAg==
X-Received: by 2002:a05:6e02:1544:b0:3a7:e0d1:e255 with SMTP id
 e9e14a558f8ab-3a811e4d2b4mr22386395ab.23.1733452660415; 
 Thu, 05 Dec 2024 18:37:40 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:37:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v3 26/46] net: Return the size from parse_args()
Date: Thu,  5 Dec 2024 19:36:05 -0700
Message-Id: <20241206023626.2456858-27-sjg@chromium.org>
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

Rather than setting global variables, return the size, if provided. For
tftput, use the addr argument to store the save address, to avoid adding
yet another parameter.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/net.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index cc968e9460f..572fa75a72f 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -323,12 +323,14 @@ static int parse_addr_size(char * const argv[], ulong *addrp, ulong *sizep)
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
@@ -358,8 +360,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[],
 
 	case 3:
 		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
-			if (parse_addr_size(argv, &image_save_addr,
-					    &image_save_size))
+			if (parse_addr_size(argv, addrp, sizep))
 				return 1;
 		} else {
 			*addrp = hextoul(argv[1], NULL);
@@ -369,7 +370,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[],
 
 #ifdef CONFIG_CMD_TFTPPUT
 	case 4:
-		if (parse_addr_size(argv, &image_save_addr, &image_save_size))
+		if (parse_addr_size(argv, addrp, sizep))
 			return 1;
 		*fnamep = argv[3];
 		break;
@@ -385,6 +386,7 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 			  char *const argv[])
 {
 	const char *fname;
+	ulong addr;
 	char *s;
 	int   rcode = 0;
 	int   size;
@@ -392,10 +394,10 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
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
@@ -408,10 +410,14 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
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

