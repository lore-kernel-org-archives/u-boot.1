Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41426C25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 06:27:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E17788224;
	Mon, 13 May 2024 08:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="SPZ2utGz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDB0C88224; Mon, 13 May 2024 08:27:24 +0200 (CEST)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 476EC83334
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 08:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20240513062721a1cd6ace686f689914 for <u-boot@lists.denx.de>;
 Mon, 13 May 2024 08:27:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=LA6knZiuB8yaD5COiK0PBRL36GSTLSI4nKw9Dsr/kDc=;
 b=SPZ2utGzQF6f9avbx19ljgyHhKwR1esiTucx8Oe1RFsIHxza7Mz6SuuLg1QxQyc6XcYFqt
 1fHAvCVaeHZS7+TL1BrddZFSHiGr+2wc4K/v6BhnSoAUWuHSMvTEM0G9W0PaQgDA4XX4WWHP
 p+Yt8rdJdPSdC3N878Tqlh83DuhjQ=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Suman Anna <s-anna@ti.com>, Keerthy <j-keerthy@ti.com>
Subject: [PATCH] net: tftp: don't call stop callback from UDP handler
Date: Mon, 13 May 2024 08:26:35 +0200
Message-ID: <20240513062643.3589070-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Contrary to doc/develop/driver-model/ethernet.rst contract, eth_ops
.free_pkt can be called after .stop, there are several error paths in TFTP,
for instance:

eth_halt() <= tftp_handler() <= net_process_received_packet() <= eth_rx()
...
am65_cpsw_free_pkt() <= eth_rx()

Which results in (deliberately "tftpboot"ing non-existing file):

TFTP error: 'File not found' (1)
Not retrying...
am65_cpsw_nuss_port ethernet@8000000port@1: RX dma free_pkt failed -22

Avoid the DMA error message (and follow the documentation) by deferring
eth_halt() until net_loop() calls net_start_again() and only do
eth_halt_state_only() instead.

Fixes: aafda38fb266 ("Add error codes/handling for TFTP-server")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 net/eth-uclass.c | 2 ++
 net/tftp.c       | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

This isn't a v2, but a completely different approach to
https://patchwork.ozlabs.org/project/uboot/patch/20240508183605.955341-1-alexander.sverdlin@siemens.com/

diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index 193218a328b..9863db59d68 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -450,6 +450,8 @@ int eth_rx(void)
 			eth_get_ops(current)->free_pkt(current, packet, ret);
 		if (ret <= 0)
 			break;
+		if (!eth_is_active(current))
+			break;
 	}
 	if (ret == -EAGAIN)
 		ret = 0;
diff --git a/net/tftp.c b/net/tftp.c
index 2e335413492..081014a1fde 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -649,7 +649,7 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 		net_set_timeout_handler(timeout_ms, tftp_timeout_handler);
 
 		if (store_block(tftp_cur_block, pkt + 2, len)) {
-			eth_halt();
+			eth_halt_state_only();
 			net_set_state(NETLOOP_FAIL);
 			break;
 		}
@@ -678,7 +678,7 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 		case TFTP_ERR_FILE_NOT_FOUND:
 		case TFTP_ERR_ACCESS_DENIED:
 			puts("Not retrying...\n");
-			eth_halt();
+			eth_halt_state_only();
 			net_set_state(NETLOOP_FAIL);
 			break;
 		case TFTP_ERR_UNDEFINED:
-- 
2.44.0

