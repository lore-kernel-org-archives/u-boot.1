Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A45E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 09:39:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E61518036B;
	Tue,  7 Jan 2025 10:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xHDWUPMw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECDDA805E9; Tue,  7 Jan 2025 10:38:58 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADCDF801E8
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 10:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5079cixE2625423
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jan 2025 03:38:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736242724;
 bh=dJ/4mvwYUQp0a4Dg3yELT/5qALRd24pjEO+50CAsbWk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=xHDWUPMwftSrZt/LJ8LjobiEbzwpUosRfbc5f9jdyw5TRW1Fnix4wODO4OqwE1L+e
 lPiEiOkfBneSLkB4AEOr/+cRGRHVLxdhfLocbYscj37BNpxQ7SOWB1GksKRxC9D1Vb
 KVFuIdFtM4kAFEnEmW1filLcwZxzdwnoPszwXPsI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5079cihb002137
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 7 Jan 2025 03:38:44 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Jan 2025 03:38:43 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Jan 2025 03:38:43 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5079cgwT057385;
 Tue, 7 Jan 2025 03:38:43 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: AKASHI Takahiro <akashi.tkhro@gmail.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Nishanth Menon <nm@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Hari Nagalla <hnagalla@ti.com>, Jonathan Humphreys
 <j-humphreys@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Simon Glass
 <sjg@chromium.org>, Jayesh Choudhary <j-choudhary@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew Davis
 <afd@ti.com>, Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <srk@ti.com>, <s-vadapalli@ti.com>, <danishanwar@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 01/13] net: tftp: Increase TFTP pkt string length to include
 null character
Date: Tue, 7 Jan 2025 15:08:28 +0530
Message-ID: <20250107093840.2211381-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107093840.2211381-1-c-vankar@ti.com>
References: <20250107093840.2211381-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

'sprintf()' function defined in 'tiny-printf.c' is returning length of the
string excluding null character. Fix this by increasing TFTP pkt length by
1 to avoid TFTP error of request being not-null terminated while
requesting length of packet.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---
 net/tftp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/tftp.c b/net/tftp.c
index 704b20b4ff8..db1d4aacb0e 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -347,11 +347,11 @@ static void tftp_send(void)
 		pkt += strlen((char *)pkt) + 1;
 #ifdef CONFIG_TFTP_TSIZE
 		pkt += sprintf((char *)pkt, "tsize%c%u%c",
-				0, net_boot_file_size, 0);
+				0, net_boot_file_size, 0) + 1;
 #endif
 		/* try for more effic. blk size */
 		pkt += sprintf((char *)pkt, "blksize%c%d%c",
-				0, tftp_block_size_option, 0);
+				0, tftp_block_size_option, 0) + 1;
 
 		/* try for more effic. window size.
 		 * Implemented only for tftp get.
@@ -359,7 +359,7 @@ static void tftp_send(void)
 		 */
 		if (tftp_state == STATE_SEND_RRQ && tftp_window_size_option > 1)
 			pkt += sprintf((char *)pkt, "windowsize%c%d%c",
-					0, tftp_window_size_option, 0);
+					0, tftp_window_size_option, 0) + 1;
 		len = pkt - xp;
 		break;
 
-- 
2.34.1

