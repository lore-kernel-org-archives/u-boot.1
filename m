Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950FDC3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 12:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 224BC889B8;
	Wed, 14 Aug 2024 14:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZOdTFXBI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56D62889BA; Wed, 14 Aug 2024 14:48:04 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD67F87C69
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 14:48:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yasuharu.shibata@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70d399da0b5so5385051b3a.3
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 05:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723639680; x=1724244480; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zo9el2NQR6QJ1FfL+fXZ8QzES733LovR7zSDbMYr5Ns=;
 b=ZOdTFXBI/SddKA4nnA8RBQA6FkpY09YpK7g8pk0zktfgDmOTOfcoN0Q1fwV+yYMSFk
 FZilMILSv8PxHcT5sXtK2ph5V8KMDug2M3xLvxXf97ZuvJu9i/+4hmfUwu1LXHD2Dh5l
 RlLg51fFPbPz6kTbcGcS3GCPreCu6z1JB6X13gR3un31UbtH+ZWexyGPlOkcmfBjVA/0
 u0UNXg74xCCG5KaVHgHE8v6oIkVWvjO/zQZX3iAolabMHXuPON5qedRlNNoR5gELqPhb
 YgWsp8hn8JtbjHTB8ES7+mr73p9ovVMIwZXeqxGUbO0RRu80QbXDXTPWzeUEBzBCbsje
 CAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723639680; x=1724244480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zo9el2NQR6QJ1FfL+fXZ8QzES733LovR7zSDbMYr5Ns=;
 b=B2+mRttzlsz/qguAgSfwdYS553v97Zgcuo0EB6oaEwXfVu33/XEzKFIWJEiisUbZ5G
 Fvh4mpu2785MvE2HhMPi591i3zF3Vba06WLMbeY27bDyoEHS1tivkp0MGmuIqfRbk0tr
 /JP0T4LdvP1mg/u+FR9p/Xh/i+MiMOisRw91IILtjPHxgh1a6uBp+HjiLsH1mYocnQxe
 wbfM/1Si1Mup2bkKF4XA8DpEFyDGasoX6wyE3zmZ4gBqsUkEP220Uu2QVXKz0nC/H4Xd
 FFIjGX+xMvMmU8MwO60nHJk72TxMnmn2YO8LwZiksUH7rDPDVXy2f7Xrlyv8lxeB/MO8
 iuhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrNSE5o5l9vS0wQMW4KivcW1zX+9YImch1+zocBoN6jiyJKVFDnZN/U3tZoWkFm98cLswyMMQb6D87AJXSdLW8fd8oyg==
X-Gm-Message-State: AOJu0YwkdH6hTK0T05Y+yh05YAlWoARWTXXd2MhID0d0bcgjdGKTAGZt
 O37rKq1QxGQvTYmI1RLPvvIY5AjoG5RdJUNxMlYUkyOqU4C34+CwWMk1Fw==
X-Google-Smtp-Source: AGHT+IFNwSRf8KW6KY2U9edb5SBtcQ9rLLaxigaxTMyqU09Z/A0ogcJM95fpk6bNIdUCkGQB545dfg==
X-Received: by 2002:a05:6a21:e89:b0:1c6:ba8b:1e27 with SMTP id
 adf61e73a8af0-1c8eae4b4c7mr3350306637.10.1723639680099; 
 Wed, 14 Aug 2024 05:48:00 -0700 (PDT)
Received: from localhost.localdomain ([2409:10:d8a0:1500:813e:3244:5b45:7c7f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd1b8417sm28768665ad.187.2024.08.14.05.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 05:47:59 -0700 (PDT)
From: Yasuharu Shibata <yasuharu.shibata@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH 2/2] sandbox: fix wget test failure after fixing wget issue
Date: Wed, 14 Aug 2024 21:41:07 +0900
Message-Id: <20240814124108.2885-2-yasuharu.shibata@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240814124108.2885-1-yasuharu.shibata@gmail.com>
References: <20240814124108.2885-1-yasuharu.shibata@gmail.com>
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

After applying the following patch, wget test on sandbox failed[1].

  Commit: cab7867cff ("net: wget: Support retransmission a dropped packet")

Here are two reasons why the test is failed and how to fix it:

1. tcp_ack is calculated by the wrong value.
   tcp_ack needs to be calculated by the received TCP payload size.
2. wget command may have a problem that HTTP response from server
   must be divided into more than two packets.
   In this commit, HTTP response is divided into two packets.

In addition, I fixed the HTTP response returned at the correct timing.

[1] https://lore.kernel.org/u-boot/CAFLszThEbk2Jr8OZ6Hj21wPSnJjgJhaDe037RqwHvwt1KjB3_A@mail.gmail.com/

Signed-off-by: Yasuharu Shibata <yasuharu.shibata@gmail.com>
Reported-by: Simon Glass <sjg@chromium.org>
---
 test/cmd/wget.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/test/cmd/wget.c b/test/cmd/wget.c
index 356a4dcd8f..11a07c08f4 100644
--- a/test/cmd/wget.c
+++ b/test/cmd/wget.c
@@ -26,6 +26,8 @@
 #define SHIFT_TO_TCPHDRLEN_FIELD(x) ((x) << 4)
 #define LEN_B_TO_DW(x) ((x) >> 2)
 
+int net_set_ack_options(union tcp_build_pkt *b);
+
 static int sb_arp_handler(struct udevice *dev, void *packet,
 			  unsigned int len)
 {
@@ -105,6 +107,10 @@ static int sb_ack_handler(struct udevice *dev, void *packet,
 	const char *payload1 = "HTTP/1.1 200 OK\r\n"
 		"Content-Length: 30\r\n\r\n\r\n"
 		"<html><body>Hi</body></html>\r\n";
+	union tcp_build_pkt *b = (union tcp_build_pkt *)tcp;
+	const int recv_payload_len = len - net_set_ack_options(b) - IP_HDR_SIZE - ETHER_HDR_SIZE;
+	static int next_seq;
+	const int bottom_payload_len = 10;
 
 	/* Don't allow the buffer to overrun */
 	if (priv->recv_packets >= PKTBUFSRX)
@@ -119,13 +125,31 @@ static int sb_ack_handler(struct udevice *dev, void *packet,
 	tcp_send->tcp_dst = tcp->tcp_src;
 	data = (void *)tcp_send + IP_TCP_HDR_SIZE;
 
-	if (ntohl(tcp->tcp_seq) == 1 && ntohl(tcp->tcp_ack) == 1) {
+	if (ntohl(tcp->tcp_seq) == 1 && ntohl(tcp->tcp_ack) == 1 && recv_payload_len == 0) {
+		// ignore ACK for three-way handshaking
+		return 0;
+	} else if (ntohl(tcp->tcp_seq) == 1 && ntohl(tcp->tcp_ack) == 1) {
+		// recv HTTP request message and reply top half data
 		tcp_send->tcp_seq = htonl(ntohl(tcp->tcp_ack));
-		tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + 1);
-		payload_len = strlen(payload1);
+		tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + recv_payload_len);
+
+		payload_len = strlen(payload1) - bottom_payload_len;
 		memcpy(data, payload1, payload_len);
 		tcp_send->tcp_flags = TCP_ACK;
-	} else if (ntohl(tcp->tcp_seq) == 2) {
+
+		next_seq = ntohl(tcp_send->tcp_seq) + payload_len;
+	} else if (ntohl(tcp->tcp_ack) == next_seq) {
+		// reply bottom half data
+		const int top_payload_len = strlen(payload1) - bottom_payload_len;
+
+		tcp_send->tcp_seq = htonl(next_seq);
+		tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + recv_payload_len);
+
+		payload_len = bottom_payload_len;
+		memcpy(data, payload1 + top_payload_len, payload_len);
+		tcp_send->tcp_flags = TCP_ACK;
+	} else {
+		// close connection
 		tcp_send->tcp_seq = htonl(ntohl(tcp->tcp_ack));
 		tcp_send->tcp_ack = htonl(ntohl(tcp->tcp_seq) + 1);
 		payload_len = 0;
@@ -148,11 +172,9 @@ static int sb_ack_handler(struct udevice *dev, void *packet,
 			  pkt_len,
 			  IPPROTO_TCP);
 
-	if (ntohl(tcp->tcp_seq) == 1 || ntohl(tcp->tcp_seq) == 2) {
-		priv->recv_packet_length[priv->recv_packets] =
-			ETHER_HDR_SIZE + IP_TCP_HDR_SIZE + payload_len;
-		++priv->recv_packets;
-	}
+	priv->recv_packet_length[priv->recv_packets] =
+		ETHER_HDR_SIZE + IP_TCP_HDR_SIZE + payload_len;
+	++priv->recv_packets;
 
 	return 0;
 }
-- 
2.20.1

