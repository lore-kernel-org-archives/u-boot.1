Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6084B606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mwTs+b5y;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=nVHl9mzK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1BDA38124D;
	Fri, 23 Oct 2026 10:51:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xcc91ubPRb5E; Fri, 23 Oct 2026 10:51:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 78F99811C0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792752663;
	b=g4PmVd+/E3cWphF+kJrqY3P059++pVT4HjujlC5gNLCnHNG8Efl2bV2etw7gp5e3+1e4
	 ybuIw3hMhLxodoX92odRU0XPVAp+S+FAAzZw5/pjPmMbKGM68SvZ/Ax6aLhAj/XRqztXC
	 Xkwlo8666k+V9yxdi06iVf2LImi/uzlV0Wy+s6UX9WQ5webASwtGnnck9NLTu3c+s66Uu
	 8v6+K8ivYe0C+Jpz2Hap/Ir5x3Y4STFjINpuOahbjSqI6EpeiUQpvvnBb+c6WA9tHxpg2
	 IKbu2M8jOLNnXCndiwBDdflVHmSKI6kT9DVY9GFR7TjpjTL7Yi9avYe2/kBamBLaBRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792752663;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sAvknLMZEpo5BakGlvWMMWPeTDLHR+xMBWPIpoRKFzs=;
	b=POeCCACN46bMkb1GpQka6/AcL9b77V+GqEYiNkQdcqXeWTdY2IIf3qy2oNtY8orp95cH
	 YgdMMuj41E/LfMLNhEVaeG/69tyw6suD/qPWlA26c50OlDw3XC2DkFzSIQAVdqa9XjQMG
	 HMjxUDmfwxF0SMIzhycrd8lh8iHHzMvcMeMIYGSaXEo9trXKTK4s5rhO/Gp/zB9sCnIbc
	 Pa+xEi+nIqm2JDALTZ9x3IdGQYyoJHMKx+1S3Mt6S3GsY5w2iH7Pc9wUXqHiGyrk1/6zv
	 w9x3pm6GAOjnp/51woUti7AD9iv87MB03lbJlQcbdTo8MtITxzaTJTzn9fwO7vwuQuQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792752663;
	bh=sAvknLMZEpo5BakGlvWMMWPeTDLHR+xMBWPIpoRKFzs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mwTs+b5y2Th2L2iRaVv9/Ljqo15YrR8G00cWIyyTdHQ/Nw7zux3ul/tm3Y8mFLWN1
	 tPGIWkqmUpTNyxvl0GVeMbsKEkOyzlnIiveOFpVzWWGvyFbzDiY1eBbjj6CKQoxexT
	 uqY1kLOqWMzstc+SOh7hHS3KkRGpwj72I34EtoCiwllh3+ulgDZC53s1jLskRbul20
	 R1pMZQXCWp3qdi5uA1tTNU5meFbtDiUg2gspHiWtypsHljMHYn+q0yE2Qis7DDqeIq
	 OnlThiH1CaasdzMCknYYuTq0Xoj5Fq0vDJk2WMrt9JkbVT3nj6Ak3Z5ViKi16/hrD8
	 PB8XgWu5sN+aQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78F99811C0;
	Fri, 23 Oct 2026 10:51:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EDEF449D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D39E460650
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:51:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e6B1Ui-PWgFV for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 10:51:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7767A60642
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.120
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792752661;
 b=OA6Qyom8+OL/YDDtLfwb0JzFKT7QtEnXchvOG7wS9ryegy8bdStvc06sjyvPD0zsl1w3
 VjfiDg7q+0k1SosJ4NVOMn6Kiu/Lyyx5Ee7yZFffCOCO/ou+C6xWWptBw2JBu4dokVhTC
 4dZeKhm15ooFgH5idDs38MLil4X6emiQzQgAg/csvRlMqNl3/MOXCFHoWjSjtaig+9jg0
 7kgX81uu/z31Prr3YxbjD2y52P15k57lieAlWHBHESLPuIdgblD+QQeM3D5GGOfBroFZH
 1tfxvxQCffbdLdjeKbfKl06kZvtxtZc2V/Afx9G22bjYfZ0IRDYj7u8le/qUjfYPP/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792752661;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=sAvknLMZEpo5BakGlvWMMWPeTDLHR+xMBWPIpoRKFzs=;
 b=psQmYYpGKb87NaCLfVeiiPP3eDWTly6NyAPWTaX6vW6l9ZOkX67hHswjX6j8vevP1UF1
 iD11xKoXjYDlgJSUiqSCLPHV2YLq1kUHjh+fs+PTkngNEVMZu/f0PlLanSDOOb6bG0KRM
 Lkx5966IstlxnCUAsMkWu2FEU3PNSSOvVY7z/nnddQSasRDBgqoktGc1Yek1IpxP8MPhf
 /fX99sv/dx0fJybM2FBJtXoMCFNXyb3pd6HpsDgsUgPUltPftIC2aYFh9fGae88SW1kS0
 H9CCWGBBxOwFUwdXkZslEYtqRQV7G/5Mkcsa2fyk8tAJlSSgZZsyZIGDYvu6No6VBQg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=nVHl9mzK; 
 arc=none smtp.remote-ip=185.125.188.120
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.120;
 helo=smtp-relay-canonical-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=nVHl9mzK
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7767A60642
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:50:59 +0000 (UTC)
Received: from LT03 (host-209-35-187-178.broadbandcancun.mx [209.35.187.178])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 75C853FB50; 
 Fri, 23 Oct 2026 10:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792752657;
 bh=sAvknLMZEpo5BakGlvWMMWPeTDLHR+xMBWPIpoRKFzs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=nVHl9mzKbJhSlufiW1ZJbyIRljzumU8/XeqzMxzt8CNPBQxQBl7bs045yt/BHVuRf
 Cec5JspEdP6bEd+AtWCBp1bT46fMRjyMPrsdoSgWHf+o1t4z6AZvZPpbNwB7CKpIJR
 16m68ONsIz/5h9sO6GT7UoL6kvJDsvH20lqoKoRAnBvtmtXjb73oi7XK7WS0QLwbdu
 sP2G/u0xf00ZyaSocesnu4341di4FJG7xlmZzTO614dJAr0VHnB0lmVbQH0zZ/lZ8A
 +6Ie623M4jPvcbrOj3TnwDhCtk7oy4iXHTCXdx4OO5/MBpy9+LLmjUXhV+OFUuPmzD
 Y+w6ksQy9oKPy+z5gRkEL2oJeyQWPWUDFjB1tblKptmfl6bO27bAqwae57Eb7UoJGY
 y4NR7dqSeHA8zOdoE/j3JobIs/ogNFqYmiY4uz6/0uRRZgklkS5iVRoquWtfwxjjet
 Y32MFBau+K/Weh60HVynkEu/RKV4+Mdr6ZmAcvk24lgORbW8mhvciUnuJbhooFzlRd
 Ylq+gyYqiyyLHqh/f21W1gWIQxPCgWDcrQSey2jvWSuVvr/nltD2BA8lDWlVEuMQ3l
 0t7NtfrCemUI+ZQc5OgfD4QLhljSNZUKiEhaOIgmn9ELumfgl6E2DxqXEjwTt24+Os
 GOLzM70IA11ipgUwoK9+aYbg=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] test: net: don't count ARP replies in DHCP test
Date: Fri, 23 Oct 2026 12:50:47 +0200
Message-ID: <20261023105047.272280-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The number of ARP replies received is not a measure for correct DHCP
handshake. Checking this number leads to false positives in the CI.

    ETH_PACKETS_BATCH_RECV - 2 == test->arp_replies:
    Expected 0x1e (30), got 0x1d (29)

Fixes: a15e24e2d0e2 ("test: net: cover lwIP DHCP autoload handoff")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/dm/lwip_dhcp.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/test/dm/lwip_dhcp.c b/test/dm/lwip_dhcp.c
index 9a61cc9bf04..c93579aea49 100644
--- a/test/dm/lwip_dhcp.c
+++ b/test/dm/lwip_dhcp.c
@@ -24,7 +24,6 @@ struct dhcp_handoff_test {
 	bool rx_burst;
 	unsigned int rx_packets;
 	int rx_error;
-	unsigned int arp_replies;
 	unsigned int tftp;
 	unsigned int nfs;
 	u32 boot_server;
@@ -110,13 +109,8 @@ static int dhcp_handoff_tx(struct udevice *dev, void *packet, unsigned int len)
 	u8 *data;
 
 	if (test->rx_burst && netif_dhcp_data(netif_default) &&
-	    ntohs(eth->et_protlen) == PROT_ARP) {
-		struct etharp_hdr *arp = (void *)(eth + 1);
-
-		if (ntohs(arp->opcode) == ARP_REPLY)
-			test->arp_replies++;
+	    ntohs(eth->et_protlen) == PROT_ARP)
 		return 0;
-	}
 	if (!sandbox_eth_arp_req_to_reply(dev, packet, len))
 		return 0;
 	if (len < ETHER_HDR_SIZE + IP_UDP_HDR_SIZE ||
@@ -240,7 +234,6 @@ static int dhcp_handoff_check(struct unit_test_state *uts,
 	ut_assertok(do_dhcp(NULL, 0, 1, argv));
 	ut_asserteq(0, test->rx_error);
 	ut_asserteq(ETH_PACKETS_BATCH_RECV, test->rx_packets);
-	ut_asserteq(ETH_PACKETS_BATCH_RECV - 2, test->arp_replies);
 	ut_asserteq_str("1.1.2.3", env_get("ipaddr"));
 	ut_asserteq(0, test->tftp);
 	ut_asserteq(0, test->nfs);
-- 
2.53.0

