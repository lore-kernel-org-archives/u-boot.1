Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EFFC4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 18:51:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE09988267;
	Mon, 29 Apr 2024 20:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AtcZGgbq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0490088359; Mon, 29 Apr 2024 20:51:23 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id CA67F87FC6
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 20:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 051D8210FBA3;
 Mon, 29 Apr 2024 11:51:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 051D8210FBA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1714416680;
 bh=5vOmtaMwFb5/M3DlGEE1/Av34TBP1JRM8DVQ1/Xpcm4=;
 h=From:To:Cc:Subject:Date:From;
 b=AtcZGgbq5K/BaUJ5ZW0i0DQGxszWhNLaKwNfrIFEoGdN97a2n8AVo897/kCgARfDU
 D0cc9wbKlfuRzlzK4trfvZR+XeD1IzytXQpWavizozxuOo60jmUP33n3ltZOutrFnT
 KxRjlAlpVinTWxRD7g3qkpaVEaSJ2hxNPNv7xgLI=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com,
 v.v.mitrofanov@yadro.com, saproj@gmail.com,
 Sean Edmond <seanedmond@microsoft.com>
Subject: [PATCH] Fix neighbor discovery ethernet address saving
Date: Mon, 29 Apr 2024 11:51:16 -0700
Message-ID: <20240429185116.2287092-1-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sean Edmond <seanedmond@microsoft.com>

When a successful neighbor advertisement is received, the ethernet
address should be saved for later use to avoid having to redo the
neighbor discovery process.

For example, with TFTP the address should get saved into
"net_server_ethaddr".  This is being done correctly with ARP for IPv4,
but not for neighbor discovery with IPv6.

Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
---
 net/ndisc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ndisc.c b/net/ndisc.c
index d1cec0601c8..505515f2d95 100644
--- a/net/ndisc.c
+++ b/net/ndisc.c
@@ -461,8 +461,8 @@ int ndisc_receive(struct ethernet_hdr *et, struct ip6_hdr *ip6, int len)
 			ndisc_extract_enetaddr(ndisc, neigh_eth_addr);
 
 			/* save address for later use */
-			if (!net_nd_packet_mac)
-				net_nd_packet_mac = neigh_eth_addr;
+			if (net_nd_packet_mac)
+				memcpy(net_nd_packet_mac, neigh_eth_addr, 6);
 
 			/* modify header, and transmit it */
 			memcpy(((struct ethernet_hdr *)net_nd_tx_packet)->et_dest,
-- 
2.42.0

