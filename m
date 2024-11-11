Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F382DD41D44
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 02:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29846893BA;
	Tue, 12 Nov 2024 03:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YCEdEvQZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66F7F89308; Mon, 11 Nov 2024 22:09:18 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D50289393
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 22:09:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21145812538so45352095ad.0
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731359354; x=1731964154; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lN6tD7WsCiG4Mi8bzkuLQbM7O7AuO+NzG5eK4Z4uCAY=;
 b=YCEdEvQZocP0oH/zaHAXasqk17kn51eEaVLOeUgiB36Ai3ALPn+kuMsSLx/Y1XStyb
 C6gtuZ45L+nL1Nkkhf9vi46CWj5q73lQCLpHv/cn4X8UbuLtWgAumNiohdsKW1jW9Bw3
 ExgfGHP7pYLAkb732gbBG6NzuJ39Lv7u4TQRHteFLyLLnutQqqco+9GVYNbILWuj2y79
 VLWJDv0s+AnQJtXPx9p4TgwU8+CkdHzlN/RJPkEnZy1mSof92vZThsz/3G1L4gQwyr3D
 BuL9d2aXq+PFswjqkACSRBpLxQCtCmlc9olLHCAo7sF3xsB2qlfACnvv6XwzTxA1E1pb
 rI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731359354; x=1731964154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lN6tD7WsCiG4Mi8bzkuLQbM7O7AuO+NzG5eK4Z4uCAY=;
 b=ZAfqwQkLHx3sl2mG80IypoeaLslZLJwEAFVQezQpfoJw0hlbIP3897Uoi6gn0wVcfj
 277PVSCFYbQPt7VR2LwggFTHv2JAxXsuEbGEpWV37Sig0FhDU/93KabgstkA5k2JEA3b
 fLwlGeyNdvXmd4Ls6m8Ydt7no80HIQmCB5RMIhSoYRRN0Q5HMlBcrEJvyd8Rcj4CSI7K
 SHxs+LuT0FeTjlvOD4aBC1nGcQ6xyfRxqJ0PrXgi5RTmlrfXg0BMcfB/1TKbJLfDJ12d
 Z+ZOL/ggoIkRRKhUaRx3AaL6d9m9CkmRLD3dHmrEuArl234mFaRfZ6jRzNlyxSGy8uva
 U0kQ==
X-Gm-Message-State: AOJu0YzVVpWDCkOE3eYklldnw2eOPNAcyYZTxSAFdfy5QYC0RYWhSr2w
 qPuEYqi/Lw58KploC28IxOgD4xscMl/9JBq1+9bpKRz7YcTHNF9eyzIibKrN
X-Google-Smtp-Source: AGHT+IF2sVGqCNUmf65qhShL8ttD/dYF0F1hX9zq7tSwZEj7TbRfA5dShfwxvamSso9QqoCp0t8N9w==
X-Received: by 2002:a17:902:e5c6:b0:20b:57f0:b38b with SMTP id
 d9443c01a7336-21183c97540mr207869395ad.19.1731359354586; 
 Mon, 11 Nov 2024 13:09:14 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc9068sm79807415ad.2.2024.11.11.13.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 13:09:14 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2 4/7] net: wget: integrate struct wget_info into legacy wget
 code
Date: Mon, 11 Nov 2024 18:08:58 -0300
Message-ID: <20241111210901.560691-5-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241111210901.560691-1-adrianox@gmail.com>
References: <20241111210901.560691-1-adrianox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 Nov 2024 03:47:02 +0100
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

Each wget request now fills the struct wget_info. The efi
bootdevice is now set conditionally to the set_bootdevice
variable in wget_info, and the same holds for lmb memory check.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---

Changes in v2:
- wget_info is now a pointer to a wget_http_info, which defaults to
  default_wget_http_info.
- wget_fill_info now uses the global wget_info instead of receiving it
  as a parameter.

 cmd/net.c  |  2 ++
 net/wget.c | 91 +++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 72 insertions(+), 21 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index c90578e1b9..79525f73a5 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -196,6 +196,8 @@ U_BOOT_CMD(
 #if defined(CONFIG_CMD_WGET)
 static int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
 {
+	wget_info = &default_wget_info;
+
 	return netboot_common(WGET, cmdtp, argc, argv);
 }
 
diff --git a/net/wget.c b/net/wget.c
index 635f82efbb..21f1875866 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -22,10 +22,10 @@ DECLARE_GLOBAL_DATA_PTR;
 /* The default, change with environment variable 'httpdstp' */
 #define SERVER_PORT		80
 
-static const char bootfile1[] = "GET ";
+static const char bootfileGET[] = "GET ";
+static const char bootfileHEAD[] = "HEAD ";
 static const char bootfile3[] = " HTTP/1.0\r\n\r\n";
 static const char http_eom[] = "\r\n\r\n";
-static const char http_ok[] = "200";
 static const char content_len[] = "Content-Length";
 static const char linefeed[] = "\r\n";
 static struct in_addr web_server_ip;
@@ -77,7 +77,7 @@ static inline int store_block(uchar *src, unsigned int offset, unsigned int len)
 	ulong newsize = offset + len;
 	uchar *ptr;
 
-	if (CONFIG_IS_ENABLED(LMB)) {
+	if (CONFIG_IS_ENABLED(LMB) && wget_info->set_bootdev) {
 		if (store_addr < image_load_addr ||
 		    lmb_read_check(store_addr, len)) {
 			printf("\nwget error: ");
@@ -132,8 +132,17 @@ static void wget_send_stored(void)
 			IP_TCP_HDR_SIZE + TCP_TSOPT_SIZE + 2;
 		offset = ptr;
 
-		memcpy(offset, &bootfile1, strlen(bootfile1));
-		offset += strlen(bootfile1);
+		switch (wget_info->method) {
+		case WGET_HTTP_METHOD_HEAD:
+			memcpy(offset, &bootfileHEAD, strlen(bootfileHEAD));
+			offset += strlen(bootfileHEAD);
+			break;
+		case WGET_HTTP_METHOD_GET:
+		default:
+			memcpy(offset, &bootfileGET, strlen(bootfileGET));
+			offset += strlen(bootfileGET);
+			break;
+		}
 
 		memcpy(offset, image_url, strlen(image_url));
 		offset += strlen(image_url);
@@ -193,6 +202,47 @@ static void wget_timeout_handler(void)
 #define PKT_QUEUE_OFFSET 0x20000
 #define PKT_QUEUE_PACKET_SIZE 0x800
 
+static void wget_fill_info(const uchar *pkt, int hlen)
+{
+	const char *first_space;
+	const char *second_space;
+	char *pos, *end;
+
+	if (wget_info->headers && hlen < MAX_HTTP_HEADERS_SIZE)
+		strncpy(wget_info->headers, pkt, hlen);
+
+	//Get status code
+	first_space = strchr(pkt, ' ');
+	if (!first_space) {
+		wget_info->status_code = -1;
+		return;
+	}
+
+	second_space = strchr(first_space + 1, ' ');
+	if (!second_space) {
+		wget_info->status_code = -1;
+		return;
+	}
+
+	wget_info->status_code = (u32)simple_strtoul(first_space + 1, &end, 10);
+
+	if (second_space != end)
+		wget_info->status_code = -1;
+
+	pos = strstr((char *)pkt, content_len);
+
+	if (pos) {
+		pos += sizeof(content_len) + 1;
+		while (*pos == ' ')
+			pos++;
+		content_length = simple_strtoul(pos, &end, 10);
+		debug_cond(DEBUG_WGET,
+			   "wget: Connected Len %lu\n",
+			   content_length);
+		wget_info->hdr_cont_len = content_length;
+	}
+}
+
 static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
 			   u8 action, unsigned int tcp_ack_num, unsigned int len)
 {
@@ -241,7 +291,11 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
 		initial_data_seq_num = tcp_seq_num + hlen;
 		next_data_seq_num    = tcp_seq_num + len;
 
-		if (strstr((char *)pkt, http_ok) == 0) {
+		wget_fill_info(pkt, hlen);
+		debug_cond(DEBUG_WGET,
+			   "wget: HTTP Status Code %d\n", wget_info->status_code);
+
+		if (wget_info->status_code != 200) {
 			debug_cond(DEBUG_WGET,
 				   "wget: Connected Bad Xfer\n");
 			wget_loop_state = NETLOOP_FAIL;
@@ -251,17 +305,6 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
 				   "wget: Connected Pkt %p hlen %x\n",
 				   pkt, hlen);
 
-			pos = strstr((char *)pkt, content_len);
-			if (!pos) {
-				content_length = -1;
-			} else {
-				pos += sizeof(content_len) + 2;
-				strict_strtoul(pos, 10, &content_length);
-				debug_cond(DEBUG_WGET,
-					   "wget: Connected Len %lu\n",
-					   content_length);
-			}
-
 			net_boot_file_size = 0;
 
 			if (len > hlen) {
@@ -397,10 +440,13 @@ static void wget_handler(uchar *pkt, u16 dport,
 	case WGET_TRANSFERRED:
 		printf("Packets received %d, Transfer Successful\n", packets);
 		net_set_state(wget_loop_state);
-		efi_set_bootdev("Net", "", image_url,
-				map_sysmem(image_load_addr, 0),
-				net_boot_file_size);
-		env_set_hex("filesize", net_boot_file_size);
+		wget_info->file_size = net_boot_file_size;
+		if (wget_info->method == WGET_HTTP_METHOD_GET && wget_info->set_bootdev) {
+			efi_set_bootdev("Net", "", image_url,
+					map_sysmem(image_load_addr, 0),
+					net_boot_file_size);
+			env_set_hex("filesize", net_boot_file_size);
+		}
 		break;
 	}
 }
@@ -425,6 +471,9 @@ static unsigned int random_port(void)
 
 void wget_start(void)
 {
+	if (!wget_info)
+		wget_info = &default_wget_info;
+
 	image_url = strchr(net_boot_file_name, ':');
 	if (image_url > 0) {
 		web_server_ip = string_to_ip(net_boot_file_name);
-- 
2.43.0

