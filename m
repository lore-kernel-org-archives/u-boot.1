Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B629C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 11:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E9FF8746A;
	Wed,  8 Nov 2023 12:07:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PgYPJipZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1937A8752D; Wed,  8 Nov 2023 12:07:49 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66CA987525
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 12:07:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cc5916d578so60939285ad.2
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 03:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699441664; x=1700046464; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AqNZNjqQYhADk2f9LcxrecaAQ0zvQd04y6QhLiDYaOs=;
 b=PgYPJipZ0WDFzwYQcdqvG7afUVGquvlDQzbkPyuHCmajlP1VoRXGXZFSaoUapSQ7XS
 aJuTo/iEBf87tpri5spqNKkB6OGK/5HOXW558Dj3E+b/0w6m+wlaKy56O2D71Hw6+ULl
 xZNH0rnc5WyH7QKG7SjH9I/XpQBL78qKFxkz6tKwjdS8Meazrby6TbkPsLMQvlvp2r1N
 5RgRW7UBsexx6qVxebFccFQAWIhZfMM1evfHQ7pQ/ROKql4NqdPDsuNYtb6sTU6O0aba
 WSAhct4Pg9ygaJNPmBolZRN32H00hKjldwnJUbJRzEoEKZxTk3guf/T0UfgCUtyNJnig
 5iuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699441664; x=1700046464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AqNZNjqQYhADk2f9LcxrecaAQ0zvQd04y6QhLiDYaOs=;
 b=VA0OQDiD/vKwB02MH8MVBFRx2L/BGsbl6IscUab+8nxnjTiZPQmYiAqbNJDr9c2RAU
 bzcdkFLGJ8Iopudg8pEqIjq37bbAzTSI0KkDC2uTw1eQtZG55dS41gr29wWYoKjZl0xj
 9IT1uYd6E4/soGj+iVoxviCF4E3YhFVqK9jFz4lroZ2nAMf+o2XmF+/K4ycF0sClhZVa
 NlAj3qRf5BNENNDksL20DD8cb9qAPSvoJ8zkpRSdUVW+l4pICLjfrHDJM6xro2/u/ke8
 QI2ILvxWQtGPTUxkY8qD8DxjNLi9J0ibJAgojSFf1PCsNzswwhpknoxOYG0ZK/3V4hsw
 /qDA==
X-Gm-Message-State: AOJu0YxAYOXI2+RFk4Y0psuhioKl+WBJxv/w8H/ENZTmFxx3cl7Ooz/D
 uIuY0GgLo1CNPwpVR2Zh1G4bFmRUTuUwtLC3M3c=
X-Google-Smtp-Source: AGHT+IH8tDoutGNoakqg4fSg8dvsZQ4oLhT4G9f5KY7uH5vqx7ZxbOvun4KAmiKG3I75oW2EFsf5Sw==
X-Received: by 2002:a17:903:244e:b0:1cc:4e81:36a4 with SMTP id
 l14-20020a170903244e00b001cc4e8136a4mr1907881pls.5.1699441664401; 
 Wed, 08 Nov 2023 03:07:44 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 d3-20020a170902cec300b001c57aac6e5esm1496956plg.23.2023.11.08.03.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 03:07:43 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: [PATCH v11 1/9] net: wget: prevent overwriting reserved memory
Date: Wed,  8 Nov 2023 20:06:28 +0900
Message-Id: <20231108110637.3691441-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108110637.3691441-1-masahisa.kojima@linaro.org>
References: <20231108110637.3691441-1-masahisa.kojima@linaro.org>
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

This introduces the valid range check to store the received
blocks using lmb. The same logic is implemented in tftp.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
---
 net/wget.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 73 insertions(+), 7 deletions(-)

diff --git a/net/wget.c b/net/wget.c
index 8bb4d72db1..6f97eb1d12 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -4,16 +4,20 @@
  * Copyright Duncan Hare <dh@synoia.com> 2017
  */
 
+#include <asm/global_data.h>
 #include <command.h>
 #include <common.h>
 #include <display_options.h>
 #include <env.h>
 #include <image.h>
+#include <lmb.h>
 #include <mapmem.h>
 #include <net.h>
 #include <net/tcp.h>
 #include <net/wget.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
 static const char bootfile1[] = "GET ";
 static const char bootfile3[] = " HTTP/1.0\r\n\r\n";
 static const char http_eom[] = "\r\n\r\n";
@@ -56,6 +60,29 @@ static unsigned int retry_tcp_ack_num;	/* TCP retry acknowledge number*/
 static unsigned int retry_tcp_seq_num;	/* TCP retry sequence number */
 static int retry_len;			/* TCP retry length */
 
+static ulong wget_load_size;
+
+/**
+ * wget_init_max_size() - initialize maximum load size
+ *
+ * Return:	0 if success, -1 if fails
+ */
+static int wget_init_load_size(void)
+{
+	struct lmb lmb;
+	phys_size_t max_size;
+
+	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
+
+	max_size = lmb_get_free_size(&lmb, image_load_addr);
+	if (!max_size)
+		return -1;
+
+	wget_load_size = max_size;
+
+	return 0;
+}
+
 /**
  * store_block() - store block in memory
  * @src: source of data
@@ -64,10 +91,25 @@ static int retry_len;			/* TCP retry length */
  */
 static inline int store_block(uchar *src, unsigned int offset, unsigned int len)
 {
+	ulong store_addr = image_load_addr + offset;
 	ulong newsize = offset + len;
 	uchar *ptr;
 
-	ptr = map_sysmem(image_load_addr + offset, len);
+	if (IS_ENABLED(CONFIG_LMB)) {
+		ulong end_addr = image_load_addr + wget_load_size;
+
+		if (!end_addr)
+			end_addr = ULONG_MAX;
+
+		if (store_addr < image_load_addr ||
+		    store_addr + len > end_addr) {
+			printf("\nwget error: ");
+			printf("trying to overwrite reserved memory...\n");
+			return -1;
+		}
+	}
+
+	ptr = map_sysmem(store_addr, len);
 	memcpy(ptr, src, len);
 	unmap_sysmem(ptr);
 
@@ -248,25 +290,39 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
 
 			net_boot_file_size = 0;
 
-			if (len > hlen)
-				store_block(pkt + hlen, 0, len - hlen);
+			if (len > hlen) {
+				if (store_block(pkt + hlen, 0, len - hlen) != 0) {
+					wget_loop_state = NETLOOP_FAIL;
+					wget_fail("wget: store error\n", tcp_seq_num, tcp_ack_num, action);
+					net_set_state(NETLOOP_FAIL);
+					return;
+				}
+			}
 
 			debug_cond(DEBUG_WGET,
 				   "wget: Connected Pkt %p hlen %x\n",
 				   pkt, hlen);
 
 			for (i = 0; i < pkt_q_idx; i++) {
+				int err;
+
 				ptr1 = map_sysmem(
 					(phys_addr_t)(pkt_q[i].pkt),
 					pkt_q[i].len);
-				store_block(ptr1,
-					    pkt_q[i].tcp_seq_num -
-					    initial_data_seq_num,
-					    pkt_q[i].len);
+				err = store_block(ptr1,
+					  pkt_q[i].tcp_seq_num -
+					  initial_data_seq_num,
+					  pkt_q[i].len);
 				unmap_sysmem(ptr1);
 				debug_cond(DEBUG_WGET,
 					   "wget: Connctd pkt Q %p len %x\n",
 					   pkt_q[i].pkt, pkt_q[i].len);
+				if (err) {
+					wget_loop_state = NETLOOP_FAIL;
+					wget_fail("wget: store error\n", tcp_seq_num, tcp_ack_num, action);
+					net_set_state(NETLOOP_FAIL);
+					return;
+				}
 			}
 		}
 	}
@@ -338,6 +394,7 @@ static void wget_handler(uchar *pkt, u16 dport,
 				len) != 0) {
 			wget_fail("wget: store error\n",
 				  tcp_seq_num, tcp_ack_num, action);
+			net_set_state(NETLOOP_FAIL);
 			return;
 		}
 
@@ -428,6 +485,15 @@ void wget_start(void)
 	debug_cond(DEBUG_WGET,
 		   "\nwget:Load address: 0x%lx\nLoading: *\b", image_load_addr);
 
+	if (IS_ENABLED(CONFIG_LMB)) {
+		if (wget_init_load_size()) {
+			printf("\nwget error: ");
+			printf("trying to overwrite reserved memory...\n");
+			net_set_state(NETLOOP_FAIL);
+			return;
+		}
+	}
+
 	net_set_timeout_handler(wget_timeout, wget_timeout_handler);
 	tcp_set_tcp_handler(wget_handler);
 
-- 
2.34.1

