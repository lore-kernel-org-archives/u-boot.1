Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F59CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 19:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A596A8319C;
	Mon, 29 Sep 2025 21:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="bsmwlUlz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8102832AD; Mon, 29 Sep 2025 21:21:56 +0200 (CEST)
Received: from mace.gateworks.com (mace.gateworks.com [174.136.5.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CC7B82A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 21:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=gateworks.com; s=gwtrack; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T59WYALRxZMEOhaWpr5T08hzGvo6aGrBL+28J/62QIg=; b=bsmwlUlz5dKX+iOZk6NJAFnLPJ
 gfl+ge0ym11KrxpB70K8bY6G3ROwinexAtC0zLnYaP9nr6m9JZR1nLLN4BEjLNA351MZkw73ZBRHr
 XpEtAgboF/fbB9twZsurItlZjg2P1+nwpsFzPYJK/wIA5+frHTdIGbWS6aPO6jqBKv3M/lW7WTgUC
 3nTV2kwhBZDA4z6Pop10ICmzbRkb9gk2MAHbw2KSXkhLNg+qQKrfelr8EzBoX/2nr7Tbb6UTcYyWD
 XNTAuv26oPeZp2TusRsx8bnyyrTXTFfbDvcqlKkLF55ExLXI7LyknTIiEu+GIwmPLeGCl2oDHHJbk
 KfJklm4A==;
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=chewbacca.pdc.gateworks.com)
 by mace.gateworks.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1v3JRW-00ARBW-Sf;
 Mon, 29 Sep 2025 19:21:51 +0000
Received: by chewbacca.pdc.gateworks.com (Postfix, from userid 1154)
 id 9B66D3083326; Mon, 29 Sep 2025 12:21:50 -0700 (PDT)
From: Tim Harvey <tharvey@gateworks.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] net: lwip: ensure alignment of packet buffers
Date: Mon, 29 Sep 2025 12:21:49 -0700
Message-Id: <20250929192149.3735435-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.34.1
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

Network packet buffers should be aligned to PKTALIGN. Add a compiler
attribute to ensure this.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 net/lwip/net-lwip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 660ceb10cbe..aec05d55de6 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -30,7 +30,7 @@ void (*push_packet)(void *, int len) = 0;
 static int net_try_count;
 static int net_restarted;
 int net_restart_wrap;
-static uchar net_pkt_buf[(PKTBUFSRX) * PKTSIZE_ALIGN + PKTALIGN];
+static uchar net_pkt_buf[(PKTBUFSRX) * PKTSIZE_ALIGN + PKTALIGN] __attribute__((aligned(PKTALIGN)));
 uchar *net_rx_packets[PKTBUFSRX];
 uchar *net_rx_packet;
 const u8 net_bcast_ethaddr[6] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
-- 
2.34.1

