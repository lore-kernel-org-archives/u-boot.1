Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C73C5DF89
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:14:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C74A840D1A;
	Fri, 21 Aug 2026 13:14:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1AcAmkw7Kj_i; Fri, 21 Aug 2026 13:14:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318070;
	bh=uX3hYsmv9qDZKLgbWuC1sGIRyLyTp5NH1TTHhCyiDK8=;
	h=From:Date:Subject:In-Reply-To:References:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=M/QXZxAwBkrRoBjvQFdfkWwjeAaM6qADjqfMoPi450ohM8FtcFXbqG2u66RI4wauT
	 W8pTh0u7gjl0BFR7qOUlCbG3gUpU1YIcaUXOQLoqaDjodDHUmEf6ZaPZrL+0vanwQO
	 qHVHgwNxxIVwIJv6uS8GHTGnWZB9eUcdqzZpHlXR8Ob6+RXGyP+XrAiardlqKUux3q
	 kiX520cDLySYOKf2OBJ3ib4smkd8NuK11KsJ8UsE6LFOb60XgXgWHBX81yXPgFxfS9
	 QpPGoOfr5oN5E+BSw/u179w7/KlKjGsg7O6myH7Wk/5b8DTuu5Z40OmUdmq8PLEN80
	 UHPpJhvZDBCww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B59540D11;
	Fri, 21 Aug 2026 13:14:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3602239E
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 07:07:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 18B2C80EEB
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 07:07:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dQ2RVURVzCfG for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 07:07:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+estebancalba.gmail.com@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=WEIMtNbC
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E240780EE9
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 07:07:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 33E2942E14;
 Fri, 21 Aug 2026 07:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 162A0C19425;
 Fri, 21 Aug 2026 07:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1787296064;
 bh=d81w9N3vV4jdlB8bS4nrtRZEufRk8oBi9aYkm1vTqG8=;
 h=From:Date:Subject:In-Reply-To:References:To:Cc:Reply-To:From;
 b=WEIMtNbCf5j7S+HS2HVADNVDAJWga+MCArWPEApNejHMCWqD603Iw8MsRPcARJFHK
 8FZgWnScepulm48bE/7cSLoiolA0z8jN2mn0WyrAq9kV2TS819787ARj4KP0Kp2PI0
 vjvbVdkvC1qj+Ix7l3J253Izem3vwV6Xd7vOIlIISb6BeKi3sNA3fFUuS+G55AEllV
 UaYdGcL/dW8pKtSp80cM3jmVP07CC3Dr6hZ5Dy08CabDTCBHkw/BGSnzQWs8k6gGeO
 sqlrrSbXQAWcK3R2obrYGLHWajX6NdFSW5+2S4oIqmoN652LukaPjfj2PUvVBusCXh
 47fjZxFr0HGWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E655CC5DF7D;
 Fri, 21 Aug 2026 07:07:43 +0000 (UTC)
From: Esteban Alba via B4 Relay <devnull+estebancalba.gmail.com@kernel.org>
Date: Fri, 21 Aug 2026 02:07:43 -0500
Subject: [PATCH v2] net: net6: validate IPv6 payload and transport lengths
 on receive
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-net6-len-validation-v2-1-29bd39f946e0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAD75h2oC/32NQQ6CMBBFr0Jm7RjaBVVX3sOwKO0UxkAxbWk0h
 LtbcO/yJe+/v0KkwBThVq0QKHPk2ReQpwrMoH1PyLYwyFo29aVW6Ck1OJLHrEe2OhUfjVWCnL0
 2Wjkoy1cgx++j+mh/HJfuSSbtqd0YOKY5fI7bLHbv/0MWKJCsc1IJ0zlp7v2keTybeYJ227YvT
 hucFMgAAAA=
X-Change-ID: 20260807-net6-len-validation-cd71efd96a7f
In-Reply-To: <20260807-net6-len-validation-v1-1-edff271cbf2c@gmail.com>
References: <20260807-net6-len-validation-v1-1-edff271cbf2c@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, rfried.dev@gmail.com, v.v.mitrofanov@yadro.com, 
 jerome.forissier@arm.com, sjg@chromium.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787296063; l=3321;
 i=estebancalba@gmail.com; s=20260808; h=from:subject:message-id;
 bh=B1o1ST4jOJ2e8Snq5dgcEV+I6sEAaDIE46Qusbt0PFs=;
 b=6sYAvn5Kxrtlk6o/HubL+tUHtLDjcHnP24BTi8BOwCc+cRccUZxFBf0oh4uDTwDY4QR1XAoh2
 Of9Shub8xIQCWmRmXSFuririKiM063yLb3Fq4rVNjcP4+Qap5r+q4EX
X-Developer-Key: i=estebancalba@gmail.com; a=ed25519;
 pk=1BEuFs3cavGme7UfOyPkuXqt9/3FstTgVwsFSCXGO5o=
X-Endpoint-Received: by B4 Relay for estebancalba@gmail.com/20260808 with
 auth_id=927
X-Original-From: Esteban Alba <estebancalba@gmail.com>
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:12:32 +0000
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
Reply-To: estebancalba@gmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Esteban Alba <estebancalba@gmail.com>

net_ip6_handler() checks the received length only against IP6_HDR_SIZE and
then uses length fields from the packet without checking them. The checksum
is computed over payload_len, but the UDP handler length comes from
udp_len. A sender can keep payload_len correct so the checksum still
validates and set udp_len larger than the frame. A handler that trusts that
length then reads or writes past the receive buffer. The DHCPv6 client
copies the declared number of bytes and can be made to write past the
packet buffer from a single link-local ADVERTISE.

Validate payload_len against the received length and trim len to it before
protocol dispatch. Validate the ICMPv6 and UDP header sizes before either
header is dereferenced, and validate udp_len before reading udp_xsum or
calling the UDP handler.

Fixes: 1feb697830ce ("net: ipv6: Add implementation of main IPv6 functions")
Suggested-by: Jerome Forissier <jerome.forissier@arm.com>
Signed-off-by: Esteban Alba <estebancalba@gmail.com>
---
Validate the IPv6 payload length against the received frame before protocol
dispatch, then validate the ICMPv6 and UDP transport header sizes and
udp_len before either header is dereferenced or the UDP handler is called.
---
Changes in v2:
- Move payload_len reconciliation before protocol dispatch.
- Validate ICMPv6 and UDP header sizes before dereferencing their headers.
- Validate udp_len before reading udp_xsum or dispatching to the UDP handler.
- Link to v1: https://patch.msgid.link/20260807-net6-len-validation-v1-1-edff271cbf2c@gmail.com

To: u-boot@lists.u-boot-project.org
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>
Cc: Simon Glass <sjg@chromium.org>
---
 net/net6.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/net6.c b/net/net6.c
index 4cff98df15..e1a455748e 100644
--- a/net/net6.c
+++ b/net/net6.c
@@ -392,11 +392,19 @@ int net_ip6_handler(struct ethernet_hdr *et, struct ip6_hdr *ip6, int len)
 	if (ip6->version != 6)
 		return -EINVAL;
 
+	hlen = ntohs(ip6->payload_len);
+
+	if (len < IP6_HDR_SIZE + hlen)
+		return -EINVAL;
+	len = IP6_HDR_SIZE + hlen;
+
 	switch (ip6->nexthdr) {
 	case PROT_ICMPV6:
+		if (hlen < sizeof(struct icmp6hdr))
+			return -EINVAL;
+
 		icmp = (struct icmp6hdr *)(((uchar *)ip6) + IP6_HDR_SIZE);
 		csum = icmp->icmp6_cksum;
-		hlen = ntohs(ip6->payload_len);
 		icmp->icmp6_cksum = 0;
 		/* checksum */
 		csum_p = csum_partial((u8 *)icmp, hlen, 0);
@@ -421,9 +429,15 @@ int net_ip6_handler(struct ethernet_hdr *et, struct ip6_hdr *ip6, int len)
 		}
 		break;
 	case IPPROTO_UDP:
+		if (hlen < UDP_HDR_SIZE)
+			return -EINVAL;
+
 		udp = (struct udp_hdr *)(((uchar *)ip6) + IP6_HDR_SIZE);
+		if (ntohs(udp->udp_len) < UDP_HDR_SIZE ||
+		    ntohs(udp->udp_len) > hlen)
+			return -EINVAL;
+
 		csum = udp->udp_xsum;
-		hlen = ntohs(ip6->payload_len);
 		udp->udp_xsum = 0;
 		/* checksum */
 		csum_p = csum_partial((u8 *)udp, hlen, 0);

---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20260807-net6-len-validation-cd71efd96a7f

Best regards,
--  
Esteban Alba <estebancalba@gmail.com>


