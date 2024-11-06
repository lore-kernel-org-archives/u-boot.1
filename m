Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EA1D44D77
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 14:14:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C1B189207;
	Wed,  6 Nov 2024 15:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TFllq44q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12DC1891BC; Wed,  6 Nov 2024 14:04:04 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC1E388E5C
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 14:04:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20c70abba48so59721905ad.0
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 05:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730898240; x=1731503040; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8MljCW/4VjEEMFhZ8Tc9+coNuSq0Ec+/A7IN2HEQoyM=;
 b=TFllq44qDgYVtjvfdH2G16cCBgfrw/zooZKKknZbCJktmJvlAvN1HWUJUi2DtmsD1c
 wgjKm90XAqabPjmPNsPZGtKfd39NFwUbZrRzHtRzFCsYhAJuHahmM44ye0LEwXaA2gf/
 /30UfofY0aq4s8g9QQqhe3YvbS1Puy1XYRpX02twpoYt3/cMc0AxAj2yOSlOQSqLxE7g
 1N+aeTuJfb7Tt088JyNslmvwqGhaa3AtDhHvdSz8SixBUMGaekO8izllVb/P+8zs4Tu9
 6mpreEQbfVkaf9SQiQeFHUCC1QEg+irFwE5u9f3UPc4AO3tayiE9Qlaz9V8GBazyyLA9
 HNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730898240; x=1731503040;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8MljCW/4VjEEMFhZ8Tc9+coNuSq0Ec+/A7IN2HEQoyM=;
 b=ikOIgyIro9sSrZlQrPLw+6feOUaDPG/mYZ5+bRbCFPZT7WrAT2YGWLIp1JgnxX3XFJ
 U4bvmQyapItvX/mN29jSG479Mkrnz0WFOvL/SiEQCX9oN/P6i5OVsMNdOTVv6ua9W2V7
 pMR/1+OmC7GD328WSaLX8SvrNO1gyuhdPPlQWhEjeXD1FB/9A29vZrgGCnpxhAb3SrPW
 6QrDIeWEyT6bDFPhEnQ4334KSnLd3UdBqeF47zkKXiADGlGXQReSgGh5hqrQe606DLL1
 9CglZ24MSFFvvalN/+ZaBFUpnW4V3iZsFfYOTh++4rF3zOG0SXrABFQg4h1OGBayWjvx
 mOkQ==
X-Gm-Message-State: AOJu0Yxn0IzXP9jWH8tqI+25Ny3PSjOm570dQ30+JM7PDG520K0zHajT
 vpUwHnLP9uqygw5FqYv1o3fKN23f440L/82D6mtVM0bJYuj4RJ6OMs/7mxJnRVM=
X-Google-Smtp-Source: AGHT+IEMoj8xQ3t3uQf7091v3EhwkE8UwgRTR5cGA0yHD4bHzD36gYy4sYIVRDzmSuQVThq1ZGyqzw==
X-Received: by 2002:a17:902:cec7:b0:20c:8763:b3f7 with SMTP id
 d9443c01a7336-2111af3bc88mr273662455ad.17.1730898240112; 
 Wed, 06 Nov 2024 05:04:00 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a22d5sm94513845ad.132.2024.11.06.05.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 05:03:59 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 4/7] net: wget: integrate struct wget_info into legacy wget
 code
Date: Wed,  6 Nov 2024 10:03:55 -0300
Message-ID: <20241106130355.211132-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 06 Nov 2024 15:13:43 +0100
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

Each wget request now fills the struct wget_info. Also, the
efi bootdevice is now set conditionally to the set_bootdevice
variable in wget_info, and the same holds for lmb memory check.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 net/wget.c | 88 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 67 insertions(+), 21 deletions(-)

diff --git a/net/wget.c b/net/wget.c
index 635f82efbb..24be0a4932 100644
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
+	if (CONFIG_IS_ENABLED(LMB) && wget_info.set_bootdev) {
 		if (store_addr < image_load_addr ||
 		    lmb_read_check(store_addr, len)) {
 			printf("\nwget error: ");
@@ -132,8 +132,17 @@ static void wget_send_stored(void)
 			IP_TCP_HDR_SIZE + TCP_TSOPT_SIZE + 2;
 		offset = ptr;
 
-		memcpy(offset, &bootfile1, strlen(bootfile1));
-		offset += strlen(bootfile1);
+		switch (wget_info.method) {
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
 
+static void wget_fill_info(const uchar *pkt, int hlen, struct wget_http_info *info)
+{
+	const char *first_space;
+	const char *second_space;
+	char *pos, *end;
+
+	if (info->headers && hlen < MAX_HTTP_HEADERS_SIZE)
+		strncpy(info->headers, pkt, hlen);
+
+	//Get status code
+	first_space = strchr(pkt, ' ');
+	if (!first_space) {
+		info->status_code = -1;
+		return;
+	}
+
+	second_space = strchr(first_space + 1, ' ');
+	if (!second_space) {
+		info->status_code = -1;
+		return;
+	}
+
+	info->status_code = simple_strtoul(first_space + 1, &end, 10);
+
+	if (second_space != end)
+		info->status_code = -1;
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
+		wget_info.hdr_cont_len = content_length;
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
+		wget_fill_info(pkt, hlen, &wget_info);
+		debug_cond(DEBUG_WGET,
+			   "wget: HTTP Status Code %ld\n", wget_info.status_code);
+
+		if (wget_info.status_code != 200) {
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
+		wget_info.file_size = net_boot_file_size;
+		if (wget_info.method == WGET_HTTP_METHOD_GET && wget_info.set_bootdev) {
+			efi_set_bootdev("Net", "", image_url,
+					map_sysmem(image_load_addr, 0),
+					net_boot_file_size);
+			env_set_hex("filesize", net_boot_file_size);
+		}
 		break;
 	}
 }
-- 
2.43.0

