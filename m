Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D687C4345F
	for <u-boot@archiver.kernel.org>; Sun, 14 Apr 2024 12:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE0EC880F9;
	Sun, 14 Apr 2024 14:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ogi1w4Nm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 514F5880C5; Sun, 14 Apr 2024 12:48:35 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1A8E880AB
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 12:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yasuharu.shibata@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ecf3943040so1825800b3a.0
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 03:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713091711; x=1713696511; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xXA67FPKeOTDfaT1/EcxpI3Jm6mVXffpaFL2NtyUSJk=;
 b=Ogi1w4NmFvFOVUxE47n+T1IZ7i50Iy6B5Pjw4VNthfdpA8uBTicG0LjFGWDqEnbQSK
 S1CXq83/o8rGCYK58fWKStIP4R0Qz1DQCkHbNu1R7kP5jj+qM6zyBXAauP/XPY3od45Y
 FQUFnamp2UjSNuFkbKUmhyj5x5bsTR4QfTWYOtvwN8x4wcNIW+fkp61ycDtfyM9Fhb7a
 KeZe4BK4kTG+fad8iSlraYXr+J8cdy11WMj7S1BWSZ+oQeDV6/aZVcXPiSqd9/faUCXv
 9rjhArEoP3udHS/9sNQQjEnjVUaKSdoCC11I6IQALGaUv5Uxu5U8M1StVgZDbVuQHBRN
 fbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713091711; x=1713696511;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xXA67FPKeOTDfaT1/EcxpI3Jm6mVXffpaFL2NtyUSJk=;
 b=X/5RAhZevGre1wCnU4ZW/F6XgbB2gAQiCW5uOHSEDTvRgOsrho8icF175w/YU9bSo4
 puNuZ/ULs8ioX69JqKYqQjIoJe1F6JP5D82eiXo/ayLYqu2D+ZMXa+wp9X7ZdUlKvotR
 VsSD10uXSbqlsnmhnz16376jJ9nbbRzb8G1uqbfbrIarKCxfsP4T2m6JJIL7GwFb9UYW
 DxlUF0FkLDfADa+N6BzOdnPrBmCp8pavlZi4wuuqp5NOClM3+8t1J4pT+ZCWFRp2nlm2
 rIVCHUj87CzoGY2+S9ebU0BokLE+o+b0HquimiS/cpTEqfVb7dDm4yY8aGoT1EF0r2i2
 s7Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrDbhC6Twr7f9L5p1Prp/nncV7bQl7SnI5p49wX532JfWEewerpYnkgnRpdqCwT7ubeOAwd0zMlDrOnjMbCOEuG7m3bg==
X-Gm-Message-State: AOJu0YwdjMSpcvzippLCDNHNoDUEp068KmSMeHZtGUl56sdau6aIh/8s
 km4AXRycRRJxQ9hi1lNFphPk12xOj7zjohgGu1VV3St67SvU5dNBoDRvtQ==
X-Google-Smtp-Source: AGHT+IEfkkZgx6SrAMDJNSsNapCxeqU9oiT2UAyTuhVM4+q5eG6TfjrBgbRHMr+C3AzvdEcW6MZqHQ==
X-Received: by 2002:a05:6a21:2d06:b0:1a9:c4cc:721d with SMTP id
 tw6-20020a056a212d0600b001a9c4cc721dmr4281724pzb.57.1713091711050; 
 Sun, 14 Apr 2024 03:48:31 -0700 (PDT)
Received: from localhost.localdomain ([2409:10:d8a0:1500:8e5b:6a40:e20e:7f49])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a17090ad38200b002a232e4f9ddsm5267434pju.34.2024.04.14.03.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Apr 2024 03:48:30 -0700 (PDT)
From: Yasuharu Shibata <yasuharu.shibata@gmail.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Yasuharu Shibata <yasuharu.shibata@gmail.com>,
	u-boot@lists.denx.de
Subject: [PATCH] net: wget: Support retransmission a dropped packet
Date: Sun, 14 Apr 2024 19:46:07 +0900
Message-Id: <20240414104607.5966-1-yasuharu.shibata@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 14 Apr 2024 14:45:45 +0200
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

The server sends multiple packets without waiting for an ACK
by window control and if some packets are dropped,
wget will return an ACK including the dropped packets.

Following log indicates this issue.

  wget_handler() wget: Transferring, seq=97bbdd4a, ack=30,len=580
  wget_handler() wget: Transferring, seq=97bbedca, ack=30,len=580

First packet of TCP sequence number is 0x97bbdd4a.
Second packet of TCP sequence number should be 0x97bbe2ca,
however it is 0x97bbedca and returns its ACK, so the server
suppose that 0x97bbe2ca and 0x97bbedca are received appropriately.
In this case, 0x97bbe2ca was lost and the data of wget was broken.

In this patch, next_data_seq_num holds the next expected
TCP sequence number.
If the TCP sequence number different from next_data_seq_num,
trying to retransmit the packet.

Signed-off-by: Yasuharu Shibata <yasuharu.shibata@gmail.com>
---
 net/wget.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/wget.c b/net/wget.c
index 817c5ebd5d..71bac92d84 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -50,6 +50,7 @@ static unsigned long content_length;
 static unsigned int packets;
 
 static unsigned int initial_data_seq_num;
+static unsigned int next_data_seq_num;
 
 static enum  wget_state current_wget_state;
 
@@ -272,17 +273,18 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
 
 		current_wget_state = WGET_TRANSFERRING;
 
+		initial_data_seq_num = tcp_seq_num + hlen;
+		next_data_seq_num    = tcp_seq_num + len;
+
 		if (strstr((char *)pkt, http_ok) == 0) {
 			debug_cond(DEBUG_WGET,
 				   "wget: Connected Bad Xfer\n");
-			initial_data_seq_num = tcp_seq_num + hlen;
 			wget_loop_state = NETLOOP_FAIL;
 			wget_send(action, tcp_seq_num, tcp_ack_num, len);
 		} else {
 			debug_cond(DEBUG_WGET,
 				   "wget: Connctd pkt %p  hlen %x\n",
 				   pkt, hlen);
-			initial_data_seq_num = tcp_seq_num + hlen;
 
 			pos = strstr((char *)pkt, content_len);
 			if (!pos) {
@@ -396,6 +398,12 @@ static void wget_handler(uchar *pkt, u16 dport,
 			   "wget: Transferring, seq=%x, ack=%x,len=%x\n",
 			   tcp_seq_num, tcp_ack_num, len);
 
+		if (next_data_seq_num != tcp_seq_num) {
+			debug_cond(DEBUG_WGET, "wget: seq=%x packet was lost\n", next_data_seq_num);
+			return;
+		}
+		next_data_seq_num = tcp_seq_num + len;
+
 		if (tcp_seq_num >= initial_data_seq_num &&
 		    store_block(pkt, tcp_seq_num - initial_data_seq_num,
 				len) != 0) {
-- 
2.25.1

