Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B91C98328
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 08:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF54140AF9;
	Sat, 26 Sep 2026 08:44:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m1Xb_tvHemwg; Sat, 26 Sep 2026 08:44:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 07B2340AF6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790412276;
	b=tZdse+ZeQkWJYHh/rTMiv0smtMTr3ruGjbsSrUilCHkztrXfL6JCX7hFROrza1dFLH/O
	 kD+8Cod/b347qoh8772YD7GlfOjMF2NPXvIM0XlLLa3nOcv+hZig/HD91T/ocrREgBpCd
	 +qP0VKE8W/B6vRDBW1MH6f1YaBSWi4aLI8WjNzpo/boJSdAZu0u9Wl+340rYPmN4Ha87R
	 0pw0/xuuG4bYEXkrjVgjIEL6nCqgf4Oh16Eo9QkKgFLIBP7O5Q1x8+/MPq0WUrvB5WwGs
	 p7UwidSy6i1/gPHHb19/qFLb6cAPgQKZ/tQXOpIdUkZKjsk522gRVz3KfFFmNUuwoUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790412276;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XUfSFJ5/5mUSJfbHAkl/ESSkO38/Xs6A0uClhXsHyl4=;
	b=R6QsMgdxIxk4Q+TVluTLgWgtOq3FrS4IM97bCIWE/7xWgqKANvl+6mbKP1wB1+2iJY1t
	 jcoDHl71cAsENAx9CNl43L14mBQ+GzuqclLrPzKJ2uZ8M/r3d1zhTAzcUAc+3H2XCzgGv
	 NG1+3TuneeyMAt+VIFmiDNzXEY1k0j7Wqi/+iPl49pc3HHuQw3wWOJ/YKJ9oUI8BB6sdF
	 rDUY5OUT+85rOh3QeworYHliQwT/l38olCZ8MaWsVJC6YlVTMh9X0P0p9KSloo6T8mFVo
	 hqBbR0WS7kb2A3kRJ/Z0sPlZxie6TlYLeCmDTkvYMZsFu41CVtJ9ABUeVzGgj2CR3gw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790412276;
	bh=XUfSFJ5/5mUSJfbHAkl/ESSkO38/Xs6A0uClhXsHyl4=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BKCGwClic9tRzFSPMqpoDE+VSVULy7FyMG6iJVVfJIbGXcWhpT7fkXPpRMB3Jn563
	 ig85kdmjC2MQqxnM5d5dbvEBJnclomKhL3ghrlXSVFBCA4+QWhRYqYT+TqZaRDmR3L
	 1vmNCEh94NMzc7qn2N74PtZ/2vd6y4UFbfHGnjj/3PeU0MBPtDU6t2LaC24DobGzJh
	 P6W2pqkNpnJC5vtAAl0aXca4R77i0bkPMxx1i/nzf2YrDvpo1P6nIowrbG/lqzpAYn
	 S1OB6p0J+IX+DfJeIvDLiy/V73EagelX2khrulkB0MNFDdqsOLwXsArLkraW5wOIUe
	 BV5HdP1kS9RVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07B2340AF6;
	Sat, 26 Sep 2026 08:44:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FE5F32F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 22:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4559E81304
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 22:10:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZdW9IZiAuvBN for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 22:10:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6A6088124F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1247"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790374216;
 b=AeH5q8DOP5UyWwofBCQDFFtC6r7cXcm+dMj4UCyylEXz3NBQFwohdRwa1qzeOcUrgCwX
 xniH9YfU/EITcJjgeUO+55WjaaeekNJ61cRruLboUAH5eMNJhbDBdFJLoIHd1nMYX/nBO
 l4AVIyAcISlEfEu48cBMoD2YclRuPlrxSQpRNmk5YumnnaPAPs7kVej1h4QbtlWogYUP4
 D/qVjYPvrLcGF5cBQO/DAkOJrrxLrOIeAZ/5I0uaigLu62JD0zU4eQUn7xSUdNGBW1LU+
 b7D2dJsx0t9CX5FYKOAm1Tgm8m+1TbJmLv4zLFrq1aBwoNw++H/roVMfurp63QYWCCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790374216;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
 Content-Type;
 bh=XUfSFJ5/5mUSJfbHAkl/ESSkO38/Xs6A0uClhXsHyl4=;
 b=Ga3O6vq6fLYzsSOv42NHxxU7OfJB+sVuKS6dEdWR2NPaOy2HNtZRTcDcar3iaPumzmif
 bdjA2CF3HZpqb+iOXh+8swaL3xpyoJd+ITxvd9vrW8IBzRf3OFajjcDHUbkwHBvNnzWIA
 0TKzi5EpGt9nWN1m1l0MgeVM5y7BPMOwc4lnVHNsqln5iDDytP2baM05GBX80qADbC9Cs
 1t0VlRsxShESfmAcSEet/79x9sVmcoshR+MqjlRtlc58xwvZG7rGNveVSi73vLVO0RMaL
 Ob09y1qIDoy4QJU9YvfYM6O/Yb9tCIXqsEHCDa+4uVu6BeYaxOOPv9SgLAjr5zdtz9A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=bOisIKIY; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1247"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1247; helo=mail-dl1-x1247.google.com;
 envelope-from=3rvg2agskbmextwh9nyg9mffnnfkd.bnlt-annskhrsr.t-anns-oqnidbs.nqf@flex--yuxiaozhang.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=bOisIKIY
Received: from mail-dl1-x1247.google.com (mail-dl1-x1247.google.com
 [IPv6:2607:f8b0:4864:20::1247])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6A6088124F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 22:10:15 +0000 (UTC)
Received: by mail-dl1-x1247.google.com with SMTP id
 a92af1059eb24-1438492fb40so2022925c88.1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 15:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790374215; x=1790979015;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XUfSFJ5/5mUSJfbHAkl/ESSkO38/Xs6A0uClhXsHyl4=;
 b=bOisIKIY5oStD+JP1R/Y/Mwkg8VULPaETiuWKvItqY0so02EtNE6Plcah4WUTKcy1C
 9WcuDZ0uxR7qU9Q7TbANP3zP8b1Lt937ZpTEajSh1O0l6gEwUYAxSSrHiCjZyKCk4QXy
 vOwfKff69R95/NTEJsmg4JQ9F+R1h34/gbaxbqdONNM/1vhgDpMCsI/nNf7VZOMRvqCf
 7xwTNDc5QY4jKqSfGico0ERykVXyhW0Og/rLGn0ipF9Ew8yv9Sv/+gj5a74hZgVKH883
 Xz2PAlU57wfghtRQbDzNwwBJMpebcfAyaDksbfEulTkqfsDdOqSjmT4Sg+ihx8iyV6Y+
 1nyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790374215; x=1790979015;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XUfSFJ5/5mUSJfbHAkl/ESSkO38/Xs6A0uClhXsHyl4=;
 b=sXO8RiVjsroSmmBv55k47TsBaWz/acEB5tKgmHDP5TANOCWa6dr1jALWRDVdK5Esrq
 GU/X/c8c/mAeWCm33ndPkbXebEVcIeIjPCOlfSt4qPgFqEITBgtp8DZldb2dK5nQfrg0
 1v95ksHDTavGgfvL/JOcSuX68d/WfG91coswCTl06Xs/kfHssdbBgRyMNf6vhB3XozF2
 zetwBclPoUTmaiTRKrWyJzjZxBvzKWrWwbFasWYYWZMTyti+EU/u8NJwcWaKQU1xR1Lc
 CNxcmdCf+gQRoPvI8vBMEsfZvpWbPtKQ4sSvT8X3hTIHMsPpZHyD9x81bUZ6gnythA1W
 562g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTtMfbh3+0HRKr+LEIrVnAwGo5MA4baHZpagXY6S2lwzW2F+wrvu7AqbleNdCO+6fXGXaJkSs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lb92C0Q4WyN7hOKps50fo5qiXzB+qY3qxK0FHS5XMTySfHzVDT
 JnmboktgHANGAd6J78LwbBxNEiWQbMtSXIDVGWgNM2TQXBlZTDqHPD709q3XwdnxEMR/qvfcllZ
 T9oealUBV2x3pd/BhXStxOs+RfA==
X-Received: from dlbpv14.prod.google.com ([2002:a05:7023:90e:b0:144:ce1e:6f56])
 (user=yuxiaozhang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:4305:b0:144:eab0:9cbf with SMTP id
 a92af1059eb24-146ce492da8mr1454493c88.19.1790374214663; 
 Fri, 25 Sep 2026 15:10:14 -0700 (PDT)
Date: Fri, 25 Sep 2026 15:09:29 -0700
In-Reply-To: <"<CAOOoKeTiVDjEwx2T3w3ij74EOR_15LBNOuFB7ANV5vd2PdgEYg@mail.gmail.com>">
Mime-Version: 1.0
References: <"<CAOOoKeTiVDjEwx2T3w3ij74EOR_15LBNOuFB7ANV5vd2PdgEYg@mail.gmail.com>">
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260925150928.v2.1.I1473cc3e9adc7793245927386e6fb0278d9ae4af@changeid>
Subject: [PATCH v2] net: dhcp6 use link local address
From: Yuxiao Zhang <yuxiaozhang@google.com>
To: u-boot@lists.denx.de
Cc: Yuxiao Zhang <yuxiaozhang@google.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 26 Sep 2026 08:44:30 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

DHCPv6 messages are sent to the link-local scope multicast address
ff02::1:2, but net_send_udp_packet6() always uses net_ip6 as the
source address. Once net_ip6 holds a global address (e.g. a static
ip6addr or a previous DHCPv6 lease), DHCPv6 messages go out with a
global source address.

Follow RFC 6724 source address selection and use the link-local
address when the destination is a link-local scope multicast address,
or when net_ip6 is not set.

Signed-off-by: Yuxiao Zhang <yuxiaozhang@google.com>
---

Changes in v2:
- Select source address by destination scope instead of DHCPv6 port

 net/net6.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/net6.c b/net/net6.c
index 4cff98df15c..c556ed7e4c5 100644
--- a/net/net6.c
+++ b/net/net6.c
@@ -94,6 +94,13 @@ int ip6_is_our_addr(struct in6_addr *addr)
 	       !memcmp(addr, &net_ip6, sizeof(struct in6_addr));
 }
 
+/* Check if addr is a multicast address with link-local scope */
+static bool ip6_is_link_local_multicast(const struct in6_addr *addr)
+{
+	return addr->s6_addr[0] == 0xff &&
+	       (addr->s6_addr[1] & 0xf) == IPV6_ADDRSCOPE_LINK;
+}
+
 void ip6_make_eui(unsigned char eui[8], unsigned char const enetaddr[6])
 {
 	memcpy(eui, enetaddr, 3);
@@ -330,6 +337,15 @@ int net_send_udp_packet6(uchar *ether, struct in6_addr *dest, int dport,
 	uchar *pkt;
 	struct udp_hdr *udp;
 	u16 csum_p;
+	struct in6_addr *src;
+
+	/*
+	 * Per RFC 6724 source address selection, prefer the link-local
+	 * address for link-local multicast destinations (e.g. DHCPv6).
+	 */
+	src = (ip6_is_unspecified_addr(&net_ip6) ||
+	       ip6_is_link_local_multicast(dest)) ?
+	      &net_link_local_ip6 : &net_ip6;
 
 	udp = (struct udp_hdr *)((uchar *)net_tx_packet + net_eth_hdr_size() +
 			IP6_HDR_SIZE);
@@ -341,7 +357,7 @@ int net_send_udp_packet6(uchar *ether, struct in6_addr *dest, int dport,
 	/* checksum */
 	udp->udp_xsum = 0;
 	csum_p = csum_partial((u8 *)udp, len + UDP_HDR_SIZE, 0);
-	udp->udp_xsum = csum_ipv6_magic(&net_ip6, dest, len + UDP_HDR_SIZE,
+	udp->udp_xsum = csum_ipv6_magic(src, dest, len + UDP_HDR_SIZE,
 					IPPROTO_UDP, csum_p);
 
 	/* if MAC address was not discovered yet, save the packet and do
@@ -353,8 +369,8 @@ int net_send_udp_packet6(uchar *ether, struct in6_addr *dest, int dport,
 
 		pkt = net_nd_tx_packet;
 		pkt += net_set_ether(pkt, net_nd_packet_mac, PROT_IP6);
-		pkt += ip6_add_hdr(pkt, &net_ip6, dest, IPPROTO_UDP, 64,
-				len + UDP_HDR_SIZE);
+		pkt += ip6_add_hdr(pkt, src, dest, IPPROTO_UDP, 64,
+				   len + UDP_HDR_SIZE);
 		memcpy(pkt, (uchar *)udp, len + UDP_HDR_SIZE);
 
 		/* size of the waiting packet */
@@ -370,8 +386,7 @@ int net_send_udp_packet6(uchar *ether, struct in6_addr *dest, int dport,
 
 	pkt = (uchar *)net_tx_packet;
 	pkt += net_set_ether(pkt, ether, PROT_IP6);
-	pkt += ip6_add_hdr(pkt, &net_ip6, dest, IPPROTO_UDP, 64,
-			len + UDP_HDR_SIZE);
+	pkt += ip6_add_hdr(pkt, src, dest, IPPROTO_UDP, 64, len + UDP_HDR_SIZE);
 	(void)eth_send(net_tx_packet, pkt - net_tx_packet + UDP_HDR_SIZE + len);
 
 	return 0;	/* transmitted */
---
base-commit: b4ac71db13a33c4e6532c60a781ddf34b7f4375a
branch: main

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

