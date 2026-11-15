Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA580606A31D
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jyCmxOjL;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ks0G1Hyq
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95AD76067A;
	Sun, 15 Nov 2026 19:00:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GjGLASlzopdr; Sun, 15 Nov 2026 19:00:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C323D60765
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794769241;
	b=LrjGb7odndWJN5z5Pmhj0XiLq8fX2OpkZpfIg4ewCeBeoDEaSqVkVAgTO64kjpk2YL3c
	 72RUQGDuE/B+WaQ5P8Z9kqwS5lDLG06EJdMLeEXc/nDfMuLDcnxxbcBuc7kS6mKzb+zZm
	 8xg+9bPHlW0rXKe3yzL/Z5L0GMmotiSZOvhBU9ypVMrB1ub3Kc7Ky20XFVNnJMd4CjLyO
	 VSxbWbLd8jkFNu8me2hAcQ3igHsTaFNlfvFilstYTIXxLHmb62OXWwRFpZWy53JmgEzle
	 K2/uHNt/B/ClNn/Vbh7NV1pZuRh0OB6a+w8OLCuIQWX2nIQshfQIeDR0Ssird5Wc70g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794769241;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RGSaqJ9uzdPbC8s1AOkaFU8TilcJyLfSi7qo0gxhOks=;
	b=EU7aa4YYiq8PIRXW2Vd0hgKM6tI69HZiBuIYcLDhJr9Ip5DCIDsvBFHDNGSMXZ+itXvK
	 1qPqULAR8VIgkdnoX0aJUjBMS6Ml3Ethu75c7XeqTa5bv6h4EaxVTkU28j+4YeFCWBu3K
	 a8YQDTSpxLJuDL4m5+UgeAzhiU8SU6B92Hb9Zbh2jcIY1qIasNBzPya4ZR/6TuKOFrIW6
	 nwWtcenhzvPjxtvzZbKnA+22/MXu0yuS1gZGGztam9WvxnYh8y6zyNddpezgO5IfYPSng
	 VKX0klu8sYlC9CEhxVQvPmH2yjN+JqWLpVDyVdzzVSdctlPmgEBfNksqBeTuBmeQ/Rg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ks0G1Hyq;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794769240;
	bh=RGSaqJ9uzdPbC8s1AOkaFU8TilcJyLfSi7qo0gxhOks=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jyCmxOjLzx+rPlrYGyzyScGmYgd80h6qOboFaNiGBC0TqJnOZtwk+qjUlnaPIZYrP
	 +kDpU+KQbJY/4IldNlN9fqhf/JUqJ/+W/bVM8T1IbQ3ucbD9Y+koyxbk9D6nSjCpft
	 G7VeqhMDEjO9EW+oeNk9ZSD3T8uF/XTaOOUGzFjEikvuIfZbWtQuWbXHGOulHmUiAl
	 sERH8KZ3GIMH0wMP68eiv6CQgaqcxQOAAcNpneYniJ371Z239seOiutsbzW+O8GYff
	 cUpjgRwE+LajBXvCpSQQ4qpgFXuShQt8uVp1Pbarcx9ZXkn+mRWoRDWJ4HG3fWcYf2
	 DsEtqc2jH1e9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C323D60765;
	Sun, 15 Nov 2026 19:00:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 510D81A6
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 17:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 43459605E5
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 17:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y9Pxog9s4a4k for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 17:12:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 603DB60602
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::e30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e30; helo=mail-vs1-xe30.google.com;
 envelope-from=georgekola@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20260707 header.b=ks0G1Hyq
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 603DB60602
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 17:12:18 +0000 (UTC)
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-7cc53938a8fso3434157137.2
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 09:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794762738; x=1795367538;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RGSaqJ9uzdPbC8s1AOkaFU8TilcJyLfSi7qo0gxhOks=;
 b=ks0G1HyqAOwiA0c3WKIXmpfSXQfmw9VDncgMUTR179cT6MdEubNJeBcWOenKgTV/Xh
 A19hzd6zP5atFxpo9q61JDl1eubIcEvuPUNsqCTfBsUVm5UA6Dn5CWQMi5qlNSeWm5yK
 hCzkzU+fZ5ifxV8MwypODGCPhmPMeQjCnovUuuyGr2QlhcuBWifX0hd97cv1ChSksGxR
 kPg9jhMs0NtfsEUkjzit9AZo/2zy3JihQUQax6lqBDiTQjntgn8HmWCnCC3n1gahewT8
 Bs3U6ghKOlhF7kKgq9fDAlelNao6eRPnnjRcfRH7KzMlzRScyyaZKweBzYoNnnxndC2m
 RPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794762738; x=1795367538;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RGSaqJ9uzdPbC8s1AOkaFU8TilcJyLfSi7qo0gxhOks=;
 b=gFnwwDLwuuqvjExcA/k/zhjQNVJ+M6najWazpZ9giR4/fFqW+xudu6qfrWLIIs5En3
 qv5fec1x8E0R/AmmY4OLm2G+h/6LUhhMh4dGHYf2usF+z6gUwj9/VEAjJU5xO7buVcaR
 SX7OFLixk7ahVe79g0WSo0MnxGV0ZWnecIpAu9LV34R0D5tDUZUVwN8Ti7jYbvCfTAs/
 57es8uF2VmipkUWMTN+Xpt7nlrvsYHXR3jWiCyyUuwwiLifF5U/dVhoZ1xx3mfIdDRgM
 gs/hw/KgV39F7FOostOdfkTGmKkWxZKw7V8WIHrLdFy3+v+skXJPuPnYkOysy46mrpCC
 CdBQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF5AeE66RzOSj/MyYcWLe9Gt4exyxOT0DXnmZq6q+Ne1Nuka05lbY3zsGtk7YhDH40fkkOJzo4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/pR/EsGwo5vGcKlCF8jgfpITX12zHwkXkXu8UJDykHwnO5PBzx
 MB2g5yoTvarPikHCNBliWKiS1UfgYf3hxusMvxZyu33QvP5yFhrfbh/CXeLRHGH6ByBaEo2aFkv
 +17TOaKVPWsJ5xAfdzDVGX/n0cf6tW80Fc7T73kLn
X-Gm-Gg: AYBFou2pbghLWJcvZjxfcTmkDY/4+jm6G9SY4VAuu3vd1vXFOnatOTe1VAtwWRNk2ff
 sKyYn7Wlwm0WO0F9H5QBukWdMv/VxuOLf1z3xnbz9g9SGPQ9/+NawhZl0bcNDYHXlIItjxGyCmK
 ivzqjeAokt71/r08b9gury4F1HGO8+uWGbYXVWoIC0qVOYvAi3GlatHbSIzr2mmVl8b7k/B3HFb
 jR0S8g0AyGnHCYBAjtZ5IAKp5RF1ms7Xj03SXQPe80joacRJVr6K+IhZN8LELVeGQf/yjXZ1kLP
 oIL5yK95S1qP5U9uJ1mT1sPthWzWFFaUPxLwVnPAuoKVbT0vgIe10lJYjV4errOYelTezXNVEvW
 JVYWALexAbANezOjIJUXK5vVoRbUzaAOU0r4IozpN5Ur2OTGrusuwIvdcmd9zwxox7w==
X-Received: by 2002:a05:6102:14a3:b0:7c1:62d2:e18a with SMTP id
 ada2fe7eead31-7d64d76c08emr3044103137.16.1794762737022; Sun, 15 Nov 2026
 09:12:17 -0800 (PST)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 15 Nov 2026 09:12:16 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: George Kola <georgekola@google.com>
Date: Sun, 15 Nov 2026 09:12:16 -0800
X-Gm-Features: AclHuK9QVbNRJgRRHxCPSdyUsC7SKK-CddLmzplVXuis4n0aTItOsfElqiEkxP0
Message-ID: <CAOTQ16LH4V_A86PAoa6C+s4WODCqhW+1aTfTm=kMsYi+Pe6mvQ@mail.gmail.com>
Subject: [PATCH] net: fastboot_tcp: enforce rxbuf and stream offset bounds
To: Guillaume La Roque <glaroque@baylibre.com>,
 Dmitrii Merkurev <dimorinny@google.com>, Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 u-boot@lists.u-boot-project.org
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 15 Nov 2026 19:00:33 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tcp_stream_rx() copies incoming TCP payload bytes into the static
74-byte rxbuf without validating rx_offs or len, enabling a single TCP
segment larger than rxbuf to overwrite adjacent globals. In addition,
tcp_stream_on_rcv_nxt_update() treats cumulative rx_bytes as unread
buffer bytes without subtracting data_read (causing fragmented reads to
parse stale bytes and multi-command memmove() calls to overflow rxbuf)
and does not bound cmd_size against FASTBOOT_COMMAND_LEN, while
tcp_stream_tx() does not clamp copies to maxlen or guard tx_offs <
tx_last_offs.

Handle overlapping TCP retransmits in tcp_stream_rx() and return -1
when offset + len exceeds sizeof(rxbuf) so tcp_rx_user_data() aborts
with TCP_RST. Derive unread = rx_bytes - data_read in
tcp_stream_on_rcv_nxt_update(), reset the stream if unread exceeds
sizeof(rxbuf), reject cmd_size > FASTBOOT_COMMAND_LEN, ensure txbuf is
NUL-terminated, and clamp tcp_stream_tx() copies to maxlen.

Fixes: 443d319180a6 ("net: add fastboot TCP support")
Fixes: bf962de97c37 ("net/tcp: improve tcp framework, use better state machine")
Signed-off-by: George Kola <georgekola@google.com>
---
 net/fastboot_tcp.c | 68 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 54 insertions(+), 14 deletions(-)

diff --git a/net/fastboot_tcp.c b/net/fastboot_tcp.c
index b9b4f707b1..aa2dcb1443 100644
--- a/net/fastboot_tcp.c
+++ b/net/fastboot_tcp.c
@@ -25,8 +25,19 @@ static void tcp_stream_on_rcv_nxt_update(struct
tcp_stream *tcp, u32 rx_bytes)
 	__be64	len_be;
 	char	saved;
 	int	fastboot_command_id, len;
+	u32	unread;

-	if (!data_read && rx_bytes >= handshake_length) {
+	if (rx_bytes <= data_read)
+		return;
+	unread = rx_bytes - data_read;
+	if (unread > sizeof(rxbuf)) {
+		tcp_stream_reset(tcp);
+		return;
+	}
+
+	if (!data_read) {
+		if (unread < handshake_length)
+			return;
 		if (memcmp(rxbuf, handshake, handshake_length)) {
 			printf("fastboot: bad handshake\n");
 			tcp_stream_close(tcp);
@@ -38,18 +49,22 @@ static void tcp_stream_on_rcv_nxt_update(struct
tcp_stream *tcp, u32 rx_bytes)
 		memcpy(txbuf, handshake, handshake_length);

 		data_read += handshake_length;
-		rx_bytes -= handshake_length;
-		if (rx_bytes > 0)
-			memmove(rxbuf, rxbuf + handshake_length, rx_bytes);
+		unread -= handshake_length;
+		if (unread > 0)
+			memmove(rxbuf, rxbuf + handshake_length, unread);
 		return;
 	}

-	if (rx_bytes < sizeof(u64))
+	if (unread < sizeof(u64))
 		return;

 	memcpy(&cmd_size, rxbuf, sizeof(u64));
 	cmd_size = __be64_to_cpu(cmd_size);
-	if (rx_bytes < sizeof(u64) + cmd_size)
+	if (cmd_size > FASTBOOT_COMMAND_LEN) {
+		tcp_stream_close(tcp);
+		return;
+	}
+	if (unread < sizeof(u64) + cmd_size)
 		return;

 	saved = rxbuf[sizeof(u64) + cmd_size];
@@ -60,6 +75,7 @@ static void tcp_stream_on_rcv_nxt_update(struct
tcp_stream *tcp, u32 rx_bytes)
 			     strncmp("OKAY", txbuf + sizeof(u64), 4) == 0);
 	rxbuf[sizeof(u64) + cmd_size] = saved;

+	txbuf[sizeof(txbuf) - 1] = '\0';
 	len = strlen(txbuf + sizeof(u64));
 	len_be = __cpu_to_be64(len);
 	memcpy(txbuf, &len_be, sizeof(u64));
@@ -68,25 +84,49 @@ static void tcp_stream_on_rcv_nxt_update(struct
tcp_stream *tcp, u32 rx_bytes)
 	tx_last_len = len + sizeof(u64);

 	data_read += sizeof(u64) + cmd_size;
-	rx_bytes -= sizeof(u64) + cmd_size;
-	if (rx_bytes > 0)
-		memmove(rxbuf, rxbuf + sizeof(u64) + cmd_size, rx_bytes);
+	unread -= sizeof(u64) + cmd_size;
+	if (unread > 0)
+		memmove(rxbuf, rxbuf + sizeof(u64) + cmd_size, unread);
 }

 static int tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void
*buf, int len)
 {
-	memcpy(rxbuf + rx_offs - data_read, buf, len);
+	int orig_len = len;
+	u32 offset;
+
+	if (len < 0)
+		return -1;
+	if (rx_offs < data_read) {
+		u32 skip = data_read - rx_offs;
+
+		if ((u32)len <= skip)
+			return orig_len;
+		buf = (char *)buf + skip;
+		len -= skip;
+		rx_offs = data_read;
+	}
+
+	offset = rx_offs - data_read;
+	if (offset > sizeof(rxbuf) ||
+	    (size_t)len > sizeof(rxbuf) - offset)
+		return -1;

-	return len;
+	memcpy(rxbuf + offset, buf, len);
+
+	return orig_len;
 }

 static int tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void
*buf, int maxlen)
 {
-	/* by design: tx_offs >= tx_last_offs */
-	if (tx_offs >= tx_last_offs + tx_last_len)
+	u32 avail;
+
+	if (maxlen <= 0 || tx_offs < tx_last_offs ||
+	    tx_offs - tx_last_offs >= tx_last_len)
 		return 0;

-	maxlen = tx_last_offs + tx_last_len - tx_offs;
+	avail = tx_last_len - (tx_offs - tx_last_offs);
+	if ((u32)maxlen > avail)
+		maxlen = avail;
 	memcpy(buf, txbuf + (tx_offs - tx_last_offs), maxlen);

 	return maxlen;
-- 
2.56.0.611.g1030f0b940-goog
