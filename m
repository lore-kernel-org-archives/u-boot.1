Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46635EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 09:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13D8F86484;
	Tue, 22 Aug 2023 11:39:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l969Csrt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3693686484; Tue, 22 Aug 2023 11:38:59 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44D1D864B6
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2bcb89b476bso35459041fa.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 02:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697135; x=1693301935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=erCd8ZSiyq6rXET12tNjhpGsxxm9NJMiH8TnEEsQ88A=;
 b=l969CsrtmDkhUQuYnvOm8m0qjO3axcOVJXisZovHgexbpcV9NHY6dfW1ztWBt561PB
 kjyt+lfkuRmtPROAKvNq/tAPvufR1X60AA0UjJ6yBHokuMcpI6xXvSJYg5j9jW5h3SCi
 ceU0JMjajC71RfAM60bn/yEDNVhJVX58kKh7RvhiXoO5L4T63LOlXeoE7NbgPz96WrK7
 ms+sZZXxuYbHDGSh6kvHPUXZRdVoaL3QBD+0fO04Do4RTqOpEkNoRR4frT6O1BjL28lS
 kkI1My7hzR921kvObVNUgbXBvdRz07MoC41pEX0OZnCVgqxawkRIxTSdItXHxssCeDCO
 UqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697135; x=1693301935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=erCd8ZSiyq6rXET12tNjhpGsxxm9NJMiH8TnEEsQ88A=;
 b=LT7Bm0cPTJzxY92RUKS0GwgsgGSjPek6vBOEvtdz9Wv+BZKqurVpHc5VN9XwAdJIpH
 lpNzNcs1Njf8zVMJrgLOIlTtReSX5PRSDyyA91f4kS/GwNXxiq0jJd87VuevO3mgZ/54
 jMhI9/8L47ouTlnIf2qIlSJp0znoakyrt3HvReqnVzRyU/ldXTDJFg3u+RxD9aQf7/Bz
 mOaMw6oucLzFnz9dIZdHx1PTiTbh6pxQ06oI5wIc1ehffsP4JdIC96Yz63K6Sezz+OOh
 zKrOPgNgU7+Syzd+qbnlU1hDchl4xdiVi8LAv10eW4MP5cmq9DnF5gfF1Jekzye2rgmB
 NP0w==
X-Gm-Message-State: AOJu0YxWXUXGpCD95yv/q6rFKjokSN5S4p1ksZibHP6qKpRlLPd0B+FH
 xyAhh7zRRtKyzGHaszGp5l0CdUgGAPpVMrREc6yrHg==
X-Google-Smtp-Source: AGHT+IFPOtnyhQUFf508DfKHL0Av1cdn0UEoH0j1IG94qNqP3wOHZXsxHV6kspLHrdnqNHhGz6pAbw==
X-Received: by 2002:a2e:3207:0:b0:2b8:3ff3:cd93 with SMTP id
 y7-20020a2e3207000000b002b83ff3cd93mr5974896ljy.7.1692697135294; 
 Tue, 22 Aug 2023 02:38:55 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a2e8089000000b002b724063010sm2649637ljg.47.2023.08.22.02.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 02:38:55 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv7 14/15] net/lwip: drop old net/wget
Date: Tue, 22 Aug 2023 15:36:13 +0600
Message-Id: <20230822093614.4717-15-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230822093614.4717-1-maxim.uvarov@linaro.org>
References: <20230822093614.4717-1-maxim.uvarov@linaro.org>
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
index 7f868ee516..38d34ed5f4 100644
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
@@ -566,11 +565,6 @@ restart:
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

