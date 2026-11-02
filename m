Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F84606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dH7ltaKs;
	dkim=pass (2048-bit key, unprotected) header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=mP+vkvcC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A69B3407E6;
	Mon,  2 Nov 2026 13:10:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GzF4mUQtV2Pu; Mon,  2 Nov 2026 13:10:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7A9A6407CC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793625046;
	b=Wcv/vpvsSjUUwop/uRrH26WFS5OIoTNEoJbUe5VGtfvWKIyQWu85gN6T/nsmsdnf49tj
	 3c3VptrtypFa4dJOevjl1Ufb9zHaMydYTGc4CdwMbEhIf718ayuUaLyJl3nenBJk6gcrH
	 1WFYCIvFyYNQtzHat8u0Io0SAp8r5gY08wuaECACshyssA2Ckv1AsMVXqiiJErsEThy1v
	 o0IgTuH9OY4nCFNoEbCjI2cZNsnUsQWbcjqGY9lTCCi+c72I5eooiTv3GFAQKwOV9TIrH
	 NMo1l1Y+qlK2vc6TeZ1eAOjyB19pyQYDa8iOz8Y6MP+6VELRMJult1sgwfvacMCO+IA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793625046;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sZPwtREil+fyH2rNOI/2hxN6vYtUxBu8ekGguvhiMWY=;
	b=lObK//Rl+UQcnqHwtwPJICdoI5hNmVkRIqwgb5QTzI0Om4ExV72Yxyja3f5ZfjMaRrB3
	 wtUDTJXtsKTgJMyec6C0YjhOLGUi/QvaFs6z3Js6ppq0m+hMkRN6GEUcr4aVNqtcr+8RX
	 Ty8uUafIhTdB9ckTpKEaDuCt8F8+t/qBC8+4lfF63R+UzzxTf84K6gjHFnVu1/mNuyshU
	 wlmP3zZhF4D3VTaSxyyHZVvIpIvow/XqRbqWuTxTB31qvNGM1E3MYUzevmF4X2WwAVizU
	 xwM2CoNcTSkYuVd9M1CvgVXnLuX23p0HhVRLwdOK3t46yx13qzMS2618vG46Vy13COQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793625045;
	bh=sZPwtREil+fyH2rNOI/2hxN6vYtUxBu8ekGguvhiMWY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dH7ltaKsX71mARiC0QOlfa0OrTOvHgzQeRfOb4vbui7kOyt3fhY8ZnGqs3gT1ZLpN
	 zDPEOUHkHLfWigeRM0Q9rHyF0DsIluBmO54f8Fk2rcyIkfECqYejTy6jXr0jmGW7+o
	 +5EgnGHqpOff275iYyyxHsuDl75fU4S2lyS7LFmyxWu44LdEPmK6RoTO5UdJlelF4Q
	 oldqcF2yu7vcCeqJLZMLVb9o2LwwxSQjBBM29CDGpqgfsm8G74fnytgA+0J/s0FhEv
	 BtGqOGKZg1Tvbc3RVAan+RdI8ilxJfCsvzYsUtMksSN6fx/0+l5TQKE9qWihh+qFL1
	 GvckoFBm/A01g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A9A6407CC;
	Mon,  2 Nov 2026 13:10:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 352E34BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 11:05:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1934F400A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 11:05:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MGs9Zz03UOZy for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 11:05:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3465B40079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793617517;
 b=V1ecbZeY83IrTyzeRM3le31JTPyYDeEQuI1vInslxgHT77i2r5rzggsXXDbG4Fp7bcTv
 R17CVcfX+Eo2iscUoKdXw9NAJ2Q7gMDxNGqkLge8eQWTi+usvilyFf+E+EaqEsUWwpGrN
 XByn9rBwEHgY2uTP8gfsWdHTxEv2prWF2PhMK/CyqIu4xKTdRjTZuPpUvGdow3VGdc7DE
 WTuig+EfQz5p9d7WG9LnE3m/4RyDAt6zN2HgucN5AjygvKoLV/XtEDz30tieStNOA7M3r
 slfu/bZg88ynswySftMd8ed/uf7TkOiHWg7cHDL2LGMQH7Luo5hRPa0S7JG1hrvvgrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793617517;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=sZPwtREil+fyH2rNOI/2hxN6vYtUxBu8ekGguvhiMWY=;
 b=jLRVl0eBvWXOAMihO/0VgLQ/1Yuq8bKioOBLe6igY6GDT0QjMwO8fQgL2eITvOYLylBY
 7F86hmWH6oXJljd56MbhIdL6b7WgX9zqDya9Q3RE0QNsokodHz2qAW3zGZC322jqRj9TK
 BLu7IFnuC6ZRiIbQKCHTU0wdeN9UaWsCDa5BGpoRHQ9mC7KPr35IAJNSg6anVRu57Xf4b
 uU5VzppDbbSwdUOz31BmY1HQ2xlBVN3AqLxV4d4o5OML3Q3SbkIwrwEQN57W5XOoGWp5+
 DikJmu2/FS5wBeFEoZC5d1E9uzf8i7l78pnbF8jualc5uR/hV5+3qnSxEtE0Apb1gBA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=octane.security;
 dkim=pass header.d=octane.security header.i=@octane.security
 header.a=rsa-sha256 header.s=google header.b=mP+vkvcC; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::122e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::122e; helo=mail-dl1-x122e.google.com;
 envelope-from=shubham@octane.security; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=octane.security
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=octane.security header.i=@octane.security
 header.a=rsa-sha256 header.s=google header.b=mP+vkvcC
Received: from mail-dl1-x122e.google.com (mail-dl1-x122e.google.com
 [IPv6:2607:f8b0:4864:20::122e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3465B40079
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 11:05:16 +0000 (UTC)
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-1adbf62dd31so2920156c88.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 03:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=octane.security; s=google; t=1793617515; x=1794222315;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sZPwtREil+fyH2rNOI/2hxN6vYtUxBu8ekGguvhiMWY=;
 b=mP+vkvcCG8Zi+5iVEfC3Zcsd2Rzvs4ZUWFcgvhVhaqhS7Lbfc4+lyX/ChqYjFAAJBa
 SdgW1qjLuYA/fq9IAaeoKAtRxgRnlN4AbIafdX7z0dWnQBV2T2uJWfBzWQfZkqb+j7SM
 Eq9WGjD0a6dm4EzgBAMQDFwI8hHa9P3JsOijZq0blBTY3aB0Z8bjKXU3LsCe+iWGf69Y
 EET1LH8YkngPX9qBua9F787ccrABnJZj2TLC6K6LKAHjO/+Mq/5q0uq14OSYqM/M7LO8
 X20DrauRS8xge7PCjrzjOBcPE8bDeZmbWrg+pz8npi8lQvq4Gi319VNeEuI0OZ/4WO3e
 mRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793617515; x=1794222315;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sZPwtREil+fyH2rNOI/2hxN6vYtUxBu8ekGguvhiMWY=;
 b=AsTpMM6tRbjg4sACdZKSQ8fRYRnKLklgrln5nhM6kZnPNeSGtC9hq0ku7oGToXXpzF
 5Sl3PWARyr75DSsYSKffcpWTpo7ft3YJ3DuCJsgD6Ysk77/w0rWNJdB0aH0mO4idFyiP
 KqE6OaeoGqsUApWinROSut4xu3DXKjQ3f00XTQCsRjrh6VxVPyXoaDBtGcdiU2hk6RIL
 D3lFatkZDWMbJvOGwPA/52TlTJqmzWQxFxo4uBSh5NvF7l9IMA+IDylN3Dr3KEicjpIf
 H+2BgJtNH8SkrLcNycd6aGeMcO7h5a3ZePkgf3eXeXcchc8CPQSYCC5jSjB272UsqBOK
 QKkg==
X-Gm-Message-State: AFq9FYKt7fTp07m7MVBBAV2NVLUs/Tqx7jwf++SIg0qlY42uBxQxQIJ+
 4KEqCXfWQVXpqlKpJj0fTA92zywtJSBSgs+F5tb5bsqwClm4NwBIgt0PFEonLGZ5CsTiLEs2yP6
 HvAZj
X-Gm-Gg: AYBFou3Jxn/15tANpKhdM0gZotY1OkAgsbwrMpwNxcl9TydWK8zSP+K7Jt2Vu6SGUKi
 3IGITK4Yc0lJ9nS1G+ymxQXGGriJtnZv7ZbhiF4QZyUReixO2lsUIx1R7kOQclYIkKlfqGfMtCw
 Lu+jQGYflhdY1sIJM7BM7WcAUgqjdQZWDm2+805S8eQzxe+gZw6eK8JADTXXswTk9NScxrhWHhT
 518iMu9WQvgDP08R1ljR0SIkuXAZ6OXziDO1qnT8Wrh4mdidhoI7d8OSHAA4jg2x3zN3IIXAlsG
 qSDO3boumlsDbhAgYS+6yqjYrETpAXDDpJJ394RoT87BFwHJytnFmZGmlwge+pmraQKragvZW3E
 f4hT2u/fNyB+lRrT8MlxeLt7Z4ITFGBgNzn5LN/EV3QCGzHP/S0x92YCsZZtdo9d/QzBQuun1Q1
 bo6z39JttpXNQ7/uJEAlbO12qC1o1YooZkVyrHpl/rMQV3/CGofDsHT909Azy0kff9ZCdBXk60H
 9Sh/iefoTepLjaEk61iGNjbrWTNnxjVnYg3FEAOvlmYd3L5pLA3uAl51UQdcX5rILgzX0unGhe9
 UwRTMQkzET5WP46QCNpvHME05h/k6rOcuzSIqOhNMteW3v75bMAUpKQAP/XpEG+rHejDDJePa2l
 j6MtJZ7sqJh0acpS95Us+1hVKsADebyKiXxG6z4UN9Crukndp
X-Received: by 2002:a05:7022:628a:b0:14d:c7ae:85dd with SMTP id
 a92af1059eb24-1ac5bbb917cmr19125145c88.7.1793617515144; 
 Mon, 02 Nov 2026 03:05:15 -0800 (PST)
Received: from localhost.localdomain ([103.196.55.178])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b2360d2066sm4481937c88.11.2026.11.02.03.05.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Nov 2026 03:05:14 -0800 (PST)
From: Shubham Antil <shubham@octane.security>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, gio@octane.security
Subject: [PATCH] net: tcp: account for SYN-ACK payload sequence numbers
Date: Mon,  2 Nov 2026 16:35:08 +0530
Message-ID: <20261102110508.76420-1-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 13:10:33 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A SYN consumes one sequence number. Passing a SYN-ACK's sequence number
to tcp_rx_user_data() for its payload underflows the receive offset to
0xffffffff. On 64-bit systems, wget can then write the payload almost
4 GiB past its requested destination.

Start SYN-ACK payloads at the first data sequence and drop data before
that sequence. Validate the TCP header length before deriving the
payload length. For wget callers that set buffer_size, compare offset
and length without overflowing their sum. The normal wget command
relies on the TCP sequence correction since its buffer_size is zero.

Fixes: bf962de97c37 ("net/tcp: improve tcp framework, use better state machine")
Signed-off-by: Shubham Antil <shubham@octane.security>
Cc: Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: gio@octane.security
---
Tested on qemu_arm64 with CONFIG_CMD_WGET and on sandbox. A SYN-ACK
with payload is now stored at the wget load address instead of
wrapping nearly 4 GiB past it. A follow-up HTTP wget of a 622-byte
file completed, and the bytes read back matched the file. The previous
wrap-write sandbox check no longer observes a store at
loadaddr+0xffffffff.

 net/tcp.c  | 9 ++++++++-
 net/wget.c | 6 ++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index 87401503..bc19330d 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -936,6 +936,10 @@ static int tcp_rx_user_data(struct tcp_stream *tcp, u32 tcp_seq_num,
 		return TCP_PACKET_DROP;
 	}
 
+	/* A byte before the initial data sequence cannot have a valid offset. */
+	if (tcp_seq_cmp(tcp_seq_num, tcp->irs + 1) < 0)
+		return TCP_PACKET_DROP;
+
 	tmp_len = len;
 	old_offs = tcp_stream_rx_offs(tcp);
 	buf_offs = tcp_seq_num - tcp->irs - 1;
@@ -973,6 +977,8 @@ void tcp_rx_state_machine(struct tcp_stream *tcp,
 	u8  tcp_flags, action;
 
 	tcp_hdr_len = GET_TCP_HDR_LEN_IN_BYTES(b->ip.hdr.tcp_hlen);
+	if (tcp_hdr_len < TCP_HDR_SIZE || tcp_hdr_len > tcp_len)
+		return;
 	payload_len = tcp_len - tcp_hdr_len;
 
 	if (tcp_hdr_len > TCP_HDR_SIZE)
@@ -1058,7 +1064,8 @@ void tcp_rx_state_machine(struct tcp_stream *tcp,
 
 		action = tcp_stream_fin_needed(tcp, tcp->snd_una) | TCP_ACK;
 		tcp_send_packet(tcp, action, tcp->snd_una, tcp->rcv_nxt, 0);
-		tcp_rx_user_data(tcp, tcp_seq_num,
+		/* SYN consumes one sequence number before its payload. */
+		tcp_rx_user_data(tcp, tcp_seq_num + 1,
 				 ((char *)b) + pkt_len - payload_len,
 				 payload_len);
 		return;
diff --git a/net/wget.c b/net/wget.c
index 49bfb9fc..8ba273fe 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -50,8 +50,10 @@ static inline int store_block(uchar *src, unsigned int offset, unsigned int len)
 	ulong store_addr = image_load_addr + offset;
 	uchar *ptr;
 
-	// Avoid overflow
-	if (wget_info->buffer_size && wget_info->buffer_size < offset + len)
+	/* Compare without wrapping the 32-bit offset and length. */
+	if (wget_info->buffer_size &&
+	    (offset > wget_info->buffer_size ||
+	     len > wget_info->buffer_size - offset))
 		return -1;
 	if (CONFIG_IS_ENABLED(LMB) && wget_info->set_bootdev) {
 		if (store_addr < image_load_addr ||
-- 
2.43.0

