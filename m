Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67742606A330
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wgyTGj37;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zzd+lhGD
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0CC2740817;
	Tue, 17 Nov 2026 13:18:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NT2_v2XMavu4; Tue, 17 Nov 2026 13:18:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4AAC640810
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794921496;
	b=M7u3FgfUShBbcPNWCER2GZ8gZiXMJggOEzfC/ozapKzAfQ5zuSVbhtLQI6p8x2YtfqAE
	 6nu9k83KjhJnK610AOx0jXuKCN0aJRnbiui3zGYlnnCHJaMzILgofkR9N25XGQeg7QQPr
	 ryx7fOGRglEgn/8Einf2tybAQk/ECUqh+KIo21/RI2/Sn3+qcV6PrkFVLpNd61hEaPeGh
	 uUA7UC1FKSFVkXqxURh49eDkO7bpnzb76SK1CHmKFZHrSU/OLsqGqW8Ka48xvbKvzOenT
	 +xjOkZYXeptMIieTNNI1Dt7iefnNiYCzA01LsSYjQ2RENPIoK849mJ1u875RrO2aAxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794921496;
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
	bh=H5HmyMWHZindAX2o3L5THJs8vhtArqkkVz/MklmSVvs=;
	b=eZaGd+GvKEH7Mg+QDIfWvXiEMB03dap5SjxH+1pzyLZ1xkulqVFJo1KBHegwy3PDnDZq
	 mso94MA8PD9jBji66jguSwNlAsdi445BPhBcej9HmGL6/Dvp/I/pNDdxDzPYDNbTtoAqa
	 x3731u81V6p48gdPfBmv9lZQHgXG0FM3HKtmrHvBeRjh/BVu0TIEC4+yUWeNV0DFapXOz
	 QvPtCPiUJzdMJ12Qddx6+38dUXWRQKjxLbyqMYaT8J6F7WR7aY+Yir1RrAuZVO4zpPImW
	 FgccJkMEhNyj7/hjM/x29iDnWX6dySE9HLKSZ7FA7WKYRDg+ViC2JScVMzr+rSTqkpA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	spf=fail smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zzd+lhGD;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794921496;
	bh=H5HmyMWHZindAX2o3L5THJs8vhtArqkkVz/MklmSVvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wgyTGj37eUlLNOlTBwFNd+BNX7K1Q01z0smPOJ+/R2IJujgpCQQbqN/nLVkFx77VG
	 +wD/6zl0g1YN2TgkiuV/m4+IPSpSEO/aWval661v9fsLeRZI+lMsmnfRQCha/4Gu/l
	 B+cajmREFN/K2zkak1FvwMcxV+lf8svg04rtgI+zQIHFMWkpYzuW4R/u0XMWCcJ8BD
	 7iIkHAvlaPlEabzvWcu1cdVQYy9aWU5l8OinzZ8WaldjMJe7hrchYgcBd8e0hNSmEt
	 w6SfHjg4tuRLHOOovgsBbtJgPQxJCu0O62Fu9xrHHjEW1U6WnltKTYPuFWUxkY5MOt
	 HJQFSsg+dLgtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4AAC640810;
	Tue, 17 Nov 2026 13:18:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2AE1C13C
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 08:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1C75F40722
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 08:57:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dNXkaLw462ES for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 08:57:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B2C48405B2
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ragaprasanth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=zzd+lhGD
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B2C48405B2
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 08:57:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4210B847EC; Tue, 17 Nov 2026 09:57:05 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C37CE84717
 for <u-boot@lists.denx.de>; Tue, 17 Nov 2026 09:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ragaprasanth@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3b0e0e65adbso2138317a91.3
 for <u-boot@lists.denx.de>; Tue, 17 Nov 2026 00:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794905816; x=1795510616; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H5HmyMWHZindAX2o3L5THJs8vhtArqkkVz/MklmSVvs=;
 b=zzd+lhGDuRbXs7jSuGMJNQnhcLniRIV/h8b0O1G3WGr2GG4OHQb9xjn6gqFLgu9QlW
 wzRQjut5UoBzk327OlXrmGFo5yCQxa7PcZPqx4slwfspFSfrS8JP1Oy5RlEZbbX1LOBK
 TL86ysLJZ0+6/9S4o0uCQtgQPbDIEQBcjs0RYUA+Mr/aKzTzsMRrpGs85UuDk+suhX/p
 4Yz5G26joIWfUEtJNNKdF4RuyA6AOZgBacj18yc5lfmURrSwcCilh9b6sMYY23Glj/CT
 8lGXlYOfdarkgjeG88t5QHGVtl/FUPg5IL0H4v/pH7cdmPNsGrgjr4vwuIOQ2RGqruEj
 l6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794905816; x=1795510616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H5HmyMWHZindAX2o3L5THJs8vhtArqkkVz/MklmSVvs=;
 b=BykguSmNo1q2zqdH1hC/LDZLqV9cZUSN/TGfsqfE2wAFUDjxGsu1qfcPqSpNICen4o
 xRGl+VrTitFfpJrpK9U2f9515t/33AVIqWLgep4dT3pyk17krL6d41Rpc8uRSlUWEFut
 1kdhAau1ELde6diIx+2swqMnV/4r6Bq1TCsEHkhZp7jyx+q3H4/p2zd1/eIx8tQIiJ4O
 OMyym7YssGIXF2SjJVBNI638NE0DQ4WXhoiO/Agjolqa78fKQCV2jfLOy0pn05Ev31JU
 6WsrrVNXqbB5ce1zXdln1kj8fNPLd4RG8FWfxyWr7SnIx9x8kISxWQGUELCWXIzZY9qY
 mC3Q==
X-Gm-Message-State: APuU4Z86qWYmbOaoI9iTUwQxl33k6VZzFM4trqBnEZLCp+NfFYFl+mWw
 YiyrIj7Ig496Euh5BIlPRt8Y3FiN/0xxsJOHI+ZSjZ2kJxOkUA4SxHF4C+phAZXR
X-Gm-Gg: AZFdTZe0g59hoEuKF+imnOayeDoMPhAmZ71NgUfRKhrS6GfPVCuz54pF/bO5E/Ii2Ob
 VGilrKjUxgojSe58gOzgqdeAvbqhCWDVR7yJ0a4ypt3jyffafZTBTzcu4p3ag3oG9XuGWiDUc7U
 1PODLzG6sIfsTWmpoCPEY5GAFe4Xx7/5GYIPcKxi03HAsaofPUWu+pYojJcAu3s9OJUcjIhzprp
 fHYjGeMTQrzNMTaoK0Q1bGEYAom/FE8vCQ5V2elVhMrYtiuOUSLlfu24L5IYva1fPiI6DNlm5rN
 yqwzyRW+8y17iTXi3RGqdsa/R0Ul44pnixixtsTkaN9OuTSirZSvZIUDgQHXbJJtcXg7bq9nZLE
 5jtj5TRN7Ue7xziDXW6kbHEGNq5cY/CVgFRlW92+giSJsolsHJpbZtkOcO6W17Ez0N67AoEdTRM
 /o0Iv2Pnoo/bD5FPV3Tnl5FWzOWwMR5MQWIHL0GhYCcKG9n4oBV67zRO4GBT+pvWUAW/H/pxuZG
 bqGmO+qMNQQIl/OUEqUXi5cv0+N8kY4AvINosfWcrjpX0pB9LBgQcFNye1f97kNC1jHBYcDm/YS
 zdQgZPEQ1js/h+0E4OB4uxFmFPoqF5INO88oTO1cGyfEck0qZ2bRgXfG/j4M04ad
X-Received: by 2002:a17:90a:c88b:b0:3ac:7449:40b4 with SMTP id
 98e67ed59e1d1-3b1b0b5316cmr13247830a91.45.1794905815942; 
 Tue, 17 Nov 2026 00:56:55 -0800 (PST)
Received: from prasanth.alps.lineo.co.jp (vpn1.lineo.co.jp. [203.141.200.204])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ac4d98b8sm3035228a91.13.2026.11.17.00.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 00:56:55 -0800 (PST)
From: Prasanth R <ragaprasanth@gmail.com>
To: u-boot@lists.denx.de
Cc: jerome.forissier@arm.com, trini@konsulko.com,
 Prasanth R <ragaprasanth@gmail.com>
Subject: [PATCH 1/2] net: tcp: drop segments with an invalid data offset
Date: Tue, 17 Nov 2026 17:56:44 +0900
Message-Id: <20261117085645.3142669-2-ragaprasanth@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_NONE,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

rxhand_tcp_f() trusts the data offset of a received segment.
tcp_rx_state_machine() then passes tcp_hdr_len - TCP_HDR_SIZE bytes of
options to tcp_parse_options() and computes payload_len as
tcp_len - tcp_hdr_len, without checking that the header fits in the
segment.

A data offset larger than the segment makes tcp_parse_options() read
past the end of the packet (CVE-2026-29007) and makes payload_len
negative. In TCP_SYN_SENT the negative length reaches
tcp_rx_user_data() and the receive handler, where it wraps to a huge
memcpy() size (CVE-2026-29008).

Drop segments that are shorter than a TCP header, or whose data offset
is below the header size or beyond the segment. Also ignore the
reserved bits when reading the data offset.

Fixes: a3bf193bf4ea ("net: Add TCP protocol")
Signed-off-by: Prasanth R <prasanth.r@lineo.co.jp>
---
 net/tcp.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/tcp.c b/net/tcp.c
index 8740150365f..737a079ec5c 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -58,7 +58,7 @@ static int (*tcp_stream_on_create)(struct tcp_stream *tcp);
 #define ROUND_TCPHDR_LEN(x) (LEN_B_TO_DW((x) + 3))
 #define ROUND_TCPHDR_BYTES(x) (((x) + 3) & ~3)
 #define SHIFT_TO_TCPHDRLEN_FIELD(x) ((x) << 4)
-#define GET_TCP_HDR_LEN_IN_BYTES(x) ((x) >> 2)
+#define GET_TCP_HDR_LEN_IN_BYTES(x) (((x) & 0xf0) >> 2)
 
 #define RANDOM_PORT_START 1024
 #define RANDOM_PORT_RANGE 0x4000
@@ -1162,6 +1162,18 @@ void rxhand_tcp_f(union tcp_build_pkt *b, unsigned int pkt_len)
 	u16 tcp_rx_xsum = b->ip.hdr.ip_sum;
 	struct tcp_stream *tcp;
 	struct in_addr src;
+	int tcp_hdr_len;
+
+	/*
+	 * The data offset must cover the fixed TCP header and must not point
+	 * past the end of the segment. Otherwise the options parser reads
+	 * beyond the packet and the payload length becomes negative.
+	 */
+	if (tcp_len < (int)TCP_HDR_SIZE)
+		return;
+	tcp_hdr_len = GET_TCP_HDR_LEN_IN_BYTES(b->ip.hdr.tcp_hlen);
+	if (tcp_hdr_len < (int)TCP_HDR_SIZE || tcp_hdr_len > tcp_len)
+		return;
 
 	/* Verify IP header */
 	debug_cond(DEBUG_DEV_PKT,
-- 
2.34.1

