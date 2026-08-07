Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE1BC5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84BEC81313;
	Fri,  7 Aug 2026 16:12:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D96NCIcW14VF; Fri,  7 Aug 2026 16:12:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6AB0480E55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786119173;
	bh=HNKb8gl2v39eGV5/yDp4ZBFinbqbjcQ1Cwwrm36d5Co=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pUSr5yfNvpc0HcgVRWFDUyzOmX0yJVW2anzb3qU4esYyVC12uTUL+CWrmQDYe2zxW
	 j95Hz74e0JMC/FcjKqOL53mMrZNI/pVOTAP8EGoqJgz1SsMSlnJgK/57s9i6cqm7Tr
	 TxwBTgvjOW2Uh/wQGc31z01LGzv995ihtX3d4ygl/Yb+BO+B/qlGvkpgq9p7xNyBZI
	 Ir89IoPyCHhKWdD5qSyUS+4hBBWON4kWd2k6lSCP1ESY7dwngYUQfJrAzBFCuxVTO+
	 des+0hpoXqqzi48M1cVEntI66nT9WzTFZtJwtc42U/CyZeDNuh7LGJ/xZOPXq0vEQv
	 8Q4YRx6bHxYPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AB0480E55;
	Fri,  7 Aug 2026 16:12:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 07C46198
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:52:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E248440074
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:52:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6qj5IYkJQfWG for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 14:52:44 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EE18D4024A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EE18D4024A
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE18D4024A
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:52:43 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a144c8eea2so5007640a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 07:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786114362; x=1786719162;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HNKb8gl2v39eGV5/yDp4ZBFinbqbjcQ1Cwwrm36d5Co=;
 b=fj8PUUIB0PmB6LXugyVtPyOGHufQFaLQdLkAm2eBaT2kOFrUTJNn0Co+GE2N1/5xjk
 +lGZaBh+HYgtE2b4XBPxoEVAOVku4IoJ8p8fcDEWtMlPR7sLnF+W0BazxCo0L1OmVHiT
 9dP4Wzs0asQJiIuCLEOk7EuNBO2WoyeQPr91vwBWjZPiFE14LE7O6+jT31C8FIlxzW96
 UyHe9YFU66HId9pspS0JMdyFB7qcwQn7LF7tZL6aXJkvZ7rl7UkfiRxCJxx0fXc0ANz2
 rw+BLDtPoXK0cVIsllDlgXu0Ajk7n3ZOLHS4Wac0bFBWSun8hUwOmQvbe49GWBW7CNrA
 hGHA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQYGxhFqf7pLiS7Az4TYXsLjPaTZj89h8SHGM/Ez4MnESQwwSUIFZQ02oJHOPq2K7d7pk+itc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxU4Gtc9M4qpyHg1clcZNmQ8XQh9cecuVsMJG3FTGQYJ1D4lt3x
 vPTVPtjkfT1imigbnmrxLzsO3MLb8qpgX8LaF1KXJ6/Dw9QHnhW/0X+xV3XtevquCA8=
X-Gm-Gg: AR+sD13J3r1/NaJ5pXJGcjgXKujSJgSzwz1JIxQl/8q7A0y5YezYu1NfqaeGGHtcvQ8
 NsFOaYr7R8jnQ2z3hUjhJLkoTXVjyM6vNqN5q3j+J3NnfjCLmsJIaisBtl2KhT9WmtytSeDOk0G
 nHCHwIvjjR4CZA+xXR3ApvD/peNO0Kw6ehR+PWa45k5pOJ/lud3oitAqPpjYZ6sDbh2rb2X72tM
 N/8cvjyYgicMVXlzXzyokd+jcxsncDvj/ulzxSb7zUI4zT2jsK1aq/1+dgWlebw+zIG/+CeNttG
 gUwR3QTzqsBbGuoBk4fOvZ4tiEVNx//DJLKxQwNB6roWGmbi7LFWYj0qb2rlft21LeD/Ideb6NX
 qdFctjVPSXz8R3bgfgf1/GvL3IglqybKE2FrqlPJi7850E6lcOptZvqHyrhq3s9FNjbMW0M2T+s
 ddrHoyZ32Sde5arf0Dq4LZ7ZQ1vm0e8XrDK7h+DJhb57k0ZVLgvu8kE7Q/M6PkS5nhT4GUd/Cs3
 vUFiCegs/lCColFIpdCVhz/q0EiE8bha9NKV10NXqjyp/aeNkTkDg==
X-Received: by 2002:a17:906:7c43:b0:c19:5a94:411b with SMTP id
 a640c23a62f3a-c208726190fmr53835166b.6.1786114361825; 
 Fri, 07 Aug 2026 07:52:41 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f0050294ea7756f18f0.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:5029:4ea7:756f:18f0])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2080cc3963sm62218566b.50.2026.08.07.07.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 07:52:41 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Fri, 07 Aug 2026 16:52:22 +0200
Subject: [PATCH 2/2] test: dm: eth: add a DHCPv6 zero-length IA option test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-poc-dhcp6-ia-loop-v1-2-9d3fd3171c59@byteray.co.uk>
References: <20260807-poc-dhcp6-ia-loop-v1-0-9d3fd3171c59@byteray.co.uk>
In-Reply-To: <20260807-poc-dhcp6-ia-loop-v1-0-9d3fd3171c59@byteray.co.uk>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sean Edmond <seanedmond@microsoft.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Francois Berder <fberder@outlook.fr>, Argus <argus@byteray.co.uk>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 07 Aug 2026 16:12:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786114362; x=1786719162;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HNKb8gl2v39eGV5/yDp4ZBFinbqbjcQ1Cwwrm36d5Co=;
 b=TbFQbwlKyD/h9cYLM4VItnqTuBY5/TXXJswbmwX9zc2n5fV4a+3jme2FwtEJrDviJt
 y1pHpqTBrPHxhNBXSRRC/enxmFnJsfOjRksPX3w5S/vhm2ERYrjbvatYqW6Vea5FCF7q
 RlMid2m7WcjQ9m9ENDWI1gFinVdxRoj6xF/D1kc4dQhb97FIKBGxWnMTK0QVuA1nb4yo
 a1cuelMykLmILkGf/6vilJZJHVrLKR+hUWZEhhvtsYXth56klXrCKkXhPqXfHLPkzxZh
 XDA0SS890uUFjyqaY1Zm1R0wCfy1c+KKB/zE71YD1J5qEgkVHUl2u3ntSQG6cPBVtxZC
 ZncA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=TbFQbwlK
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Answer a DHCPv6 SOLICIT with an ADVERTISE whose IA_NA holds a zero-length
encapsulated sub-option and check the client parses past it and
re-solicits instead of stalling in the IA option parser.

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
 test/dm/eth.c | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/test/dm/eth.c b/test/dm/eth.c
index ed0b57d8861..4708f0a4676 100644
--- a/test/dm/eth.c
+++ b/test/dm/eth.c
@@ -621,6 +621,126 @@ static int dm_test_eth_async_ping_reply(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_eth_async_ping_reply, UTF_SCAN_FDT);
+
+#if IS_ENABLED(CONFIG_CMD_DHCP6) && IS_ENABLED(CONFIG_IPV6)
+static bool dhcp6_advertise_sent;
+static bool dhcp6_resolicited;
+
+/*
+ * Answer a DHCPv6 SOLICIT with an ADVERTISE whose IA_NA holds an encapsulated
+ * sub-option of length zero. A correct client bounds the sub-option, finds the
+ * ADVERTISE carries no SERVERID and re-solicits.
+ */
+static int sb_dhcp6_ia_option_handler(struct udevice *dev, void *packet,
+				      unsigned int len)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct ethernet_hdr *seth = packet;
+	struct ethernet_hdr *eth;
+	struct ip6_hdr *sip6, *ip6;
+	struct udp_hdr *sudp, *udp;
+	uchar *sdhcp6, *d, *opt, *rx;
+	int msglen;
+	u16 udptot;
+
+	if (ntohs(seth->et_protlen) != PROT_IP6)
+		return 0;
+	sip6 = (struct ip6_hdr *)((uchar *)packet + ETHER_HDR_SIZE);
+	if (sip6->nexthdr != IPPROTO_UDP)
+		return 0;
+	sudp = (struct udp_hdr *)((uchar *)sip6 + IP6_HDR_SIZE);
+	if (ntohs(sudp->udp_dst) != 547 || ntohs(sudp->udp_src) != 546)
+		return 0;
+	sdhcp6 = (uchar *)sudp + UDP_HDR_SIZE;
+
+	if (sdhcp6[0] != 1)		/* DHCP6_MSG_SOLICIT */
+		return 0;
+	if (dhcp6_advertise_sent) {
+		/* the client parsed the ADVERTISE and re-solicited */
+		dhcp6_resolicited = true;
+		net_set_state(NETLOOP_FAIL);
+		return 0;
+	}
+	dhcp6_advertise_sent = true;
+	if (priv->recv_packets >= PKTBUFSRX)
+		return 0;
+
+	rx = priv->recv_packet_buffer[priv->recv_packets];
+	memset(rx, 0, PKTSIZE);
+
+	eth = (struct ethernet_hdr *)rx;
+	memcpy(eth->et_dest, seth->et_src, ARP_HLEN);
+	memcpy(eth->et_src, priv->fake_host_hwaddr, ARP_HLEN);
+	eth->et_protlen = htons(PROT_IP6);
+
+	ip6 = (struct ip6_hdr *)(rx + ETHER_HDR_SIZE);
+	ip6->version = 6;
+	ip6->nexthdr = IPPROTO_UDP;
+	ip6->hop_limit = 255;
+	memcpy(&ip6->saddr, &sip6->daddr, sizeof(struct in6_addr));
+	memcpy(&ip6->daddr, &sip6->saddr, sizeof(struct in6_addr));
+
+	udp = (struct udp_hdr *)((uchar *)ip6 + IP6_HDR_SIZE);
+	udp->udp_src = htons(547);
+	udp->udp_dst = htons(546);
+
+	d = (uchar *)udp + UDP_HDR_SIZE;
+	opt = d;
+	/* dhcp6 header: reuse the SOLICIT trans_id, msg_type = ADVERTISE */
+	memcpy(opt, sdhcp6, 4);
+	opt[0] = 2;			/* DHCP6_MSG_ADVERTISE */
+	opt += 4;
+	/* CLIENTID copied from the SOLICIT (hdr 4 + DUID-LL 10) */
+	memcpy(opt, sdhcp6 + 4, 14);
+	opt += 14;
+	/*
+	 * IA_NA (option 3), data length 20: IA_ID/T1/T2 (12) plus one
+	 * encapsulated sub-option header (4) of length 0, plus 4 trailing bytes.
+	 * Copy the client's IA_ID from its SOLICIT so the option is accepted.
+	 */
+	opt[0] = 0; opt[1] = 3;
+	opt[2] = 0; opt[3] = 20;
+	memcpy(opt + 4, sdhcp6 + 4 + 14 + 6 + 4, 4);	/* IA_ID */
+	opt[16] = 0; opt[17] = 5;	/* sub-option DHCP6_OPTION_IAADDR */
+	opt[18] = 0; opt[19] = 0;	/* sub-option length 0 */
+	opt += 24;
+
+	msglen = opt - d;
+	udptot = UDP_HDR_SIZE + msglen;
+	ip6->payload_len = htons(udptot);
+	udp->udp_len = htons(udptot);
+	udp->udp_xsum = 0;
+	udp->udp_xsum = csum_ipv6_magic(&ip6->saddr, &ip6->daddr, udptot,
+					IPPROTO_UDP,
+					csum_partial((u8 *)udp, udptot, 0));
+
+	priv->recv_packet_length[priv->recv_packets] =
+		ETHER_HDR_SIZE + IP6_HDR_SIZE + udptot;
+	priv->recv_packets++;
+
+	return 0;
+}
+
+/* A zero-length IA sub-option must not stall the DHCPv6 option parser */
+static int dm_test_dhcp6_ia_zero_len_option(struct unit_test_state *uts)
+{
+	dhcp6_advertise_sent = false;
+	dhcp6_resolicited = false;
+	sandbox_eth_set_tx_handler(0, sb_dhcp6_ia_option_handler);
+	sandbox_eth_skip_timeout();
+
+	env_set("ethact", "eth@10002000");
+	net_loop(DHCP6);
+
+	sandbox_eth_set_tx_handler(0, NULL);
+
+	/* the client parsed past the zero-length sub-option and continued */
+	ut_assert(dhcp6_resolicited);
+
+	return 0;
+}
+DM_TEST(dm_test_dhcp6_ia_zero_len_option, UTF_SCAN_FDT);
+#endif
 #endif
 
 #if IS_ENABLED(CONFIG_IPV6_ROUTER_DISCOVERY)

-- 
2.43.0

