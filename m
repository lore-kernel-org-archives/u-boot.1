Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA95CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 10:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B472F868CA;
	Fri,  1 Sep 2023 12:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i82uFwhF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6B3386886; Fri,  1 Sep 2023 12:26:29 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C9D286146
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 12:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bf5c314a57so13626075ad.1
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 03:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693563984; x=1694168784; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K5o7rE4kZSShVKtRcA18G41Zui4Hcxs84NmAGyEAImE=;
 b=i82uFwhFEr4qH/d7v6odlOrvFZpUXgG8WfdERi8NCZl7sb5f04e1QHtOe1cwTRYnj9
 X0HFEKKJvMXksFsI/HskQAJe2DfDWx9iSrOuy5vNIOR7Waq1TWA+m5FE9UU5hKSImWD1
 iprfOHti4y/01fTOplFvw7SYD/MLgxfE4ZX4dsPfvgnYG1TKZAbOgGsDWRcxvZaXWAJc
 nFI0ZvTSqwMzRu2Xls1+Jwg80tYrUHAoG6NFD9mzVnoijpAP+/eboaB5W9k3f0tmU524
 CSGQa1JbW0V9ROBQ6topx2BK6WqSheruSl0jF+Epio98w3SrkUys1QtrRVPxvfMwe/TP
 bRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693563984; x=1694168784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K5o7rE4kZSShVKtRcA18G41Zui4Hcxs84NmAGyEAImE=;
 b=guzmKn+ygpBGnsymMhi0VCOK/tOFIopXfoKi8p0vqlOcfrWj5g1aq9Uu5lFekMADti
 2tcXkThGp3xNTY7OANrWkxb9jSvYcDZf3P3H2CwtvE5Qrw6zhtIxE3KLectMlp1SuBsO
 Tlr3XAYxnceUc/Xujfi9sQsffCmB/jO3Z3Js287zGDnmmMuXgXzbhKIydHB947cUJzxG
 i+k43k/e/2ZyExTxD7hVZTL0bvVPZ1RJaXgM/foEIxmhL+z5qqrzRpDM4HPqPRLs3OoJ
 zBnY14THCAc+4H1QXyzCPUY1aBXqkal1BwVpHPd/DuaobVakzQHVYh07oxTvNfI/GfeL
 E/Gg==
X-Gm-Message-State: AOJu0YzEE7zPeNYdGURQ8+Yk+JFQz8B1fnqrHfYsxNN8SxwySVbiG+tq
 vYVd1XHZMP5YfEA6DyZWeNu07Rm1zQ8+7nnf2M8=
X-Google-Smtp-Source: AGHT+IFMrWvZCEvpGKn8qcce6UTd6k1MpeHCZKGS3rkr0+mI8a3FEJ9AVVJZYDx7JuXAC4wp3TMO6g==
X-Received: by 2002:a17:902:e808:b0:1bf:70be:ca8b with SMTP id
 u8-20020a170902e80800b001bf70beca8bmr2745835plg.43.1693563984114; 
 Fri, 01 Sep 2023 03:26:24 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 y4-20020a170902700400b001c0c86a5415sm2677052plk.154.2023.09.01.03.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 03:26:23 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2 1/6] net: wget: prevent overwriting reserved memory
Date: Fri,  1 Sep 2023 19:25:37 +0900
Message-Id: <20230901102542.609239-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901102542.609239-1-masahisa.kojima@linaro.org>
References: <20230901102542.609239-1-masahisa.kojima@linaro.org>
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
---
 net/wget.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 69 insertions(+), 7 deletions(-)

diff --git a/net/wget.c b/net/wget.c
index 2dbfeb1a1d..8bf4db4d04 100644
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
@@ -55,6 +59,32 @@ static unsigned int retry_tcp_ack_num;	/* TCP retry acknowledge number*/
 static unsigned int retry_tcp_seq_num;	/* TCP retry sequence number */
 static int retry_len;			/* TCP retry length */
 
+#ifdef CONFIG_LMB
+static ulong wget_load_size;
+#endif
+
+/**
+ * wget_init_max_size() - initialize maximum load size
+ *
+ * Return:	0 if success, -1 if fails
+ */
+static int wget_init_load_size(void)
+{
+#ifdef CONFIG_LMB
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
+#endif
+	return 0;
+}
+
 /**
  * store_block() - store block in memory
  * @src: source of data
@@ -63,10 +93,24 @@ static int retry_len;			/* TCP retry length */
  */
 static inline int store_block(uchar *src, unsigned int offset, unsigned int len)
 {
+	ulong store_addr = image_load_addr + offset;
 	ulong newsize = offset + len;
 	uchar *ptr;
 
-	ptr = map_sysmem(image_load_addr + offset, len);
+#ifdef CONFIG_LMB
+	ulong end_addr = image_load_addr + wget_load_size;
+
+	if (!end_addr)
+		end_addr = ULONG_MAX;
+
+	if (store_addr < image_load_addr ||
+		store_addr + len > end_addr) {
+		puts("\nwget error: ");
+		puts("trying to overwrite reserved memory...\n");
+		return -1;
+	}
+#endif
+	ptr = map_sysmem(store_addr, len);
 	memcpy(ptr, src, len);
 	unmap_sysmem(ptr);
 
@@ -240,25 +284,37 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
 
 			net_boot_file_size = 0;
 
-			if (len > hlen)
-				store_block(pkt + hlen, 0, len - hlen);
+			if (len > hlen) {
+				if (store_block(pkt + hlen, 0, len - hlen) != 0) {
+					wget_loop_state = NETLOOP_FAIL;
+					wget_fail("wget: store error\n", tcp_seq_num, tcp_ack_num, action);
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
+						  pkt_q[i].tcp_seq_num -
+						  initial_data_seq_num,
+						  pkt_q[i].len);
 				unmap_sysmem(ptr1);
 				debug_cond(DEBUG_WGET,
 					   "wget: Connctd pkt Q %p len %x\n",
 					   pkt_q[i].pkt, pkt_q[i].len);
+				if (err) {
+					wget_loop_state = NETLOOP_FAIL;
+					wget_fail("wget: store error\n", tcp_seq_num, tcp_ack_num, action);
+					return;
+				}
 			}
 		}
 	}
@@ -420,6 +476,12 @@ void wget_start(void)
 	debug_cond(DEBUG_WGET,
 		   "\nwget:Load address: 0x%lx\nLoading: *\b", image_load_addr);
 
+	if (wget_init_load_size()) {
+		puts("\nwget error: ");
+		puts("trying to overwrite reserved memory...\n");
+		return;
+	}
+
 	net_set_timeout_handler(wget_timeout, wget_timeout_handler);
 	tcp_set_tcp_handler(wget_handler);
 
-- 
2.34.1

