Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7397E606A888
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RVIW94uR;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GTHyfHm8
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 812C360886;
	Tue, 17 Nov 2026 13:18:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1sC6Bx5dorFG; Tue, 17 Nov 2026 13:18:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DD38760872
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794921498;
	b=WmtSy0yNMEuKoNUVgEBUKxT6s6BUluen1wts3X+NHWfRyQPrZ9uD0rvd6gFzt/YYDK5r
	 inJTTgzllOJ62eflPCaShGznCuZ1wtolGF6zOESbe8CcyZLJw0qEMpexrfaadw5Ltd0Py
	 NQeuJ2m5r7eBcYMu42HXZW9yBeHCIjZFod/Dvyf4fs6PZHt+cO5AUegNYeyz0KSPE9p4/
	 H6N/j34/y4Jh29SkzS3ZUbRk0nfAJGlqoshfGsAzmq6byHgPspsAthIZ+/+U557s7KEQE
	 dhkp1URovcGufJZz8IJ50xoqnseaWY0JAz/UV2aalUVHlvxEz9LEAYxjV7N7Jp/04oQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794921498;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7zfIhX+9OBiriF34DgNNR45MFiKsYZqrcZhQum8o/UQ=;
	b=tcvFZxKS4xaSKH9jVZMvmFHSGtvPfZ8c1IXMRcpXmzQfp/lo8ALLC7JegA8Y8Y/gOyDl
	 GpGmssMq8L/SLmB3CqJCwgJNJojLpJE5ye0Is3Ba6h9U0lAIw0JNRP+/FoYVXWhjBT5H9
	 BPYn5oe1BoI8UjR0Q6Aeye1W/6tsA5hpMuc6zRur05HSLHi2LzP1x5hBPK7vTP8TRFQVf
	 3SBNGHU9ys4WqALmab1wEaEg+o9oJ426g+9fH8M8SOOt1ERcBcsxpoDd3iZHdH2pnurRd
	 aWcfLG0/XZknQP3V9Tur4eaA8DkVmKR8D6wrnjgWhEjBgcRtNOylLqHPcpcqL9Rqz1w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794921498;
	bh=7zfIhX+9OBiriF34DgNNR45MFiKsYZqrcZhQum8o/UQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RVIW94uRE5iZwGebOcWGYfehHYo30VYJAie5jlRrRl5q3CzYuF9kE1rf7+6Gg8pak
	 FuTwjVRjVVWEEo0gZGtHWdjnzi/kZJcSZ5z4b1b6GUO3Z5UCAtWwmRPw/fiAi69NXV
	 q06UkSUaDT+/nFdohCkIY7muRQPi0iN2mXQjQI8sXgjI9GRDvIueI5k6mV+FYY0ah0
	 CVY6zDbdnAB048gW9TWUS7H4MQaO4uzle+YHH48+lEg4baHVV3m7dwlS2K+N9IcVYA
	 Kq8EadK/OVYW7CtjUAxB0I6pa9pZlDjglx+x421rXa7igk8jLyjC3qSbpa+cVT9Luz
	 Xn75jPdxYU6Kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD38760872;
	Tue, 17 Nov 2026 13:18:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 18C93A32
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 08:57:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0678A405B2
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 08:57:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6wsCdTdP0NnO for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 08:57:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ED9BF4071F
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ragaprasanth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=GTHyfHm8
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ED9BF4071F
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 08:57:08 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B23684717; Tue, 17 Nov 2026 09:57:06 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5090B847E6
 for <u-boot@lists.denx.de>; Tue, 17 Nov 2026 09:56:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ragaprasanth@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3b3bf3bef9aso97909a91.1
 for <u-boot@lists.denx.de>; Tue, 17 Nov 2026 00:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794905817; x=1795510617; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7zfIhX+9OBiriF34DgNNR45MFiKsYZqrcZhQum8o/UQ=;
 b=GTHyfHm8nxIRiyo7yBugHPzvrIgoo5dWtARYPCU7tmlYNhkv+mjHbE9QLErSZC9BOA
 BnzKst3aG1ko+zMjKpKb/xD6JvSVLcUcpICk3yKEnjrIfMLpBz8Bi3dRJN9YBI6bVOdz
 1tifQzQ77/oHxZnMbp483ajA4donTqpgFRHkV30QyMsQSrVcYuddisw/fX+B9W5lgzKI
 Kw5VMC6XW9Z2KhOGt1PCnFjq0N/tl9goCT5yNDEU//byW9yLYW4byS3PoigHxUF0j/zL
 ngJ2M8XaIE3YA4fx3pemv19gi/KqP1JdzGXyhBxn/X5KdBxSe7kebYNK6NG2846SeDs4
 ulZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794905817; x=1795510617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7zfIhX+9OBiriF34DgNNR45MFiKsYZqrcZhQum8o/UQ=;
 b=mv7WgmycyzwvTkPCrT0RdaSa3YCoJZi2kfLd+6KH/MzL1rl+BTXARassHzuukhTEBU
 dS1WZ8ZTLvv7ksyGQqseTFMJEqt0uYkaHlZNr6UYt1+Zht8BfH+DWYpckOJjpJ0snb40
 VRUq8zIICyXTLZWFR2WaNPveDdoDBVpFG5tfhuS4TtbrjO2hBS8E9UCygUS+Q4XijWp7
 qOuVNDa6sbshoYdyylMQYMWTj7kBqn9bNglSIEiXhcFDgf1kszWyeww9IYjiIznWrktH
 doDnjk3qeyiJ1Gl2owvVL3H2zXCJm+xW0u2fWLYbpNkxmGrsICz/vagoYH4+eZjoQsCJ
 /3uQ==
X-Gm-Message-State: APuU4Z/hSlcu5JMzBPYU06M6vF2q8ccQ7oPw6FkvvG7RkUlatIgPAsIw
 mJrKC2PNS0J5nFWhHIfHlfvb0VkSmLHex/EFGAeYtbVjXL1J5Z6mFxC6qJ/WIrku
X-Gm-Gg: AZFdTZdN3GTE2TwegZ2f0iItPYYroffJt8HnvX6ORoFyobMr8DetXSLA5jBhuof7xCK
 QU0ZtDJeJOGRU4ksORBTlyCwbJNh0F+2OpBsqa4UJjVloPHBNtvhWdAPSVjfORflMRXrsnCsK4x
 lVUxb9ADZy3sGFAGJQNRhDviiONvCaJ3Bda2yEEG6uLqvc8bvYbSmCB6KIKdYCG4qJQIXa+Ei+L
 uA5lRdvhWpXMiwMJhYIB9DEqWPyvjdOa+jl4g0CqH1lFoSn/DwCNLji0sY8u1mIsThKv8hKb5WF
 HHIf+/64DqVUybc7bcqIktQb/oEDIEYYDDmZ1M+0rbxLAa1K6dAKK1KXJWnjOmf5SIpcfF3Q9Ra
 uDBOibYWu+Eh1nN8BEnbPsFEWZHEGoIIghHTd1VAIdySd4CFCqGXFXSYungIkHVPAg2PzzfS1J6
 3VKEe9hHuZH4BedrqpxvrjSBb9G3mP4GwhEe3CwsWUZtuNWBce8KxhP+9xeoca11BGAFTE1DyfJ
 wCF4dPewuJgx6n3jjlPWqkoNeQnpBW5C4dq0UnAgY7gZyIYfDx2g0Dwlxq6DKiBiy/Gx5cKwisV
 lH61eZrnlweba7EclY4jejdduxQS1LfnUljT36oYIGY2kRNyXecnSBzNCB6ZJVDBETntpWavMeW
 7bfmTN0LVXg==
X-Received: by 2002:a17:90b:4a05:b0:3ac:9176:e81c with SMTP id
 98e67ed59e1d1-3b1b0cdb2efmr11585077a91.46.1794905817432; 
 Tue, 17 Nov 2026 00:56:57 -0800 (PST)
Received: from prasanth.alps.lineo.co.jp (vpn1.lineo.co.jp. [203.141.200.204])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ac4d98b8sm3035228a91.13.2026.11.17.00.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 00:56:57 -0800 (PST)
From: Prasanth R <ragaprasanth@gmail.com>
To: u-boot@lists.denx.de
Cc: jerome.forissier@arm.com, trini@konsulko.com,
 Prasanth R <ragaprasanth@gmail.com>
Subject: [PATCH 2/2] net: tcp: check option lengths in tcp_parse_options()
Date: Tue, 17 Nov 2026 17:56:45 +0900
Message-Id: <20261117085645.3142669-3-ragaprasanth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117085645.3142669-1-ragaprasanth@gmail.com>
References: <20261117085645.3142669-1-ragaprasanth@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 17 Nov 2026 13:18:13 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tcp_parse_options() reads the length byte of an option without checking
that it is inside the option area, and reads the window scale and
timestamp values without checking the option length. A truncated or
malformed option makes it read past the end of the options.

Check that each option and its length byte fit in the remaining
options, and only use the window scale and timestamp when the option
has the expected size. Limit the window scale to 14 as RFC 7323 says,
so the window shift in tcp_rx_state_machine() stays defined.

Fixes: a3bf193bf4ea ("net: Add TCP protocol")
Signed-off-by: Prasanth R <prasanth.r@lineo.co.jp>
---
 net/tcp.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index 737a079ec5c..cde3319bc4b 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -776,38 +776,42 @@ void tcp_parse_options(struct tcp_stream *tcp, uchar *o, int o_len)
 {
 	struct tcp_t_opt  *tsopt;
 	struct tcp_scale  *wsopt;
+	uchar *end = o + o_len;
 	uchar *p = o;
+	u8 len;
 
-	/*
-	 * NOPs are options with a zero length, and thus are special.
-	 * All other options have length fields.
-	 */
-	for (p = o; p < (o + o_len); ) {
-		if (!p[1])
-			return; /* Finished processing options */
+	while (p < end) {
+		if (p[0] == TCP_O_END)
+			return;
+		if (p[0] == TCP_1_NOP) {
+			p++;
+			continue;
+		}
 
-		switch (p[0]) {
-		case TCP_O_END:
+		/* All other options have a length byte covering kind and len */
+		if (end - p < TCP_OPT_LEN_2)
 			return;
-		case TCP_O_MSS:
-		case TCP_P_SACK:
-		case TCP_V_SACK:
-			break;
+		len = p[1];
+		if (len < TCP_OPT_LEN_2 || len > end - p)
+			return;
+
+		switch (p[0]) {
 		case TCP_O_SCL:
+			if (len != TCP_OPT_LEN_3)
+				break;
 			wsopt = (struct tcp_scale *)p;
-			tcp->rmt_win_scale = wsopt->scale;
+			/* RFC 7323: a shift count above 14 is treated as 14 */
+			tcp->rmt_win_scale = wsopt->scale > 14 ? 14 : wsopt->scale;
 			break;
 		case TCP_O_TS:
+			if (len != TCP_OPT_LEN_A)
+				break;
 			tsopt = (struct tcp_t_opt *)p;
 			tcp->rmt_timestamp = tsopt->t_snd;
 			break;
 		}
 
-		/* Process optional NOPs */
-		if (p[0] == TCP_1_NOP)
-			p++;
-		else
-			p += p[1];
+		p += len;
 	}
 }
 
-- 
2.34.1

