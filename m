Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DE6C47074
	for <u-boot@archiver.kernel.org>; Sun,  7 Jan 2024 16:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C020B8781C;
	Sun,  7 Jan 2024 17:34:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BapRrjW8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E99487831; Sun,  7 Jan 2024 17:34:32 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C591877FC
 for <u-boot@lists.denx.de>; Sun,  7 Jan 2024 17:34:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a28f66dc7ffso367159866b.0
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 08:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1704645270; x=1705250070;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VEO9s5KE4fzvAc72PBTqi3K8rhyuGHpZ3HzmToAhb0M=;
 b=BapRrjW8HCX39ptrcBZUiZUv9vPJh/qcEW827F2v/oN8sssubufbGfiU7V6mTa+0Ps
 jgnw9q5nDxRRDE+Q/y3gjgu7i7+rkKDtf92s8s7Ug3LEbDeHuRut63FHuOnn6Xs57dZX
 Olt9ketlsDcLvVy7354gWsky7p2gq1STLBMdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704645270; x=1705250070;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VEO9s5KE4fzvAc72PBTqi3K8rhyuGHpZ3HzmToAhb0M=;
 b=OabNP5us7S27tmygTg/yFVhAJQojCK2ZDI/rsYPN/h0HLRG1krakeeBcVlHAvFHXUu
 9Onr8S1L5W5XqhytWAdQkvZEjKVBjshxM1q5W1Rr+tWJms9/q/ANPvzTEdLLnCrSeYFY
 1v+lBxv6n6uaelGByfFGb3XZTyGoYgm8XO3+rDVQCIIkMP9cGTLRtVWsO0ZgzFYEm2gl
 yPspG9a6eXEWDrpyWy978whqhpnPiz9TgjqixREEteTHWxZQugTrs1WX4UjrwQQstb8H
 06BQ6UPwR1uOzVW+gqId3L0ovHvaRdQGZ1zvi1qkPIoCvXWcHYiI9O56ylCsrYcDOCuw
 q4MQ==
X-Gm-Message-State: AOJu0YyKV9fay9F0rpsjrvW5cVERjIMBoNttBzt43eulAVL/lFIGSaiM
 N1k1mlpq0hHPQ3ao697iTWCmYBWxqeFmMQ==
X-Google-Smtp-Source: AGHT+IFVRVF+OTPowwVGMsQrnqemzaDlVy9gP9MkOUezU3WwupNCNHPJWQtKPfuqzn8ho8CScabJWg==
X-Received: by 2002:a17:906:c289:b0:a28:ac22:7575 with SMTP id
 r9-20020a170906c28900b00a28ac227575mr4846441ejz.4.1704645269773; 
 Sun, 07 Jan 2024 08:34:29 -0800 (PST)
Received: from panicking.. (mob-2-41-169-92.net.vodafone.it. [2.41.169.92])
 by smtp.gmail.com with ESMTPSA id
 fb20-20020a1709073a1400b00a2a9ddd15b8sm203578ejc.173.2024.01.07.08.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 08:34:29 -0800 (PST)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-amarula@amarulasolutions.com, u-boot@lists.denx.de,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [RFC PATCH] net: wget: Take in account tcp sequence number wrap around
Date: Sun,  7 Jan 2024 17:34:24 +0100
Message-Id: <20240107163424.25074-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.40.1
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

Coming from some discussion on mailing about wget unconsistent. It's
just and idea to play around

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---

I'm on a train ;). No board to test

---
 include/net/tcp.h | 10 ++++++++++
 net/wget.c        |  8 ++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index c29d4ce24a..584813b637 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -88,6 +88,16 @@ struct ip_tcp_hdr {
 #define TCP_MSS		1460		/* Max segment size		*/
 #define TCP_SCALE	0x01		/* Scale			*/
 
+/*
+ * The next routines deal with comparing 32 bit unsigned ints
+ * and worry about wraparound (automatic with unsigned arithmetic).
+ */
+static inline bool before(__u32 seq1, __u32 seq2)
+{
+	return (__s32)(seq1-seq2) < 0;
+}
+#define after(seq2, seq1)	before(seq1, seq2)
+
 /**
  * struct tcp_mss - TCP option structure for MSS (Max segment size)
  * @kind: Field ID
diff --git a/net/wget.c b/net/wget.c
index 8bb4d72db1..99a688846f 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -260,8 +260,8 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
 					(phys_addr_t)(pkt_q[i].pkt),
 					pkt_q[i].len);
 				store_block(ptr1,
-					    pkt_q[i].tcp_seq_num -
-					    initial_data_seq_num,
+					    (unsigned int)((s32)pkt_q[i].tcp_seq_num -
+					    (s32)initial_data_seq_num),
 					    pkt_q[i].len);
 				unmap_sysmem(ptr1);
 				debug_cond(DEBUG_WGET,
@@ -333,8 +333,8 @@ static void wget_handler(uchar *pkt, u16 dport,
 			   "wget: Transferring, seq=%x, ack=%x,len=%x\n",
 			   tcp_seq_num, tcp_ack_num, len);
 
-		if (tcp_seq_num >= initial_data_seq_num &&
-		    store_block(pkt, tcp_seq_num - initial_data_seq_num,
+		if (!before(initial_data_seq_num, tcp_seq_num) &&
+		    store_block(pkt, (unsigned int)((s32)tcp_seq_num - (s32)initial_data_seq_num),
 				len) != 0) {
 			wget_fail("wget: store error\n",
 				  tcp_seq_num, tcp_ack_num, action);
-- 
2.40.1

