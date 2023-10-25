Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEB0C25B47
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 06:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8462887A41;
	Wed, 25 Oct 2023 08:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U98tgawJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 648C087A45; Wed, 25 Oct 2023 08:30:15 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B091A879E0
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 08:30:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ca74e77aecso4047835ad.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 23:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698215406; x=1698820206; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AqNZNjqQYhADk2f9LcxrecaAQ0zvQd04y6QhLiDYaOs=;
 b=U98tgawJvKlvw1Bmh4766lJPhERlTER8NOs/DcLEx02/o6dNXzZ369kwpOTZ5UKlxC
 bYzEXnX70JWofKd9TvDBOxvZOXEySQqgHgtWZy2a+dSX5l+8ok/4GE2DbdajXdjflSKe
 EMuS8WvFBVSljz9tSiJQrER3x3rLb0E0KHDE/Dvnn1QF56/m1V70G2PnQvcKfPnvTNbj
 ngvtx8KFpjcl7ZYD3qK0N6wPSlhzdvzw8P51pWAoPrRm6mejRyUmvziHG1fYZbhZiNRo
 CqqsuqaCvNOl42TGhGWqWu5/DacNntY6xRunKAg9RLgn3bGuLiK7tMuBKnCdxfSczyKS
 JcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698215406; x=1698820206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AqNZNjqQYhADk2f9LcxrecaAQ0zvQd04y6QhLiDYaOs=;
 b=W9uTT7ldByDrk5PNlQKKJzH7yfT3fp1MQEwV1aD1IwMj4C9NYT5ZoFb8tYISTUQRAm
 g6FOLH3azi1nQ+UUTyUSuxNahLoA/DAgrL8g8X8YwVWoqxnlZId6lq6SsJzr9Nz922Ju
 5wbN6L0ppaDISLbM/h8nbX4BDlDxIzOx/DodLHrPe8mVhVfc4chutaZDqxLfJJs3vSi4
 aqaYfd40dIusmZjUg/aey/6RR/6KJC3CxACN5EuCU2fqZCDY2HN24ZYpkWXP8N9GZwP3
 VXE/Nw4/BG11e+Ij03gToiJEApEGZ04AVFUbcpPOUTu5A8h1dGnJU2haN2noBcfzYOY+
 47nw==
X-Gm-Message-State: AOJu0Yyw541Xvbqa3N6pQGDsvDQGepeniojiGBwRz5M8evbb+vC1iO4F
 cbNdOvqkcNNCkhEz2zyemV5/mlyICty5kC8mB8E=
X-Google-Smtp-Source: AGHT+IEowKJgHdpwPsaDiz56H1dPSbuGyrYriezdQF6bcMv0MCh8wXbiw7CxbdfuIOF0K9NsIHpzWA==
X-Received: by 2002:a17:902:cecc:b0:1ca:7909:6eda with SMTP id
 d12-20020a170902cecc00b001ca79096edamr18073775plg.23.1698215405808; 
 Tue, 24 Oct 2023 23:30:05 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 j12-20020a170902da8c00b001c61afa7009sm8406126plx.114.2023.10.24.23.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 23:30:05 -0700 (PDT)
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
Subject: [PATCH v8 1/7] net: wget: prevent overwriting reserved memory
Date: Wed, 25 Oct 2023 15:28:39 +0900
Message-Id: <20231025062845.3100964-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025062845.3100964-1-masahisa.kojima@linaro.org>
References: <20231025062845.3100964-1-masahisa.kojima@linaro.org>
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

