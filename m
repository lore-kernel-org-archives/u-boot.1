Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6410ACF042B
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 23:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB9088811C;
	Wed,  9 Oct 2024 01:02:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LZav4wMc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 632B48811C; Wed,  9 Oct 2024 01:02:13 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB3A8880E6
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 01:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-109-097.46.114.pool.telefonica.de
 [46.114.109.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6A4EF40A54; 
 Tue,  8 Oct 2024 23:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1728428529;
 bh=0ii4nRdxxgDZZuyGfKOKQLOx3OIsxp1y9RjIYFNFNaI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=LZav4wMcvaGxDcgC82nqDwefPc+PdwA9wZBxY5TcN4Ci8TC2+bciRzXNEDR/R5C/l
 n92P5wxtxncDZryXa0qF1/jZIwX0vcnPhMwUGncJ4wKt0ubHSAAOYNmiY9Rk7Mh/Ij
 RarDUxzjCZb9tnc9epO4ywdsnEciVKOuNvb1pbFAX4dC9ijrM9NbNlZKUGq8wu8tQk
 1Jhu/RG7HVGG6DdLka/KdaqeoTEzVGraVolPj/5T2Vj8XvgKZwHgDfFmQ1DEI5wofu
 RjOe6hKXwFbo+YjBvejHzPx16CsTaZ2xK+Kp52GOAOYknoGlyd1iMqcJQQDyFRgQOv
 vmKvcCst+xLkQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] net: correct wget_connected debug messages
Date: Wed,  9 Oct 2024 01:02:05 +0200
Message-ID: <20241008230205.108375-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

* Remove duplicate debug message in wget_connected()
* Correct typo 'Connctd'

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 net/wget.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/wget.c b/net/wget.c
index b4251e0f293..f978adc9f0a 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -248,7 +248,7 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
 			wget_send(action, tcp_seq_num, tcp_ack_num, len);
 		} else {
 			debug_cond(DEBUG_WGET,
-				   "wget: Connctd pkt %p  hlen %x\n",
+				   "wget: Connected Pkt %p hlen %x\n",
 				   pkt, hlen);
 
 			pos = strstr((char *)pkt, content_len);
@@ -273,10 +273,6 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
 				}
 			}
 
-			debug_cond(DEBUG_WGET,
-				   "wget: Connected Pkt %p hlen %x\n",
-				   pkt, hlen);
-
 			for (i = 0; i < pkt_q_idx; i++) {
 				int err;
 
@@ -288,7 +284,7 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
 					  pkt_q[i].len);
 				unmap_sysmem(ptr1);
 				debug_cond(DEBUG_WGET,
-					   "wget: Connctd pkt Q %p len %x\n",
+					   "wget: Conncted pkt Q %p len %x\n",
 					   pkt_q[i].pkt, pkt_q[i].len);
 				if (err) {
 					wget_loop_state = NETLOOP_FAIL;
-- 
2.45.2

