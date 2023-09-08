Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3D3EE8004
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 13:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 741FC86A9F;
	Fri,  8 Sep 2023 15:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xWYD3nqt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA67E86AB9; Fri,  8 Sep 2023 15:56:11 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD3B986ABD
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 15:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2bcfd3220d3so34951051fa.2
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 06:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694181368; x=1694786168; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Enmy0689N7W2ZgwZJNW/re8YJQVeDPBPlmUCaBkcQNw=;
 b=xWYD3nqtt1P++90PyBQVDS4uOO+LyF7kSsi+ej2/ROWwxgCjayOOF+yocgWk5Sib7v
 vaYN3YpWPVwXtuAq4PDjyej4ZKX8kfB1tzniSai3zxwjdJ8trU6b1LMjo26thGxXu1Rf
 aSY4yOJhZNRMERkeaGmtQn/SLPN/hmYexUCdQspx4yNjeZicHs77Aqhbe0BhRdJ90IKP
 mfnDFOKwkAprsIGFWjZ6SK3GxO0trXV04kFGaTU4mEVCqVu5imjtIXwGnlRQOqdH+k0S
 TtrcsYQqOysXmCdU9EwqXOc7gfBF7ela6dv2oHu8BMHQTKrQyvvNiN8y+Z/qdavCQYs8
 me0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694181368; x=1694786168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Enmy0689N7W2ZgwZJNW/re8YJQVeDPBPlmUCaBkcQNw=;
 b=Qnq2pGnXz+2Mbc6o4beR4XpwHc9tPLgaLAXmuWng6M3VZlWE2jtEi4YG5dmdFTNkhU
 7HpGShmMetYxCpSG3BTlnFfqDXeacl/LpY6m2/B9BR/ms5otBUAULskJNfOV9WAp3zv0
 N5XgP46MvCSjZ2Wq29YLfdZnagDa9tmGAx7jH2XQM9K/MRj7/gvvsxgQ6bywyR31yq5g
 p5J4VsqDCdFqlr3QQZXXOzAO97D+8FPJP5g0ymfbpJ12JQ/z+XK3brXHuvmhkajTeirt
 /J9VbAJmfD8LOMW9kTAkKVsdRah+xHOvcywxXfdF12M0i0o6QXVUUoMosJx6dhUrZKSZ
 TRpA==
X-Gm-Message-State: AOJu0YyTDV+pDGWTXifKgwTwca2xTzm8ANC36Aorikds7qyt2Z1fh7uP
 CBAF2WNMGt35QFQ0Co96EmwaUL8I6nHdXXQCNL+Tuw==
X-Google-Smtp-Source: AGHT+IGnl57JVOmTR6qk0PwfJbueWr5FGqmeQxsBmOofqQkUih93mSEwG/TmG62/5OuDZ2GFj3qaUA==
X-Received: by 2002:a2e:804b:0:b0:2bc:f523:c88a with SMTP id
 p11-20020a2e804b000000b002bcf523c88amr2023832ljg.1.1694181367891; 
 Fri, 08 Sep 2023 06:56:07 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a2e9f0e000000b002bcbae4c21fsm306907ljk.50.2023.09.08.06.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 06:56:07 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv8 14/15] net/lwip: drop old net/wget
Date: Fri,  8 Sep 2023 19:53:19 +0600
Message-Id: <20230908135320.7066-15-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230908135320.7066-1-maxim.uvarov@linaro.org>
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
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

After which to lwip variants of working apps we need to
drop old code with all dependencies. This commit
drop old wget command files.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 include/net/wget.h |  22 ---
 net/Makefile       |   1 -
 net/net.c          |   6 -
 net/wget.c         | 440 ---------------------------------------------
 4 files changed, 469 deletions(-)
 delete mode 100644 include/net/wget.h
 delete mode 100644 net/wget.c

diff --git a/include/net/wget.h b/include/net/wget.h
deleted file mode 100644
index da0920de11..0000000000
--- a/include/net/wget.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Duncan Hare Copyright 2017
- */
-
-/**
- * wget_start() - begin wget
- */
-void wget_start(void);
-
-enum wget_state {
-	WGET_CLOSED,
-	WGET_CONNECTING,
-	WGET_CONNECTED,
-	WGET_TRANSFERRING,
-	WGET_TRANSFERRED
-};
-
-#define DEBUG_WGET		0	/* Set to 1 for debug messages */
-#define SERVER_PORT		80
-#define WGET_RETRY_COUNT	30
-#define WGET_TIMEOUT		2000UL
diff --git a/net/Makefile b/net/Makefile
index 61930c244e..eda21f988a 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -32,7 +32,6 @@ obj-$(CONFIG_TCP_FUNCTION_FASTBOOT)  += fastboot_tcp.o
 obj-$(CONFIG_CMD_WOL)  += wol.o
 obj-$(CONFIG_PROT_UDP) += udp.o
 obj-$(CONFIG_PROT_TCP) += tcp.o
-obj-$(CONFIG_CMD_WGET) += wget.o
 obj-$(CONFIG_LWIP) += lwip/
 
 # Disable this warning as it is triggered by:
diff --git a/net/net.c b/net/net.c
index d9e566081c..677eda26bc 100644
--- a/net/net.c
+++ b/net/net.c
@@ -109,7 +109,6 @@
 #include <linux/compiler.h>
 #include <test/test.h>
 #include <net/tcp.h>
-#include <net/wget.h>
 #include "arp.h"
 #include "bootp.h"
 #include "cdp.h"
@@ -564,11 +563,6 @@ restart:
 			nfs_start();
 			break;
 #endif
-#if defined(CONFIG_CMD_WGET)
-		case WGET:
-			wget_start();
-			break;
-#endif
 #if defined(CONFIG_CMD_CDP)
 		case CDP:
 			cdp_start();
diff --git a/net/wget.c b/net/wget.c
deleted file mode 100644
index 2dbfeb1a1d..0000000000
--- a/net/wget.c
+++ /dev/null
@@ -1,440 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * WGET/HTTP support driver based on U-BOOT's nfs.c
- * Copyright Duncan Hare <dh@synoia.com> 2017
- */
-
-#include <command.h>
-#include <common.h>
-#include <display_options.h>
-#include <env.h>
-#include <image.h>
-#include <mapmem.h>
-#include <net.h>
-#include <net/tcp.h>
-#include <net/wget.h>
-
-static const char bootfile1[] = "GET ";
-static const char bootfile3[] = " HTTP/1.0\r\n\r\n";
-static const char http_eom[] = "\r\n\r\n";
-static const char http_ok[] = "200";
-static const char content_len[] = "Content-Length";
-static const char linefeed[] = "\r\n";
-static struct in_addr web_server_ip;
-static int our_port;
-static int wget_timeout_count;
-
-struct pkt_qd {
-	uchar *pkt;
-	unsigned int tcp_seq_num;
-	unsigned int len;
-};
-
-/*
- * This is a control structure for out of order packets received.
- * The actual packet bufers are in the kernel space, and are
- * expected to be overwritten by the downloaded image.
- */
-static struct pkt_qd pkt_q[PKTBUFSRX / 4];
-static int pkt_q_idx;
-static unsigned long content_length;
-static unsigned int packets;
-
-static unsigned int initial_data_seq_num;
-
-static enum  wget_state current_wget_state;
-
-static char *image_url;
-static unsigned int wget_timeout = WGET_TIMEOUT;
-
-static enum net_loop_state wget_loop_state;
-
-/* Timeout retry parameters */
-static u8 retry_action;			/* actions for TCP retry */
-static unsigned int retry_tcp_ack_num;	/* TCP retry acknowledge number*/
-static unsigned int retry_tcp_seq_num;	/* TCP retry sequence number */
-static int retry_len;			/* TCP retry length */
-
-/**
- * store_block() - store block in memory
- * @src: source of data
- * @offset: offset
- * @len: length
- */
-static inline int store_block(uchar *src, unsigned int offset, unsigned int len)
-{
-	ulong newsize = offset + len;
-	uchar *ptr;
-
-	ptr = map_sysmem(image_load_addr + offset, len);
-	memcpy(ptr, src, len);
-	unmap_sysmem(ptr);
-
-	if (net_boot_file_size < (offset + len))
-		net_boot_file_size = newsize;
-
-	return 0;
-}
-
-/**
- * wget_send_stored() - wget response dispatcher
- *
- * WARNING, This, and only this, is the place in wget.c where
- * SEQUENCE NUMBERS are swapped between incoming (RX)
- * and outgoing (TX).
- * Procedure wget_handler() is correct for RX traffic.
- */
-static void wget_send_stored(void)
-{
-	u8 action = retry_action;
-	int len = retry_len;
-	unsigned int tcp_ack_num = retry_tcp_seq_num + (len == 0 ? 1 : len);
-	unsigned int tcp_seq_num = retry_tcp_ack_num;
-	uchar *ptr, *offset;
-
-	switch (current_wget_state) {
-	case WGET_CLOSED:
-		debug_cond(DEBUG_WGET, "wget: send SYN\n");
-		current_wget_state = WGET_CONNECTING;
-		net_send_tcp_packet(0, SERVER_PORT, our_port, action,
-				    tcp_seq_num, tcp_ack_num);
-		packets = 0;
-		break;
-	case WGET_CONNECTING:
-		pkt_q_idx = 0;
-		net_send_tcp_packet(0, SERVER_PORT, our_port, action,
-				    tcp_seq_num, tcp_ack_num);
-
-		ptr = net_tx_packet + net_eth_hdr_size() +
-			IP_TCP_HDR_SIZE + TCP_TSOPT_SIZE + 2;
-		offset = ptr;
-
-		memcpy(offset, &bootfile1, strlen(bootfile1));
-		offset += strlen(bootfile1);
-
-		memcpy(offset, image_url, strlen(image_url));
-		offset += strlen(image_url);
-
-		memcpy(offset, &bootfile3, strlen(bootfile3));
-		offset += strlen(bootfile3);
-		net_send_tcp_packet((offset - ptr), SERVER_PORT, our_port,
-				    TCP_PUSH, tcp_seq_num, tcp_ack_num);
-		current_wget_state = WGET_CONNECTED;
-		break;
-	case WGET_CONNECTED:
-	case WGET_TRANSFERRING:
-	case WGET_TRANSFERRED:
-		net_send_tcp_packet(0, SERVER_PORT, our_port, action,
-				    tcp_seq_num, tcp_ack_num);
-		break;
-	}
-}
-
-static void wget_send(u8 action, unsigned int tcp_seq_num,
-		      unsigned int tcp_ack_num, int len)
-{
-	retry_action = action;
-	retry_tcp_ack_num = tcp_ack_num;
-	retry_tcp_seq_num = tcp_seq_num;
-	retry_len = len;
-
-	wget_send_stored();
-}
-
-void wget_fail(char *error_message, unsigned int tcp_seq_num,
-	       unsigned int tcp_ack_num, u8 action)
-{
-	printf("wget: Transfer Fail - %s\n", error_message);
-	net_set_timeout_handler(0, NULL);
-	wget_send(action, tcp_seq_num, tcp_ack_num, 0);
-}
-
-void wget_success(u8 action, unsigned int tcp_seq_num,
-		  unsigned int tcp_ack_num, int len, int packets)
-{
-	printf("Packets received %d, Transfer Successful\n", packets);
-	wget_send(action, tcp_seq_num, tcp_ack_num, len);
-}
-
-/*
- * Interfaces of U-BOOT
- */
-static void wget_timeout_handler(void)
-{
-	if (++wget_timeout_count > WGET_RETRY_COUNT) {
-		puts("\nRetry count exceeded; starting again\n");
-		wget_send(TCP_RST, 0, 0, 0);
-		net_start_again();
-	} else {
-		puts("T ");
-		net_set_timeout_handler(wget_timeout +
-					WGET_TIMEOUT * wget_timeout_count,
-					wget_timeout_handler);
-		wget_send_stored();
-	}
-}
-
-#define PKT_QUEUE_OFFSET 0x20000
-#define PKT_QUEUE_PACKET_SIZE 0x800
-
-static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
-			   u8 action, unsigned int tcp_ack_num, unsigned int len)
-{
-	uchar *pkt_in_q;
-	char *pos;
-	int hlen, i;
-	uchar *ptr1;
-
-	pkt[len] = '\0';
-	pos = strstr((char *)pkt, http_eom);
-
-	if (!pos) {
-		debug_cond(DEBUG_WGET,
-			   "wget: Connected, data before Header %p\n", pkt);
-		pkt_in_q = (void *)image_load_addr + PKT_QUEUE_OFFSET +
-			(pkt_q_idx * PKT_QUEUE_PACKET_SIZE);
-
-		ptr1 = map_sysmem((phys_addr_t)pkt_in_q, len);
-		memcpy(ptr1, pkt, len);
-		unmap_sysmem(ptr1);
-
-		pkt_q[pkt_q_idx].pkt = pkt_in_q;
-		pkt_q[pkt_q_idx].tcp_seq_num = tcp_seq_num;
-		pkt_q[pkt_q_idx].len = len;
-		pkt_q_idx++;
-	} else {
-		debug_cond(DEBUG_WGET, "wget: Connected HTTP Header %p\n", pkt);
-		/* sizeof(http_eom) - 1 is the string length of (http_eom) */
-		hlen = pos - (char *)pkt + sizeof(http_eom) - 1;
-		pos = strstr((char *)pkt, linefeed);
-		if (pos > 0)
-			i = pos - (char *)pkt;
-		else
-			i = hlen;
-		printf("%.*s", i,  pkt);
-
-		current_wget_state = WGET_TRANSFERRING;
-
-		if (strstr((char *)pkt, http_ok) == 0) {
-			debug_cond(DEBUG_WGET,
-				   "wget: Connected Bad Xfer\n");
-			initial_data_seq_num = tcp_seq_num + hlen;
-			wget_loop_state = NETLOOP_FAIL;
-			wget_send(action, tcp_seq_num, tcp_ack_num, len);
-		} else {
-			debug_cond(DEBUG_WGET,
-				   "wget: Connctd pkt %p  hlen %x\n",
-				   pkt, hlen);
-			initial_data_seq_num = tcp_seq_num + hlen;
-
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
-			net_boot_file_size = 0;
-
-			if (len > hlen)
-				store_block(pkt + hlen, 0, len - hlen);
-
-			debug_cond(DEBUG_WGET,
-				   "wget: Connected Pkt %p hlen %x\n",
-				   pkt, hlen);
-
-			for (i = 0; i < pkt_q_idx; i++) {
-				ptr1 = map_sysmem(
-					(phys_addr_t)(pkt_q[i].pkt),
-					pkt_q[i].len);
-				store_block(ptr1,
-					    pkt_q[i].tcp_seq_num -
-					    initial_data_seq_num,
-					    pkt_q[i].len);
-				unmap_sysmem(ptr1);
-				debug_cond(DEBUG_WGET,
-					   "wget: Connctd pkt Q %p len %x\n",
-					   pkt_q[i].pkt, pkt_q[i].len);
-			}
-		}
-	}
-	wget_send(action, tcp_seq_num, tcp_ack_num, len);
-}
-
-/**
- * wget_handler() - TCP handler of wget
- * @pkt: pointer to the application packet
- * @dport: destination TCP port
- * @sip: source IP address
- * @sport: source TCP port
- * @tcp_seq_num: TCP sequential number
- * @tcp_ack_num: TCP acknowledgment number
- * @action: TCP action (SYN, ACK, FIN, etc)
- * @len: packet length
- *
- * In the "application push" invocation, the TCP header with all
- * its information is pointed to by the packet pointer.
- */
-static void wget_handler(uchar *pkt, u16 dport,
-			 struct in_addr sip, u16 sport,
-			 u32 tcp_seq_num, u32 tcp_ack_num,
-			 u8 action, unsigned int len)
-{
-	enum tcp_state wget_tcp_state = tcp_get_tcp_state();
-
-	net_set_timeout_handler(wget_timeout, wget_timeout_handler);
-	packets++;
-
-	switch (current_wget_state) {
-	case WGET_CLOSED:
-		debug_cond(DEBUG_WGET, "wget: Handler: Error!, State wrong\n");
-		break;
-	case WGET_CONNECTING:
-		debug_cond(DEBUG_WGET,
-			   "wget: Connecting In len=%x, Seq=%u, Ack=%u\n",
-			   len, tcp_seq_num, tcp_ack_num);
-		if (!len) {
-			if (wget_tcp_state == TCP_ESTABLISHED) {
-				debug_cond(DEBUG_WGET,
-					   "wget: Cting, send, len=%x\n", len);
-				wget_send(action, tcp_seq_num, tcp_ack_num,
-					  len);
-			} else {
-				printf("%.*s", len,  pkt);
-				wget_fail("wget: Handler Connected Fail\n",
-					  tcp_seq_num, tcp_ack_num, action);
-			}
-		}
-		break;
-	case WGET_CONNECTED:
-		debug_cond(DEBUG_WGET, "wget: Connected seq=%u, len=%x\n",
-			   tcp_seq_num, len);
-		if (!len) {
-			wget_fail("Image not found, no data returned\n",
-				  tcp_seq_num, tcp_ack_num, action);
-		} else {
-			wget_connected(pkt, tcp_seq_num, action, tcp_ack_num, len);
-		}
-		break;
-	case WGET_TRANSFERRING:
-		debug_cond(DEBUG_WGET,
-			   "wget: Transferring, seq=%x, ack=%x,len=%x\n",
-			   tcp_seq_num, tcp_ack_num, len);
-
-		if (tcp_seq_num >= initial_data_seq_num &&
-		    store_block(pkt, tcp_seq_num - initial_data_seq_num,
-				len) != 0) {
-			wget_fail("wget: store error\n",
-				  tcp_seq_num, tcp_ack_num, action);
-			return;
-		}
-
-		switch (wget_tcp_state) {
-		case TCP_FIN_WAIT_2:
-			wget_send(TCP_ACK, tcp_seq_num, tcp_ack_num, len);
-			fallthrough;
-		case TCP_SYN_SENT:
-		case TCP_SYN_RECEIVED:
-		case TCP_CLOSING:
-		case TCP_FIN_WAIT_1:
-		case TCP_CLOSED:
-			net_set_state(NETLOOP_FAIL);
-			break;
-		case TCP_ESTABLISHED:
-			wget_send(TCP_ACK, tcp_seq_num, tcp_ack_num,
-				  len);
-			wget_loop_state = NETLOOP_SUCCESS;
-			break;
-		case TCP_CLOSE_WAIT:     /* End of transfer */
-			current_wget_state = WGET_TRANSFERRED;
-			wget_send(action | TCP_ACK | TCP_FIN,
-				  tcp_seq_num, tcp_ack_num, len);
-			break;
-		}
-		break;
-	case WGET_TRANSFERRED:
-		printf("Packets received %d, Transfer Successful\n", packets);
-		net_set_state(wget_loop_state);
-		break;
-	}
-}
-
-#define RANDOM_PORT_START 1024
-#define RANDOM_PORT_RANGE 0x4000
-
-/**
- * random_port() - make port a little random (1024-17407)
- *
- * Return: random port number from 1024 to 17407
- *
- * This keeps the math somewhat trivial to compute, and seems to work with
- * all supported protocols/clients/servers
- */
-static unsigned int random_port(void)
-{
-	return RANDOM_PORT_START + (get_timer(0) % RANDOM_PORT_RANGE);
-}
-
-#define BLOCKSIZE 512
-
-void wget_start(void)
-{
-	image_url = strchr(net_boot_file_name, ':');
-	if (image_url > 0) {
-		web_server_ip = string_to_ip(net_boot_file_name);
-		++image_url;
-		net_server_ip = web_server_ip;
-	} else {
-		web_server_ip = net_server_ip;
-		image_url = net_boot_file_name;
-	}
-
-	debug_cond(DEBUG_WGET,
-		   "wget: Transfer HTTP Server %pI4; our IP %pI4\n",
-		   &web_server_ip, &net_ip);
-
-	/* Check if we need to send across this subnet */
-	if (net_gateway.s_addr && net_netmask.s_addr) {
-		struct in_addr our_net;
-		struct in_addr server_net;
-
-		our_net.s_addr = net_ip.s_addr & net_netmask.s_addr;
-		server_net.s_addr = net_server_ip.s_addr & net_netmask.s_addr;
-		if (our_net.s_addr != server_net.s_addr)
-			debug_cond(DEBUG_WGET,
-				   "wget: sending through gateway %pI4",
-				   &net_gateway);
-	}
-	debug_cond(DEBUG_WGET, "URL '%s'\n", image_url);
-
-	if (net_boot_file_expected_size_in_blocks) {
-		debug_cond(DEBUG_WGET, "wget: Size is 0x%x Bytes = ",
-			   net_boot_file_expected_size_in_blocks * BLOCKSIZE);
-		print_size(net_boot_file_expected_size_in_blocks * BLOCKSIZE,
-			   "");
-	}
-	debug_cond(DEBUG_WGET,
-		   "\nwget:Load address: 0x%lx\nLoading: *\b", image_load_addr);
-
-	net_set_timeout_handler(wget_timeout, wget_timeout_handler);
-	tcp_set_tcp_handler(wget_handler);
-
-	wget_timeout_count = 0;
-	current_wget_state = WGET_CLOSED;
-
-	our_port = random_port();
-
-	/*
-	 * Zero out server ether to force arp resolution in case
-	 * the server ip for the previous u-boot command, for example dns
-	 * is not the same as the web server ip.
-	 */
-
-	memset(net_server_ethaddr, 0, 6);
-
-	wget_send(TCP_SYN, 0, 0, 0);
-}
-- 
2.30.2

