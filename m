Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265BAE7D0D2
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 07:12:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A716867D2;
	Fri, 22 Sep 2023 09:12:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F+hOPqi/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83A7786680; Fri, 22 Sep 2023 09:11:59 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FCFD86575
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 09:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c3bd829b86so15658875ad.0
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 00:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695366715; x=1695971515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WU12nRc3PY07Ru07cR6taZkTqc1pHCkiZamCQo1Qz1c=;
 b=F+hOPqi/r6No+psk77FBLtcuI951uNxD1u+Uor2o7+IqQ2IZiOJZ4uJQJJwG3DQuvC
 MJRnT1RbsFOxvu9O6IZm7Jo3bV9nWEPsB5Q3JV7wORNyNOIwz/JD9G1qgOekKu1uMwus
 li/xffUa8XxG/JLsnX7BIBmZuqLYBzIF1iZXknOqpNUfWC5h36zr+Yb7dtDkQtdfL3wb
 /0f6B/bu0Qnk3FWVj5socpyZ9N+0xZEXpsQriGZ9k6GwVJ7PSBqMIEwZ9ZTbBYymeC/A
 NU024ctUNGKoXLOhNVyI62huFfAQ7dMWRK3JRp9xtdIxHVSv0CMnbZnNQvShRAk+yO+p
 Ba8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695366715; x=1695971515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WU12nRc3PY07Ru07cR6taZkTqc1pHCkiZamCQo1Qz1c=;
 b=rLFJwjNkc0Tz1zMP8neQJ9Am7gP6bPBNfU6E4lxArk1khYq9WRWJda6Sg57EKEutKy
 zk9nVAKKn81lNpByfEem8Aai0GdQJY2oVMM7PLeAdg902sJiNqaHuLXsEZ/IQVDsd2n1
 ugC7b3eRLuWOCZhWaX+L69igIhqWdZdOewrhWB06qZEjHCgOQZOrVZ9HztsSIDgYcTA5
 e0/HtS6cMleJjrGFXlCwV0+Swq2vlLN3bnonaOaoZBf8A96dT6msnPoXaubz9NM0wphT
 9rdI4w27sBWWLdD7AbYokYkb6LTRhtyp8dYUzsl10mxP9rIJOuE9SfMyOg+2cj0g9wlc
 veFA==
X-Gm-Message-State: AOJu0Ywfku3rqEasbFBfZw5t4owzSOX1MFJYTtxqIItFOCXr/714TILD
 3fw3RRp4WJW4+JMtT9SODtGTCpUm+MWvVkB5HLQ=
X-Google-Smtp-Source: AGHT+IGMFUE8yst9HsvtZjyG7sGpT3+XMLdHITfTS6jMkNkvkxyjE3qkFkVQIk1Lwr0mQ1NSBXQ8qw==
X-Received: by 2002:a17:902:ec8a:b0:1c4:660d:3d19 with SMTP id
 x10-20020a170902ec8a00b001c4660d3d19mr8821185plg.26.1695366715474; 
 Fri, 22 Sep 2023 00:11:55 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 ji12-20020a170903324c00b001c44489ee55sm2713253plb.273.2023.09.22.00.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 00:11:54 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v4 1/8] net: wget: prevent overwriting reserved memory
Date: Fri, 22 Sep 2023 16:11:12 +0900
Message-Id: <20230922071119.1439482-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922071119.1439482-1-masahisa.kojima@linaro.org>
References: <20230922071119.1439482-1-masahisa.kojima@linaro.org>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/wget.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 73 insertions(+), 7 deletions(-)

diff --git a/net/wget.c b/net/wget.c
index 2dbfeb1a1d..a48a8cb624 100644
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
@@ -55,6 +59,29 @@ static unsigned int retry_tcp_ack_num;	/* TCP retry acknowledge number*/
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
@@ -63,10 +90,25 @@ static int retry_len;			/* TCP retry length */
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
 
@@ -240,25 +282,39 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
 
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
@@ -330,6 +386,7 @@ static void wget_handler(uchar *pkt, u16 dport,
 				len) != 0) {
 			wget_fail("wget: store error\n",
 				  tcp_seq_num, tcp_ack_num, action);
+			net_set_state(NETLOOP_FAIL);
 			return;
 		}
 
@@ -420,6 +477,15 @@ void wget_start(void)
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

