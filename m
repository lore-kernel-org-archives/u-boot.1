Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DEFC88E41
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 05:09:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F407811A2;
	Fri, 11 Sep 2026 05:09:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tonB9hy6C-SB; Fri, 11 Sep 2026 05:09:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E64D2811BE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789103395;
	b=ZMos3e5bDJwne6N/rumkXL7BQ+jFCTxIqR6SPYr5XsL1WP4s7yEF+nu+I93uBlhdoCfi
	 YUKCBiO6d6QgKpWUcFaVnQUhn0yBjaOq1DTe9wmjoArfBvABPhr9k0MyinCNfsN772s7n
	 /HzMpFbjALVNRdC7084WnsWaaClVhjSoAuEnf/tjHpr33NhkQUTpr7GfoMzdKyONczTyw
	 XykMiC4bWSGiORV+uFwL9u4RDuMRvKhYNjiczE9AMucfHuj233hSYBt6v8n+kQ4ENaSsF
	 kdbNDNr4yMkXrxtNRo6Soz7vfumgHkr9Q3qYPH3MVtsofSaX0cEqHB2/w2Rjh1Gh6Xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789103395;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WrtJhmDzX/88skuLKee3cl973TB46oo2LuJwus6sHGg=;
	b=LHGKUKQHhpacJNplCma5v24JIhzI7QF2X2Rt/FbpPSLFP7y/h2elpsC2RBIC3CHMBZnr
	 2Rz5YqQSi0d9kJsL08t1ri+U2jgzBDbjEQDFGZ1uKzYiD3mg7kmR3lzgTt+3RApF3KlBv
	 lXmFTU7KnMynWHu0HpSm3Bn3U29VnC06mdeROC7hA9b7mPmnOJ6yum+KU9LaXUpw4Ohud
	 apqhS37oUKp37800Q7JWWLQ6l+no5sOv+7Ezv1/7BTndkGjxCR6cvBPI2eZWJde/TepuP
	 lG5eB9j0AqwHTm0ohwEnp405ehZPnDCPqAoWCf7wpKHDDsozMhw4V+0RjvIcE3vxlNg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789103395;
	bh=WrtJhmDzX/88skuLKee3cl973TB46oo2LuJwus6sHGg=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=EqRv4GoHannfkdhT4U5yclWW3gnz0LgL1diIHe3vpn1PKk4WW5s5S65d09bpRaQtu
	 /rqG7C7Ih9ZBsRMmg30LCa890scGN6qX+YMUeFRBEgZQocrulb9YrHOpqhUqVHXO65
	 xsi5vBIygwImPQCrT8LQQ8cA3Q7XA9YlI4L/qDkwYMDEmNiJhzQzbX6V3sfUowGN87
	 jGN/i3O1Oa+ramaGrgFzXdo8pn6QnAcYMFJqUTsGHQGiiaN/iJInav+sLYePT02Hz/
	 QPE3ObgwMCXs+ox6NP/PCwBLPgLrXYfobmvC/5kzh4Jra4n8zc4WF04CX3lD9bkiCp
	 APmMtpD9CQU6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E64D2811BE;
	Fri, 11 Sep 2026 05:09:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CB29C49D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 22:33:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BA1F240077
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 22:33:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HmrN_UcZbErm for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 22:33:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 295E640073
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::645"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789079591;
 b=EkuK4xQhNKhVJLqdLmNumUhrGfDXOcTwd1Fm0kbseINcsSU4HhXkBMkzUMCb1IWLPB/o
 2zrdD4SZNoyPCSumD3ynjS8aMr1eIoa6NY2aS8aKgsSCy8z0RSvwrdpnsOcCCkbjIEphM
 4a+Z66I7W4MckkAmMY55mQ9s6wCGy/nBt4fUC3l23zqHcpiIu/ZTLwVmyiywfg54DWf21
 XN4DDvI+4ZgFP4Eu226MEGRO+TXV5IPC3UJGoOmoNM+2gJCf94MqiBmwY1eywRSQFUtqS
 vFQ5ONQ2nOw3meB4jBpBbHfChPr9mtFXe54oA3ZfyaK6tnYWBxy0HP7ZNgdML83Zw8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789079591;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
 bh=WrtJhmDzX/88skuLKee3cl973TB46oo2LuJwus6sHGg=;
 b=Uv9rfdFIqE/VNeP/uvcEClu0edrGgJSfVzImoMWAuwl/YqGyPyZGpmSm02Xqdig0J0PE
 zEo9KZtSJk/QyTHrotae9qSj65iIvt3ZsB9KXuBdHcnxvxpJdPC9Ws60WqTdc/zDE160y
 5LIfYKcbS1wgmxZglxoDHdVOEyJV0W3i6rSGW9Lp6jv13O+tnmSZhuDsltvSvio2naQgQ
 pTv2jKawrkddOAUKRIgQJhYEfOCLvLRJ00a/RVQFQ//mSp+IC9eEuHdO9qGPpjYIWiDW7
 JYyxLofz+3WTyPhbd1dIqp5NcYwZkvO7uNXJTmotq+RDymqsrE/GwfRifkFjx+Y/olA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=google.com; 
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=XJG0gO0k; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::645"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::645; helo=mail-pl1-x645.google.com;
 envelope-from=3jtcjagskbm4kgjumaltmzssaasxq.oayg-naafxuefe.g-naaf-bdavqof.ads@flex--yuxiaozhang.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=XJG0gO0k
Received: from mail-pl1-x645.google.com (mail-pl1-x645.google.com
 [IPv6:2607:f8b0:4864:20::645])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 295E640073
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 22:33:10 +0000 (UTC)
Received: by mail-pl1-x645.google.com with SMTP id
 d9443c01a7336-2ce7dff6253so16756305ad.1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 15:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789079590; x=1789684390;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WrtJhmDzX/88skuLKee3cl973TB46oo2LuJwus6sHGg=;
 b=XJG0gO0k/ZjUgDUcHT76yjSaDRrfd9uM1lgY77z3NH+XtqJTjMtjiMrVa2JNnItise
 BkOD0Roik3ArzTBqAiMQc+CdfQTDpWt+aqD+yzBrAmXcBdIOYgReB0AWQIZjueYxxDLD
 qOjp18S60YH+zMG9LrORbaNocIC1t9dqZYq5Czlh902YDhBZEhOUdDiqY5xVGTTV4bwV
 ssuAB9puN4IBS+cc+qTFqEHfHfaLKhHWfhcE7FVnJBz6Ebhnr92MedoIKJi2gtATFfe4
 rwGlzeV02YTjwSTCr3Ip2p9JSIcyol46nmAUGsDGtUvJpL1akkFyecJkX9j0AeBbR4kg
 NqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789079590; x=1789684390;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WrtJhmDzX/88skuLKee3cl973TB46oo2LuJwus6sHGg=;
 b=WygkXxhCvBk68UxKrXlLDsgaU9pSIYCeaMQk9eKmN8HxH7T7MCE3TrEbo3f9DZdr7X
 LTyb+V+IhnWPEA+16kUy6xzN41/SvVlu34vVj4fWGJEjkv8N9ahWOG66I+YuHUyiW6xx
 wniky44DwMKS9VH6VWQv3gi7wN6VS5eky8R5myHjLX6s600MO9jWvVm18Qb0bXX1S8yl
 iPLFWbGyFnQuBHMsj85YbUV+aVfZyXju+CMBsmW0f9CkOzppgq5pCzwiB9ytReTIU9Rk
 WvfFnyOELaINWprgbhJqfFWYTIQqA5nXjEZR/509AzZRAT3Pg0GesHrBgGcEDO8LKNeL
 lAmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxLTIZSthslihbdJO17Mq0VOkSiT9zOLHaL1qRRM3w72VKRCdK+l1ycEgAoXnwDHgEp2AGCZc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m4I4hcmhtGSnTzDtjrjw+gT9oEUIgg56ykKWW9EXwFdYjpQSRS
 sVGcSSYQxs7Qd80G1f0BL+5ZxKrw/19kwDLnvdH3l8A3RFfQeurQBlkVZ6t4qAfbmmnkIhVgIHr
 GBf6ZKMBdB5RyL2GpU8zVh69WKw==
X-Received: from dycak9.prod.google.com ([2002:a05:7301:1c09:b0:334:e08b:1b72])
 (user=yuxiaozhang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:fc4f:b0:396:669c:b5f6 with SMTP id
 98e67ed59e1d1-39d7796cf16mr8571087a91.12.1789079589939; 
 Thu, 10 Sep 2026 15:33:09 -0700 (PDT)
Date: Thu, 10 Sep 2026 15:32:55 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910153255.1.I1473cc3e9adc7793245927386e6fb0278d9ae4af@changeid>
Subject: [PATCH] net: dhcp6 use link local address
From: Yuxiao Zhang <yuxiaozhang@google.com>
To: u-boot@lists.denx.de
Cc: Yuxiao Zhang <yuxiaozhang@google.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 11 Sep 2026 05:09:50 +0000
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

dhcpv6 is a special UDP traffic and should always use link local
addresses. Only pick net_ip6 if it is not empty and if it is not dhcp6.

Signed-off-by: Yuxiao Zhang <yuxiaozhang@google.com>
---

 net/net6.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/net6.c b/net/net6.c
index 4cff98df15c..18072bd9f49 100644
--- a/net/net6.c
+++ b/net/net6.c
@@ -330,6 +330,10 @@ int net_send_udp_packet6(uchar *ether, struct in6_addr *dest, int dport,
 	uchar *pkt;
 	struct udp_hdr *udp;
 	u16 csum_p;
+	struct in6_addr *src =
+		(dport == 547 || ip6_is_unspecified_addr(&net_ip6)) ?
+			&net_link_local_ip6 :
+			&net_ip6;
 
 	udp = (struct udp_hdr *)((uchar *)net_tx_packet + net_eth_hdr_size() +
 			IP6_HDR_SIZE);
@@ -341,7 +345,7 @@ int net_send_udp_packet6(uchar *ether, struct in6_addr *dest, int dport,
 	/* checksum */
 	udp->udp_xsum = 0;
 	csum_p = csum_partial((u8 *)udp, len + UDP_HDR_SIZE, 0);
-	udp->udp_xsum = csum_ipv6_magic(&net_ip6, dest, len + UDP_HDR_SIZE,
+	udp->udp_xsum = csum_ipv6_magic(src, dest, len + UDP_HDR_SIZE,
 					IPPROTO_UDP, csum_p);
 
 	/* if MAC address was not discovered yet, save the packet and do
@@ -353,8 +357,8 @@ int net_send_udp_packet6(uchar *ether, struct in6_addr *dest, int dport,
 
 		pkt = net_nd_tx_packet;
 		pkt += net_set_ether(pkt, net_nd_packet_mac, PROT_IP6);
-		pkt += ip6_add_hdr(pkt, &net_ip6, dest, IPPROTO_UDP, 64,
-				len + UDP_HDR_SIZE);
+		pkt += ip6_add_hdr(pkt, src, dest, IPPROTO_UDP, 64,
+				   len + UDP_HDR_SIZE);
 		memcpy(pkt, (uchar *)udp, len + UDP_HDR_SIZE);
 
 		/* size of the waiting packet */
@@ -370,8 +374,7 @@ int net_send_udp_packet6(uchar *ether, struct in6_addr *dest, int dport,
 
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
2.55.0.1007.g17ff1f9808-goog

