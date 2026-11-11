Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A168606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=As5y6xRH;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nCyEEqaM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28FC440998;
	Wed, 11 Nov 2026 20:12:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x9oKj1lVs1IY; Wed, 11 Nov 2026 20:11:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 492C140DB8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794427919;
	b=BZgj6ZHiMPJJahe8ioN/RyC3ESngW7P+wYhDz5tzw7Y8CuwHlR6Nk86I50nLjggSdEVY
	 y58Qdur84uvKHwRVZcn+UyST8mZRAyjFbvn2MMiZ0m84Pd+b/raN2Nw49B+Jz0FdUN+8X
	 3GTzCRr/79bSatI/WTgtga4VyP8LfVMlKOvvcRmizHlV+frfmQ9IjJh90+nkbHldhHP2w
	 O+NX6tnic5HHWFaqkdUsY2DUfMjSd2jzt5NZM1T9XFv9XlSWhpvXpfxNS5c6EYFgv64qz
	 uyigL2ARTKzrvsWN95kZhxYkWTVFfFlaDYiB4uPGM35kPFmAU51XuAGTQgIdUzQ53yg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794427919;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EBaAEENSth04T04YAIpEB4UWlRlOIIYw5slOml/EMXo=;
	b=oGd/AU+MYIvYsuB3ZYZV8UKwaMGecDoApQMZyH8t660dRggvl6z0EzhYKWA789tmUOyk
	 JfOPqxI6ui5Mq2AG3jM88Y5aYqVhrK2bsMuGS5N774VEaH6hoAqy5y2cO4JMiYDFsI6ao
	 WgCifYIQKdwuBQ1FOhuh0ob6ymNjVvdHvExxtnQYgorfavOiqCWD3Y+HKErBjkjaIacGc
	 3/M229KEhRwsRYKdy07PVG2thDL1HBva2Ls5hD1mesycuLCcT61mCiXK0+prt+kOaGJRG
	 fS37DwWGcAgoverUyK/TObtNsyfN20zw9wueyG6/L2P9246eWexYg3poiOOsGLAK7UA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nCyEEqaM;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794427919;
	bh=EBaAEENSth04T04YAIpEB4UWlRlOIIYw5slOml/EMXo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=As5y6xRHvLn0jdG7MEJ3hR4k+2CTtzvshZJWsClby9g1PmY4+O9xymfFK+nypV6LF
	 kxPgTFAbkbSfN22YiuuhOReuKHGpwtMHkpm3a8QdW/12wsmdBmJZN/GuZRQfLrTzkZ
	 tmE0fscHCc2T/ZfxvPIknizSu19XQnWFkZ15wCaq1GN++dioHYis/9kcjDXna1C9F8
	 PpxEnKq93svr25ghDyZT+0XUFEKI9a50xaqQVcfXHg/iBm1J9YhqbUh6qXdyz3I1UB
	 CPGmtziN7C3hiUFhMfXYQEywObEuCTeA9gnTHddgS3ITcAn+O0o49Hf3mA+aqy2tGD
	 sFXRDYCAh3Z1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 492C140DB8;
	Wed, 11 Nov 2026 20:11:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F974178C
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 65A2940DB7
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RS6C4hpSfKxt for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 20:11:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 17FB340D99
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=nCyEEqaM
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 17FB340D99
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 20:11:42 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-82109f51565so1554472a34.2
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794427902; x=1795032702;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EBaAEENSth04T04YAIpEB4UWlRlOIIYw5slOml/EMXo=;
 b=nCyEEqaMxmaFqbSDUcvkFPCrCxGSXjtMU/XDPfpPIq2M1nHLKonSKABR98IH9wT1ck
 5CDDdiO9Hzh+Yh8Jm9bRUDHiC5ESxAPWwLZlAq/5fGK4hJVq6EF1M+F7aS17ru3UldVv
 /yCmECz9Uq2FuSfZhSFriuMeLPBjjgbWC+yPsn0jhySib6L3Tc78vciuRwwPEAzZy9ab
 KxsjvQDCZn6bzchy2+fO/eRhWPZ7Izy81oc3WXau/+GArG4CO/VWZSoGDAZOxjAgWiLr
 avori6A7iVAMi7RvMzj5xGHnqP7Mpg1UXmV1bhXJZXTwVNkYSGuYm4178YcAvZps2Ejb
 XjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794427902; x=1795032702;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EBaAEENSth04T04YAIpEB4UWlRlOIIYw5slOml/EMXo=;
 b=AmtzcsId0202uxCGN5r/a5OeuRkMBqhIsNz3TtEqYSduDYAWsBBDNuS7T91Y0lPtDN
 pcgW3jytelTW5Wv0bz+gKmoxD2DcYB+zkURoyzunOjwNZetSFzWGB9aHtxlYh3LQrs9Z
 UkFuu5cWyV+RZJThrX5kwKyRdmlFkbt9x9bMBVOzcDQsL2JNNRgDG6izd+hciqeaDfC3
 V8Zt2iSGkeLHzfSXFk+x3HpqxWUHlVaspdv2shF+mTuBUyPfPDtmwMHebfXacjOGhZf0
 DhUmT+ePxx+FSQSBD736XPxfjauCPlJKAOH219iQE/lWe4a5MXljdIYHiblqI/Du3aOf
 A3AA==
X-Forwarded-Encrypted: i=1;
 AL+hErHGMWNwrWtLyTLmllGLTwt6XqAHSo7mgTaqjh709YFfFpOAfSuxk4CP7BlDczlDCznFEmq8a6w=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z90Sv/w8AjZ3HoJBhdN/arZ14WrJwvubegaTMUBF9rVN1YfQfms
 qRlwSYtMOusF4GzCPmrC9aI/wd+OU4buNodtPNo4ZyKQCaohw7r5O16s
X-Gm-Gg: AYBFou06J487HgFH+uJy7NQtggLia29NsPB6uNwQMNZD89rtJTWyru0hVzhahQeo0V7
 5i+y4AMaXKaQnQR7lH/AgdeQ1PN211Mi+Er7ozuziv7z60broWqKFGS8WhOzRaUUTHjLmObSFVo
 qdVfk4iMavIKT9ZEgAyo7NsXoj/UvdvPtSsXRgtxSUexIcWQneHpARVQyQNpX3yRC867xNV3dEM
 k2+PPoq+USVzqK8P5mkXOmG3FzcXm/TjPbULif+gKIiKYPSp8YVRp7izTWnTKHMVrk24893jMY2
 lO1HMUscOzuLbasudOHxhFYSoUsoKuM2zuaRoDcdflpcRmJmhtfd6MSMYZ7YUxdasfG8jZxTUGg
 euPYNFgcAukQ5PNymRY8oJTWQ90GVRkRHHfMqj/h9CXJNObCuy8F3C72zM3oBZa4nMTygu5iCCO
 +noIXuUafdLw7n//A9jK36iP3cvWDgNz04gI97SdGWijHQ79qmA7+vpjZLlIA2pb9x8l+sFVflk
 rEzshtQqOkuAOViE8e13DRADvxIq1nCl4URVa/sITFB/DbXyt9BMjtedNrBaVqcAPVEFH7zVa8+
 hNY/Le+ZhpDuFrBchXGD+Dm8XsFQUOE2Tbi9IV2XXSg9b7t4kVBJMrnJc/BtR023lwvmZOoDZ3E
 PPmvau0JU1/rAXYz/OvuDHC1G5o59fUco8yZlw8/tflEDZghTddmnMcqjO5P1X+13BBfpzeU9ok
 dq2SmYq3nMwiSf4V2NYgf+qKWV6lm5R2VHLEGUHnc6Dhusgi0msreA
X-Received: by 2002:a05:6808:1209:b0:567:c40e:c79e with SMTP id
 5614622812f47-56b966b962amr3196138b6e.24.1794427901399; 
 Wed, 11 Nov 2026 12:11:41 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905d3bab2sm5863446b6e.12.2026.11.11.12.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 12:11:40 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Nov 2026 13:11:25 -0700
Subject: [PATCH 18/19] test: net: exercise lwIP IPv6 application transfers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-submit-lwip-ipv6-v1-v1-18-eb0ee8f8da1a@gmail.com>
References: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
In-Reply-To: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Igor Velkov <iav@iav.lv>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Murtaza Munaim <murtaza@saramena.us>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Drew Kluemke <ankluemk@microsoft.com>
X-Mailer: b4 0.15.2
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

Extend the sandbox peer with TFTP, HTTP, NFS, SNTP and netconsole replies.
Exercise fragmented TFTP reception, uploads, listeners, hostname
resolution, port-unreachable errors and application framing.

Verify that scheme-like path and query text stays in the HTTP request
target, and that HTTPS authentication cannot be bypassed by an embedded
HTTP URL.

Check bounded decimal parsing for HTTP ports and TFTP ports, block and
window sizes, timeouts and retry limits. Reject overflowing values before
sending a request and preserve TFTP's zero-port defaults.

Exercise output-only netconsole across finite address and router expiry,
advertisement recovery, static and infinite configuration, and output
from an active poll callback. Check that unavailable configuration drops
output promptly.

Check input-only netconsole after unrelated environment updates and a
change of link-local peer, rejecting traffic from the previous peer.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 test/dm/lwip_ipv6.c | 720 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 719 insertions(+), 1 deletion(-)

diff --git a/test/dm/lwip_ipv6.c b/test/dm/lwip_ipv6.c
index d82b936a96c..185f7aafb4d 100644
--- a/test/dm/lwip_ipv6.c
+++ b/test/dm/lwip_ipv6.c
@@ -38,15 +38,30 @@ struct ip6_test {
 	unsigned int echoes;
 	unsigned int bad_checksums;
 	unsigned int corrupt;
+	unsigned int requests;
+	unsigned int uploads;
+	unsigned int fragments;
 	unsigned int dns_queries;
 	unsigned int dns4_queries;
 	bool drop_dns;
 	ip6_addr_t last_dns;
+	unsigned int http_requests;
+	unsigned int rpc_requests;
+	unsigned int sntp_requests;
+	unsigned int console_packets;
+	bool console_no_reply;
+	const char *http_host;
+	const char *http_target;
+	const char *tftp_file;
+	bool unreachable;
+	bool listener;
+	bool listener_done;
 	u32 rdnss_lifetime;
 	bool lease_conflict;
 	bool conflict;
 	bool advertise;
 	bool cancel;
+	bool fragment;
 };
 
 static u16 ip6_test_checksum(struct ip6_hdr *ip, void *data, unsigned int len)
@@ -64,6 +79,7 @@ static int ip6_test_reply(struct udevice *dev, const ip6_addr_t *src,
 			  u8 proto, bool bad_checksum)
 {
 	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct ip6_test *test = priv->priv;
 	struct eth_pdata *pdata = dev_get_plat(dev);
 	struct ethernet_hdr *eth;
 	struct icmp6_hdr *icmp;
@@ -102,6 +118,40 @@ static int ip6_test_reply(struct udevice *dev, const ip6_addr_t *src,
 		if (bad_checksum)
 			icmp->chksum ^= htons(1);
 	}
+	if (proto == IP6_NEXTH_UDP && test->fragment) {
+		struct ethernet_hdr *tail;
+		struct ip6_hdr *tail_ip;
+		struct ip6_frag_hdr *first_frag = (void *)(ip + 1), *last_frag;
+		u32 id = htonl(++test->fragments);
+
+		if (priv->recv_packets + 1 >= PKTBUFSRX || len <= UDP_HLEN)
+			return -ENOSPC;
+		tail = (void *)priv->recv_packet_buffer[priv->recv_packets + 1];
+		memcpy(tail, eth, ETHER_HDR_SIZE + IP6_HLEN);
+		tail_ip = (void *)(tail + 1);
+		last_frag = (void *)(tail_ip + 1);
+		memcpy(last_frag + 1, (u8 *)icmp + UDP_HLEN, len - UDP_HLEN);
+		*last_frag = (struct ip6_frag_hdr) {
+			._nexth = IP6_NEXTH_UDP,
+			._fragment_offset = htons(UDP_HLEN),
+			._identification = id,
+		};
+		IP6H_NEXTH_SET(tail_ip, IP6_NEXTH_FRAGMENT);
+		IP6H_PLEN_SET(tail_ip, IP6_FRAG_HLEN + len - UDP_HLEN);
+		priv->recv_packet_length[priv->recv_packets + 1] = size;
+		memmove(first_frag + 1, icmp, UDP_HLEN);
+		*first_frag = (struct ip6_frag_hdr) {
+			._nexth = IP6_NEXTH_UDP,
+			._fragment_offset = htons(IP6_FRAG_MORE_FLAG),
+			._identification = id,
+		};
+		IP6H_NEXTH_SET(ip, IP6_NEXTH_FRAGMENT);
+		IP6H_PLEN_SET(ip, IP6_FRAG_HLEN + UDP_HLEN);
+		priv->recv_packet_length[priv->recv_packets] =
+			ETHER_HDR_SIZE + IP6_HLEN + IP6_FRAG_HLEN + UDP_HLEN;
+		priv->recv_packets += 2;
+		return 0;
+	}
 	priv->recv_packet_length[priv->recv_packets++] = size;
 
 	return 0;
@@ -170,6 +220,63 @@ static int ip6_test_ra(struct udevice *dev)
 	return ip6_test_ra_lifetimes(dev, 1800, 900);
 }
 
+static int ip6_test_tftp_reply(struct udevice *dev, struct ip6_hdr *ip, unsigned int len)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct ip6_test *test = priv->priv;
+	struct udp_hdr *udp = (void *)(ip + 1);
+	struct {
+		struct udp_hdr udp;
+		u8 data[4 + sizeof("ipv6-tftp") - 1];
+	} __packed reply = {};
+	ip6_addr_t src, dst;
+	u8 *data = (void *)(udp + 1);
+	unsigned int size = UDP_HLEN + 4;
+	u16 op;
+
+	if (len < IP6_HLEN + UDP_HLEN + 4 || IP6H_PLEN(ip) < UDP_HLEN + 4)
+		return -EINVAL;
+	if (ip6_test_checksum(ip, udp, IP6H_PLEN(ip)))
+		test->bad_checksums++;
+	op = get_unaligned_be16(data);
+	if (op == 1 || op == 2) {
+		test->requests++;
+		if (strcmp((char *)data + 2, test->tftp_file ?: "ipv6.bin"))
+			return -EINVAL;
+		put_unaligned_be16(op == 1 ? 3 : 4, reply.data);
+		put_unaligned_be16(op == 1 ? 1 : 0, reply.data + 2);
+		if (op == 1) {
+			memcpy(reply.data + 4, "ipv6-tftp", 9);
+			size += 9;
+		}
+	} else if (op == 3) {
+		if (IP6H_PLEN(ip) != UDP_HLEN + 4 + 9 ||
+		    memcmp(data + 4, "ipv6-tftp", 9))
+			return -EINVAL;
+		test->uploads++;
+		put_unaligned_be16(4, reply.data);
+		put_unaligned_be16(1, reply.data + 2);
+	} else if (op == 4 && test->listener) {
+		if (get_unaligned_be16(data + 2) == 1) {
+			test->listener_done = true;
+			return 0;
+		}
+		put_unaligned_be16(3, reply.data);
+		put_unaligned_be16(1, reply.data + 2);
+		memcpy(reply.data + 4, "ipv6-tftp", 9);
+		size += 9;
+	} else {
+		return 0;
+	}
+	reply.udp.src = htons(1234);
+	reply.udp.dest = udp->src;
+	reply.udp.len = htons(size);
+	ip6_addr_copy_from_packed(src, ip->dest);
+	ip6_addr_copy_from_packed(dst, ip->src);
+
+	return ip6_test_reply(dev, &src, &dst, &reply, size, IP6_NEXTH_UDP, false);
+}
+
 static int ip6_test_udp(struct udevice *dev, struct ip6_hdr *ip, u16 port,
 			const void *data, unsigned int len)
 {
@@ -273,6 +380,111 @@ static int ip6_test_ipv4(struct udevice *dev, void *packet, unsigned int len)
 	return 0;
 }
 
+static int ip6_test_http_reply(struct udevice *dev, struct ip6_hdr *ip)
+{
+	struct ip6_test *test = ((struct eth_sandbox_priv *)dev_get_priv(dev))->priv;
+	static const char response[] = "HTTP/1.1 200 OK\r\nContent-Length: 9\r\n"
+				       "Connection: close\r\n\r\nipv6-http";
+	u8 *tcp = (void *)(ip + 1), packet[20 + sizeof(response)] = {};
+	ip6_addr_t src, dst;
+	unsigned int header = (tcp[12] >> 4) * 4, len = IP6H_PLEN(ip), size = 20;
+	u32 seq = get_unaligned_be32(tcp + 4);
+
+	if (len < 20 || header < 20 || header > len)
+		return -EINVAL;
+	if (ip6_test_checksum(ip, tcp, len))
+		test->bad_checksums++;
+	memcpy(packet, tcp + 2, 2);
+	memcpy(packet + 2, tcp, 2);
+	packet[12] = 5 << 4;
+	put_unaligned_be16(32768, packet + 14);
+	if (tcp[13] & 2) {
+		put_unaligned_be32(1000, packet + 4);
+		put_unaligned_be32(seq + 1, packet + 8);
+		packet[13] = 0x12;
+	} else if (len > header) {
+		if (!test->http_host ||
+		    !strnstr((char *)tcp + header, test->http_host, len - header) ||
+		    (test->http_target &&
+		     !strnstr((char *)tcp + header, test->http_target, len - header)))
+			return -EINVAL;
+		test->http_requests++;
+		put_unaligned_be32(1001, packet + 4);
+		put_unaligned_be32(seq + len - header, packet + 8);
+		packet[13] = 0x19;
+		memcpy(packet + 20, response, sizeof(response) - 1);
+		size += sizeof(response) - 1;
+	} else {
+		return 0;
+	}
+	ip6_addr_copy_from_packed(src, ip->dest);
+	ip6_addr_copy_from_packed(dst, ip->src);
+	return ip6_test_reply(dev, &src, &dst, packet, size, IP6_NEXTH_TCP, false);
+}
+
+static int ip6_test_rpc_reply(struct udevice *dev, struct ip6_hdr *ip)
+{
+	struct ip6_test *test = ((struct eth_sandbox_priv *)dev_get_priv(dev))->priv;
+	struct udp_hdr *udp = (void *)(ip + 1);
+	u32 reply[288] = {};
+	u8 *query = (void *)(udp + 1);
+	const char *uaddr;
+	int ret;
+
+	memcpy(reply, query, 4);
+	reply[1] = htonl(1);
+	switch (++test->rpc_requests) {
+	case 1:
+	case 2:
+		if (get_unaligned_be32(query + 12) != 100000 ||
+		    get_unaligned_be32(query + 16) != 3 ||
+		    get_unaligned_be32(query + 20) != 3 ||
+		    get_unaligned_be32(query + 48) != 4 || memcmp(query + 52, "udp6", 4))
+			return -EINVAL;
+		/* A truncated universal address must not advance service discovery. */
+		reply[6] = htonl(100);
+		ret = ip6_test_udp(dev, ip, ntohs(udp->dest), reply, 28);
+		if (ret)
+			return ret;
+		uaddr = test->rpc_requests == 1 ? "fe80::2.15.160" : "fe80::2.15.161";
+		reply[6] = htonl(strlen(uaddr));
+		memcpy(reply + 7, uaddr, strlen(uaddr));
+		break;
+	case 3:
+	case 4:
+		reply[7] = htonl(32);
+		break;
+	case 5:
+		reply[8] = htonl(9);
+		reply[9] = htonl(1);
+		reply[10] = htonl(9);
+		memcpy(reply + 11, "ipv6-nfs!", 9);
+		break;
+	case 6:
+	case 7:
+		break;
+	default:
+		return -EINVAL;
+	}
+	return ip6_test_udp(dev, ip, ntohs(udp->dest), reply, sizeof(reply));
+}
+
+static int ip6_test_sntp_reply(struct udevice *dev, struct ip6_hdr *ip)
+{
+	struct ip6_test *test = ((struct eth_sandbox_priv *)dev_get_priv(dev))->priv;
+	u8 reply[48] = {}, *query = (void *)((struct udp_hdr *)(ip + 1) + 1);
+
+	if (IP6H_PLEN(ip) != UDP_HLEN + sizeof(reply))
+		return -EINVAL;
+	reply[0] = 0x24;
+	reply[1] = 1;
+	memcpy(reply + 24, query + 40, 8);
+	put_unaligned_be32(0xe0000000, reply + 32);
+	put_unaligned_be32(0xe0000000, reply + 40);
+	test->sntp_requests++;
+	return ip6_test_udp(dev, ip, 123, reply, sizeof(reply));
+}
+
 static int ip6_test_tx(struct udevice *dev, void *packet, unsigned int len)
 {
 	struct eth_sandbox_priv *priv = dev_get_priv(dev);
@@ -296,10 +508,33 @@ static int ip6_test_tx(struct udevice *dev, void *packet, unsigned int len)
 
 		if (IP6H_PLEN(ip) < UDP_HLEN || len < ETHER_HDR_SIZE + IP6_HLEN + IP6H_PLEN(ip))
 			return -EINVAL;
+		if (test->unreachable) {
+			u8 packet[sizeof(struct icmp6_hdr) + IP6_HLEN + UDP_HLEN] = {
+				ICMP6_TYPE_DUR, ICMP6_DUR_PORT,
+			};
+
+			memcpy(packet + sizeof(struct icmp6_hdr), ip, IP6_HLEN + UDP_HLEN);
+			ip6_addr_copy_from_packed(src, ip->dest);
+			ip6_addr_copy_from_packed(dst, ip->src);
+			return ip6_test_reply(dev, &src, &dst, packet, sizeof(packet),
+					     IP6_NEXTH_ICMP6, false);
+		}
 		if (ntohs(udp->dest) == 53)
 			return ip6_test_dns_reply(dev, ip);
-		return 0;
+		if (ntohs(udp->dest) == 111 || ntohs(udp->dest) == 4000 || ntohs(udp->dest) == 4001)
+			return ip6_test_rpc_reply(dev, ip);
+		if (ntohs(udp->dest) == 123)
+			return ip6_test_sntp_reply(dev, ip);
+		if (ntohs(udp->dest) == 6666) {
+			test->console_packets++;
+			if (test->console_no_reply)
+				return 0;
+			return ip6_test_udp(dev, ip, 6666, "x", 1);
+		}
+		return ip6_test_tftp_reply(dev, ip, len - ETHER_HDR_SIZE);
 	}
+	if (IP6H_NEXTH(ip) == IP6_NEXTH_TCP)
+		return ip6_test_http_reply(dev, ip);
 	if (IP6H_NEXTH(ip) != IP6_NEXTH_ICMP6)
 		return 0;
 	plen = IP6H_PLEN(ip);
@@ -578,6 +813,83 @@ static int ip6_test_lifetimes(struct unit_test_state *uts, struct ip6_test *test
 }
 #endif
 
+#if CONFIG_IS_ENABLED(CMD_TFTPBOOT)
+static int ip6_test_tftp(struct unit_test_state *uts, struct ip6_test *test)
+{
+	void *data = map_sysmem(0x2100000, 9);
+	ulong start;
+
+	ut_assertok(env_set("ipaddr", NULL));
+	ut_assertok(run_command("tftpboot 2100000 [fe80::2]:ipv6.bin", 0));
+	ut_asserteq(9, net_boot_file_size);
+	ut_asserteq_mem("ipv6-tftp", data, 9);
+	ut_assertok(env_set("serverip6", "fe80::2"));
+	test->fragment = true;
+	ut_assertok(run_command("tftpboot 2100000 ipv6.bin -ipv6", 0));
+	ut_asserteq(9, net_boot_file_size);
+	ut_asserteq_mem("ipv6-tftp", data, 9);
+	ut_asserteq(2, test->requests);
+	ut_assert(test->fragments);
+#if CONFIG_IS_ENABLED(CMD_TFTPPUT)
+	ut_assertok(run_command("tftpput 2100000 9 [fe80::2]:ipv6.bin", 0));
+	ut_asserteq(1, test->uploads);
+#endif
+	test->fragment = false;
+	test->unreachable = true;
+	start = get_timer(0);
+	ut_asserteq(CMD_RET_FAILURE,
+		    run_command("tftpboot 2100000 [fe80::2]:ipv6.bin", 0));
+	ut_assert(get_timer(start) < 5000);
+	ut_asserteq(0, test->bad_checksums);
+	ut_assertnull(netif_default);
+	unmap_sysmem(data);
+
+	return 0;
+}
+
+static int ip6_test_tftp_numbers(struct unit_test_state *uts, struct ip6_test *test)
+{
+	static const char *const ports[] = {
+		"65536", "4294967365", "18446744073709551685",
+		"99999999999999999999999999999999",
+	};
+	static const char *const names[] = {
+		"tftpdstp", "tftpsrcp", "tftpblocksize", "tftpwindowsize",
+		"tftptimeout", "tftptimeoutcountmax",
+	};
+	static const char *const invalid[] = {
+		"-1", "+69", " 69", "69junk", "18446744073709552640",
+	};
+	char cmd[128];
+
+	ut_assertok(env_set("ipaddr", NULL));
+	ut_assertok(env_set("serverip6", "fe80::2"));
+	for (unsigned int i = 0; i < ARRAY_SIZE(ports); i++) {
+		snprintf(cmd, sizeof(cmd), "tftpboot 2100000 [fe80::2]:%s:ipv6.bin", ports[i]);
+		ut_asserteq(CMD_RET_FAILURE, run_command(cmd, 0));
+		ut_asserteq(0, test->requests);
+	}
+	for (unsigned int i = 0; i < ARRAY_SIZE(names); i++) {
+		if (i >= 2 && !CONFIG_IS_ENABLED(NET_TFTP_VARS))
+			continue;
+		for (unsigned int j = 0; j < ARRAY_SIZE(invalid); j++) {
+			ut_assertok(env_set(names[i], invalid[j]));
+			ut_asserteq(CMD_RET_FAILURE,
+				    run_command("tftpboot 2100000 ipv6.bin -ipv6", 0));
+			ut_asserteq(0, test->requests);
+			ut_assertnull(netif_default);
+		}
+		ut_assertok(env_set(names[i], NULL));
+	}
+	/* Zero retains the default port; leading zeroes do not change the value. */
+	ut_assertok(env_set("tftpsrcp", "0"));
+	ut_assertok(run_command("tftpboot 2100000 [fe80::2]:0:ipv6.bin", 0));
+	ut_assertok(run_command("tftpboot 2100000 [fe80::2]:00065535:ipv6.bin", 0));
+	ut_asserteq(2, test->requests);
+	return 0;
+}
+#endif
+
 static int ip6_test_run(struct unit_test_state *uts,
 			int (*check)(struct unit_test_state *, struct ip6_test *))
 {
@@ -652,6 +964,121 @@ static int dm_test_lwip_ip6_config(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_lwip_ip6_config, UTF_SCAN_FDT);
 
+#if CONFIG_IS_ENABLED(WGET)
+static int ip6_test_http_ports(struct unit_test_state *uts, struct ip6_test *test)
+{
+	static const char *const ports[] = {
+		"", "0", "65536", "+8080", "8080junk", "4294975376",
+		"18446744073709559696", "99999999999999999999999999999999",
+	};
+	struct wget_http_info info = { .method = WGET_HTTP_METHOD_GET };
+	char url[128];
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(ports); i++) {
+		snprintf(url, sizeof(url), "http://[fe80::2]:%s/ipv6.bin", ports[i]);
+		ut_assert(wget_request(0x2100000, url, &info));
+		ut_asserteq(0, test->http_requests);
+		ut_assertnull(netif_default);
+	}
+	test->http_host = "Host: [fe80::2]:8080\r\n";
+	ut_assertok(wget_request(0x2100000, "http://[fe80::2]:0008080/ipv6.bin", &info));
+	ut_asserteq(1, test->http_requests);
+	return 0;
+}
+
+static int dm_test_lwip_ip6_http_ports(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_http_ports);
+}
+DM_TEST(dm_test_lwip_ip6_http_ports, UTF_SCAN_FDT | UTF_CONSOLE);
+
+static int ip6_test_http_scheme(struct unit_test_state *uts, struct ip6_test *test)
+{
+	static const char *const paths[] = {
+		"/http://other.test/image", "/https://other.test/image",
+		"/image?next=http://other.test/image",
+		"/image?next=https://other.test/image",
+	};
+	struct wget_http_info info = { .method = WGET_HTTP_METHOD_GET };
+	char url[128], target[128];
+
+	test->http_host = "Host: [fe80::2]:8080\r\n";
+	for (unsigned int i = 0; i < ARRAY_SIZE(paths); i++) {
+		snprintf(url, sizeof(url), "http://[fe80::2]:8080%s", paths[i]);
+		snprintf(target, sizeof(target), "GET %s HTTP/1.1\r\n", paths[i]);
+		test->http_target = target;
+		ut_assertok(wget_request(0x2100000, url, &info));
+		ut_asserteq(i + 1, test->http_requests);
+		ut_asserteq(9, info.file_size);
+		ut_assertnull(netif_default);
+	}
+	return 0;
+}
+
+static int dm_test_lwip_ip6_http_scheme(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_http_scheme);
+}
+DM_TEST(dm_test_lwip_ip6_http_scheme, UTF_SCAN_FDT | UTF_CONSOLE);
+
+#if CONFIG_IS_ENABLED(WGET_CACERT) || CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
+static int ip6_test_https_run(struct unit_test_state *uts,
+			      int (*check)(struct unit_test_state *, struct ip6_test *))
+{
+	enum auth_mode saved_auth = cacert_auth_mode;
+	size_t saved_size = cacert_size;
+#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
+	bool saved_initialized = cacert_initialized;
+#endif
+	int ret;
+
+	/* HTTPS must fail authentication rather than download over plain HTTP. */
+	cacert_auth_mode = AUTH_REQUIRED;
+	cacert_size = 0;
+#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
+	cacert_initialized = true;
+#endif
+	ret = ip6_test_run(uts, check);
+	cacert_auth_mode = saved_auth;
+	cacert_size = saved_size;
+#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
+	cacert_initialized = saved_initialized;
+#endif
+	return ret;
+}
+
+static int ip6_test_https_scheme(struct unit_test_state *uts, struct ip6_test *test)
+{
+	char urls[][128] = {
+		"https://[fe80::3]:8443/ipv6.bin",
+		"https://[fe80::3]:8443/http://[fe80::2]:8080/ipv6.bin",
+		"https://[fe80::3]:8443/image?next=http://[fe80::2]:8080/ipv6.bin",
+	};
+
+	ut_assertok(env_set("ipaddr", NULL));
+	test->http_host = "Host: [fe80::2]:8080\r\n";
+	for (unsigned int i = 0; i < ARRAY_SIZE(urls); i++) {
+		struct wget_http_info info = { .method = WGET_HTTP_METHOD_GET };
+		int ret;
+
+		ut_assert(wget_validate_uri(urls[i]));
+		ret = wget_request(0x2100000, urls[i], &info);
+		ut_asserteq(0, test->http_requests);
+		ut_asserteq(-EINVAL, ret);
+		ut_asserteq(0, info.file_size);
+		ut_assertnull(netif_default);
+	}
+	return 0;
+}
+
+static int dm_test_lwip_ip6_https_scheme(struct unit_test_state *uts)
+{
+	return ip6_test_https_run(uts, ip6_test_https_scheme);
+}
+DM_TEST(dm_test_lwip_ip6_https_scheme, UTF_SCAN_FDT | UTF_CONSOLE);
+#endif
+#endif
+
 static int ip6_test_prefix(struct unit_test_state *uts, struct ip6_test *test)
 {
 	ip6_addr_t addr, dest, gateway;
@@ -737,6 +1164,283 @@ static int dm_test_lwip_ip6_dns(struct unit_test_state *uts)
 DM_TEST(dm_test_lwip_ip6_dns, UTF_SCAN_FDT);
 #endif
 
+static int ip6_test_apps(struct unit_test_state *uts, struct ip6_test *test)
+{
+	void *data = map_sysmem(0x2100000, 9);
+
+	ut_assertok(env_set("ipaddr", NULL));
+#if CONFIG_IS_ENABLED(WGET)
+	{
+		struct wget_http_info info = { .method = WGET_HTTP_METHOD_GET };
+
+		test->http_host = "Host: [fe80::2]:8080\r\n";
+		ut_assertok(wget_request(0x2100000, "http://[fe80::2]:8080/ipv6.bin", &info));
+		ut_asserteq_mem("ipv6-http", data, 9);
+		ut_asserteq(9, info.file_size);
+		ut_asserteq(1, test->http_requests);
+#if CONFIG_IS_ENABLED(DNS)
+		ut_assertok(env_set("dnsip6", "fe80::2"));
+		test->http_host = "Host: http.test:8080\r\n";
+		ut_assertok(wget_request(0x2100000, "http://http.test:8080/ipv6.bin", &info));
+		ut_asserteq_mem("ipv6-http", data, 9);
+#endif
+	}
+#endif
+#if CONFIG_IS_ENABLED(CMD_SNTP)
+	ut_assertok(run_command("sntp fe80::2", 0));
+	ut_asserteq(1, test->sntp_requests);
+#endif
+#if CONFIG_IS_ENABLED(CMD_NFS)
+	ut_assertok(run_command("nfs 2100000 [fe80::2]:/ipv6.bin", 0));
+	ut_asserteq_mem("ipv6-nfs!", data, 9);
+	ut_asserteq(7, test->rpc_requests);
+#endif
+#if CONFIG_IS_ENABLED(NETCONSOLE)
+	{
+		struct stdio_dev *nc = stdio_get_by_name("nc");
+		int ret;
+
+		ut_assertnonnull(nc);
+		ut_assertok(env_set("ncip", NULL));
+		ut_assertok(env_set("ncip6", "fe80::2"));
+		ut_assertok(env_set("ncinport", NULL));
+		ut_assertok(env_set("ncoutport", NULL));
+		ut_assertok(nc->start(nc));
+		nc->puts(nc, "ipv6-console");
+		ret = nc->tstc(nc);
+		if (ret)
+			ret = nc->getc(nc);
+		nc->stop(nc);
+		ut_asserteq('x', ret);
+		ut_asserteq(1, test->console_packets);
+	}
+#endif
+	ut_asserteq(0, test->bad_checksums);
+	ut_assertnull(netif_default);
+	unmap_sysmem(data);
+	return 0;
+}
+
+static int dm_test_lwip_ip6_apps(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_apps);
+}
+DM_TEST(dm_test_lwip_ip6_apps, UTF_SCAN_FDT);
+
+#if CONFIG_IS_ENABLED(NETCONSOLE)
+static int ip6_test_netconsole_refresh(struct unit_test_state *uts, struct ip6_test *test)
+{
+	static const struct {
+		const char *name;
+		const char *value;
+		const char *peer;
+		int expected;
+	} cases[] = {
+		{ NULL, NULL, "fe80::2", 'x' },
+		{ "filesize", "1234", "fe80::2", 'x' },
+		{ "dnsip6", "fe80::3", "fe80::2", 'x' },
+		{ "ncip6", "fe80::3", "fe80::2", 0 },
+		{ NULL, NULL, "fe80::3", 'x' },
+	};
+	struct {
+		struct udp_hdr udp;
+		u8 data;
+	} __packed packet = {
+		.udp.src = htons(6666),
+		.udp.dest = htons(6666),
+		.udp.len = htons(sizeof(packet)),
+		.data = 'x',
+	};
+	struct stdio_dev *nc = stdio_get_by_name("nc");
+	int received[ARRAY_SIZE(cases)] = {};
+	ip6_addr_t src;
+	int ret = 0;
+
+	ut_assertnonnull(nc);
+	ut_assertok(env_set("ipaddr", NULL));
+	ut_assertok(env_set("ncip", NULL));
+	ut_assertok(env_set("ncip6", "fe80::2"));
+	ut_assertok(env_set("ncinport", NULL));
+	ut_assertok(env_set("ncoutport", NULL));
+	ut_assertok(nc->start(nc));
+	/* Input must retain the peer's scope without any console output. */
+	for (unsigned int i = 0; i < ARRAY_SIZE(cases); i++) {
+		if (cases[i].name) {
+			ret = env_set(cases[i].name, cases[i].value);
+			if (ret)
+				break;
+		}
+		ip6addr_aton(cases[i].peer, &src);
+		ret = ip6_test_reply(eth_get_dev(), &src, netif_ip6_addr(netif_default, 0),
+				     &packet, sizeof(packet), IP6_NEXTH_UDP, false);
+		if (ret)
+			break;
+		if (nc->tstc(nc))
+			received[i] = nc->getc(nc);
+	}
+	nc->stop(nc);
+
+	ut_assertok(ret);
+	for (unsigned int i = 0; i < ARRAY_SIZE(cases); i++)
+		ut_asserteq(cases[i].expected, received[i]);
+	ut_asserteq(0, test->console_packets);
+	ut_asserteq(0, test->bad_checksums);
+	ut_assertnull(netif_default);
+	return 0;
+}
+
+static int dm_test_lwip_ip6_netconsole_refresh(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_netconsole_refresh);
+}
+DM_TEST(dm_test_lwip_ip6_netconsole_refresh, UTF_SCAN_FDT);
+#endif
+
+#if CONFIG_IS_ENABLED(NETCONSOLE) && CONFIG_IS_ENABLED(IPV6_ROUTER_DISCOVERY)
+static void ip6_test_console_output(void *arg)
+{
+	struct stdio_dev *nc = arg;
+
+	nc->puts(nc, "output from poller");
+}
+
+static int ip6_test_netconsole_lifetimes(struct unit_test_state *uts, struct ip6_test *test)
+{
+	static const struct {
+		const char *address;
+		const char *gateway;
+		const char *peer;
+		bool infinite;
+		bool survives;
+	} cases[] = {
+		{ NULL, NULL, "2001:db8:2::2", false, false },
+		{ "2001:db8:1::10", NULL, "2001:db8:2::2", false, false },
+		{ "2001:db8:1::10", "fe80::1", "2001:db8:2::2", false, true },
+		{ NULL, NULL, "2001:db8:1::2", true, true },
+	};
+	struct stdio_dev *nc = stdio_get_by_name("nc");
+
+	ut_assertnonnull(nc);
+	ut_assertok(env_set("ipaddr", NULL));
+	ut_assertok(env_set("ncip", NULL));
+	ut_assertok(env_set("ncinport", NULL));
+	ut_assertok(env_set("ncoutport", NULL));
+	test->console_no_reply = true;
+	for (unsigned int i = 0; i < ARRAY_SIZE(cases); i++) {
+		unsigned int before, after, recovered, polled;
+		ulong start, elapsed;
+		bool valid;
+		int ret = 0;
+
+		ut_assertok(env_set("ip6addr", cases[i].address));
+		ut_assertok(env_set("gatewayip6", cases[i].gateway));
+		ut_assertok(env_set("ncip6", cases[i].peer));
+		test->advertise = !cases[i].gateway;
+		test->console_packets = 0;
+		ut_assertok(nc->start(nc));
+		test->advertise = false;
+		if (cases[i].infinite)
+			ret = ip6_test_ra_lifetimes(eth_get_dev(), U32_MAX, U32_MAX);
+		/* Resolve the neighbor, then leave the output-only console idle. */
+		nc->puts(nc, "before expiry");
+		before = test->console_packets;
+		timer_test_add_offset(1801000);
+		start = get_timer(0);
+		nc->puts(nc, "after expiry");
+		nc->puts(nc, "still after expiry");
+		elapsed = get_timer(start);
+		after = test->console_packets;
+		valid = ip6_addr_isvalid(netif_ip6_addr_state(netif_default, 1));
+
+		/* Output must also process advertisements that restore readiness. */
+		if (!cases[i].survives && !ret) {
+			ret = ip6_test_ra(eth_get_dev());
+			for (unsigned int j = 0; j < 5 && !ret; j++) {
+				timer_test_add_offset(1000);
+				nc->puts(nc, "restored route and address");
+			}
+		}
+		recovered = test->console_packets;
+		/* Console output from a poll callback must tolerate -EBUSY. */
+		sys_timeout(1, ip6_test_console_output, nc);
+		timer_test_add_offset(10);
+		if (!ret)
+			ret = net_lwip_poll();
+		sys_untimeout(ip6_test_console_output, nc);
+		polled = test->console_packets;
+		nc->stop(nc);
+
+		ut_assertok(ret);
+		ut_asserteq(1, before);
+		ut_asserteq(before + 2 * cases[i].survives, after);
+		ut_assert(elapsed < 1000);
+		ut_asserteq(!!cases[i].address || cases[i].infinite, valid);
+		ut_assert(recovered > before);
+		ut_asserteq(recovered + 1, polled);
+		ut_assertnull(netif_default);
+	}
+	return 0;
+}
+
+static int dm_test_lwip_ip6_netconsole_lifetimes(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_netconsole_lifetimes);
+}
+DM_TEST(dm_test_lwip_ip6_netconsole_lifetimes, UTF_SCAN_FDT);
+#endif
+
+#if CONFIG_IS_ENABLED(CMD_TFTPSRV)
+static void ip6_test_wrq(void *arg)
+{
+	struct ip6_test *test = arg;
+	struct {
+		struct udp_hdr udp;
+		u8 data[18];
+	} __packed packet = {};
+	ip6_addr_t src;
+
+	if (test->listener_done)
+		return;
+	sys_timeout(1000, ip6_test_wrq, test);
+	if (!netif_default || !ip6_addr_isvalid(netif_ip6_addr_state(netif_default, 0)))
+		return;
+	packet.udp.src = htons(1234);
+	packet.udp.dest = htons(69);
+	packet.udp.len = htons(sizeof(packet));
+	put_unaligned_be16(2, packet.data);
+	memcpy(packet.data + 2, "ipv6.bin\0octet\0", 15);
+	ip6addr_aton("fe80::2", &src);
+	ip6_test_reply(netif_default->state, &src, netif_ip6_addr(netif_default, 0),
+		       &packet, sizeof(packet), IP6_NEXTH_UDP, false);
+}
+
+static int ip6_test_server(struct unit_test_state *uts, struct ip6_test *test)
+{
+	void *data = map_sysmem(0x2100000, 9);
+	int ret;
+
+	ut_assertok(env_set("ipaddr", NULL));
+	ut_assertok(env_set("autostart", "no"));
+	test->listener = true;
+	sys_timeout(1, ip6_test_wrq, test);
+	ret = run_command("tftpsrv 2100000 -ipv6", 0);
+	sys_untimeout(ip6_test_wrq, test);
+	ut_assertok(ret);
+	ut_assert(test->listener_done);
+	ut_asserteq(9, net_boot_file_size);
+	ut_asserteq_mem("ipv6-tftp", data, 9);
+	ut_assertnull(netif_default);
+	unmap_sysmem(data);
+	return 0;
+}
+
+static int dm_test_lwip_ip6_server(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_server);
+}
+DM_TEST(dm_test_lwip_ip6_server, UTF_SCAN_FDT);
+#endif
+
 #if CONFIG_IS_ENABLED(IPV6_ROUTER_DISCOVERY) && CONFIG_IS_ENABLED(DNS)
 static int ip6_test_rdnss(struct unit_test_state *uts, struct ip6_test *test)
 {
@@ -1101,6 +1805,20 @@ static int dm_test_lwip_ip6_dad_scope(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_lwip_ip6_dad_scope, UTF_SCAN_FDT);
 
+#if CONFIG_IS_ENABLED(CMD_TFTPBOOT)
+static int dm_test_lwip_ip6_tftp(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_tftp);
+}
+DM_TEST(dm_test_lwip_ip6_tftp, UTF_SCAN_FDT);
+
+static int dm_test_lwip_ip6_tftp_numbers(struct unit_test_state *uts)
+{
+	return ip6_test_run(uts, ip6_test_tftp_numbers);
+}
+DM_TEST(dm_test_lwip_ip6_tftp_numbers, UTF_SCAN_FDT | UTF_CONSOLE);
+#endif
+
 #if CONFIG_IS_ENABLED(IPV6_ROUTER_DISCOVERY)
 static int dm_test_lwip_ip6_slaac(struct unit_test_state *uts)
 {

-- 
2.53.0

