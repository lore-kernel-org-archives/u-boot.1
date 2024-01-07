Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2065C47074
	for <u-boot@archiver.kernel.org>; Sun,  7 Jan 2024 20:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2193F87A22;
	Sun,  7 Jan 2024 21:01:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SawQqcfh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43B6587A23; Sun,  7 Jan 2024 21:01:12 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E24E87A14
 for <u-boot@lists.denx.de>; Sun,  7 Jan 2024 21:01:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a293f2280c7so123866866b.1
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 12:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1704657670; x=1705262470;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rI6gtQ7jlvHaX1z1bqTVaN3lAbCdW4kY6qZ7zLbGCYw=;
 b=SawQqcfhecRqW58Ql/wag/UPQHC32MnPXAg/s3Y2GUiBJW1SE7S9j1tM/5qtkqHvs5
 aXT4jrjxFjs9685MCCcymU2xOGnR8JQdseMGA2Mz6FJOoYaoSer+xldVXztDM0ibYb59
 c+8lZYEPRBQeFKtpa/rx7dKA5Kb3OzBUtbvmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704657670; x=1705262470;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rI6gtQ7jlvHaX1z1bqTVaN3lAbCdW4kY6qZ7zLbGCYw=;
 b=qs/2m1OEVOQu3d2agVJQgSPVxzbeCnia+memENm5ri/BcJxN8zWjDTcdRbixHXy5PM
 4x6nGbBotnc309vykRykW2QqoyCyxr2iIhAOWmWNsF7fWI9DKiOaWWd6SLQlQyVRACV/
 mG+NOfOfcRNo0HfcnIP1N5NicS/Nu0zj2+2hFc/b32W3GfQKcBmYk05Xt9mSdZXZs1dC
 ZRaSXIxUIT6jX7uBU8RKh1EfEUtxB4qBBV3nH/H+UFVS37vZNOBxFFiXnmJMMfzSQqiX
 ejD1RAsAuCLHRLQYr2Zk0k9p+V6MWfshMhw82SpAETf7TElK/8Dnc1y8x2T0v+eHuKJz
 caZg==
X-Gm-Message-State: AOJu0Yx3ZDGuCff2+ecZCYx5XY8ixasythP9xjvMYNMQ+lVE6LubOPZw
 F1IUMdRsA4kFfBRafiMTWViaUFStusJz1g==
X-Google-Smtp-Source: AGHT+IHe6t4Xz39Pxs4m7IpOzKTtpaFkZiGmGdwvapxRcly5MOwNDpC5+7XrwTmONsm+KEy2wone1A==
X-Received: by 2002:a17:906:6a81:b0:a28:d132:c4ab with SMTP id
 p1-20020a1709066a8100b00a28d132c4abmr678960ejr.48.1704657669669; 
 Sun, 07 Jan 2024 12:01:09 -0800 (PST)
Received: from panicking.. (mob-2-41-161-21.net.vodafone.it. [2.41.161.21])
 by smtp.gmail.com with ESMTPSA id
 uz29-20020a170907119d00b00a2aae23b414sm204016ejb.26.2024.01.07.12.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 12:01:09 -0800 (PST)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-amarula@amarulasolutions.com, u-boot@lists.denx.de,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [RFC PATCH V2] net: wget: Take in account tcp sequence number wrap
 around
Date: Sun,  7 Jan 2024 21:01:02 +0100
Message-Id: <20240107200102.19249-1-michael@amarulasolutions.com>
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
RFC V1 -> RFC V2:
	- drop random train change in unsigned difference

---
 include/net/tcp.h | 10 ++++++++++
 net/wget.c        |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

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
index 8bb4d72db1..020503b763 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -333,7 +333,7 @@ static void wget_handler(uchar *pkt, u16 dport,
 			   "wget: Transferring, seq=%x, ack=%x,len=%x\n",
 			   tcp_seq_num, tcp_ack_num, len);
 
-		if (tcp_seq_num >= initial_data_seq_num &&
+		if (!before(initial_data_seq_num, tcp_seq_num) &&
 		    store_block(pkt, tcp_seq_num - initial_data_seq_num,
 				len) != 0) {
 			wget_fail("wget: store error\n",
-- 
2.40.1

