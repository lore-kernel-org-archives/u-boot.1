Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7244FC3DA7F
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 20:53:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49E2E888E0;
	Sat, 10 Aug 2024 22:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FiFyLKp+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 611138894F; Sat, 10 Aug 2024 22:52:36 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56194888D4
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 22:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-81f921c40f2so119744539f.0
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 13:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723323147; x=1723927947; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JnmYWz3RLaAkBjoSdGO3gDA82BcJWxg/Oy85hPxXEzw=;
 b=FiFyLKp+UBykyZ5wPOvaEyrHtakEIXZQtWFpiD6Kl4hNwnjiuYTodMeot3h2EatCKN
 gtu2P51NTA+RMOf04A3XExM+x30SleQC1hMti/QSL9OanA4KVn7dWEcnvRd/TTXlm5iV
 pseOhZEHi1HgPYF/zK1KkgCPmAPsHfSoM3ffg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723323147; x=1723927947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JnmYWz3RLaAkBjoSdGO3gDA82BcJWxg/Oy85hPxXEzw=;
 b=fvO+/UZgH/ZX0xPNdlovkzPi2FuSOY0//z8Fak7OZnMCqNwuLrzKkWgCP39z7soI0G
 y+zSqU67v35dhOtupTBwPJCuvX0KteDZCUFNRGU/D07buNf/YVRAlK98yjuPF5HI+2Xo
 lQZYOKuZFLe9cRMMVfFntut80Kmd2RNxCPPnX5IU0pqYz/LOSQA3WfcSdvtEBGgnE409
 nM5rjtyACJ4w9E9iEUEzTMo3dlFuRdrhFIR9MQGZGAgopjgw4IA12WzaQ8B/Sdm1svcT
 e8AKqaneTxw1elh8KQBcc8aTnMrAoC5ikb6Jh3BH5+Jq0DiF/U4kfY8R6p+yBxTs1yTo
 Y5mQ==
X-Gm-Message-State: AOJu0YxAfRN0z9OWI1IlBiREhnTZZEn9Ot29SnK2BL5n+esiBshoxlaO
 wdFvrsGEJRF7VVOcAq2zwSg/73S2jbLZs6LTib2mlueL+8WBm8ZqW4Dfob/VTTmt4ZofvxVK8Qw
 =
X-Google-Smtp-Source: AGHT+IHMu9EP+NVFkCO4ObpeNb1Xq7CLMGfODMw3Yrjfn1lvYjjeoXP0LnCCMbym0l68bjWQDyBkTQ==
X-Received: by 2002:a05:6602:27ce:b0:81f:bcd2:24e with SMTP id
 ca18e2360f4ac-8225ee874d3mr864050139f.9.1723323147049; 
 Sat, 10 Aug 2024 13:52:27 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82266f56333sm82893139f.0.2024.08.10.13.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 13:52:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Ramon Fried <rfried.dev@gmail.com>, Richard Weinberger <richard@nod.at>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>
Subject: [PATCH 07/21] Revert "net: wget: Support retransmission a dropped
 packet"
Date: Sat, 10 Aug 2024 14:51:51 -0600
Message-Id: <20240810205205.3403177-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810205205.3403177-1-sjg@chromium.org>
References: <20240810205205.3403177-1-sjg@chromium.org>
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

This breaks the wget tests, so revert it until a proper fix can be
figured out.

This reverts commit cab7867cff33f9c21025102ea9ca3b26e362fb52.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 net/wget.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/net/wget.c b/net/wget.c
index f1dd7abeff6..5eabb413116 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -49,7 +49,6 @@ static unsigned long content_length;
 static unsigned int packets;
 
 static unsigned int initial_data_seq_num;
-static unsigned int next_data_seq_num;
 
 static enum  wget_state current_wget_state;
 
@@ -272,18 +271,17 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
 
 		current_wget_state = WGET_TRANSFERRING;
 
-		initial_data_seq_num = tcp_seq_num + hlen;
-		next_data_seq_num    = tcp_seq_num + len;
-
 		if (strstr((char *)pkt, http_ok) == 0) {
 			debug_cond(DEBUG_WGET,
 				   "wget: Connected Bad Xfer\n");
+			initial_data_seq_num = tcp_seq_num + hlen;
 			wget_loop_state = NETLOOP_FAIL;
 			wget_send(action, tcp_seq_num, tcp_ack_num, len);
 		} else {
 			debug_cond(DEBUG_WGET,
 				   "wget: Connctd pkt %p  hlen %x\n",
 				   pkt, hlen);
+			initial_data_seq_num = tcp_seq_num + hlen;
 
 			pos = strstr((char *)pkt, content_len);
 			if (!pos) {
@@ -397,13 +395,9 @@ static void wget_handler(uchar *pkt, u16 dport,
 			   "wget: Transferring, seq=%x, ack=%x,len=%x\n",
 			   tcp_seq_num, tcp_ack_num, len);
 
-		if (next_data_seq_num != tcp_seq_num) {
-			debug_cond(DEBUG_WGET, "wget: seq=%x packet was lost\n", next_data_seq_num);
-			return;
-		}
-		next_data_seq_num = tcp_seq_num + len;
-
-		if (store_block(pkt, tcp_seq_num - initial_data_seq_num, len) != 0) {
+		if (tcp_seq_num >= initial_data_seq_num &&
+		    store_block(pkt, tcp_seq_num - initial_data_seq_num,
+				len) != 0) {
 			wget_fail("wget: store error\n",
 				  tcp_seq_num, tcp_ack_num, action);
 			net_set_state(NETLOOP_FAIL);
-- 
2.34.1

