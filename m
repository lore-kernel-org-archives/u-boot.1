Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0893606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GbbzLn6y;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=JI3HSbDM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87B1F60669;
	Sat, 21 Nov 2026 16:53:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7o7lSRiYG38o; Sat, 21 Nov 2026 16:53:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 58CB860642
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795279980;
	b=JgVJjAwz8NxwO/+ZLjjnh8cv4Nj/tJz8jpUwchs2qwWqscYq2ssYGhQyAsXI6PICu7qR
	 5iQ/41rSnowzkGoLe9Bj16vTVljw/bF2LGi5nIR91CYnh8qU/muxXF8PcB+3qV74Pl4cs
	 /jQngoLHThp3NyzggDWYGHLbmPsofK1utDgRa+gWOIuR1fuNLZL6yizEntgDOexQAnJxF
	 wdnA8S8A7nh42inpk5Pcj239sRnZho1QZJCuoDSLOIGX8Q9wZg9yVOw5MDTruD65h8bh3
	 OfU81QCYvVRmuZs6ZaijohyozgQypgz0JXtt79+iIBBvlZLfQK9/z/SMu5M2NAttzWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795279980;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3gENcRpmsSPLGTep1OGIcEqNYfzPF6elHRUc/btGh+E=;
	b=YZRdyLBR3hdDhk+aFJyMP4ODCBUYo/grQaF9EeJfvzJtF+CMOob+i+x3INynqVx8tAc0
	 nZhreGU2qX3rgPyL02ww0MOE81+sA0Wh5+MXtRYI6qg65HfBlH6cOwNn+UoshEVHZJqB9
	 /fmW0OJ5LFzniqK0Rr5UwaglP2xMIwohnOCjUnLPCgxs6u3tWPhehsL4F2LP3enmmutBX
	 g32FfbT4i9NP2Ve1xhEdiTyaHlEA0AQmwgcJGOrcerMn/098G5KlG305U51tgnjt3kiB1
	 CS5epPzfStdF52q6J8vE9hw9oGJ0ylNZnObJ0pCw8YAA5Fk2qftSLqHlpz6GHeYmFeg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795279980;
	bh=3gENcRpmsSPLGTep1OGIcEqNYfzPF6elHRUc/btGh+E=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GbbzLn6yo/08bu0HrLrMajNJLeI9R2i4gBWh6Ref5ye7bM8gfXcWwTPqm+PzNdaT7
	 iXNBH0AGWsFiDwYF1/DlNm94iIPDJVu8QELZd9Atv0VkFzJDv4gL1KOxEs2sJ+gLvk
	 W5/xlgeuw+H8UqnIR+vT5MSho8gUGBxqRN2Rzg1ZaCmgL4HOeXPrhVQmsJAxS+VRxt
	 DECpMPRTc5bQXjD9XzLx5cUBUZiYRQGXU70UAXPCC+aS4KySLa5QPMqk7iJ7bJKoy2
	 ESZ2FH6ERCmIlOVCHxlNffD3UtcsIswtdjKjgRrLSCYTEJYixlF0A1VoqN3zvkCj3H
	 J2cWuR6/uSsSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58CB860642;
	Sat, 21 Nov 2026 16:53:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FB8F15D
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 16:52:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 418DF80EBE
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 16:52:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h3H_uSjEAn80 for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 16:52:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 77F7380E73
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=JI3HSbDM
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 77F7380E73
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 16:52:55 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jWytq6krzzMll9;
 Sat, 21 Nov 2026 17:52:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1795279971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3gENcRpmsSPLGTep1OGIcEqNYfzPF6elHRUc/btGh+E=;
 b=JI3HSbDMMbhQXmHpB9Zc03h7EFhHM2v6nqK9KZqDc00r+jTqtszHkiqhIoEXMjLg3KddY/
 95Kz/yDAgOwUb0Aqz1BEmJoos+fDJ4T0iDJqbUZMTJQb9Xs/ScG0Aq1dzZTcuz8z4Kj6mo
 V3ehr5x9CdVaJ9swsfhlIhWVn8NQuPppxyS16Vwcnm8E6eX2RqPcQ8g9aojK5rOUPt/ogZ
 881s2VEmI8V9Hk10XKCFSUTQpTntXCWdqeUi/C2FkJmnoNDIhSj7MD6ULaMigydESyeJ+6
 ZhxNGowlgjry9OwqaK9Uh67cUwf9x1FU5g9xgYFCW+GB2BdhZbfVO9ueAnhpRw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: lwip: Fix net_lwip_tx typo in net_lwip_rx() function
 debug print
Date: Sat, 21 Nov 2026 17:52:41 +0100
Message-ID: <20261121165249.941705-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 58c7fabb166abfd7f2f
X-MBO-RS-META: o8m99dfj3zionkcdiwxsewpwcapfn7xm
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix "net_lwip_tx" typo in net_lwip_rx() function debug print.
While doing so, replace the hard-coded function name with __func__
in printf() and with RX: and TX: prefix in print_hex_dump() calls.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: James Hilliard <james.hilliard1@gmail.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 net/lwip/net-lwip.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 60fcf9b3225..bbd5a233e3e 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -83,8 +83,8 @@ static err_t net_lwip_tx(struct netif *netif, struct pbuf *p)
 	}
 
 	if (CONFIG_IS_ENABLED(LWIP_DEBUG_RXTX)) {
-		printf("net_lwip_tx: %u bytes, udev %s\n", plen, udev->name);
-		print_hex_dump("net_lwip_tx: ", 0, 16, 1, pp, plen, true);
+		printf("%s: %u bytes, udev %s\n", __func__, plen, udev->name);
+		print_hex_dump("TX: ", 0, 16, 1, pp, plen, true);
 	}
 
 	err = eth_get_ops(udev)->send(udev, pp, plen);
@@ -641,9 +641,9 @@ static int net_lwip_rx(struct udevice *udev, struct netif *netif)
 				pcap_post(packet, len, false);
 
 			if (CONFIG_IS_ENABLED(LWIP_DEBUG_RXTX)) {
-				printf("net_lwip_tx: %u bytes, udev %s \n", len,
+				printf("%s: %u bytes, udev %s \n", __func__, len,
 				       udev->name);
-				print_hex_dump("net_lwip_rx: ", 0, 16, 1,
+				print_hex_dump("RX: ", 0, 16, 1,
 					       packet, len, true);
 			}
 
-- 
2.53.0

