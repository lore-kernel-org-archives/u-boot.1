Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1895CC5AC67
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 01:50:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD1004090C;
	Fri,  7 Aug 2026 01:50:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6v4ZOPwcuRd5; Fri,  7 Aug 2026 01:50:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AFC9240894
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786067428;
	bh=DFnF7HiMEpJDr4K3S86JHFB18VlKiZQGiJfFUHJb1N8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=syf8tV1oiTelNoTZfOPoCxoNVKAbkV2RKZjwLIuwK5DzgwdEdSrR+J/h7aKdrOvfZ
	 BWdPBEx9UcZ7rtlhxaBjU6rNra3scd9SvNt6Q5bwEJW3j+sI/47/AUMBHLOaU8dBAb
	 bD2mbsntV1F3mFbT26eNqgRIzADkMtnPbj3OTlr6AaOkNTE+2S1h1G2D2odZaV7X6o
	 okm7kWRan65/JaK8UPjJbMfNxzisCjLAmObDX2LgAcqNOEp4Myx9wp74jP2mWNBREl
	 Kt6wilrJE6Jq7qyTF/TGycZmxI6prcPm88w3/rcB8RybAiUVknqQb9tGr/ln+g8GT1
	 oSIbgHsdyJiNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFC9240894;
	Fri,  7 Aug 2026 01:50:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 236D6392
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 18:38:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 153E840813
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 18:38:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0uBWlxgXm8-u for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 18:38:07 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F3CC14085E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F3CC14085E
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F3CC14085E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 18:38:06 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c2055f5a993so158512466b.2
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 11:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786041485; x=1786646285;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DFnF7HiMEpJDr4K3S86JHFB18VlKiZQGiJfFUHJb1N8=;
 b=E2aCz/+DhESh1GM07j3DafPHpP9cuR/bgEbGxma8qMS2ArYbI4qSUL3I53dWyinpIB
 UQxfiacrE20H7qDEZ23IvPKs2421KRZnfvo27x1Iz9aQWpjDJGBG/IRKbUIS2+JqBZbs
 tCvp19kQrKC9ZGt6c3Djdg5lR34pkuqQ9mLApytaxLkYgAEahO4rqyzyibQIhdOIL6y8
 9NfKaBiVckGWez37Qm+FgtlU7CPic/geSr1QImqaOPHmMxE5V9moFU2mhVrnkdBpKIvv
 YemRiSGFapS+1xqhMn8eG8LINDXThVtyJ5pKg9vtA+P9K9vt+QeqHlJICkh6/SoFTyj9
 B4kg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUGzCYiaIz1GXvtR7/JnMxET9vVsM4FCrc31jGruyOHiFhj9NjTpAZU4fT7175eJsC6/ZAuQs=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzEeViG1C4h3ANW9aWNUgPPIzbS7Cqa3sDnClKVR+RFeWtdXYbc
 L8cVnkLPT74yDDEJySX1j5KJo93iX9OeX44oQDwf1RlmLgA/U8J7w74j2egkYXpZOLphJtiGSsc
 QnpKmcQk=
X-Gm-Gg: AR+sD10yb0wp2hKV8oPLNrBMOof33pBU8xHYFR852fHQ40EP5/C1cL25XQHYu3TvQyO
 lyvBHmse1weLExmdrm0mWYQlwPgTYfVNOcNv/RwDlOtHc1z+h5nhhkJNl7ckW5ydvVY3qTkxHLe
 VI95EBciI6hphmHOyvo+b2fhszid+G14fCjk6zx7Mooa85YbxwxhPhYpop8Gd7beDOVlto4Ku4J
 0kkrMa5Kw+NNgoxRMKouP6gLb2Y1kz4UZ+pMbrUQUJSFvimnUh71Yrtc0viJHyNkDMmfMQ8bGsv
 sq+7DzOKE2Xb9bZ3dQ/r8QCAD0BiMM9S3OwLJUAQYjEQpB2LrHUERuVaBOSlq0APmNdHdoUyu8k
 GmpkPusofUC9GRQfpVUdQawQuL7vRuETfETRMcMMc5oqmtPx4QY9hBAgjPbbHg/etRDVAa1gFF7
 tVLGGNRozFgANgg1mHqt6wl9OrbKdCvZRUzk9RpiFo9Z1uQufn4A4IVVeYpXcFHRMnYVrFmxHhb
 gqjpt94oMnqHRGXmkLIRRmfUU7cPGY4BhmJDaf8dlQxyVz/hc4WLA==
X-Received: by 2002:a17:906:eec4:b0:c1c:2ee9:5e6d with SMTP id
 a640c23a62f3a-c2039c39717mr860698066b.17.1786041484910; 
 Thu, 06 Aug 2026 11:38:04 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00156d21543c815f45.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:156d:2154:3c81:5f45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c203642435dsm290075266b.44.2026.08.06.11.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 11:38:04 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Thu, 06 Aug 2026 20:37:51 +0200
Subject: [PATCH 2/2] test: dm: eth: add DHCPv6 oversized option regression
 tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-dhcp6-serverid-oob-v1-2-4ec6857682e1@byteray.co.uk>
References: <20260806-b4-dhcp6-serverid-oob-v1-0-4ec6857682e1@byteray.co.uk>
In-Reply-To: <20260806-b4-dhcp6-serverid-oob-v1-0-4ec6857682e1@byteray.co.uk>
To: Sean Edmond <seanedmond@microsoft.com>, 
 Ramon Fried <rfried.dev@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Argus <argus@byteray.co.uk>, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 07 Aug 2026 01:50:23 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786041485; x=1786646285;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DFnF7HiMEpJDr4K3S86JHFB18VlKiZQGiJfFUHJb1N8=;
 b=MilsrrvLqV5Sv8ibmtBt07toZjLXUWEk8fgEIRr6r1UcqfEZlTFpE/NI5qPYn60hI0
 tdbxYXilYzkqNPXZOTQxwOlHxLhWwiOJmtIVUcnUw2GgOHoca9ZGDuOCbf9uiohKGIHr
 7mpN/5b9YZ1d6Vkx84IHik7TUcB2CUoN3TxBuagqfR19GN+jF/vbEidugfk6axTlk/k+
 NdNg1q9NweLS934AaAGtjTB5PEbQLjFzeh6wgHcf8+o3BZIl1utT25CmdKsPIz7FEnJY
 +bJI5X8o02pAqCOuDOXL9go3NC3rRKPW+WZQcTyuss1PCHFufroqpkJ+EttzdOn2QOfv
 5CoA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=MilsrrvL
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

Answer a DHCPv6 SOLICIT from the sandbox eth tx handler with an
ADVERTISE that carries an option longer than a valid DUID, and check
the client rejects it rather than sending a REQUEST.

Two cases cover the option parser: an over-long SERVERID, which a client
that trusts the length copies out of bounds while building the REQUEST,
and an over-long CLIENTID, which drives a memcmp past the client DUID
buffer.

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
 test/dm/eth.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/test/dm/eth.c b/test/dm/eth.c
index ed0b57d8861..f3a972c5c0a 100644
--- a/test/dm/eth.c
+++ b/test/dm/eth.c
@@ -621,6 +621,157 @@ static int dm_test_eth_async_ping_reply(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_eth_async_ping_reply, UTF_SCAN_FDT);
+
+#if IS_ENABLED(CONFIG_CMD_DHCP6) && IS_ENABLED(CONFIG_IPV6)
+#define DHCP6_DUID_LL_LEN	10	/* type(2) + hw_type(2) + MAC(6) */
+static bool dhcp6_request_seen;
+static bool dhcp6_advertise_sent;
+static int dhcp6_clientid_len;
+static int dhcp6_serverid_len;
+
+/*
+ * Answer a DHCPv6 SOLICIT with an ADVERTISE whose SERVERID option is longer
+ * than any valid DUID. A correct client rejects it and never sends a REQUEST;
+ * a client that trusts the length copies it out of bounds while building the
+ * REQUEST.
+ */
+static int sb_dhcp6_advertise_handler(struct udevice *dev, void *packet,
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
+	/* a REQUEST means the client accepted the over-long SERVERID */
+	if (sdhcp6[0] == 3) {		/* DHCP6_MSG_REQUEST */
+		dhcp6_request_seen = true;
+		net_set_state(NETLOOP_FAIL);
+		return 0;
+	}
+	if (sdhcp6[0] != 1)		/* DHCP6_MSG_SOLICIT */
+		return 0;
+	if (dhcp6_advertise_sent) {
+		/* the client re-solicited, so it rejected the ADVERTISE */
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
+	/* CLIENTID: the client DUID from the SOLICIT, padded to the test size */
+	opt[0] = 0; opt[1] = 1;
+	opt[2] = dhcp6_clientid_len >> 8;
+	opt[3] = dhcp6_clientid_len & 0xff;
+	memcpy(opt + 4, sdhcp6 + 8, DHCP6_DUID_LL_LEN);
+	opt += 4 + dhcp6_clientid_len;
+	/* echo the client's IA_NA (hdr 4 + iaid/t1/t2 12) */
+	memcpy(opt, sdhcp6 + 4 + 14 + 6, 16);
+	opt += 16;
+	/* PREFERENCE = 255 so the client acts on this ADVERTISE at once */
+	opt[0] = 0; opt[1] = 7; opt[2] = 0; opt[3] = 1; opt[4] = 255;
+	opt += 5;
+	/* SERVERID of the test size */
+	opt[0] = 0; opt[1] = 2;
+	opt[2] = dhcp6_serverid_len >> 8;
+	opt[3] = dhcp6_serverid_len & 0xff;
+	memset(opt + 4, 0x41, dhcp6_serverid_len);
+	opt += 4 + dhcp6_serverid_len;
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
+static int dhcp6_run_advertise(struct unit_test_state *uts)
+{
+	dhcp6_request_seen = false;
+	dhcp6_advertise_sent = false;
+	sandbox_eth_set_tx_handler(0, sb_dhcp6_advertise_handler);
+	sandbox_eth_skip_timeout();
+
+	env_set("ethact", "eth@10002000");
+	net_loop(DHCP6);
+
+	sandbox_eth_set_tx_handler(0, NULL);
+
+	/* the malformed ADVERTISE must be rejected: no REQUEST is sent */
+	ut_assert(!dhcp6_request_seen);
+
+	return 0;
+}
+
+/* Check the DHCPv6 client rejects an over-long SERVERID option */
+static int dm_test_dhcp6_serverid_reject(struct unit_test_state *uts)
+{
+	dhcp6_clientid_len = DHCP6_DUID_LL_LEN;
+	dhcp6_serverid_len = 200;
+
+	return dhcp6_run_advertise(uts);
+}
+DM_TEST(dm_test_dhcp6_serverid_reject, UTF_SCAN_FDT);
+
+/* Check the DHCPv6 client rejects an over-long CLIENTID option */
+static int dm_test_dhcp6_clientid_reject(struct unit_test_state *uts)
+{
+	dhcp6_clientid_len = 20;
+	dhcp6_serverid_len = DHCP6_DUID_LL_LEN;
+
+	return dhcp6_run_advertise(uts);
+}
+DM_TEST(dm_test_dhcp6_clientid_reject, UTF_SCAN_FDT);
+#endif
 #endif
 
 #if IS_ENABLED(CONFIG_IPV6_ROUTER_DISCOVERY)

-- 
2.43.0

