Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37134C5AC82
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 02:22:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E681940816;
	Sat,  8 Aug 2026 02:22:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mouzVku0D0GN; Sat,  8 Aug 2026 02:22:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 164EE4081B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786155775;
	bh=7QzW+JrdLD2VYSSYlCm7ko3dRJBfWt7CLUDnGL8QIhs=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=sg1dxQ5PvoTnBC6ujusTTpO4Nt/YJ1OqHNonNEfz40lVxMR8KmE9f7+44wrpP3n/j
	 s0vhYPJHGOkjhuTd+73qQFEyt4JZhgCsshUfuoy7k/Yvy+FLbtBi2hU7Z4fYTu62k6
	 P5EdZYccqIQXJG+ojv5Dp8K7YTp8NBWkiaWb3EEyQ3N6o0CFZHMKeDA73heALbxyhJ
	 aRQG/lwOnafmY+IIwawVe95DhdDJtt3dhvIqZX5DRJv6JSbYgq/9bvLkR6dcwJ9E5G
	 GxPhyTBOmHAUuldOv+6hhWDhkA83WHZx4kAPckU/b8De9ALOaZ4avrVFd1K9BYza6B
	 1W0D8zU8iWn8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 164EE4081B;
	Sat,  8 Aug 2026 02:22:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A6A771AF
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 02:09:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 925BE407D0
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 02:09:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nLsJMKASslSJ for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 02:09:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+estebancalba.gmail.com@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 61338407CF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 61338407CF
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 61338407CF
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 02:09:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A562F6001A;
 Sat,  8 Aug 2026 02:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CC4CC19425;
 Sat,  8 Aug 2026 02:09:53 +0000 (UTC)
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 381DEC5AC82;
 Sat,  8 Aug 2026 02:09:53 +0000 (UTC)
From: Esteban Alba via B4 Relay <devnull+estebancalba.gmail.com@kernel.org>
Date: Fri, 07 Aug 2026 21:09:53 -0500
Subject: [PATCH] net: net6: validate IPv6 payload and UDP length on receive
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-net6-len-validation-v1-1-edff271cbf2c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPCPdmoC/yXMwQrDIBCE4VcJe86CyUHbvkrIwejYbgmmqJFCy
 LvXtscPZv6DMpIg0607KKFKli02DH1H7mHjHSy+mUY1anVRhiOK5hWRq13F29L27LwZEPxVWxO
 oPV8JQd6/6jT/nfflCVe+KTrPD4FKLfl3AAAA
X-Change-ID: 20260807-net6-len-validation-cd71efd96a7f
To: u-boot@lists.u-boot-project.org
Cc: Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786154992; l=2310;
 i=estebancalba@gmail.com; s=20260808; h=from:subject:message-id;
 bh=Noglsh+V1jbRhzRXFIKeYwjx9lELZ2FDIrdfAldKLjk=;
 b=mltVNCMlvJDST5IxyVGnqclfs/TqZZ03IQYrKdHH21v4nAjlYGxRjJP6exVh9mn8oz64j9gUM
 NDGwAIBToy8BxvruaKTQC++I9GBphp8OyTA+UvBFdcc6jJcacDnKVC9
X-Developer-Key: i=estebancalba@gmail.com; a=ed25519;
 pk=1BEuFs3cavGme7UfOyPkuXqt9/3FstTgVwsFSCXGO5o=
X-Endpoint-Received: by B4 Relay for estebancalba@gmail.com/20260808 with
 auth_id=927
X-Original-From: Esteban Alba <estebancalba@gmail.com>
X-Mailman-Approved-At: Sat, 08 Aug 2026 02:22:49 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1786154993;
 bh=r3vipK22HBJ9TKPaxEyl8uWUOEZjjqKabJclpOuww3g=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=teYGN9M5YsJqNxJHOBlCJ89/UAOkcJUsPF0XZYJFvXpLGAe1AYJpuRX12Yk8t21hr
 Xh+uvhhbU9B+uEBUMOm+qYUMswrv0T5SXpAgjnaFQc7pq7iDASx/xds/iJmLQ00Z/i
 oqKjGHohYvltslrBSf9wO2P7Hz7BBeHtF+hamb/w9gs6LDMFQ2y/JUH0927rvWPTkf
 /17D4/Zm/vs1qlvR/VSOr+tsQP5+7YTAk+VX9E32DrzD5ciQoQIl6BD6hdFszGTVTu
 Vo9gK2/TLzqwLRm3Y/ZLXBphqWtp1HFUw3+JRvbUQTPIec0SqshAqQlfZisVwetDBO
 bu6yXkqQagT8Q==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=teYGN9M5
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Esteban Alba <estebancalba@gmail.com>

net_ip6_handler() checks the received length only against IP6_HDR_SIZE
and then uses two length fields from the packet without checking them.
The checksum is computed over payload_len, but the length passed to the
UDP handler comes from udp_len. A sender can keep payload_len correct so
the checksum still validates and set udp_len larger than the frame. A
handler that trusts that length then reads or writes past the receive
buffer. The DHCPv6 client copies the declared number of bytes and can be
made to write past the packet buffer from a single link-local ADVERTISE.

The IPv4 path already reconciles these lengths in
net_process_received_packet(). Do the same here: reject a payload_len
that exceeds the received length and trim len to it, then reject a
udp_len smaller than the UDP header or larger than the payload before
calling the handler.

Fixes: 1feb697830ce ("net: ipv6: Add implementation of main IPv6 functions")
Signed-off-by: Esteban Alba <estebancalba@gmail.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>
---
 net/net6.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/net6.c b/net/net6.c
index 4cff98df15..af2f484fad 100644
--- a/net/net6.c
+++ b/net/net6.c
@@ -392,6 +392,11 @@ int net_ip6_handler(struct ethernet_hdr *et, struct ip6_hdr *ip6, int len)
 	if (ip6->version != 6)
 		return -EINVAL;
 
+	/* Trim to the length declared in the header, as the IPv4 path does */
+	if (len < IP6_HDR_SIZE + ntohs(ip6->payload_len))
+		return -EINVAL;
+	len = IP6_HDR_SIZE + ntohs(ip6->payload_len);
+
 	switch (ip6->nexthdr) {
 	case PROT_ICMPV6:
 		icmp = (struct icmp6hdr *)(((uchar *)ip6) + IP6_HDR_SIZE);
@@ -433,6 +438,10 @@ int net_ip6_handler(struct ethernet_hdr *et, struct ip6_hdr *ip6, int len)
 		if (csum != udp->udp_xsum)
 			return -EINVAL;
 
+		if (ntohs(udp->udp_len) < UDP_HDR_SIZE ||
+		    ntohs(udp->udp_len) > len - IP6_HDR_SIZE)
+			return -EINVAL;
+
 		/* IP header OK. Pass the packet to the current handler. */
 		net_get_udp_handler()((uchar *)ip6 + IP6_HDR_SIZE +
 					UDP_HDR_SIZE,

---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20260807-net6-len-validation-cd71efd96a7f

Best regards,
--  
Esteban Alba <estebancalba@gmail.com>


